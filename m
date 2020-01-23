Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878FBC33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 07:26:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50D8B24673
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 07:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KdVCpxvH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50D8B24673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuWt4-0007Zp-Fd
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 02:26:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37607)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iuWdx-0006pr-GS
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:11:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iuWdv-0000Bh-VH
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:11:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48381
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iuWdv-0000BX-RM
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:11:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579763467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ggBqUw/TkyscUgLTaAI+ToeLG/4Kdqwt2Kyfz0gAqcA=;
 b=KdVCpxvH+EMzssDqqQTS0Ne0rWJ8LgOWf4nQFbGP9nwM6C/3OUB0EuuTd9DBmM0Y2MBzv5
 0h4GRhubF9UTUIifBmpqY+OyRzwCQfAeAGnWAEdU3fAue3l1QoHDro2PuMZX0sswALrXaM
 KvNOzOdPq+uY8jnGU1P395h8AG/Ud6I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-a2kL-y1bNiGoYYbCq5638w-1; Thu, 23 Jan 2020 02:11:03 -0500
Received: by mail-wr1-f69.google.com with SMTP id z14so1326994wrs.4
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 23:11:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=cGSuN6h1x+S1blKGljaTMghfpV/GT8UXotLBiV9qbUk=;
 b=V/mLqvj8x7OhMfOg36ZpahLnNopYWjT7THwTmQtTJf4uA+WrRK8JmYb5D6iZTIiVa9
 zkE2UZS8v280+DY+xx9iTZzrz2+tD+xDeJjQbxtjI1jQxE0CCyrIjh3D49UBTKjrK4pF
 YS3u4sjJDySEkhzLjKaSdZ2zkRqvSNs3YNOEUhr+dB1dTe4j4RKqCxbxzTU4tqYaLXSQ
 e93x9RThHaLuiFGA5IMr9xV2wtQgyUeJgjARPZ02BqJmZUb3q1lBpOcCrOZrQ39/ceH+
 nee/9RmCSrn5nfB8PM/2PeihkYvG1rE6KkhnZxFBqP23zAqiKsq/RmxBwCBPZrpNHqDp
 hcKg==
X-Gm-Message-State: APjAAAWWAgrlS8hY32chbODPW2IUTXicxIf0k9TWrWc4vCG2Pg9aEjPf
 69e1sBmkrYYe2kAd5cImMbKbEebu1BzSIlKC/W3saQgC8ppn8hSPvkLze6hZEBUWmdxfnKgZsed
 jCcex0IHd1b12EQo=
X-Received: by 2002:a05:600c:305:: with SMTP id
 q5mr2360521wmd.167.1579763462074; 
 Wed, 22 Jan 2020 23:11:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqzxxPSujN6AQWntf1iApTcXz+WP3BlyrW1m6Bj0zinRfhdZ04IfDpKT25JpJTkgLr+lribqhA==
X-Received: by 2002:a05:600c:305:: with SMTP id
 q5mr2360506wmd.167.1579763461860; 
 Wed, 22 Jan 2020 23:11:01 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 s10sm1801373wrw.12.2020.01.22.23.11.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 23:11:01 -0800 (PST)
Date: Thu, 23 Jan 2020 02:10:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 17/18] i386:acpi: Remove _HID from the SMBus ACPI entry
Message-ID: <20200123070913.626488-18-mst@redhat.com>
References: <20200123070913.626488-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200123070913.626488-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: a2kL-y1bNiGoYYbCq5638w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
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
Message-Id: <20200120170725.24935-6-minyard@acm.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/acpi-build.c              |   1 -
 tests/data/acpi/q35/DSDT          | Bin 7879 -> 7869 bytes
 tests/data/acpi/q35/DSDT.acpihmat | Bin 9203 -> 9193 bytes
 tests/data/acpi/q35/DSDT.bridge   | Bin 7896 -> 7886 bytes
 tests/data/acpi/q35/DSDT.cphp     | Bin 8342 -> 8332 bytes
 tests/data/acpi/q35/DSDT.dimmpxm  | Bin 9532 -> 9522 bytes
 tests/data/acpi/q35/DSDT.ipmibt   | Bin 7954 -> 7944 bytes
 tests/data/acpi/q35/DSDT.memhp    | Bin 9238 -> 9228 bytes
 tests/data/acpi/q35/DSDT.mmio64   | Bin 9009 -> 8999 bytes
 tests/data/acpi/q35/DSDT.numamem  | Bin 7885 -> 7875 bytes
 10 files changed, 1 deletion(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index e25df838f0..9c4e46fa74 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1816,7 +1816,6 @@ static void build_smb0(Aml *table, I2CBus *smbus, int=
 devnr, int func)
     Aml *scope =3D aml_scope("_SB.PCI0");
     Aml *dev =3D aml_device("SMB0");
=20
-    aml_append(dev, aml_name_decl("_HID", aml_eisaid("APP0005")));
     aml_append(dev, aml_name_decl("_ADR", aml_int(devnr << 16 | func)));
     build_acpi_ipmi_devices(dev, BUS(smbus), "\\_SB.PCI0.SMB0");
     aml_append(scope, dev);
diff --git a/tests/data/acpi/q35/DSDT b/tests/data/acpi/q35/DSDT
index 77ea60ffed421c566138fe6341421f579129a582..1f91888d7a485850cf27f152e24=
7a90b208003dc 100644
GIT binary patch
delta 42
xcmX?ZyVsV>CD<iouN(sdBf~~6V@W}2z4&0K_yA{5gXkvyU|%PL%@LCMtN{E}3u*uW

delta 52
zcmdmMd)$`GCD<k8xEuomWBo=3DhV@YXMz4&0K_yA{5gXkv7U|%N#j(87G7aleN2G-4f
HlKHFvhbs+g

diff --git a/tests/data/acpi/q35/DSDT.acpihmat b/tests/data/acpi/q35/DSDT.a=
cpihmat
index 30e3717b5b87dbd706e90915cb0be1ff3ff8df06..3586f6368a77d1497c35a7571c9=
f6c460221d9ab 100644
GIT binary patch
delta 42
ycmezD{?eVxCD<k8r7{Bp<GGDo#*%{4dhx+d@d3`B2GLFY!M;ugn<FG=3Da{&M<%nb$r

delta 52
zcmaFq{@I<&CD<k8voZq%qwhv8V@YXMz4&0K_yA{5gXkv7U|%N#j(87G7aleN2G-4f
HlC!x0ox%<V

diff --git a/tests/data/acpi/q35/DSDT.bridge b/tests/data/acpi/q35/DSDT.bri=
dge
index fbc2d40000428b402586ea9302b5ccf36ef8de1e..eae3a2a8657e9986d8ac5929585=
03c0b516faaef 100644
GIT binary patch
delta 42
xcmca%d(M{2CD<k8oE!rK<ARM`#*%{4dhx+d@d3`B2GLFY!M;ugn<FF}SOFEN3{C(5

delta 52
zcmX?Sd&8E?CD<k8h8zO}qx?oLV@YXMz4&0K_yA{5gXkv7U|%N#j(87G7aleN2G-4f
Hk`1f?g02lt

diff --git a/tests/data/acpi/q35/DSDT.cphp b/tests/data/acpi/q35/DSDT.cphp
index 6a896cb2142feadbcabc6276b59c138a7e93f540..53d735a4de25c4d8e23eed102fc=
d01376168c5b3 100644
GIT binary patch
delta 42
xcmbQ{*yG6M66_MvqrkwxSh<nQSW-}0FFx2QKET=3D2Ai9Y^*w@KmbA+TFI{@^p3o8Hs

delta 52
zcmeBioaV^o66_K(O@V=3Dd@yA9kV@YXMz4&0K_yA{5gXkv7U|%N#j(87G7aleN2G-4f
Hl6LF>e&h`+

diff --git a/tests/data/acpi/q35/DSDT.dimmpxm b/tests/data/acpi/q35/DSDT.di=
mmpxm
index 23fdf5e60a5069f60d6c680ac9c68c4a8a81318e..02ccdd5f38d5b2356dcca89398c=
41dcf2595dfff 100644
GIT binary patch
delta 42
xcmdnvwaJUiCD<jzNR@$s(P<->v8151UVN}qe1Nm3L39&;u&<NB<_O6r+yL|Y3#R}8

delta 52
zcmdnwwa1IgCD<jzMwNkq@!&=3D-V@YXMz4&0K_yA{5gXkv7U|%N#j(87G7aleN2G-4f
Hl25n+d}a-&

diff --git a/tests/data/acpi/q35/DSDT.ipmibt b/tests/data/acpi/q35/DSDT.ipm=
ibt
index c3fca0a71efa7b55c958a49f305389426fbe7922..9e2d4f785c54629d233924a503c=
fe81199e22aa0 100644
GIT binary patch
delta 42
xcmbPa*I~!y66_MfA<w|TsIrl(PEt@>FFx2QKET=3D2Ai9Y^*w@Km^J2+-Rsi7S3kU!J

delta 52
zcmeCMn`Fo366_KpB+tOWxOgL1ouss?UVN}qe1Nm3L3ER3u&<K=3DN4$rp3lEzB1MB9Q
HlKHFvWcdvU

diff --git a/tests/data/acpi/q35/DSDT.memhp b/tests/data/acpi/q35/DSDT.memh=
p
index 2abd0e36cd1344cbca3fa4ab59c5db2ea326d125..baefa611acadce4c6da5babdaaf=
ad533d19358e6 100644
GIT binary patch
delta 42
xcmbQ{(c{7866_Mfqr$+z_;Dkbv8151UVN}qe1Nm3L39&;u&<NB<_O7sTmba|3%CFP

delta 52
zcmeD2nC8Ld66_KprozC$Sg?`HSW;S5FFx2QKET=3D2Ai7C1*w@K`Bi_T)g@;XmfpxQ=3D
H<UTF{S(^;F

diff --git a/tests/data/acpi/q35/DSDT.mmio64 b/tests/data/acpi/q35/DSDT.mmi=
o64
index b32034a11c1f8a0a156df3765df44b14a88dbb4d..aae0ea2110a54b02f772d99e66d=
f0730d74b43d9 100644
GIT binary patch
delta 42
xcmdn!w%m=3D&CD<iIU73M_aqUJfV@W}2z4&0K_yA{5gXkvyU|%PL%@L9}IRW`53)%nx

delta 52
zcmZ4Pw$Y8tCD<jzP?>>&QD-BUv81%BUVN}qe1Nm3L3ER3u&<K=3DN4$rp3lEzB1M6l#
H$(x)2UJ(r1

diff --git a/tests/data/acpi/q35/DSDT.numamem b/tests/data/acpi/q35/DSDT.nu=
mamem
index d8b2b47f8b47067d375021a30086ca97d8aca43f..859a2e08710ba37f56c9c32b023=
5ff90cedb1905 100644
GIT binary patch
delta 42
xcmX?Wd)SuCCD<k8up9#e<Eo8Z#*%{4dhx+d@d3`B2GLFY!M;ugn<FGkSpgBb3@iWu

delta 52
zcmX?Xd)AiACD<k8tQ-Raqvl2~V@YXMz4&0K_yA{5gXkv7U|%N#j(87G7aleN2G-4f
HlBKKwec25x

--=20
MST


