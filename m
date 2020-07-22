Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2A8C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 17:48:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24C2220787
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 17:47:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24C2220787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyIqV-00048x-82
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 13:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jyIpY-0003I5-IO
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 13:47:00 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:60593)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jyIpW-0000Xp-UR
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 13:47:00 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N7iGi-1ku41m3hMA-014o7F; Wed, 22 Jul 2020 19:46:53 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] linux-user: fix clock_nanosleep()
Date: Wed, 22 Jul 2020 19:46:11 +0200
Message-Id: <20200722174612.2917566-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200722174612.2917566-1-laurent@vivier.eu>
References: <20200722174612.2917566-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:4R9z6YS56lzcDW6LoH52kgUgWKQr00fJjGd4dtH65Md43O20aEJ
 nyD1CnzEBF6UeLp8rfyjGj9wL7Qg5jTC3sL8rI00UnYTONqmTw3airRX6oLIK/Q8mVVidZa
 MRHJqAzxN91mneW+gcUFk5XQt7ESX0zcHtqdFQtcd17AMDvZxA7ZfGxxiBbFb49SHk6koAI
 qV8oegazs9M4Ne4fo67Zg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7ccVDHNJKAI=:OpIkbdyU9hMd1sGu1ZHRTk
 cONtWvTiaiT0YVGOvwDe9WnI+rR72fQxXQTTwTdRbxUL9uNAal/gTQzVRRc3aRmusdrbOvs3q
 Z1D/mR/L/YwJraFEjoE8lrphcGwq9oeDz3Z+TdgamZUcHZfkSGIKgPuOKFpDSn0fFWHyurfk6
 KUldxGqZoh9RmZv+orrXO4IC0NpxqyJ8R0AB0T3wFsywyjLB5rxc5E5PhDtxRb9i2/0iem6PP
 A2mbMQneebTeJgdxHISN8SmOqa1cJzNPm8v64hTrdQpjsVgxkosY3876k0GR2eALnNvFRpGWg
 WkyrXaY07tTSVmgM8j22BMjKff/gbVxXLXUENOngpxBCpNvX5tUZ/UdGAwAbjQaIgYMXbgevi
 yoa+MZggYaFTkZPSxSjtZamlv1QpotTcEKw8aA/PP2bmkMrbpcfvr8NlUjGg6px3pghW1dl8v
 TS2rkhSRaSIAkVmHTPOhEv/6czyTe+mjF7mrnpON20TRf6QleoWRNEDoPbkae6qmfSa37RO81
 NdYvqKxhjpWscj/8663mYvNFNfyMA6n115owFWAZS1ksOPEHi3ayboSxyu8jXvEw56F2KRyUh
 tUWN4Nh5KMupYfnax1r8KWxw+QkyESxJMFeOmHM7kfxtW/SoJsfkeyhcrjp+SPvrzLyurTrnX
 cSVyEpmwYzQKhMNmw7xVPE6+P0ZZwsgMNMIjd7XGcRLLAsi7Qgu52JZGCis4vG0Z3DRXOD/4m
 L4ZduK62t0toRKHMVajm1CjaqnrZG0/ymmBFxBRN/Dx0opMKFyhyR7qpshJxUeOnYHDNpGDjw
 /9pJRMDhQfgoyiO2tST13l0Z10iqggZg57JzL4DcQbyEUfdZD98jCUGVf/DB84grzLhonzdr4
 s6F9zVffqOYR1HJKhWPzx2fx9BLpPN3CQwx6uh9kMMHqzGw9dHacn6cySGdQm31EpvlAQ/Ai4
 6d8xBbSLkhe4hpgL89Y8DPwegUZpwCF4INBtMh2XAcHowCzMgBVvYnXY9bPlwYAMybjQ97smU
 WtkWCWY1re97pxZ6ZdRTNdzmwfuebQ1OETl1NFnARKznPYoIY+6vr4qWapGg7bmeODCz1eaN9
 ww0wKdsYmWZEoGXKYNle3Joq6PNAVwZyheEYVesDZOvIpKL5hxG7rLT3tTIJjEe1b0egRCy4k
 qtKj1msUyT2ioLPheuJGjxQYmiG5lBSsojGdsSQicQd9xptw==
Received-SPF: none client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 13:46:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If the call is interrupted by a signal handler, it fails with error EINTR
and if "remain" is not NULL and "flags" is not TIMER_ABSTIME, it returns
the remaining unslept time in "remain".

Update linux-user to not overwrite the "remain" structure if there is no
error.

Found with "make check-tcg", linux-test fails on nanosleep test:

  TEST    linux-test on x86_64
.../tests/tcg/multiarch/linux-test.c:242: nanosleep

Reported-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---

Notes:
    v2: safe_clock_nanosleep() returns -1 and update errno,
        so we need get_errno()

 linux-user/syscall.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 1211e759c26c..43a6e283961b 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11831,8 +11831,14 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         target_to_host_timespec(&ts, arg3);
         ret = get_errno(safe_clock_nanosleep(arg1, arg2,
                                              &ts, arg4 ? &ts : NULL));
-        if (arg4)
+        /*
+         * if the call is interrupted by a signal handler, it fails
+         * with error -TARGET_EINTR and if arg4 is not NULL and arg2 is not
+         * TIMER_ABSTIME, it returns the remaining unslept time in arg4.
+         */
+        if (ret == -TARGET_EINTR && arg4 && arg2 != TIMER_ABSTIME) {
             host_to_target_timespec(arg4, &ts);
+        }
 
 #if defined(TARGET_PPC)
         /* clock_nanosleep is odd in that it returns positive errno values.
-- 
2.26.2


