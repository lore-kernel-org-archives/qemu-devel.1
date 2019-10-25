Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839C2CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:24:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51378206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hnWHV+EL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51378206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNtx8-0006vf-Rz
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 03:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38205)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtWZ-0003OE-Uy
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:56:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtWY-0007gH-PF
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:56:39 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:56230)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtWY-0007ey-J9
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:56:38 -0400
Received: by mail-wm1-x32e.google.com with SMTP id g24so796776wmh.5
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 23:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=InxJufY4GZdXxhorR8TFr2dyO/+lRhEgHf6keWCHq84=;
 b=hnWHV+ELMptqNqlmI81JXyI4tT0hGhEgvyPo6cntZiYZJxFrB/8okHPF2LlpBMknTM
 DL7aM/8P18p6Hi9TNSZMOjT466NMw2RDl85YkwoBMrCONRHWtt0iRNZMtnITlob9MZ2+
 xpyfMoRUmhKiaCSdgJKgg67aD0Jppgd08hWi/vQWuTD5HNLh0/mMjq5JrZKGAgnQQVQK
 JbpsxFdxSV6UwYtzfraMHRaS5k9bx3UpAzUkG//ftKcUE2oA8yUI3W3hAW4Flr+m4t7y
 TgN8tnXGDZicCfhkQ+kwHRjQgNK3KSM1Wy7fIAstxbde1trEHo4edJB6srx0rDUoaBDQ
 H5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=InxJufY4GZdXxhorR8TFr2dyO/+lRhEgHf6keWCHq84=;
 b=mgZXOd81gK5eYSaA6fXjWuvOpUynSavwdgUF35ocRA5TemKOe+/3tEReR1vi7XTn5n
 LXdFFfcbToF/jFUqMNcUhK1EGXldGpxdKpPZd6DBW+Dj1Xxr4ZeKCEW5WkQxcHklEoip
 OfHcdf8m3qLmedaklu01aeThg9J/LX93hQDj6ejx5n58oUdzjEYGR0b2fsZZ/mpVo7kv
 FuuaWtKib06BNzSIUHQgNAgZkCP7C0I2IKo2aH0KCKgE7DXyQ8Ij4AL53ysHotmfVi/E
 TfYqCAMEi3bkK/jFoY9I86AUa3iPudtXwTLnyp6eWWJ6mjW4TVzJaejaBMjqdy3A3P2M
 NXwA==
X-Gm-Message-State: APjAAAUDh00fA7/9MaHaJJl9x/Bp2ltP3KJ71XnVpZ9W3+KUcZXynfrW
 ms+2mxKnI75ZJunazCkAJ4ftMQ==
X-Google-Smtp-Source: APXvYqykaf6cCTxGXpxqlGZt9TrzVh3QOx3dW83w08gMPiTjAv56WTKjlEe/VHK8t4jilL/Hijdljg==
X-Received: by 2002:a7b:c7d9:: with SMTP id z25mr2026014wmk.127.1571986597523; 
 Thu, 24 Oct 2019 23:56:37 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a186sm1396359wmd.3.2019.10.24.23.56.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 23:56:36 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0547C1FFBB;
 Fri, 25 Oct 2019 07:37:17 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 34/73] *-user: notify plugin of exit
Date: Fri, 25 Oct 2019 07:36:34 +0100
Message-Id: <20191025063713.23374-35-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, "Emilio G. Cota" <cota@braap.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/bsd-user/syscall.c b/bsd-user/syscall.c
index 1ee6195d9ff..84a983a9a12 100644
--- a/bsd-user/syscall.c
+++ b/bsd-user/syscall.c
@@ -332,6 +332,7 @@ abi_long do_freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         _mcleanup();
 #endif
         gdb_exit(cpu_env, arg1);
+        qemu_plugin_atexit_cb();
         /* XXX: should free thread stack and CPU env */
         _exit(arg1);
         ret = 0; /* avoid warning */
@@ -430,6 +431,7 @@ abi_long do_netbsd_syscall(void *cpu_env, int num, abi_long arg1,
         _mcleanup();
 #endif
         gdb_exit(cpu_env, arg1);
+        qemu_plugin_atexit_cb();
         /* XXX: should free thread stack and CPU env */
         _exit(arg1);
         ret = 0; /* avoid warning */
@@ -505,6 +507,7 @@ abi_long do_openbsd_syscall(void *cpu_env, int num, abi_long arg1,
         _mcleanup();
 #endif
         gdb_exit(cpu_env, arg1);
+        qemu_plugin_atexit_cb();
         /* XXX: should free thread stack and CPU env */
         _exit(arg1);
         ret = 0; /* avoid warning */
diff --git a/linux-user/exit.c b/linux-user/exit.c
index bdda7205532..a362ef67d2c 100644
--- a/linux-user/exit.c
+++ b/linux-user/exit.c
@@ -35,4 +35,5 @@ void preexit_cleanup(CPUArchState *env, int code)
         __gcov_dump();
 #endif
         gdb_exit(env, code);
+        qemu_plugin_atexit_cb();
 }
-- 
2.20.1


