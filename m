Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58263C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 20:18:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CCEF206E3
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 20:18:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CCEF206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxyj2-0001MW-Em
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 16:18:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jxyiE-0000wE-01
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 16:18:06 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:54603)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jxyiC-0005fS-7d
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 16:18:05 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N336J-1kyULg49G9-013NuK; Tue, 21 Jul 2020 22:17:58 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH] linux-user: fix clock_nanosleep()
Date: Tue, 21 Jul 2020 22:17:54 +0200
Message-Id: <20200721201754.2731479-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ii3jxqkRO/HPYb/ekUYcNb86TzNNz6BaN1vtFbCu8KR9SJ3f4L2
 0dgJR0epBgxJZlATTDscaC3JGLRwKpo2hdFgNvzZOsmhwfaeImSKO3so0tsppvW8vlFIUKE
 fNjKY2GqkUzeTIjAXwlZTiukryMtNhxL2qQzZ+NaF/o1J+DAerJOPaxVu4Eboc0mUDyF8+x
 KzmT7qkADp0XgOw+GvIoA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PyymBnG4ZO4=:8bPi+EPlssMIjdf/04Rarx
 smk5msY3Th2EcvJ7CycybHkJWR1vPkO5wo6VHs4uHiLNT1UpbyNUrWGdjHk4EGb5MbLJ0mKkj
 RnZNGax66pbcME6z0zaC6sY+XcRO2mXcgTe17wSbQO1ObcZB68CjPI61D3cOheekIYogxGIWP
 6rPYlxqBOOFMCYhy7ihvHZRc/IWNv3n+b318erJKfWA1OKkzjHbfQnyse9Vf2tBPOQLMmwU4x
 FEcBal++KTk6VvCuaC4AC74UeZ8bGW8v41SHZqMmPp8ymRzyBu15fTSP6o91a1nS25HoiQogL
 Co0c78IX3p4R29MCbJI0bSmfgscpQRaRsAYcQ6lDAuK3HUxx/aAY8W7ddcF/c6R8+iNSf/hQN
 wiwThDz6K8GxVnr/S9nhXGBbB0iaI74Rf5yqVf35+7QTfYZ6zjhN0PmvKex/DEtHUoAmORD3o
 cD3kohDZ+G4cZyN4gEf/wEVNvUDFxR2KNSCh2wBEsD8SZZSXHWqU1NRI3wKiu88uk3crWZTZj
 BTlxt1PRhhpML8LlKUUpUHo7MyDks9ph3HQBJFS30GEt+fAlGbSZ3oYcctJIzv+an+5h9LgWc
 9k5gCKDsv8jQgoY5JCdIcISG3WzIUwn6v7es3A7llApa3YFefy8rhY4Io742YS2pM7NpxKtoC
 zjSpz+b/X5ybY6Oml3Cf7FoEwTMIFZORla0pzIXIRXrfnMMpDwnYi/EydfrW2eMzBSzbnDXUJ
 OMK7HwKyHagWXhgJyN1yDCI5X0Pk9tNPBqXP10kBIV7+whadQYwg915j35OGKtt2yd+SfSCaZ
 qMOWT3z6ybXL9tLnpp8pqwcMehnWqZYX5AZC2Fz6U+2gWa/8iwCIlYheCdXP5oYOQ05Qi4v
Received-SPF: none client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 16:18:02
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
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If clock_nanosleep() encounters an error, it returns one of the positive
error number.

If the call is interrupted by a signal handler, it fails with error EINTR
and if "remain" is not NULL and "flags" is not TIMER_ABSTIME, it returns
the remaining unslept time in "remain".

Update linux-user to not overwrite the "remain" structure if there is no
error.

Found with "make check-tcg", linux-test fails on nanosleep test:

  TEST    linux-test on x86_64
.../tests/tcg/multiarch/linux-test.c:242: nanosleep
make[2]: *** [../Makefile.target:153: run-linux-test] Error 1
make[1]: *** [.../tests/tcg/Makefile.qemu:76: run-guest-tests] Error 2
make: *** [.../tests/Makefile.include:857: run-tcg-tests-x86_64-linux-user] Error 2

Reported-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 1211e759c26c..caa7cd3cab94 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11829,10 +11829,19 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     {
         struct timespec ts;
         target_to_host_timespec(&ts, arg3);
-        ret = get_errno(safe_clock_nanosleep(arg1, arg2,
-                                             &ts, arg4 ? &ts : NULL));
-        if (arg4)
+        /*
+         * clock_nanosleep() returns 0 or one of the *positive* error number.
+         */
+        ret = host_to_target_errno(safe_clock_nanosleep(arg1, arg2, &ts,
+                                                        arg4 ? &ts : NULL));
+        /*
+         * if the call is interrupted by a signal handler, it fails
+         * with error TARGET_EINTR and if arg4 is not NULL and arg2 is not
+         * TIMER_ABSTIME, it returns the remaining unslept time in arg4.
+         */
+        if (ret == TARGET_EINTR && arg4 && arg2 != TIMER_ABSTIME) {
             host_to_target_timespec(arg4, &ts);
+        }
 
 #if defined(TARGET_PPC)
         /* clock_nanosleep is odd in that it returns positive errno values.
-- 
2.26.2


