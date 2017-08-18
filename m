Received: from eggs.gnu.org ([2001:4830:134:3::10]:60017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xiechanglong.d@gmail.com>) id 1dieBY-0002Ci-PS
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 06:07:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xiechanglong.d@gmail.com>) id 1dieBV-0007nb-LZ
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 06:07:24 -0400
References: <1493916761-32319-1-git-send-email-kwolf@redhat.com>
	<1493916761-32319-6-git-send-email-kwolf@redhat.com>
From: Xie Changlong <xiechanglong.d@gmail.com>
Message-ID: <849a6489-11f5-73c0-a7a8-400c58f995a4@gmail.com>
Date: Fri, 18 Aug 2017 18:06:47 +0800
MIME-Version: 1.0
In-Reply-To: <1493916761-32319-6-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 5/6] block: Fix write/resize permissions
 for inactive images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, Zhang Hailiang <zhang.zhanghailiang@huawei.com>, Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, Wen Congyang <wencongyang2@huawei.com>
Cc: famz@redhat.com, qemu-devel@nongnu.org

在 5/5/2017 12:52 AM, Kevin Wolf 写道:
>   
> +/* Returns whether the image file can be written to right now */
> +bool bdrv_is_writable(BlockDriverState *bs)
> +{
> +    return !bdrv_is_read_only(bs) && !(bs->open_flags & BDRV_O_INACTIVE);
> +}
> +

This commit use BDRV_O_INACTIVE to judge whether the image file can be 
written or not. But it blocks replication driver on the secondary node. 
For replication in secondary, we must ensure that the whole chain are 
writable:


   ||
   ||                            .----------
   ||                            | Secondary
   ||                            '----------
   ||
   ||

                                                         virtio-blk
                                                              ^
------>  3 NBD                                               |
   ||     server                                          2 filter
   ||        ^                                                ^
   ||        |                                                |
   ||  Secondary disk <--------- hidden-disk 5 <--------- active-disk 4
   ||        |          backing        ^       backing
   ||        |                         |
   ||        |                         |
   ||        '-------------------------'
   ||           drive-backup sync=none 6

The root casue is when we run replication in secondary, vmstate changes 
to RUN_STATE_INMIGRATE, then blockdev_init() sets bdrv_flags |= 
BDRV_O_INACTIVE. So the whole chain become readonly. I've tried on my 
side, but it seems not easy to fix it. I wonder if there is any way to 
bypass this? Any suggestion would be appreciated.

It's very easy to reproduce this scenario:
(gdb) r
Starting program: /root/.xie/qemu-colo/x86_64-softmmu/qemu-system-x86_64 
-boot c -m 2048 -smp 2 -qmp stdio -vnc :0 -name secondary -enable-kvm 
-cpu qemu64,+kvmclock -device piix3-usb-uhci -device usb-tablet -drive 
if=none,id=colo-disk,file.filename=/root/.xie/suse.qcow2.orgin,file.node-name=secondary_disk,driver=qcow2,node-name=sec-qcow2-driver-for-nbd 
-drive 
if=ide,id=active-disk0,node-name=active-disk111,throttling.bps-total=70000000,driver=replication,node-name=secondary-replication-driver,mode=secondary,top-id=active-disk0,file.driver=qcow2,file.node-name=active-qcow2-driver,file.file.filename=/mnt/ramfs/active_disk.img,file.file.node-name=active_disk,file.backing.driver=qcow2,file.backing.file.filename=/mnt/ramfs/hidden_disk.img,file.backing.node-name=hidden-qcow2-driver,file.backing.file.node-name=hidden_disk,file.backing.backing=colo-disk 
-incoming tcp:0:8888
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib64/libthread_db.so.1".
[New Thread 0x7ffff4801700 (LWP 25252)]
[New Thread 0x7ffff4000700 (LWP 25255)]
qemu-system-x86_64: -drive 
if=ide,id=active-disk0,node-name=active-disk111,throttling.bps-total=70000000,driver=replication,node-name=secondary-replication-driver,mode=secondary,top-id=active-disk0,file.driver=qcow2,file.node-name=active-qcow2-driver,file.file.filename=/mnt/ramfs/active_disk.img,file.file.node-name=active_disk,file.backing.driver=qcow2,file.backing.file.filename=/mnt/ramfs/hidden_disk.img,file.backing.node-name=hidden-qcow2-driver,file.backing.file.node-name=hidden_disk,file.backing.backing=colo-disk: 
Block node is read-only
[Thread 0x7ffff4000700 (LWP 25255) exited]
[Thread 0x7ffff4801700 (LWP 25252) exited]
[Inferior 1 (process 25248) exited with code 01]
Missing separate debuginfos, use: debuginfo-install 
glib2-2.46.2-4.el7.x86_64 glibc-2.17-157.el7_3.4.x86_64 
libacl-2.2.51-12.el7.x86_64 libattr-2.4.46-12.el7.x86_64 
libgcc-4.8.5-11.el7.x86_64 libgcrypt-1.5.3-13.el7_3.1.x86_64 
libgpg-error-1.12-3.el7.x86_64 libstdc++-4.8.5-11.el7.x86_64 
libuuid-2.23.2-33.el7_3.2.x86_64 openssl-libs-1.0.1e-60.el7_3.1.x86_64 
pixman-0.34.0-1.el7.x86_64 zlib-1.2.7-17.el7.x86_64
(gdb)

-- 
Thanks
     -Xie
