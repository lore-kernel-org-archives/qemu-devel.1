Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFD1C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:18:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 887362073E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WO0UPXrj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 887362073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlSLZ-0000MT-PN
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 03:18:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jlSF1-0007AQ-QN
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 03:12:11 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40925
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jlSEz-0000VF-1O
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 03:12:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592377928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=CRP5nFic0KQPwNNP6bY2yX+/8sTfxWXbFvBbOXawvuI=;
 b=WO0UPXrjeaGiB8zqodzOugksTyCqFTbpmfBpkri3gh8aZbnFMQGBgZQxsWekJUW5MGXK3v
 A8qAQtOu6BEHwEoxHKSm0/hnRu+BIyFjCpBPQv9xXE2grj03f7Ce5KCQTVaVzC6DXqBc4M
 A91eBNbCqoSenKSbXRfL/bpSWI01mgs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-9h3CSqrQMf-DibXelv4YrA-1; Wed, 17 Jun 2020 03:12:05 -0400
X-MC-Unique: 9h3CSqrQMf-DibXelv4YrA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F89681EE51;
 Wed, 17 Jun 2020 07:12:03 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-67.ams2.redhat.com
 [10.36.112.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 431595C1D2;
 Wed, 17 Jun 2020 07:11:59 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id F32089D9B; Wed, 17 Jun 2020 09:11:38 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 10/10] acpi: q35: drop _SB.PCI0.ISA.LPCD opregion.
Date: Wed, 17 Jun 2020 09:11:38 +0200
Message-Id: <20200617071138.11159-11-kraxel@redhat.com>
In-Reply-To: <20200617071138.11159-1-kraxel@redhat.com>
References: <20200617071138.11159-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 02:02:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Seems to be unused.

ich9 DSDT changes:

     Scope (_SB.PCI0)
     {
         Device (ISA)
         {
             Name (_ADR, 0x001F0000)  // _ADR: Address
             OperationRegion (PIRQ, PCI_Config, 0x60, 0x0C)
-            OperationRegion (LPCD, PCI_Config, 0x80, 0x02)
-            Field (LPCD, AnyAcc, NoLock, Preserve)
-            {
-                COMA,   3,
-                    ,   1,
-                COMB,   3,
-                Offset (0x01),
-                LPTD,   2
-            }
         }
     }

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/i386/acpi-build.c              |  11 -----------
 tests/data/acpi/q35/DSDT          | Bin 7718 -> 7678 bytes
 tests/data/acpi/q35/DSDT.acpihmat | Bin 9042 -> 9002 bytes
 tests/data/acpi/q35/DSDT.bridge   | Bin 7735 -> 7695 bytes
 tests/data/acpi/q35/DSDT.cphp     | Bin 8181 -> 8141 bytes
 tests/data/acpi/q35/DSDT.dimmpxm  | Bin 9371 -> 9331 bytes
 tests/data/acpi/q35/DSDT.ipmibt   | Bin 7793 -> 7753 bytes
 tests/data/acpi/q35/DSDT.memhp    | Bin 9077 -> 9037 bytes
 tests/data/acpi/q35/DSDT.mmio64   | Bin 8848 -> 8808 bytes
 tests/data/acpi/q35/DSDT.numamem  | Bin 7724 -> 7684 bytes
 tests/data/acpi/q35/DSDT.tis      | Bin 8323 -> 8283 bytes
 11 files changed, 11 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 59f1b4d89000..378515df66c5 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1340,7 +1340,6 @@ static void build_q35_isa_bridge(Aml *table)
 {
     Aml *dev;
     Aml *scope;
-    Aml *field;
 
     scope =  aml_scope("_SB.PCI0");
     dev = aml_device("ISA");
@@ -1350,16 +1349,6 @@ static void build_q35_isa_bridge(Aml *table)
     aml_append(dev, aml_operation_region("PIRQ", AML_PCI_CONFIG,
                                          aml_int(0x60), 0x0C));
 
-    aml_append(dev, aml_operation_region("LPCD", AML_PCI_CONFIG,
-                                         aml_int(0x80), 0x02));
-    field = aml_field("LPCD", AML_ANY_ACC, AML_NOLOCK, AML_PRESERVE);
-    aml_append(field, aml_named_field("COMA", 3));
-    aml_append(field, aml_reserved_field(1));
-    aml_append(field, aml_named_field("COMB", 3));
-    aml_append(field, aml_reserved_field(1));
-    aml_append(field, aml_named_field("LPTD", 2));
-    aml_append(dev, field);
-
     aml_append(scope, dev);
     aml_append(table, scope);
 }
diff --git a/tests/data/acpi/q35/DSDT b/tests/data/acpi/q35/DSDT
index dada9bf69fc23ea9c0931029445257657fde90ce..e63676d7a63afec714debeb465ee478ea4714337 100644
GIT binary patch
delta 63
zcmZ2x^Us>gCD<k8pDY6d<LZrE^BL9D^x}h^;scyL4WgT*JcAwMIpQ5%f_NAh<QbwH
T0z88PnYa?Tcs74$)RzGOT*VQ4

delta 103
zcmexoz08KoCD<iIO^$(q@!v+S`HX&kEPC<5PVoWGo(9oPjx3(Rj`1AvjxIqw3=HxN
z(G3BfL4izM30yqU4L$+RE=*hvTujl8k{~vNv%jw+GXo=#aspC50U<6-o6j@q%K!k0
Cz!`f0

diff --git a/tests/data/acpi/q35/DSDT.acpihmat b/tests/data/acpi/q35/DSDT.acpihmat
index 134fcffc3036c250877a50847426b2fe6d4229d7..cd97b819824e4140d087e465d179b71775d6a494 100644
GIT binary patch
delta 63
zcmccQw#tpmCD<iIOPPUzv0@|Fd`2}jz4&0K_yA{5gXktH&tS)Rj(A6xARYz=d4}kQ
S0MDR6Cawf7p3UDGqZI)owGfy9

delta 103
zcmZ4GcFB#)CD<h-NST3w@ytf9`HX&kEPC<5PVoWGo(9oPjx3(Rj`1AvjxIqw3=HxN
z(G3BfL4izM30yqU4L$+RE=*hvTujl8k{~vNv%jw+GXo=#aspC50U<6-o6j>wD*^z5
Cjv1H$

diff --git a/tests/data/acpi/q35/DSDT.bridge b/tests/data/acpi/q35/DSDT.bridge
index 6be4ccde643b3bba57f827c65490fa3a328ca77e..8b0fb497dbbaeba18e9d0e1503de4396f1c230b0 100644
GIT binary patch
delta 63
zcmdmP({ID&66_MfFUP>Z=(Uk+KBJnNUVN}qe1Nm3L3ERpXRu>DN4%p;5Dx=`JVSIt
SfM-x36ITKk&*txp4l)1&84ut9

delta 103
zcmeCT*>1z-66_LUF2}&YIBz4@d`3S%7QOgjr}zM8PlM<tM;6au$9Rr-N0%TT1_pVC
z=!O8#pg<<B1TLQF2A=?D7bdO-E~e;4Nf4XC+27ZZnSl{VIRPo3fDjj^&F2{%WB^Gr
B7~lW^

diff --git a/tests/data/acpi/q35/DSDT.cphp b/tests/data/acpi/q35/DSDT.cphp
index d076236552c60b275bd91e59ab03ea8d96ccc9ea..d9bb414e9bf15d9b9149f38c9bb5d8b993f88650 100644
GIT binary patch
delta 63
zcmexrf7YJMCD<k8tULn)qsm6E`HX66dhx+d@d3`B2GLDYp23ds9Py4WK|Bl$@(j@p
T0iHpDOk4?EJe$8W{*wg&L=O?V

delta 103
zcmX?W|J9z$CD<k8t2_e(W5q_U`HX&kEPC<5PVoWGo(9oPjx3(Rj`1AvjxIqw3=HxN
z(G3BfL4izM30yqU4L$+RE=*hvTujl8k{~vNv%jw+GXo=#aspC50U<6-o6j@;lLY{`
CU>dpr

diff --git a/tests/data/acpi/q35/DSDT.dimmpxm b/tests/data/acpi/q35/DSDT.dimmpxm
index eeef0a4c15828b3a621aab88eafb3631ff85a960..29f19b22a38f9d8e7dc9870f0c1aa3d4470643ff 100644
GIT binary patch
delta 63
zcmbR3`PqZZCD<jTScQRs@$E*g`HX66dhx+d@d3`B2GLDYp23ds9Py4WK|Bl$@(j@p
T0iHpDOk4?EJe$8WE>QviPgW7Q

delta 103
zcmezDG24^NCD<iowh99SqvJ-d`HX&kEPC<5PVoWGo(9oPjx3(Rj`1AvjxIqw3=HxN
z(G3BfL4izM30yqU4L$+RE=*hvTujl8k{~vNv%jw+GXo=#aspC50U<6-o6j>YQ33#W
Cof)_Q

diff --git a/tests/data/acpi/q35/DSDT.ipmibt b/tests/data/acpi/q35/DSDT.ipmibt
index 5d89b41a1878bb0c77abda0807bcc833c7538581..e8dea1ea42af765babcb747af998b0d912abdcbd 100644
GIT binary patch
delta 63
zcmexpbJB*(CD<jzQ;vaw@!m$R`HX66dhx+d@d3`B2GLDYp23ds9Py4WK|Bl$@(j@p
T0iHpDOk4?EJe$8WR>=SWM>P>#

delta 103
zcmX?U^U;ROCD<jTP>z9t(P$&rd`3S%7QOgjr}zM8PlM<tM;6au$9Rr-N0%TT1_pVC
z=!O8#pg<<B1TLQF2A=?D7bdO-E~e;4Nf4XC+27ZZnSl{VIRPo3fDjj^&F2}bWB_NL
B8C(DW

diff --git a/tests/data/acpi/q35/DSDT.memhp b/tests/data/acpi/q35/DSDT.memhp
index ad0608ef4d22de894e0a72596c2b15dead384903..dca76db15b943122efd5c200cb54ce3dbc97a55f 100644
GIT binary patch
delta 63
zcmezBcGiu{CD<jzSDAr<an44r`HX66dhx+d@d3`B2GLDYp23ds9Py4WK|Bl$@(j@p
T0iHpDOk4?EJe$8W)+qu2Lp2dd

delta 103
zcmX@>_SKEcCD<jTRGEQ+@xw;0`HX&kEPC<5PVoWGo(9oPjx3(Rj`1AvjxIqw3=HxN
z(G3BfL4izM30yqU4L$+RE=*hvTujl8k{~vNv%jw+GXo=#aspC50U<6-o6j@WDFOhv
C78*zZ

diff --git a/tests/data/acpi/q35/DSDT.mmio64 b/tests/data/acpi/q35/DSDT.mmio64
index b6c6946ed9812685dd71b51784900480963b54bd..6d8facd9e179140682ad5d4302f3dad14dbec342 100644
GIT binary patch
delta 63
zcmbQ>`oe|FCD<h-Ly3WbF=8Xvd`2}jz4&0K_yA{5gXktH&tS)Rj(A6xARYz=d4}kQ
T0MDR6Cawf7p3UDGXDR>yD8Ufx

delta 103
zcmaFiGQpM0CD<iof)WD*<C=|J^BMj8SoGq9o#F$WJq@Cp99cYr9pgFT9bJNW7#QRk
zq8kD{g94ej61aGx8+-zsU6{BUxR|0FB|&TkXMbNuW(Gze<piXB0zzDvHlJslsQ>_s
C2pQ`D

diff --git a/tests/data/acpi/q35/DSDT.numamem b/tests/data/acpi/q35/DSDT.numamem
index 9b5c962434471d63d65f027c84dfc3e6ac20e10b..737325dc3082fdf06283857811f6f5174e0ff2a9 100644
GIT binary patch
delta 63
zcmZ2u(_+Kr66_MfBFDhM7_yOTKBJnNUVN}qe1Nm3L3ERpXRu>DN4%p;5Dx=`JVSIt
SfM-x36ITKk&*txprZNEhI1j!6

delta 103
zcmZp%S!2WH66_M9BgeqNxMCyMd`3S%7QOgjr}zM8PlM<tM;6au$9Rr-N0%TT1_pVC
z=!O8#pg<<B1TLQF2A=?D7bdO-E~e;4Nf4XC+27ZZnSl{VIRPo3fDjj^&F2|SWdJ|O
B7`^}i

diff --git a/tests/data/acpi/q35/DSDT.tis b/tests/data/acpi/q35/DSDT.tis
index 7cb8d8b154f3de295669a741c9ec3ec8c67e2b2f..27ee927fc5ac05b89724c154197304c39e653269 100644
GIT binary patch
delta 63
zcmZp6yzRi{66_KZt-!#**u0TzKBJnNUVN}qe1Nm3L3ERpXRu>DN4%p;5Dx=`JVSIt
SfM-x36ITKk&*txpJ#qjggb>yM

delta 103
zcmccZ(Co<N66_MvtiZs)czq++d`3S%7QOgjr}zM8PlM<tM;6au$9Rr-N0%TT1_pVC
z=!O8#pg<<B1TLQF2A=?D7bdO-E~e;4Nf4XC+27ZZnSl{VIRPo3fDjj^&F2|=<N$};
B8P)&*

-- 
2.18.4


