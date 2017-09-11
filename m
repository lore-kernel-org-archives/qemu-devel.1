Received: from eggs.gnu.org ([2001:4830:134:3::10]:44795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wangjie88@huawei.com>) id 1drDSy-0005pq-5n
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 21:24:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wangjie88@huawei.com>) id 1drDSu-0003eo-OV
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 21:24:48 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2261)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <wangjie88@huawei.com>) id 1drDSt-0003TI-Tf
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 21:24:44 -0400
From: "WangJie (Captain)" <wangjie88@huawei.com>
Message-ID: <59B5E5C7.1030201@huawei.com>
Date: Mon, 11 Sep 2017 09:24:23 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] question: qemu will crash when attach and detach a
 disk which configured qos for a while
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, famz@redhat.com, wangjie88@huawei.com

Hi, I maybe find a bug about qemu-kvm(version:2.8.1.1)



*Segmentation fault info:*
Program received signal SIGSEGV, Segmentation fault.
0x00007f5469220607 in blk_has_pending_reqs (blk=0x7f54672a0032, is_write=false) at block/throttle-groups.c:184
184        return blkp->pending_reqs[is_write];
(gdb) bt
#0  0x00007f5469220607 in blk_has_pending_reqs (blk=0x7f54672a0032, is_write=false) at block/throttle-groups.c:184
#1  0x00007f54692206a8 in next_throttle_token (blk=0x7f546b6cd120, is_write=false) at block/throttle-groups.c:207
#2  0x00007f5469220984 in throttle_group_co_io_limits_intercept (blk=0x7f546b6cd120, bytes=512, is_write=false)
    at block/throttle-groups.c:322
#3  0x00007f546920bc79 in blk_co_preadv (blk=0x7f546b6cd120, offset=0, bytes=512, qiov=0x7ffcc7355060, flags=0)
    at block/block-backend.c:815
#4  0x00007f546920bddf in blk_read_entry (opaque=0x7ffcc7355080) at block/block-backend.c:865
#5  0x00007f54692a00f0 in coroutine_trampoline (i0=-588050448, i1=32595) at util/coroutine-ucontext.c:79
#6  0x00007f5466f34cf0 in ?? () from /lib64/libc.so.6
#7  0x00007f53f27fa9e0 in ?? ()
#8  0x0000000000000000 in ?? ()


the way how to find the bug as follows:

*1、attach and detach a disk for a while，the configure of the disk as follows*
<disk device="disk" type="file">
<driver cache="none" io="native" name="qemu" type="raw" />
<source file="/mnt/sdb/wangjie-kvm/core/fk8b42zr-oz" />
<target bus="virtio" dev="vdb" />
<iotune>
<read_iops_sec>3000</read_iops_sec>
<write_iops_sec>3000</write_iops_sec>
<read_bytes_sec>120000000</read_bytes_sec>
<write_bytes_sec>120000000</write_bytes_sec>
</iotune>
</disk>


*2、run below script for a while，the qemu process of  VM will crash*
ret=1
while [ $ret -ne 0 ]; do
        virsh attach-device i-clone203_rhel_7.3_64_guestosdev add-1.xml
        sleep 2
        virsh detach-device i-clone203_rhel_7.3_64_guestosdev add-1.xml
done
