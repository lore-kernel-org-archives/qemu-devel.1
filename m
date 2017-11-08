Received: from eggs.gnu.org ([2001:4830:134:3::10]:50631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eCNq9-0007Bh-U8
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 05:44:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eCNq8-0002W0-JX
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 05:44:13 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20171107172638.29942-1-kwolf@redhat.com>
	<20171107173920.GK3213@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <357d61df-9bad-dc5a-1878-2fce4b2a93cc@redhat.com>
Date: Wed, 8 Nov 2017 11:44:01 +0100
MIME-Version: 1.0
In-Reply-To: <20171107173920.GK3213@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] block: Deprecate bdrv_set_read_only() and
 users
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: mreitz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com

On 07/11/2017 18:39, Daniel P. Berrange wrote:
> On Tue, Nov 07, 2017 at 06:26:38PM +0100, Kevin Wolf wrote:
>> bdrv_set_read_only() is used by some block drivers to override the
>> read-only option given by the user. This is not how read-only images
>> generally work in QEMU: Instead of second guessing what the user really
>> meant (which currently includes making an image read-only even if the
>> user didn't only use the default, but explicitly said read-only=off), we
>> should error out if we can't provide what the user requested.
>>
>> This adds deprecation warnings to all callers of bdrv_set_read_only() so
>> that the behaviour can be corrected after the usual deprecation period.
> 
> All deprecations should be listed in "Deprecated features" appendix
> in qemu-doc.texi. This probably fits in the 'system emulator command
> line arguments' section, even though its talking about the need for
> the user to add something extra, rather than deleting something they
> currently use.

I am not sure this counts as deprecation, but it should go in the
release notes as "future incompatible changes", and that section
probably should go in qemu-doc.texi itself.

Paolo

> 
>>
>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> ---
>>  block.c       |  5 +++++
>>  block/bochs.c | 13 ++++++++++---
>>  block/cloop.c | 13 ++++++++++---
>>  block/dmg.c   | 12 +++++++++---
>>  block/rbd.c   | 14 ++++++++++----
>>  block/vvfat.c |  6 +++++-
>>  6 files changed, 49 insertions(+), 14 deletions(-)
>>
>> diff --git a/block.c b/block.c
>> index f6415547fe..0ed0c27140 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -261,6 +261,11 @@ int bdrv_can_set_read_only(BlockDriverState *bs, bool read_only,
>>      return 0;
>>  }
>>  
>> +/* TODO Remove (deprecated since 2.11)
>> + * Block drivers are not supposed to automatically change bs->read_only.
>> + * Instead, they should just check whether they can provide what the user
>> + * explicitly requested and error out if read-write is requested, but they can
>> + * only provide read-only access. */
>>  int bdrv_set_read_only(BlockDriverState *bs, bool read_only, Error **errp)
>>  {
>>      int ret = 0;
>> diff --git a/block/bochs.c b/block/bochs.c
>> index a759b6eff0..50c630047b 100644
>> --- a/block/bochs.c
>> +++ b/block/bochs.c
>> @@ -28,6 +28,7 @@
>>  #include "block/block_int.h"
>>  #include "qemu/module.h"
>>  #include "qemu/bswap.h"
>> +#include "qemu/error-report.h"
>>  
>>  /**************************************************************/
>>  
>> @@ -110,9 +111,15 @@ static int bochs_open(BlockDriverState *bs, QDict *options, int flags,
>>          return -EINVAL;
>>      }
>>  
>> -    ret = bdrv_set_read_only(bs, true, errp); /* no write support yet */
>> -    if (ret < 0) {
>> -        return ret;
>> +    if (!bdrv_is_read_only(bs)) {
>> +        error_report("Opening bochs images without an explicit read-only=on "
>> +                     "option is deprecated. Future versions will refuse to "
>> +                     "open the image instead of automatically marking the "
>> +                     "image read-only.");
>> +        ret = bdrv_set_read_only(bs, true, errp); /* no write support yet */
>> +        if (ret < 0) {
>> +            return ret;
>> +        }
>>      }
>>  
>>      ret = bdrv_pread(bs->file, 0, &bochs, sizeof(bochs));
>> diff --git a/block/cloop.c b/block/cloop.c
>> index d6597fcf78..2be68987bd 100644
>> --- a/block/cloop.c
>> +++ b/block/cloop.c
>> @@ -23,6 +23,7 @@
>>   */
>>  #include "qemu/osdep.h"
>>  #include "qapi/error.h"
>> +#include "qemu/error-report.h"
>>  #include "qemu-common.h"
>>  #include "block/block_int.h"
>>  #include "qemu/module.h"
>> @@ -72,9 +73,15 @@ static int cloop_open(BlockDriverState *bs, QDict *options, int flags,
>>          return -EINVAL;
>>      }
>>  
>> -    ret = bdrv_set_read_only(bs, true, errp);
>> -    if (ret < 0) {
>> -        return ret;
>> +    if (!bdrv_is_read_only(bs)) {
>> +        error_report("Opening cloop images without an explicit read-only=on "
>> +                     "option is deprecated. Future versions will refuse to "
>> +                     "open the image instead of automatically marking the "
>> +                     "image read-only.");
>> +        ret = bdrv_set_read_only(bs, true, errp);
>> +        if (ret < 0) {
>> +            return ret;
>> +        }
>>      }
>>  
>>      /* read header */
>> diff --git a/block/dmg.c b/block/dmg.c
>> index 6c0711f563..c9b3c519c4 100644
>> --- a/block/dmg.c
>> +++ b/block/dmg.c
>> @@ -419,9 +419,15 @@ static int dmg_open(BlockDriverState *bs, QDict *options, int flags,
>>          return -EINVAL;
>>      }
>>  
>> -    ret = bdrv_set_read_only(bs, true, errp);
>> -    if (ret < 0) {
>> -        return ret;
>> +    if (!bdrv_is_read_only(bs)) {
>> +        error_report("Opening dmg images without an explicit read-only=on "
>> +                     "option is deprecated. Future versions will refuse to "
>> +                     "open the image instead of automatically marking the "
>> +                     "image read-only.");
>> +        ret = bdrv_set_read_only(bs, true, errp);
>> +        if (ret < 0) {
>> +            return ret;
>> +        }
>>      }
>>  
>>      block_module_load_one("dmg-bz2");
>> diff --git a/block/rbd.c b/block/rbd.c
>> index 144f350e1f..a76a5e8755 100644
>> --- a/block/rbd.c
>> +++ b/block/rbd.c
>> @@ -665,10 +665,16 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
>>      /* If we are using an rbd snapshot, we must be r/o, otherwise
>>       * leave as-is */
>>      if (s->snap != NULL) {
>> -        r = bdrv_set_read_only(bs, true, &local_err);
>> -        if (r < 0) {
>> -            error_propagate(errp, local_err);
>> -            goto failed_open;
>> +        if (!bdrv_is_read_only(bs)) {
>> +            error_report("Opening rbd snapshots without an explicit "
>> +                         "read-only=on option is deprecated. Future versions "
>> +                         "will refuse to open the image instead of "
>> +                         "automatically marking the image read-only.");
>> +            r = bdrv_set_read_only(bs, true, &local_err);
>> +            if (r < 0) {
>> +                error_propagate(errp, local_err);
>> +                goto failed_open;
>> +            }
>>          }
>>      }
>>  
>> diff --git a/block/vvfat.c b/block/vvfat.c
>> index a0f2335894..0841cc42fc 100644
>> --- a/block/vvfat.c
>> +++ b/block/vvfat.c
>> @@ -1259,7 +1259,11 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
>>                         "Unable to set VVFAT to 'rw' when drive is read-only");
>>              goto fail;
>>          }
>> -    } else  {
>> +    } else  if (!bdrv_is_read_only(bs)) {
>> +        error_report("Opening non-rw vvfat images without an explicit "
>> +                     "read-only=on option is deprecated. Future versions "
>> +                     "will refuse to open the image instead of "
>> +                     "automatically marking the image read-only.");
>>          /* read only is the default for safety */
>>          ret = bdrv_set_read_only(bs, true, &local_err);
>>          if (ret < 0) {
>> -- 
>> 2.13.6
>>
>>
> 
> Regards,
> Daniel
> 
