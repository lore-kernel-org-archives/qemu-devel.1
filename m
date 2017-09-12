Received: from eggs.gnu.org ([2001:4830:134:3::10]:60328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1driFC-0000Ti-7b
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 06:16:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1driF8-000813-76
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 06:16:38 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:45394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1driF7-0007wv-Vo
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 06:16:34 -0400
Received: by mail-wm0-x22b.google.com with SMTP id f199so56754385wme.0
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 03:16:32 -0700 (PDT)
Date: Tue, 12 Sep 2017 11:15:33 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170912101533.GD6123@stefanha-x1.localdomain>
References: <59B5E5C7.1030201@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <59B5E5C7.1030201@huawei.com>
Subject: Re: [Qemu-devel] question: qemu will crash when attach and detach a
 disk which configured qos for a while
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "WangJie (Captain)" <wangjie88@huawei.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, famz@redhat.com, Alberto Garcia <berto@igalia.com>

On Mon, Sep 11, 2017 at 09:24:23AM +0800, WangJie (Captain) wrote:
> Hi, I maybe find a bug about qemu-kvm(version:2.8.1.1)

Can you reproduce the segfault with qemu.git/master?

> *Segmentation fault info:*
> Program received signal SIGSEGV, Segmentation fault.
> 0x00007f5469220607 in blk_has_pending_reqs (blk=0x7f54672a0032, is_write=false) at block/throttle-groups.c:184
> 184        return blkp->pending_reqs[is_write];
> (gdb) bt
> #0  0x00007f5469220607 in blk_has_pending_reqs (blk=0x7f54672a0032, is_write=false) at block/throttle-groups.c:184
> #1  0x00007f54692206a8 in next_throttle_token (blk=0x7f546b6cd120, is_write=false) at block/throttle-groups.c:207
> #2  0x00007f5469220984 in throttle_group_co_io_limits_intercept (blk=0x7f546b6cd120, bytes=512, is_write=false)
>     at block/throttle-groups.c:322
> #3  0x00007f546920bc79 in blk_co_preadv (blk=0x7f546b6cd120, offset=0, bytes=512, qiov=0x7ffcc7355060, flags=0)
>     at block/block-backend.c:815
> #4  0x00007f546920bddf in blk_read_entry (opaque=0x7ffcc7355080) at block/block-backend.c:865
> #5  0x00007f54692a00f0 in coroutine_trampoline (i0=-588050448, i1=32595) at util/coroutine-ucontext.c:79
> #6  0x00007f5466f34cf0 in ?? () from /lib64/libc.so.6
> #7  0x00007f53f27fa9e0 in ?? ()
> #8  0x0000000000000000 in ?? ()

Is the guest running software that accesses the disk?  Otherwise I guess
this is the guest kernel probing the partition table on the disk
(offset=0, bytes=512).

> the way how to find the bug as follows:
> 
> *1、attach and detach a disk for a while，the configure of the disk as follows*
> <disk device="disk" type="file">
> <driver cache="none" io="native" name="qemu" type="raw" />
> <source file="/mnt/sdb/wangjie-kvm/core/fk8b42zr-oz" />
> <target bus="virtio" dev="vdb" />
> <iotune>
> <read_iops_sec>3000</read_iops_sec>
> <write_iops_sec>3000</write_iops_sec>
> <read_bytes_sec>120000000</read_bytes_sec>
> <write_bytes_sec>120000000</write_bytes_sec>
> </iotune>
> </disk>
> 
> 
> *2、run below script for a while，the qemu process of  VM will crash*
> ret=1
> while [ $ret -ne 0 ]; do
>         virsh attach-device i-clone203_rhel_7.3_64_guestosdev add-1.xml
>         sleep 2
>         virsh detach-device i-clone203_rhel_7.3_64_guestosdev add-1.xml
> done
> 
