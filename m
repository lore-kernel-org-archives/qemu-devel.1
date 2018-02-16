Received: from eggs.gnu.org ([2001:4830:134:3::10]:41725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Antonios.Motakis@huawei.com>) id 1emdEh-0003WJ-Ha
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 05:27:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Antonios.Motakis@huawei.com>) id 1emdEd-0003IL-3X
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 05:27:23 -0500
Received: from lhrrgout.huawei.com ([194.213.3.17]:44266 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Antonios.Motakis@huawei.com>)
	id 1emdEc-0003H6-TZ
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 05:27:19 -0500
References: <20180208180019.13683-1-antonios.motakis@huawei.com>
	<20180208180019.13683-5-antonios.motakis@huawei.com>
	<20180209162233.1d191ace@bahia.lan> <20180209214706.GA3684@flamenco>
From: Antonios Motakis <antonios.motakis@huawei.com>
Message-ID: <f8702023-f2ea-4b29-50d9-a9918ed71357@huawei.com>
Date: Fri, 16 Feb 2018 11:28:24 +0100
MIME-Version: 1.0
In-Reply-To: <20180209214706.GA3684@flamenco>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 4/4] 9pfs: stat_to_qid: implement slow path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, veaceslav.falico@huawei.com, Eduard.Shishkin@huawei.com, andy.wangguoli@huawei.com, Jani.Kokkonen@huawei.com, berrange@redhat.com



On 02/09/2018 10:47 PM, Emilio G. Cota wrote:
> On Fri, Feb 09, 2018 at 16:22:33 +0100, Greg Kurz wrote:
>> On Thu, 8 Feb 2018 19:00:19 +0100
>> <antonios.motakis@huawei.com> wrote:
> (snip)
>>>   /* stat_to_qid needs to map inode number (64 bits) and device id (32 bits)
>>>    * to a unique QID path (64 bits). To avoid having to map and keep track
>>>    * of up to 2^64 objects, we map only the 16 highest bits of the inode plus
>>> @@ -646,6 +695,10 @@ static int stat_to_qid(V9fsPDU *pdu, const struct stat *stbuf, V9fsQID *qidp)
>>>   
>>>       /* map inode+device to qid path (fast path) */
>>>       err = qid_path_prefixmap(pdu, stbuf, &qidp->path);
>>> +    if (err == -ENFILE) {
>>> +        /* fast path didn't work, fal back to full map */
>>> +        err = qid_path_fullmap(pdu, stbuf, &qidp->path);
>> Hmm... if we have already generate QIDs with fast path, how
>> can we be sure we won't collide with the ones from the full
>> map ?
>>
>> IIRC, Emilio had suggested to use bit 63 to distinguish between
>> fast and slow path.
> Yep. Antonios: did you consider that approach? For reference:
>    https://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg05084.html
>
> That would make the fast path faster by just using bit masks, which I
> think it's a superior approach if indeed the assumption about top bits
> being zero in most cases is accurate.
>
> 		Emilio

The fast path reserves prefix 0x0000 to detect overflows, and so will 
allocate prefixes 0x0001 to 0xffff only.
So if the fast path fails, we still have the whole space of 64 bit 
values that start with 0x0000, and 48 bits of play
room. And this is the space the slow path is allocating from. So they 
will never allocate a colliding path,
prefix 0x0000 distinguishes the slow path.

By reserving one prefix instead of one bit, we keep the bit-space that 
we can work with larger.
We can track almost twice as many QID paths.

I did consider the approach proposed originally using bitmasks, however 
I think this implementation has the advantage:
(1) The fast path is just being checked first without any other pre-checks,
which means the common use case is assumed to be true / is optimized.
We slow down the slow path because we have to check the fast path first,
but personally I don't mind slowing down the slow path a bit.
(2) It is a bit more flexible with the assumptions about the top bits. 
Think about
nested virtualization with nested 9p for example; the inner QEMU 
instance won't have
the luxury of working with inodes with zero top bits. However, the 
combination of
prefixes that it will run into will still be discreet and non-random. 
The proposed approach
will still allow the fast path to work fully for all files.

I think it is plausible that there are other cases with non-zero, but 
also non-randomly distributed
top bits in the inode, so I opted to give the fast path another 
advantage at the expense of the slow path.

I can change it, but personally I have accepted the slow path as a much 
more inferior fallback,
that only 0,001% of users should ever see. Fast path FTW.

Thanks for your feedback!
Tony
