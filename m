Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D09C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:43:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05A8420714
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XiMRGjrt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A8420714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRzz8-0001pD-33
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 11:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRzqa-00078W-Qo
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:34:50 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36597)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRzqP-0007LG-P6
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:34:44 -0400
Received: by mail-wm1-x343.google.com with SMTP id e2so17969597wme.1
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 08:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3HBlEcMasIy4oDb25g21pdvkhkMGpmMaGyWG6UZXcVY=;
 b=XiMRGjrt3XZdV7lYHGRutgqWE5PCk89dcxaiotWvyRkgRb8O++Kf1X+Vu/EFIZ8Mxp
 UaCl280RgEI6ddCbLctLO0TDwd9K1ANiIwO3T3lYfgQUqUgjn9GC0MU1hzOqkzi0YSt6
 TlxqJJB2zgxfVeW8+HREB17+QgcZp6e6jihVcfA0dZn77z3Ie9bKQ3bEJdC7x/huaLdS
 uLonmv7yRQhMTdyeYLuEIM4/2OyruHsuel3s2X/PQk/jgBtXCqlX7JUuSdJ6uq0Z++77
 V4eSdqxiR+4TLq4sc5RpwP8yJjRY426HpJrDQi+Kl1m1sRBWpqjwsSR4T6Bll+Z1eErk
 ScUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3HBlEcMasIy4oDb25g21pdvkhkMGpmMaGyWG6UZXcVY=;
 b=Az8qrJv1MDr8dwWAMXSUWUeP1Yjy2b7Dj5JdIwq7yKD5cD1d84gb+ZczVQFi2tCrty
 GamHmewwQTTiod5Ym/ZKVkn+xr8AkYxRiP2os0gvPj53jWqMePGIbba7WT6tE190Cg/t
 vAHLypLMCZQipOhLpbt6axovatMRAwBPHxWcIU6VLtVTIFUy8vzYXyrS8o/C9vvyyh16
 AvI4QKQm3EtNM4EN6SnQRmcTPQQ9G9jKwsOcB5+TaRoJkJgq1tzf4hAKBEityJ/XCMBj
 rkFaaY2SE9HuGvUt9bC+uSMp4OD4J3OR5ZqduFXJsLAxRMxSYGVCN0XfizJbX0BzBr8U
 OjDg==
X-Gm-Message-State: AOAM532dCKFQAnc2YW0p+JogeBmgvWTy0MNMpLTHTmRtBSNXyyyh4N+u
 5hKYMmlyju8dQViiT1T0TXogWw==
X-Google-Smtp-Source: ABdhPJwgz1ZRG1R5q2wnTgdgP16tDHGKqt8qBLi9LlWX2DJ6vMsWP4eeNhSmMCbSPNQazzFWysi9kg==
X-Received: by 2002:a1c:1d89:: with SMTP id
 d131mr10235175wmd.188.1602516874954; 
 Mon, 12 Oct 2020 08:34:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y10sm19675284wrq.73.2020.10.12.08.34.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 08:34:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [RFC PATCH v2] linux-user: Use FD_32BIT_MODE fd flag for 32-bit guests
Date: Mon, 12 Oct 2020 16:33:44 +0100
Message-Id: <20201012153408.9747-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201012153408.9747-1-peter.maydell@linaro.org>
References: <20201012153408.9747-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If the guest is 32 bit then there is a potential problem if the
host gives us back a 64-bit sized value that we can't fit into
the ABI the guest requires. This is a theoretical issue for many
syscalls, but a real issue for directory reads where the host
is using ext3 or ext4. There the 'offset' values retured via
the getdents syscall are hashes, and on a 64-bit system they
will always fill the full 64 bits.

Use the FD_32BIT_MODE fd flag to tell the kernel to stick
to 32-bit sized hashes for fds used by the guest.

This is an RFC patch because the kernel patch that adds the
new fd flag hasn't yet been accepted upstream. The kernel
patch is:
 https://patchew.org/QEMU/20200529072017.2906-1-linus.walleij@linaro.org/

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This is just a minor update of the testing patch I sent out in the
thread discussing Linus's v1 kernel patch.

 linux-user/syscall.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 97de9fb5c92..265b9a096a0 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -884,6 +884,33 @@ static inline int host_to_target_sock_type(int host_type)
     return target_type;
 }
 
+/*
+ * If the guest is using a 32 bit ABI then we should try to ask the kernel
+ * to provide 32-bit offsets in getdents syscalls, as otherwise some
+ * filesystems will return 64-bit hash values which we can't fit into
+ * the field sizes the guest ABI mandates.
+ */
+#ifndef FD_32BIT_MODE
+#define FD_32BIT_MODE 2
+#endif
+
+static inline void request_32bit_fs(int fd)
+{
+#if HOST_LONG_BITS > TARGET_ABI_BITS
+    /*
+     * Ignore errors, which are likely due to the host kernel being
+     * too old to support FD_32BIT_MODE. We'll continue anyway, which
+     * might or might not work, depending on the guest code and on the
+     * host filesystem.
+     */
+    int flags = fcntl(fd, F_GETFD);
+    if (flags == -1) {
+        return;
+    }
+    fcntl(fd, F_SETFD, flags | FD_32BIT_MODE);
+#endif
+}
+
 static abi_ulong target_brk;
 static abi_ulong target_original_brk;
 static abi_ulong brk_page;
@@ -7725,6 +7752,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                                   target_to_host_bitmask(arg2, fcntl_flags_tbl),
                                   arg3));
         fd_trans_unregister(ret);
+        request_32bit_fs(ret);
         unlock_user(p, arg1, 0);
         return ret;
 #endif
@@ -7735,6 +7763,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                                   target_to_host_bitmask(arg3, fcntl_flags_tbl),
                                   arg4));
         fd_trans_unregister(ret);
+        request_32bit_fs(ret);
         unlock_user(p, arg2, 0);
         return ret;
 #if defined(TARGET_NR_name_to_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
@@ -7746,6 +7775,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     case TARGET_NR_open_by_handle_at:
         ret = do_open_by_handle_at(arg1, arg2, arg3);
         fd_trans_unregister(ret);
+        request_32bit_fs(ret);
         return ret;
 #endif
     case TARGET_NR_close:
@@ -7790,6 +7820,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             return -TARGET_EFAULT;
         ret = get_errno(creat(p, arg2));
         fd_trans_unregister(ret);
+        request_32bit_fs(ret);
         unlock_user(p, arg1, 0);
         return ret;
 #endif
@@ -12419,6 +12450,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         }
         ret = get_errno(memfd_create(p, arg2));
         fd_trans_unregister(ret);
+        request_32bit_fs(ret);
         unlock_user(p, arg1, 0);
         return ret;
 #endif
-- 
2.20.1


