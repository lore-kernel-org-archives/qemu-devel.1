Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50364C4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 11:21:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2498F208C3
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 11:21:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2498F208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGhck-0008Pv-Ae
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 07:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33526)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jGhZJ-00035w-L4
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 07:18:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jGhZI-0007bt-Eo
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 07:18:01 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:44447)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jGhZI-0007bi-65
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 07:18:00 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N49xZ-1jOzGE40vp-0100ec; Tue, 24 Mar 2020 12:17:08 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 5/5] linux-user: Flush out implementation of gettimeofday
Date: Tue, 24 Mar 2020 12:17:00 +0100
Message-Id: <20200324111700.595531-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200324111700.595531-1-laurent@vivier.eu>
References: <20200324111700.595531-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nxNTZT40BDeQWB/pCBr2MQyPGlh4spQuOikUnuwKc+qNYYzVl9H
 tZdUzBP9eldOdp55TCExUBUEE+oRP6NZpOPG/LIsF/OaEbEpFQmA9buPBx5gHkJEGnmfVZ4
 YG39jT6DsusHQbhflTUqsccaqCHkfag5/WPsJJaF34HiSNXLZxSEHm/Fsq2Kazdvm90F1VP
 i7di1p3fOh+Sw+EtAJ8OQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Rhltnc+KlBU=:4IxLpHu/oKnm8CSNwBba6b
 6DhFB7DqW4tSd89qrxpZyBV7Kgglh4bOYPw5RYjJEMdwqoxMtYzNXE+NAjvx2O5z1K0Pjviul
 YkeQcLqQzomLkin62DYzjYGIsP+ZjjqL7G2Rq3CUh42U608Tvu6P1qB2LLBYoeZ+N1zXre1W5
 7H8uwyHVGscU60R60bqY+GPy3jECm4EaMfsGm2NXTLwR1xTr3ZoEvcZVmpIc21Lj9ff29L0Gk
 1PS96VkICBekF3IWA47pjQV3XjtkqsOPycu41u87d/uynWTqL+MbWlkbTwYdwkaN1vZjRbUf8
 NCz79J/j/7r1ZIiTKKZgwpYkX1soynkdxaUZoqn+2LkrGRrCL5yCDmwx9Xn25hVKnxeK8LJ2G
 knnygqmV1IpUjumjv23tmqsc0ZfAgNQ9dqyLh13l8cQimWaZZcx/U6R3J1fal0xQZl8LuDH1I
 eY6o1Q7PkI7I0Sst/AeGIlEUIC6RIxel1lBY/oxeJ4LhwOjx7EHPDSePz7w7ZWoXJy92RvN5G
 iRx1irjv/JMJ6SryBkl4mZlGhuIbCklGMGmgP1GTkOYuqhoq7fKCunmXu6V3w7dnxDRCBXydl
 jrpC5p77lAgwHLTFpXcbIaMSnvKFMKfwh6ZLBYwJp9GLL47fC6I0bTPOnK8mXhCEu93/qsTI9
 +XgDQ5lc7KQ/Bi8hXW1POA/RoL/iKb4L8xwdzOPEeRSVuEM787107/dWm5o72Dy6FTGb9HTM+
 kGadevAtZwU5PydCVrN1ZMRZJFhBXxW7PdyUPPLKvVOcNt1WONYwKQL30Yv55WWzeT+zwRgps
 14/lE6s7qJR9ekw8/5um2BAe635gVyL9mwVlzusrB30l1tcQQmiHMGyGcu+OhEWiZgaJOTc
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

The first argument, timeval, is allowed to be NULL.

The second argument, timezone, was missing.  While its use is
deprecated, it is still present in the syscall.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200213032223.14643-6-richard.henderson@linaro.org>
[lv: add "#if defined(TARGET_NR_gettimeofday)"]
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index dbdd56e42077..49395dcea978 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1273,6 +1273,25 @@ static inline abi_long host_to_target_timespec64(abi_ulong target_addr,
     return 0;
 }
 
+#if defined(TARGET_NR_gettimeofday)
+static inline abi_long copy_to_user_timezone(abi_ulong target_tz_addr,
+                                             struct timezone *tz)
+{
+    struct target_timezone *target_tz;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_tz, target_tz_addr, 1)) {
+        return -TARGET_EFAULT;
+    }
+
+    __put_user(tz->tz_minuteswest, &target_tz->tz_minuteswest);
+    __put_user(tz->tz_dsttime, &target_tz->tz_dsttime);
+
+    unlock_user_struct(target_tz, target_tz_addr, 1);
+
+    return 0;
+}
+#endif
+
 #if defined(TARGET_NR_settimeofday)
 static inline abi_long copy_from_user_timezone(struct timezone *tz,
                                                abi_ulong target_tz_addr)
@@ -8710,10 +8729,16 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     case TARGET_NR_gettimeofday:
         {
             struct timeval tv;
-            ret = get_errno(gettimeofday(&tv, NULL));
+            struct timezone tz;
+
+            ret = get_errno(gettimeofday(&tv, &tz));
             if (!is_error(ret)) {
-                if (copy_to_user_timeval(arg1, &tv))
+                if (arg1 && copy_to_user_timeval(arg1, &tv)) {
+                    return -TARGET_EFAULT;
+                }
+                if (arg2 && copy_to_user_timezone(arg2, &tz)) {
                     return -TARGET_EFAULT;
+                }
             }
         }
         return ret;
-- 
2.25.1


