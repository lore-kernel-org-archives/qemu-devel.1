Received: from eggs.gnu.org ([2001:4830:134:3::10]:50042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1clG8i-0005hR-4F
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 09:31:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1clG8g-0004hg-U7
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 09:31:00 -0500
References: <1484884080-28836-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1484884080-28836-6-git-send-email-zhang.zhanghailiang@huawei.com>
	<20170227173720.GJ10201@stefanha-x1.localdomain>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <58BEC406.1050903@huawei.com>
Date: Tue, 7 Mar 2017 22:30:30 +0800
MIME-Version: 1.0
In-Reply-To: <20170227173720.GJ10201@stefanha-x1.localdomain>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 5/6] replication: Implement block
 replication for shared disk case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: xuquan8@huawei.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, xiecl.fnst@cn.fujitsu.com, zhangchen.fnst@cn.fujitsu.com, wencongyang2@huawei.com

Hi Stefan,

Sorry for the delayed reply.

On 2017/2/28 1:37, Stefan Hajnoczi wrote:
> On Fri, Jan 20, 2017 at 11:47:59AM +0800, zhanghailiang wrote:
>> Just as the scenario of non-shared disk block replication,
>> we are going to implement block replication from many basic
>> blocks that are already in QEMU.
>> The architecture is:
>>
>>           virtio-blk                     ||                               .----------
>>               /                          ||                               | Secondary
>>              /                           ||                               '----------
>>             /                            ||                                 virtio-blk
>>            /                             ||                                      |
>>            |                             ||                               replication(5)
>>            |                    NBD  -------->   NBD   (2)                       |
>>            |                  client     ||    server ---> hidden disk <-- active disk(4)
>>            |                     ^       ||                      |
>>            |              replication(1) ||                      |
>>            |                     |       ||                      |
>>            |   +-----------------'       ||                      |
>>           (3)  |drive-backup sync=none   ||                      |
>> --------. |   +-----------------+       ||                      |
>> Primary | |                     |       ||           backing    |
>> --------' |                     |       ||                      |
>>            V                     |                               |
>>         +-------------------------------------------+            |
>>         |               shared disk                 | <----------+
>>         +-------------------------------------------+
>>
>>      1) Primary writes will read original data and forward it to Secondary
>>         QEMU.
>>      2) The hidden-disk is created automatically. It buffers the original content
>>         that is modified by the primary VM. It should also be an empty disk, and
>>         the driver supports bdrv_make_empty() and backing file.
>>      3) Primary write requests will be written to Shared disk.
>>      4) Secondary write requests will be buffered in the active disk and it
>>         will overwrite the existing sector content in the buffer.
>>
>> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
>> Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>
>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>
> Are there any restrictions on the shared disk?  For example the -drive
> cache= mode must be 'none'.  If the cache mode isn't 'none' the
> secondary host might have old data in the host page cache.  The

While do checkpoint, we will call vm_stop(), in which, the bdrv_flush_all()
will be called, is it enough ?

> Secondary QEMU would have an inconsistent view of the shared disk.
>
> Are image file formats like qcow2 supported for the shared disk?  Extra

In the above scenario, it has no limitation of formats for the shared disk.

> steps are required to achieve consistency, see bdrv_invalidate_cache().
>

Hmm, in that case, we should call bdrv_invalidate_cache_all() while checkpoint.


Thanks,
Hailiang

> Stefan
>
