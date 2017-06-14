Received: from eggs.gnu.org ([2001:4830:134:3::10]:33193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dL3x8-0004q8-Tu
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 04:47:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dL3x5-0000sr-PR
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 04:47:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dL3x5-0000ri-HQ
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 04:46:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 81BC061B92
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 08:46:58 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170614072706.GK11751@pxdev.xzpeter.org> (Peter Xu's message of
	"Wed, 14 Jun 2017 15:27:06 +0800")
References: <20170613095432.11623-1-quintela@redhat.com>
	<20170613095432.11623-2-quintela@redhat.com>
	<20170614072706.GK11751@pxdev.xzpeter.org>
Reply-To: quintela@redhat.com
Date: Wed, 14 Jun 2017 10:46:54 +0200
Message-ID: <87fuf3ez29.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/2] migration: Test for disabled features
 on reception
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com

Peter Xu <peterx@redhat.com> wrote:
> On Tue, Jun 13, 2017 at 11:54:31AM +0200, Juan Quintela wrote:
>> Right now, if we receive a compressed page while this features are
>> disabled, Bad Things (TM) can happen.  Just add a test for them.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> 
>> --
>> 
>> I had XBZRLE here also, but it don't need extra resources on
>> destination, only on source.  Additionally libvirt don't enable it on
>> destination, so don't put it here.
>> ---
>>  migration/ram.c | 16 +++++++++++++++-
>>  1 file changed, 15 insertions(+), 1 deletion(-)
>> 
>> diff --git a/migration/ram.c b/migration/ram.c
>> index f35d65a..f2d1bce 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -2477,7 +2477,7 @@ static int ram_load_postcopy(QEMUFile *f)
>>  
>>  static int ram_load(QEMUFile *f, void *opaque, int version_id)
>>  {
>> -    int flags = 0, ret = 0;
>> +    int flags = 0, ret = 0, invalid_flags;
>>      static uint64_t seq_iter;
>>      int len = 0;
>>      /*
>> @@ -2494,6 +2494,11 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>>          ret = -EINVAL;
>>      }
>>  
>> +    invalid_flags = 0;
>
> Nit: set zero when declare (just like flags, ret)?

Fixed.

As answered to dave, I use to do it that way.
But here it is more consistant to do it the other way.

>> +
>> +    if (!migrate_use_compression()) {
>> +        invalid_flags |= RAM_SAVE_FLAG_COMPRESS_PAGE;
>> +    }
>>      /* This RCU critical section can be very long running.
>>       * When RCU reclaims in the code start to become numerous,
>>       * it will be necessary to reduce the granularity of this
>> @@ -2514,6 +2519,15 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>>          flags = addr & ~TARGET_PAGE_MASK;
>>          addr &= TARGET_PAGE_MASK;
>>  
>> +        if (flags & invalid_flags) {
>> +            if (flags & invalid_flags  & RAM_SAVE_FLAG_COMPRESS_PAGE) {
>                                         ^
> Nit: one extra space -------------------+

Fixed.

>> +                error_report("Received an unexpected compressed page");
>> +            }
>> +
>> +            ret = -EINVAL;
>> +            break;
>> +        }
>> +
>>          if (flags & (RAM_SAVE_FLAG_ZERO | RAM_SAVE_FLAG_PAGE |
>>                       RAM_SAVE_FLAG_COMPRESS_PAGE | RAM_SAVE_FLAG_XBZRLE)) {
>>              RAMBlock *block = ram_block_from_stream(f, flags);
>> -- 
>> 2.9.4
>> 
>
> Besides the nits:
>
> Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks.
