Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D446EC2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 07:29:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A000F206D3
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 07:29:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A000F206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijIA8-0005oa-Lg
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 02:29:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44387)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1ijI9Y-0005Pr-Fc
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 02:29:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1ijI9X-0001up-7h
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 02:29:20 -0500
Received: from relay.sw.ru ([185.231.240.75]:40470)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1ijI9X-0001hj-00
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 02:29:19 -0500
Received: from dptest2.qa.sw.ru ([10.94.4.71])
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <dplotnikov@virtuozzo.com>)
 id 1ijI9G-0000hc-VF; Mon, 23 Dec 2019 10:29:03 +0300
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1] hw: fix using 4.2 compat in 5.0 machine types for
 i440fx/q35
Date: Mon, 23 Dec 2019 10:28:56 +0300
Message-Id: <20191223072856.5369-1-dplotnikov@virtuozzo.com>
X-Mailer: git-send-email 2.17.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
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
Cc: ehabkost@redhat.com, mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

5.0 machine type uses 4.2 compats. This seems to be incorrect, since
the latests machine type by now is 5.0 and it should use its own
compat or shouldn't use any relying on the defaults.
Seems, like this appeared because of some problems on merge/rebase.

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 hw/i386/pc_piix.c | 1 -
 hw/i386/pc_q35.c  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index ffb30c32ce..846e70bc55 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -431,7 +431,6 @@ static void pc_i440fx_5_0_machine_options(MachineClass *m)
     m->alias = "pc";
     m->is_default = 1;
     pcmc->default_cpu_version = 1;
-    compat_props_add(m->compat_props, hw_compat_4_2, hw_compat_4_2_len);
 }
 
 DEFINE_I440FX_MACHINE(v5_0, "pc-i440fx-5.0", NULL,
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 7398d7baa2..ddd485d608 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -354,7 +354,6 @@ static void pc_q35_5_0_machine_options(MachineClass *m)
     pc_q35_machine_options(m);
     m->alias = "q35";
     pcmc->default_cpu_version = 1;
-    compat_props_add(m->compat_props, hw_compat_4_2, hw_compat_4_2_len);
 }
 
 DEFINE_Q35_MACHINE(v5_0, "pc-q35-5.0", NULL,
-- 
2.17.0


