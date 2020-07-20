Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65251C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 14:21:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2190822B4D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 14:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FpPf4LQD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2190822B4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxWfM-0000PM-Bc
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 10:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jxWak-00016A-98
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 10:16:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33751
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jxWah-0002mI-KK
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 10:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595254585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=icDIqx42j8IEYUfMqJMiQ3IsVGTwwWcE02balHDuFRA=;
 b=FpPf4LQDbRr0MgA+Lh6B4rqPjPDDU1R4Byq6DJ75WbS613iN/nUlOoizySz7VtzpilIvW6
 1VeeRJStvthKGHZePM4Sqs+Lu25cMld64xfMkQh7ShOH64iFVwZsjq4ctvmV++bqXvjKgy
 FaCJEE+oyJ1e0uhuSK9l3n2Mm7lRskQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-PF_e2C1qOgaTv_P2HR7cAw-1; Mon, 20 Jul 2020 10:16:23 -0400
X-MC-Unique: PF_e2C1qOgaTv_P2HR7cAw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA4A3800478;
 Mon, 20 Jul 2020 14:16:19 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F64F19C71;
 Mon, 20 Jul 2020 14:16:18 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/6] tests: acpi: update acpi blobs with new AML
Date: Mon, 20 Jul 2020 10:16:10 -0400
Message-Id: <20200720141610.574308-7-imammedo@redhat.com>
In-Reply-To: <20200720141610.574308-1-imammedo@redhat.com>
References: <20200720141610.574308-1-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 02:11:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: boris.ostrovsky@oracle.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Update CPU hotplug AML with following changes

@@ -2917,6 +2917,8 @@ DefinitionBlock ("", "DSDT", 1, "BOCHS ", "BXPCDSDT", 0x00000001)
             Method (CSCN, 0, Serialized)
             {
                 Acquire (\_SB.PCI0.PRES.CPLK, 0xFFFF)
+                Name (CNEW, Package (0x01){})
+                Local1 = Zero
                 Local0 = One
                 While ((Local0 == One))
                 {
@@ -2924,7 +2926,8 @@ DefinitionBlock ("", "DSDT", 1, "BOCHS ", "BXPCDSDT", 0x00000001)
                     \_SB.PCI0.PRES.CCMD = Zero
                     If ((\_SB.PCI0.PRES.CINS == One))
                     {
-                        CTFY (\_SB.PCI0.PRES.CDAT, One)
+                        CNEW [Local1] = \_SB.PCI0.PRES.CDAT
+                        Local1++
                         \_SB.PCI0.PRES.CINS = One
                         Local0 = One
                     }
@@ -2936,6 +2939,13 @@ DefinitionBlock ("", "DSDT", 1, "BOCHS ", "BXPCDSDT", 0x00000001)
                     }
                 }

+                Local2 = Zero
+                While ((Local2 < Local1))
+                {
+                    CTFY (DerefOf (CNEW [Local2]), One)
+                    Local2++
+                }
+
                 Release (\_SB.PCI0.PRES.CPLK)
             }

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h |  19 -------------------
 tests/data/acpi/pc/DSDT                     | Bin 4934 -> 4973 bytes
 tests/data/acpi/pc/DSDT.acpihmat            | Bin 6258 -> 6297 bytes
 tests/data/acpi/pc/DSDT.bridge              | Bin 6793 -> 6832 bytes
 tests/data/acpi/pc/DSDT.cphp                | Bin 5397 -> 5436 bytes
 tests/data/acpi/pc/DSDT.dimmpxm             | Bin 6587 -> 6626 bytes
 tests/data/acpi/pc/DSDT.ipmikcs             | Bin 5006 -> 5045 bytes
 tests/data/acpi/pc/DSDT.memhp               | Bin 6293 -> 6332 bytes
 tests/data/acpi/pc/DSDT.numamem             | Bin 4940 -> 4979 bytes
 tests/data/acpi/q35/DSDT                    | Bin 7678 -> 7717 bytes
 tests/data/acpi/q35/DSDT.acpihmat           | Bin 9002 -> 9041 bytes
 tests/data/acpi/q35/DSDT.bridge             | Bin 7695 -> 7734 bytes
 tests/data/acpi/q35/DSDT.cphp               | Bin 8141 -> 8180 bytes
 tests/data/acpi/q35/DSDT.dimmpxm            | Bin 9331 -> 9370 bytes
 tests/data/acpi/q35/DSDT.ipmibt             | Bin 7753 -> 7792 bytes
 tests/data/acpi/q35/DSDT.memhp              | Bin 9037 -> 9076 bytes
 tests/data/acpi/q35/DSDT.mmio64             | Bin 8808 -> 8847 bytes
 tests/data/acpi/q35/DSDT.numamem            | Bin 7684 -> 7723 bytes
 tests/data/acpi/q35/DSDT.tis                | Bin 8283 -> 8322 bytes
 19 files changed, 19 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dba32d5613..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,20 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/pc/DSDT",
-"tests/data/acpi/q35/DSDT",
-"tests/data/acpi/q35/DSDT.tis",
-"tests/data/acpi/q35/DSDT.bridge",
-"tests/data/acpi/q35/DSDT.mmio64",
-"tests/data/acpi/q35/DSDT.ipmibt",
-"tests/data/acpi/q35/DSDT.cphp",
-"tests/data/acpi/q35/DSDT.memhp",
-"tests/data/acpi/q35/DSDT.numamem",
-"tests/data/acpi/q35/DSDT.dimmpxm",
-"tests/data/acpi/q35/DSDT.acpihmat",
-"tests/data/acpi/pc/DSDT.bridge",
-"tests/data/acpi/pc/DSDT.ipmikcs",
-"tests/data/acpi/pc/DSDT.cphp",
-"tests/data/acpi/pc/DSDT.memhp",
-"tests/data/acpi/pc/DSDT.numamem",
-"tests/data/acpi/pc/DSDT.dimmpxm",
-"tests/data/acpi/pc/DSDT.acpihmat",
-"tests/data/acpi/pc/DSDT.acpihmat",
diff --git a/tests/data/acpi/pc/DSDT b/tests/data/acpi/pc/DSDT
index 6d0aaf729ac7d64cf966621adf276534de5cc555..2ce71cb385e06394d399b1540c8e2d775aa4a9b4 100644
GIT binary patch
delta 147
zcmX@6_EwF{CD<h-SD1l;@zh4HEo@BAmXi;#t!8r5o1Dx3m&spXat?=#0Ee@mYq$^-
zV*x{A0b{}<x5>R6vL-$(lVkK*;)9*y1Drh#0)kwFojv`684J(_T^vI?K>8CIN)spF
h<VX=OU`SddJT)oNIm9ip87!5=z*w5J*_M-&3jk|-D=`27

delta 111
zcmaE>c1(@SCD<jzO_+g!asNiHEo@9aW|I%Ft!DDqo}A16m)(QUIoR2cV{#*>1Pf!r
zBFD)yIArzRStiHmv&08G#RoWh8UzHn20MHD1v5H_xJ9CiyEuk0PJYRevN?s5lM4VS
C4j>@_

diff --git a/tests/data/acpi/pc/DSDT.acpihmat b/tests/data/acpi/pc/DSDT.acpihmat
index 2e5e02400b1bd2842989d395c573fc593f45503b..90ef187d087b436641d9c77806beaf8bc2bf8b63 100644
GIT binary patch
delta 161
zcmexlFw>CBCD<iorUU~6<MfSOTiBQ!?I#~#Tg~KRvN@NXgOSr;z&Y62k0V-nG9!nu
z(EtA&&VH`pLQG5r42cDd35(n&&)|?X@nM-9qt6l_>=Ym1>}e1X<QnYk=@-mcfG+6b
v7}5dKpU6;}IQa=jig*D-(jwuhNr}!OZjsGksU!x*(xl1p9AcZ}I7RpYo@*}X

delta 124
zcmbPf_{o6FCD<jTNP>ZZv3Dca7B(g?o5=^*Rx|k;Zq8-rVC3}Ra}IX)<A_$C%*Y|E
z`u~3cW5Oaw?#T&^1q=xV3^DpF@xe~<0nVNV0YR?8&d$Cr3*09k<Pei^4snY_mvwOr
PVVwMhBV}_wrxrf|$#o<`

diff --git a/tests/data/acpi/pc/DSDT.bridge b/tests/data/acpi/pc/DSDT.bridge
index 623c4c03585c47d4d28adc611823b7cce8f4a5c7..46f651d7a106032cca053b0e59a107a333f3fe7e 100644
GIT binary patch
delta 147
zcmeA)-C)Y)66_MPL5hKaQFtTQ7B(hl%gG1WRx`QjP0nTi%j7RGIfp|=fWz6(HC%{^
zv4A15fH7f_+vHvjSrZ?Y$uasY@xe~<0nVNV0YR?8&Yph3j0Na|E{-7`ApMC9rHPYo
ha-@hCFeEJ!o|=^C9O4$)43<h_U@T4AY|H5*2mk;)DzX3o

delta 111
zcmdmB+G)z=66_MvDaF9R$gz=Y3mcP<+2jLktC{?@C+D*NW%uB74tDnAnB2%I!NQoZ
z$Z_%v4q1J7mdP>tEb+lk@d3`B1_42?!Oot3!Hmu!ZjtEXE{-9LlV5VAY);|y5d;9)
C1RtUR

diff --git a/tests/data/acpi/pc/DSDT.cphp b/tests/data/acpi/pc/DSDT.cphp
index e0a43ccdadae150c0f39599c85e4e21ed8fff2a4..74d132918a096b7548eaa0e13884a04fad73df21 100644
GIT binary patch
delta 143
zcmbQLwMUD~CD<jzMwEep(QYHx7B(iQu*nD5Rx`PJZ_Z`6WMuaja1M6%<CyHvAuhn-
z?B^OT#Kcy>kXXQ&u*hxlNe)>FAC}26`YiFmPVoWGo(2IyuEEZpe!+|dlNmXMIXgf)
r5*bPpCyR2Xh!-#<EfSuZl;|Ad7TFAzN@8FvO`1G`Lu_+DXB#&FuY)J6

delta 136
zcmdm^HC2ntCD<iIRFr{%(PAUl7B(jD;K>KrRx|l|Y|dr3WMuc?a}IX)<CyHvArZis
zu*i{nasp!kLqY*Vj6O?zuv2`1v!_8okZZ8Bv#-kncb3WM!k&J?jLso$k?7(sjv<Vb
NRXI~OFW{WR4FJjPC2Ifx

diff --git a/tests/data/acpi/pc/DSDT.dimmpxm b/tests/data/acpi/pc/DSDT.dimmpxm
index 21eb065a0ee3bd96f1a2e7601aa83fefa833349a..929e50d002d98872ab6100420cd5c275678a134f 100644
GIT binary patch
delta 131
zcmdmO{K%NgCD<k8kt72HBiBZ*Eo@BQUXu^7t!DDG-<->?z{un;Fu9*YMu5ZF&ox|#
ziKT!cv4AmQk=x`A9I}i)lh1L8$ri-uv&08G#RoWh8UzHn20ObrhID|GCo+^KPX5D@
fB3{6dv`BbrQlfK+TVyj>Dv5!yG--1JXS4tSxGE;e

delta 89
zcmV-f0H*)qGrKbiL{mgmyBPog0U)sov<3o1NRz+@s{%(ovuy_;0Rl)4laB}-1#kgi
vqCu0p2ptwj1e07Z1Yc7^Ur<9yFi=uOQ$tBkQ<FXk7y$v33<+ejhY4E{fyWrg

diff --git a/tests/data/acpi/pc/DSDT.ipmikcs b/tests/data/acpi/pc/DSDT.ipmikcs
index b8f08f266b5735fe6967d4e105ee6b3662dad7e6..7a1fc5f0c7b149210cac6098b18dfe243be4fadb 100644
GIT binary patch
delta 194
zcmeBE->S~#66_MPRhWT+F>WK*A2udu%gG$<tC`&NCU0f`TkkL69PI4J5v?4f&k`T(
z6d&O1X%G<P8tfe4<Ng0XhqIq+xDXR#0YhQ|W5Oag?#T&2c0vIIx@u=%mjym7lhK7e
z{el?_&;?x_Lpng_CNh*JPFCbh5iej!S|mI*DbYE^EwULbmBheUnzXr<lamVosm3_<

delta 113
zcmdn0-lxvx66_MvC(OXW7`&0|4;zz@*<=p()lB}{lee<}RrcU>4tDnAh*pl#XNeDX
ziVtx1GzbWC4R#Lj@&5n6fH7f_<Kzb%vW)JN|8a;(IET1JqAPT93}KvX$eFTv4JRiT
E0FWRe4gdfE

diff --git a/tests/data/acpi/pc/DSDT.memhp b/tests/data/acpi/pc/DSDT.memhp
index 9a9418f4bde5fb18883c244ea956122e371ff01a..5b5bf7f7d1dd78f5cb10d71be68656b3b842886f 100644
GIT binary patch
delta 147
zcmbPgxW|yoCD<ioj|2k)<GhVrTiBR9EhisfTg~L7H#wL6FO$E(<Qxte0S;$B*Ki>w
z#sY@K0>*?zZj*aCWKDcnCdcTr#0NXY2RM5g1O&MTJA3*CGZvr=x;Tb(fb=IalqOET
h$&n&nz>u^^cxqCjbBJ4HGgvB#fw44cvn^)?KLA|eD{TM(

delta 111
zcmdmEIMtBLCD<iosssZA<Hn6#TiBSK%qJgUTg~LEGdY+2FS`eybFi}?$K*y%2^PkL
zMUInaaLDSrvrLZBXNeDXiVtx1GzbWC4R-eQ3ubf<af?J3cX141ocxj_WpfH=1U~>B
C?;u?O

diff --git a/tests/data/acpi/pc/DSDT.numamem b/tests/data/acpi/pc/DSDT.numamem
index 6eec385c2ec00544c6eaa7e19d32b2ccd5a51915..57b03c88d75cbfcffc81e17d52970e52fb767dc8 100644
GIT binary patch
delta 147
zcmX@3_F0X~CD<jTSeSu<F>E8(7B(hN%gG1WRx|nNP0nTi%j7RGIfp|=fWz6(HC%{^
zv4A15fH7f_+vHvjSrZ?Y$uasY@xe~<0nVNV0YR?8&Yph3j0Na|E{-7`ApMC9rHPYo
ha-@hCFeEJ!o|=^C9O4$)43<h_U@T4AY|F{d1pq%GD&YVC

delta 111
zcmeyYc1DfMCD<jzN0@<uF>@o=7B(g)^T`L;Rx`QkOwMKh%kIJF9PI4JF}aabf`u_*
zk>lhU9J2cEER$pOS>l78;scyL4FZB(gPlG7f*GAd+#=D%T^vIgC%@!K*_^`3&jkPo
C=O57k

diff --git a/tests/data/acpi/q35/DSDT b/tests/data/acpi/q35/DSDT
index e63676d7a63afec714debeb465ee478ea4714337..26a26e68d166c7e02971d62a48b0e79c38744338 100644
GIT binary patch
delta 142
zcmexoz0`)wCD<iIRgQsyaqC8|2@*`smXqg5tY&i4o9rq1m)&2$IoR2cWAb}RaRClz
zKi6;}CdLAW!~({IMQ)QbrDP?1SSH8lv&08G#RoWh8UzHn20MHD1v3^*UMMBZ*#Xj#
r$WWR%d8<^4cmYGwBH^h?iOwNzk<DPKBnHOPq{#+SVw?4)&oco4kr^r?

delta 135
zcmZ2#^Us>gCD<k8pDY6d<LZrE6C{{?%qGu~Sk2_GJ=s(8FS`eybFi}?$K>~t5&?_}
ziyXNpComQ;Bor{j=(EHJJH-b$dm01;xduBs`?@S}XPJyH?CBTG=p5n}i7xKq7{WOD
Ms8q^k2kECw004a`%>V!Z

diff --git a/tests/data/acpi/q35/DSDT.acpihmat b/tests/data/acpi/q35/DSDT.acpihmat
index cd97b819824e4140d087e465d179b71775d6a494..bf363910b99c8501669041cb6a796e2a5fb82c40 100644
GIT binary patch
delta 177
zcmZ4GcF~Q?CD<h-P?>>&v1udM1PLZb`^j@8Rx`PnZ1$AoU}X0fa1M6%<Cr{AQaq8v
z+0Qjxh>59yA+dllVUZj6<OIe7hJ*r!7=4!bV5j&1XHSEGAlG1LXJ3~EJ}i^bg+2X(
x84J(_T^vI?K;|YglqOC-AeACsz>u^^cxqCjbBJ4HGgvB#fw44cvx+nu2LS#(GAsZ9

delta 112
zcmccUw#tpmCD<iIOPPUzv0@|F1PLZDo5^z|Rx|k;ZuXSqU}X2;a}IX)<Cr{AQi6ps
zVUgqHdMR0bcb3U9`YiFmPVoWGo(2IyuEEZpe!+~+A#RcA;x3LMjFT@&rEK<=X5#<=
D$~zv~

diff --git a/tests/data/acpi/q35/DSDT.bridge b/tests/data/acpi/q35/DSDT.bridge
index 8b0fb497dbbaeba18e9d0e1503de4396f1c230b0..22d0eab1632cdd9e78330a7c1c746120ee0a90b1 100644
GIT binary patch
delta 142
zcmeCT*=ED#66_LUCda_Q7`l;bf&`PZ<>WaMtC`&NCVNW$W%n0w4tDnAnEYN+T!6#b
z&ox|#iLrnov4AmQk=x`<DOm|0mdP>tEb+lk@d3`B1_42?!Oot3!Hfly7fK0pc7Svw
qGL$Ax-YS(MUcivFNO)>eqH~B_WHVSQiGi^+X|jQo*k*m{2TTAqS1E@8

delta 135
zcmdmH({ID&66_MfFUP>Z=(Uk+f&`O~+2lDAtC{?@Cwof%W%uB74tDnAnEYN+B7iYr
zkt6ry1jYh}gaU>beU|uOr}zM8PlJFU*I;L7UzY{$ER)fNJ^g|iokQFr(ZyXHLl`F?
Ml}g#{ApMOA04-uCG5`Po

diff --git a/tests/data/acpi/q35/DSDT.cphp b/tests/data/acpi/q35/DSDT.cphp
index d9bb414e9bf15d9b9149f38c9bb5d8b993f88650..ee2bd28aac83fc9543cafd13d654be6c0b7d47f1 100644
GIT binary patch
delta 195
zcmX?W|HYomCD<k8i#!7Zqt-^Q2@*_BVUy=btY&ic-s~x9$yo0%;2iAi#}Ta@qt6l_
z>=Ym1>}e1X<QnW8;N$)OKZmoQYq$^-TLD920b{}<H}1&^j0Fq{1q|q_oqb&v_^?by
z7xwfEW-LG#ba4#n0GXS}P?|XTqg0A`0YlOv;i*Z9&LM7*&0wh{2FB8)&7sm2EC3uJ
BI&lC1

delta 114
zcmexjf7YJMCD<k8tULn)qsm6E2@*`+!IS4mtY-4_*z753$*AnX=N#<p#}Ta@qt6l_
z>=Ym1>}e1X<QnW8;N$)Oe*t5{BFD)aq+}W0C!doNlW-1ki$quG;uyj>nNd1rbB%Nb
F3jo7{B2NGS

diff --git a/tests/data/acpi/q35/DSDT.dimmpxm b/tests/data/acpi/q35/DSDT.dimmpxm
index 29f19b22a38f9d8e7dc9870f0c1aa3d4470643ff..f58daacaf329c70c0f3007e1b4d162a20e5e7408 100644
GIT binary patch
delta 148
zcmezDG0T(7CD<iomI?y{<MoYP6C{|ty(Z6*Sk2^Tzu8k#fsx5yU~;yUi~xtTpKG`f
z6H5U@VgX~qBDcvsQnDsKER$pOS>l78;scyL4FZB(gPlG7f*A|Y1zj9NIzajp8A=l;
i-;hcXFJMSoBs?`K(K*B|vKcIu#K2gZwAn`5oD%?Qkt<IC

delta 116
zcmbQ``PqZZCD<jTScQRs@$E*g2@*^$9+T%ttY&hz-Rvo;z{u{w=N#<p$1%A<T7rc!
zVUgqH=~A-#?ktmI^jYGAo#F$WJq-eaT!WoG{el^tL);?K#a$dj7$?7wN}0?kBf7al
HT8R??uE`+;

diff --git a/tests/data/acpi/q35/DSDT.ipmibt b/tests/data/acpi/q35/DSDT.ipmibt
index e8dea1ea42af765babcb747af998b0d912abdcbd..4ecf98b8659229fe33ecf1deee5d61d4425cf52e 100644
GIT binary patch
delta 175
zcmX?U^TCG8CD<jTK#qZd@#RLY+Y(I9mXn`LtY&i4n><DGFT1~hbFi}?$K;EW;)xv2
zey-s{OpFB#i3N-ai`=*;Cji+A1q?CzEb+lk@d3`B1_42?!OqUUE(?5ECZh{``UNu<
upbNS<hID|;O=KudoFtthUcivFNO)>eqH~B_WHVSMiGi^+X>*G7QzigB(={9b

delta 111
zcmexhbJB*(CD<jzQ;vaw@!m$R+Y(GZW|N;wtY-4po;*eJFS`eybFi}?$K;EW5-f}f
ziySBKmy*?YXPF$M&k`T(6d&O1X%G<P8tm-p7tH7!;ueW6?&282I9WhCWplUmQzihc
CSRxAm

diff --git a/tests/data/acpi/q35/DSDT.memhp b/tests/data/acpi/q35/DSDT.memhp
index dca76db15b943122efd5c200cb54ce3dbc97a55f..06bc000ff275668d6864b5d16117d48b308c6d61 100644
GIT binary patch
delta 142
zcmX@>_Qj3MCD<jTM45qsv2!EW1PLZj%gJ*jRx|nNP4<-h%kD4W9PI4JG5NiuxB!Q<
zpKG`f6Jr5GVgX~qBDcwzQnC_0ER$pOS>l78;scyL4FZB(gPlG7f*A`YFO(AI>;UOV
qWGGFXyj3biynrETk?_={MCTB<$Y!uq5(8st(qscEvCaC@avT80Z7JRW

delta 135
zcmez3cGiu{CD<jzSDAr<an44r2@*_B=9A}0tY&i6nd~X~m)(QUIoR2cWAb}Ri2%lg
zMULE)6Br8^5(*e%^jYGAo#F$WJq-eaT!WpReO(r~vrI-8_Vf#8bPjQgL>G5)3}Kvn
MR4Qe&gR}_;0Jjb&i2wiq

diff --git a/tests/data/acpi/q35/DSDT.mmio64 b/tests/data/acpi/q35/DSDT.mmio64
index 6d8facd9e179140682ad5d4302f3dad14dbec342..1d34813a26b46e229c5dee7d7b19680aa941b006 100644
GIT binary patch
delta 142
zcmaFi((lUU66_Mvuf)K>=(>?>f&`PN<>WaMtC@WCCVNW$W%n0w4tDnAnEYN+T!6#b
z&ox|#iLrnov4AmQk=x`<DOm|0mdP>tEb+lk@d3`B1_42?!Oot3!Hfly7fK0pc7Svw
qGL$Ax-YS(MUcivFNO)>eqH~B_WHVSQiGi^+X|jQo*k*lcOLhQ=J}H3!

delta 135
zcmeBoec{6866_L^p~S$z7_pISf&`P3`Q$kgtC?JNCVNW$W%uB74tDnAnEYN+B7iYr
zkt6ry1jYh}gaU>beU|uOr}zM8PlJFU*I;L7UzY{$ER)fNJ^g|iokQFr(ZyXHLl`F?
Ml}g#{Annf%0DB@QEC2ui

diff --git a/tests/data/acpi/q35/DSDT.numamem b/tests/data/acpi/q35/DSDT.numamem
index 737325dc3082fdf06283857811f6f5174e0ff2a9..7e1775656cf08224d815e6e2986fa68dbe54d4e1 100644
GIT binary patch
delta 142
zcmZp%S#87R66_M9EyuvX=(v$<f&`PN<>WaMtC@WCCVNW$W%n0w4tDnAnEYN+T!6#b
z&ox|#iLrnov4AmQk=x`<DOm|0mdP>tEb+lk@d3`B1_42?!Oot3!Hfly7fK0pc7Svw
qGL$Ax-YS(MUcivFNO)>eqH~B_WHVSQiGi^+X|jQo*k*m{t4shN`YBTY

delta 135
zcmZ2&(_+Kr66_MfBFDhM7_yOTf&`P3`Q$kgtC?JNCVNW$W%uB74tDnAnEYN+B7iYr
zkt6ry1jYh}gaU>beU|uOr}zM8PlJFU*I;L7UzY{$ER)fNJ^g|iokQFr(ZyXHLl`F?
Ml}g#{ApM#N02x0f{r~^~

diff --git a/tests/data/acpi/q35/DSDT.tis b/tests/data/acpi/q35/DSDT.tis
index 27ee927fc5ac05b89724c154197304c39e653269..d7872b2dc57bfe64d76051158f315816e166002a 100644
GIT binary patch
delta 142
zcmccZ(B#PF66_Mvq`<(y*td~uf&`PZ<>WaMtC`&NCVNW$W%n0w4tDnAnEYN+T!6#b
z&ox|#iLrnov4AmQk=x`<DOm|0mdP>tEb+lk@d3`B1_42?!Oot3!Hfly7fK0pc7Svw
qGL$Ax-YS(MUcivFNO)>eqH~B_WHVSQiGi^+X|jQo*k*lc9aaF0nJIn%

delta 135
zcmZp2yzRi{66_KZt-!#**u0Tzf&`O~+2lDAtC{?@Cwof%W%uB74tDnAnEYN+B7iYr
zkt6ry1jYh}gaU>beU|uOr}zM8PlJFU*I;L7UzY{$ER)fNJ^g|iokQFr(ZyXHLl`F?
Ml}g#{Ann8o0DcZ9DF6Tf

-- 
2.26.2


