Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50491C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 12:59:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 243FC20659
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 12:59:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 243FC20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1rbl-0000Y4-4d
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 07:59:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60878)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j1raZ-0007Zj-VI
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 07:58:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j1raP-0003s9-GZ
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 07:57:59 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:51335)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1j1raP-0003rF-7G
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 07:57:49 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MHoZS-1jFYQB4ATe-00EvBY; Wed, 12 Feb 2020 13:57:06 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 4/4] linux-user: fix use of SIGRTMIN
Date: Wed, 12 Feb 2020 13:56:58 +0100
Message-Id: <20200212125658.644558-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200212125658.644558-1-laurent@vivier.eu>
References: <20200212125658.644558-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:J92mwqrY8tMW58Fc7j+NPrHkaGX9N6Me3XwyeYxAeTcxENAHD3W
 CI1Gcj/g44tXy0DWFr1Hjfh4XWDRhascm4w2kXIPfB6T8golCLT4hjxnJSmZEyWmrpJGgBr
 8Hu31rxW5TUR3x3rojmmn0W6h2P2Azsuc9T/lmNcsFy3dVUWv4l6Nh7LG7T2i/GW9XHI2AE
 juH/AB8QYcYn867AoqYrA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DJQHfzKL2kQ=:CX1qI1f8d0asqplHJkHI0q
 akaZiY9Xc0WpZSZWQDsdTBXZxtoSty2QkpyswZuus4s1haqOHhAxGMnamtd/0MECQ7eUhtQG8
 oSiEjWlNZmUlPWYRThJDCgkStlM+TkwqVBr1kxG6UHIvkOf/AImBRTlCuon47mCCALZgCGR6M
 WZXe3GcqvWfrE2tu5W5a++lhSnPpaU50SM9yqJu9Sy6AS5vZ8MCBccGaJ3DYbvJ866wfMw4Mn
 PPCZRr6SP7R2fbeH7yvlAd7m5RRFI8QlLJYpGEqLc+snuosnkbSzyvxNzvUrilqUiMsCB5Ila
 DgraK+tYn2SmyLu66pBxQ5vRGOCjSPPw0Jm3+DRee+0ztlc2AluW/pdqom491PPonC6yjki0S
 lMv5FEDzpyoUGMi37ob7LMc2G7JZewz59yfBNZuGAB0COYttf9sDjomtuJS0bWzkzNJXoJg3Y
 IN3Rxw14AbnGxHJSIpNZelnQhWrLDkojIB7x+zPcTFlN4bqpHmowevIDKFe3WQJh6StUZTbAA
 762k1d8zie5M6+LNPuLuiAcZZLg/xdIG5LgJdcm3VGjWXTwDB5TNqRqmckgM/sgEPv7Xnh/TV
 cSAGediKkMFzfh2HUHRmY8JxRzWzOCic/cEncJprF3/jdfybinRNKBzG+P4i2mM5xifk12KEm
 b4JkySZcku2kOH1zGDL6O8qSh6E9fuZSlgHf36NqNZi2Vitv1r759cwj1NyYg17gGnZG+917A
 UsTT3v/JnefsBhcuSTACBoEUsOrYQa/jKh/ew2+H0RzMfVdAWSVn2HiNTMaiz/HYdJ/8dNBEa
 K8r/ACgCN4Vjx3wkvuJntw/ytiEudYALT4vInP7yecsVHrOZ5M+zQYObl4NltnPVcWo6ozf
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
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

Some RT signals can be in use by glibc,
it's why SIGRTMIN (34) is generally greater than __SIGRTMIN (32).

So SIGRTMIN cannot be mapped to TARGET_SIGRTMIN.

Instead of swapping only SIGRTMIN and SIGRTMAX, map all the
range [TARGET_SIGRTMIN ... TARGET_SIGRTMAX - X] to
      [__SIGRTMIN + X ... SIGRTMAX ]
(SIGRTMIN is __SIGRTMIN + X).

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Taylor Simson <tsimpson@quicinc.com>
---

Notes:
    v3: use trace_event_get_state_backends()
        update comments
    
    v2: ignore error when target sig <= TARGET_NSIG but host sig > SIGRTMAX
        replace i, j by target_sig, host_sig
        update signal_table_init() trace message

 linux-user/signal.c     | 50 ++++++++++++++++++++++++++++++++++++-----
 linux-user/trace-events |  3 +++
 2 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index c1e664f97a7c..046159dd0c5b 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -498,18 +498,30 @@ static int core_dump_signal(int sig)
 
 static void signal_table_init(void)
 {
-    int host_sig, target_sig;
+    int host_sig, target_sig, count;
 
     /*
-     * Nasty hack: Reverse SIGRTMIN and SIGRTMAX to avoid overlap with
-     * host libpthread signals.  This assumes no one actually uses SIGRTMAX :-/
+     * Signals are supported starting from TARGET_SIGRTMIN and going up
+     * until we run out of host realtime signals.
+     * glibc at least uses only the lower 2 rt signals and probably
+     * nobody's using the upper ones.
+     * it's why SIGRTMIN (34) is generally greater than __SIGRTMIN (32)
      * To fix this properly we need to do manual signal delivery multiplexed
      * over a single host signal.
+     * Attempts for configure "missing" signals via sigaction will be
+     * silently ignored.
      */
-    host_to_target_signal_table[__SIGRTMIN] = __SIGRTMAX;
-    host_to_target_signal_table[__SIGRTMAX] = __SIGRTMIN;
+    for (host_sig = SIGRTMIN; host_sig <= SIGRTMAX; host_sig++) {
+        target_sig = host_sig - SIGRTMIN + TARGET_SIGRTMIN;
+        if (target_sig <= TARGET_NSIG) {
+            host_to_target_signal_table[host_sig] = target_sig;
+        }
+    }
 
     /* generate signal conversion tables */
+    for (target_sig = 1; target_sig <= TARGET_NSIG; target_sig++) {
+        target_to_host_signal_table[target_sig] = _NSIG; /* poison */
+    }
     for (host_sig = 1; host_sig < _NSIG; host_sig++) {
         if (host_to_target_signal_table[host_sig] == 0) {
             host_to_target_signal_table[host_sig] = host_sig;
@@ -519,6 +531,15 @@ static void signal_table_init(void)
             target_to_host_signal_table[target_sig] = host_sig;
         }
     }
+
+    if (trace_event_get_state_backends(TRACE_SIGNAL_TABLE_INIT)) {
+        for (target_sig = 1, count = 0; target_sig <= TARGET_NSIG; target_sig++) {
+            if (target_to_host_signal_table[target_sig] == _NSIG) {
+                count++;
+            }
+        }
+        trace_signal_table_init(count);
+    }
 }
 
 void signal_init(void)
@@ -817,6 +838,8 @@ int do_sigaction(int sig, const struct target_sigaction *act,
     int host_sig;
     int ret = 0;
 
+    trace_signal_do_sigaction_guest(sig, TARGET_NSIG);
+
     if (sig < 1 || sig > TARGET_NSIG || sig == TARGET_SIGKILL || sig == TARGET_SIGSTOP) {
         return -TARGET_EINVAL;
     }
@@ -847,6 +870,23 @@ int do_sigaction(int sig, const struct target_sigaction *act,
 
         /* we update the host linux signal state */
         host_sig = target_to_host_signal(sig);
+        trace_signal_do_sigaction_host(host_sig, TARGET_NSIG);
+        if (host_sig > SIGRTMAX) {
+            /* we don't have enough host signals to map all target signals */
+            qemu_log_mask(LOG_UNIMP, "Unsupported target signal #%d, ignored\n",
+                          sig);
+            /*
+             * we don't return an error here because some programs try to
+             * register an handler for all possible rt signals even if they
+             * don't need it.
+             * An error here can abort them whereas there can be no problem
+             * to not have the signal available later.
+             * This is the case for golang,
+             *   See https://github.com/golang/go/issues/33746
+             * So we silently ignore the error.
+             */
+            return 0;
+        }
         if (host_sig != SIGSEGV && host_sig != SIGBUS) {
             sigfillset(&act1.sa_mask);
             act1.sa_flags = SA_SIGINFO;
diff --git a/linux-user/trace-events b/linux-user/trace-events
index f6de1b8befc0..0296133daeb6 100644
--- a/linux-user/trace-events
+++ b/linux-user/trace-events
@@ -1,6 +1,9 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
 # signal.c
+signal_table_init(int i) "number of unavailable signals: %d"
+signal_do_sigaction_guest(int sig, int max) "target signal %d (MAX %d)"
+signal_do_sigaction_host(int sig, int max) "host signal %d (MAX %d)"
 # */signal.c
 user_setup_frame(void *env, uint64_t frame_addr) "env=%p frame_addr=0x%"PRIx64
 user_setup_rt_frame(void *env, uint64_t frame_addr) "env=%p frame_addr=0x%"PRIx64
-- 
2.24.1


