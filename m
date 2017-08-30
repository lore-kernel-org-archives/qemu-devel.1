Received: from eggs.gnu.org ([2001:4830:134:3::10]:32795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dn02F-0001di-BS
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 06:15:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dn02D-0000Nc-Px
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 06:15:47 -0400
References: <20170828055631.GB3258@host-172-16-90-85.openstacklocal>
	<7327a956-aef3-a8da-13ff-53073039802f@redhat.com>
	<20170829025645.GA30307@host-172-16-90-85.openstacklocal>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <17126413-cb74-a633-0138-5bd4e5dab315@virtuozzo.com>
Date: Wed, 30 Aug 2017 13:15:33 +0300
MIME-Version: 1.0
In-Reply-To: <20170829025645.GA30307@host-172-16-90-85.openstacklocal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] reduce write bandwidth of qcow2 driver while
 allocating new cluster
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liu Qing <liuqing@huayun.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org


On 29/08/2017 05:56, Liu Qing wrote:
> On Mon, Aug 28, 2017 at 10:46:34AM -0500, Eric Blake wrote:
>> [adding qemu-block]
>>
>> On 08/28/2017 12:56 AM, Liu Qing wrote:
>>> Dear list,
>>>     Recently I used fio to test qcow2 driver in the guest os, and found out
>>> that when a new cluster is allocated the 4K IO will occupy 64K(default cluster
>>> size) bandwith.
>>>     From the code qcow2 driver will fill the unused part of new allocated
>>> cluster with 0 in perform_cow. These 0s are set in qcow2_co_readv when the read
>>> destination is not allocated and it has no backing file. Could I forbidden any
>>> further write in copy_sectors if the copy source is not allocated and it has
>>> no backing file? So only the requested data is written to the cluster. Function
>>> copy_sectors is only used by perform_cow in the master branch.
>>
>> There have already been discussions on optimizing COW writes in a manner
>> similar to what you are describing; for example,
>>
>> https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg00109.html
> Thanks Eric, this is what I am looking for.
> The only concern I have is in patch '[Qemu-devel] [PATCH v4 12/15] qcow2: skip
> writing zero buffers to empty' it says:
>
> It can be detected that
>   1. COW alignment of a write request is zeroes
>   2. Respective areas on the underlying BDS already read as zeroes
>      after being preallocated previously
>   If both of these true, COW may be skipped
>
> Will writing zero be skipped if the disk is not preallocated? @Anton
>

Hi,

In short, no, it will not (with my patches), but there might be some way
if that's what you really need.


First of all, this might be undesirable as you lose the cluster-size
data locality: now the whole cluster is written at once and is expected
to reside in the contiguous area on the physical drive.

Secondly, I think there is no guarantee that the underlying bs->file
image reads back as zeroes if the cluster is unallocated on qcow2 level.

For example, the unallocated cluster could have been used earlier but
then discarded. Discard passthrough is configurable so discard may not
be passed down to the underlying image. And I guess that in general,
even if it is passed, there is no strong requirement on reading back as
zeroes - look at qcow2 discard handling - discard head and tail which do
not cover full clusters are ignored.

_perhaps_, one may expect that there will be zeroes if the cluster is
allocated at the end of file
(see 'clusters_are_trailing' detection here
https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg00122.html)

but I haven't thought about all corner cases here.


/Anton

> BTW: why the code in the patch is a little different than the latest
> master branch? For example I don't have the is_zero function but only
> get is_zero_sectors. Is there something wrong with my settings?
>
> My repo:
> # git remote -v
> origin  git://git.qemu-project.org/qemu.git (fetch)
> origin  git://git.qemu-project.org/qemu.git (push)
>
> Thanks.
>>
>> --
>> Eric Blake, Principal Software Engineer
>> Red Hat, Inc.           +1-919-301-3266
>> Virtualization:  qemu.org | libvirt.org
>>
>
>
