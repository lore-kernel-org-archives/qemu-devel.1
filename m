Received: from eggs.gnu.org ([2001:4830:134:3::10]:33044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1eXvQS-0008DF-16
	for qemu-devel@nongnu.org; Sat, 06 Jan 2018 15:50:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1eXvQQ-0001FR-Pe
	for qemu-devel@nongnu.org; Sat, 06 Jan 2018 15:50:44 -0500
Received: from smtp8.web4u.cz ([81.91.87.88]:58681 helo=mx-8.mail.web4u.cz)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pisa@cmp.felk.cvut.cz>)
	id 1eXvQQ-0001E4-Ff
	for qemu-devel@nongnu.org; Sat, 06 Jan 2018 15:50:42 -0500
From: pisa@cmp.felk.cvut.cz
Date: Sat,  6 Jan 2018 21:47:36 +0100
Message-Id: <b49046ca1e0c27099bd0124c97bfa01ddcb6f40e.1515260163.git.pisa@cmp.felk.cvut.cz>
In-Reply-To: <cover.1515260163.git.pisa@cmp.felk.cvut.cz>
References: <cover.1515260163.git.pisa@cmp.felk.cvut.cz>
In-Reply-To: <cover.1515260163.git.pisa@cmp.felk.cvut.cz>
References: <cover.1515260163.git.pisa@cmp.felk.cvut.cz>
Subject: [Qemu-devel] [PATCH 7/7] QEMU CAN bus emulation documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Konrad Frederic <frederic.konrad@adacore.com>, Deniz Eren <deniz.eren@icloud.com>, Oliver Hartkopp <socketcan@hartkopp.net>, Marek Vasut <marex@denx.de>, Jan Kiszka <jan.kiszka@siemens.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Pavel Pisa <pisa@cmp.felk.cvut.cz>

From: Pavel Pisa <pisa@cmp.felk.cvut.cz>

Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
---
 docs/can.txt | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 docs/can.txt

diff --git a/docs/can.txt b/docs/can.txt
new file mode 100644
index 0000000000..ac3170e947
--- /dev/null
+++ b/docs/can.txt
@@ -0,0 +1,78 @@
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
+    -device kvaser_pci,canbus=canbus0
+    Add "host" parameter to connect device to host system CAN bus
+    -device kvaser_pci,canbus=canbus0,host=can0
+
+ (2) CAN bus PCM-3680I PCI (dual SJA1000 channel) emulation
+    -device pcm3680_pci,canbus=canbus0,host=can0
+
+ (3) CAN bus MIOe-3680 PCI (dual SJA1000 channel) emulation
+    -device mioe3680_pci,canbus=canbus0,host=can0
+
+
+The ''kvaser_pci'' board/device model is compatible with and has been tested with
+''kvaser_pci'' driver included in mainline Linux kernel.
+The tested setup was Linux 4.9 kernel on the host and guest side.
+
+Next parameters has been used for qemu-system-x86_64
+
+    qemu-system-x86_64 -enable-kvm -kernel /boot/vmlinuz-4.9.0-4-amd64 \
+      -initrd ramdisk.cpio \
+      -virtfs local,path=shareddir,security_model=none,mount_tag=shareddir \
+      -vga cirrus \
+      -device kvaser_pci,canbus=canbus0,host=can0 \
+      -nographic -append "console=ttyS0"
+
+The list of parameters for qemu-system-arm
+
+    qemu-system-arm -cpu arm1176 -m 256 -M versatilepb \
+      -kernel kernel-qemu-arm1176-versatilepb \
+      -hda rpi-wheezy-overlay \
+      -append "console=ttyAMA0 root=/dev/sda2 ro init=/sbin/init-overlay" \
+      -nographic \
+      -virtfs local,path=shareddir,security_model=none,mount_tag=shareddir \
+      -device kvaser_pci,canbus=canbus0,host=can0 \
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
-- 
2.11.0
