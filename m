Return-Path: <SRS0=55mG=TM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82515C04A6B
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2019 08:51:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 489AF216C4
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2019 08:51:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 489AF216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40678 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPkCf-0006P7-Kv
	for qemu-devel@archiver.kernel.org; Sun, 12 May 2019 04:51:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1hPjza-0004OL-Ps
	for qemu-devel@nongnu.org; Sun, 12 May 2019 04:38:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1hPjzZ-0003ql-7n
	for qemu-devel@nongnu.org; Sun, 12 May 2019 04:37:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>)
	id 1hPjz4-0003VK-5n; Sun, 12 May 2019 04:37:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 75341308427E;
	Sun, 12 May 2019 08:37:25 +0000 (UTC)
Received: from kamzik.brq.redhat.com (ovpn-116-87.ams2.redhat.com
	[10.36.116.87])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 077FA5D706;
	Sun, 12 May 2019 08:37:21 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Date: Sun, 12 May 2019 10:36:22 +0200
Message-Id: <20190512083624.8916-12-drjones@redhat.com>
In-Reply-To: <20190512083624.8916-1-drjones@redhat.com>
References: <20190512083624.8916-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Sun, 12 May 2019 08:37:25 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 11/13] target/arm/cpu64: max cpu: Introduce
 sve-vls-map
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, armbru@redhat.com,
	abologna@redhat.com, alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce another cpu property to control SVE vector lengths,
sve-vls-map, which allows the user to explicitly select the
set of vector lengths the guest can use. The map must conform
to QEMU's limits and architectural constraints, checked when
the property is set. Inconsistencies with sve-max-vq are also
checked. The bit number of a set bit in the map represents the
allowed vector length in number of quadwords.

Note, as the map is implemented with a single 64-bit word we
currently only support up to 8192-bit vectors. As QEMU and
KVM only support up to 2048-bit vectors then this sufficient
now, and probably for some time. Extending the bitmap beyond
a single word will likely require changing the property to
a string and adding yet another parser to QEMU.

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 target/arm/cpu.c     |  4 +++
 target/arm/cpu.h     |  3 ++
 target/arm/cpu64.c   | 70 +++++++++++++++++++++++++++++++++++++++++---
 target/arm/helper.c  | 10 ++++++-
 target/arm/monitor.c |  9 ++++--
 5 files changed, 88 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index a181fa8dc1a7..ea0e24bba8b6 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1188,6 +1188,10 @@ static void arm_cpu_realizefn(DeviceState *dev, Er=
ror **errp)
         set_feature(env, ARM_FEATURE_VBAR);
     }
=20
+    if (!kvm_enabled() && !cpu->sve_vls_map) {
+        cpu->sve_vls_map =3D BIT_MASK(cpu->sve_max_vq) - 1;
+    }
+
     register_cp_regs_for_features(cpu);
     arm_cpu_register_gdb_regs_for_features(cpu);
=20
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 8292d547e8f9..f0d0ce759ba8 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -920,6 +920,9 @@ struct ARMCPU {
=20
     /* Used to set the maximum vector length the cpu will support.  */
     uint32_t sve_max_vq;
+
+    /* Each bit represents a supported vector length of (bitnum * 16) by=
tes */
+    uint64_t sve_vls_map;
 };
=20
 static inline ARMCPU *arm_env_get_cpu(CPUARMState *env)
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 3756e7e2a3e5..9ac702d54136 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -273,14 +273,73 @@ static void cpu_max_set_sve_vq(Object *obj, Visitor=
 *v, const char *name,
=20
     visit_type_uint32(v, name, &cpu->sve_max_vq, &err);
=20
-    if (!err && (cpu->sve_max_vq =3D=3D 0 || cpu->sve_max_vq > ARM_MAX_V=
Q)) {
-        error_setg(&err, "unsupported SVE vector length");
-        error_append_hint(&err, "Valid sve-max-vq in range [1-%d]\n",
-                          ARM_MAX_VQ);
+    if (!err) {
+        if (cpu->sve_max_vq =3D=3D 0 || cpu->sve_max_vq > ARM_MAX_VQ) {
+            error_setg(&err, "unsupported SVE vector length");
+            error_append_hint(&err, "Valid sve-max-vq in range [1-%d]\n"=
,
+                              ARM_MAX_VQ);
+        } else if (cpu->sve_vls_map &&
+                   cpu->sve_max_vq !=3D arm_cpu_fls64(cpu->sve_vls_map))=
 {
+            error_setg(&err, "sve-vls-map and sve-max-vq are inconsisten=
t");
+        }
     }
     error_propagate(errp, err);
 }
=20
+static void cpu_get_sve_vls_map(Object *obj, Visitor *v, const char *nam=
e,
+                                void *opaque, Error **errp)
+{
+    ARMCPU *cpu =3D ARM_CPU(obj);
+    visit_type_uint64(v, name, &cpu->sve_vls_map, errp);
+}
+
+static void cpu_set_sve_vls_map(Object *obj, Visitor *v, const char *nam=
e,
+                                void *opaque, Error **errp)
+{
+    ARMCPU *cpu =3D ARM_CPU(obj);
+    Error *err =3D NULL;
+    uint64_t mask =3D ~(BIT_MASK(ARM_MAX_VQ - 1) - 1);
+    int i;
+
+    visit_type_uint64(v, name, &cpu->sve_vls_map, errp);
+
+    if (!err) {
+        if (cpu->sve_vls_map =3D=3D 0) {
+            error_setg(&err, "SVE vector length map cannot be zero");
+        } else if (cpu->sve_vls_map & mask) {
+            error_setg(&err, "SVE vector length map has unsupported leng=
ths");
+            error_append_hint(&err, "Valid vector lengths in range [1-%d=
]\n",
+                              ARM_MAX_VQ);
+        } else if (cpu->sve_max_vq !=3D ARM_MAX_VQ &&
+                   cpu->sve_max_vq !=3D arm_cpu_fls64(cpu->sve_vls_map))=
 {
+            /*
+             * If the user provides both sve-max-vq and sve-vls-map, wit=
h
+             * sve-max-vq first, then, unless ARM_MAX_VQ is selected for
+             * sve-max-vq, we can catch inconsistencies. If ARM_MAX_VQ w=
as
+             * selected then sve-max-vq will get silently overwritten wi=
th
+             * the max sve-vls-map provides. This is the best we can do
+             * without initially setting sve-max-vq to -1 like we do for=
 KVM.
+             */
+            error_setg(&err, "sve-vls-map and sve-max-vq are inconsisten=
t");
+        } else {
+            cpu->sve_max_vq =3D arm_cpu_fls64(cpu->sve_vls_map);
+            mask =3D 0;
+            for (i =3D 1; i < cpu->sve_max_vq; ++i) {
+                if (is_power_of_2(i)) {
+                    mask |=3D BIT_MASK(i - 1);
+                }
+            }
+            if ((cpu->sve_vls_map & mask) !=3D mask) {
+                error_setg(&err, "SVE vector length map is missing lengt=
hs");
+                error_append_hint(&err, "All power-of-2 vector lengths u=
p to "
+                                  "the max supported length are required=
.\n");
+            }
+        }
+    }
+
+    error_propagate(errp, err);
+}
+
 /* -cpu max: if KVM is enabled, like -cpu host (best possible with this =
host);
  * otherwise, a CPU with as many features enabled as our emulation suppo=
rts.
  * The version of '-cpu max' for qemu-system-arm is defined in cpu.c;
@@ -374,6 +433,9 @@ static void aarch64_max_initfn(Object *obj)
 #endif
=20
         cpu->sve_max_vq =3D ARM_MAX_VQ;
+
+        object_property_add(obj, "sve-vls-map", "uint64", cpu_get_sve_vl=
s_map,
+                            cpu_set_sve_vls_map, NULL, NULL, &error_fata=
l);
     }
=20
     object_property_add(obj, "sve-max-vq", "uint32", cpu_max_get_sve_vq,
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 1e6eb0d0f360..bedec1ea0b27 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5254,12 +5254,20 @@ uint32_t sve_zcr_len_for_el(CPUARMState *env, int=
 el)
 static void zcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                       uint64_t value)
 {
+    ARMCPU *cpu =3D arm_env_get_cpu(env);
     int cur_el =3D arm_current_el(env);
     int old_len =3D sve_zcr_len_for_el(env, cur_el);
     int new_len;
=20
     /* Bits other than [3:0] are RAZ/WI.  */
-    raw_write(env, ri, value & 0xf);
+    value &=3D 0xf;
+
+    if (value && !(BIT_MASK(value) & cpu->sve_vls_map)) {
+        uint64_t map =3D cpu->sve_vls_map & (BIT_MASK(value) - 1);
+        value =3D arm_cpu_fls64(map) - 1;
+    }
+
+    raw_write(env, ri, value);
=20
     /*
      * Because we arrived here, we know both FP and SVE are enabled;
diff --git a/target/arm/monitor.c b/target/arm/monitor.c
index 3e13dd7c7b7a..192012659e36 100644
--- a/target/arm/monitor.c
+++ b/target/arm/monitor.c
@@ -133,9 +133,12 @@ static SVEVectorLengths *qmp_sve_vls_get(void)
     }
=20
     for (i =3D 1; i <=3D cpu->sve_max_vq; ++i) {
-        *v =3D g_new0(intList, 1);
-        (*v)->value =3D i;
-        v =3D &(*v)->next;
+        int bitval =3D (cpu->sve_vls_map >> (i - 1)) & 1;
+        if (bitval) {
+            *v =3D g_new0(intList, 1);
+            (*v)->value =3D i;
+            v =3D &(*v)->next;
+        }
     }
=20
     return vls;
--=20
2.20.1


