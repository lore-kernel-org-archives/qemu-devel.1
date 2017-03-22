Received: from eggs.gnu.org ([2001:4830:134:3::10]:35519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1cqVca-0008OI-Ah
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 22:03:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1cqVcV-0000dU-EH
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 22:03:32 -0400
Received: from mga05.intel.com ([192.55.52.43]:25386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anthony.xu@intel.com>)
	id 1cqVcV-0000bp-6L
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 22:03:27 -0400
From: "Xu, Anthony" <anthony.xu@intel.com>
Date: Wed, 22 Mar 2017 02:03:22 +0000
Message-ID: <4712D8F4B26E034E80552F30A67BE0B1A2D69E@ORSMSX112.amr.corp.intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH] only link current target arch traces to
 qemu-system
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: 'Paolo Bonzini' <pbonzini@redhat.com>

When building target x86_64-softmmu, all other architectures' trace.o are l=
inked into=20
x86_64-softmmu/qemu-system-x86_64, like hw/arm/trace.o, hw/mips/trace.o etc=
.,=20
that is not necessary.
 Same thing happens when building other targets.

Only current target arch traces should be linked into qemu-system.

Signed-off -by: Anthony Xu <anthony.xu@intel.com>




diff --git a/Makefile.target b/Makefile.target
index 7df2b8c..638e044 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -177,6 +177,41 @@ block-obj-y :=3D
 common-obj-y :=3D
 chardev-obj-y :=3D
 include $(SRC_PATH)/Makefile.objs
+
+# remove all arch related trace
+trace-obj-y :=3D $(filter-out hw/alpha/trace.o hw/alpha/trace-dtrace.o,$(t=
race-obj-y))
+trace-obj-y :=3D $(filter-out target/alpha/trace.o target/alpha/trace-dtra=
ce.o,$(trace-obj-y))
+
+trace-obj-y :=3D $(filter-out hw/arm/trace.o hw/arm/trace-dtrace.o,$(trace=
-obj-y))
+trace-obj-y :=3D $(filter-out target/arm/trace.o target/arm/trace-dtrace.o=
,$(trace-obj-y))
+
+trace-obj-y :=3D $(filter-out hw/i386/trace.o hw/i386/trace-dtrace.o,$(tra=
ce-obj-y))
+trace-obj-y :=3D $(filter-out target/i386/trace.o target/i386/trace-dtrace=
.o,$(trace-obj-y))
+
+trace-obj-y :=3D $(filter-out hw/mips/trace.o hw/mips/trace-dtrace.o,$(tra=
ce-obj-y))
+trace-obj-y :=3D $(filter-out target/mips/trace.o target/mips/trace-dtrace=
.o,$(trace-obj-y))
+
+trace-obj-y :=3D $(filter-out hw/sparc/trace.o hw/sparc/trace-dtrace.o,$(t=
race-obj-y))
+trace-obj-y :=3D $(filter-out target/sparc/trace.o target/sparc/trace-dtra=
ce.o,$(trace-obj-y))
+
+trace-obj-y :=3D $(filter-out hw/s390x/trace.o hw/s390x/trace-dtrace.o,$(t=
race-obj-y))
+trace-obj-y :=3D $(filter-out target/s390x/trace.o target/s390x/trace-dtra=
ce.o,$(trace-obj-y))
+
+trace-obj-y :=3D $(filter-out hw/ppc/trace.o hw/ppc/trace-dtrace.o,$(trace=
-obj-y))
+trace-obj-y :=3D $(filter-out target/ppc/trace.o target/ppc/trace-dtrace.o=
,$(trace-obj-y))
+
+# add current arch related trace
+carch :=3D $(TARGET_BASE_ARCH)
+ifneq ($(wildcard $(SRC_PATH)/hw/$(carch)/trace-events),)
+trace-obj-y +=3D hw/$(carch)/trace.o
+trace-obj-$(CONFIG_TRACE_DTRACE) +=3D hw/$(carch)/trace-dtrace.o
+endif
+
+ifneq ($(wildcard $(SRC_PATH)/target/$(carch)/trace-events),)
+trace-obj-y +=3D target/$(carch)/trace.o
+trace-obj-$(CONFIG_TRACE_DTRACE) +=3D target/$(carch)/trace-dtrace.o
+endif
+
 dummy :=3D $(call unnest-vars,,target-obj-y)
 target-obj-y-save :=3D $(target-obj-y)
 dummy :=3D $(call unnest-vars,.., \
