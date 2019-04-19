Return-Path: <SRS0=rbQy=SV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25AFC282DA
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 06:24:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C40B5217F9
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 06:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C40B5217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51988 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHMx3-0005Ff-2A
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 02:24:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hHMnM-0005nv-DT
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 02:14:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hHMnL-00055F-BL
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 02:14:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>)
	id 1hHMnJ-00053Y-0I; Fri, 19 Apr 2019 02:14:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3981285550;
	Fri, 19 Apr 2019 06:14:40 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D9CC85C21F;
	Fri, 19 Apr 2019 06:14:38 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 19 Apr 2019 03:14:25 -0300
Message-Id: <20190419061429.17695-4-ehabkost@redhat.com>
In-Reply-To: <20190419061429.17695-1-ehabkost@redhat.com>
References: <20190419061429.17695-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Fri, 19 Apr 2019 06:14:40 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 3/7] arm: Don't split CPU model string
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Igor Mammedov <imammedo@redhat.com>,
	Greg Bellows <greg.bellows@linaro.org>, qemu-arm@nongnu.org,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190419061425.QUjRMtlPlM2ph9H0yDMEq01lKJUpdbtR1AI68R8aydM@z>

CPUClass::class_by_name is called after the CPU model name and
options were already split, there's no need to split the string
again.

Fixes: fb8d6c24b095 ("target-arm: Add CPU property to disable AArch64")
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Greg Bellows <greg.bellows@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org
---
 target/arm/cpu.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 4155782197..6848d9c94d 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1212,22 +1212,17 @@ static ObjectClass *arm_cpu_class_by_name(const char *cpu_model)
 {
     ObjectClass *oc;
     char *typename;
-    char **cpuname;
-    const char *cpunamestr;
 
-    cpuname = g_strsplit(cpu_model, ",", 1);
-    cpunamestr = cpuname[0];
 #ifdef CONFIG_USER_ONLY
     /* For backwards compatibility usermode emulation allows "-cpu any",
      * which has the same semantics as "-cpu max".
      */
-    if (!strcmp(cpunamestr, "any")) {
-        cpunamestr = "max";
+    if (!strcmp(cpu_model, "any")) {
+        cpu_model = "max";
     }
 #endif
-    typename = g_strdup_printf(ARM_CPU_TYPE_NAME("%s"), cpunamestr);
+    typename = g_strdup_printf(ARM_CPU_TYPE_NAME("%s"), cpu_model);
     oc = object_class_by_name(typename);
-    g_strfreev(cpuname);
     g_free(typename);
     if (!oc || !object_class_dynamic_cast(oc, TYPE_ARM_CPU) ||
         object_class_is_abstract(oc)) {
-- 
2.18.0.rc1.1.g3f1ff2140


