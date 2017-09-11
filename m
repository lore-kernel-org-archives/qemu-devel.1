Received: from eggs.gnu.org ([2001:4830:134:3::10]:49063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1drQXj-0004N0-Lx
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 11:22:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1drQXf-0000Lm-Kx
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 11:22:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42946)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1drQXf-0000Jc-DA
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 11:22:31 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 11 Sep 2017 17:21:36 +0200
Message-Id: <20170911152150.12535-8-david@redhat.com>
In-Reply-To: <20170911152150.12535-1-david@redhat.com>
References: <20170911152150.12535-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v4 07/21] target/s390x: move some s390x
 typedefs to cpu-qom.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

This allows us to drop inclusion of cpu_models.h in cpu-qom.h, and
prepares for using cpu-qom.h as a s390 specific version of typedefs.h

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu-qom.h    | 5 ++++-
 target/s390x/cpu.h        | 5 +++--
 target/s390x/cpu_models.h | 8 ++++----
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/target/s390x/cpu-qom.h b/target/s390x/cpu-qom.h
index 4e936e7788..2435cd8390 100644
--- a/target/s390x/cpu-qom.h
+++ b/target/s390x/cpu-qom.h
@@ -21,7 +21,6 @@
 #define QEMU_S390_CPU_QOM_H
 
 #include "qom/cpu.h"
-#include "cpu_models.h"
 
 #define TYPE_S390_CPU "s390-cpu"
 
@@ -32,6 +31,9 @@
 #define S390_CPU_GET_CLASS(obj) \
     OBJECT_GET_CLASS(S390CPUClass, (obj), TYPE_S390_CPU)
 
+typedef struct S390CPUModel S390CPUModel;
+typedef struct S390CPUDef S390CPUDef;
+
 /**
  * S390CPUClass:
  * @parent_realize: The parent class' realize handler.
@@ -62,5 +64,6 @@ typedef struct S390CPUClass {
 } S390CPUClass;
 
 typedef struct S390CPU S390CPU;
+typedef struct CPUS390XState CPUS390XState;
 
 #endif
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 372f7d8885..4a0a59dfbc 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -25,6 +25,7 @@
 
 #include "qemu-common.h"
 #include "cpu-qom.h"
+#include "cpu_models.h"
 
 #define TARGET_LONG_BITS 64
 
@@ -80,7 +81,7 @@ typedef struct MchkQueue {
     uint16_t type;
 } MchkQueue;
 
-typedef struct CPUS390XState {
+struct CPUS390XState {
     uint64_t regs[16];     /* GP registers */
     /*
      * The floating point registers are part of the vector registers.
@@ -174,7 +175,7 @@ typedef struct CPUS390XState {
     /* currently processed sigp order */
     uint8_t sigp_order;
 
-} CPUS390XState;
+};
 
 static inline CPU_DoubleU *get_freg(CPUS390XState *cs, int nr)
 {
diff --git a/target/s390x/cpu_models.h b/target/s390x/cpu_models.h
index c0bee15d7a..4c6dee1871 100644
--- a/target/s390x/cpu_models.h
+++ b/target/s390x/cpu_models.h
@@ -17,7 +17,7 @@
 #include "qom/cpu.h"
 
 /* static CPU definition */
-typedef struct S390CPUDef {
+struct S390CPUDef {
     const char *name;       /* name exposed to the user */
     const char *desc;       /* description exposed to the user */
     uint8_t gen;            /* hw generation identification */
@@ -37,10 +37,10 @@ typedef struct S390CPUDef {
     S390FeatBitmap full_feat;
     /* used to init full_feat from generated data */
     S390FeatInit full_init;
-} S390CPUDef;
+};
 
 /* CPU model based on a CPU definition */
-typedef struct S390CPUModel {
+struct S390CPUModel {
     const S390CPUDef *def;
     S390FeatBitmap features;
     /* values copied from the "host" model, can change during migration */
@@ -48,7 +48,7 @@ typedef struct S390CPUModel {
     uint32_t cpu_id;        /* CPU id */
     uint8_t cpu_id_format;  /* CPU id format bit */
     uint8_t cpu_ver;        /* CPU version, usually "ff" for kvm */
-} S390CPUModel;
+};
 
 /*
  * CPU ID
-- 
2.13.5
