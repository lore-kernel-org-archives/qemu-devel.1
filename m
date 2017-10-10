Received: from eggs.gnu.org ([2001:4830:134:3::10]:56965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1e208X-0006jD-F2
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 15:24:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1e208W-0002Zb-Cr
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 15:24:17 -0400
References: <20171004020048.26379-1-eblake@redhat.com>
	<20171004020048.26379-2-eblake@redhat.com>
	<20171010135940.GJ4177@dhcp-200-186.str.redhat.com>
	<67e98ca7-e861-a646-b701-b8f7453f2951@redhat.com>
	<46e7ca23-fb38-7620-90fb-04982e5b9ad0@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <06af49fb-6e94-d8c0-3701-7579e55c92a5@redhat.com>
Date: Tue, 10 Oct 2017 15:24:02 -0400
MIME-Version: 1.0
In-Reply-To: <46e7ca23-fb38-7620-90fb-04982e5b9ad0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 01/23] block: Allow NULL file for
 bdrv_get_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: famz@redhat.com, qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>



On 10/10/2017 03:00 PM, Eric Blake wrote:
> On 10/10/2017 09:43 AM, Eric Blake wrote:
> 
>>>> ---
>>>> v5: use second label for cleaner exit logic [John], use local_pnum
>>
>>>> @@ -1811,16 +1811,19 @@ static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,
>>>>      int64_t total_sectors;
>>>>      int64_t n;
>>>>      int64_t ret, ret2;
>>>> +    BlockDriverState *local_file = NULL;
>>>> +    int local_pnum = 0;
>>>
>>> I don't quite see what the point of local_pnum is if we assert anyway
>>> that the real pnum is non-NULL.
>>
>> I did it in parallel with fallout from John's review on v4:
>> https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg06958.html
>>
>> but since it wasn't specifically asked for, and is now getting
>> questions, I'm fine with not having it in v6.
> 
> Okay, I re-read v4, and here's the comment (on 21/23) that led to my
> experiment in v5 patch 1 with local_pnum:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg00293.html
> 
> and I did argue:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg00311.html
> 

Well, Kevin's the boss :D

>>> Is it asking for trouble to be updating pnum here before we undo our
>>> alignment corrections? For readability reasons and preventing an
>>> accidental context-based oopsy-daisy.
>>
>> As in, write the code to make all calculations in a temporary, and then
>> assign *pnum only at the end?  I suppose I can tweak the code along
>> those lines, but I'm not sure it will make the end result any more legible.
> 
