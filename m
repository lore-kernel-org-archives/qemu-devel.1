Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72407C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 10:08:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8FE022253
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 10:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="GMS6Lb7v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8FE022253
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUoZ9-0006mi-LM
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 06:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1kUoTw-0008AL-Rq
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 06:03:04 -0400
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:49475)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1kUoTu-0007Eg-W1
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 06:03:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1603188182;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3eqI4wA+3uMajVVyTgFTOFTM3SrnL7w/R6m8eV3YUOc=;
 b=GMS6Lb7vn6sNGvLz9uihv+y3Kzey7twX4ojqYKsbd26MRZvgsOATghTu
 lLMlehsgssLhfqNihQBDFPxdrgnT9+PaQEiyuyq3c154y0rcJtBo5XFNf
 aO9PuVm7MBSPNrfX97Uoy7WYRCX9VrdmVJJIAqaNZdmWEUEVOYQwLyFIg s=;
Authentication-Results: esa4.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
IronPort-SDR: IrOYJOs2fXFA5tGCOikbfFkm1HJ60nzd3zCJuRzXMwTvfdLsq/CsC5pNoDuW8zn0LAFy638Gi5
 tgl8ZJ8xkG6AXCWBkzQU1rh4+J1gFrDOUS+BBHLv70dyd5rtVfustp4iwHJqDI69nsuGAkXKAp
 GHMM8YoD1LxCVGOvWD7qnb0UOso52rvtPYuO8LkQ2R5KqXCEakRXMzcIi8Fyo4Dpoyy1Rcawwg
 oEGKNSxVBJ0+7db9YfKc4rx3BbuT3pEn1a9Qc48BCUuPc0Y00JzCC7ei3U/SLsqAST1PAieogo
 HDY=
X-SBRS: None
X-MesageID: 30419948
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.77,396,1596513600"; d="scan'208";a="30419948"
To: <qemu-devel@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Jason Andryuk
 <jandryuk@gmail.com>, Anthony PERARD <anthony.perard@citrix.com>
Subject: [PULL 4/4] hw/xen: Set suppress-vmdesc for Xen machines
Date: Tue, 20 Oct 2020 11:02:39 +0100
Message-ID: <20201020100239.272748-5-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020100239.272748-1-anthony.perard@citrix.com>
References: <20201020100239.272748-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.155.144;
 envelope-from=anthony.perard@citrix.com; helo=esa4.hc3370-68.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 06:02:54
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Anthony PERARD <anthony.perard@citrix.com>
From: Anthony PERARD via <qemu-devel@nongnu.org>

From: Jason Andryuk <jandryuk@gmail.com>

xen-save-devices-state doesn't currently generate a vmdesc, so restore
always triggers "Expected vmdescription section, but got 0".  This is
not a problem when restore comes from a file.  However, when QEMU runs
in a linux stubdom and comes over a console, EOF is not received.  This
causes a delay restoring - though it does restore.

Setting suppress-vmdesc skips looking for the vmdesc during restore and
avoids the wait.

The other approach would be generate a vmdesc in qemu_save_device_state.
Since COLO shared that function, and the vmdesc is just discarded on
restore, we choose to skip it.

Reported-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
Acked-by: Anthony PERARD <anthony.perard@citrix.com>
Message-Id: <20201013190506.3325-1-jandryuk@gmail.com>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/i386/pc_piix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 3c2ae0612b23..0cf22a57ad14 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -987,7 +987,7 @@ static void xenfv_4_2_machine_options(MachineClass *m)
     pc_i440fx_4_2_machine_options(m);
     m->desc = "Xen Fully-virtualized PC";
     m->max_cpus = HVM_MAX_VCPUS;
-    m->default_machine_opts = "accel=xen";
+    m->default_machine_opts = "accel=xen,suppress-vmdesc=on";
 }
 
 DEFINE_PC_MACHINE(xenfv_4_2, "xenfv-4.2", pc_xen_hvm_init,
@@ -999,7 +999,7 @@ static void xenfv_3_1_machine_options(MachineClass *m)
     m->desc = "Xen Fully-virtualized PC";
     m->alias = "xenfv";
     m->max_cpus = HVM_MAX_VCPUS;
-    m->default_machine_opts = "accel=xen";
+    m->default_machine_opts = "accel=xen,suppress-vmdesc=on";
 }
 
 DEFINE_PC_MACHINE(xenfv, "xenfv-3.1", pc_xen_hvm_init,
-- 
Anthony PERARD


