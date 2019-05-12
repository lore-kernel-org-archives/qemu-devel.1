Return-Path: <SRS0=55mG=TM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254D7C04A6B
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2019 08:43:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5D732146F
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2019 08:43:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5D732146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40555 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPk4x-0000Nn-4F
	for qemu-devel@archiver.kernel.org; Sun, 12 May 2019 04:43:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1hPjzX-0004Jj-GJ
	for qemu-devel@nongnu.org; Sun, 12 May 2019 04:37:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1hPjzV-0003lU-PB
	for qemu-devel@nongnu.org; Sun, 12 May 2019 04:37:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>)
	id 1hPjzE-0003Z4-U4; Sun, 12 May 2019 04:37:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3C29781F13;
	Sun, 12 May 2019 08:37:36 +0000 (UTC)
Received: from kamzik.brq.redhat.com (ovpn-116-87.ams2.redhat.com
	[10.36.116.87])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 571015D706;
	Sun, 12 May 2019 08:37:30 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Date: Sun, 12 May 2019 10:36:24 +0200
Message-Id: <20190512083624.8916-14-drjones@redhat.com>
In-Reply-To: <20190512083624.8916-1-drjones@redhat.com>
References: <20190512083624.8916-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Sun, 12 May 2019 08:37:36 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 13/13] target/arm/kvm: host cpu: Add support
 for sve-vls-map
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

Allow the host cpu type to enable SVE in guests with the sve-vls-map
cpu property.

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 target/arm/cpu.c   |  1 +
 target/arm/cpu.h   |  2 ++
 target/arm/cpu64.c | 12 +++++++++---
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index ea0e24bba8b6..a5c01ff42c78 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2222,6 +2222,7 @@ static void arm_host_initfn(Object *obj)
     ARMCPU *cpu =3D ARM_CPU(obj);
=20
     kvm_arm_set_cpu_features_from_host(cpu);
+    aarch64_add_sve_vls_map_property(obj);
     arm_cpu_post_init(obj);
 }
=20
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index f0d0ce759ba8..13731ccb39f3 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -976,11 +976,13 @@ int aarch64_cpu_gdb_write_register(CPUState *cpu, u=
int8_t *buf, int reg);
 void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq);
 void aarch64_sve_change_el(CPUARMState *env, int old_el,
                            int new_el, bool el0_a64);
+void aarch64_add_sve_vls_map_property(Object *obj);
 #else
 static inline void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq) =
{ }
 static inline void aarch64_sve_change_el(CPUARMState *env, int o,
                                          int n, bool a)
 { }
+void aarch64_add_sve_vls_map_property(Object *obj) { }
 #endif
=20
 target_ulong do_arm_semihosting(CPUARMState *env);
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 94f3dd5b51e5..3b0b900a4d97 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -310,7 +310,8 @@ static void cpu_set_sve_vls_map(Object *obj, Visitor =
*v, const char *name,
             error_setg(&err, "SVE vector length map has unsupported leng=
ths");
             error_append_hint(&err, "Valid vector lengths in range [1-%d=
]\n",
                               ARM_MAX_VQ);
-        } else if (cpu->sve_max_vq !=3D ARM_MAX_VQ && cpu->sve_max_vq !=3D=
 -1 &&
+        } else if (cpu->sve_max_vq && cpu->sve_max_vq !=3D ARM_MAX_VQ &&
+                   cpu->sve_max_vq !=3D -1 &&
                    cpu->sve_max_vq !=3D arm_cpu_fls64(cpu->sve_vls_map))=
 {
             /*
              * If the user provides both sve-max-vq and sve-vls-map, wit=
h
@@ -340,6 +341,12 @@ static void cpu_set_sve_vls_map(Object *obj, Visitor=
 *v, const char *name,
     error_propagate(errp, err);
 }
=20
+void aarch64_add_sve_vls_map_property(Object *obj)
+{
+    object_property_add(obj, "sve-vls-map", "uint64", cpu_get_sve_vls_ma=
p,
+                        cpu_set_sve_vls_map, NULL, NULL, &error_fatal);
+}
+
 /* -cpu max: if KVM is enabled, like -cpu host (best possible with this =
host);
  * otherwise, a CPU with as many features enabled as our emulation suppo=
rts.
  * The version of '-cpu max' for qemu-system-arm is defined in cpu.c;
@@ -437,8 +444,7 @@ static void aarch64_max_initfn(Object *obj)
=20
     object_property_add(obj, "sve-max-vq", "uint32", cpu_max_get_sve_vq,
                         cpu_max_set_sve_vq, NULL, NULL, &error_fatal);
-    object_property_add(obj, "sve-vls-map", "uint64", cpu_get_sve_vls_ma=
p,
-                        cpu_set_sve_vls_map, NULL, NULL, &error_fatal);
+    aarch64_add_sve_vls_map_property(obj);
 }
=20
 struct ARMCPUInfo {
--=20
2.20.1


