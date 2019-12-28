Return-Path: <SRS0=DnLG=2S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25555C2D0C6
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 11:00:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E327A21582
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 11:00:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E327A21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1il9pW-0006Sq-0L
	for qemu-devel@archiver.kernel.org; Sat, 28 Dec 2019 06:00:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57908)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xiaoyao.li@intel.com>) id 1il9os-00062k-KK
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 05:59:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <xiaoyao.li@intel.com>) id 1il9oq-00041M-8s
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 05:59:41 -0500
Received: from mga09.intel.com ([134.134.136.24]:52059)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <xiaoyao.li@intel.com>)
 id 1il9op-0003jD-Sh
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 05:59:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Dec 2019 02:59:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,366,1571727600"; d="scan'208";a="250886854"
Received: from lxy-clx-4s.sh.intel.com ([10.239.43.57])
 by fmsmga002.fm.intel.com with ESMTP; 28 Dec 2019 02:59:33 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v2] accel/kvm: Make "kernel_irqchip" default on
Date: Sat, 28 Dec 2019 18:43:26 +0800
Message-Id: <20191228104326.21732-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.24
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
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 11bc4a13d1f4 ("kvm: convert "-machine kernel_irqchip" to an
accelerator property") moves kernel_irqchip property from "-machine" to
"-accel kvm", but it forgets to set the default value of
kernel_irqchip_allowed and kernel_irqchip_split.

Also cleaning up the three useless members (kernel_irqchip_allowed,
kernel_irqchip_required, kernel_irqchip_split) in struct MachineState.

Fixes: 11bc4a13d1f4 ("kvm: convert "-machine kernel_irqchip" to an accelerator property")
Reported-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
Changes in v2:
  - Add Reported-by tag;
  - Initialize kernel_irqchip_split in init_machine();
---
 accel/kvm/kvm-all.c | 3 +++
 include/hw/boards.h | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index b2f1a5bcb5ef..afbbe0a1af25 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2070,6 +2070,8 @@ static int kvm_init(MachineState *ms)
         goto err;
     }
 
+    s->kernel_irqchip_split = mc->default_kernel_irqchip_split;
+
     if (s->kernel_irqchip_allowed) {
         kvm_irqchip_create(s);
     }
@@ -3046,6 +3048,7 @@ static void kvm_accel_instance_init(Object *obj)
     KVMState *s = KVM_STATE(obj);
 
     s->kvm_shadow_mem = -1;
+    s->kernel_irqchip_allowed = true;
 }
 
 static void kvm_accel_class_init(ObjectClass *oc, void *data)
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 61f8bb8e5a42..fb1b43d5b972 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -271,9 +271,6 @@ struct MachineState {
 
     /*< public >*/
 
-    bool kernel_irqchip_allowed;
-    bool kernel_irqchip_required;
-    bool kernel_irqchip_split;
     char *dtb;
     char *dumpdtb;
     int phandle_start;
-- 
2.19.1


