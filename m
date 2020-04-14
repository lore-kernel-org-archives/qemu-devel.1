Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A938BC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:46:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7716F20656
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KhGVGS9T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7716F20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOOhz-0008AG-2C
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 12:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55944)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOOaZ-0002Rw-98
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:39:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOOaX-0004yn-Do
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:39:07 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33813
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOMcM-0008OK-MN
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 10:32:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586874770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jZFQWRRmxtz/+WJb6IoMnCqiX+d+hiM5esZ7aEbtiwQ=;
 b=KhGVGS9TfGMu3COn6xivi7adq9AGedbCFbnkw5hhyGsPJbwlwQDVfkObWP9RkH3+ih1RQT
 YyFBuCsnWvCFuSaCgdBiEQ0MWDKsO4zB6ReXvqGVoZvHv5DHW7OBfdOAOGFGdnpKJS++dH
 Yfzat1Bs3yQXf67ECFBgmLY9kJP0/qY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-qUQHiY10NBu-t4hrxPPKOw-1; Tue, 14 Apr 2020 10:32:48 -0400
X-MC-Unique: qUQHiY10NBu-t4hrxPPKOw-1
Received: by mail-wm1-f72.google.com with SMTP id f128so2709747wmf.8
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 07:32:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HAo29GLrra0kpb4F1uXdTWM4Afqo9zSyzRKdzK333tk=;
 b=sZ9DykTVNzBuTbyO+dsXvJ/0K9FQxn0f8HAtVRkG1RMIMrXO0p3d8yX7ZgLcajtvOf
 3/qUeaXOZqmJ11666q4Q65y5PKRXO3eiqWJMzNcysXv0zUWb1L6r3hlakyE9Vl7LusOg
 KvSqtMf0aBBloJ5DDKlw5xH16g0UIcNAw1TlXznT8DDmZsI6E4wRCXmTMh3p/Ro9OrF0
 FPE8FVUAyKWvLn+nIa+j8xZy0/bkKT07bJu8bzpfI54Mc4mJcR2kOG5GUNlIvlO4ghQO
 1v9EemJ4RJU9zeSBq2GN6xNxYshZXopkrR3TSBxkbyH1869ZhinyhX+qFkKNtxBoJCiY
 GCvA==
X-Gm-Message-State: AGi0PuYrZtuxE8ZY/eWEORtKnziHYMGJKB+83+B186/pDfH9Kawng90j
 sQSchln31UCKw6i55YujV8TP47A4RUy26omhLIcFUCKJc4pAJkvUkOPFjHsXKCzRWsISOyS9eqG
 sMXtkpx6hSleaJaU=
X-Received: by 2002:adf:a28e:: with SMTP id s14mr24415311wra.208.1586874767229; 
 Tue, 14 Apr 2020 07:32:47 -0700 (PDT)
X-Google-Smtp-Source: APiQypLHS0bba7RmEtN2KcWQoHYvsJgHuCQB69zdd8+XPbm4MFrJ7/34QQ3kTKMSoLwdTARLmYLJ7w==
X-Received: by 2002:adf:a28e:: with SMTP id s14mr24415298wra.208.1586874767069; 
 Tue, 14 Apr 2020 07:32:47 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id f3sm19476741wmj.24.2020.04.14.07.32.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 07:32:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 v2 1/2] gdbstub: Introduce gdb_get_float32() to get
 32-bit float registers
Date: Tue, 14 Apr 2020 16:32:39 +0200
Message-Id: <20200414143240.21764-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200414143240.21764-1-philmd@redhat.com>
References: <20200414143240.21764-1-philmd@redhat.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
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
 include/exec/gdbstub.h | 12 ++++++++++++
 target/sh4/gdbstub.c   |  6 ++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index b52d9933ee..3caca99416 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -125,6 +125,18 @@ static inline int gdb_get_reg128(GByteArray *buf, uint=
64_t val_hi,
     return 16;
 }
=20
+static inline int gdb_get_float32(GByteArray *array, float32 val)
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


