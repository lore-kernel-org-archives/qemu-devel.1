Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69330C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:49:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F49B205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ahlQWJeJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F49B205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDxbn-0008Nu-DM
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 17:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42153)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jDxHT-0003QR-D0
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jDxHS-0003tw-1g
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:15 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:39623)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jDxHR-0003r9-RU
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584394093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PpGvtNCDlQfH6rOIsiKSImKl8aq6C5B4SOcZrIHugE4=;
 b=ahlQWJeJebsiF1T/zxI5U1+D7s7hUaTC7/UPmzhHeSG/iuKrKif4HvSVFIWc8jaIEa/XVZ
 2nLxUZJ8SH6grh7nhERcAr4f+4+XRvJHc78zYv/AjIFYZ3B+tkmDH4U5Z0vQrkDm3ai4E2
 ZdEIQTYL+9uwxTqxjSbJ1GhHAOQp01s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-cdlhqBcxMbCwnDWozQgwlA-1; Mon, 16 Mar 2020 17:28:11 -0400
X-MC-Unique: cdlhqBcxMbCwnDWozQgwlA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1248B180454D;
 Mon, 16 Mar 2020 21:28:10 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1D25719C4F;
 Mon, 16 Mar 2020 21:28:08 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 22/61] WHPX: Use proper synchronization primitives while
 processing
Date: Mon, 16 Mar 2020 22:26:49 +0100
Message-Id: <1584394048-44994-23-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
References: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Sunil Muthuswamy <sunilmut@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sunil Muthuswamy <sunilmut@microsoft.com>

WHPX wasn't using the proper synchronization primitives while
processing async events, which can cause issues with SMP.

Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx-all.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index cb863b7..c78baac 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -905,9 +905,8 @@ static void whpx_vcpu_process_async_events(CPUState *cp=
u)
=20
     if ((cpu->interrupt_request & CPU_INTERRUPT_INIT) &&
         !(env->hflags & HF_SMM_MASK)) {
-
+        whpx_cpu_synchronize_state(cpu);
         do_cpu_init(x86_cpu);
-        cpu->vcpu_dirty =3D true;
         vcpu->interruptable =3D true;
     }
=20
@@ -923,17 +922,13 @@ static void whpx_vcpu_process_async_events(CPUState *=
cpu)
     }
=20
     if (cpu->interrupt_request & CPU_INTERRUPT_SIPI) {
-        if (!cpu->vcpu_dirty) {
-            whpx_get_registers(cpu);
-        }
+        whpx_cpu_synchronize_state(cpu);
         do_cpu_sipi(x86_cpu);
     }
=20
     if (cpu->interrupt_request & CPU_INTERRUPT_TPR) {
         cpu->interrupt_request &=3D ~CPU_INTERRUPT_TPR;
-        if (!cpu->vcpu_dirty) {
-            whpx_get_registers(cpu);
-        }
+        whpx_cpu_synchronize_state(cpu);
         apic_handle_tpr_access_report(x86_cpu->apic_state, env->eip,
                                       env->tpr_access_type);
     }
@@ -1125,8 +1120,10 @@ static int whpx_vcpu_run(CPUState *cpu)
=20
 static void do_whpx_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data a=
rg)
 {
-    whpx_get_registers(cpu);
-    cpu->vcpu_dirty =3D true;
+    if (!cpu->vcpu_dirty) {
+        whpx_get_registers(cpu);
+        cpu->vcpu_dirty =3D true;
+    }
 }
=20
 static void do_whpx_cpu_synchronize_post_reset(CPUState *cpu,
--=20
1.8.3.1



