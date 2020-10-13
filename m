Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A3EC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 05:14:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B28C220872
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 05:14:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B28C220872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSCe0-0006Rw-NZ
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 01:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weijiang.yang@intel.com>)
 id 1kSCa8-0001vQ-40
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 01:10:40 -0400
Received: from mga11.intel.com ([192.55.52.93]:57350)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weijiang.yang@intel.com>)
 id 1kSCa4-0006ZJ-Ua
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 01:10:39 -0400
IronPort-SDR: doiyPj154vCvC/UTjGrl99Ff/IXP9j1TF9sKDBZhCA150+yp9mZ0Fxlddo/oRrj402TzdUDLO7
 JIbDJ5POVZOw==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="162385627"
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; d="scan'208";a="162385627"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2020 22:10:36 -0700
IronPort-SDR: xJIsFgVqlreC9RLZJeFkGl1y3ZVPYyD92a6kjMelEFUB9f3ViPfvrWq8wFpXbHVDUod6NkUoEn
 WQjt5sYNbsPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; d="scan'208";a="420427134"
Received: from unknown (HELO local-michael-cet-test.sh.intel.com)
 ([10.239.159.128])
 by fmsmga001.fm.intel.com with ESMTP; 12 Oct 2020 22:10:34 -0700
From: Yang Weijiang <weijiang.yang@intel.com>
To: pbonzini@redhat.com, mtosatti@redhat.com, rth@twiddle.net,
 ehabkost@redhat.com, sean.j.christopherson@intel.com, qemu-devel@nongnu.org
Subject: [Qemu-devel][PATCH v6 5/6] x86/cpu: Add CET state support for guest
 migration
Date: Tue, 13 Oct 2020 13:19:34 +0800
Message-Id: <20201013051935.6052-6-weijiang.yang@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20201013051935.6052-1-weijiang.yang@intel.com>
References: <20201013051935.6052-1-weijiang.yang@intel.com>
Received-SPF: pass client-ip=192.55.52.93;
 envelope-from=weijiang.yang@intel.com; helo=mga11.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 01:10:25
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Yang Weijiang <weijiang.yang@intel.com>, hao.wu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Save the MSRs being used on source machine and restore them
on destination machine.

Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
---
 target/i386/machine.c | 161 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 161 insertions(+)

diff --git a/target/i386/machine.c b/target/i386/machine.c
index b1acf7d0ef..fe4692eaa8 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -962,6 +962,159 @@ static const VMStateDescription vmstate_umwait = {
     }
 };
 
+static bool u_cet_needed(void *opaque)
+{
+    X86CPU *cpu = opaque;
+    CPUX86State *env = &cpu->env;
+
+    return env->u_cet != 0;
+}
+
+static const VMStateDescription vmstate_u_cet = {
+    .name = "cpu/u_cet",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = u_cet_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(env.u_cet, X86CPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static bool s_cet_needed(void *opaque)
+{
+    X86CPU *cpu = opaque;
+    CPUX86State *env = &cpu->env;
+
+    return env->s_cet != 0;
+}
+
+static const VMStateDescription vmstate_s_cet = {
+    .name = "cpu/s_cet",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = s_cet_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(env.s_cet, X86CPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static bool pl0_ssp_needed(void *opaque)
+{
+    X86CPU *cpu = opaque;
+    CPUX86State *env = &cpu->env;
+
+    return env->pl0_ssp != 0;
+}
+
+static const VMStateDescription vmstate_pl0_ssp = {
+    .name = "cpu/pl0_ssp",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = pl0_ssp_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(env.pl0_ssp, X86CPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static bool pl1_ssp_needed(void *opaque)
+{
+    X86CPU *cpu = opaque;
+    CPUX86State *env = &cpu->env;
+
+    return env->pl1_ssp != 0;
+}
+
+static const VMStateDescription vmstate_pl1_ssp = {
+    .name = "cpu/pl1_ssp",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = pl1_ssp_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(env.pl1_ssp, X86CPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static bool pl2_ssp_needed(void *opaque)
+{
+    X86CPU *cpu = opaque;
+    CPUX86State *env = &cpu->env;
+
+    return env->pl2_ssp != 0;
+}
+
+static const VMStateDescription vmstate_pl2_ssp = {
+    .name = "cpu/pl2_ssp",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = pl2_ssp_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(env.pl2_ssp, X86CPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+
+static bool pl3_ssp_needed(void *opaque)
+{
+    X86CPU *cpu = opaque;
+    CPUX86State *env = &cpu->env;
+
+    return env->pl3_ssp != 0;
+}
+
+static const VMStateDescription vmstate_pl3_ssp = {
+    .name = "cpu/pl3_ssp",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = pl3_ssp_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(env.pl3_ssp, X86CPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static bool ssp_tbl_needed(void *opaque)
+{
+    X86CPU *cpu = opaque;
+    CPUX86State *env = &cpu->env;
+
+    return env->ssp_tbl != 0;
+}
+
+static const VMStateDescription vmstate_ssp_tbl = {
+    .name = "cpu/ssp_tbl",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = ssp_tbl_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(env.ssp_tbl, X86CPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static bool guest_ssp_needed(void *opaque)
+{
+    X86CPU *cpu = opaque;
+    CPUX86State *env = &cpu->env;
+
+    return env->guest_ssp != 0;
+}
+
+static const VMStateDescription vmstate_guest_ssp = {
+    .name = "cpu/guest_ssp",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = guest_ssp_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(env.guest_ssp, X86CPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 #ifdef TARGET_X86_64
 static bool pkru_needed(void *opaque)
 {
@@ -1476,6 +1629,14 @@ VMStateDescription vmstate_x86_cpu = {
         &vmstate_nested_state,
 #endif
         &vmstate_msr_tsx_ctrl,
+        &vmstate_u_cet,
+        &vmstate_s_cet,
+        &vmstate_pl0_ssp,
+        &vmstate_pl1_ssp,
+        &vmstate_pl2_ssp,
+        &vmstate_pl3_ssp,
+        &vmstate_ssp_tbl,
+        &vmstate_guest_ssp,
         NULL
     }
 };
-- 
2.26.2


