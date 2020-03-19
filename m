Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3684C4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 09:29:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98ECB20757
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 09:29:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98ECB20757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jErUR-0002BK-Pf
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 05:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40875)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jErRv-0005MQ-MY
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:26:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jErRu-0004D2-Gj
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:26:47 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:40723)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jErRu-0004Ce-7I
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:26:46 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mw9oq-1jXlmB0qrU-00s8TV; Thu, 19 Mar 2020 10:26:35 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v3 05/16] linux-user: Flush out implementation of gettimeofday
Date: Thu, 19 Mar 2020 10:26:16 +0100
Message-Id: <20200319092627.51487-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200319092627.51487-1-laurent@vivier.eu>
References: <20200319092627.51487-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:A1gRnY8zWnzS4FbXY6sw/gIdS9rOUf6PKVl0Fh7zabe1Ojordm3
 j5Gv34XV1xEmN61PjkE9sUVX8be70NciUyXyGotX6s1PoGezB9kfMmIuYKO4kcJcjC93ABb
 GNd7QHnldbAve6Zg36G7ZJqMhaBFy6A+QGDBR5D9CqnxPGKRsxTMBXnh7xspkh/aZjpHgyG
 ozv8bXJw4Tg+7S/FFOMAQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eDuNZpO6p+w=:BkUi6WE3VEQf4xndonIecB
 6XV0ZGNdHbWo1ocLy3J7d3hqL7h2UOQc7zLv4YP6i7XprYj+vKPSsYw93ORm+8WsmQIbNtT16
 P+TTaVrO8a2Ojfy7Qh8VSKD/T/ROvb5K+CCRm4iX9ASuidnx9dC1DQdzS2V+VcgSwHVl+QJ82
 wefAwIif8qHNerL2JRkck24XBmMjOVi0JO7UDom9W/XzzlWOamDeNI/CiP3y5zWWXDi2hKX4n
 hcj3H+DOB7E+JvcpxcYZU5aqRIDI6cl0LCYAU1YI+xMXLZmxmuwFpPSAiYcHp4RhUv/tPd+Qi
 Inf9B5Z82SkgSGr77+1sgp+qL8l//JyFB7c/K33RUuwZW3HNYjcOzW0Tpc4XzaHb4Mh2Jr8v5
 TEp6I9/L2gG5QDI97ERhlkjy0AYvYYcwzokM34UqFHImRVbxjD3gg7VMlHKCu1LI5mGQoU6h6
 DdVFC9OeMNKm8LhwqcAa1lQ1d90/GgwdiI5ZSSAepc2enkQxztB2uhD4umszWDYFQwxPdIdQO
 3A4uK62KQ2YlcAdSVBfWFf545hm9ccqsQrKXp8b9CTW1iu6MJmogDKDy74aYqNyS2qfsE6I6B
 H8NmBIgazIMDgy8w5H69huIHUraBaAY05sCg/QTeApH7xKC+LvPu7Dh/qPG5cb0wO/AOeSDvS
 BAt1kLV87z+wENJgSmw85tlWCDuG64WmIzXgXlLkHfRsdXRZk7Oyc8+6ohZ8m42x71JWByRzD
 QKBBHdA9GrEccxXbJpW4FPO9mTR8K1JeUWVKs6WoQhtTomVcScFZlNWIwD9YPMirun3nDF9aR
 JO1ZaVN/7q3loOZ2ha8CREiFYWbuYnohsv66v3FAHchCDrmIgkVprr85qikrxouWhMKgP7J
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
2.25.1


