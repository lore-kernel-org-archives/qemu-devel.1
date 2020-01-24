Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93932C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 16:57:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6059620709
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 16:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mL7hhvik"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6059620709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv2Gf-00057Q-GR
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 11:57:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45541)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1iv2Fr-0003cU-RV
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:56:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1iv2Fq-0002vm-UX
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:56:23 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b]:55740)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1iv2Fq-0002vA-PK
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:56:22 -0500
Received: by mail-pj1-x102b.google.com with SMTP id d5so61373pjz.5
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 08:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=X0NxLy9YfOGRAzvR5nre9SreXUazO7Ppv8M7S281EDw=;
 b=mL7hhvikCjOfHRj5MDWBzw3Oi1/OGEqV5ZojROPHMBNhk4rd6opa737N0fpeb+ZTae
 FIZevJI8OJoFcSnRod6z0NDeTtz06fxHJ5k8/SZW4jeiQQOLmKqrS6gYqZ+MSso4ytaX
 5h6aPLSImgq2xx3T7TNAavxxlXy3UoQ7IW8dtDc+Fmz+du+tWKqC+7Z1OFm4M1nt6BxZ
 1kKqvvYv+WtAhSurdxKZBmj4Gz0Vhqfzt+bxbnXIgSdQGzAn1cufH4KDB3j4KysrTssP
 lNUTg3NcWlED68lrQaP2r6PRVTnzy+ZRAzZCT0TwkC7YG/J58XkEoxLMc6scQv9+tUuk
 KjZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=X0NxLy9YfOGRAzvR5nre9SreXUazO7Ppv8M7S281EDw=;
 b=GAGH4fDoWy54wgVuGpICj93KP5dO2GQ/s9/T5zb4fxfyC8vNM8B0EZkHT46T7mwecc
 8syhyD3TOD2phWQHJ/aHYrHwClsSLFTJxYggns2npvYEHAfcgDZP3plxYWn4v/iDQK6K
 OkEUPnZSYDyLv3gBht4AmLOoluxIQ/xmm3QYbRTqywKsBhR7qt9Gkh8SmoqKYfe4Jn6h
 Uz8YyGZTnIhEgzm+r1hj/rTF+2i/MNI/uVnT5LaHu4pmJ3euGbwCzn7Gl0TpnFMHdwvC
 GvCcuO5kdyZ8/K7xwUM6hJHqfrl4PrFzErPs4hnwRgdaYN65GA9RKTOra8q/Ck73CEk1
 YNMw==
X-Gm-Message-State: APjAAAU+mn+rxa5y3nniyXeesMLYAzIZ+MVVS51mbAEmpp0VU64DfUuL
 xURrh77/lMKZhPJgih1YF3TI38n+sls=
X-Google-Smtp-Source: APXvYqza1F0gg1YP6n0jX3v6NCiga5uzfdZBZtZx9TJ3dw0Rnib+xD4tDoODGQdZYf2q+dRZYa9cIw==
X-Received: by 2002:a17:902:708b:: with SMTP id
 z11mr4552410plk.121.1579884981668; 
 Fri, 24 Jan 2020 08:56:21 -0800 (PST)
Received: from Rfoley-MA01.usrd.futurewei.com ([12.111.81.71])
 by smtp.gmail.com with ESMTPSA id l10sm6969953pjy.5.2020.01.24.08.56.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2020 08:56:21 -0800 (PST)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/8] tests/vm: Debug mode shows ssh output.
Date: Fri, 24 Jan 2020 11:53:28 -0500
Message-Id: <20200124165335.422-2-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200124165335.422-1-robert.foley@linaro.org>
References: <20200124165335.422-1-robert.foley@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::102b
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
Cc: fam@euphon.net, philmd@redhat.com, alex.bennee@linaro.org,
 robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add changes to tests/vm/basevm.py so that during debug
 mode we show ssh output.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
---
 tests/vm/basevm.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index ed5dd4f3d0..991115e44b 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -122,11 +122,16 @@ class BaseVM(object):
         return fname
 
     def _ssh_do(self, user, cmd, check):
-        ssh_cmd = ["ssh", "-q", "-t",
+        ssh_cmd = ["ssh",
+                   "-t",
                    "-o", "StrictHostKeyChecking=no",
                    "-o", "UserKnownHostsFile=" + os.devnull,
                    "-o", "ConnectTimeout=1",
                    "-p", self.ssh_port, "-i", self._ssh_key_file]
+        # If not in debug mode, set ssh to quiet mode to
+        # avoid printing the results of commands.
+        if not self.debug:
+            ssh_cmd.append("-q")
         for var in self.envvars:
             ssh_cmd += ['-o', "SendEnv=%s" % var ]
         assert not isinstance(cmd, str)
-- 
2.17.1


