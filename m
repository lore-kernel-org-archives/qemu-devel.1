Received: from eggs.gnu.org ([2001:4830:134:3::10]:53226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1d2pcn-0006ZJ-RZ
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 21:50:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1d2pcm-0007Ob-Ed
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 21:50:41 -0400
MIME-Version: 1.0
In-Reply-To: <0ffa427b-9f38-c673-ded9-b6f17742f5ca@redhat.com>
References: <1492957997-28587-1-git-send-email-lidongchen@tencent.com>
	<0ffa427b-9f38-c673-ded9-b6f17742f5ca@redhat.com>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Tue, 25 Apr 2017 09:50:38 +0800
Message-ID: <CAOGPPbced2TTLkU8VmaQVGmAatpckd+T=2+uue-=drOkVd4rLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 1/2] qemu-img: make sure contain the
 consecutive number of zero bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Lidong Chen <lidongchen@tencent.com>, qemu block <qemu-block@nongnu.org>, mreitz@redhat.com

On Mon, Apr 24, 2017 at 10:43 PM, Eric Blake <eblake@redhat.com> wrote:
> On 04/23/2017 09:33 AM, jemmy858585@gmail.com wrote:
>> From: Lidong Chen <lidongchen@tencent.com>
>>
>> is_allocated_sectors_min don't guarantee to contain the
>> consecutive number of zero bytes. this patch fixes this bug.
>
> This message was sent without an 'In-Reply-To' header pointing to a 0/2
> cover letter.  When sending a series, please always thread things to a
> cover letter; you may find 'git config format.coverletter auto' to be
> helpful.

Thanks for your kind advises.

>
>>
>> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
>> ---
>>  qemu-img.c | 11 ++++++-----
>>  1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/qemu-img.c b/qemu-img.c
>> index b220cf7..df6d165 100644
>> --- a/qemu-img.c
>> +++ b/qemu-img.c
>> @@ -1060,9 +1060,9 @@ static int is_allocated_sectors(const uint8_t *buf, int n, int *pnum)
>>  }
>>
>>  /*
>> - * Like is_allocated_sectors, but if the buffer starts with a used sector,
>> - * up to 'min' consecutive sectors containing zeros are ignored. This avoids
>> - * breaking up write requests for only small sparse areas.
>> + * Like is_allocated_sectors, but up to 'min' consecutive sectors
>> + * containing zeros are ignored. This avoids breaking up write requests
>> + * for only small sparse areas.
>>   */
>>  static int is_allocated_sectors_min(const uint8_t *buf, int n, int *pnum,
>>      int min)
>> @@ -1071,11 +1071,12 @@ static int is_allocated_sectors_min(const uint8_t *buf, int n, int *pnum,
>>      int num_checked, num_used;
>>
>>      if (n < min) {
>> -        min = n;
>> +        *pnum = n;
>> +        return 1;
>>      }
>>
>>      ret = is_allocated_sectors(buf, n, pnum);
>> -    if (!ret) {
>> +    if (!ret && *pnum >= min) {
>
> I seem to recall past attempts to try and patch this function, which
> were then turned down, although I haven't scrubbed the archives for a
> quick URL to point to. I'm worried that there are more subtleties here
> than what you realize.

Hi Eric:
Do you mean this URL?
https://lists.gnu.org/archive/html/qemu-block/2017-01/msg00306.html

But I think the code is not consistent with qemu-img --help.
qemu-img --help
  '-S' indicates the consecutive number of bytes (defaults to 4k) that must
       contain only zeros for qemu-img to create a sparse image during
       conversion. If the number of bytes is 0, the source will not be
scanned for
       unallocated or zero sectors, and the destination image will always be
       fully allocated.

another reason:
if s->has_zero_init is 1(the qcow2 image which have backing_file), the empty
space at the beginning of the buffer still need write and invoke
blk_co_pwrite_zeroes.
and split a single write operation into two just because there is small empty
space at the beginning.

Thanks.

>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>
