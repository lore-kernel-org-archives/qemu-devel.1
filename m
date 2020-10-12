Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60045C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 20:09:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6BDA20BED
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 20:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rYtSPe2K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6BDA20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS48r-00023B-GZ
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 16:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1kS46z-0008M7-T2
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 16:08:01 -0400
Received: from mail-qv1-xf44.google.com ([2607:f8b0:4864:20::f44]:40182)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1kS46y-0007qZ-9T
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 16:08:01 -0400
Received: by mail-qv1-xf44.google.com with SMTP id o25so2413348qvf.7
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 13:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QY2243JX786fdUoHzoK1Y6Kh1lJrJoZtoq/K0Z9ICJs=;
 b=rYtSPe2K/v1dU7vZsTf27LfQRM1ImXctJlIOG3nIN7IH978uvQVPQCjWOd6D6XniNU
 mKQg27mvMRIXMCi4AnPhtDNCrMgkF9YnvVLyst07RQa3J7AoDV9twIKB9nD75/WM1SXf
 si7oE4eTR1Vtlc59TMUo6Ns6acrzagC9QRh6ajVF6vQJKUtHM3bRSpHWKiraNSDp0oTx
 PbbHDxkBMZjQDCuFP0KNmVOHAEZYT4PS/s0QVTFGjQsKkfTJRLfrtGTHABYgGkfMvWX9
 PaucQ1LQGfo7nU2F3n7cPK94O3Z3cTejLMuXEXktHME0VdOtuuhg8oNV+MVp3QdHgj+c
 eaiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QY2243JX786fdUoHzoK1Y6Kh1lJrJoZtoq/K0Z9ICJs=;
 b=Pf/3f8WdQuDNFtfV6dmm1Dyq3deaKL/Is3uApZ/JEp/E9yljSyiK+w6Ot/03asvBUe
 O1FVFcfeLkFWYgYUENGtH8YGF44dKIDU737ChDpxKYe2Tl6zOAVjqHjLsSA8FJLSuErn
 adK6iILyCsg5ygntfljph4w2kP+Z9mp07SRQv5QM2vI0e3IjB9CDtjSuDOFrdHo63Pcb
 27oHjLmGbVNHbbzEVsjvwHNZsvVLij8romQU9N53QDTLa0UfEYKd03eUFZP+79hmsW0p
 YrYIfZppfO+DN0z8TywUYeMHmFnh3IfFGSrEQxdUBDBh5+zBAPr4V0PvaJd58V4ldDfP
 doww==
X-Gm-Message-State: AOAM533jhS1ZZ5WscRw1dTsfCTDpbLIxPYDrys5nkOQAHtnGJhImTFVC
 xaZ2sreQWqoJ9deTfOKpLIZd1fJ9Rq4=
X-Google-Smtp-Source: ABdhPJw3I51kN+J+TGXLaLkJTSdYuDYY97kg7N1G1MUPkpX1p5tdCYS7ebkzO/aJ0SAisDXB4fym3w==
X-Received: by 2002:a0c:b29e:: with SMTP id r30mr27540725qve.38.1602533279090; 
 Mon, 12 Oct 2020 13:07:59 -0700 (PDT)
Received: from shine.lan ([2001:470:8:67e:9802:d83e:b724:7fdf])
 by smtp.gmail.com with ESMTPSA id d129sm13418350qkg.127.2020.10.12.13.07.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 13:07:58 -0700 (PDT)
From: Jason Andryuk <jandryuk@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] accel: Add xen CpusAccel using dummy-cpu
Date: Mon, 12 Oct 2020 16:07:24 -0400
Message-Id: <20201012200725.64137-3-jandryuk@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201012200725.64137-1-jandryuk@gmail.com>
References: <20201012200725.64137-1-jandryuk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f44;
 envelope-from=jandryuk@gmail.com; helo=mail-qv1-xf44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Anthony Perard <anthony.perard@citrix.com>,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Jason Andryuk <jandryuk@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Xen was broken by commit 1583a3898853 ("cpus: extract out qtest-specific
code to accel/qtest").  Xen relied on qemu_init_vcpu() calling
qemu_dummy_start_vcpu() in the default case, but that was replaced by
g_assert_not_reached().

Add a minimal "CpusAccel" for xen using the dummy-cpu implementation
used by qtest.

Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
---
 accel/dummy/meson.build |  1 +
 accel/xen/xen-all.c     | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/accel/dummy/meson.build b/accel/dummy/meson.build
index 5fbe27de90..cdff0ba746 100644
--- a/accel/dummy/meson.build
+++ b/accel/dummy/meson.build
@@ -4,3 +4,4 @@ dummy_ss.add(files(
 ))
 
 specific_ss.add_all(when: ['CONFIG_SOFTMMU', 'CONFIG_POSIX'], if_true: dummy_ss)
+specific_ss.add_all(when: ['CONFIG_XEN'], if_true: dummy_ss)
diff --git a/accel/xen/xen-all.c b/accel/xen/xen-all.c
index 60b971d0a8..2d243c58d4 100644
--- a/accel/xen/xen-all.c
+++ b/accel/xen/xen-all.c
@@ -16,12 +16,15 @@
 #include "hw/xen/xen_pt.h"
 #include "chardev/char.h"
 #include "sysemu/accel.h"
+#include "sysemu/cpus.h"
 #include "sysemu/xen.h"
 #include "sysemu/runstate.h"
 #include "migration/misc.h"
 #include "migration/global_state.h"
 #include "hw/boards.h"
 
+#include "accel/dummy/dummy-cpus.h"
+
 //#define DEBUG_XEN
 
 #ifdef DEBUG_XEN
@@ -153,6 +156,10 @@ static void xen_setup_post(MachineState *ms, AccelState *accel)
     }
 }
 
+const CpusAccel xen_cpus = {
+    .create_vcpu_thread = dummy_start_vcpu_thread,
+};
+
 static int xen_init(MachineState *ms)
 {
     MachineClass *mc = MACHINE_GET_CLASS(ms);
@@ -180,6 +187,9 @@ static int xen_init(MachineState *ms)
      * opt out of system RAM being allocated by generic code
      */
     mc->default_ram_id = NULL;
+
+    cpus_register_accel(&xen_cpus);
+
     return 0;
 }
 
-- 
2.25.1


