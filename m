Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2718EC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 14:25:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4DDD206E2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 14:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gd3wTRUn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4DDD206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDqgT-0006CX-FP
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 10:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49304)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDoRM-0004yD-Ma
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:01:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDoRL-0006MI-90
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:01:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42020
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDoRL-0006EB-2t
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:01:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584360110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KWDNiFJqFqiz5RLtLkzj0Xcv4N3xLjsv0Q3BZIwVHcU=;
 b=gd3wTRUnpJBzTHiNxOD5V4azh7rqOD/XbEFWj0MZ5fhZz6vLEWzmGCAK7IAC6dgNXlNq7J
 YrU6Q8UIdfustBbgDYxYQ0nna2bagJ/CG/WotH0kgUmPbWRS1YIetIBR2izhvPuKHI2YSK
 TDk937MV4EAZ7IyhQpOFUURWpD+b2UA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-PlQeryTsPw2B4e11Dq6k-A-1; Mon, 16 Mar 2020 08:01:49 -0400
X-MC-Unique: PlQeryTsPw2B4e11Dq6k-A-1
Received: by mail-wm1-f69.google.com with SMTP id a23so5700205wmm.8
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 05:01:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=F8Hw9XI7udEgvO3Z4/24BD5VnJ65W4Svw6F6Rde3+TE=;
 b=hSgecvABiSObxWZBar8JrgxapOAkdnDVJFFUC5ES4P4u7sgqT+yY/L5VoMJoAy+NqJ
 f5vLwV7EFY2LhRnJxcmXzEF1l03DL9ojj3pq+MfPYkIaWCdcI9+mSAcQgjctFAD9gNck
 0xt7M/GU1jlkHJLdpE3WXb0EnX/V+UHHArRIc/KSvrAw54SMADnZ7nA9HB8PLVp/gddj
 jL0pCWo4WOu5I5whQP0ENj3YGa6wXFcDOs2xdYE1LpKYuZlU1tyamJ0TlMsRP4+vwoRu
 rxGA14FwdhSVTwvjuvKTVLKKVtk09gJsxjqKv0I2adHRljXPrxTAFNi40ejSOQYiU+NQ
 azeg==
X-Gm-Message-State: ANhLgQ3SiOkObPDXeyJ8r2iKfGeDat9uTP2+uKMhvXKNxVH0C620XZz8
 WW9y2KOe9Fz5Y1/Oa6w/XEUZUXcnkS2zMZI5nCdX/gT9GueZF0mQqI8rddl4h9BB3clJdam1fIK
 EMGLbcdXxV7U1ZCs=
X-Received: by 2002:a7b:cc9a:: with SMTP id p26mr27543200wma.0.1584360107671; 
 Mon, 16 Mar 2020 05:01:47 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsHi7yZYGn3LtJcneH8tM5v5HIdXfkC6i2rjyObDKaXMWL0XaRIM3DdOB/uVeHjHaKgbli8DA==
X-Received: by 2002:a7b:cc9a:: with SMTP id p26mr27543179wma.0.1584360107466; 
 Mon, 16 Mar 2020 05:01:47 -0700 (PDT)
Received: from localhost.localdomain (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id y15sm3967918wrp.92.2020.03.16.05.01.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 05:01:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/11] target/arm: Always enable CONFIG_SEMIHOSTING
Date: Mon, 16 Mar 2020 13:00:48 +0100
Message-Id: <20200316120049.11225-11-philmd@redhat.com>
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
 [fuzzy]
X-Received-From: 207.211.31.120
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On ARM, the semihosting feature is always required on user-space,
and is also used by system emulation.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 default-configs/aarch64-linux-user-common.mak | 4 ++++
 default-configs/aarch64-linux-user.mak        | 2 ++
 default-configs/aarch64_be-linux-user.mak     | 2 ++
 default-configs/arm-linux-user-common.mak     | 4 ++++
 default-configs/arm-linux-user.mak            | 2 ++
 default-configs/arm-softmmu.mak               | 4 +++-
 default-configs/armeb-linux-user.mak          | 2 ++
 7 files changed, 19 insertions(+), 1 deletion(-)
 create mode 100644 default-configs/aarch64-linux-user-common.mak
 create mode 100644 default-configs/arm-linux-user-common.mak

diff --git a/default-configs/aarch64-linux-user-common.mak b/default-config=
s/aarch64-linux-user-common.mak
new file mode 100644
index 0000000000..94c0cdf826
--- /dev/null
+++ b/default-configs/aarch64-linux-user-common.mak
@@ -0,0 +1,4 @@
+# Common aarch64*-linux-user CONFIG defines
+
+# CONFIG_SEMIHOSTING is always required on this architecture
+CONFIG_SEMIHOSTING=3Dy
diff --git a/default-configs/aarch64-linux-user.mak b/default-configs/aarch=
64-linux-user.mak
index 0a5b08a007..d27232cbc6 100644
--- a/default-configs/aarch64-linux-user.mak
+++ b/default-configs/aarch64-linux-user.mak
@@ -1 +1,3 @@
 # Default configuration for aarch64-linux-user
+
+include aarch64-linux-user-common.mak
diff --git a/default-configs/aarch64_be-linux-user.mak b/default-configs/aa=
rch64_be-linux-user.mak
index a69d9d2e41..7dee7ba4cb 100644
--- a/default-configs/aarch64_be-linux-user.mak
+++ b/default-configs/aarch64_be-linux-user.mak
@@ -1 +1,3 @@
 # Default configuration for aarch64_be-linux-user
+
+include aarch64-linux-user-common.mak
diff --git a/default-configs/arm-linux-user-common.mak b/default-configs/ar=
m-linux-user-common.mak
new file mode 100644
index 0000000000..67acd961f3
--- /dev/null
+++ b/default-configs/arm-linux-user-common.mak
@@ -0,0 +1,4 @@
+# Common arm*-linux-user CONFIG defines
+
+# CONFIG_SEMIHOSTING is always required on this architecture
+CONFIG_SEMIHOSTING=3Dy
diff --git a/default-configs/arm-linux-user.mak b/default-configs/arm-linux=
-user.mak
index 413361a022..7d45e4d20a 100644
--- a/default-configs/arm-linux-user.mak
+++ b/default-configs/arm-linux-user.mak
@@ -1 +1,3 @@
 # Default configuration for arm-linux-user
+
+include arm-linux-user-common.mak
diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.=
mak
index 36a0e89daa..8b89d8c4c0 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -1,5 +1,8 @@
 # Default configuration for arm-softmmu
=20
+# CONFIG_SEMIHOSTING is always required on this architecture
+CONFIG_SEMIHOSTING=3Dy
+
 # TODO: ARM_V7M is currently always required - make this more flexible!
 CONFIG_ARM_V7M=3Dy
=20
@@ -40,5 +43,4 @@ CONFIG_MICROBIT=3Dy
 CONFIG_FSL_IMX25=3Dy
 CONFIG_FSL_IMX7=3Dy
 CONFIG_FSL_IMX6UL=3Dy
-CONFIG_SEMIHOSTING=3Dy
 CONFIG_ALLWINNER_H3=3Dy
diff --git a/default-configs/armeb-linux-user.mak b/default-configs/armeb-l=
inux-user.mak
index bf2ffe7038..485132f606 100644
--- a/default-configs/armeb-linux-user.mak
+++ b/default-configs/armeb-linux-user.mak
@@ -1 +1,3 @@
 # Default configuration for armeb-linux-user
+
+include arm-linux-user-common.mak
--=20
2.21.1


