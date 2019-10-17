Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB179ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:56:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3BC82082C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QYTzuTqT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3BC82082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL6G6-0004lw-Ai
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 09:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35665)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5ma-0002QH-Tc
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:25:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5mY-0001K6-SS
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:25:36 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38960)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iL5mY-0001Jj-Lt
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:25:34 -0400
Received: by mail-wm1-x342.google.com with SMTP id v17so2523603wml.4
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uTKqy+wnCWVLTWShRSYu/D5n/xFvdeK0I9HBQnZtYcw=;
 b=QYTzuTqTRv9k4dwikGibJ6BTRaMcJ9Z22ScLexM4hESE2I1l0JLdiL8/deaPzVKLHb
 oqkNgssyVemThpqxv96DQcyx8jSVEkOVJIhUH5KTOQ3qQ7WTGa0pl3/KjJSHMOzRyJfo
 tSxML33moo9itmA69RYwIOFfdbqc9cMFdarvQryfG7tFfIiQyUGIUWfxg64scuedhWfE
 d8yNqGmPoJzAuN1d6mfGKK6q/Xfk7CsvrDkY8YKxrb4xMa+1lrJRzOzjihxl83+0I7Zv
 9nWcdmf3807axu1kAF6yqBJDbzTr1nfv+pYFSPn780U9eaQyCOOQ0rNu1izpTuCRGfuT
 8ElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uTKqy+wnCWVLTWShRSYu/D5n/xFvdeK0I9HBQnZtYcw=;
 b=htUXtyME6fRbDISY8GCiF0ZxVGDVwv0bfofO0cVgOFJz4kj0auU0HdlIqsReoNicfU
 9gEome7elAe4AyEHwo42MMEzOzgZOMtw5v2VwQuKEpL493MSe7TDBB8ItR8qxNPAJe44
 ieNG4WNnT8RKaPCsRiS+Orif9PrKQV706TbHvAKOPPdKNsmFh7bN1+NS3simuFBqr/cU
 rsLfw7KuCbusX9mvsH5VqlumI4e3Q7tnWJHj9+yAIU69VBuVf+KqLM26/6A6P/SaonjQ
 s3owmwNUgC+aJ+b+f3DWGJojV+XylnpbFoQxJ/QKZ3NO7BdTsEitUlMfQzRJ/rfJ8cu5
 U3CQ==
X-Gm-Message-State: APjAAAV7yWOWGpUkf2Vo5JZSeR4KRPfyWGswstwQsAH6/YkSJ+NNW7Qj
 4WwcJAKRrzrPm47WwJDq+JxKgA==
X-Google-Smtp-Source: APXvYqxY2BcWAETFmftWm8+CwG8lkrOqA8UAZFIfPcjGm90iWsSgo2rvtAkX7XGhIm1BWnuiF6t4WA==
X-Received: by 2002:a1c:dcd6:: with SMTP id t205mr2950572wmg.10.1571318733514; 
 Thu, 17 Oct 2019 06:25:33 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k24sm10131817wmi.1.2019.10.17.06.25.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:25:30 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A22671FF87;
 Thu, 17 Oct 2019 14:16:17 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v6 18/54] *-user: notify plugin of exit
Date: Thu, 17 Oct 2019 14:15:39 +0100
Message-Id: <20191017131615.19660-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017131615.19660-1-alex.bennee@linaro.org>
References: <20191017131615.19660-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: robert.foley@futurewei.com, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 bsd-user/syscall.c | 3 +++
 linux-user/exit.c  | 1 +
 2 files changed, 4 insertions(+)

diff --git a/bsd-user/syscall.c b/bsd-user/syscall.c
index 1ee6195d9f..84a983a9a1 100644
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
index bdda720553..a362ef67d2 100644
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


