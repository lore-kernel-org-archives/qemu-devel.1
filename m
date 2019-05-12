Return-Path: <SRS0=55mG=TM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0ADDC04A6B
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2019 08:45:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB5212146F
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2019 08:45:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB5212146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40608 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPk7G-0002Rs-2V
	for qemu-devel@archiver.kernel.org; Sun, 12 May 2019 04:45:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1hPjzZ-0004M6-5u
	for qemu-devel@nongnu.org; Sun, 12 May 2019 04:37:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1hPjzX-0003oK-Kz
	for qemu-devel@nongnu.org; Sun, 12 May 2019 04:37:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>)
	id 1hPjyo-0003PZ-Cz; Sun, 12 May 2019 04:37:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AB1753092662;
	Sun, 12 May 2019 08:37:09 +0000 (UTC)
Received: from kamzik.brq.redhat.com (ovpn-116-87.ams2.redhat.com
	[10.36.116.87])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5168E5D706;
	Sun, 12 May 2019 08:37:05 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Date: Sun, 12 May 2019 10:36:19 +0200
Message-Id: <20190512083624.8916-9-drjones@redhat.com>
In-Reply-To: <20190512083624.8916-1-drjones@redhat.com>
References: <20190512083624.8916-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Sun, 12 May 2019 08:37:09 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 08/13] target/arm/monitor: Add
 query-sve-vector-lengths
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

Provide a QMP interface to query the supported SVE vector lengths.
A migratable guest will need to explicitly specify a valid set of
lengths on the command line and that set can be obtained from the
list returned with this QMP command.

This patch only introduces the QMP command with the TCG implementation.
The result may not yet be correct for KVM. Following patches ensure
the KVM result is correct.

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 qapi/target.json     | 34 ++++++++++++++++++++++++
 target/arm/monitor.c | 62 ++++++++++++++++++++++++++++++++++++++++++++
 tests/qmp-cmd-test.c |  1 +
 3 files changed, 97 insertions(+)

diff --git a/qapi/target.json b/qapi/target.json
index 1d4d54b6002e..ca1e85254780 100644
--- a/qapi/target.json
+++ b/qapi/target.json
@@ -397,6 +397,40 @@
 { 'command': 'query-gic-capabilities', 'returns': ['GICCapability'],
   'if': 'defined(TARGET_ARM)' }
=20
+##
+# @SVEVectorLengths:
+#
+# The struct contains a list of integers where each integer is a valid
+# SVE vector length for a KVM guest on this host. The vector lengths
+# are in quadword (128-bit) units, e.g. '4' means 512 bits (64 bytes).
+#
+# @vls:      list of vector lengths in quadwords.
+#
+# Since: 4.1
+##
+{ 'struct': 'SVEVectorLengths',
+  'data': { 'vls': ['int'] },
+  'if': 'defined(TARGET_ARM)' }
+
+##
+# @query-sve-vector-lengths:
+#
+# This command is ARM-only. It will return a list of SVEVectorLengths
+# objects. The list describes all valid SVE vector length sets.
+#
+# Returns: a list of SVEVectorLengths objects
+#
+# Since: 4.1
+#
+# -> { "execute": "query-sve-vector-lengths" }
+# <- { "return": [ { "vls": [ 1 ] },
+#                  { "vls": [ 1, 2 ] },
+#                  { "vls": [ 1, 2, 4 ] } ] }
+#
+##
+{ 'command': 'query-sve-vector-lengths', 'returns': ['SVEVectorLengths']=
,
+  'if': 'defined(TARGET_ARM)' }
+
 ##
 # @CpuModelExpansionInfo:
 #
diff --git a/target/arm/monitor.c b/target/arm/monitor.c
index 41b32b94b258..8b2afa255c92 100644
--- a/target/arm/monitor.c
+++ b/target/arm/monitor.c
@@ -24,6 +24,7 @@
 #include "hw/boards.h"
 #include "kvm_arm.h"
 #include "qapi/qapi-commands-target.h"
+#include "monitor/hmp-target.h"
=20
 static GICCapability *gic_cap_new(int version)
 {
@@ -82,3 +83,64 @@ GICCapabilityList *qmp_query_gic_capabilities(Error **=
errp)
=20
     return head;
 }
+
+static SVEVectorLengths *qmp_sve_vls_get(void)
+{
+    CPUArchState *env =3D mon_get_cpu_env();
+    ARMCPU *cpu =3D arm_env_get_cpu(env);
+    SVEVectorLengths *vls =3D g_new(SVEVectorLengths, 1);
+    intList **v =3D &vls->vls;
+    int i;
+
+    if (cpu->sve_max_vq =3D=3D 0) {
+        *v =3D g_new0(intList, 1); /* one vl of 0 means none supported *=
/
+        return vls;
+    }
+
+    for (i =3D 1; i <=3D cpu->sve_max_vq; ++i) {
+        *v =3D g_new0(intList, 1);
+        (*v)->value =3D i;
+        v =3D &(*v)->next;
+    }
+
+    return vls;
+}
+
+static SVEVectorLengths *qmp_sve_vls_dup_and_truncate(SVEVectorLengths *=
vls)
+{
+    SVEVectorLengths *trunc_vls;
+    intList **v, *p =3D vls->vls;
+
+    if (!p->next) {
+        return NULL;
+    }
+
+    trunc_vls =3D g_new(SVEVectorLengths, 1);
+    v =3D &trunc_vls->vls;
+
+    for (; p->next; p =3D p->next) {
+        *v =3D g_new0(intList, 1);
+        (*v)->value =3D p->value;
+        v =3D &(*v)->next;
+    }
+
+    return trunc_vls;
+}
+
+SVEVectorLengthsList *qmp_query_sve_vector_lengths(Error **errp)
+{
+    SVEVectorLengthsList *vls_list =3D g_new0(SVEVectorLengthsList, 1);
+    SVEVectorLengths *vls =3D qmp_sve_vls_get();
+
+    while (vls) {
+        vls_list->value =3D vls;
+        vls =3D qmp_sve_vls_dup_and_truncate(vls);
+        if (vls) {
+            SVEVectorLengthsList *next =3D vls_list;
+            vls_list =3D g_new0(SVEVectorLengthsList, 1);
+            vls_list->next =3D next;
+        }
+    }
+
+    return vls_list;
+}
diff --git a/tests/qmp-cmd-test.c b/tests/qmp-cmd-test.c
index 9f5228cd9951..3d714dbc6a4a 100644
--- a/tests/qmp-cmd-test.c
+++ b/tests/qmp-cmd-test.c
@@ -90,6 +90,7 @@ static bool query_is_blacklisted(const char *cmd)
         /* Success depends on target arch: */
         "query-cpu-definitions",  /* arm, i386, ppc, s390x */
         "query-gic-capabilities", /* arm */
+        "query-sve-vector-lengths", /* arm */
         /* Success depends on target-specific build configuration: */
         "query-pci",              /* CONFIG_PCI */
         /* Success depends on launching SEV guest */
--=20
2.20.1


