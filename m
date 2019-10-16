Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B25BC4360C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 09:03:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F04F72168B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 09:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F04F72168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKfD8-0002l1-Ar
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 05:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50378)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1iKf4p-00027i-OR
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 04:54:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1iKf4l-00068z-Sl
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 04:54:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51712)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>)
 id 1iKf4d-00062r-5z; Wed, 16 Oct 2019 04:54:27 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 631ECC04D936;
 Wed, 16 Oct 2019 08:54:26 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 238B55D9CD;
 Wed, 16 Oct 2019 08:54:23 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Subject: [PATCH v6 4/9] target/arm/cpu64: max cpu: Introduce sve<N> properties
Date: Wed, 16 Oct 2019 10:54:03 +0200
Message-Id: <20191016085408.24360-5-drjones@redhat.com>
In-Reply-To: <20191016085408.24360-1-drjones@redhat.com>
References: <20191016085408.24360-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Wed, 16 Oct 2019 08:54:26 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, armbru@redhat.com,
 eric.auger@redhat.com, imammedo@redhat.com, alex.bennee@linaro.org,
 Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce cpu properties to give fine control over SVE vector lengths.
We introduce a property for each valid length up to the current
maximum supported, which is 2048-bits. The properties are named, e.g.
sve128, sve256, sve384, sve512, ..., where the number is the number of
bits. See the updates to docs/arm-cpu-features.rst for a description
of the semantics and for example uses.

Note, as sve-max-vq is still present and we'd like to be able to
support qmp_query_cpu_model_expansion with guests launched with e.g.
-cpu max,sve-max-vq=3D8 on their command lines, then we do allow
sve-max-vq and sve<N> properties to be provided at the same time, but
this is not recommended, and is why sve-max-vq is not mentioned in the
document.  If sve-max-vq is provided then it enables all lengths smaller
than and including the max and disables all lengths larger. It also has
the side-effect that no larger lengths may be enabled and that the max
itself cannot be disabled. Smaller non-power-of-two lengths may,
however, be disabled, e.g. -cpu max,sve-max-vq=3D4,sve384=3Doff provides =
a
guest the vector lengths 128, 256, and 512 bits.

This patch has been co-authored with Richard Henderson, who reworked
the target/arm/cpu64.c changes in order to push all the validation and
auto-enabling/disabling steps into the finalizer, resulting in a nice
LOC reduction.

Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 docs/arm-cpu-features.rst | 168 +++++++++++++++++++++++++++++++--
 include/qemu/bitops.h     |   1 +
 target/arm/cpu.c          |  19 ++++
 target/arm/cpu.h          |  19 ++++
 target/arm/cpu64.c        | 192 ++++++++++++++++++++++++++++++++++++-
 target/arm/helper.c       |  10 +-
 target/arm/monitor.c      |  12 +++
 tests/arm-cpu-features.c  | 194 ++++++++++++++++++++++++++++++++++++++
 8 files changed, 606 insertions(+), 9 deletions(-)

diff --git a/docs/arm-cpu-features.rst b/docs/arm-cpu-features.rst
index c79dcffb5556..2ea4d6e90c02 100644
--- a/docs/arm-cpu-features.rst
+++ b/docs/arm-cpu-features.rst
@@ -48,18 +48,31 @@ block in the script for usage) is used to issue the Q=
MP commands.
       (QEMU) query-cpu-model-expansion type=3Dfull model=3D{"name":"max"=
}
       { "return": {
         "model": { "name": "max", "props": {
-        "pmu": true, "aarch64": true
+        "sve1664": true, "pmu": true, "sve1792": true, "sve1920": true,
+        "sve128": true, "aarch64": true, "sve1024": true, "sve": true,
+        "sve640": true, "sve768": true, "sve1408": true, "sve256": true,
+        "sve1152": true, "sve512": true, "sve384": true, "sve1536": true=
,
+        "sve896": true, "sve1280": true, "sve2048": true
       }}}}
=20
-We see that the `max` CPU type has the `pmu` and `aarch64` CPU features.
-We also see that the CPU features are enabled, as they are all `true`.
+We see that the `max` CPU type has the `pmu`, `aarch64`, `sve`, and many
+`sve<N>` CPU features.  We also see that all the CPU features are
+enabled, as they are all `true`.  (The `sve<N>` CPU features are all
+optional SVE vector lengths (see "SVE CPU Properties").  While with TCG
+all SVE vector lengths can be supported, when KVM is in use it's more
+likely that only a few lengths will be supported, if SVE is supported at
+all.)
=20
 (2) Let's try to disable the PMU::
=20
       (QEMU) query-cpu-model-expansion type=3Dfull model=3D{"name":"max"=
,"props":{"pmu":false}}
       { "return": {
         "model": { "name": "max", "props": {
-        "pmu": false, "aarch64": true
+        "sve1664": true, "pmu": false, "sve1792": true, "sve1920": true,
+        "sve128": true, "aarch64": true, "sve1024": true, "sve": true,
+        "sve640": true, "sve768": true, "sve1408": true, "sve256": true,
+        "sve1152": true, "sve512": true, "sve384": true, "sve1536": true=
,
+        "sve896": true, "sve1280": true, "sve2048": true
       }}}}
=20
 We see it worked, as `pmu` is now `false`.
@@ -75,7 +88,22 @@ We see it worked, as `pmu` is now `false`.
 It looks like this feature is limited to a configuration we do not
 currently have.
=20
-(4) Let's try probing CPU features for the Cortex-A15 CPU type::
+(4) Let's disable `sve` and see what happens to all the optional SVE
+    vector lengths::
+
+      (QEMU) query-cpu-model-expansion type=3Dfull model=3D{"name":"max"=
,"props":{"sve":false}}
+      { "return": {
+        "model": { "name": "max", "props": {
+        "sve1664": false, "pmu": true, "sve1792": false, "sve1920": fals=
e,
+        "sve128": false, "aarch64": true, "sve1024": false, "sve": false=
,
+        "sve640": false, "sve768": false, "sve1408": false, "sve256": fa=
lse,
+        "sve1152": false, "sve512": false, "sve384": false, "sve1536": f=
alse,
+        "sve896": false, "sve1280": false, "sve2048": false
+      }}}}
+
+As expected they are now all `false`.
+
+(5) Let's try probing CPU features for the Cortex-A15 CPU type::
=20
       (QEMU) query-cpu-model-expansion type=3Dfull model=3D{"name":"cort=
ex-a15"}
       {"return": {"model": {"name": "cortex-a15", "props": {"pmu": true}=
}}}
@@ -131,7 +159,133 @@ After determining which CPU features are available =
and supported for a
 given CPU type, then they may be selectively enabled or disabled on the
 QEMU command line with that CPU type::
=20
-  $ qemu-system-aarch64 -M virt -cpu max,pmu=3Doff
+  $ qemu-system-aarch64 -M virt -cpu max,pmu=3Doff,sve=3Don,sve128=3Don,=
sve256=3Don
=20
-The example above disables the PMU for the `max` CPU type.
+The example above disables the PMU and enables the first two SVE vector
+lengths for the `max` CPU type.  Note, the `sve=3Don` isn't actually
+necessary, because, as we observed above with our probe of the `max` CPU
+type, `sve` is already on by default.  Also, based on our probe of
+defaults, it would seem we need to disable many SVE vector lengths, rath=
er
+than only enabling the two we want.  This isn't the case, because, as
+disabling many SVE vector lengths would be quite verbose, the `sve<N>` C=
PU
+properties have special semantics (see "SVE CPU Property Parsing
+Semantics").
+
+SVE CPU Properties
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+There are two types of SVE CPU properties: `sve` and `sve<N>`.  The firs=
t
+is used to enable or disable the entire SVE feature, just as the `pmu`
+CPU property completely enables or disables the PMU.  The second type
+is used to enable or disable specific vector lengths, where `N` is the
+number of bits of the length.  The `sve<N>` CPU properties have special
+dependencies and constraints, see "SVE CPU Property Dependencies and
+Constraints" below.  Additionally, as we want all supported vector lengt=
hs
+to be enabled by default, then, in order to avoid overly verbose command
+lines (command lines full of `sve<N>=3Doff`, for all `N` not wanted), we
+provide the parsing semantics listed in "SVE CPU Property Parsing
+Semantics".
+
+SVE CPU Property Dependencies and Constraints
+---------------------------------------------
+
+  1) At least one vector length must be enabled when `sve` is enabled.
+
+  2) If a vector length `N` is enabled, then all power-of-two vector
+     lengths smaller than `N` must also be enabled.  E.g. if `sve512`
+     is enabled, then the 128-bit and 256-bit vector lengths must also
+     be enabled.
+
+SVE CPU Property Parsing Semantics
+----------------------------------
+
+  1) If SVE is disabled (`sve=3Doff`), then which SVE vector lengths
+     are enabled or disabled is irrelevant to the guest, as the entire
+     SVE feature is disabled and that disables all vector lengths for
+     the guest.  However QEMU will still track any `sve<N>` CPU
+     properties provided by the user.  If later an `sve=3Don` is provide=
d,
+     then the guest will get only the enabled lengths.  If no `sve=3Don`
+     is provided and there are explicitly enabled vector lengths, then
+     an error is generated.
+
+  2) If SVE is enabled (`sve=3Don`), but no `sve<N>` CPU properties are
+     provided, then all supported vector lengths are enabled, including
+     the non-power-of-two lengths.
+
+  3) If SVE is enabled, then an error is generated when attempting to
+     disable the last enabled vector length (see constraint (1) of "SVE
+     CPU Property Dependencies and Constraints").
+
+  4) If one or more vector lengths have been explicitly enabled and at
+     at least one of the dependency lengths of the maximum enabled lengt=
h
+     has been explicitly disabled, then an error is generated (see
+     constraint (2) of "SVE CPU Property Dependencies and Constraints").
+
+  5) If one or more `sve<N>` CPU properties are set `off`, but no `sve<N=
>`,
+     CPU properties are set `on`, then the specified vector lengths are
+     disabled but the default for any unspecified lengths remains enable=
d.
+     Disabling a power-of-two vector length also disables all vector
+     lengths larger than the power-of-two length (see constraint (2) of
+     "SVE CPU Property Dependencies and Constraints").
+
+  6) If one or more `sve<N>` CPU properties are set to `on`, then they
+     are enabled and all unspecified lengths default to disabled, except
+     for the required lengths per constraint (2) of "SVE CPU Property
+     Dependencies and Constraints", which will even be auto-enabled if
+     they were not explicitly enabled.
+
+  7) If SVE was disabled (`sve=3Doff`), allowing all vector lengths to b=
e
+     explicitly disabled (i.e. avoiding the error specified in (3) of
+     "SVE CPU Property Parsing Semantics"), then if later an `sve=3Don` =
is
+     provided an error will be generated.  To avoid this error, one must
+     enable at least one vector length prior to enabling SVE.
+
+SVE CPU Property Examples
+-------------------------
+
+  1) Disable SVE::
+
+     $ qemu-system-aarch64 -M virt -cpu max,sve=3Doff
+
+  2) Implicitly enable all vector lengths for the `max` CPU type::
+
+     $ qemu-system-aarch64 -M virt -cpu max
+
+  3) Only enable the 128-bit vector length::
+
+     $ qemu-system-aarch64 -M virt -cpu max,sve128=3Don
+
+  4) Disable the 512-bit vector length and all larger vector lengths,
+     since 512 is a power-of-two.  This results in all the smaller,
+     uninitialized lengths (128, 256, and 384) defaulting to enabled::
+
+     $ qemu-system-aarch64 -M virt -cpu max,sve512=3Doff
+
+  5) Enable the 128-bit, 256-bit, and 512-bit vector lengths::
+
+     $ qemu-system-aarch64 -M virt -cpu max,sve128=3Don,sve256=3Don,sve5=
12=3Don
+
+  6) The same as (5), but since the 128-bit and 256-bit vector
+     lengths are required for the 512-bit vector length to be enabled,
+     then allow them to be auto-enabled::
+
+     $ qemu-system-aarch64 -M virt -cpu max,sve512=3Don
+
+  7) Do the same as (6), but by first disabling SVE and then re-enabling=
 it::
+
+     $ qemu-system-aarch64 -M virt -cpu max,sve=3Doff,sve512=3Don,sve=3D=
on
+
+  8) Force errors regarding the last vector length::
+
+     $ qemu-system-aarch64 -M virt -cpu max,sve128=3Doff
+     $ qemu-system-aarch64 -M virt -cpu max,sve=3Doff,sve128=3Doff,sve=3D=
on
+
+SVE CPU Property Recommendations
+--------------------------------
+
+The examples in "SVE CPU Property Examples" exhibit many ways to select
+vector lengths which developers may find useful in order to avoid overly
+verbose command lines.  However, the recommended way to select vector
+lengths is to explicitly enable each desired length.  Therefore only
+example's (1), (3), and (5) exhibit recommended uses of the properties.
=20
diff --git a/include/qemu/bitops.h b/include/qemu/bitops.h
index 3f0926cf40ca..ee76552c0622 100644
--- a/include/qemu/bitops.h
+++ b/include/qemu/bitops.h
@@ -20,6 +20,7 @@
 #define BITS_PER_LONG           (sizeof (unsigned long) * BITS_PER_BYTE)
=20
 #define BIT(nr)                 (1UL << (nr))
+#define BIT_ULL(nr)             (1ULL << (nr))
 #define BIT_MASK(nr)            (1UL << ((nr) % BITS_PER_LONG))
 #define BIT_WORD(nr)            ((nr) / BITS_PER_LONG)
 #define BITS_TO_LONGS(nr)       DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(=
long))
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 2a1e95e90df3..48c18871f6ea 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1197,6 +1197,19 @@ static void arm_cpu_finalizefn(Object *obj)
 #endif
 }
=20
+void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp)
+{
+    Error *local_err =3D NULL;
+
+    if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
+        arm_cpu_sve_finalize(cpu, &local_err);
+        if (local_err !=3D NULL) {
+            error_propagate(errp, local_err);
+            return;
+        }
+    }
+}
+
 static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs =3D CPU(dev);
@@ -1253,6 +1266,12 @@ static void arm_cpu_realizefn(DeviceState *dev, Er=
ror **errp)
         return;
     }
=20
+    arm_cpu_finalize_features(cpu, &local_err);
+    if (local_err !=3D NULL) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
     if (arm_feature(env, ARM_FEATURE_AARCH64) &&
         cpu->has_vfp !=3D cpu->has_neon) {
         /*
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 297ad5e47ad8..11162484465a 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -184,8 +184,13 @@ typedef struct {
=20
 #ifdef TARGET_AARCH64
 # define ARM_MAX_VQ    16
+void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp);
+uint32_t arm_cpu_vq_map_next_smaller(ARMCPU *cpu, uint32_t vq);
 #else
 # define ARM_MAX_VQ    1
+static inline void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp) { }
+static inline uint32_t arm_cpu_vq_map_next_smaller(ARMCPU *cpu, uint32_t=
 vq)
+{ return 0; }
 #endif
=20
 typedef struct ARMVectorReg {
@@ -915,6 +920,18 @@ struct ARMCPU {
=20
     /* Used to set the maximum vector length the cpu will support.  */
     uint32_t sve_max_vq;
+
+    /*
+     * In sve_vq_map each set bit is a supported vector length of
+     * (bit-number + 1) * 16 bytes, i.e. each bit number + 1 is the vect=
or
+     * length in quadwords.
+     *
+     * While processing properties during initialization, corresponding
+     * sve_vq_init bits are set for bits in sve_vq_map that have been
+     * set by properties.
+     */
+    DECLARE_BITMAP(sve_vq_map, ARM_MAX_VQ);
+    DECLARE_BITMAP(sve_vq_init, ARM_MAX_VQ);
 };
=20
 void arm_cpu_post_init(Object *obj);
@@ -1834,6 +1851,8 @@ static inline int arm_feature(CPUARMState *env, int=
 feature)
     return (env->features & (1ULL << feature)) !=3D 0;
 }
=20
+void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp);
+
 #if !defined(CONFIG_USER_ONLY)
 /* Return true if exception levels below EL3 are in secure state,
  * or would be following an exception return to that level.
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 89a8ae77fe84..34b0ba2cf6f7 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -256,6 +256,151 @@ static void aarch64_a72_initfn(Object *obj)
     define_arm_cp_regs(cpu, cortex_a72_a57_a53_cp_reginfo);
 }
=20
+void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
+{
+    /*
+     * If any vector lengths are explicitly enabled with sve<N> properti=
es,
+     * then all other lengths are implicitly disabled.  If sve-max-vq is
+     * specified then it is the same as explicitly enabling all lengths
+     * up to and including the specified maximum, which means all larger
+     * lengths will be implicitly disabled.  If no sve<N> properties
+     * are enabled and sve-max-vq is not specified, then all lengths not
+     * explicitly disabled will be enabled.  Additionally, all power-of-=
two
+     * vector lengths less than the maximum enabled length will be
+     * automatically enabled and all vector lengths larger than the larg=
est
+     * disabled power-of-two vector length will be automatically disable=
d.
+     * Errors are generated if the user provided input that interferes w=
ith
+     * any of the above.  Finally, if SVE is not disabled, then at least=
 one
+     * vector length must be enabled.
+     */
+    DECLARE_BITMAP(tmp, ARM_MAX_VQ);
+    uint32_t vq, max_vq =3D 0;
+
+    /*
+     * Process explicit sve<N> properties.
+     * From the properties, sve_vq_map<N> implies sve_vq_init<N>.
+     * Check first for any sve<N> enabled.
+     */
+    if (!bitmap_empty(cpu->sve_vq_map, ARM_MAX_VQ)) {
+        max_vq =3D find_last_bit(cpu->sve_vq_map, ARM_MAX_VQ) + 1;
+
+        if (cpu->sve_max_vq && max_vq > cpu->sve_max_vq) {
+            error_setg(errp, "cannot enable sve%d", max_vq * 128);
+            error_append_hint(errp, "sve%d is larger than the maximum ve=
ctor "
+                              "length, sve-max-vq=3D%d (%d bits)\n",
+                              max_vq * 128, cpu->sve_max_vq,
+                              cpu->sve_max_vq * 128);
+            return;
+        }
+
+        /* Propagate enabled bits down through required powers-of-two. *=
/
+        for (vq =3D pow2floor(max_vq); vq >=3D 1; vq >>=3D 1) {
+            if (!test_bit(vq - 1, cpu->sve_vq_init)) {
+                set_bit(vq - 1, cpu->sve_vq_map);
+            }
+        }
+    } else if (cpu->sve_max_vq =3D=3D 0) {
+        /*
+         * No explicit bits enabled, and no implicit bits from sve-max-v=
q.
+         */
+        if (!cpu_isar_feature(aa64_sve, cpu)) {
+            /* SVE is disabled and so are all vector lengths.  Good. */
+            return;
+        }
+
+        /* Disabling a power-of-two disables all larger lengths. */
+        if (test_bit(0, cpu->sve_vq_init)) {
+            error_setg(errp, "cannot disable sve128");
+            error_append_hint(errp, "Disabling sve128 results in all vec=
tor "
+                              "lengths being disabled.\n");
+            error_append_hint(errp, "With SVE enabled, at least one vect=
or "
+                              "length must be enabled.\n");
+            return;
+        }
+        for (vq =3D 2; vq <=3D ARM_MAX_VQ; vq <<=3D 1) {
+            if (test_bit(vq - 1, cpu->sve_vq_init)) {
+                break;
+            }
+        }
+        max_vq =3D vq <=3D ARM_MAX_VQ ? vq - 1 : ARM_MAX_VQ;
+
+        bitmap_complement(cpu->sve_vq_map, cpu->sve_vq_init, max_vq);
+        max_vq =3D find_last_bit(cpu->sve_vq_map, max_vq) + 1;
+    }
+
+    /*
+     * Process the sve-max-vq property.
+     * Note that we know from the above that no bit above
+     * sve-max-vq is currently set.
+     */
+    if (cpu->sve_max_vq !=3D 0) {
+        max_vq =3D cpu->sve_max_vq;
+
+        if (!test_bit(max_vq - 1, cpu->sve_vq_map) &&
+            test_bit(max_vq - 1, cpu->sve_vq_init)) {
+            error_setg(errp, "cannot disable sve%d", max_vq * 128);
+            error_append_hint(errp, "The maximum vector length must be "
+                              "enabled, sve-max-vq=3D%d (%d bits)\n",
+                              max_vq, max_vq * 128);
+            return;
+        }
+
+        /* Set all bits not explicitly set within sve-max-vq. */
+        bitmap_complement(tmp, cpu->sve_vq_init, max_vq);
+        bitmap_or(cpu->sve_vq_map, cpu->sve_vq_map, tmp, max_vq);
+    }
+
+    /*
+     * We should know what max-vq is now.  Also, as we're done
+     * manipulating sve-vq-map, we ensure any bits above max-vq
+     * are clear, just in case anybody looks.
+     */
+    assert(max_vq !=3D 0);
+    bitmap_clear(cpu->sve_vq_map, max_vq, ARM_MAX_VQ - max_vq);
+
+    /* Ensure all required powers-of-two are enabled. */
+    for (vq =3D pow2floor(max_vq); vq >=3D 1; vq >>=3D 1) {
+        if (!test_bit(vq - 1, cpu->sve_vq_map)) {
+            error_setg(errp, "cannot disable sve%d", vq * 128);
+            error_append_hint(errp, "sve%d is required as it "
+                              "is a power-of-two length smaller than "
+                              "the maximum, sve%d\n",
+                              vq * 128, max_vq * 128);
+            return;
+        }
+    }
+
+    /*
+     * Now that we validated all our vector lengths, the only question
+     * left to answer is if we even want SVE at all.
+     */
+    if (!cpu_isar_feature(aa64_sve, cpu)) {
+        error_setg(errp, "cannot enable sve%d", max_vq * 128);
+        error_append_hint(errp, "SVE must be enabled to enable vector "
+                          "lengths.\n");
+        error_append_hint(errp, "Add sve=3Don to the CPU property list.\=
n");
+        return;
+    }
+
+    /* From now on sve_max_vq is the actual maximum supported length. */
+    cpu->sve_max_vq =3D max_vq;
+}
+
+uint32_t arm_cpu_vq_map_next_smaller(ARMCPU *cpu, uint32_t vq)
+{
+    uint32_t bitnum;
+
+    /*
+     * We allow vq =3D=3D ARM_MAX_VQ + 1 to be input because the caller =
may want
+     * to find the maximum vq enabled, which may be ARM_MAX_VQ, but this
+     * function always returns the next smaller than the input.
+     */
+    assert(vq && vq <=3D ARM_MAX_VQ + 1);
+
+    bitnum =3D find_last_bit(cpu->sve_vq_map, vq - 1);
+    return bitnum =3D=3D vq - 1 ? 0 : bitnum + 1;
+}
+
 static void cpu_max_get_sve_max_vq(Object *obj, Visitor *v, const char *=
name,
                                    void *opaque, Error **errp)
 {
@@ -287,6 +432,44 @@ static void cpu_max_set_sve_max_vq(Object *obj, Visi=
tor *v, const char *name,
     error_propagate(errp, err);
 }
=20
+static void cpu_arm_get_sve_vq(Object *obj, Visitor *v, const char *name=
,
+                               void *opaque, Error **errp)
+{
+    ARMCPU *cpu =3D ARM_CPU(obj);
+    uint32_t vq =3D atoi(&name[3]) / 128;
+    bool value;
+
+    /* All vector lengths are disabled when SVE is off. */
+    if (!cpu_isar_feature(aa64_sve, cpu)) {
+        value =3D false;
+    } else {
+        value =3D test_bit(vq - 1, cpu->sve_vq_map);
+    }
+    visit_type_bool(v, name, &value, errp);
+}
+
+static void cpu_arm_set_sve_vq(Object *obj, Visitor *v, const char *name=
,
+                               void *opaque, Error **errp)
+{
+    ARMCPU *cpu =3D ARM_CPU(obj);
+    uint32_t vq =3D atoi(&name[3]) / 128;
+    Error *err =3D NULL;
+    bool value;
+
+    visit_type_bool(v, name, &value, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    if (value) {
+        set_bit(vq - 1, cpu->sve_vq_map);
+    } else {
+        clear_bit(vq - 1, cpu->sve_vq_map);
+    }
+    set_bit(vq - 1, cpu->sve_vq_init);
+}
+
 static void cpu_arm_get_sve(Object *obj, Visitor *v, const char *name,
                             void *opaque, Error **errp)
 {
@@ -323,6 +506,7 @@ static void cpu_arm_set_sve(Object *obj, Visitor *v, =
const char *name,
 static void aarch64_max_initfn(Object *obj)
 {
     ARMCPU *cpu =3D ARM_CPU(obj);
+    uint32_t vq;
=20
     if (kvm_enabled()) {
         kvm_arm_set_cpu_features_from_host(cpu);
@@ -426,11 +610,17 @@ static void aarch64_max_initfn(Object *obj)
         cpu->dcz_blocksize =3D 7; /*  512 bytes */
 #endif
=20
-        cpu->sve_max_vq =3D ARM_MAX_VQ;
         object_property_add(obj, "sve-max-vq", "uint32", cpu_max_get_sve=
_max_vq,
                             cpu_max_set_sve_max_vq, NULL, NULL, &error_f=
atal);
         object_property_add(obj, "sve", "bool", cpu_arm_get_sve,
                             cpu_arm_set_sve, NULL, NULL, &error_fatal);
+
+        for (vq =3D 1; vq <=3D ARM_MAX_VQ; ++vq) {
+            char name[8];
+            sprintf(name, "sve%d", vq * 128);
+            object_property_add(obj, name, "bool", cpu_arm_get_sve_vq,
+                                cpu_arm_set_sve_vq, NULL, NULL, &error_f=
atal);
+        }
     }
 }
=20
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0d9a2d2ab745..602b85b40cee 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5351,6 +5351,13 @@ int sve_exception_el(CPUARMState *env, int el)
     return 0;
 }
=20
+static uint32_t sve_zcr_get_valid_len(ARMCPU *cpu, uint32_t start_len)
+{
+    uint32_t start_vq =3D (start_len & 0xf) + 1;
+
+    return arm_cpu_vq_map_next_smaller(cpu, start_vq + 1) - 1;
+}
+
 /*
  * Given that SVE is enabled, return the vector length for EL.
  */
@@ -5368,7 +5375,8 @@ uint32_t sve_zcr_len_for_el(CPUARMState *env, int e=
l)
     if (arm_feature(env, ARM_FEATURE_EL3)) {
         zcr_len =3D MIN(zcr_len, 0xf & (uint32_t)env->vfp.zcr_el[3]);
     }
-    return zcr_len;
+
+    return sve_zcr_get_valid_len(cpu, zcr_len);
 }
=20
 static void zcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
diff --git a/target/arm/monitor.c b/target/arm/monitor.c
index 2209b27b9a08..fa054f8a369c 100644
--- a/target/arm/monitor.c
+++ b/target/arm/monitor.c
@@ -90,6 +90,8 @@ GICCapabilityList *qmp_query_gic_capabilities(Error **e=
rrp)
     return head;
 }
=20
+QEMU_BUILD_BUG_ON(ARM_MAX_VQ > 16);
+
 /*
  * These are cpu model features we want to advertise. The order here
  * matters as this is the order in which qmp_query_cpu_model_expansion
@@ -98,6 +100,9 @@ GICCapabilityList *qmp_query_gic_capabilities(Error **=
errp)
  */
 static const char *cpu_model_advertised_features[] =3D {
     "aarch64", "pmu", "sve",
+    "sve128", "sve256", "sve384", "sve512",
+    "sve640", "sve768", "sve896", "sve1024", "sve1152", "sve1280",
+    "sve1408", "sve1536", "sve1664", "sve1792", "sve1920", "sve2048",
     NULL
 };
=20
@@ -186,6 +191,9 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(=
CpuModelExpansionType type,
         if (!err) {
             visit_check_struct(visitor, &err);
         }
+        if (!err) {
+            arm_cpu_finalize_features(ARM_CPU(obj), &err);
+        }
         visit_end_struct(visitor, NULL);
         visit_free(visitor);
         if (err) {
@@ -193,6 +201,10 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion=
(CpuModelExpansionType type,
             error_propagate(errp, err);
             return NULL;
         }
+    } else {
+        Error *err =3D NULL;
+        arm_cpu_finalize_features(ARM_CPU(obj), &err);
+        assert(err =3D=3D NULL);
     }
=20
     expansion_info =3D g_new0(CpuModelExpansionInfo, 1);
diff --git a/tests/arm-cpu-features.c b/tests/arm-cpu-features.c
index 202bc0e3e823..0190148260dc 100644
--- a/tests/arm-cpu-features.c
+++ b/tests/arm-cpu-features.c
@@ -9,10 +9,17 @@
  * See the COPYING file in the top-level directory.
  */
 #include "qemu/osdep.h"
+#include "qemu/bitops.h"
 #include "libqtest.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qjson.h"
=20
+/*
+ * We expect the SVE max-vq to be 16. Also it must be <=3D 64
+ * for our test code, otherwise 'vls' can't just be a uint64_t.
+ */
+#define SVE_MAX_VQ 16
+
 #define MACHINE    "-machine virt,gic-version=3Dmax "
 #define QUERY_HEAD "{ 'execute': 'query-cpu-model-expansion', " \
                      "'arguments': { 'type': 'full', "
@@ -157,6 +164,183 @@ static void assert_bad_props(QTestState *qts, const=
 char *cpu_type)
     qobject_unref(resp);
 }
=20
+static uint64_t resp_get_sve_vls(QDict *resp)
+{
+    QDict *props;
+    const QDictEntry *e;
+    uint64_t vls =3D 0;
+    int n =3D 0;
+
+    g_assert(resp);
+    g_assert(resp_has_props(resp));
+
+    props =3D resp_get_props(resp);
+
+    for (e =3D qdict_first(props); e; e =3D qdict_next(props, e)) {
+        if (strlen(e->key) > 3 && !strncmp(e->key, "sve", 3) &&
+            g_ascii_isdigit(e->key[3])) {
+            char *endptr;
+            int bits;
+
+            bits =3D g_ascii_strtoll(&e->key[3], &endptr, 10);
+            if (!bits || *endptr !=3D '\0') {
+                continue;
+            }
+
+            if (qdict_get_bool(props, e->key)) {
+                vls |=3D BIT_ULL((bits / 128) - 1);
+            }
+            ++n;
+        }
+    }
+
+    g_assert(n =3D=3D SVE_MAX_VQ);
+
+    return vls;
+}
+
+#define assert_sve_vls(qts, cpu_type, expected_vls, fmt, ...)          \
+({                                                                     \
+    QDict *_resp =3D do_query(qts, cpu_type, fmt, ##__VA_ARGS__);       =
 \
+    g_assert(_resp);                                                   \
+    g_assert(resp_has_props(_resp));                                   \
+    g_assert(resp_get_sve_vls(_resp) =3D=3D expected_vls);              =
   \
+    qobject_unref(_resp);                                              \
+})
+
+static void sve_tests_default(QTestState *qts, const char *cpu_type)
+{
+    /*
+     * With no sve-max-vq or sve<N> properties on the command line
+     * the default is to have all vector lengths enabled. This also
+     * tests that 'sve' is 'on' by default.
+     */
+    assert_sve_vls(qts, cpu_type, BIT_ULL(SVE_MAX_VQ) - 1, NULL);
+
+    /* With SVE off, all vector lengths should also be off. */
+    assert_sve_vls(qts, cpu_type, 0, "{ 'sve': false }");
+
+    /* With SVE on, we must have at least one vector length enabled. */
+    assert_error(qts, cpu_type, "cannot disable sve128", "{ 'sve128': fa=
lse }");
+
+    /* Basic enable/disable tests. */
+    assert_sve_vls(qts, cpu_type, 0x7, "{ 'sve384': true }");
+    assert_sve_vls(qts, cpu_type, ((BIT_ULL(SVE_MAX_VQ) - 1) & ~BIT_ULL(=
2)),
+                   "{ 'sve384': false }");
+
+    /*
+     * -----------------------------------------------------------------=
----
+     *               power-of-two(vq)   all-power-            can      c=
an
+     *                                  of-two(< vq)        enable   dis=
able
+     * -----------------------------------------------------------------=
----
+     * vq < max_vq      no                MUST*              yes      ye=
s
+     * vq < max_vq      yes               MUST*              yes      no
+     * -----------------------------------------------------------------=
----
+     * vq =3D=3D max_vq     n/a               MUST*              yes**  =
  yes**
+     * -----------------------------------------------------------------=
----
+     * vq > max_vq      n/a               no                 no       ye=
s
+     * vq > max_vq      n/a               yes                yes      ye=
s
+     * -----------------------------------------------------------------=
----
+     *
+     * [*] "MUST" means this requirement must already be satisfied,
+     *     otherwise 'max_vq' couldn't itself be enabled.
+     *
+     * [**] Not testable with the QMP interface, only with the command l=
ine.
+     */
+
+    /* max_vq :=3D 8 */
+    assert_sve_vls(qts, cpu_type, 0x8b, "{ 'sve1024': true }");
+
+    /* max_vq :=3D 8, vq < max_vq, !power-of-two(vq) */
+    assert_sve_vls(qts, cpu_type, 0x8f,
+                   "{ 'sve1024': true, 'sve384': true }");
+    assert_sve_vls(qts, cpu_type, 0x8b,
+                   "{ 'sve1024': true, 'sve384': false }");
+
+    /* max_vq :=3D 8, vq < max_vq, power-of-two(vq) */
+    assert_sve_vls(qts, cpu_type, 0x8b,
+                   "{ 'sve1024': true, 'sve256': true }");
+    assert_error(qts, cpu_type, "cannot disable sve256",
+                 "{ 'sve1024': true, 'sve256': false }");
+
+    /* max_vq :=3D 3, vq > max_vq, !all-power-of-two(< vq) */
+    assert_error(qts, cpu_type, "cannot disable sve512",
+                 "{ 'sve384': true, 'sve512': false, 'sve640': true }");
+
+    /*
+     * We can disable power-of-two vector lengths when all larger length=
s
+     * are also disabled. We only need to disable the power-of-two lengt=
h,
+     * as all non-enabled larger lengths will then be auto-disabled.
+     */
+    assert_sve_vls(qts, cpu_type, 0x7, "{ 'sve512': false }");
+
+    /* max_vq :=3D 3, vq > max_vq, all-power-of-two(< vq) */
+    assert_sve_vls(qts, cpu_type, 0x1f,
+                   "{ 'sve384': true, 'sve512': true, 'sve640': true }")=
;
+    assert_sve_vls(qts, cpu_type, 0xf,
+                   "{ 'sve384': true, 'sve512': true, 'sve640': false }"=
);
+}
+
+static void sve_tests_sve_max_vq_8(const void *data)
+{
+    QTestState *qts;
+
+    qts =3D qtest_init(MACHINE "-cpu max,sve-max-vq=3D8");
+
+    assert_sve_vls(qts, "max", BIT_ULL(8) - 1, NULL);
+
+    /*
+     * Disabling the max-vq set by sve-max-vq is not allowed, but
+     * of course enabling it is OK.
+     */
+    assert_error(qts, "max", "cannot disable sve1024", "{ 'sve1024': fal=
se }");
+    assert_sve_vls(qts, "max", 0xff, "{ 'sve1024': true }");
+
+    /*
+     * Enabling anything larger than max-vq set by sve-max-vq is not
+     * allowed, but of course disabling everything larger is OK.
+     */
+    assert_error(qts, "max", "cannot enable sve1152", "{ 'sve1152': true=
 }");
+    assert_sve_vls(qts, "max", 0xff, "{ 'sve1152': false }");
+
+    /*
+     * We can enable/disable non power-of-two lengths smaller than the
+     * max-vq set by sve-max-vq, but, while we can enable power-of-two
+     * lengths, we can't disable them.
+     */
+    assert_sve_vls(qts, "max", 0xff, "{ 'sve384': true }");
+    assert_sve_vls(qts, "max", 0xfb, "{ 'sve384': false }");
+    assert_sve_vls(qts, "max", 0xff, "{ 'sve256': true }");
+    assert_error(qts, "max", "cannot disable sve256", "{ 'sve256': false=
 }");
+
+    qtest_quit(qts);
+}
+
+static void sve_tests_sve_off(const void *data)
+{
+    QTestState *qts;
+
+    qts =3D qtest_init(MACHINE "-cpu max,sve=3Doff");
+
+    /* SVE is off, so the map should be empty. */
+    assert_sve_vls(qts, "max", 0, NULL);
+
+    /* The map stays empty even if we turn lengths off. */
+    assert_sve_vls(qts, "max", 0, "{ 'sve128': false }");
+
+    /* It's an error to enable lengths when SVE is off. */
+    assert_error(qts, "max", "cannot enable sve128", "{ 'sve128': true }=
");
+
+    /* With SVE re-enabled we should get all vector lengths enabled. */
+    assert_sve_vls(qts, "max", BIT_ULL(SVE_MAX_VQ) - 1, "{ 'sve': true }=
");
+
+    /* Or enable SVE with just specific vector lengths. */
+    assert_sve_vls(qts, "max", 0x3,
+                   "{ 'sve': true, 'sve128': true, 'sve256': true }");
+
+    qtest_quit(qts);
+}
+
 static void test_query_cpu_model_expansion(const void *data)
 {
     QTestState *qts;
@@ -180,9 +364,12 @@ static void test_query_cpu_model_expansion(const voi=
d *data)
     if (g_str_equal(qtest_get_arch(), "aarch64")) {
         assert_has_feature(qts, "max", "aarch64");
         assert_has_feature(qts, "max", "sve");
+        assert_has_feature(qts, "max", "sve128");
         assert_has_feature(qts, "cortex-a57", "pmu");
         assert_has_feature(qts, "cortex-a57", "aarch64");
=20
+        sve_tests_default(qts, "max");
+
         /* Test that features that depend on KVM generate errors without=
. */
         assert_error(qts, "max",
                      "'aarch64' feature cannot be disabled "
@@ -234,6 +421,13 @@ int main(int argc, char **argv)
     qtest_add_data_func("/arm/query-cpu-model-expansion",
                         NULL, test_query_cpu_model_expansion);
=20
+    if (g_str_equal(qtest_get_arch(), "aarch64")) {
+        qtest_add_data_func("/arm/max/query-cpu-model-expansion/sve-max-=
vq-8",
+                            NULL, sve_tests_sve_max_vq_8);
+        qtest_add_data_func("/arm/max/query-cpu-model-expansion/sve-off"=
,
+                            NULL, sve_tests_sve_off);
+    }
+
     if (kvm_available) {
         qtest_add_data_func("/arm/kvm/query-cpu-model-expansion",
                             NULL, test_query_cpu_model_expansion_kvm);
--=20
2.21.0


