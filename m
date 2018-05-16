Received: from eggs.gnu.org ([2001:4830:134:3::10]:60592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fIwo3-0001PX-Mg
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:49:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fIwo0-0001Oo-IP
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:49:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50920 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1fIwo0-0001OS-Bl
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:49:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B89D140201A4
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 13:49:23 +0000 (UTC)
References: <20180417140802.16711-1-pbonzini@redhat.com>
	<0a51d026-8b9f-9925-1229-10e3766907bb@redhat.com>
	<02617670-8b06-e5b9-d763-65453b5f706a@redhat.com>
	<222e8530-6bd1-086a-cecf-1a755a38ce99@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <19ded06a-be5a-4956-5508-1449f845aaf1@redhat.com>
Date: Wed, 16 May 2018 15:49:22 +0200
MIME-Version: 1.0
In-Reply-To: <222e8530-6bd1-086a-cecf-1a755a38ce99@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/4] exec: reintroduce MemoryRegion caching
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

Hi Paolo,

On 05/16/2018 03:38 PM, Auger Eric wrote:
> Hi Paolo
> 
> On 05/16/2018 12:42 PM, Paolo Bonzini wrote:
>> On 16/05/2018 12:41, Auger Eric wrote:
>>> This patch seems to cause a regression with ARM vsmmu +
>>> virtio-blk-pci. Reverting it looks to fix the issue. Otherwise I
>>> get:
>>
>> What's the command line for a reproducer?
>>
>> Thanks,
>>
>> Paolo
>>
> 
> here is my command line:
> 
> TCG:
> 
> sudo /home/augere/UPSTREAM/qemu/aarch64-softmmu/qemu-system-aarch64 -M virt-2.12,gic-version=3,iommu=smmuv3 \
> -cpu cortex-a57 -smp 8 -m 4096 -display none -machine accel=tcg \
> -serial tcp:localhost:4444,server -trace events=/home/augere/TEST/QEMU/hw-arm-smmu \
> -qmp unix:/home/augere/TEST/QEMU/qmp-sock,server,nowait \
> -device virtio-blk-pci,bus=pcie.0,scsi=off,drive=drv0,id=drv0,bootindex=1,iommu_platform,disable-modern=off,disable-legacy=on,werror=stop,rerror=stop \
> -drive file=/home/augere/VM/IMAGES/vm0.qcow2,format=qcow2,if=none,id=drv0 \
> -device virtio-net-pci,bus=pcie.0,netdev=nic0,mac=6a:f5:10:b1:3d:d2,iommu_platform,disable-modern=off,disable-legacy=on \
> -netdev tap,id=nic0,script=/home/augere/TEST/SCRIPTS/qemu-ifup,downscript=/home/augere/TEST/SCRIPTS/qemu-ifdown \
> -net none
> 
> or with acceleration:
> 
> sudo /home/augere/UPSTREAM/qemu/aarch64-softmmu/qemu-system-aarch64 -M virt-2.12,gic-version=3,iommu=smmuv3 -cpu host -smp 8 -m 4096 -display none --enable-kvm ../..
> 
> I reproduce with both, 100% of the cases.
> 
> Trying to reproduce with intel iommu as well.

Yep I just reproduced on x86 as well. Here is the used cmd line.

/home/augere/UPSTREAM/qemu/x86_64-softmmu/qemu-system-x86_64 \
-M q35,accel=kvm,usb=off,dump-guest-core=off -cpu Haswell,-hle,-rtm -smp 4,sockets=4,cores=1,threads=1 -m 8192 \
-display none --enable-kvm -serial tcp:localhost:4444,server -qmp unix:/home/augere/TEST/QEMU/qmp-sock,server,nowait -rtc base=utc,driftfix=slew \
-global kvm-pit.lost_tick_policy=delay -realtime mlock=off -no-hpet -no-shutdown -global PIIX4_PM.disable_s3=1 -global PIIX4_PM.disable_s4=1 \
-boot strict=on -machine kernel_irqchip=split -device ioh3420,chassis=1,addr=4,id=pcie.1 -device ioh3420,chassis=2,addr=5,id=pcie.2 \
-device intel-iommu,intremap=on \
-device virtio-blk-pci,scsi=off,drive=drv0,id=virtio-disk0,bootindex=1,iommu_platform,disable-modern=off,disable-legacy=on \
-drive file=/home/augere/VM/IMAGES/vm0.qcow2,format=qcow2,if=none,id=drv0 \
-device virtio-net-pci,netdev=nic0,mac=6a:f5:10:b1:3d:d2,iommu_platform,disable-modern=off,disable-legacy=on \
-netdev tap,id=nic0,script=/home/augere/TEST/SCRIPTS/qemu-ifup,downscript=/home/augere/TEST/SCRIPTS/qemu-ifdown \
-net none

Program received signal SIGSEGV, Segmentation fault.
address_space_lduw_internal_cached_slow (endian=DEVICE_LITTLE_ENDIAN, result=<optimized out>, attrs=...,
    addr=2, cache=<optimized out>) at /home/augere/UPSTREAM/qemu/memory_ldst.inc.c:242
242	            val = lduw_le_p(ptr);
Missing separate debuginfos, use: debuginfo-install bzip2-libs-1.0.6-13.el7.x86_64 celt051-0.5.1.3-8.el7.x86_64 cyrus-sasl-lib-2.1.26-23.el7.x86_64 elfutils-libelf-0.170-4.el7.x86_64
elfutils-libs-0.170-4.el7.x86_64 glibc-2.17-222.el7.x86_64 keyutils-libs-1.5.8-3.el7.x86_64 krb5-libs-1.15.1-18.el7.x86_64 libattr-2.4.46-13.el7.x86_64 libblkid-2.23.2-52.el7.x86_64
libcacard-2.5.2-2.el7.x86_64 libcap-2.22-9.el7.x86_64 libcom_err-1.42.9-11.el7.x86_64 libffi-3.0.13-18.el7.x86_64 libgcc-4.8.5-28.el7.x86_64 libjpeg-turbo-1.2.90-5.el7.x86_64
libmount-2.23.2-52.el7.x86_64 libselinux-2.5-12.el7.x86_64 libstdc++-4.8.5-28.el7.x86_64 libusbx-1.0.21-1.el7.x86_64 libuuid-2.23.2-52.el7.x86_64 lz4-1.7.5-2.el7.x86_64
ncurses-libs-5.9-14.20130511.el7_4.x86_64 nspr-4.17.0-1.el7.x86_64 nss-3.34.0-4.el7.x86_64 nss-softokn-freebl-3.34.0-2.el7.x86_64 nss-util-3.34.0-2.el7.x86_64 numactl-libs-2.0.9-7.el7.x86_64
openssl-libs-1.0.2k-12.el7.x86_64 opus-1.0.2-6.el7.x86_64 pcre-8.32-17.el7.x86_64 pixman-0.34.0-1.el7.x86_64 spice-server-0.14.0-2.el7.x86_64 systemd-libs-219-57.el7.x86_64 usbredir-0.7.1-3.el7.x86_64
xz-libs-5.2.2-1.el7.x86_64 zlib-1.2.7-17.el7.x86_64
(gdb) where
#0  0x000055555580e773 in address_space_lduw_le_cached_slow (endian=
    DEVICE_LITTLE_ENDIAN, result=<optimized out>, attrs=..., addr=2, cache=<optimized out>)
    at /home/augere/UPSTREAM/qemu/memory_ldst.inc.c:242
#1  0x000055555580e773 in address_space_lduw_le_cached_slow (cache=<optimized out>, addr=addr@entry=2, attrs=..., attrs@entry=..., result=result@entry=0x0) at
/home/augere/UPSTREAM/qemu/memory_ldst.inc.c:273
#2  0x00005555558b0a9b in virtio_queue_set_notification (result=0x0, attrs=..., addr=2, cache=<optimized out>) at /home/augere/UPSTREAM/qemu/include/exec/memory_ldst_cached.inc.h:56
#3  0x00005555558b0a9b in virtio_queue_set_notification (addr=2, cache=<optimized out>)
    at /home/augere/UPSTREAM/qemu/include/exec/memory_ldst_phys.inc.h:91
#4  0x00005555558b0a9b in virtio_queue_set_notification (vdev=<optimized out>, pa=2, cache=<optimized out>) at /home/augere/UPSTREAM/qemu/include/hw/virtio/virtio-access.h:166
#5  0x00005555558b0a9b in virtio_queue_set_notification (vq=0x7fffec260010)
    at /home/augere/UPSTREAM/qemu/hw/virtio/virtio.c:227
#6  0x00005555558b0a9b in virtio_queue_set_notification (vq=vq@entry=0x7fffec260010, enable=enable@entry=0) at /home/augere/UPSTREAM/qemu/hw/virtio/virtio.c:324
#7  0x00005555558b0b12 in virtio_queue_set_notification (vq=vq@entry=0x7fffec260010, enable=enable@entry=0) at /home/augere/UPSTREAM/qemu/hw/virtio/virtio.c:318
#8  0x0000555555880fea in virtio_blk_handle_vq (s=0x555557dc9660, vq=0x7fffec260010)
    at /home/augere/UPSTREAM/qemu/hw/block/virtio-blk.c:605
#9  0x00005555558b0680 in virtio_queue_notify_aio_vq (vq=0x7fffec260010)
    at /home/augere/UPSTREAM/qemu/hw/virtio/virtio.c:1515
#10 0x0000555555bef7c8 in aio_dispatch_handlers (ctx=ctx@entry=0x555556a35ce0) at util/aio-posix.c:406
#11 0x0000555555bf0068 in aio_dispatch (ctx=0x555556a35ce0) at util/aio-posix.c:437
#12 0x0000555555becbce in aio_ctx_dispatch (source=<optimized out>, callback=<optimized out>, user_data=<optimized out>) at util/async.c:261
#13 0x00007ffff79058f9 in g_main_context_dispatch (context=0x555556a360b0) at gmain.c:3146
#14 0x00007ffff79058f9 in g_main_context_dispatch (context=context@entry=0x555556a360b0) at gmain.c:3811
#15 0x0000555555bef326 in main_loop_wait () at util/main-loop.c:215
#16 0x0000555555bef326 in main_loop_wait (timeout=<optimized out>) at util/main-loop.c:263
#17 0x0000555555bef326 in main_loop_wait (nonblocking=nonblocking@entry=0) at util/main-loop.c:522
#18 0x00005555557fdb1f in main () at vl.c:1943
#19 0x00005555557fdb1f in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>)
    at vl.c:4675
(gdb) quit


Thanks

Eric

> 
> Thanks
> 
> Eric
> 
