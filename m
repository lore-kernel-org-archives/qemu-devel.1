Received: from eggs.gnu.org ([2001:4830:134:3::10]:36978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Antonios.Motakis@huawei.com>) id 1eeO5H-0006tS-23
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 11:39:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Antonios.Motakis@huawei.com>) id 1eeO5D-00070a-5Q
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 11:39:35 -0500
Received: from lhrrgout.huawei.com ([194.213.3.17]:40746 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Antonios.Motakis@huawei.com>)
	id 1eeO5C-0006x9-Qc
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 11:39:31 -0500
References: <081955e1-84ec-4877-72d4-f4e8b46be350@huawei.com>
	<20180112171416.6048ae9e@bahia.lan>
	<e059ddfb-030d-98b6-8e6e-4938270bcebf@huawei.com>
	<20180119112733.4a9dd43f@bahia.lan> <20180120000506.GA3859@flamenco>
	<20180120220349.GA20376@flamenco> <20180124143031.7fc9c90f@bahia.lan>
From: Antonios Motakis <antonios.motakis@huawei.com>
Message-ID: <0286586c-7061-6f3f-20ae-b5241d12685b@huawei.com>
Date: Wed, 24 Jan 2018 17:40:57 +0100
MIME-Version: 1.0
In-Reply-To: <20180124143031.7fc9c90f@bahia.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [RFC] qid path collision issues in 9pfs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, "Emilio G. Cota" <cota@braap.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Veaceslav Falico <veaceslav.falico@huawei.com>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, Eduard Shishkin <Eduard.Shishkin@huawei.com>, "vfalico@gmail.com" <vfalico@gmail.com>, "Wangguoli (Andy)" <andy.wangguoli@huawei.com>, Jiangyiwen <jiangyiwen@huawei.com>, "zhangwei (CR)" <zhangwei555@huawei.com>



On 01/24/2018 02:30 PM, Greg Kurz wrote:
> Thanks Emilio for providing these valuable suggestions ! :)
>
> On Sat, 20 Jan 2018 17:03:49 -0500
> "Emilio G. Cota" <cota@braap.org> wrote:
>
>> On Fri, Jan 19, 2018 at 19:05:06 -0500, Emilio G. Cota wrote:
>>>>>> On Fri, 12 Jan 2018 19:32:10 +0800
>>>>>> Antonios Motakis <antonios.motakis@huawei.com> wrote:
>>>>> Since inodes are not completely random, and we usually have a handful of device IDs,
>>>>> we get a much smaller number of entries to track in the hash table.
>>>>>
>>>>> So what this would give:
>>>>> (1)	Would be faster and take less memory than mapping the full inode_nr,devi_id
>>>>> tuple to unique QID paths
>>>>> (2)	Guaranteed not to run out of bits when inode numbers stay below the lowest
>>>>> 54 bits and we have less than 1024 devices.
>>>>> (3)	When we get beyond this this limit, there is a chance we run out of bits to
>>>>> allocate new QID paths, but we can detect this and refuse to serve the offending
>>>>> files instead of allowing a collision.
>>>>>
>>>>> We could tweak the prefix size to match the scenarios that we consider more likely,
>>>>> but I think close to 10-16 bits sounds reasonable enough. What do you think?
>>> Assuming assumption (2) is very likely to be true, I'd suggest
>>> dropping the intermediate hash table altogether, and simply refuse
>>> to work with any files that do not meet (2).
>>>
>>> That said, the naive solution of having a large hash table with all entries
>>> in it might be worth a shot.
>> hmm but that would still take a lot of memory.
>>
>> Given assumption (2), a good compromise would be the following,
>> taking into account that the number of total gids is unlikely to
>> reach even close to 2**64:
>> - bit 63: 0/1 determines "fast" or "slow" encoding
>> - 62-0:
>>    - fast (trivial) encoding: when assumption (2) is met
>>      - 62-53: device id (it fits because of (2))
>>      - 52-0: inode (it fits because of (2))
> And as pointed by Eduard, we may have to take the mount id into account
> as well if we want to support the case where we have bind mounts in the
> exported directory... My understanding is that mount ids are incremental
> and reused when the associated fs gets unmounted: if we assume that the
> host doesn't have more than 1024 mounts, we would need 10 bits to encode
> it.
>
> The fast encoding could be something like:
>
> 62-53: mount id
> 52-43: device id
> 42-0: inode

I don't agree that we should take the mount id into account though.
The TL; DR: I think the issue about bind mounts is distinct from the QID 
path issue, and just happens to be worked around when we (falsely) 
advertise to the guest that 2 files are not the same (even though they 
are). Making unique 2 files that shouldn't be, will cause other issues.

The kernel's 9p client documentation states that with fscache enabled, 
there is no support for coherency when multiple users (i.e. guest and 
host) are reading and writing to the share. If this limitation is not 
taken into account, there are multiple issues with stale caches in the 
guest.

Disambiguating files using mount id might work around fscache 
limitations in this case, but will introduce a host of other bugs. For 
example:
(1) The user starts two containers sharing a directory (via host bind 
mounts) with data
(2) Container 1 writes something to a file in the data dir
(3) Container 2 reads from the file
(4) The guest kernel doesn't know the the file is one and the same, so 
it is twice in the cache. Container 2 might get stale data

The user, wrote the code running in containers 1 and 2, assuming they 
can share a file when running on the same system. For example, one 
container generating the configuration file for another. It doesn't 
matter if the user wrote the applications correctly, syncing data when 
needed. It only breaks because we lied to the guest 9p client, telling 
it that they are distinct files. 9p is supposed to support this.

This is why I think including the mount id in the QID path would be 
another bug, this time in the opposite direction.

In contrast the QID path issues:
(1) do not require touching files on the host, after the guest has 
already mounted the share, to trigger it.
(2) can be explained by the guest assuming that two or more distinct 
files are actually the same.

The bind mount issue:
(1) bind mounts have to be changed on the host after the guest has 
mounted the share. Already a no-no for fscache, and can be explained by 
stale caches in the guest.
(2) The guest is correctly identifying that they refer to the same file. 
There is no collision here.

>
>>    - slow path: assumption (2) isn't met. Then, assign incremental
>>      IDs in the [0,2**63-1] range and track them in a hash table.
>>
>> Choosing 10 or whatever else bits for the device id is of course TBD,
>> as Antonios you pointed out.
>>
> This is a best effort to have a fallback in QEMU. The right way to
> address the issue would really be to extend the protocol to have
> bigger qids (eg, 64 for inode, 32 for device and 32 for mount).

Does this mean we don't need the slow path for the fallback case? I have 
tested a glib hash table implementation of the "fast path", I will look 
into porting it to the QEMU hash table and will send it to this list.

Keep in mind, we still need a hash table for the device id, since it is 
32 bits, but we will try to reserve only 10-16 bits for it.

Cheers,
Tony
