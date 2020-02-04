Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A640CC35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:28:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 824512082E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 824512082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz1zb-0005kJ-MR
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 12:28:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54888)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iz1jf-00078Y-FR
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:11:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iz1je-0001aL-9J
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:11:39 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:37669)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iz1jd-0001VE-Vp
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:11:38 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MbAYi-1jVtZL1IHg-00bdxB; Tue, 04 Feb 2020 18:11:07 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/4] linux-user: cleanup signal.c
Date: Tue,  4 Feb 2020 18:10:51 +0100
Message-Id: <20200204171053.1718013-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200204171053.1718013-1-laurent@vivier.eu>
References: <20200204171053.1718013-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:EIm9a7+YzWA3RVuwlOMtseaQqYUyH2rlaronjAq9JvijJ1zS0yS
 8kHGZY0eectH8FzOeo0O4if6eeeY8cXebK4aJQ8yx6LXnBGIk8xgJ2J4fkb+Zz4KBM4+H4+
 KVsdYdlciyJhWRVZR1VM3jOAC6ZvzvRoSOn4fc5kiyqif+v6Q3CGGPlrGFT63jTUrMNge7P
 zlg7IkIchuu3l0vkxYJ4w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LzrnhUWiL+k=:dAjJzbjW3JWg0JyGqsCeBN
 3NIMm08WHB9KoJL/DcsWZltc6A5bmTOqt+ttgr2rosYEu2kKA5uH4vbirRMmmCT0TNdu3ec18
 zUAy0W2+OPg+QWprGmVrb3kCi6XWT35SNJAsVKzeFDG0shD4d+qsouFg6E9uXGn3joA7nTSGq
 IalWl8XmTj0NrmTTJGviz4b4U9Rw52zeSrQ3vZS1/9/+RdBpMxNyg2i4JQBPkQhBrGSCojA8y
 VBUcahRDMDryTdXIrCd7LWxsjSTs9rwRLXmvEmDCndlzx9stImIdST5fe2dlnuGI74t4rCsaV
 mT1Day3DAgyHF92d3k904uyM6QXAjtvpoI4KprKNBp+6ASwJQ+FlW6b33S5Li6LG/XuTuxmMs
 6T4+jCVL2wexGoWRZH+WZDbhD/A3MOq5xDwSnM+qhUtcAHbmjEA8BFPc3xv2AtI5BOO1CJ3+r
 3hLYKgrmdURfKt72SDUHcgm2lVtYE0yFSjpPIKeLcy+3RB+7HFg74sc+/yH4oyQGhQfYeYrAx
 qxRpxJXqorHQMA2oe9n/61pqcY9asNgnFxw6h9z8i6pML14oQsxd54CuG1iCxCSRfz6LmgzTD
 GdVFRZ48032kWrMc4ThhMsR63Uk2rO7Pxn66OLQtB5D1TiKezJIQ6c4P4iyHYwTG+/kQG9m9S
 YMPXh0+EcHyYoTxtkFprRQvnZV6Us0bfQ3kf3DdujtV4pnKwxXHMFv+kpEfyRmRwZbIUn/UTQ
 BIV4/ja2ZSn2TpHQUmzuF82nnMu3rQa8tQBasJGWJomyfifGxWvptExNFLGT+MlQZsMCYPIhz
 Aqyulin0zsdGMElBc2RQShyIgxt7pMlkwEWKirT0GvxbqmLXx8dAidXy2ZRH12xfE1N23kg
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Marlies Ruck <marlies.ruck@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Josh Kunz <jkz@google.com>, Taylor Simpson <tsimpson@quicinc.com>,
 Matus Kysel <mkysel@tachyum.com>, milos.stojanovic@rt-rk.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No functional changes. Prepare the field for future fixes.

Remove memset(.., 0, ...) that is useless on a static array

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---

Notes:
    v2: replace i, j by target_sig, host_sig

 linux-user/signal.c | 48 ++++++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index 5ca6d62b15d3..246315571c09 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -66,12 +66,6 @@ static uint8_t host_to_target_signal_table[_NSIG] = {
     [SIGPWR] = TARGET_SIGPWR,
     [SIGSYS] = TARGET_SIGSYS,
     /* next signals stay the same */
-    /* Nasty hack: Reverse SIGRTMIN and SIGRTMAX to avoid overlap with
-       host libpthread signals.  This assumes no one actually uses SIGRTMAX :-/
-       To fix this properly we need to do manual signal delivery multiplexed
-       over a single host signal.  */
-    [__SIGRTMIN] = __SIGRTMAX,
-    [__SIGRTMAX] = __SIGRTMIN,
 };
 static uint8_t target_to_host_signal_table[_NSIG];
 
@@ -480,31 +474,45 @@ static int core_dump_signal(int sig)
     }
 }
 
+static void signal_table_init(void)
+{
+    int host_sig, target_sig;
+
+    /*
+     * Nasty hack: Reverse SIGRTMIN and SIGRTMAX to avoid overlap with
+     * host libpthread signals.  This assumes no one actually uses SIGRTMAX :-/
+     * To fix this properly we need to do manual signal delivery multiplexed
+     * over a single host signal.
+     */
+    host_to_target_signal_table[__SIGRTMIN] = __SIGRTMAX;
+    host_to_target_signal_table[__SIGRTMAX] = __SIGRTMIN;
+
+    /* generate signal conversion tables */
+    for (host_sig = 1; host_sig < _NSIG; host_sig++) {
+        if (host_to_target_signal_table[host_sig] == 0) {
+            host_to_target_signal_table[host_sig] = host_sig;
+        }
+    }
+    for (host_sig = 1; host_sig < _NSIG; host_sig++) {
+        target_sig = host_to_target_signal_table[host_sig];
+        target_to_host_signal_table[target_sig] = host_sig;
+    }
+}
+
 void signal_init(void)
 {
     TaskState *ts = (TaskState *)thread_cpu->opaque;
     struct sigaction act;
     struct sigaction oact;
-    int i, j;
+    int i;
     int host_sig;
 
-    /* generate signal conversion tables */
-    for(i = 1; i < _NSIG; i++) {
-        if (host_to_target_signal_table[i] == 0)
-            host_to_target_signal_table[i] = i;
-    }
-    for(i = 1; i < _NSIG; i++) {
-        j = host_to_target_signal_table[i];
-        target_to_host_signal_table[j] = i;
-    }
+    /* initialize signal conversion tables */
+    signal_table_init();
 
     /* Set the signal mask from the host mask. */
     sigprocmask(0, 0, &ts->signal_mask);
 
-    /* set all host signal handlers. ALL signals are blocked during
-       the handlers to serialize them. */
-    memset(sigact_table, 0, sizeof(sigact_table));
-
     sigfillset(&act.sa_mask);
     act.sa_flags = SA_SIGINFO;
     act.sa_sigaction = host_signal_handler;
-- 
2.24.1


