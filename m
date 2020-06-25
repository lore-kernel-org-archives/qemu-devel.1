Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2234CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 09:13:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9F7D20709
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 09:13:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9F7D20709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joNwV-0005a1-72
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 05:13:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1joNvn-0004k9-0J
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 05:12:27 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:57525)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1joNvk-0007GH-9V
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 05:12:26 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N18MG-1irYvu1hog-012av1; Thu, 25 Jun 2020 11:12:12 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] linux-user/sparc64: Fix the handling of window spill
 trap
Date: Thu, 25 Jun 2020 11:12:04 +0200
Message-Id: <20200625091204.3186186-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200625091204.3186186-1-laurent@vivier.eu>
References: <20200625091204.3186186-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:haf5ZDw9BhvA7sVK9J7LHOxjRS2OcWVOhVraSDvOYty0T9DyXCk
 iHqJF137STJlLtUp45GZqu5BsgkematCpRvZRIwzgq0TSP4bUI9wdWXOYndikTTKpd5qgZy
 ydagMwUAgG47/meF37U9aXMCnQh33dndi932NTVuzb7PzDJ8iEZaV7vN4ub27T13WRPbH0R
 6uRAo3AZ1BgUajkl+eoCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UjNgFKmgUzU=:dbZVwy+5NGZvhx11cCG3C0
 crKUgYUOZRaXUS9/+/tgVB6NeQaGkJ4/Laj9kuqidQNX2QCoWMm4vxJ7UB17nmi7M0r1RUVvH
 HFlr0eEgsmtOvwYeBwLJThASChJeqjkctG85/qV1QE8HTz48p1EjvlSAakjiEqRHcvgYS/Fy2
 2RBRehMPta5uV+3NVaMNObuPIIysyVwCThDejssHrqjOJn+8ce480UnmxJV3jju3t40Z3jBqN
 shCCFnBr+Y1acRWvLvXBcLUlmZtb4zlmDhnjb5IPlO5ZAyyGJqiCEOuPyCG9SUNr6H5K5SfJ/
 +mYp89LOZYJnDcgtTnFAj7lAFwpWJxdTgAHAlA5K/J++SinoVKEM0Vpj3oLW34DrDrThpjO2q
 M2GSb8ETbep3kn0bLF+HZT5a4ws5ALJbuH91NciokmZf12tKSim/QHDk7YcNOiVBmEhSz8TYv
 AoQNnUrdPY+//vnPXpZ54boJ41YqQxGDNnCMDn721rh8FKySWDFqEMqhoTAy4lzCBuwban4eJ
 XiPmUjTqeCSn1d8+2nmMLAxoRZin1q1WGltZeeD7wMQvq5SqQJwwsxmTw1TDztPdb/tYoqcHC
 yyqzkpqjE7VWMl6HxUMfp+Lpp7CxXabY6gXy477oo5YIBsY6QTYM1SIDEWXwxs52qacZt7w7o
 hqo1DK3a19zqu4rIrtwkelT7ArlI1cjCvlNBZy87e2Au7Ih63qBavCqljVaZTk9kg51n/WGJM
 xOAMNqhybjOGwcYsVrWpLVO3yTiEdGVFNoowQxSc/vlEBxrcLlDnHSoWajbEFutJVupcOrgXY
 IVm07cFsx96JxnV6GuFQkHlgTuqUWHLlaifyrVB/8c1JJB1HOQ=
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 05:12:21
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>, Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: LemonBoy <thatlemon@gmail.com>

Fix the handling of window spill traps by keeping cansave into account
when calculating the new CWP.

Signed-off-by: Giuseppe Musacchio <thatlemon@gmail.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
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


