Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27102C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 08:49:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E03E12075F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 08:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WFAeKTLQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E03E12075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeEEL-0001np-5T
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 04:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jeEDU-0001MT-N5
 for qemu-devel@nongnu.org; Thu, 28 May 2020 04:48:44 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40352
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jeEDT-0001jV-5n
 for qemu-devel@nongnu.org; Thu, 28 May 2020 04:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590655722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vlfuHql+8IeO3+3Jckexjq8hpWK92Wqi8Q8IsIPFSKw=;
 b=WFAeKTLQ6vHGdMAkbY35SXXFq5r3ZV02UgrWvDtGCiKOKsc0t8diH0W7OenolzMNc5Pbvl
 cVsoWBDVq7kaDFaQ0LxgL9NUVZYow8KpHe7837XJZ1bIi4CQky3Gn+LLCvkCueZHj9ki6C
 Aq5fZgeExGNUzr1NfW3azFSOr0gesd8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-pk7jfKpPPMqkEtAwllOAaA-1; Thu, 28 May 2020 04:48:37 -0400
X-MC-Unique: pk7jfKpPPMqkEtAwllOAaA-1
Received: by mail-wr1-f71.google.com with SMTP id l1so8648816wrc.8
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 01:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vlfuHql+8IeO3+3Jckexjq8hpWK92Wqi8Q8IsIPFSKw=;
 b=n/feulLJPMxST+NWwIkBMPMF7Z+8iTWFf341qEZamKewyRhB6mOM33jSb90ED+NgCT
 ByOylHLUcP/6wWSj2hVlnXZxlcFH6TWhnaxpk0Urc1D/i9OO3v+Wr/oUfcYeRCVTsvRA
 bgjnerrVpcjLjEd4hJjPhSJuR0miud2a4f9lgdgCpku+5BVX9MCI7xbXhMBeyQFirLPA
 pLO5BMKLViILhQY1oUDofoAka3l/UQfaqv8nmEupusgMSYkAeHHCn6iC/RLUwfzOdMZE
 lXGNbxHZ5ubJDlVjL00FCd3mruRng5B5uiPADmUr8pKZeyiZBvXiG35rLiRLsufL1KGa
 64Zw==
X-Gm-Message-State: AOAM531CbQELgwGbtP/9x2tBaFaxvscE9Q1ncKEet6gosi2CkUcTC5On
 oVe13+QLROthRAAQNhJ4wl4LrG/fR5AEKlU1QBZImX2Cbl47OaiKI1mnMPFg77w+avgquGmv3Mr
 rFlj6n9wv5pAMZIc=
X-Received: by 2002:a1c:8107:: with SMTP id c7mr2345451wmd.20.1590655716043;
 Thu, 28 May 2020 01:48:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbWu/flCzkTlhLtkyOf4v72yy/XjAkSFY8mjYKJeVXrFdMA6UkJ6ogU8KRDXDZd5GCVYeaaQ==
X-Received: by 2002:a1c:8107:: with SMTP id c7mr2345428wmd.20.1590655715724;
 Thu, 28 May 2020 01:48:35 -0700 (PDT)
Received: from localhost.localdomain (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id g10sm5200092wrx.4.2020.05.28.01.48.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 01:48:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] fpu/softfloat: Silent 'bitwise negation of a boolean
 expression' warning
Date: Thu, 28 May 2020 10:48:33 +0200
Message-Id: <20200528084833.9531-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 02:50:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When building with clang version 10.0.0-4ubuntu1, we get:

    CC      lm32-softmmu/fpu/softfloat.o
  fpu/softfloat.c:3365:13: error: bitwise negation of a boolean expression; did you mean logical negation? [-Werror,-Wbool-operation]
      absZ &= ~ ( ( ( roundBits ^ 0x40 ) == 0 ) & roundNearestEven );
              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  fpu/softfloat.c:3423:18: error: bitwise negation of a boolean expression; did you mean logical negation? [-Werror,-Wbool-operation]
          absZ0 &= ~ ( ( (uint64_t) ( absZ1<<1 ) == 0 ) & roundNearestEven );
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  fpu/softfloat.c:3483:18: error: bitwise negation of a boolean expression; did you mean logical negation? [-Werror,-Wbool-operation]
          absZ0 &= ~(((uint64_t)(absZ1<<1) == 0) & roundNearestEven);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  fpu/softfloat.c:3606:13: error: bitwise negation of a boolean expression; did you mean logical negation? [-Werror,-Wbool-operation]
      zSig &= ~ ( ( ( roundBits ^ 0x40 ) == 0 ) & roundNearestEven );
              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  fpu/softfloat.c:3760:13: error: bitwise negation of a boolean expression; did you mean logical negation? [-Werror,-Wbool-operation]
      zSig &= ~ ( ( ( roundBits ^ 0x200 ) == 0 ) & roundNearestEven );
              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  fpu/softfloat.c:3987:21: error: bitwise negation of a boolean expression; did you mean logical negation? [-Werror,-Wbool-operation]
                      ~ ( ( (uint64_t) ( zSig1<<1 ) == 0 ) & roundNearestEven );
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  fpu/softfloat.c:4003:22: error: bitwise negation of a boolean expression; did you mean logical negation? [-Werror,-Wbool-operation]
              zSig0 &= ~ ( ( (uint64_t) ( zSig1<<1 ) == 0 ) & roundNearestEven );
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  fpu/softfloat.c:4273:18: error: bitwise negation of a boolean expression; did you mean logical negation? [-Werror,-Wbool-operation]
          zSig1 &= ~ ( ( zSig2 + zSig2 == 0 ) & roundNearestEven );
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fix by rewriting the fishy bitwise AND of two bools as an int.

Suggested-by: Eric Blake <eblake@redhat.com>
Buglink: https://bugs.launchpad.net/bugs/1881004
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
v2: Resend without the Cc: "Toni Wilen <twilen@winuae.net>" tag
---
 fpu/softfloat.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 6c8f2d597a..0dd57eddd7 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -3362,7 +3362,9 @@ static int32_t roundAndPackInt32(bool zSign, uint64_t absZ,
     }
     roundBits = absZ & 0x7F;
     absZ = ( absZ + roundIncrement )>>7;
-    absZ &= ~ ( ( ( roundBits ^ 0x40 ) == 0 ) & roundNearestEven );
+    if (((roundBits ^ 0x40) == 0) && roundNearestEven) {
+        absZ &= ~1;
+    }
     z = absZ;
     if ( zSign ) z = - z;
     if ( ( absZ>>32 ) || ( z && ( ( z < 0 ) ^ zSign ) ) ) {
@@ -3420,7 +3422,9 @@ static int64_t roundAndPackInt64(bool zSign, uint64_t absZ0, uint64_t absZ1,
     if ( increment ) {
         ++absZ0;
         if ( absZ0 == 0 ) goto overflow;
-        absZ0 &= ~ ( ( (uint64_t) ( absZ1<<1 ) == 0 ) & roundNearestEven );
+        if (((absZ1 << 1) == 0) && roundNearestEven) {
+            absZ0 &= ~1;
+        }
     }
     z = absZ0;
     if ( zSign ) z = - z;
@@ -3480,7 +3484,9 @@ static int64_t roundAndPackUint64(bool zSign, uint64_t absZ0,
             float_raise(float_flag_invalid, status);
             return UINT64_MAX;
         }
-        absZ0 &= ~(((uint64_t)(absZ1<<1) == 0) & roundNearestEven);
+        if (((absZ1 << 1) == 0) && roundNearestEven) {
+            absZ0 &= ~1;
+        }
     }
 
     if (zSign && absZ0) {
@@ -3603,7 +3609,9 @@ static float32 roundAndPackFloat32(bool zSign, int zExp, uint32_t zSig,
         status->float_exception_flags |= float_flag_inexact;
     }
     zSig = ( zSig + roundIncrement )>>7;
-    zSig &= ~ ( ( ( roundBits ^ 0x40 ) == 0 ) & roundNearestEven );
+    if (((roundBits ^ 0x40) == 0) && roundNearestEven) {
+        zSig &= ~1;
+    }
     if ( zSig == 0 ) zExp = 0;
     return packFloat32( zSign, zExp, zSig );
 
@@ -3757,7 +3765,9 @@ static float64 roundAndPackFloat64(bool zSign, int zExp, uint64_t zSig,
         status->float_exception_flags |= float_flag_inexact;
     }
     zSig = ( zSig + roundIncrement )>>10;
-    zSig &= ~ ( ( ( roundBits ^ 0x200 ) == 0 ) & roundNearestEven );
+    if (((roundBits ^ 0x200) == 0) && roundNearestEven) {
+        zSig &= ~1;
+    }
     if ( zSig == 0 ) zExp = 0;
     return packFloat64( zSign, zExp, zSig );
 
@@ -3983,8 +3993,9 @@ floatx80 roundAndPackFloatx80(int8_t roundingPrecision, bool zSign,
             }
             if ( increment ) {
                 ++zSig0;
-                zSig0 &=
-                    ~ ( ( (uint64_t) ( zSig1<<1 ) == 0 ) & roundNearestEven );
+                if (((zSig1 << 1) == 0) && roundNearestEven) {
+                    zSig0 &= ~1;
+                }
                 if ( (int64_t) zSig0 < 0 ) zExp = 1;
             }
             return packFloatx80( zSign, zExp, zSig0 );
@@ -4000,7 +4011,9 @@ floatx80 roundAndPackFloatx80(int8_t roundingPrecision, bool zSign,
             zSig0 = UINT64_C(0x8000000000000000);
         }
         else {
-            zSig0 &= ~ ( ( (uint64_t) ( zSig1<<1 ) == 0 ) & roundNearestEven );
+            if (((zSig1 << 1) == 0) && roundNearestEven) {
+                zSig0 &= ~1;
+            }
         }
     }
     else {
@@ -4270,7 +4283,9 @@ static float128 roundAndPackFloat128(bool zSign, int32_t zExp,
     }
     if ( increment ) {
         add128( zSig0, zSig1, 0, 1, &zSig0, &zSig1 );
-        zSig1 &= ~ ( ( zSig2 + zSig2 == 0 ) & roundNearestEven );
+        if ((zSig2 + zSig2 == 0) && roundNearestEven) {
+            zSig1 &= ~1;
+        }
     }
     else {
         if ( ( zSig0 | zSig1 ) == 0 ) zExp = 0;
-- 
2.21.3


