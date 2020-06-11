Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0FFC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:51:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D50902074B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gbjuw9o8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D50902074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjUAz-0008G8-4M
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:51:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTAt-0002Uk-IX
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:47:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44702
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTAn-0001Us-CE
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eYVHpNxxw7MWY152CHc9nNx671yGuicGgwNx49IwhrA=;
 b=Gbjuw9o89FROTRw/vXHWEZ/yDpHG9SnJbyXi+/EuUEluByAA9J43cspADtOZp+Jjmj1P7W
 I+fqsTY1wJxtrS62yHifCEPr76VtVIC2GizwIcnJpcP5YbBSEEs758vO9e0XWHRJGgIs/3
 +Tdn08BYD5quiW/ZmNjrIfYVJLV/9w8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-sKt29ZECPAS8MPB9SmrTjQ-1; Thu, 11 Jun 2020 15:46:57 -0400
X-MC-Unique: sKt29ZECPAS8MPB9SmrTjQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA6561005512;
 Thu, 11 Jun 2020 19:46:56 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2A0A560CC0;
 Thu, 11 Jun 2020 19:46:56 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 086/115] target/ppc: Restrict PPCVirtualHypervisorClass to
 system-mode
Date: Thu, 11 Jun 2020 15:44:20 -0400
Message-Id: <20200611194449.31468-87-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 14:52:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

The code related to PPC Virtual Hypervisor is pointless in user-mode.

Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200526172427.17460-5-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/ppc/cpu.h                |  4 ++--
 target/ppc/kvm_ppc.h            | 22 +++++++++++-----------
 target/ppc/translate_init.inc.c |  4 ++++
 3 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 1988b436cb..e7d382ac10 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1202,6 +1202,7 @@ PowerPCCPUClass *ppc_cpu_class_by_pvr(uint32_t pvr);
 PowerPCCPUClass *ppc_cpu_class_by_pvr_mask(uint32_t pvr);
 PowerPCCPUClass *ppc_cpu_get_family_class(PowerPCCPUClass *pcc);
 
+#ifndef CONFIG_USER_ONLY
 struct PPCVirtualHypervisorClass {
     InterfaceClass parent;
     void (*hypercall)(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu);
@@ -1215,10 +1216,8 @@ struct PPCVirtualHypervisorClass {
     void (*hpte_set_r)(PPCVirtualHypervisor *vhyp, hwaddr ptex, uint64_t pte1);
     void (*get_pate)(PPCVirtualHypervisor *vhyp, ppc_v3_pate_t *entry);
     target_ulong (*encode_hpt_for_kvm_pr)(PPCVirtualHypervisor *vhyp);
-#ifndef CONFIG_USER_ONLY
     void (*cpu_exec_enter)(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu);
     void (*cpu_exec_exit)(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu);
-#endif
 };
 
 #define TYPE_PPC_VIRTUAL_HYPERVISOR "ppc-virtual-hypervisor"
@@ -1230,6 +1229,7 @@ struct PPCVirtualHypervisorClass {
 #define PPC_VIRTUAL_HYPERVISOR_GET_CLASS(obj) \
     OBJECT_GET_CLASS(PPCVirtualHypervisorClass, (obj), \
                      TYPE_PPC_VIRTUAL_HYPERVISOR)
+#endif /* CONFIG_USER_ONLY */
 
 void ppc_cpu_do_interrupt(CPUState *cpu);
 bool ppc_cpu_exec_interrupt(CPUState *cpu, int int_req);
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index fcaf745516..701c0c262b 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -280,6 +280,17 @@ static inline bool kvmppc_has_cap_spapr_vfio(void)
     return false;
 }
 
+static inline void kvmppc_read_hptes(ppc_hash_pte64_t *hptes,
+                                     hwaddr ptex, int n)
+{
+    abort();
+}
+
+static inline void kvmppc_write_hpte(hwaddr ptex, uint64_t pte0, uint64_t pte1)
+{
+    abort();
+}
+
 #endif /* !CONFIG_USER_ONLY */
 
 static inline bool kvmppc_has_cap_epr(void)
@@ -310,17 +321,6 @@ static inline int kvmppc_load_htab_chunk(QEMUFile *f, int fd, uint32_t index,
     abort();
 }
 
-static inline void kvmppc_read_hptes(ppc_hash_pte64_t *hptes,
-                                     hwaddr ptex, int n)
-{
-    abort();
-}
-
-static inline void kvmppc_write_hpte(hwaddr ptex, uint64_t pte0, uint64_t pte1)
-{
-    abort();
-}
-
 static inline bool kvmppc_has_cap_fixup_hcalls(void)
 {
     abort();
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 38cb773ab4..a40888411c 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -10942,16 +10942,20 @@ static const TypeInfo ppc_cpu_type_info = {
     .class_init = ppc_cpu_class_init,
 };
 
+#ifndef CONFIG_USER_ONLY
 static const TypeInfo ppc_vhyp_type_info = {
     .name = TYPE_PPC_VIRTUAL_HYPERVISOR,
     .parent = TYPE_INTERFACE,
     .class_size = sizeof(PPCVirtualHypervisorClass),
 };
+#endif
 
 static void ppc_cpu_register_types(void)
 {
     type_register_static(&ppc_cpu_type_info);
+#ifndef CONFIG_USER_ONLY
     type_register_static(&ppc_vhyp_type_info);
+#endif
 }
 
 type_init(ppc_cpu_register_types)
-- 
2.26.2



