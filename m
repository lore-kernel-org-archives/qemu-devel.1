Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D671C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:49:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2844F2073C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I/i8fiSJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2844F2073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2FoG-0004id-Ab
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 09:49:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60178)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fgs-0004IX-Id
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fgn-0001dr-9d
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:06 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:42491)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2Fgm-0001cA-Vv
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:01 -0500
Received: by mail-wr1-x431.google.com with SMTP id k11so6970753wrd.9
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 06:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ymk2zAkPGglw3fo24eTj2ydWCethPALcQIEH22v1sZw=;
 b=I/i8fiSJougR6RABTZVGoceo3DrI1IkyrqGczBJuznsgNfmfYIYV6o7FiwGZJomr46
 cu55j1Yd7gxKJBvJHD8GZvCayKmwFYtFPIqxhvjXDYDkoQ+1P27fI/oiz22e5BDg8js7
 aDhbYH617HZlUGPPPV9c1bRRw9zS3HXC6IZJKAXNhjHj5CX6xev3ZTemi1EnpEvgCA+G
 eQPFx7Cx+KoSsA9Ursw265OdvA4DudM5GOvmqBZNQtawT9kE11hQjbEr/6PTpFBKQ66P
 Pa+l+pyBNQ/I3J3U7VOEr/Z7cQPZW5FSiaG+PFM8MBZ/NKBC/i//QtaE6YcIlO8qhnNu
 M+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ymk2zAkPGglw3fo24eTj2ydWCethPALcQIEH22v1sZw=;
 b=g5dxqqlqoucrA2prGBU0PTrbHtbyZL/uK002vACtN+j1UUGapjRbUEhqzvFHoDY5jR
 +R9Yq9bkBS1MnjcuNWf0VctO7+qAVdQQd0j/IqDRmxseig9Bl5dPz8CEmJ/U3JQ7zhZx
 xFuc3H8vMHDSBBi/3fvPw9jOaXdIVyhen6g5Sl1++no7YgIUwc/Uz7rlVJFqmQ8fgGMt
 zpmLU0sa7mmtiI7jt7gXdAy/OY8KShhvsVvnNNmSXRk8FGK9g1suXvK9wUG+QpIpLrrj
 7m9Z3kPv237F4YkS1BJ/dZfqwZlmxpoHA1Zp2Q0011Uxrt2yJBPwKcDdKqHYvfKXOt97
 sl5A==
X-Gm-Message-State: APjAAAWjhTUm5Hz61pWVwzl4GeF6ARGeUl8UhW2oF9qfHsnquYvgVPT/
 exwVAJlDb2MNfNhCo+LZQuihRKhKWJM=
X-Google-Smtp-Source: APXvYqwTSjJz3txwgUwTybxm7JGzvAbza99+yiias421wKONb24dahMlW8g1ZA6Cp3xfcAPnYqNweg==
X-Received: by 2002:adf:df90:: with SMTP id z16mr21596721wrl.273.1581604918870; 
 Thu, 13 Feb 2020 06:41:58 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e22sm3362454wme.45.2020.02.13.06.41.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 06:41:58 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/46] virt/acpi: update golden masters for DSDT update
Date: Thu, 13 Feb 2020 14:41:08 +0000
Message-Id: <20200213144145.818-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213144145.818-1-peter.maydell@linaro.org>
References: <20200213144145.818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Heyi Guo <guoheyi@huawei.com>

Differences between disassembled ASL files:

@@ -5,13 +5,13 @@
  *
  * Disassembling to symbolic ASL+ operators
  *
- * Disassembly of DSDT, Thu Jan 23 16:00:04 2020
+ * Disassembly of DSDT.new, Thu Jan 23 16:47:12 2020
  *
  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x0000481E (18462)
+ *     Length           0x000014BB (5307)
  *     Revision         0x02
- *     Checksum         0x60
+ *     Checksum         0xD1
  *     OEM ID           "BOCHS "
  *     OEM Table ID     "BXPCDSDT"
  *     OEM Revision     0x00000001 (1)
@@ -43,7 +43,6 @@ DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPCDSDT", 0x00000001)
                     0x00000021,
                 }
             })
-            Name (_ADR, 0x09000000)  // _ADR: Address
         }

         Device (FLS0)
@@ -668,11 +667,10 @@ DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPCDSDT", 0x00000001)
             Name (_CID, "PNP0A03" /* PCI Bus */)  // _CID: Compatible ID
             Name (_SEG, Zero)  // _SEG: PCI Segment
             Name (_BBN, Zero)  // _BBN: BIOS Bus Number
-            Name (_ADR, Zero)  // _ADR: Address
             Name (_UID, "PCI0")  // _UID: Unique ID
             Name (_STR, Unicode ("PCIe 0 Device"))  // _STR: Description String
             Name (_CCA, One)  // _CCA: Cache Coherency Attribute
-            Name (_PRT, Package (0x0400)  // _PRT: PCI Routing Table
+            Name (_PRT, Package (0x80)  // _PRT: PCI Routing Table
             {
                 Package (0x04)
                 {
@@ -1696,7174 +1694,6 @@ DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPCDSDT", 0x00000001)
                     0x03,
                     GSI2,
                     Zero
-                },
-
-                Package (0x04)
-                {
-                    0x0020FFFF,
-                    Zero,
-                    GSI0,
-                    Zero
-                },
-
-                *Omit the other (4 * (256 - 32) - 2) packages*
-
-                Package (0x04)
-                {
-                    0x00FFFFFF,
-                    0x03,
-                    GSI2,
-                    Zero
                 }
             })
             Device (GSI0)
@@ -8892,7 +1722,7 @@ DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPCDSDT", 0x00000001)
             Device (GSI1)
             {
                 Name (_HID, "PNP0C0F" /* PCI Interrupt Link Device */)  // _HID: Hardware ID
-                Name (_UID, Zero)  // _UID: Unique ID
+                Name (_UID, One)  // _UID: Unique ID
                 Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
                 {
                     Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
@@ -8915,7 +1745,7 @@ DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPCDSDT", 0x00000001)
             Device (GSI2)
             {
                 Name (_HID, "PNP0C0F" /* PCI Interrupt Link Device */)  // _HID: Hardware ID
-                Name (_UID, Zero)  // _UID: Unique ID
+                Name (_UID, 0x02)  // _UID: Unique ID
                 Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
                 {
                     Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
@@ -8938,7 +1768,7 @@ DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPCDSDT", 0x00000001)
             Device (GSI3)
             {
                 Name (_HID, "PNP0C0F" /* PCI Interrupt Link Device */)  // _HID: Hardware ID
-                Name (_UID, Zero)  // _UID: Unique ID
+                Name (_UID, 0x03)  // _UID: Unique ID
                 Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
                 {
                     Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
@@ -8965,37 +1795,6 @@ DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPCDSDT", 0x00000001)

             Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
             {
-                Name (RBUF, ResourceTemplate ()
-                {
-                    WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
-                        0x0000,             // Granularity
-                        0x0000,             // Range Minimum
-                        0x00FF,             // Range Maximum
-                        0x0000,             // Translation Offset
-                        0x0100,             // Length
-                        ,, )
-                    DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
-                        0x00000000,         // Granularity
-                        0x10000000,         // Range Minimum
-                        0x3EFEFFFF,         // Range Maximum
-                        0x00000000,         // Translation Offset
-                        0x2EFF0000,         // Length
-                        ,, , AddressRangeMemory, TypeStatic)
-                    DWordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
-                        0x00000000,         // Granularity
-                        0x00000000,         // Range Minimum
-                        0x0000FFFF,         // Range Maximum
-                        0x3EFF0000,         // Translation Offset
-                        0x00010000,         // Length
-                        ,, , TypeStatic, DenseTranslation)
-                    QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
-                        0x0000000000000000, // Granularity
-                        0x0000008000000000, // Range Minimum
-                        0x000000FFFFFFFFFF, // Range Maximum
-                        0x0000000000000000, // Translation Offset
-                        0x0000008000000000, // Length
-                        ,, , AddressRangeMemory, TypeStatic)
-                })
                 Return (ResourceTemplate ()
                 {
                     WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
@@ -9080,11 +1879,6 @@ DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPCDSDT", 0x00000001)
                 })
             }

-            Device (RP0)
-            {
-                Name (_ADR, Zero)  // _ADR: Address
-            }
-
             Device (RES0)
             {
                 Name (_HID, "PNP0C02" /* PNP Motherboard Resources */)  // _HID: Hardware ID
@@ -9131,7 +1925,6 @@ DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPCDSDT", 0x00000001)
         Device (PWRB)
         {
             Name (_HID, "PNP0C0C" /* Power Button Device */)  // _HID: Hardware ID
-            Name (_ADR, Zero)  // _ADR: Address
             Name (_UID, Zero)  // _UID: Unique ID
         }
     }

The differences between the two versions of DSDT.memhp are almost the
same as the above, except for total length and checksum.

DSDT.numamem binary is just the same with DSDT on virt machine, so we
don't show the differences again.

Signed-off-by: Heyi Guo <guoheyi@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-id: 20200204014325.16279-8-guoheyi@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/bios-tables-test-allowed-diff.h |   3 ---
 tests/data/acpi/virt/DSDT                   | Bin 18462 -> 5307 bytes
 tests/data/acpi/virt/DSDT.memhp             | Bin 19799 -> 6644 bytes
 tests/data/acpi/virt/DSDT.numamem           | Bin 18462 -> 5307 bytes
 4 files changed, 3 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 32a401ae35f..dfb8523c8bf 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,4 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/virt/DSDT",
-"tests/data/acpi/virt/DSDT.memhp",
-"tests/data/acpi/virt/DSDT.numamem",
diff --git a/tests/data/acpi/virt/DSDT b/tests/data/acpi/virt/DSDT
index d0f3afeb134fdf1c11f64cd06dbcdd30be603b80..d6f5c617881c4247f55d4dcd06581f9693916b2f 100644
GIT binary patch
delta 156
zcmbO?fpNDcmrJlq$Zin^2BwP>xulufJQ*iyC^K43^tIeLL4lLWeZ}O>oO+X=b6T<Z
z6mvCfR_C%{pDgc^#>hCi&BajKi^V<I(}*M9!_$Q~z%RhS*}#o~BR<sAg^OwOMVP!X
lHhJdBGOmtnjvVpMLBX3Jy81CrwsAkqC^^YPgaxRb0RT`TDiQzy

literal 18462
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
A00000

diff --git a/tests/data/acpi/virt/DSDT.memhp b/tests/data/acpi/virt/DSDT.memhp
index 41ccc6431b917252bcbaac86c33b340c796be5ce..c527ac4739af3df3c3e042bf91c412033a2b73c3 100644
GIT binary patch
delta 173
zcmcaUi}8ywmrJlq$QMZl2ByY|T++<_a~LOTC^K43^tIeLL4lLWeZ}O>oO+X=b6T<Z
z6mvCfR_C%{pDgc^#>hCi&BajKi^V<I(}*M9!_$Q~z%RhS*}#o~BR<sAg^OwOMVP!X
pHhJdBGOmtnjvVpMLBX3Jy81D0wsHT%Dk&Kd9^{0q-Wg&Z0|3#tFC_o~

literal 19799
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
DDbP3`

diff --git a/tests/data/acpi/virt/DSDT.numamem b/tests/data/acpi/virt/DSDT.numamem
index d0f3afeb134fdf1c11f64cd06dbcdd30be603b80..d6f5c617881c4247f55d4dcd06581f9693916b2f 100644
GIT binary patch
delta 156
zcmbO?fpNDcmrJlq$Zin^2BwP>xulufJQ*iyC^K43^tIeLL4lLWeZ}O>oO+X=b6T<Z
z6mvCfR_C%{pDgc^#>hCi&BajKi^V<I(}*M9!_$Q~z%RhS*}#o~BR<sAg^OwOMVP!X
lHhJdBGOmtnjvVpMLBX3Jy81CrwsAkqC^^YPgaxRb0RT`TDiQzy

literal 18462
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
A00000

-- 
2.20.1


