Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5A7C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:42:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C992A2075B
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WzwExoTX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C992A2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVcId-00037r-Ua
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:42:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc6l-0006SV-54
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:30:11 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21536
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc6j-0006aA-RK
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:30:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588602609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yUrmwWqL2K6iY/OhY7iuAMwbDTzHlgoQh3a4JQty25Y=;
 b=WzwExoTXDPMGXW2q5HVLqfOqRS3D4d3bCVDxYKWgyFSgpRpG1KSedTOCcugws2rakmsXWZ
 i685NmxytMayBpWmYaXlTxcztKJ0qS9R1W1ReYFKIHkGF3ilhHhlDpKptYnNrtQSECNEEH
 VPYdp+oDpbSSh2M1xHKR0S3FSHuZd74=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-u_z3vKRsNFeB-7tqaOqITA-1; Mon, 04 May 2020 10:30:07 -0400
X-MC-Unique: u_z3vKRsNFeB-7tqaOqITA-1
Received: by mail-wr1-f71.google.com with SMTP id e5so10810659wrs.23
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 07:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=iBQgoo6mUjltyYaN6V5AQ7kWH/joO2eUflEQVfyPDqg=;
 b=ohgc0CiCbUUY+NVrwwoTNCuFtNXzF073thKTXtLY+dSkytURExd/aRhK4BkN7tXKBY
 OuLQOpN6ffL9KIK7XDQotYoC0uNBhsp6R09oLXMU8gHnk7IwwZhxI4q0Ma8fcdVzycKg
 RmnO9Di9gNMhooPKcgDYJudQR7n4Gp8YjS6CX0Hu30GKiJM3aRV/BxwYQDJG1UIrARQz
 TPkhuXSPQLt1fiVl7c7Q57L9dYvLikzeTH3CDe7btWyDKOGa3CHJtiAwPKJCwb3yDbKh
 iwX/8mYYCWprnIhzHnZzEbhv/ttuN2YNZUx6ewUUFb+3D8wLg46JPXRbimp06HPUzYjN
 4mPA==
X-Gm-Message-State: AGi0PuaX6dOqZyUve1p4gXz1xQsm5EppPastFtNv1NPKpoCXCiJWmw+x
 eETnRwFky3Je8w3BnQpt2t70NrWG2V1w9jA6FLSEJ7wEVqVfb/PZrqA98q+w7dnT70Ri+oFxc5O
 h/cCho372paShYs4=
X-Received: by 2002:adf:e704:: with SMTP id c4mr18803916wrm.181.1588602605994; 
 Mon, 04 May 2020 07:30:05 -0700 (PDT)
X-Google-Smtp-Source: APiQypIyMOd6TZ/CIdtjqG2sV4rQizsU/tU9s92ws+OwklTeS4L+IesM7cZngxFsM4LdvNHEOY0JDw==
X-Received: by 2002:adf:e704:: with SMTP id c4mr18803888wrm.181.1588602605743; 
 Mon, 04 May 2020 07:30:05 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 a67sm14733024wmc.30.2020.05.04.07.30.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 07:30:05 -0700 (PDT)
Date: Mon, 4 May 2020 10:30:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 21/29] tests/acpi: add expected tables for bios-tables-test
Message-ID: <20200504142814.157589-22-mst@redhat.com>
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
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 08:14:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Because of the following changes, the expeacted tables for bios-tables-test
needs to be updated.

1. Changed NVDIM DSM output buffer AML code.
2. Updated arm/virt test_acpi_virt_tcg_memhp() to add pc-dimm/nvdimm

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Message-Id: <20200421125934.14952-8-shameerali.kolothum.thodi@huawei.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h |   5 -----
 tests/data/acpi/pc/SSDT.dimmpxm             | Bin 685 -> 734 bytes
 tests/data/acpi/q35/SSDT.dimmpxm            | Bin 685 -> 734 bytes
 tests/data/acpi/virt/DSDT.memhp             | Bin 6644 -> 6668 bytes
 tests/data/acpi/virt/NFIT.memhp             | Bin 0 -> 224 bytes
 tests/data/acpi/virt/SSDT.memhp             | Bin 0 -> 736 bytes
 6 files changed, 5 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios=
-tables-test-allowed-diff.h
index 862c49e675..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,6 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/pc/SSDT.dimmpxm",
-"tests/data/acpi/q35/SSDT.dimmpxm",
-"tests/data/acpi/virt/DSDT.memhp",
-"tests/data/acpi/virt/SSDT.memhp",
-"tests/data/acpi/virt/NFIT.memhp",
diff --git a/tests/data/acpi/pc/SSDT.dimmpxm b/tests/data/acpi/pc/SSDT.dimm=
pxm
index 8ba0e67cb72daa81a65da4906d37a5e0f4af1fd4..ac55387d57e48adb99eb738a102=
308688a262fb8 100644
GIT binary patch
delta 125
zcmZ3>dXJSWIM^lR9uortW7tG4X>Nb5nD}6)_~<4#t%(LAOunKU-FO)N7nn^=3D<l-n`
zNa6@_3Uw1?W@IQ3WMW8PBs(=3DJv7oub-^DQ`iJ=3D1|$G}jW4x-abla{0xR3>sUGbBa}
TgA_0%`UAz6fQZcnjJAvbW$GgJ

delta 76
zcmcb|x|WqIIM^j*EfWI+W57f%X>LFDnD}6)_~<5A^@#=3D|Og=3D&z-FO(~3Mv!1m>CkI
dh5cO|Ll_eMokHD;1(_H?bo!F?%?lZA83Fei6ZHT9

diff --git a/tests/data/acpi/q35/SSDT.dimmpxm b/tests/data/acpi/q35/SSDT.di=
mmpxm
index 2d5b721bcf9c398feb6d005761f898015042e8a4..98e6f0e3f3bb02dd419e36bdd1d=
b9b94c728c406 100644
GIT binary patch
delta 125
zcmZ3>dXJSWIM^lR9uortquWF-X>Nb5nD}6)_~<4#t%(LAOunKU-FO)N7nn^=3D<l-n`
zNa6@_3Uw1?W@IQ3WMW8PBs(=3DJv7oub-^DQ`iJ=3D1|$G}jW4x-abla{0xR3>sUGbBa}
TgA_0%`UAz6fQZcnjJAvbUiu>C

delta 76
zcmcb|x|WqIIM^j*EfWI+qr*flX>LFDnD}6)_~<5A^@#=3D|Og=3D&z-FO(~3Mv!1m>CkI
dh5cO|Ll_eMokHD;1(_H?bo!F?%?lZA83FS;6XgH^

diff --git a/tests/data/acpi/virt/DSDT.memhp b/tests/data/acpi/virt/DSDT.me=
mhp
index c527ac4739af3df3c3e042bf91c412033a2b73c3..730e95a46d2cce0af011ffc051d=
7342beb8f1328 100644
GIT binary patch
delta 66
zcmexj++)J!66_MfBgMeL^l>7WG*kP$jq2<oOpaWW4Mc*Od{`#8h!~455Sv_`z{SGA
W#nKj|7a!~t?-%A0w0WzDJu3iIl@a3r

delta 43
zcmeA%`C`oF66_N4MUsJmsc|BgG*kbajq2<oOr9K*4Mc(&O(wUB7;io=3DV#^8u9B2%1

diff --git a/tests/data/acpi/virt/NFIT.memhp b/tests/data/acpi/virt/NFIT.me=
mhp
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..738c6f74c0ce7dc329cc72cc7b9=
30460ceb9b6a0 100644
GIT binary patch
literal 224
zcmeZs^9*^wz`($G(aGQ0BUr&HBEZ=3DXD8>jB1F=3DCg1XwVzFffCeAhF8JAJRT=3DDREfi
z%xf&Mz2`Pir~{&ofdfQyG(dQa3<eBL5GGJRD~JV_hYBH45Sv&S0)VR88W<T6HiHy}
Pn+P#5Laay9LzoEwN>da8

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/virt/SSDT.memhp b/tests/data/acpi/virt/SSDT.me=
mhp
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..db61d6733284c90153e0e2c1d6c=
2ac25c22b1d84 100644
GIT binary patch
literal 736
zcmZWnJ&4m_7=3DF{1Ynryuv=3Dve6ky!_O6-025G-+(0NlTIzAqUNmw7s^&hj$JlLfadz
zo*?wXEh3U083lL2&DF`tL2x*5cM%-K?@e*=3DT;7-Od*1JPpXcE-P1*XE0AOy_+fvgM
z^q#D08a)F*{Xs{<UJ!5W_RV_VUNo;$++h1nRnCi2N3B+OYEW)p(j~E#Ct5=3Dj2lh<w
zsBOprWHMZeo(xfgK^6-3Jc~$Dw-i;d=3DM@B!O}W(&j7HBCl&&rbifG)Q{Yu;OVvHKC
zhAy;a(VG2EhgX9s5Wd6}qVI*9t2gKT^UuY*!Oz|I&iYQc9Zcy)W;5{P^^1q=3DPetkY
zi~8|h?Stp6FUJq7Z!;2~Kj&8~7KGfZffHVN77XAd7&#DTf-yvVl8FmLrl^eUp)@i^
zZDHkU@N&YXf};stvz!2U<k0hpkDAE<T^*oaF6D-|PhE~B;IUS{s~{)g6EHlxcIvt0
zaEXRISRw|nKg2$K>_tQJ#O0FU+9ezSw@vROEagI9HnmiQA&>UP6JQO~5}~Z64Mnvw
zY+ErcAR}x9XE39S5im?~i@}LFCFj@yO3@`)kSxrd1o2Hog_0x3J#f(n8@M!%1lT2q
z6Jm8#juK%h-|N%mEE@9&_-9pypc>!7*C8JuYZjQl__`2oA({8ccl~|O@$5xK?^Ua8
nUz82zqC>`BY*Tb6M!7_p|2F_GvB7H_Joz7<WbrFft6!x*uUOFm

literal 0
HcmV?d00001

--=20
MST


