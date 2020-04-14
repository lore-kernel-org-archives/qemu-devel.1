Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33192C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 17:27:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F194D20678
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 17:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LsUdJIZx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F194D20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOPKw-0004hy-7M
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 13:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOP2e-0001Pp-Bp
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 13:08:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOP2c-0007mY-VD
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 13:08:08 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52723
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOLfW-0008QO-FJ
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 09:32:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586871122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n59eKf+0oDoamY0gLsMDzHfLMPXzKnb/MCgiWXZhTz8=;
 b=LsUdJIZx68+f13Io4YQ8CITy7P4w1N6jtm9wWOKxt9BeTERKa5H6mfgCVJ4sAl9pjcmccy
 F541cxSUiDVhZStOZxp16uEV9jr6a4pt1ogZR+DERvE8sKjZza4CfOCOY4hNBORCfU5hxY
 gOLcq2lev21zPant6A5za6hjFP8lmYc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-Yf7dFgbKNairJ9qPhXYCfQ-1; Tue, 14 Apr 2020 09:32:00 -0400
X-MC-Unique: Yf7dFgbKNairJ9qPhXYCfQ-1
Received: by mail-wr1-f72.google.com with SMTP id v14so8693450wrq.13
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 06:31:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KS4zH+Aytjp2L30CAb1LBJ5X0HgAg1y2VGWQ+0RaCBU=;
 b=LGHxbv14d8TpJ/ls/5ozP+llI1kQ1rtygC0Vym6MjBjqtzTv2NvIcytHGRqlAWv0h/
 M5kwbiuUQd0EDQXat4baRKl6uo0C/ucB6D647quKpz8B3NSYTAkquVIkFQIqXupsf8X2
 zFjDf37V0KfBs80tJ3QCG0MJJ3RhEXbhpcUY3b8cE5Xh5zRH6O6Ec4kn8JiIlgMJAi9r
 Fvu7ENFNk9T/+VP6NEcxQNZCmDWY77aMbILJTG3ulhhtvj0CqB7OxW1q3G+WKJTOvhhf
 jpfd/IrpibvfUIWj+1cZde5Lh38Puz5VsSHZ3h2L65u05txiVhoKGBCErbDMTZGpmcQL
 ++5g==
X-Gm-Message-State: AGi0PuY5zgkCJSlkAIKOZz1Y+OwMxvKo5zxdEbM0iLsVJ8akrSzqkwJM
 3iPoyancjvyjAvzZWSZu8Ckxkw9qBS05B12WQmSqUBxSk0/jh6oTBr7CjbflqLVKOWvSaoVIRNg
 XOxJk5FpiO9WmukY=
X-Received: by 2002:a05:600c:a:: with SMTP id
 g10mr24285279wmc.153.1586871116613; 
 Tue, 14 Apr 2020 06:31:56 -0700 (PDT)
X-Google-Smtp-Source: APiQypL3uroLMeRg90QZWpGZ1WUFQokPTl6qoFHzPiMBF81f8x+sVHwBkls+HCO4GqUUhj2AY5KJiw==
X-Received: by 2002:a05:600c:a:: with SMTP id
 g10mr24285254wmc.153.1586871116450; 
 Tue, 14 Apr 2020 06:31:56 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a7sm2414016wrs.61.2020.04.14.06.31.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 06:31:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 12/12] gdbstub: Introduce gdb_get_freg32() to get
 float32 registers
Date: Tue, 14 Apr 2020 15:30:52 +0200
Message-Id: <20200414133052.13712-13-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200414133052.13712-1-philmd@redhat.com>
References: <20200414133052.13712-1-philmd@redhat.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Fabien Chouteau <chouteau@adacore.com>, Max Filippov <jcmvbkbc@gmail.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stafford Horne <shorne@gmail.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since we now use a GByteArray, we can not use stfl_p() directly.
Introduce the gdb_get_freg32() helper to load a float32 register.

Fixes: a010bdbe719 ("extend GByteArray to read register helpers")
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/exec/gdbstub.h | 12 ++++++++++++
 target/sh4/gdbstub.c   |  6 ++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index f44bdd2270..6d41234071 100644
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
     guint oldlen =3D array->len;
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


