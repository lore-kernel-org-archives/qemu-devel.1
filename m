Received: from eggs.gnu.org ([2001:4830:134:3::10]:41683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZHO-00045Q-8n
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:01:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZHM-0007ag-Vf
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:01:46 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:40345)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1elZHM-0007aV-MC
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:01:44 -0500
Received: by mail-wm0-x244.google.com with SMTP id v123so15588248wmd.5
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 04:01:44 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Feb 2018 13:00:14 +0100
Message-Id: <1518523252-49106-11-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
References: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 10/48] net/can: documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>

From: Pavel Pisa <pisa@cmp.felk.cvut.cz>

Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/can.txt | 107 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)
 create mode 100644 docs/can.txt

diff --git a/docs/can.txt b/docs/can.txt
new file mode 100644
index 0000000..a357105
--- /dev/null
+++ b/docs/can.txt
@@ -0,0 +1,107 @@
+QEMU CAN bus emulation support
+==============================
+
+The CAN bus emulation provides mechanism to connect multiple
+emulated CAN controller chips together by one or multiple CAN busses
+(the controller device "canbus"  parameter). The individual busses
+can be connected to host system CAN API (at this time only Linux
+SocketCAN is supported).
+
+The concept of busses is generic and different CAN controllers
+can be implemented for it but at this time only SJA1000 chip
+controller is implemented.
+
+The PCI addon card hardware has been selected as the first CAN
+interface to implement because such device can be easily connected
+to systems with different CPU architectures (x86, PowerPC, ARM, etc.).
+
+The project has been initially started in frame of RTEMS GSoC 2013
+slot by Jin Yang under our mentoring  The initial idea was to provide generic
+CAN subsystem for RTEMS. But lack of common environment for code and RTEMS
+testing lead to goal change to provide environment which provides complete
+emulated environment for testing and RTEMS GSoC slot has been donated
+to work on CAN hardware emulation on QEMU.
+
+Examples how to use CAN emulation
+=================================
+
+When QEMU with CAN PCI support is compiled then one of the next
+CAN boards can be selected
+
+ (1) CAN bus Kvaser PCI CAN-S (single SJA1000 channel) boad. QEMU startup options
+    -object can-bus,id=canbus0
+    -device kvaser_pci,canbus=canbus0
+    Add "can-host-socketcan" object to connect device to host system CAN bus
+    -object can-host-socketcan,id=canhost0,if=can0,canbus=canbus0
+
+ (2) CAN bus PCM-3680I PCI (dual SJA1000 channel) emulation
+    -object can-bus,id=canbus0
+    -device pcm3680_pci,canbus0=canbus0,canbus1=canbus0
+
+ another example:
+    -object can-bus,id=canbus0
+    -object can-bus,id=canbus1
+    -device pcm3680_pci,canbus0=canbus0,canbus1=canbus1
+
+ (3) CAN bus MIOe-3680 PCI (dual SJA1000 channel) emulation
+    -device mioe3680_pci,canbus0=canbus0
+
+
+The ''kvaser_pci'' board/device model is compatible with and has been tested with
+''kvaser_pci'' driver included in mainline Linux kernel.
+The tested setup was Linux 4.9 kernel on the host and guest side.
+Example for qemu-system-x86_64:
+
+    qemu-system-x86_64 -enable-kvm -kernel /boot/vmlinuz-4.9.0-4-amd64 \
+      -initrd ramdisk.cpio \
+      -virtfs local,path=shareddir,security_model=none,mount_tag=shareddir \
+      -object can-bus,id=canbus0 \
+      -object can-host-socketcan,id=canhost0,if=can0,canbus=canbus0 \
+      -device kvaser_pci,canbus=canbus0 \
+      -nographic -append "console=ttyS0"
+
+Example for qemu-system-arm:
+
+    qemu-system-arm -cpu arm1176 -m 256 -M versatilepb \
+      -kernel kernel-qemu-arm1176-versatilepb \
+      -hda rpi-wheezy-overlay \
+      -append "console=ttyAMA0 root=/dev/sda2 ro init=/sbin/init-overlay" \
+      -nographic \
+      -virtfs local,path=shareddir,security_model=none,mount_tag=shareddir \
+      -object can-bus,id=canbus0 \
+      -object can-host-socketcan,id=canhost0,if=can0,canbus=canbus0 \
+      -device kvaser_pci,canbus=canbus0,host=can0 \
+
+The CAN interface of the host system has to be configured for proper
+bitrate and set up. Configuration is not propagated from emulated
+devices through bus to the physical host device. Example configuration
+for 1 Mbit/s
+
+  ip link set can0 type can bitrate 1000000
+  ip link set can0 up
+
+Virtual (host local only) can interface can be used on the host
+side instead of physical interface
+
+  ip link add dev can0 type vcan
+
+The CAN interface on the host side can be used to analyze CAN
+traffic with "candump" command which is included in "can-utils".
+
+  candump can0
+
+Links to other resources
+========================
+
+ (1) Repository with development branch can-pci at Czech Technical University
+     https://gitlab.fel.cvut.cz/canbus/qemu-canbus
+ (2) GitHub repository with can-pci and our other changes included
+     https://gitlab.fel.cvut.cz/canbus/qemu-canbus
+ (3) RTEMS page describing project
+     https://devel.rtems.org/wiki/Developer/Simulators/QEMU/CANEmulation
+ (4) RTLWS 2015 article about the projevt and its use with CANopen emulation
+     http://rtime.felk.cvut.cz/publications/public/rtlws2015-qemu-can.pdf
+     Slides
+     http://rtime.felk.cvut.cz/publications/public/rtlws2015-qemu-can-slides.pdf
+ (5) Linux SocketCAN utilities
+     https://github.com/linux-can/can-utils/
\ No newline at end of file
-- 
1.8.3.1
