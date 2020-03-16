Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A48C2BB1D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:06:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86D6920674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:06:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86D6920674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDu87-0003RA-Gh
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40314)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jDsPe-0007uS-E5
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:16:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jDsPd-0008Jz-7p
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:16:22 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:44111)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jDsPc-00089c-Sw
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:16:21 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MJWgK-1iu9fF0v5k-00JtBP; Mon, 16 Mar 2020 17:16:09 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 05/38] linux-user: Flush out implementation of gettimeofday
Date: Mon, 16 Mar 2020 17:15:17 +0100
Message-Id: <20200316161550.336150-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200316161550.336150-1-laurent@vivier.eu>
References: <20200316161550.336150-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:2+OnKEYWuZtt3LxPwxgWv2MmMh5zFI/qbCEo/Y0vnYsZo1wgRYE
 XNrFQkaN5nIM6oooTEeFIYSAFrRg38LDumZGna+54GdMhnqhq/41MZ5xndr3aCitIgC+T7Z
 yrztQN6I19hQXnoOz+hQLkfBEEiYILpfXEl8nJx1+xkVzYqm+lRJ3riYujlsC7jHygr28fP
 Fl8LsgikLMxCRAqgVWZvw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1lgY4n/pUaE=:1ivdzdwoXUHX6ENjH6hC9+
 2ByfVFANsSd27UMZmS4JEQw0ZJu/hqzsAJvOCmNaNPZmwWwdb79/LQbng227raBS2r+my/K2L
 DrWjuJ7BQtBy4H8XU4p7cfDVfeajz1b2pRIcRpvc03lLqEYTRdrXXdMYfZ+oBROa8gnNHoITj
 gJJ4koCHS93o9lI6sVO11j2Egjl6ar8bFKtMv7Wn6xF6pgXS7Dd2NGhqA9Gzw1xc8yl4rv283
 zvt1JPS+NWCp29Pd8+bMtMkmrWsElboxajHPZYwOsLAjRKV+YGQrKKwZyUcz1cea78r7/Wwun
 rlRxyRNfq6P157K/0GpKMDxH2mxlbtNTolhwfwmbokn3a901hww5Gk5yg1bzaToMp3mm0ntXg
 A3Oci06rf12zs2HHwav58gYG4uwmuyLCkUqi3X6nowP93qr1iF/QcTXxas1jz5Bqj2uSqmSZF
 g8mUkREfORnPM4TIMWfc9zb7/uKzZWWDF4Nc01WZqwiKGlWmakad6aKZY96p1rMrbnU+ZPE0Q
 4KkyWxR3E/H/6BhKcz+2U7g3COtxmmNZivjOzGEjlaMDAczItcT6TGEDEaORxn81fTDhEat9B
 KeyDNCqAeg6rY7yNHHvmLbljWNsqTUj6q2dIl3z5lywbV4cKKBC2V4M3clvFeowz4Z+KyMb6G
 z7pcCYPnD+x3sD8gXiXyQSGUGuATWGcdrI+lq7i+aKPzsV4U4iMusKem84EyPp+CKvjHJEoh+
 qkElwRxUZ11ebBIioxOzXueQ9LS2b72RPN68D65gyG0nqbDsCXff1EAdWSFkf/ZsFzsqujYAn
 VtHcXm65RV03EA0WigD/eVxeO3RsZVTbUqAkC00bVwR6+MdsyOn3cipSyWnvJkcTLM36Kn7
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.131
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
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 5479d67a10be..811495c3a0bc 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1228,6 +1228,23 @@ static inline abi_long host_to_target_timespec64(abi_ulong target_addr,
     return 0;
 }
 
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
+
 static inline abi_long copy_from_user_timezone(struct timezone *tz,
                                                abi_ulong target_tz_addr)
 {
@@ -8642,10 +8659,16 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
                     return -TARGET_EFAULT;
+                }
+                if (arg2 && copy_to_user_timezone(arg2, &tz)) {
+                    return -TARGET_EFAULT;
+                }
             }
         }
         return ret;
-- 
2.24.1


