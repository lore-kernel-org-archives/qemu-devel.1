Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61E4C2BB1D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 13:03:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A16A92076A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 13:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="chIJNivB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A16A92076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDpOn-00008O-CK
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 09:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49174)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDoRJ-0004wp-97
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:01:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDoRG-0005ML-RC
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:01:49 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44360
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDoRG-0005Cg-K3
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:01:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584360106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CwIXjXIXlcMAWLvq3ScgOCyIvELWS8JWHr16GXd7c2I=;
 b=chIJNivBrH0cyVIvUtUn9oNIlQT3p5jzeRuzM+KmUPtkcxWizGb/iMkpcGW62yMqanviGY
 FrAHybtEuXbvufVm9t+uVjP7liQ9o0iaCjKFoR5lKIVTvEkKky4BcNuAD/6N125kZQwowS
 iKo6IkTfMmrLobv+WwMANXx3qJ8bFwA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-T1vkWZtaNKyomYASQxM8uw-1; Mon, 16 Mar 2020 08:01:44 -0400
X-MC-Unique: T1vkWZtaNKyomYASQxM8uw-1
Received: by mail-wm1-f69.google.com with SMTP id p4so4816124wmp.0
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 05:01:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=J7UuHcBLWfpHR5sQ63i5sW+wU4N7EXBN4yjsHxGaorI=;
 b=gcvx2QYRR48kLU2/KxoE1FrcB2f8rOPM87l2/LgMsvjXWhQbGWu9ZjmKrwe9EclMus
 7yoKi89uB4fQRiQ1N5EPMab0JHooqQHNzDa2/jZupr8Tq2IUn2gGIDRLgiMuLQGJ0+Vb
 lKqRQbyNpoKOSAcg7PDDE+GTjFo+U68bX/+AQkffdIDWl6VSQIr4Xd11kYOLxH0aP19I
 aulaKZjmMYv8k5OkF915MFQn5QOFjVPuN9dx4j67UYydWJKiqxj7hVBCV2DM+nTWo29l
 tJTKYOQd+B2wsvWX/tPjqOrNcW+REqR9AkGNGtGYaZ6FAw9j6g3gF6wZvruM9tYJeM8B
 L5sA==
X-Gm-Message-State: ANhLgQ1CctN7ot75wgFcjTSnYtOFPa2YoRpZ5oRMmgBi9OP4Vgmpuqvi
 VF/Zp4Iu4/QyXZnrlmE2l8mp5bppOZgvnsmehmnvpwLUnbvTLPwv47JNAcA7F7lT411rhT9Ogn3
 kvuW8YQkHklVj9uY=
X-Received: by 2002:a5d:4b0b:: with SMTP id v11mr3192872wrq.23.1584360101911; 
 Mon, 16 Mar 2020 05:01:41 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vv12JJyZKh6e0i8izMwxeWW+Z3IDEPxuBAbMCr4bjeMoYqIjRNiK5dLBNMUXfjNt7nbRHvDIQ==
X-Received: by 2002:a5d:4b0b:: with SMTP id v11mr3192857wrq.23.1584360101733; 
 Mon, 16 Mar 2020 05:01:41 -0700 (PDT)
Received: from localhost.localdomain (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id d63sm30352268wmd.44.2020.03.16.05.01.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 05:01:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/11] target/mips: Always enable CONFIG_SEMIHOSTING
Date: Mon, 16 Mar 2020 13:00:47 +0100
Message-Id: <20200316120049.11225-10-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316120049.11225-1-philmd@redhat.com>
References: <20200316120049.11225-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On MIPS, the semihosting feature is always required on user-space.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 default-configs/mips-linux-user-common.mak | 4 ++++
 default-configs/mips-linux-user.mak        | 2 ++
 default-configs/mips64-linux-user.mak      | 2 ++
 default-configs/mips64el-linux-user.mak    | 2 ++
 default-configs/mipsel-linux-user.mak      | 2 ++
 default-configs/mipsn32-linux-user.mak     | 2 ++
 default-configs/mipsn32el-linux-user.mak   | 2 ++
 7 files changed, 16 insertions(+)
 create mode 100644 default-configs/mips-linux-user-common.mak

diff --git a/default-configs/mips-linux-user-common.mak b/default-configs/m=
ips-linux-user-common.mak
new file mode 100644
index 0000000000..04947706e8
--- /dev/null
+++ b/default-configs/mips-linux-user-common.mak
@@ -0,0 +1,4 @@
+# Common mips*-linux-user CONFIG defines
+
+# CONFIG_SEMIHOSTING is always required on this architecture
+CONFIG_SEMIHOSTING=3Dy
diff --git a/default-configs/mips-linux-user.mak b/default-configs/mips-lin=
ux-user.mak
index 31df57021e..c606e12444 100644
--- a/default-configs/mips-linux-user.mak
+++ b/default-configs/mips-linux-user.mak
@@ -1 +1,3 @@
 # Default configuration for mips-linux-user
+
+include mips-linux-user-common.mak
diff --git a/default-configs/mips64-linux-user.mak b/default-configs/mips64=
-linux-user.mak
index 1598bfcf7d..81e16ac2eb 100644
--- a/default-configs/mips64-linux-user.mak
+++ b/default-configs/mips64-linux-user.mak
@@ -1 +1,3 @@
 # Default configuration for mips64-linux-user
+
+include mips-linux-user-common.mak
diff --git a/default-configs/mips64el-linux-user.mak b/default-configs/mips=
64el-linux-user.mak
index 629f084086..6399af3fd5 100644
--- a/default-configs/mips64el-linux-user.mak
+++ b/default-configs/mips64el-linux-user.mak
@@ -1 +1,3 @@
 # Default configuration for mips64el-linux-user
+
+include mips-linux-user-common.mak
diff --git a/default-configs/mipsel-linux-user.mak b/default-configs/mipsel=
-linux-user.mak
index 4d0e4afb69..4a27d30b45 100644
--- a/default-configs/mipsel-linux-user.mak
+++ b/default-configs/mipsel-linux-user.mak
@@ -1 +1,3 @@
 # Default configuration for mipsel-linux-user
+
+include mips-linux-user-common.mak
diff --git a/default-configs/mipsn32-linux-user.mak b/default-configs/mipsn=
32-linux-user.mak
index 5b97919794..f3ac967463 100644
--- a/default-configs/mipsn32-linux-user.mak
+++ b/default-configs/mipsn32-linux-user.mak
@@ -1 +1,3 @@
 # Default configuration for mipsn32-linux-user
+
+include mips-linux-user-common.mak
diff --git a/default-configs/mipsn32el-linux-user.mak b/default-configs/mip=
sn32el-linux-user.mak
index d6367ff987..63fe4de4fd 100644
--- a/default-configs/mipsn32el-linux-user.mak
+++ b/default-configs/mipsn32el-linux-user.mak
@@ -1 +1,3 @@
 # Default configuration for mipsn32el-linux-user
+
+include mips-linux-user-common.mak
--=20
2.21.1


