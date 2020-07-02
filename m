Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963E2C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 15:28:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 705942073E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 15:28:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 705942073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr18R-0002AQ-KV
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 11:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jr17U-0000Rj-Ut
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 11:27:24 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:58457)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jr17T-0006IQ-1y
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 11:27:24 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M1HuU-1jpMQV1iI6-002ofL; Thu, 02 Jul 2020 17:27:13 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 02/12] linux-user/sparc64: Fix the handling of window spill
 trap
Date: Thu,  2 Jul 2020 17:27:00 +0200
Message-Id: <20200702152710.84602-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200702152710.84602-1-laurent@vivier.eu>
References: <20200702152710.84602-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:QBrQcB5DztA7knOhNhU9kAxyVGIrVZW7MQBvZv3bpPXqcmpr0PD
 lJt0QL1MGpdhzf5aHF7bxXcge9ko2BCJcRzzS1MBjQ6dQ/Bs8t+MuFZzf/gcNBPDFiMp95A
 ivpDodPlYSg4mgyheFQ5J7RbSqmDijyhb4WLKqzu69M6XaYQMRlZdCOpE92toWPCPEFrC/T
 R6mHxfNFsLxrL9xaqjxiw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JYTIK/MwxHE=:/zhJXYbYcO8mylBuhAhOky
 pe334IqDBNuUIb4/Gl4cUHPyc3u3EkmhbsDjiZCsK5NpxwaGxgsr+dtvIADPSRbQpILPhRCkZ
 gN+3OZiqlI758sJFFInIKxNxFQEXS82Uw+v8YqYjOan3Nl5shnSupTVc6bhC/JHLtjm3V18g4
 s+dZ8GEKrPudxL7qJuWjxQPwee0awWsPNnCUax0i87ayrbFxZDuos0r0Ymcs+FdZPPAsmuLZP
 26nKeFY2dzPEsLA7HV1pLyGX3cFCAERHYEwjkxHTKztJU1tEWOh+niets0CR8IUiZ76nWDLbA
 niuG7mQnLMnm0BwsQPMX8db+4A2zOt24KedxatWtxLyIHorgeFrc2JM7cimsAfbfMYZRaBkMT
 Po/n+eHIFpV0AzTmhm6tFAx7cYwXYocb5n3T+wL3sQTo2ln1n/BWZ32f1A8tEZcC7Fl9FStnA
 1ZPylbxyel5FXDoZ/Wy0Z5D6qvbUfk5xW+YdwGCGak94xPGFW4q1N5kfgsBAkwhU4o3KNn/Yy
 gKP/n4QR/c8FjoNeVwOYWLKfyLTiWQ/xvf+xSHNRq6WVrrUDZ8KAhFci2rT57e1ux6dZgiZwx
 RxbCoYKHEPQu9fCBlTPwvKRU2N03faNullWmFF5Pl4EN13++veO0lT7RpjBzeYdTkQ0EZ4tJN
 pL43Gvm0VDS7sh0De5FehFNyn0IsvcEQfr23C6ZQ+2Oc8xqqHofiUj/CVwhsjFxcmE1E+gcJl
 nJPwax7XSRz2T2KXl1oXtgySPaqm7N7Aqas30+7JBXLGyq/hyHoO4ESw6q+wado4ExAtZbFfy
 kdnlG6u1mWkTMT78pfw8lag3yGy1E7ZTlGsxdeh1AovYurJ2IE=
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 10:57:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: Giuseppe Musacchio <thatlemon@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Giuseppe Musacchio <thatlemon@gmail.com>

Fix the handling of window spill traps by keeping cansave into account
when calculating the new CWP.

Signed-off-by: Giuseppe Musacchio <thatlemon@gmail.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200625091204.3186186-3-laurent@vivier.eu>
---
 bsd-user/main.c             | 6 +++++-
 linux-user/sparc/cpu_loop.c | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index 0bfe46cff93e..ac40d79bfaac 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -413,7 +413,11 @@ static void save_window(CPUSPARCState *env)
     save_window_offset(env, cpu_cwp_dec(env, env->cwp - 2));
     env->wim = new_wim;
 #else
-    save_window_offset(env, cpu_cwp_dec(env, env->cwp - 2));
+    /*
+     * cansave is zero if the spill trap handler is triggered by `save` and
+     * nonzero if triggered by a `flushw`
+     */
+    save_window_offset(env, cpu_cwp_dec(env, env->cwp - env->cansave - 2));
     env->cansave++;
     env->canrestore--;
 #endif
diff --git a/linux-user/sparc/cpu_loop.c b/linux-user/sparc/cpu_loop.c
index 7645cc04ca73..02532f198df8 100644
--- a/linux-user/sparc/cpu_loop.c
+++ b/linux-user/sparc/cpu_loop.c
@@ -69,7 +69,11 @@ static void save_window(CPUSPARCState *env)
     save_window_offset(env, cpu_cwp_dec(env, env->cwp - 2));
     env->wim = new_wim;
 #else
-    save_window_offset(env, cpu_cwp_dec(env, env->cwp - 2));
+    /*
+     * cansave is zero if the spill trap handler is triggered by `save` and
+     * nonzero if triggered by a `flushw`
+     */
+    save_window_offset(env, cpu_cwp_dec(env, env->cwp - env->cansave - 2));
     env->cansave++;
     env->canrestore--;
 #endif
-- 
2.26.2


