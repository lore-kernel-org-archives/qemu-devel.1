Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91696C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 11:19:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AEAD206B6
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 11:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GHOsC7AD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AEAD206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOJba-000532-Gi
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 07:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53653)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOJah-0004dV-SR
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 07:18:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOJag-0004ab-BR
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 07:18:55 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43862
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOJag-0004Ys-6z
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 07:18:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586863133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uSbWWFpCYDQW/mn8qaE3YF/Tqc06dP5p+nRREUUssvg=;
 b=GHOsC7ADcsUiAN/weQKIf/y2MRtSqlcNjvYlllVy8PxXwCV2/4iTnnH9pdiu1rrMkJS7dr
 dH2137HeBqZPsFDnApRHpUZK2uBfTvKZ7Oz5JKuln3DWnILeagZzd82pZHszG2kV49rptH
 99TbiyXVqn9scUSCGWehk72JajkykNE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-PPO84TuFME6hhkxnyUNZZQ-1; Tue, 14 Apr 2020 07:18:49 -0400
X-MC-Unique: PPO84TuFME6hhkxnyUNZZQ-1
Received: by mail-wr1-f69.google.com with SMTP id o12so5436379wra.14
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 04:18:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fxPhu/NQir7Rf+ELHL0Z/YidSVTKuDiieyOLHp4ILI8=;
 b=hlac2rN9BWs9a83Ulid741cgILKnMS2kEXq5J2TRlYs/PZVLWZ8WZA+T6/9j6TgnvL
 M7GOxz3KwNWKRYI9eeHOa4gRsZ9m9O5muoXREPn0b1FtvYDOlby8Wv66hWtRJ2p6LW1w
 so8izlLVZjpGNmX9PSYpYyktMLt/kf2yUEAocvZKJu3cCGwJYF1FlQKidQIvGoTx5K4L
 4xr62fZjU3ATHHb3aokPiD+fC/mj+LM5e3nHcf6tqG7Ivg3CeUdC21qq3y0B19mxXMCf
 vFDErOrwWu+7b6EPfbdqnTABQTQrXEKaGFm5MZFuRU0PeKXLnAPQJLBdDhO4MPSpPuaT
 hDkQ==
X-Gm-Message-State: AGi0PubnjccrpyrYF8zM62VW7SXATw9JeJptMRr/wkrNLmq756tJPeRE
 +rgu5gP7fgmaJ+YTlw5x6AngI7wuSF5HqLtIJfFz6cLetNekueZZEDGD9LhFD7qTfNVqBY9Tz/m
 6sU1wrAHoo/pAAs8=
X-Received: by 2002:adf:97cc:: with SMTP id t12mr22076929wrb.261.1586863128241; 
 Tue, 14 Apr 2020 04:18:48 -0700 (PDT)
X-Google-Smtp-Source: APiQypKQdk1+3ylNl5G8mUajlUMODYRjk0vdmq5B6g6Q/DWx+/O0R/70havUA9PeqqWLHG3MPEv/XA==
X-Received: by 2002:adf:97cc:: with SMTP id t12mr22076914wrb.261.1586863127935; 
 Tue, 14 Apr 2020 04:18:47 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id n124sm18742413wma.11.2020.04.14.04.18.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 04:18:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0] gdbstub: Introduce gdb_get_freg32() to get float32
 registers
Date: Tue, 14 Apr 2020 13:18:46 +0200
Message-Id: <20200414111846.27495-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since we now use a GByteArray, we can not use stfl_p() directly.
Introduce the gdb_get_freg32() helper to load a float32 register.

Fixes: a010bdbe719 ("extend GByteArray to read register helpers")
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Based-on: <20200414102427.7459-1-philmd@redhat.com>
---
 include/exec/gdbstub.h | 12 ++++++++++++
 target/sh4/gdbstub.c   |  6 ++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index b52d9933ee..52a4a936c6 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -125,6 +125,18 @@ static inline int gdb_get_reg128(GByteArray *buf, uint=
64_t val_hi,
     return 16;
 }
=20
+static inline int gdb_get_freg32(GByteArray *array, float32 val)
+{
+    uint8_t buf[4];
+
+    QEMU_BUILD_BUG_ON(sizeof(CPU_FloatU) !=3D sizeof(buf));
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
index 49fc4a0cc6..da95205889 100644
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
+            return gdb_get_freg32(mem_buf, env->fregs[n - 9]);
         }
-        return 4;
+        return gdb_get_freg32(mem_buf, env->fregs[n - 25]);
     case 41:
         return gdb_get_regl(mem_buf, env->ssr);
     case 42:
--=20
2.21.1


