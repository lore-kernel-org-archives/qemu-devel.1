Return-Path: <SRS0=aI0a=ZQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55566C432C0
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2019 05:13:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F8A12075E
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2019 05:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LL2j4A3T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F8A12075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYkD3-0007Zi-At
	for qemu-devel@archiver.kernel.org; Sun, 24 Nov 2019 00:13:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60563)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1iYk3S-0003xw-CG
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 00:03:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1iYk3R-0007er-8h
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 00:03:26 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52661)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1iYk3R-0007ea-2i
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 00:03:25 -0500
Received: by mail-wm1-x342.google.com with SMTP id l1so11726538wme.2
 for <qemu-devel@nongnu.org>; Sat, 23 Nov 2019 21:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GlC9DNfd17iXYoIYbyFaU4VN/Ub98bGub2GAS49SvrY=;
 b=LL2j4A3TNww+ee9nklZWIp7pVRshHKjY04aNeAzAgOGV00BJY0xOF4J5AoqO4gBxOv
 vlOxtrrZ2hcOgiGumNJkxN90QGiZJZ2b+TZUxbg+y2M7O65ARgiRmyWMEyRndM9e7WZ/
 dcXNtB89a7d/TfzdmpSiRGzlLR6x/BzCVBIDJ26zy+9wn1HKo+Rukqd9MbmAJiVkMjP7
 wEHxWDo/5waRhTu/ym72rR7CjzZaDcZHnOd9XcQ8FqdBJ4JnRv0LkpEthD44Lhs3/RYB
 /ab6W7mjCrTK65TrzTEjxjfkQ4HNewqbeZXJSpdhqQcCTxaGFwf3uYaxu7OtgA4ueGR6
 Egyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GlC9DNfd17iXYoIYbyFaU4VN/Ub98bGub2GAS49SvrY=;
 b=Ad33ac6SjboipjUCSis/eDdlYKtl9lhVHzvLnHxPePqhPxF+3zuXznmRWnsCJc2fua
 hH2lUt6blqMJxl7GQzhmWwlwOeTEFq47rBRjvabN6CrvIB9oKCqIPvj53HkeAasghg8m
 YWZhrFdQ7twcStWgoWLYV7b4rGL+eoiXkERd1xeGg2FL7v3J5IA5XOdtsYJksk55crjP
 5z8AsVIGq1oijL8tWwfCSzkOt7aX8LJAUeAUNPgtgiiUhDBYuc2tJkvIQYLrdCPf86dg
 aHa18IOk5tnujJuntus/hCaYRPST2y2I4Mxrq6Gh+628LVCOOkj2J1OF9+gVWiGZw05G
 WWew==
X-Gm-Message-State: APjAAAXsr86fCVO1Zru8V5d0je0BdiBBaSnQvPqCfQhrh+6rZAOilKVF
 u3P9Xw75HkNrz6PDiwKXAl8smEoqt8erPiuO
X-Google-Smtp-Source: APXvYqz4xAyO6lEwDyuYGIM45wN2oWIaa+QpQ+/gZCToPOJCa54mf677j15EU8jhAbC1D4nNQaNz0w==
X-Received: by 2002:a05:600c:214a:: with SMTP id
 v10mr23315930wml.102.1574571803692; 
 Sat, 23 Nov 2019 21:03:23 -0800 (PST)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-79-178-10-38.red.bezeqint.net. [79.178.10.38])
 by smtp.gmail.com with ESMTPSA id t185sm4173976wmf.45.2019.11.23.21.03.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sat, 23 Nov 2019 21:03:23 -0800 (PST)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v36 15/17] target/avr: Add boot serial test
Date: Sun, 24 Nov 2019 07:02:23 +0200
Message-Id: <20191124050225.30351-16-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20191124050225.30351-1-mrolnik@gmail.com>
References: <20191124050225.30351-1-mrolnik@gmail.com>
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
Cc: thuth@redhat.com, Michael Rolnik <mrolnik@gmail.com>,
 richard.henderson@linaro.org, dovgaluk@ispras.ru, imammedo@redhat.com,
 philmd@redhat.com, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Print out 'T' through serial port

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
---
 tests/boot-serial-test.c | 10 ++++++++++
 tests/Makefile.include   |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index d3a54a0ba5..1121ed0db2 100644
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
@@ -16,6 +16,15 @@
 #include "qemu/osdep.h"
 #include "libqtest.h"
 
+static const uint8_t bios_avr[] = {
+    0x88, 0xe0,             /* ldi r24, 0x08   */
+    0x80, 0x93, 0xc1, 0x00, /* sts 0x00C1, r24 ; Enable tx */
+    0x86, 0xe0,             /* ldi r24, 0x06   */
+    0x80, 0x93, 0xc2, 0x00, /* sts 0x00C2, r24 ; Set the data bits to 8 */
+    0x84, 0xe5,             /* ldi r24, 0x54   */
+    0x80, 0x93, 0xc6, 0x00, /* sts 0x00C6, r24 ; Output 'T' */
+};
+
 static const uint8_t kernel_mcf5208[] = {
     0x41, 0xf9, 0xfc, 0x06, 0x00, 0x00,     /* lea 0xfc060000,%a0 */
     0x10, 0x3c, 0x00, 0x54,                 /* move.b #'T',%d0 */
@@ -103,6 +112,7 @@ typedef struct testdef {
 
 static testdef_t tests[] = {
     { "alpha", "clipper", "", "PCI:" },
+    { "avr", "sample", "", "T", sizeof(bios_avr), NULL, bios_avr },
     { "ppc", "ppce500", "", "U-Boot" },
     { "ppc", "40p", "-vga none -boot d", "Trying cd:," },
     { "ppc", "g3beige", "", "PowerPC,750" },
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 8566f5f119..3e18e5770c 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -208,6 +208,8 @@ check-qtest-i386-y += tests/test-x86-cpuid-compat$(EXESUF)
 check-qtest-i386-y += tests/numa-test$(EXESUF)
 check-qtest-x86_64-y += $(check-qtest-i386-y)
 
+check-qtest-avr-y += tests/boot-serial-test$(EXESUF)
+
 check-qtest-alpha-y += tests/boot-serial-test$(EXESUF)
 check-qtest-alpha-$(CONFIG_VGA) += tests/display-vga-test$(EXESUF)
 
-- 
2.17.2 (Apple Git-113)


