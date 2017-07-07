Received: from eggs.gnu.org ([2001:4830:134:3::10]:35332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wanghaibin.wang@huawei.com>) id 1dTQTw-0002T9-Hg
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 06:27:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wanghaibin.wang@huawei.com>) id 1dTQNA-0008Sx-3y
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 06:20:33 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3901)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <wanghaibin.wang@huawei.com>) id 1dTQN9-0008RU-Ga
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 06:20:28 -0400
Message-ID: <595F6049.9050700@huawei.com>
Date: Fri, 7 Jul 2017 18:19:53 +0800
From: wanghaibin <wanghaibin.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] virtio-gpu: bug report : vnc connect can not display
 when migrate to destination.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kraxel@redhat.com, airlied@redhat.com, zhaoshenglong@huawei.com, wu.wubin@huawei.com

Hi, all:

I met a problem.

I boot a aarch64 kernel with virtio-gpu device on aarch64 board. The cmdline just like：

qemu-system-aarch64 -name guest=vm,debug-threads=on -S -machine virt-2.6,accel=kvm,usb=off,gic-version=3 -cpu host -m 8192 -realtime mlock=off -smp 4,sockets=4,cores=1,threads=1
-no-user-config -nodefaults -no-shutdown -boot strict=on -kernel /mnt/linux-stable/arch/arm64/boot/Image -append console=ttyAMA0 root=/dev/sda2 earlyprintk=pl011,0x9000000 rw
-device ioh3420,port=0x8,chassis=1,id=pci.1,bus=pcie.0,addr=0x1 -device i82801b11-bridge,id=pci.2,bus=pcie.0,addr=0x2 -device pci-bridge,chassis_nr=3,id=pci.3,bus=pci.2,addr=0x0
-device ioh3420,port=0x18,chassis=4,id=pci.4,bus=pcie.0,addr=0x3 -device ioh3420,port=0x20,chassis=5,id=pci.5,bus=pcie.0,addr=0x4 -device ioh3420,port=0x28,chassis=6,id=pci.6,bus=pcie.0,addr=0x5
-device usb-ehci,id=usb,bus=pci.3,addr=0x1 -device virtio-scsi-pci,id=scsi0,bus=pci.4,addr=0x0 -drive file=/mnt/euler_b500.raw,format=raw,if=none,id=drive-scsi0-0-0-0,cache=none,aio=native
-device scsi-hd,bus=scsi0.0,channel=0,scsi-id=0,lun=0,drive=drive-scsi0-0-0-0,id=scsi0-0-0-0,bootindex=1 -netdev tap,fd=27,id=hostnet0,vhost=on,vhostfd=28
-device virtio-net-pci,netdev=hostnet0,id=net0,mac=52:54:00:af:3c:c5,bus=pci.1,addr=0x0 -serial pty -device usb-tablet,id=input0 -device usb-kbd,id=input1
-vnc 0.0.0.0:0 -device virtio-gpu-pci,id=video0,bus=pci.5,addr=0x0

Using the VNC4 client connect to the vm, every is OK.

After migrate to destination, Using the VNC4 client connect to the vm , it cannot display normally. Using the tightVNC client, display normally.


I try to debug this problem, and the info just as follow:
(1) Guest kernel driver use soft_cursor update the cursor, not the virtio-gpu driver virtio_gpu_cursor_ping func
    (qemu virtio-gpu backend does not call update_cursor)
(2) Migrate to destination, I notice virtio_gpu_load func will call update_cursor (call to vnc_dpy_cursor_define, define vd->cursor).
    At the source, vd->cursor is not define.
(3) After migrate, using the VNC4 client, display failed caused by set_encodings(VNC_ENCODING_RICH_CURSOR: vnc_cursor_define(vs);, i don't know why),


I don't understand very well about console, virtio-gpu, I just doubt this problem though compared the source and destination state difference.
So just supply these message.

BTW: just a simple test, delete the virtio_gpu_load func update_cursor line, VNC4 client display OK at destination ...


Thanks.
