Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B65C2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 16:57:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FD5A20709
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 16:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TxNPT2Z9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FD5A20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijR1o-0006Ic-Ti
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 11:57:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41604)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ijQmx-0004uq-NE
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 11:42:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ijQmv-0005fO-Ha
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 11:42:35 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21303
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ijQmv-0005eo-B2
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 11:42:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577119350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KK1l/PHjlNOm2EdO0lI4ftoCkLwZHJNbAAGaDddroN4=;
 b=TxNPT2Z9XEypHHSwI1SCvYkAP2RFGlgN+H6VeAXrLClqHsIFFh6mi7ruoPvE9915mJk9Yt
 AJ3NPgGYF2NEErg5hRYjY9fIcK6B5uXwPI+KdN+jsBw7a1OK7Bu1+dg6sj539urXSZS1rP
 HJw8q9Hq8inDk2BfuKT/oMANkDkweHg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-Z-Od3o-HNFGixW1G46TjTw-1; Mon, 23 Dec 2019 11:42:29 -0500
Received: by mail-qv1-f70.google.com with SMTP id c1so11622747qvw.17
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2019 08:42:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WHf91FL9X6R/LHFT3E8dg17f/3EsgQa7B7wKa5HVzBM=;
 b=Vp9N9VfG0/Qc8etYQl0ZLVI3WlvFkozNVh2U7rvmf2OgzVBlrKUfNsNjK8arCasj7P
 FP635n3PlnkRSWNru1fw8RUXHI5E2UORlRQ1Fh4BwJCttYrVjAlh5VbU0BXft9xYOjLk
 MtBoIU3uAau3C/uYwUT6SjcJOSERwyGDhm4oz39w2P6JeMeHAmNPKaDyE0oL7gFr74Hd
 5gjh6OeMLHL4FeUwyPZ598zFwjTdPZ8TihDXNEDLRZLAqHtaB/SzZwwC7ErJt5jIoA4V
 KmxC13Al95PVR1tvuX6J9MGBORrc7O+Qi+xCujGqQKxuADZGrJynTHrxPpNbW84fcuPo
 UJCQ==
X-Gm-Message-State: APjAAAULUxIFFW3vfn04ctog4fUTnslHZiAnAAC3PAaUgBHcK+BC0OZI
 I6iXCeANDlAtV9rK82YRvqJFbr1frhBS9TP803W/UIynSZX6VH37luscTMlkXEjRk1jy3Kb+drP
 uAfJW28nMZNmSIGc=
X-Received: by 2002:ac8:337c:: with SMTP id u57mr15740778qta.42.1577119347887; 
 Mon, 23 Dec 2019 08:42:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqyMwh9eb/WKwqHDxQ7nRs4FiE3TgTaOeZgOalR5gIMypmaLti7pAB0zVK8T7n5GKYJ6ZkTUKg==
X-Received: by 2002:ac8:337c:: with SMTP id u57mr15740758qta.42.1577119347484; 
 Mon, 23 Dec 2019 08:42:27 -0800 (PST)
Received: from redhat.com (bzq-109-64-31-13.red.bezeqint.net. [109.64.31.13])
 by smtp.gmail.com with ESMTPSA id
 k1sm2676992qtq.86.2019.12.23.08.42.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Dec 2019 08:42:26 -0800 (PST)
Date: Mon, 23 Dec 2019 11:42:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 19/27] ACPI: add expected files for HMAT tests (acpihmat)
Message-ID: <20191223141536.72682-20-mst@redhat.com>
References: <20191223141536.72682-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191223141536.72682-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: Z-Od3o-HNFGixW1G46TjTw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
 Daniel Black <daniel@linux.ibm.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/bios-tables-test-allowed-diff.h |   8 --------
 tests/data/acpi/pc/APIC.acpihmat      | Bin 0 -> 128 bytes
 tests/data/acpi/pc/DSDT.acpihmat      | Bin 0 -> 6455 bytes
 tests/data/acpi/pc/HMAT.acpihmat      | Bin 0 -> 280 bytes
 tests/data/acpi/pc/SRAT.acpihmat      | Bin 0 -> 280 bytes
 tests/data/acpi/q35/APIC.acpihmat     | Bin 0 -> 128 bytes
 tests/data/acpi/q35/DSDT.acpihmat     | Bin 0 -> 9203 bytes
 tests/data/acpi/q35/HMAT.acpihmat     | Bin 0 -> 280 bytes
 tests/data/acpi/q35/SRAT.acpihmat     | Bin 0 -> 280 bytes
 9 files changed, 8 deletions(-)

diff --git a/tests/bios-tables-test-allowed-diff.h b/tests/bios-tables-test=
-allowed-diff.h
index 3c9e0c979b..dfb8523c8b 100644
--- a/tests/bios-tables-test-allowed-diff.h
+++ b/tests/bios-tables-test-allowed-diff.h
@@ -1,9 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/pc/APIC.acpihmat",
-"tests/data/acpi/pc/SRAT.acpihmat",
-"tests/data/acpi/pc/HMAT.acpihmat",
-"tests/data/acpi/pc/DSDT.acpihmat",
-"tests/data/acpi/q35/APIC.acpihmat",
-"tests/data/acpi/q35/SRAT.acpihmat",
-"tests/data/acpi/q35/HMAT.acpihmat",
-"tests/data/acpi/q35/DSDT.acpihmat",
diff --git a/tests/data/acpi/pc/APIC.acpihmat b/tests/data/acpi/pc/APIC.acp=
ihmat
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..a21f164699bfccd8992ea1bdb57=
17f2dc3025496 100644
GIT binary patch
literal 128
zcmZ<^@N{lqU|?Xp<>c?|5v<@85#a0y6k`O6f!H9Lf#JbFFwFr}2jX%tGJ<GE9uVii
mKM=3D{p1;ii*h{ehZq<KLsPEHt$3#b4h#?1|8v9SFI8UX-@1`PoK

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/pc/DSDT.acpihmat b/tests/data/acpi/pc/DSDT.acp=
ihmat
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..ad890e09aab12dd280c3d246554=
0db82ca1b430b 100644
GIT binary patch
literal 6455
zcmcIo-EJGl6`tXbyc|-}Qrg(E<-~;SB#oQcr0B>A8l)n3DUlYJT5~Da#Tw;OmQgB5
z;e`?xQH-Fp0w_-I0@g(f^nx~cZ9hWu2zi9`6;d?uRn+h7awwY80?9=3DQh?+C!o9~>N
zIp@p_4clm3J<S;ZOL1K<+nM4`OE=3DKR8DrF@|7s<6i#Z*mxZ32&NQ^rVl71UsMMZnl
zC~mCszqj4Lx$ehbxV+`D%_r)k&6fB1LwA!A=3D-#F$1U1x!rd@10d-IlF$tulq#Yh#t
z6;Y*GFzQTcZd44eno58vDP^nFkRT2a)NrG0HB6Rb?AxD`Eap5=3DNuIq?su>xpZZtF6
zQqyh}m`6RXM_sK?U7@<Y)Yn~?b=3D~B_L7(-ezV5czUt1~m@Bha8tS_dOre3$xX)(2*
zz>Go8VvOxF_0>z{4Y}*=3Dowjb~^1iRBDC2O&%H{P469?*Yd<3S)Dt4h6;IOcSyOPx-
z!WD4$wLe@U78=3DP|`7%3EwMsS4-eFO_K#izg#6ML(cR4Bz6PvU5R=3DuHvG+44E7K{9y
z6ECfDk9kauEHJ*xci0Y#Ozbje@9J977{a4bE#a@qaH9S|m${5%)E3*q|Ah$V>+HR5
zu5SznPS1`HR78A%sRS%2D~3MY#1jLL=3DEdA9|33PCl*Ly0kI^5oPz%fKV$A2xtyHao
z-0T&jGLuo6h>LZR<>Hx$h*$A9Bj&|{_)z>HriG$3SBz5nl+Y*)M?Vn=3D&ffb~t1<L7
z#<aO$>uE{d-UPP0&mPByb5_OVD*q(<NmNl5I=3D(-pn7(f2<f6uT5P_10HYAMZdGvXd
zDGRDkvqChBV>BW%<iU=3DH@<g6Tz@vaiEh~pX)UkBC!ISK%P!QrI=3D!n6M48Dwv)3Hm}
zkc!Gvil`(BdNEtN21T)E)_GD56eQ@y+J>2Nc(JOlG3`}LFI|f`=3DSey^@Y<yGcKJ4=3D
z;m+&S-DheIDO7B#Yl6aFGepy>H<&jQ>9`(iJt-z0wM57Jv?U^J)4RXZ+GHZiZuivg
zZGaL;n`&*%U|YQl-P^pE?zTj1*ln||$CE>;08qMnTSSIE#X(PW*rT&8@3Y-ap)w>c
zd$`4zcfSRD54Sk;wjR1IcCXcUod*{#N6A~t70Nbl)vsq2eC6nCk-qYZHe0!lRqZA2
zi%uI!pXiIEwp6*U*AoELv*{_3{BnXN{9xN<Us0ck<Ga#JK5ApmZEE+a+u5t0z%&ue
zK|-cbK&U(^SSveyQp|oi#S+mtqEz57iN9T@O$RwhPLO+Ax@lBw_8GNB$M2b@tY&?3
z$(K(x?YhmsY6o7Rn$;`RKd@dLvyS-v+17I-)^on~9Q+%#p3{!Eo^$q0n!7$`T||C?
z`Na|Qi@y2AG4qQd<`)O%jdAlhAb$4j^CRZ-zWMx^`Fx1^ytB6+!|d&G^Rd9Z3?Vv2
zu;sGsCbbEFv$bTf#^frxXm{0X?*#{*E^ZwbeXCv?nh+Cya82sgMy7oCWADRzf6VOM
z`RMMwo!fUlVh-1>>e`_EP71Ng*)#Txr%<C2RDKnCCQ{CW^CT2lMyCTuuheX=3D*UcLo
z1tH5>OxH~VrDldeQQa<8Ge8=3DJMn+3DE47N^G3vzH=3DWh8`3cdvXO%`;klFjC_<Uw$r
z$F;M1W99dep6IsOzMjoyx2eggncLRN6DVhegmeDZ<(NF<Xu32FDoW$su<J3mccwe8
zpow^5+I3z(qN%R+UCoTs<bIhUK28OOWBIl6ly2)aC2ShpeNsqvU7XISn&YHc?A~hZ
z$b|e&!OD%pu@Brk;u+8$cOS3CdgY^3{?;B(C89^U00-Cc6Eze1y4^^HP4w9PI^ry5
z>}?-2FHc0qdkOl%cqf+NSnr(A-=3D_dWw&8<VMPw;`iZ6ttS!kq_LSYKs!l0dMVjfAF
z3~O(HfPB4aGUxNP7=3D>kU!5Ae#H60Rg?h_=3DNlq`P6jF9mmnKqB)ShY&cQg#u0?%&`j
zQ7BN5I`NVGHp^B}!6vPml`UkK;4co4N%PL1?(Xbn+DFnnxbOw}EpV#LQGS;#I_{Ye
zbGVO{g3JVSP@2b>jf!bzw(k6Sn~H{F8nwEJI1et3EHwE<j8U^*tY+|4##fbERkW;|
z&5ZNl&13Kdwk*t&-Q*?(ut}k3(gg*l@-gVBN!7(%FWtbGt!K1Z|5)rLy5tkCY&ex2
zZu<9?!i0&XV~09qlXISQ2M15yd*spx&n3d%Y&Woum`Bq2t~@^3)4G8>)Jt(s(vC}!
zP9%M<y=3D78~9HI68(Plnjvg^+&C@?<S)e3Vaj!0CLzy*m_%=3D*%mbY5h?`ZZ&C8;pH^
zItV_pdmtX*ia`U#6g;m6%^5VyLG!h0N%meubI^OzEZiJm&!AcMXq#vdHL65}Mzu@>
zs8J=3D79qOhAjU~ZX)99Y|i26vsLo)X}(|#xac-TX&D(R{{<3yLb5kU3)V)~po`^Blz
zDbrMGnlwd!dig~mK;Oii(44~9LGvUWYI<au)E<$O(jz}fHP|5<Hf%0k(JmkkO+LN>
z9!00zR9E{I0;>@_0@|ja^FE-c3n;Y(#Az1y;TN|PVS?}tAV}K@)5_wVL)n@A1f^zp
z@^|E&fr5hckg4+YDW(Q8)tEl{?8|AYKvD9JMAQw8pprsv_&o!2c#{mw<^Hecw6i8M
zV{lN@GzSMYnmDKrt65%FGb%2WlInVl3Z1_cgBt)!nD#CzUyjj9F?_uSPmPfdORxE*
z`~`%nYeDs*OMFo3mWBA|!$}swQ=3DbBgzVKFko_e0*3i^4FXFo#yJT;Uj{qXzGXiy3S
zBVEAh6Jfq4DE5pg2M7Q9DbRfL!;#$mhG2-}-_m1q<kO)xy@2%?mLPZmkJVc0AGxC8
z7mY?iBu7g4chA0i#$!ZsEoPOida#f$9tBv6W3GEgx!6<olxuiEzHtk|V&|JP6EQlk
z(7w`~QDS&hV+N4kCJi~S{^oG8oxMvdztdL&2d<aQ4V<QngdX!)jjM6GRH`NKmj667
z@A`XHMDfKml6E$Wr#StN<Lq6ua{~dp6JZ+Iat10pH5O$fPYq}94LkP^2HG37!S6sA
z5@p(qpBMC8B?F`;=3DpxY)6t``d0u-<Q5U6C0OK3a{nwPA&X9uhkp-{<sLPAf3L9a+w
z{E88<Dxpxxnvl>$81!w)DkM~dLM1B#FK{3k23?Y@DG5!5LM7{@gieM*uS(V_37ras
zN>;q117D}ZpzlalRYKKJsANq`XgUn~u4J8&(3w!EWSy1J*)V89vLf<>X=3D$NQ$@-Fn
zz7z&6O4gGSdNLF$Sx-smsW7N6S?45lE)*(RPfO_OFsLC}&q(N*P^e^`m(ckzXi2i3
zmC&=3DHP|5nTguWaGU6HJ>Na!n}P|12uLeCus)ynh6jannpOWkkdA+k@kZrc}B2&iU(
zkRd^8mLZ@b1)2^Cq?x?mPU01_Z=3D<XXqzFkvT?`V6!$3#2-X7}67*c$oBWp`T9hpO-
z4s>MiD(R;0w^3bjitO7+I4R>CfqbaPX|iu4b)+6IEy#y@m1HD=3D)MtG8P`^wv!ddD&
zzI>?nXN<s<dK@PEwmzb#StG=3DTdYZQ}qNkZ7Scdux$s_t@$k_IwzC$wf+Bv$W;D>ek
Qg_O1sXWa%LGz<~_AAR>eTL1t6

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/pc/HMAT.acpihmat b/tests/data/acpi/pc/HMAT.acp=
ihmat
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..c00f7ba6cd0acecbc4b158f430d=
29b2f32988522 100644
GIT binary patch
literal 280
zcmeb9bqtYUWME*L;pFe^5v<@85#a0r6axw|fY=3D}!1~h;SWIjwBokmuNOFc;30ICth
zW`eR`Fhdzga*PcB{=3D?M+<&o8c*vJ6H|M&lYJ;*!-WC@U?fIv`?15Cr@;rh|!0TAyG
A0RR91

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/pc/SRAT.acpihmat b/tests/data/acpi/pc/SRAT.acp=
ihmat
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..1dcae90aec688e88f9d212e632f=
aaaaf2e0dc7bc 100644
GIT binary patch
literal 280
zcmWFzatx7RWME)C;N<V@5v<@85#SsQ6axw|fY=3D}!gyBE{gU^U8&!_=3Dc31x7>1+c3F
q8VCj-m|+T0)xmizP<a@Q;x0^kVWy$dj2dwBVET8!RKOho6aWCEstN%B

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/q35/APIC.acpihmat b/tests/data/acpi/q35/APIC.a=
cpihmat
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..a21f164699bfccd8992ea1bdb57=
17f2dc3025496 100644
GIT binary patch
literal 128
zcmZ<^@N{lqU|?Xp<>c?|5v<@85#a0y6k`O6f!H9Lf#JbFFwFr}2jX%tGJ<GE9uVii
mKM=3D{p1;ii*h{ehZq<KLsPEHt$3#b4h#?1|8v9SFI8UX-@1`PoK

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/q35/DSDT.acpihmat b/tests/data/acpi/q35/DSDT.a=
cpihmat
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..30e3717b5b87dbd706e90915cb0=
be1ff3ff8df06 100644
GIT binary patch
literal 9203
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
HcG>>`zx=3DOx

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/q35/HMAT.acpihmat b/tests/data/acpi/q35/HMAT.a=
cpihmat
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..c00f7ba6cd0acecbc4b158f430d=
29b2f32988522 100644
GIT binary patch
literal 280
zcmeb9bqtYUWME*L;pFe^5v<@85#a0r6axw|fY=3D}!1~h;SWIjwBokmuNOFc;30ICth
zW`eR`Fhdzga*PcB{=3D?M+<&o8c*vJ6H|M&lYJ;*!-WC@U?fIv`?15Cr@;rh|!0TAyG
A0RR91

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/q35/SRAT.acpihmat b/tests/data/acpi/q35/SRAT.a=
cpihmat
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..1dcae90aec688e88f9d212e632f=
aaaaf2e0dc7bc 100644
GIT binary patch
literal 280
zcmWFzatx7RWME)C;N<V@5v<@85#SsQ6axw|fY=3D}!gyBE{gU^U8&!_=3Dc31x7>1+c3F
q8VCj-m|+T0)xmizP<a@Q;x0^kVWy$dj2dwBVET8!RKOho6aWCEstN%B

literal 0
HcmV?d00001

--=20
MST


