Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA90BC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:38:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D2BD207DF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:38:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D2BD207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBean-0005MP-NC
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 09:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBeZz-0003de-TI
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 09:38:07 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:46305)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBeZx-0007Fs-Ur
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 09:38:07 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MQgtC-1k0CGI2pyI-00NhcS; Fri, 28 Aug 2020 15:37:56 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 02/18] linux-user: Fix 'clock_nanosleep()' implementation
Date: Fri, 28 Aug 2020 15:37:37 +0200
Message-Id: <20200828133753.2622286-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200828133753.2622286-1-laurent@vivier.eu>
References: <20200828133753.2622286-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:PgMW5plxnhlyQLOwsnzOcAwuV8dMZ/LyU3W09+waqJCNYohd1Gs
 WTAHD9U+T6jTVeRxRyFqjiFUysN4/2vZO/lImSWf5gVCK+eKFn+PFQGUb/jAEiIAGmtg4/l
 kjFswtG1vr3EOZkWRoa8Dhrchd1hFn6d4SeaqlRJLAwtSh2fOaodLZOeQWUNicStM9S5uP9
 ukRaSD+8LvCy0+1RmHjXQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:g5Y5p3hL8vQ=:lj7l8StXdlWAIWmlyuVTGF
 bj81489C8uU/Jse2obLy/IJ3n0AiQPV+PsSQYCSa7Sy34Y5dGcuTCKc2GiXFkWtQLlAeZs82G
 uo2abBOvW7gd3XHk7WZDG8siekYaQTndtXVEwvr7vgEwnnOwbp+feFaJUPJLXoMAyhAp9b9e5
 ESYjaxRiy2faE4ih1KqE3MPXUTXdNqaIpEnzLm7yyoC9EsGuLRXOqsta5IPN58b7VkeXVV5Ec
 FImV0LTDxeo+51jx/Bc2t4N0/gxIEkl9WHcM7k+5bX1aQ9XwopCCqlqqKgW3ee0XyU4wlqzFS
 4Pu6E46yncE4zP0qTjB9k2EbWAy7DYxaim06AneolQ/BNx9TV7GhPaprEJH/gOA6hmhPYhgoQ
 uFAdUOU87zxxeFSeWvxbvmxev1AV1gm5763Csiwp4fR9kP9VwHp/3zXSFTzpGzDheMjs+a7zP
 7F51rzkXEVybRnyjQAafG0Crla2EZlpBLlND+DVTFZHLOSLhyXXM7c5NSrz341pbs9SapbXrE
 iTaYxjpteMuL40nXks6qM4J6sEbLq+rW5kK5Oi0IM7e+UNWyvBUdPBH9ap9OPQwDk5WnsPD/l
 5/VnrLEXsK07BNZBuMQ98epwI5NO9GyE8UMp6Nr6++XSmNJMLcS2YsbOGRqDqPE8JYLrsVQNB
 sqXc7OpwryBqAIW3EIdIX3YRyyLPJhxu09hnamcaXoMp6nSdZy/tUJwSAWkWRry2T5vOHGqcW
 4SnoRJBgeA9r7B0mJqZcwRqSXgNbaV7mnX0APKSIAzutDCLKY4X6nQFi9UyyHdCHR+e+dN/Nw
 GV2nHtZiGvrp+MBNm6tUvwHv/5VbU8Kwf3Z7wWn7VHFrz2Mf1WL1JxVx7LSYKqPINHWP4+6
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 09:38:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Filip Bozuta <Filip.Bozuta@syrmia.com>

Implementation of syscall 'clock_nanosleep()' in 'syscall.c' uses
functions 'target_to_host_timespec()' and 'host_to_target_timespec()'
to transfer the value of 'struct timespec' between target and host.
However, the implementation doesn't check whether this conversion
succeeds and thus can return an unaproppriate error instead of 'EFAULT'
that is expected. This was confirmed with the modified LTP test suite
where testcases with bad 'struct timespec' adress for 'clock_nanosleep()'
were added. This modified LTP suite can be found at:
https://github.com/bozutaf/ltp

(Patch with this new test case will be sent to LTP mailing list soon)

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200727201326.401519-1-Filip.Bozuta@syrmia.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 5b3fce3dc0cb..e387246d7196 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11875,7 +11875,9 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     case TARGET_NR_clock_nanosleep:
     {
         struct timespec ts;
-        target_to_host_timespec(&ts, arg3);
+        if (target_to_host_timespec(&ts, arg3)) {
+            return -TARGET_EFAULT;
+        }
         ret = get_errno(safe_clock_nanosleep(arg1, arg2,
                                              &ts, arg4 ? &ts : NULL));
         /*
@@ -11883,8 +11885,9 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
          * with error -TARGET_EINTR and if arg4 is not NULL and arg2 is not
          * TIMER_ABSTIME, it returns the remaining unslept time in arg4.
          */
-        if (ret == -TARGET_EINTR && arg4 && arg2 != TIMER_ABSTIME) {
-            host_to_target_timespec(arg4, &ts);
+        if (ret == -TARGET_EINTR && arg4 && arg2 != TIMER_ABSTIME &&
+            host_to_target_timespec(arg4, &ts)) {
+              return -TARGET_EFAULT;
         }
 
         return ret;
-- 
2.26.2


