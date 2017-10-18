Received: from eggs.gnu.org ([2001:4830:134:3::10]:35790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qy1-0003Qk-Fj
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qxz-000256-SN
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:13 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:45110)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1e4qxz-00024m-I8
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:11 -0400
Received: by mail-wr0-x244.google.com with SMTP id k7so5595489wre.2
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 09:13:11 -0700 (PDT)
Received: from 640k.lan (94-39-155-245.adsl-ull.clienti.tiscali.it.
	[94.39.155.245])
	by smtp.gmail.com with ESMTPSA id 69sm13436794wmm.2.2017.10.18.09.13.08
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 18 Oct 2017 09:13:09 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 18 Oct 2017 18:12:02 +0200
Message-Id: <1508343141-31835-11-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
References: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 10/29] build: remove CONFIG_LIBDECNUMBER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

It is used by all PPC targets; we can give the directory its own
Makefile.objs file, and include it directly from target/ppc.
target/s390 can do the same when it starts using it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.target                           | 6 ------
 default-configs/ppc-linux-user.mak        | 1 -
 default-configs/ppc-softmmu.mak           | 1 -
 default-configs/ppc64-linux-user.mak      | 1 -
 default-configs/ppc64-softmmu.mak         | 1 -
 default-configs/ppc64abi32-linux-user.mak | 1 -
 default-configs/ppc64le-linux-user.mak    | 1 -
 default-configs/ppcemb-softmmu.mak        | 1 -
 libdecnumber/Makefile.objs                | 5 +++++
 target/ppc/Makefile.objs                  | 1 +
 10 files changed, 6 insertions(+), 13 deletions(-)
 create mode 100644 libdecnumber/Makefile.objs

diff --git a/Makefile.target b/Makefile.target
index a4b292d..e4244c1 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -102,12 +102,6 @@ obj-y += target/$(TARGET_BASE_ARCH)/
 obj-y += disas.o
 obj-$(call notempty,$(TARGET_XML_FILES)) += gdbstub-xml.o
 
-obj-$(CONFIG_LIBDECNUMBER) += libdecnumber/decContext.o
-obj-$(CONFIG_LIBDECNUMBER) += libdecnumber/decNumber.o
-obj-$(CONFIG_LIBDECNUMBER) += libdecnumber/dpd/decimal32.o
-obj-$(CONFIG_LIBDECNUMBER) += libdecnumber/dpd/decimal64.o
-obj-$(CONFIG_LIBDECNUMBER) += libdecnumber/dpd/decimal128.o
-
 #########################################################
 # Linux user emulator target
 
diff --git a/default-configs/ppc-linux-user.mak b/default-configs/ppc-linux-user.mak
index 260ba41..6273df2 100644
--- a/default-configs/ppc-linux-user.mak
+++ b/default-configs/ppc-linux-user.mak
@@ -1,2 +1 @@
 # Default configuration for ppc-linux-user
-CONFIG_LIBDECNUMBER=y
diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index d7a3755..bb225c6 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -46,7 +46,6 @@ CONFIG_E500=y
 CONFIG_OPENPIC_KVM=$(call land,$(CONFIG_E500),$(CONFIG_KVM))
 CONFIG_PLATFORM_BUS=y
 CONFIG_ETSEC=y
-CONFIG_LIBDECNUMBER=y
 CONFIG_SM501=y
 # For PReP
 CONFIG_SERIAL_ISA=y
diff --git a/default-configs/ppc64-linux-user.mak b/default-configs/ppc64-linux-user.mak
index e731ce0..422d3fb 100644
--- a/default-configs/ppc64-linux-user.mak
+++ b/default-configs/ppc64-linux-user.mak
@@ -1,2 +1 @@
 # Default configuration for ppc64-linux-user
-CONFIG_LIBDECNUMBER=y
diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/ppc64-softmmu.mak
index 9086475..d1b3a6d 100644
--- a/default-configs/ppc64-softmmu.mak
+++ b/default-configs/ppc64-softmmu.mak
@@ -51,7 +51,6 @@ CONFIG_E500=y
 CONFIG_OPENPIC_KVM=$(call land,$(CONFIG_E500),$(CONFIG_KVM))
 CONFIG_PLATFORM_BUS=y
 CONFIG_ETSEC=y
-CONFIG_LIBDECNUMBER=y
 CONFIG_SM501=y
 # For pSeries
 CONFIG_XICS=$(CONFIG_PSERIES)
diff --git a/default-configs/ppc64abi32-linux-user.mak b/default-configs/ppc64abi32-linux-user.mak
index c244d07..1c657ec 100644
--- a/default-configs/ppc64abi32-linux-user.mak
+++ b/default-configs/ppc64abi32-linux-user.mak
@@ -1,2 +1 @@
 # Default configuration for ppc64abi32-linux-user
-CONFIG_LIBDECNUMBER=y
diff --git a/default-configs/ppc64le-linux-user.mak b/default-configs/ppc64le-linux-user.mak
index 4ba4eae..63f4269 100644
--- a/default-configs/ppc64le-linux-user.mak
+++ b/default-configs/ppc64le-linux-user.mak
@@ -1,2 +1 @@
 # Default configuration for ppc64le-linux-user
-CONFIG_LIBDECNUMBER=y
diff --git a/default-configs/ppcemb-softmmu.mak b/default-configs/ppcemb-softmmu.mak
index 635923a..13917fb 100644
--- a/default-configs/ppcemb-softmmu.mak
+++ b/default-configs/ppcemb-softmmu.mak
@@ -15,5 +15,4 @@ CONFIG_PTIMER=y
 CONFIG_I8259=y
 CONFIG_XILINX=y
 CONFIG_XILINX_ETHLITE=y
-CONFIG_LIBDECNUMBER=y
 CONFIG_SM501=y
diff --git a/libdecnumber/Makefile.objs b/libdecnumber/Makefile.objs
new file mode 100644
index 0000000..d81db04
--- /dev/null
+++ b/libdecnumber/Makefile.objs
@@ -0,0 +1,5 @@
+obj-y += decContext.o
+obj-y += decNumber.o
+obj-y += dpd/decimal32.o
+obj-y += dpd/decimal64.o
+obj-y += dpd/decimal128.o
diff --git a/target/ppc/Makefile.objs b/target/ppc/Makefile.objs
index f92ba67..e8fa18c 100644
--- a/target/ppc/Makefile.objs
+++ b/target/ppc/Makefile.objs
@@ -15,5 +15,6 @@ obj-y += int_helper.o
 obj-y += timebase_helper.o
 obj-y += misc_helper.o
 obj-y += mem_helper.o
+obj-y += ../../libdecnumber/
 obj-$(CONFIG_USER_ONLY) += user_only_helper.o
 obj-y += gdbstub.o
-- 
1.8.3.1
