Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C657C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:52:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38D10206E9
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b0nKODow"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38D10206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsUM2-0007hm-Fp
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 12:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsUCB-0003RA-P3
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:42:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39307
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsUC8-00035n-Fq
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:42:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594053735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R1+vZEAHkXZ+3r9qbN9gysTqbpARWv/Xkk3DWlAMb3E=;
 b=b0nKODow6cAxIqYb9Tt0cxv1RAb47BTZxUrlKjtc7ZgLyiRlUPmgF8ZKoYBPyQ1Urr9PTg
 rfKkw1xOntr2etxGbZ6l5pGHkiK4zcEsM8oprxMdXmtjVr7AkCQwJ1U2hM6uHRPlnb2B6a
 vvkwq9p46tRjo3qC3TfQ8GTk5ulrGnI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-jT8x8QflM0iKX16V-cpBvQ-1; Mon, 06 Jul 2020 12:42:13 -0400
X-MC-Unique: jT8x8QflM0iKX16V-cpBvQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8775B8010EF;
 Mon,  6 Jul 2020 16:42:12 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 32C2A5BACD;
 Mon,  6 Jul 2020 16:42:12 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/53] i386: hvf: Clean up synchronize functions
Date: Mon,  6 Jul 2020 12:41:20 -0400
Message-Id: <20200706164155.24696-19-pbonzini@redhat.com>
In-Reply-To: <20200706164155.24696-1-pbonzini@redhat.com>
References: <20200706164155.24696-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:22:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Roman Bolshakov <r.bolshakov@yadro.com>, Cameron Esfahani <dirty@apple.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Roman Bolshakov <r.bolshakov@yadro.com>

Make them more concise and consitent with the rest of the code in the
file and drop non-relevant TODO.

Cc: Cameron Esfahani <dirty@apple.com>
Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
Message-Id: <20200630102824.77604-9-r.bolshakov@yadro.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/hvf.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 2a12867ef0..d81f569aed 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -282,47 +282,43 @@ void hvf_handle_io(CPUArchState *env, uint16_t port, void *buffer,
     }
 }
 
-/* TODO: synchronize vcpu state */
 static void do_hvf_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
 {
-    CPUState *cpu_state = cpu;
-    if (cpu_state->vcpu_dirty == 0) {
-        hvf_get_registers(cpu_state);
+    if (!cpu->vcpu_dirty) {
+        hvf_get_registers(cpu);
+        cpu->vcpu_dirty = true;
     }
-
-    cpu_state->vcpu_dirty = 1;
 }
 
-void hvf_cpu_synchronize_state(CPUState *cpu_state)
+void hvf_cpu_synchronize_state(CPUState *cpu)
 {
-    if (cpu_state->vcpu_dirty == 0) {
-        run_on_cpu(cpu_state, do_hvf_cpu_synchronize_state, RUN_ON_CPU_NULL);
+    if (!cpu->vcpu_dirty) {
+        run_on_cpu(cpu, do_hvf_cpu_synchronize_state, RUN_ON_CPU_NULL);
     }
 }
 
-static void do_hvf_cpu_synchronize_post_reset(CPUState *cpu, run_on_cpu_data arg)
+static void do_hvf_cpu_synchronize_post_reset(CPUState *cpu,
+                                              run_on_cpu_data arg)
 {
-    CPUState *cpu_state = cpu;
-    hvf_put_registers(cpu_state);
-    cpu_state->vcpu_dirty = false;
+    hvf_put_registers(cpu);
+    cpu->vcpu_dirty = false;
 }
 
-void hvf_cpu_synchronize_post_reset(CPUState *cpu_state)
+void hvf_cpu_synchronize_post_reset(CPUState *cpu)
 {
-    run_on_cpu(cpu_state, do_hvf_cpu_synchronize_post_reset, RUN_ON_CPU_NULL);
+    run_on_cpu(cpu, do_hvf_cpu_synchronize_post_reset, RUN_ON_CPU_NULL);
 }
 
 static void do_hvf_cpu_synchronize_post_init(CPUState *cpu,
                                              run_on_cpu_data arg)
 {
-    CPUState *cpu_state = cpu;
-    hvf_put_registers(cpu_state);
-    cpu_state->vcpu_dirty = false;
+    hvf_put_registers(cpu);
+    cpu->vcpu_dirty = false;
 }
 
-void hvf_cpu_synchronize_post_init(CPUState *cpu_state)
+void hvf_cpu_synchronize_post_init(CPUState *cpu)
 {
-    run_on_cpu(cpu_state, do_hvf_cpu_synchronize_post_init, RUN_ON_CPU_NULL);
+    run_on_cpu(cpu, do_hvf_cpu_synchronize_post_init, RUN_ON_CPU_NULL);
 }
 
 static void do_hvf_cpu_synchronize_pre_loadvm(CPUState *cpu,
-- 
2.26.2



