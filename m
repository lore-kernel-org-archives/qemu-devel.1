Received: from eggs.gnu.org ([2001:4830:134:3::10]:42886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fk85K-0003e1-6Y
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 09:19:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fk85F-0000fB-BP
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 09:19:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52508 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fk85F-0000dj-6N
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 09:19:33 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <5B5EC604.4020301@intel.com> (Wei Wang's message of "Mon, 30 Jul
	2018 16:02:12 +0800")
References: <1532934837-5966-1-git-send-email-wei.w.wang@intel.com>
	<1532934837-5966-2-git-send-email-wei.w.wang@intel.com>
	<5B5EC604.4020301@intel.com>
Reply-To: quintela@redhat.com
Date: Mon, 30 Jul 2018 15:19:30 +0200
Message-ID: <87zhy8kgil.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/2] bitmap.h: add comments to
 BITMAP_LAST_WORD_MASK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, dgilbert@redhat.com, mst@redhat.com

Wei Wang <wei.w.wang@intel.com> wrote:
> On 07/30/2018 03:13 PM, Wei Wang wrote:
>> This macro was ported from Linux and we've reached an aggreement there
>> that the corner case "nbits = 0" is not applicable to this macro, because
>> when "nbits = 0", which means no bits to mask, this macro is expected to
>> return 0, instead of 0xffffffff. This patch simply adds a comment above
>> the macro as a note to users about the corner case.
>>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> CC: Juan Quintela <quintela@redhat.com>
>> CC: Peter Xu <peterx@redhat.com>
>> ---
>>   include/qemu/bitmap.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/include/qemu/bitmap.h b/include/qemu/bitmap.h
>> index 509eedd..f53c640 100644
>> --- a/include/qemu/bitmap.h
>> +++ b/include/qemu/bitmap.h
>> @@ -60,6 +60,7 @@
>>    */
>>     #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) &
>> (BITS_PER_LONG - 1)))
>> +/* "nbits = 0" is not applicable to this macro. Callers should avoid that. */
>>   #define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
>>     #define DECLARE_BITMAP(name,bits)                  \
>
> A better fix would be to directly change the macro to:  nbits ? (~0UL
>>> (-(nbits) & (BITS_PER_LONG - 1))) : 0,
> so that we don't need to fix other callers like bitmap_full,
> bitmap_intersects.
>
> So just post this out for a discussion whether it's preferred to just
> adding note comments as we did for linux or fixing the macro directly.
>
> Best,
> Wei

On one hand:
a - we have copied it form linux, we don't want to diverge
On the other hand:
b - it is much easier to use if we change the macro

So, it is a tought one.

I slightly preffer b), but will not object to a either.  As you are the
one doing the patch, your choice.

Later, Juan.
