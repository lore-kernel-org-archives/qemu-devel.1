Received: from eggs.gnu.org ([2001:4830:134:3::10]:52530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1f3KR4-0000XH-3c
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 07:49:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1f3KQz-0001QE-3U
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 07:49:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49296 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1f3KQy-0001Q0-Ug
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 07:49:05 -0400
References: <3c36db1dc0702763ebb7966cc27428ed67d43804.1522751624.git.mprivozn@redhat.com>
	<CAJ+F1CKzkhdXHyZ0wRQ7Hjx8cVLVhDCgoGP9pVgte26+NMQmbA@mail.gmail.com>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <7c6e36a4-f03f-1042-dc34-cfaf48d7518a@redhat.com>
Date: Tue, 3 Apr 2018 13:48:53 +0200
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CKzkhdXHyZ0wRQ7Hjx8cVLVhDCgoGP9pVgte26+NMQmbA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] ccid-card: include libcacard.h only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On 04/03/2018 01:38 PM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Tue, Apr 3, 2018 at 12:34 PM, Michal Privoznik <mprivozn@redhat.com>=
 wrote:
>> When trying to build with latest libcacard-2.5.1, I hit the
>> following error:
>>
>> In file included from hw/usb/ccid-card-passthru.c:12:0:
>> /usr/include/cacard/vscard_common.h:26:2: error: #warning "Only <libca=
card.h> can be included directly" [-Werror=3Dcpp]
>>  #warning "Only <libcacard.h> can be included directly"
>>
>> While it was fixed in libcacard upstream (so that individual
>> files can be included directly), it doesn't make much sense.
>> Let's switch to including the main libcacard.h and also require
>> at least libcacard-2.5.1 which introduced it. It's available
>> since late 2015.
>>
>> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
>> ---
>>
>> diff to v1:
>> - Introduce configure change to require newer libcacard version
>>
>>  configure                   | 2 +-
>>  hw/usb/ccid-card-emulated.c | 5 +----
>>  hw/usb/ccid-card-passthru.c | 2 +-
>>  3 files changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/configure b/configure
>> index 4d0e92c96c..0edec24fff 100755
>> --- a/configure
>> +++ b/configure
>> @@ -4440,7 +4440,7 @@ fi
>>
>>  # check for smartcard support
>>  if test "$smartcard" !=3D "no"; then
>> -    if $pkg_config libcacard; then
>> +    if $pkg_config --atleast-version=3D2.5.1 libcacard; then
>>          libcacard_cflags=3D$($pkg_config --cflags libcacard)
>>          libcacard_libs=3D$($pkg_config --libs libcacard)
>>          smartcard=3D"yes"
>> diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
>> index ea42e4681d..7b538ae6da 100644
>> --- a/hw/usb/ccid-card-emulated.c
>> +++ b/hw/usb/ccid-card-emulated.c
>> @@ -27,10 +27,7 @@
>>   */
>>
>>  #include "qemu/osdep.h"
>> -#include <eventt.h>
>> -#include <vevent.h>
>> -#include <vreader.h>
>> -#include <vcard_emul.h>
>> +#include <cacard/libcacard.h>
>=20
> You should be able to #include <libcacard.h> only.

Yes, you're right. Do you want me to resend or will you handle this when
merging the patch?


Thanks,
Michal
