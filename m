Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADB9C47254
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:36:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8A232087E
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RTK7i3tH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A232087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVcDF-00011E-JT
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:36:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc6U-0005qR-MW
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:29:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28022
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc6T-0006IW-Ae
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588602592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LtXVkBoCFIAVJ/jOrNLyyiGZyY5VnZEubRIet50fmJI=;
 b=RTK7i3tHQ7D/eBtc2zeKK78TGdOKKAQJvm4tJ9hJhVZPP3xOcVXK3ShHXYvtBRJ9F6qnLt
 NfB3cYWxcHWDGiRtnKoFP40gQWR2l+DYA4uqB8rJwS4Bywt1VcpiAmcocSehnPkrbCZNXI
 FNKkXm4KMyizyrhdXqlbp1RcOx/b1fw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-N5J-0rNbOjaCcTBFRKdJ_w-1; Mon, 04 May 2020 10:29:51 -0400
X-MC-Unique: N5J-0rNbOjaCcTBFRKdJ_w-1
Received: by mail-wm1-f72.google.com with SMTP id f128so4983967wmf.8
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 07:29:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7nWALb+pJoUtPTist7vsOnCoCaxtfGeZaRiKPqBS0NQ=;
 b=qq4uZUnleckhcbFDQvmWvSlTLWoMVhrTPpLHu1NkLOfUGJ6KIYErFpM39anEeMAvJZ
 IRhTtrrWrJdLWMJNnCtJyk1EAuDhxCBCSuZUmnigqdmXfHJpc1boArvg/dIURSeW7Dx0
 R4Bz3unvS+0fdwArBEUP+F+T/I5SbFADQUeNB7hArbXd2FcNU0X2wX+HilHVhVMtRLaq
 uaeqbBZtc/huV7/OxlLThzl9Lh+mYral9o2CZsO2FCU905RKImewXQXgWARbb3GpPo0N
 rto66o7YUJMv0u6QiJQRlfwUmQlG18iPJB0H+QACvy0F/Lr/i/R76TbP1rlFAz8QndyI
 qDBQ==
X-Gm-Message-State: AGi0PuYXeLvzg276h9o2b+ONebhYOzHi7ysfZxEhR6nG0CLdK6ZFS4WL
 bdAfTCO8UEDn7LY5FNrPILBVO4cOjqQaksY4qpBIsFw3ApU5G/lnUA8784zicfXKVBiM6uPwoAp
 wJ6/1OPzTg1niY6o=
X-Received: by 2002:a7b:c306:: with SMTP id k6mr14454914wmj.40.1588602589216; 
 Mon, 04 May 2020 07:29:49 -0700 (PDT)
X-Google-Smtp-Source: APiQypLAxwLp6ehplwK9OFaGfUXobi8iQo/KNl/m+Nw8T3kdDPixK9zU7w/hdGJQvo8SBjgmr6KmCw==
X-Received: by 2002:a7b:c306:: with SMTP id k6mr14454890wmj.40.1588602588907; 
 Mon, 04 May 2020 07:29:48 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 k17sm13605519wmi.10.2020.05.04.07.29.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 07:29:48 -0700 (PDT)
Date: Mon, 4 May 2020 10:29:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/29] acpi: DSDT without _STA
Message-ID: <20200504142814.157589-15-mst@redhat.com>
References: <20200504142814.157589-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200504142814.157589-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 04:24:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

commit f6595976e699 ("acpi: drop pointless _STA method") replaced
_STA method with simple name object. Update DSDT accordingly.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h |  17 -----------------
 tests/data/acpi/pc/DSDT                     | Bin 5131 -> 5125 bytes
 tests/data/acpi/pc/DSDT.acpihmat            | Bin 6455 -> 6449 bytes
 tests/data/acpi/pc/DSDT.bridge              | Bin 6990 -> 6984 bytes
 tests/data/acpi/pc/DSDT.cphp                | Bin 5594 -> 5588 bytes
 tests/data/acpi/pc/DSDT.dimmpxm             | Bin 6784 -> 6778 bytes
 tests/data/acpi/pc/DSDT.ipmikcs             | Bin 5203 -> 5197 bytes
 tests/data/acpi/pc/DSDT.memhp               | Bin 6490 -> 6484 bytes
 tests/data/acpi/pc/DSDT.numamem             | Bin 5137 -> 5131 bytes
 tests/data/acpi/q35/DSDT                    | Bin 7869 -> 7863 bytes
 tests/data/acpi/q35/DSDT.acpihmat           | Bin 9193 -> 9187 bytes
 tests/data/acpi/q35/DSDT.bridge             | Bin 7886 -> 7880 bytes
 tests/data/acpi/q35/DSDT.cphp               | Bin 8332 -> 8326 bytes
 tests/data/acpi/q35/DSDT.dimmpxm            | Bin 9522 -> 9516 bytes
 tests/data/acpi/q35/DSDT.ipmibt             | Bin 7944 -> 7938 bytes
 tests/data/acpi/q35/DSDT.memhp              | Bin 9228 -> 9222 bytes
 tests/data/acpi/q35/DSDT.mmio64             | Bin 8999 -> 8993 bytes
 tests/data/acpi/q35/DSDT.numamem            | Bin 7875 -> 7869 bytes
 18 files changed, 17 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios=
-tables-test-allowed-diff.h
index 6a052c5044..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,18 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/pc/DSDT",
-"tests/data/acpi/pc/DSDT.acpihmat",
-"tests/data/acpi/pc/DSDT.bridge",
-"tests/data/acpi/pc/DSDT.cphp",
-"tests/data/acpi/pc/DSDT.dimmpxm",
-"tests/data/acpi/pc/DSDT.ipmikcs",
-"tests/data/acpi/pc/DSDT.memhp",
-"tests/data/acpi/pc/DSDT.numamem",
-"tests/data/acpi/q35/DSDT",
-"tests/data/acpi/q35/DSDT.acpihmat",
-"tests/data/acpi/q35/DSDT.bridge",
-"tests/data/acpi/q35/DSDT.cphp",
-"tests/data/acpi/q35/DSDT.dimmpxm",
-"tests/data/acpi/q35/DSDT.ipmibt",
-"tests/data/acpi/q35/DSDT.memhp",
-"tests/data/acpi/q35/DSDT.mmio64",
-"tests/data/acpi/q35/DSDT.numamem",
diff --git a/tests/data/acpi/pc/DSDT b/tests/data/acpi/pc/DSDT
index c6adfe32d5ba6a5db2ca3e210766839547e122c8..ad4b2d46cc7865e8bafcca2e4e8=
88a03cc5483b5 100644
GIT binary patch
delta 77
zcmeCyXw~3y33dr#6=3D7gtRNKha%gE#_H+d$by@-jolS@2DyoaX?kK+YqW{&va5XZ^y
W8I?p-eEmb=3D68yqoiOm{Jj|BnUDii7e

delta 83
zcmZqG=3D+@wJ33dtL7GYpu+_;gemyyX?e)3F4dvSAbCzp7Rcn?n(9>)vJ%p#oe!6A+e
aOD4ZzR1#PB^$&&1@e9M`HY+hb76brx%@yYW

diff --git a/tests/data/acpi/pc/DSDT.acpihmat b/tests/data/acpi/pc/DSDT.acp=
ihmat
index ad890e09aab12dd280c3d2465540db82ca1b430b..eff7aadfabe431c3ac2d28e0c67=
21eb6e322af66 100644
GIT binary patch
delta 77
zcmdmPw9$ymCD<jzP?CXx@ykZ8UPdNgxydsb?L|zyom}EM;ypZFcpNV<GjqfThd54t
X&!{A#;_Dv@m*5u$OKjF);ui-1J46(R

delta 83
zcmdmJwB3lyCD<jzT#|u-v3?_0FC&w){N$O8_TuK=3DPA>5r@gANoJdPKbnMF9`gF_q{
amP~%bs3flL>mLf2;}?d>ZB}C97Y6{CS`~x<

diff --git a/tests/data/acpi/pc/DSDT.bridge b/tests/data/acpi/pc/DSDT.bridg=
e
index f01fa3ad4ee6aed5262daef464a1ade41e06975d..92ae808e2e071e367f0b68b3553=
239bd56b4b766 100644
GIT binary patch
delta 77
zcmX?ScEXIyCD<jzLz;nsF@GahFC&w$+~k>z_97<UPA>5r@gANoJdPKbnK|NvLmVf+
XXH*hV@%0adOYjSWB{pj?sYwC=3DF<TUB

delta 83
zcmX?McFv5;CD<jzPnv;&@z+MKUPdNo`N=3DaG?ZwT#om}EM;ypZFcpNV<GmCJ>2ZuN^
aESda<QAu3g*FO|4$1e<%+pNT-CJ6x2Ef!}0

diff --git a/tests/data/acpi/pc/DSDT.cphp b/tests/data/acpi/pc/DSDT.cphp
index 3295d81c7f725472671632ac612a1c3ed81d7492..f3572358510f3fbb3d966047274=
f7aa7835e7bef 100644
GIT binary patch
delta 77
zcmcbmeMOtgCD<k8iYNmE<ARM`y^Ku0a+7B=3D+KZTYJGsPj#Cv$U@Hk#zX6A?w4so3P
Xo>56e#n(R+F2OGhme{Ppv`H8MV#pP#

delta 83
zcmcbjeM_6mCD<k8mM8-QqxMFwUPdNo`N=3DaG?ZwT#om}EM;ypZFcpNV<GmCJ>2ZuN^
aESda<QAu3g*FO|4$1e<%+pNU2Nf-da@D`>3

diff --git a/tests/data/acpi/pc/DSDT.dimmpxm b/tests/data/acpi/pc/DSDT.dimm=
pxm
index ad2800de672534dc87012f03e27b19671a330083..7fa09463c16c2f6b60114591785=
918b9d96b4f17 100644
GIT binary patch
delta 77
zcmZoL{bj=3DC66_LECB?wN*uIggmyyX=3DZt_e<dl3_FCzp7Rcn?n(9>)vJ%pCE-A&!&Z
WGb)Lw`1*&!CHRHG5}P%cA|wDh`xM0h

delta 83
zcmexm(qPKv66_MvAjQDID72BQmyyX?e)3F4dvSAbCzp7Rcn?n(9>)vJ%p#oe!6A+e
aOD4ZzR1#PB^$&&1@e9M`HY+hjNB{ts#}&c=3D

diff --git a/tests/data/acpi/pc/DSDT.ipmikcs b/tests/data/acpi/pc/DSDT.ipmi=
kcs
index 2633a8cecf017bfce01ba8377428b8c5433e0be2..469d13e1f6b873bb9cfa0b3af32=
d1a3bc58e8f77 100644
GIT binary patch
delta 76
zcmcbtaaM!NCD<jzSA>Cqao0w!UPeaO$uk%oL`=3DM$T;e(6Jv?1_94|04bHoRSI8J`g
Ws3fA|>mLf2;1>o<Y}R1X76Je-trU0w

delta 82
zcmX@Baan`QCD<h-ScHLr(QG4EFC(M(<Qa?(;^y8?F7X`k9-b~dju)7jML6SwLmU~F
ZOn$?tB(Co39}1V_7lz4gR$|f?0sxEt6?Fgr

diff --git a/tests/data/acpi/pc/DSDT.memhp b/tests/data/acpi/pc/DSDT.memhp
index 9e75ac96e15730f245ff6730bd28127ad827119a..aee75bea272cc9983202cceb747=
aecc297b5104e 100644
GIT binary patch
delta 77
zcmca*bj66vCD<h-M3RAlQDP%kFC&w$+~k>z_97<UPA>5r@gANoJdPKbnK|NvLmVf+
XXH*hV@%0adOYjSWB{pj?8Hob`BYG4!

delta 83
zcmca&bjyg#CD<h-N|J$raq&j3UPdNo`N=3DaG?ZwT#om}EM;ypZFcpNV<GmCJ>2ZuN^
aESda<QAu3g*FO|4$1e<%+pNT7Bn|+=3D-WD_f

diff --git a/tests/data/acpi/pc/DSDT.numamem b/tests/data/acpi/pc/DSDT.numa=
mem
index 71a975b3e25f8b5cc4491f16d5575a3a35afc777..9a747f6f08f61c73b891d8f91db=
01521e635f811 100644
GIT binary patch
delta 77
zcmbQJ(XGMd66_MfEyBRScwr+~FC&w$+~k>z_97<UPA>5r@gANoJdPKbnK|NvLmVf+
XXH*hV@%0adOYjSWB{pj?y%Yoh3_}#G

delta 83
zcmeCyn5e<!66_KpD8j(N7`>6JmyyX?e)3F4dvSAbCzp7Rcn?n(9>)vJ%p#oe!6A+e
aOD4ZzR1#PB^$&&1@e9M`HY+i`6a)ZeKNYC}

diff --git a/tests/data/acpi/q35/DSDT b/tests/data/acpi/q35/DSDT
index 1f91888d7a485850cf27f152e247a90b208003dc..9fa4d5a405c2bcd9313b1389491=
7622bf156013e 100644
GIT binary patch
delta 77
zcmdmMyWN({CD<ioyBq@pW9ddN0VXCdvB@$__97<UPA>5r@gANoJdPKbnK|NvLmVd;
XF)4|t`1*&!CHRHG5}Q{u3CREe1yK{h

delta 83
zcmdmPyVsV>CD<iouN(sdBf~~60VXB~@yRkw_TuK=3DPA>5r@gANoJdPKbnMF9`gF_q{
amQ2oPQW979^$&&1@e9M`HZNrok^ul)^%TAU

diff --git a/tests/data/acpi/q35/DSDT.acpihmat b/tests/data/acpi/q35/DSDT.a=
cpihmat
index 3586f6368a77d1497c35a7571c9f6c460221d9ab..2d834a854ccddc17afd0bc4b4a9=
e0886feff8e65 100644
GIT binary patch
delta 77
zcmaFq{@9(%CD<k8u`&Y#qw_{C0VXCdvB@$__97<UPA>5r@gANoJdPKbnK|NvLmVd;
XF)4|t`1*&!CHRHG5}Q{u*(m}5CR-F;

delta 83
zcmaFt{?eVxCD<k8r7{Bp<GGDo0!&N};*({V?8VK!om}EM;ypZFcpNV<GmCJ>2ZuN^
aESa3oq$IBH>mLf2;}?d>ZC=3DV`rw9PVffiZ-

diff --git a/tests/data/acpi/q35/DSDT.bridge b/tests/data/acpi/q35/DSDT.bri=
dge
index eae3a2a8657e9986d8ac592958503c0b516faaef..b75122b24a41b8fd58b9e707103=
2298e0fc2284b 100644
GIT binary patch
delta 77
zcmX?Sd%~8>CD<k8gd76{qv%F10VXCdvB@$__97<UPA>5r@gANoJdPKbnK|NvLmVd;
XF)4|t`1*&!CHRHG5}Q{uDa!x=3D{9qHM

delta 83
zcmX?Md(M{2CD<k8oE!rK<ARM`0!&N};*({V?8VK!om}EM;ypZFcpNV<GmCJ>2ZuN^
aESa3oq$IBH>mLf2;}?d>ZC=3DWxECT?S1r?$I

diff --git a/tests/data/acpi/q35/DSDT.cphp b/tests/data/acpi/q35/DSDT.cphp
index 53d735a4de25c4d8e23eed102fcd01376168c5b3..c59c19ff46b9bb4fa3e06e9ffbc=
beba308a80cd0 100644
GIT binary patch
delta 77
zcmeBiY;)vt33dr-Q($0Ve7BKHfQiXVY_bfKy@-jolS@2DyoaX?kK+YqW{&va5XZ?y
WOiCguzW$+b34UR)#OBpZ4`l)UY7~J0

delta 83
zcmZp3>~Z9B33dtTQD9(TtlY>Yz{KPrK3RszUfkT<$t9j6-ow*{$MFI)vj}H=3DaEK$r
ZlF9i@O5*Ci{-JO=3Deqos0=3DA}#zWdT#Y6@CB!

diff --git a/tests/data/acpi/q35/DSDT.dimmpxm b/tests/data/acpi/q35/DSDT.di=
mmpxm
index 02ccdd5f38d5b2356dcca89398c41dcf2595dfff..9edc104ee6b06dd9d909b65b83c=
99494d03a137d 100644
GIT binary patch
delta 77
zcmdnwwZ@CfCD<iIN0otrar;It0VXCdvB@$__97<UPA>5r@gANoJdPKbnK|NvLmVd;
XF)4|t`1*&!CHRHG5}Q{uwJQMt^luaX

delta 83
zcmZ4EwaJUiCD<jzNR@$s(P<->027mg_+%L-dvSAbCzp7Rcn?n(9>)vJ%p#oe!6A+e
aOD5+tDT%B5`iH{h_=3DRC|o0l@RD**sWt`z$K

diff --git a/tests/data/acpi/q35/DSDT.ipmibt b/tests/data/acpi/q35/DSDT.ipm=
ibt
index 9e2d4f785c54629d233924a503cfe81199e22aa0..3910e9b767808962b46501da519=
45229359e3d1d 100644
GIT binary patch
delta 76
zcmeCMYqH~V33dr#l4oFGT(OZ$fQiv{vNV%}h>5q8OFT!sho=3DjV;{|4Bj`-jZ$H_%Z
VN+K%0{-JOQeqpf0=3DG9EGG61;j69)hQ

delta 82
zcmZp&>#*Z;33dtLkY`|ERN2TSz{Kc1S(?c~+}zvAC7vVR!_$Sw@d7im2xok7h$F+2
Y$@xr5;_ANsp>R2VVVK<JrA)Ch012QJ1ONa4

diff --git a/tests/data/acpi/q35/DSDT.memhp b/tests/data/acpi/q35/DSDT.memh=
p
index baefa611acadce4c6da5babdaafad533d19358e6..8461e984c965da916d828884f66=
29422e83e429c 100644
GIT binary patch
delta 77
zcmeD2X!GE533dr#Q(<6WOxwsMz{KPwHd%(rUc|)P$t9j6-ow*{$MFI)Ge>-Ih~wlU
WCM6LSU;j|J1ivs?V)JUIL`49;91{-!

delta 83
zcmZqk=3D<(ok33dtLQDI<U{J4=3DzfQiXLe6kFay|}rzlS@2DyoaX?kK+YqW)aT#;1EZK
ZC6n`+l*HA2{X^k${K7D~%}bdQ6#-ML6$}6X

diff --git a/tests/data/acpi/q35/DSDT.mmio64 b/tests/data/acpi/q35/DSDT.mmi=
o64
index aae0ea2110a54b02f772d99e66df0730d74b43d9..fc0cc096baf8aedc0a526978ff7=
96025d7380453 100644
GIT binary patch
delta 77
zcmZ4Pw$P2sCD<iIQJH~(QE4NW027m!*kl<ddl3_FCzp7Rcn?n(9>)vJ%pCE-A&!%a
Wn3P0ReEmb=3D68yqoiOs8-Y7_v&S`#q<

delta 83
zcmZ4Jw%m=3D&CD<iIU73M_aqUJf0VXB~@yRkw_TuK=3DPA>5r@gANoJdPKbnMF9`gF_q{
amQ2oPQW979^$&&1@e9M`HZNtWQ2+p085J%7

diff --git a/tests/data/acpi/q35/DSDT.numamem b/tests/data/acpi/q35/DSDT.nu=
mamem
index 859a2e08710ba37f56c9c32b0235ff90cedb1905..498c843be1695a0fe1d31d88873=
b57206d17d758 100644
GIT binary patch
delta 77
zcmX?XyVsV>CD<iouN(sdqx?oL0VXCdvB@$__97<UPA>5r@gANoJdPKbnK|NvLmVd;
XF)4|t`1*&!CHRHG5}Q{uNyq>I^-L3k

delta 83
zcmdmMd)SuCCD<k8up9#e<Eo8Z0!&N};*({V?8VK!om}EM;ypZFcpNV<GmCJ>2ZuN^
aESa3oq$IBH>mLf2;}?d>ZC=3DVGAp-!9XBB_|

--=20
MST


