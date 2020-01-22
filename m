Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5ABC32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 05:38:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A67221835
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 05:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SUJyv0MF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A67221835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu8iQ-00035f-Pg
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 00:38:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58835)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iu8hp-0002bO-25
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 00:37:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iu8hl-00047M-VD
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 00:37:31 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36421
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iu8hl-00046M-O5
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 00:37:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579671448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Kuu+x5YR0JSwnk+s6h8ppNMfMbxgduytrza6RaZDWA=;
 b=SUJyv0MFuCQ/6cbYx6efotZbeJhAp0SRIYjnjd1NqXRzS21ClS3HNxalgbYVW/XMiFb9Qw
 v5Jn5ZLput3PttAIqU8qWPrkEhkvzNyQQiCCERAx3Uy04ySFGRejzNUvj/z4zKmJk2NRzR
 vtJyAog91ksg56bO12+1DTRwMcMGc9Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-txUizO_4OCWz8VEvyHAi1g-1; Wed, 22 Jan 2020 00:37:23 -0500
Received: by mail-wr1-f69.google.com with SMTP id j13so2511450wrr.20
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 21:37:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=5A8KysGPUEQgzbtCiR2pj3mB3nqF8uEuTnU/ByrRCBw=;
 b=gUwQd8fbPNnvwBgnw2puda68DA5oYnJCVtJQeeb0SpZmLdrBQ1Sj3RvzaKMiuYVyty
 HjgTJhx67I5BTDjwnZDEYf+KPjDZ9QZheSqMUd9XnZXgiJ8I5p6lsO3NOeUCQ7o//RGu
 kYSd+sKNmUqa6SStfwQ4A0mkrouaUw0MQS/9BDzeYbxWCvu13s/KdgSFnRyACikT0lqM
 18AkogYIjv9MHIfrf5jjxy0YzYU/sAmtCXiK+6KQkFde4QWOzFtf1qI5nO7io0SImd7T
 BTt4F/N7fL/M8salGosMpDDrjMw+Ly4CHXzBtK+DVdyak6L3o/oagy0N0mtg7aUtDdBz
 5nww==
X-Gm-Message-State: APjAAAUxCuU3dFOx1OkZLzfsaVMN9e8iPz/ahkavljmAZvW8ELST+Re4
 ZJWqinuWmLeqRuH2Ii4PO9VF9240ZfNXzZulf4/Gc+p0H0BFyYK44RWtlOyfT8KJ4OeAhGGwNNx
 K/q/lYt81Ib1qAwo=
X-Received: by 2002:a05:6000:11c9:: with SMTP id
 i9mr9321705wrx.164.1579671442235; 
 Tue, 21 Jan 2020 21:37:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqyNCGLXfOSDYk3ogfUrNG/4GFlQJevOVED5Z49cgMKnssHm3wCylqmpUSumeWgL05LUuDFeqg==
X-Received: by 2002:a05:6000:11c9:: with SMTP id
 i9mr9321681wrx.164.1579671441994; 
 Tue, 21 Jan 2020 21:37:21 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 g25sm3371098wmh.3.2020.01.21.21.37.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 21:37:21 -0800 (PST)
Date: Wed, 22 Jan 2020 00:37:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: minyard@acm.org
Subject: Re: [PATCH 5/5] i386:acpi: Remove _HID from the SMBus ACPI entry
Message-ID: <20200122003620-mutt-send-email-mst@kernel.org>
References: <20200120170725.24935-1-minyard@acm.org>
 <20200120170725.24935-6-minyard@acm.org>
MIME-Version: 1.0
In-Reply-To: <20200120170725.24935-6-minyard@acm.org>
X-MC-Unique: txUizO_4OCWz8VEvyHAi1g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Corey Minyard <cminyard@mvista.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jan 20, 2020 at 11:07:25AM -0600, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
>=20
> Per the ACPI spec (version 6.1, section 6.1.5 _HID) it is not required
> on enumerated buses (like PCI in this case), _ADR is required (and is
> already there).  And the _HID value is wrong.  Linux appears to ignore
> the _HID entry, but Windows 10 detects it as 'Unknown Device' and there
> is no driver available.  See https://bugs.launchpad.net/qemu/+bug/1856724
>=20
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>

Applied this one. In the future pls follow the process in
tests/qtest/bios-tables-test.c.

> ---
>  hw/i386/acpi-build.c             |   1 -
>  tests/data/acpi/q35/DSDT         | Bin 7879 -> 7869 bytes
>  tests/data/acpi/q35/DSDT.bridge  | Bin 7896 -> 7886 bytes
>  tests/data/acpi/q35/DSDT.cphp    | Bin 8342 -> 8332 bytes
>  tests/data/acpi/q35/DSDT.dimmpxm | Bin 9532 -> 9522 bytes
>  tests/data/acpi/q35/DSDT.ipmibt  | Bin 7954 -> 7944 bytes
>  tests/data/acpi/q35/DSDT.memhp   | Bin 9238 -> 9228 bytes
>  tests/data/acpi/q35/DSDT.mmio64  | Bin 9009 -> 8999 bytes
>  tests/data/acpi/q35/DSDT.numamem | Bin 7885 -> 7875 bytes
>  9 files changed, 1 deletion(-)
>=20
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 7b8da62d41..ab73a8f4c8 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1815,7 +1815,6 @@ static void build_smb0(Aml *table, I2CBus *smbus, i=
nt devnr, int func)
>      Aml *scope =3D aml_scope("_SB.PCI0");
>      Aml *dev =3D aml_device("SMB0");
> =20
> -    aml_append(dev, aml_name_decl("_HID", aml_eisaid("APP0005")));
>      aml_append(dev, aml_name_decl("_ADR", aml_int(devnr << 16 | func)));
>      build_acpi_ipmi_devices(dev, BUS(smbus), "\\_SB.PCI0.SMB0");
>      aml_append(scope, dev);
> diff --git a/tests/data/acpi/q35/DSDT b/tests/data/acpi/q35/DSDT
> index 77ea60ffed421c566138fe6341421f579129a582..1f91888d7a485850cf27f152e=
247a90b208003dc 100644
> GIT binary patch
> delta 42
> xcmX?ZyVsV>CD<iouN(sdBf~~6V@W}2z4&0K_yA{5gXkvyU|%PL%@LCMtN{E}3u*uW
>=20
> delta 52
> zcmdmMd)$`GCD<k8xEuomWBo=3DhV@YXMz4&0K_yA{5gXkv7U|%N#j(87G7aleN2G-4f
> HlKHFvhbs+g
>=20
> diff --git a/tests/data/acpi/q35/DSDT.bridge b/tests/data/acpi/q35/DSDT.b=
ridge
> index fbc2d40000428b402586ea9302b5ccf36ef8de1e..eae3a2a8657e9986d8ac59295=
8503c0b516faaef 100644
> GIT binary patch
> delta 42
> xcmca%d(M{2CD<k8oE!rK<ARM`#*%{4dhx+d@d3`B2GLFY!M;ugn<FF}SOFEN3{C(5
>=20
> delta 52
> zcmX?Sd&8E?CD<k8h8zO}qx?oLV@YXMz4&0K_yA{5gXkv7U|%N#j(87G7aleN2G-4f
> Hk`1f?g02lt
>=20
> diff --git a/tests/data/acpi/q35/DSDT.cphp b/tests/data/acpi/q35/DSDT.cph=
p
> index 6a896cb2142feadbcabc6276b59c138a7e93f540..53d735a4de25c4d8e23eed102=
fcd01376168c5b3 100644
> GIT binary patch
> delta 42
> xcmbQ{*yG6M66_MvqrkwxSh<nQSW-}0FFx2QKET=3D2Ai9Y^*w@KmbA+TFI{@^p3o8Hs
>=20
> delta 52
> zcmeBioaV^o66_K(O@V=3Dd@yA9kV@YXMz4&0K_yA{5gXkv7U|%N#j(87G7aleN2G-4f
> Hl6LF>e&h`+
>=20
> diff --git a/tests/data/acpi/q35/DSDT.dimmpxm b/tests/data/acpi/q35/DSDT.=
dimmpxm
> index 23fdf5e60a5069f60d6c680ac9c68c4a8a81318e..02ccdd5f38d5b2356dcca8939=
8c41dcf2595dfff 100644
> GIT binary patch
> delta 42
> xcmdnvwaJUiCD<jzNR@$s(P<->v8151UVN}qe1Nm3L39&;u&<NB<_O6r+yL|Y3#R}8
>=20
> delta 52
> zcmdnwwa1IgCD<jzMwNkq@!&=3D-V@YXMz4&0K_yA{5gXkv7U|%N#j(87G7aleN2G-4f
> Hl25n+d}a-&
>=20
> diff --git a/tests/data/acpi/q35/DSDT.ipmibt b/tests/data/acpi/q35/DSDT.i=
pmibt
> index c3fca0a71efa7b55c958a49f305389426fbe7922..9e2d4f785c54629d233924a50=
3cfe81199e22aa0 100644
> GIT binary patch
> delta 42
> xcmbPa*I~!y66_MfA<w|TsIrl(PEt@>FFx2QKET=3D2Ai9Y^*w@Km^J2+-Rsi7S3kU!J
>=20
> delta 52
> zcmeCMn`Fo366_KpB+tOWxOgL1ouss?UVN}qe1Nm3L3ER3u&<K=3DN4$rp3lEzB1MB9Q
> HlKHFvWcdvU
>=20
> diff --git a/tests/data/acpi/q35/DSDT.memhp b/tests/data/acpi/q35/DSDT.me=
mhp
> index 2abd0e36cd1344cbca3fa4ab59c5db2ea326d125..baefa611acadce4c6da5babda=
afad533d19358e6 100644
> GIT binary patch
> delta 42
> xcmbQ{(c{7866_Mfqr$+z_;Dkbv8151UVN}qe1Nm3L39&;u&<NB<_O7sTmba|3%CFP
>=20
> delta 52
> zcmeD2nC8Ld66_KprozC$Sg?`HSW;S5FFx2QKET=3D2Ai7C1*w@K`Bi_T)g@;XmfpxQ=3D
> H<UTF{S(^;F
>=20
> diff --git a/tests/data/acpi/q35/DSDT.mmio64 b/tests/data/acpi/q35/DSDT.m=
mio64
> index b32034a11c1f8a0a156df3765df44b14a88dbb4d..aae0ea2110a54b02f772d99e6=
6df0730d74b43d9 100644
> GIT binary patch
> delta 42
> xcmdn!w%m=3D&CD<iIU73M_aqUJfV@W}2z4&0K_yA{5gXkvyU|%PL%@L9}IRW`53)%nx
>=20
> delta 52
> zcmZ4Pw$Y8tCD<jzP?>>&QD-BUv81%BUVN}qe1Nm3L3ER3u&<K=3DN4$rp3lEzB1M6l#
> H$(x)2UJ(r1
>=20
> diff --git a/tests/data/acpi/q35/DSDT.numamem b/tests/data/acpi/q35/DSDT.=
numamem
> index d8b2b47f8b47067d375021a30086ca97d8aca43f..859a2e08710ba37f56c9c32b0=
235ff90cedb1905 100644
> GIT binary patch
> delta 42
> xcmX?Wd)SuCCD<k8up9#e<Eo8Z#*%{4dhx+d@d3`B2GLFY!M;ugn<FGkSpgBb3@iWu
>=20
> delta 52
> zcmX?Xd)AiACD<k8tQ-Raqvl2~V@YXMz4&0K_yA{5gXkv7U|%N#j(87G7aleN2G-4f
> HlBKKwec25x
>=20
> --=20
> 2.17.1


