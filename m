Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D8FC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:44:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ABE620656
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V6wKG60P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ABE620656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOOfu-0004bR-FG
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 12:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55924)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOOaY-0002Rr-Iw
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:39:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOOaX-0004yt-Eh
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:39:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56346
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOOaW-0004yG-DP
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:39:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586882343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uTz3KcJlNsaV83gD8WOBIeR47sdCWtE05dPDmVPpmB4=;
 b=V6wKG60PZidT77mqvK4xHklw/QPxNpArZ0gTODLxgzSk2/VwauNEE/6JjF233YHyWxaRQw
 p4LTsruChkBqjdhswgmORxq6gcVxzBe5IbobwwQ0syNKD3zkmXYaEvXTp1gUi3o48XyD+p
 NY1ii4QqtGCBYBch3oFqBroBla5QE5o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-yt9V2ageO_aleN7rSZpbtA-1; Tue, 14 Apr 2020 12:39:02 -0400
X-MC-Unique: yt9V2ageO_aleN7rSZpbtA-1
Received: by mail-wm1-f70.google.com with SMTP id t62so4527501wma.0
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 09:39:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0U0eCjik1vGrpyxoZhXD2gNf3y9hyHhyj+DOXzp6ISo=;
 b=biuf1zMBLpHVMM6mR6ukFlJm2TrSl7ZX8yR2aQ7u4q/yuActukQGhNC65VNNPHcLgf
 hW2PaiX0vvn0JCbgWfiy/qhIl1UPHzYJvgxVpqkhp2bUtAY9q1ti7bUWK2R0aS9Xx/Bg
 uOHiUN+GnyLqYeQTNQmiZxsy2Dbw34Fs8AbuzYV4Vs73i2cn2Rdf7PFL7AGC1ol1hVoo
 W6AAZjXAizEK37D0Zrqx3HPA07NpQJf9+ZF3KAXqdg0ICdasya7dXmZPDo5jLBItGkNH
 m5Vhlm5WE7c0xIxhaPMfCoEQLK/6SwGc8dRckR//NphoovbkH0aIRBrIK5MfLjEiMJqr
 9kGw==
X-Gm-Message-State: AGi0PuYjiwOTbI1RaV8Baz4nkoNdWb0rHXYmDhVThRyO6yEIv//Mo4zR
 0eCAe8ALWHliTHoLKKnfHxFyQU+1qWSdfs1PMqjx09nRx617Ke99h9y7uMIVVd73Hi3RPnnq0/R
 ipfk8sLcGqxLLrl0=
X-Received: by 2002:a05:6000:8f:: with SMTP id
 m15mr21488084wrx.19.1586882340604; 
 Tue, 14 Apr 2020 09:39:00 -0700 (PDT)
X-Google-Smtp-Source: APiQypKgPqfzGoFMleiKmVQw3PAx05Z2Sh+q2EwkDaLefCqAgbJXI5czyX5f1i7P6KprNahM53ZS3g==
X-Received: by 2002:a05:6000:8f:: with SMTP id
 m15mr21488068wrx.19.1586882340443; 
 Tue, 14 Apr 2020 09:39:00 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id v19sm14240210wra.57.2020.04.14.09.38.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 09:38:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 v3 1/2] gdbstub: Introduce gdb_get_float32() to get
 32-bit float registers
Date: Tue, 14 Apr 2020 18:38:52 +0200
Message-Id: <20200414163853.12164-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200414163853.12164-1-philmd@redhat.com>
References: <20200414163853.12164-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since we now use a GByteArray, we can not use stfl_p() directly.
Introduce the gdb_get_float32() helper to load a float32 register.

Fixes: a010bdbe719 ("extend GByteArray to read register helpers")
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v3: Use buf[sizeof(CPU_FloatU)] (rth)
---
 include/exec/gdbstub.h | 10 ++++++++++
 target/sh4/gdbstub.c   |  6 ++----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index b52d9933ee..0891d93de2 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -125,6 +125,16 @@ static inline int gdb_get_reg128(GByteArray *buf, uint=
64_t val_hi,
     return 16;
 }
=20
+static inline int gdb_get_float32(GByteArray *array, float32 val)
+{
+    uint8_t buf[sizeof(CPU_FloatU)];
+
+    stfl_p(buf, val);
+    g_byte_array_append(array, buf, sizeof(buf));
+
+    return sizeof(buf);
+}
+
 static inline int gdb_get_zeroes(GByteArray *array, size_t len)
 {
     for (size_t i =3D 0; i < len; i++) {
diff --git a/target/sh4/gdbstub.c b/target/sh4/gdbstub.c
index 49fc4a0cc6..34ad3ca050 100644
--- a/target/sh4/gdbstub.c
+++ b/target/sh4/gdbstub.c
@@ -58,11 +58,9 @@ int superh_cpu_gdb_read_register(CPUState *cs, GByteArra=
y *mem_buf, int n)
         return gdb_get_regl(mem_buf, env->fpscr);
     case 25 ... 40:
         if (env->fpscr & FPSCR_FR) {
-            stfl_p(mem_buf, env->fregs[n - 9]);
-        } else {
-            stfl_p(mem_buf, env->fregs[n - 25]);
+            return gdb_get_float32(mem_buf, env->fregs[n - 9]);
         }
-        return 4;
+        return gdb_get_float32(mem_buf, env->fregs[n - 25]);
     case 41:
         return gdb_get_regl(mem_buf, env->ssr);
     case 42:
--=20
2.21.1


