Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BE5C38A24
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 12:09:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C0F7206B8
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 12:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xhW1l5QV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C0F7206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWIrR-0004pw-B4
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 08:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jWIo8-0006Ku-Bv
 for qemu-devel@nongnu.org; Wed, 06 May 2020 08:05:49 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d]:36862)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jWIo6-0000ub-3Z
 for qemu-devel@nongnu.org; Wed, 06 May 2020 08:05:47 -0400
Received: by mail-ej1-x62d.google.com with SMTP id k8so1103812ejv.3
 for <qemu-devel@nongnu.org>; Wed, 06 May 2020 05:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DrqUaGonDL46LGXalbeGbioWVxgk7+O8lq9vZxw9cGg=;
 b=xhW1l5QVlhf2N3yHKNGFlo5ygiJGhlR4W1/lnPkeUYBt3jcDyX115BdK5nQOcPpsyK
 HMGq9yRcHe8b0MsshVMGzH8dYqjoY0mhpV9YzdV/FtQAEZs1Bh/9CENMwZXthISGa4JR
 t0LJuWE+T1CrDepKC2DjNKwe0eDE0eIFqwSneUFZHQaJGP90I51lvLYZmZIC6/ciWQ15
 +dLL1Z05865Zoq/nVP4RKleugsKp+qZ8G6F313Y9nD1xZjXyfPN7UAHYAp9ryqp+xXOj
 v2lN6xB8LUpWlkQZZk8VcDRI5hdTlQvmT9U+Ie8QKUyMhcpec0jtuDkYcJnQXxp2IR7e
 S+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DrqUaGonDL46LGXalbeGbioWVxgk7+O8lq9vZxw9cGg=;
 b=XAGKDE59KF3ls68x76hh1n1WSzG1uhZIOWXhj7UgnBFUKXqhuFBp+H8D2qc0ebAqzy
 2kDuO82M7CQwmeAo2vEkbFqdeJXFFWb77ds9tsFVZ1zyr9koqDxnkWmSWwW/Kk0BtaR6
 1511rz8rH4PrOvb101WAn2i/yjU+PmOGzBXI1c9wlyEGkNf+GrWVnPX3NJvza7t1HpOR
 hz7CW689smNe38t6lRu81KBtwz5ZmTLyJZrG/mXCE+jjgNnuMGXc19qW88JLlOUq1q1W
 7VG3rqFwh5B40LPUSyC2XkQmRqgHzwwnKoBWSw8WfJYdQXcEZMSSUqNeO1mUWEWLv0zG
 zEgQ==
X-Gm-Message-State: AGi0PuaaW1iqWyPoCt2QWT3lEhrdKRMEfQz3WkID6ZGYfIWcyeUs8BSm
 +wv43ysuZq3u1saltsggmVHil/cWZ3A=
X-Google-Smtp-Source: APiQypLh/cz9s9GlwCWMV1rUw6rpeXEEAhWdaU1J5LFVz7er4CUfG4Mu21vZH+lolKW5YJPn2XFp5g==
X-Received: by 2002:adf:e2c2:: with SMTP id d2mr9957876wrj.55.1588766743820;
 Wed, 06 May 2020 05:05:43 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n6sm436179wrt.58.2020.05.06.05.05.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 05:05:37 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 806F41FF98;
 Wed,  6 May 2020 13:05:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 09/14] tests/tcg: drop inferior.was_attached() test
Date: Wed,  6 May 2020 13:05:24 +0100
Message-Id: <20200506120529.18974-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200506120529.18974-1-alex.bennee@linaro.org>
References: <20200506120529.18974-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This test seems flaky and reports attachment even when we failed to
negotiate the architecture. However the fetching of the guest
architecture will fail tripping up the gdb AttributeError which will
trigger our early no error status exit from the test

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200430190122.4592-5-alex.bennee@linaro.org>

diff --git a/tests/tcg/aarch64/gdbstub/test-sve-ioctl.py b/tests/tcg/aarch64/gdbstub/test-sve-ioctl.py
index 387b2fc20aa..972cf73c315 100644
--- a/tests/tcg/aarch64/gdbstub/test-sve-ioctl.py
+++ b/tests/tcg/aarch64/gdbstub/test-sve-ioctl.py
@@ -58,9 +58,6 @@ def run_test():
 #
 try:
     inferior = gdb.selected_inferior()
-    if inferior.was_attached == False:
-        print("SKIPPING (failed to attach)", file=sys.stderr)
-        exit(0)
     arch = inferior.architecture()
     report(arch.name() == "aarch64", "connected to aarch64")
 except (gdb.error, AttributeError):
diff --git a/tests/tcg/aarch64/gdbstub/test-sve.py b/tests/tcg/aarch64/gdbstub/test-sve.py
index 5995689625e..b96bdbb99af 100644
--- a/tests/tcg/aarch64/gdbstub/test-sve.py
+++ b/tests/tcg/aarch64/gdbstub/test-sve.py
@@ -59,9 +59,6 @@ def run_test():
 #
 try:
     inferior = gdb.selected_inferior()
-    if inferior.was_attached == False:
-        print("SKIPPING (failed to attach)", file=sys.stderr)
-        exit(0)
     arch = inferior.architecture()
     report(arch.name() == "aarch64", "connected to aarch64")
 except (gdb.error, AttributeError):
-- 
2.20.1


