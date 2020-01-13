Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD25BC33CAD
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 14:44:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8844E20678
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 14:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hdi3fy85"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8844E20678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir0wn-0006Zp-Kd
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 09:44:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42572)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tcminyard@gmail.com>) id 1ir0vk-0005qP-Q8
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 09:43:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tcminyard@gmail.com>) id 1ir0vi-0004PJ-NV
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 09:43:00 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:40323)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1ir0vi-0004OK-IZ
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 09:42:58 -0500
Received: by mail-ot1-x341.google.com with SMTP id w21so9111880otj.7
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 06:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=NgG8/oXKPfzZ5PXrBgXiek8H6KwYdNE5o1J3M+0kzq0=;
 b=Hdi3fy85Ly7Lhzq9j5HeO/JwhxCvodSJy89N7xYog1oiGIrFQUh860PqrE2NIt/UdX
 qhZk6u4TDiAuYfsgCjv4YH5kwc5VXAzg0xRE9DF3f5KxTNKpu2XSJs5kJufAm8UZqHko
 rpXZouVXak4EhIVF+F1NAQ4ToKYZaJaL+KA135VARli9haBybTsR+vpAgJdFKoW3E7ew
 /sDrmZmVbrK5Ud9EBk9+vTx/NAgy7hQFLBpztL+kcFIt6+g+ehxMNjBuQqDk9rh9r+4Y
 mzIP2LkyQY7ghK7ahOcToP06Gyi2RoZ9TcMsYwPsIxuMsIP+F/p2ijWK/fupa/UYchcr
 Cq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=NgG8/oXKPfzZ5PXrBgXiek8H6KwYdNE5o1J3M+0kzq0=;
 b=tnFMJRMW5LoLTqpnF5DurwlaHS+wX+iFFUv3eqN8si4rwAN5qYP9SQHsfjG2dHCIOh
 JHxbJ8fz7BPYzAKfipiby9+BSKCoREDdbAiW8FAaAVtCvulEOSdTPbkDHIuy2/0RvGFf
 TBscoXW5ooB+PDCOCRj42CnaZ8NrcEpM03seuh+NaVd32w6hxfQOoH5qwbwkVhZ9WlpP
 /F6Y50dXitVjXisjC14QDck0hk+dFV8Z3pHNkE5QEC6jHzZDtRCwFVG9qR+2Kw347AW0
 8SEqs61zK1C1j8xVSbUG6xEVgPw7243YjqvxGBJ5Z8lSvX+FRyub9wHlLfLShLsoI6St
 eUag==
X-Gm-Message-State: APjAAAX852U8MwIi4wBjZN55IidbnA2PqLBhfjk7goAEiQShYHQYaRNA
 NDqpelDB6Sn0svQgZl1JiA==
X-Google-Smtp-Source: APXvYqxc4UHFxt6FEXP+gId/gIkg4P+7lWnjkfQ1QA4bPixa0E0iQbTiNEc5mO/B9j4/IYJAuogF+w==
X-Received: by 2002:a9d:7ac9:: with SMTP id m9mr12491963otn.80.1578926577057; 
 Mon, 13 Jan 2020 06:42:57 -0800 (PST)
Received: from serve.minyard.net ([47.184.136.59])
 by smtp.gmail.com with ESMTPSA id j10sm4183075otr.64.2020.01.13.06.42.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2020 06:42:56 -0800 (PST)
Received: from t560.minyard.net (unknown
 [IPv6:2001:470:b8f6:1b:d74:b0ed:d755:2da5])
 by serve.minyard.net (Postfix) with ESMTPA id B5B15180050;
 Mon, 13 Jan 2020 14:42:55 +0000 (UTC)
From: minyard@acm.org
To: "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH] i386:acpi: Remove _HID from the SMBus ACPI entry
Date: Mon, 13 Jan 2020 08:42:28 -0600
Message-Id: <20200113144228.16660-1-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200113090515-mutt-send-email-mst@kernel.org>
References: <20200113090515-mutt-send-email-mst@kernel.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
 Corey Minyard <cminyard@mvista.com>, qemu-devel@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>, wanghaibin.wang@huawei.com,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Corey Minyard <cminyard@mvista.com>

Per the ACPI spec (version 6.1, section 6.1.5 _HID) it is not required
on enumerated buses (like PCI in this case), _ADR is required (and is
already there).  And the _HID value is wrong.  Linux appears to ignore
the _HID entry, but Windows 10 detects it as 'Unknown Device' and there
is no driver available.  See https://bugs.launchpad.net/qemu/+bug/1856724

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/i386/acpi-build.c             |   1 -
 tests/data/acpi/q35/DSDT         | Bin 7879 -> 7869 bytes
 tests/data/acpi/q35/DSDT.bridge  | Bin 7896 -> 7886 bytes
 tests/data/acpi/q35/DSDT.cphp    | Bin 8342 -> 8332 bytes
 tests/data/acpi/q35/DSDT.dimmpxm | Bin 9532 -> 9522 bytes
 tests/data/acpi/q35/DSDT.ipmibt  | Bin 7954 -> 7944 bytes
 tests/data/acpi/q35/DSDT.memhp   | Bin 9238 -> 9228 bytes
 tests/data/acpi/q35/DSDT.mmio64  | Bin 9009 -> 8999 bytes
 tests/data/acpi/q35/DSDT.numamem | Bin 7885 -> 7875 bytes
 9 files changed, 1 deletion(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 7b8da62d41..ab73a8f4c8 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1815,7 +1815,6 @@ static void build_smb0(Aml *table, I2CBus *smbus, int devnr, int func)
     Aml *scope = aml_scope("_SB.PCI0");
     Aml *dev = aml_device("SMB0");
 
-    aml_append(dev, aml_name_decl("_HID", aml_eisaid("APP0005")));
     aml_append(dev, aml_name_decl("_ADR", aml_int(devnr << 16 | func)));
     build_acpi_ipmi_devices(dev, BUS(smbus), "\\_SB.PCI0.SMB0");
     aml_append(scope, dev);
diff --git a/tests/data/acpi/q35/DSDT b/tests/data/acpi/q35/DSDT
index 77ea60ffed421c566138fe6341421f579129a582..1f91888d7a485850cf27f152e247a90b208003dc 100644
GIT binary patch
delta 42
xcmX?ZyVsV>CD<iouN(sdBf~~6V@W}2z4&0K_yA{5gXkvyU|%PL%@LCMtN{E}3u*uW

delta 52
zcmdmMd)$`GCD<k8xEuomWBo=hV@YXMz4&0K_yA{5gXkv7U|%N#j(87G7aleN2G-4f
HlKHFvhbs+g

diff --git a/tests/data/acpi/q35/DSDT.bridge b/tests/data/acpi/q35/DSDT.bridge
index fbc2d40000428b402586ea9302b5ccf36ef8de1e..eae3a2a8657e9986d8ac592958503c0b516faaef 100644
GIT binary patch
delta 42
xcmca%d(M{2CD<k8oE!rK<ARM`#*%{4dhx+d@d3`B2GLFY!M;ugn<FF}SOFEN3{C(5

delta 52
zcmX?Sd&8E?CD<k8h8zO}qx?oLV@YXMz4&0K_yA{5gXkv7U|%N#j(87G7aleN2G-4f
Hk`1f?g02lt

diff --git a/tests/data/acpi/q35/DSDT.cphp b/tests/data/acpi/q35/DSDT.cphp
index 6a896cb2142feadbcabc6276b59c138a7e93f540..53d735a4de25c4d8e23eed102fcd01376168c5b3 100644
GIT binary patch
delta 42
xcmbQ{*yG6M66_MvqrkwxSh<nQSW-}0FFx2QKET=2Ai9Y^*w@KmbA+TFI{@^p3o8Hs

delta 52
zcmeBioaV^o66_K(O@V=d@yA9kV@YXMz4&0K_yA{5gXkv7U|%N#j(87G7aleN2G-4f
Hl6LF>e&h`+

diff --git a/tests/data/acpi/q35/DSDT.dimmpxm b/tests/data/acpi/q35/DSDT.dimmpxm
index 23fdf5e60a5069f60d6c680ac9c68c4a8a81318e..02ccdd5f38d5b2356dcca89398c41dcf2595dfff 100644
GIT binary patch
delta 42
xcmdnvwaJUiCD<jzNR@$s(P<->v8151UVN}qe1Nm3L39&;u&<NB<_O6r+yL|Y3#R}8

delta 52
zcmdnwwa1IgCD<jzMwNkq@!&=-V@YXMz4&0K_yA{5gXkv7U|%N#j(87G7aleN2G-4f
Hl25n+d}a-&

diff --git a/tests/data/acpi/q35/DSDT.ipmibt b/tests/data/acpi/q35/DSDT.ipmibt
index c3fca0a71efa7b55c958a49f305389426fbe7922..9e2d4f785c54629d233924a503cfe81199e22aa0 100644
GIT binary patch
delta 42
xcmbPa*I~!y66_MfA<w|TsIrl(PEt@>FFx2QKET=2Ai9Y^*w@Km^J2+-Rsi7S3kU!J

delta 52
zcmeCMn`Fo366_KpB+tOWxOgL1ouss?UVN}qe1Nm3L3ER3u&<K=N4$rp3lEzB1MB9Q
HlKHFvWcdvU

diff --git a/tests/data/acpi/q35/DSDT.memhp b/tests/data/acpi/q35/DSDT.memhp
index 2abd0e36cd1344cbca3fa4ab59c5db2ea326d125..baefa611acadce4c6da5babdaafad533d19358e6 100644
GIT binary patch
delta 42
xcmbQ{(c{7866_Mfqr$+z_;Dkbv8151UVN}qe1Nm3L39&;u&<NB<_O7sTmba|3%CFP

delta 52
zcmeD2nC8Ld66_KprozC$Sg?`HSW;S5FFx2QKET=2Ai7C1*w@K`Bi_T)g@;XmfpxQ=
H<UTF{S(^;F

diff --git a/tests/data/acpi/q35/DSDT.mmio64 b/tests/data/acpi/q35/DSDT.mmio64
index b32034a11c1f8a0a156df3765df44b14a88dbb4d..aae0ea2110a54b02f772d99e66df0730d74b43d9 100644
GIT binary patch
delta 42
xcmdn!w%m=&CD<iIU73M_aqUJfV@W}2z4&0K_yA{5gXkvyU|%PL%@L9}IRW`53)%nx

delta 52
zcmZ4Pw$Y8tCD<jzP?>>&QD-BUv81%BUVN}qe1Nm3L3ER3u&<K=N4$rp3lEzB1M6l#
H$(x)2UJ(r1

diff --git a/tests/data/acpi/q35/DSDT.numamem b/tests/data/acpi/q35/DSDT.numamem
index d8b2b47f8b47067d375021a30086ca97d8aca43f..859a2e08710ba37f56c9c32b0235ff90cedb1905 100644
GIT binary patch
delta 42
xcmX?Wd)SuCCD<k8up9#e<Eo8Z#*%{4dhx+d@d3`B2GLFY!M;ugn<FGkSpgBb3@iWu

delta 52
zcmX?Xd)AiACD<k8tQ-Raqvl2~V@YXMz4&0K_yA{5gXkv7U|%N#j(87G7aleN2G-4f
HlBKKwec25x

-- 
2.17.1


