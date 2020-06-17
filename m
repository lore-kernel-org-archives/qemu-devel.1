Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA73EC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:18:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5D012073E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RNubsquc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5D012073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlSLO-0008WP-0o
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 03:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jlSFD-0007ce-9f
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 03:12:23 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23183
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jlSFA-0000aK-1W
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 03:12:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592377939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=9Yghzj5BDEoyZVmuyyKns/SnsdxS39VB1n2rxPWWNy8=;
 b=RNubsqucHg6AUW68eZ0va78VRB5KAtNyjCretJJNLCM3D9ELningwz0SjhhhwhT0MmzKPc
 JhN/fne9Fh3LpqfR5PZhIBJ9L3VPVReFX7Nd3noFxKPL3+3rOgpEBw1vADV5zoDCuv/LcB
 BudYV6iSr0Ek7nNzJJe4aoH0p9R7Fds=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-MN-rKeurNtC3EnQluUyz9g-1; Wed, 17 Jun 2020 03:12:18 -0400
X-MC-Unique: MN-rKeurNtC3EnQluUyz9g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D91C58AB3AB;
 Wed, 17 Jun 2020 07:12:10 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-67.ams2.redhat.com
 [10.36.112.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4BC221002393;
 Wed, 17 Jun 2020 07:11:59 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id E9CF99D99; Wed, 17 Jun 2020 09:11:38 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 09/10] acpi: drop build_piix4_pm()
Date: Wed, 17 Jun 2020 09:11:37 +0200
Message-Id: <20200617071138.11159-10-kraxel@redhat.com>
In-Reply-To: <20200617071138.11159-1-kraxel@redhat.com>
References: <20200617071138.11159-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 01:42:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

The _SB.PCI0.PX13.P13C opregion (holds isa device enable bits)
is not used any more, remove it from DSDT.

piix4 DSDT changes:

     Scope (_SB.PCI0)
     {
-        Device (PX13)
-        {
-            Name (_ADR, 0x00010003)  // _ADR: Address
-            OperationRegion (P13C, PCI_Config, Zero, 0xFF)
-        }
-    }
-
-    Scope (_SB.PCI0)
-    {
         Device (ISA)
         {
             Name (_ADR, 0x00010000)  // _ADR: Address
             OperationRegion (P40C, PCI_Config, 0x60, 0x04)
         }
     }

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Igor Mammedow <imammedo@redhat.com>
---
 hw/i386/acpi-build.c             |  16 ----------------
 tests/data/acpi/pc/DSDT          | Bin 4972 -> 4934 bytes
 tests/data/acpi/pc/DSDT.acpihmat | Bin 6296 -> 6258 bytes
 tests/data/acpi/pc/DSDT.bridge   | Bin 6831 -> 6793 bytes
 tests/data/acpi/pc/DSDT.cphp     | Bin 5435 -> 5397 bytes
 tests/data/acpi/pc/DSDT.dimmpxm  | Bin 6625 -> 6587 bytes
 tests/data/acpi/pc/DSDT.ipmikcs  | Bin 5044 -> 5006 bytes
 tests/data/acpi/pc/DSDT.memhp    | Bin 6331 -> 6293 bytes
 tests/data/acpi/pc/DSDT.numamem  | Bin 4978 -> 4940 bytes
 9 files changed, 16 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index ffbdbee51aa8..59f1b4d89000 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1364,21 +1364,6 @@ static void build_q35_isa_bridge(Aml *table)
     aml_append(table, scope);
 }
 
-static void build_piix4_pm(Aml *table)
-{
-    Aml *dev;
-    Aml *scope;
-
-    scope =  aml_scope("_SB.PCI0");
-    dev = aml_device("PX13");
-    aml_append(dev, aml_name_decl("_ADR", aml_int(0x00010003)));
-
-    aml_append(dev, aml_operation_region("P13C", AML_PCI_CONFIG,
-                                         aml_int(0x00), 0xff));
-    aml_append(scope, dev);
-    aml_append(table, scope);
-}
-
 static void build_piix4_isa_bridge(Aml *table)
 {
     Aml *dev;
@@ -1530,7 +1515,6 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         aml_append(dsdt, sb_scope);
 
         build_hpet_aml(dsdt);
-        build_piix4_pm(dsdt);
         build_piix4_isa_bridge(dsdt);
         build_isa_devices_aml(dsdt);
         build_piix4_pci_hotplug(dsdt);
diff --git a/tests/data/acpi/pc/DSDT b/tests/data/acpi/pc/DSDT
index d9074ac8df7ff21f214a5f4a135e3d1ac2c86227..6d0aaf729ac7d64cf966621adf276534de5cc555 100644
GIT binary patch
delta 24
fcmaE(c1(@SCD<jzO_+g!asNgxF~-eqjA}vvTlfZ5

delta 62
zcmX@6_C}4%CD<h-N0@<uan(jHF-BEYz4&0K_yA{5gXkv7fCxilj(A6xARcB0MuzBy
R07GMECI+tmo8=kRg#ZJ94@3X}

diff --git a/tests/data/acpi/pc/DSDT.acpihmat b/tests/data/acpi/pc/DSDT.acpihmat
index 8d76c7c01d49087cc5efb9843a2e1d0865145017..2e5e02400b1bd2842989d395c573fc593f45503b 100644
GIT binary patch
delta 24
fcmbPX_{o6FCD<jTNP>ZZv3Dbv7~^I)#vpM3TJi>R

delta 62
zcmexlFvF0`CD<ioh6DoxW5q@;F-BEYz4&0K_yA{5gXkv7fCxilj(A6xARcB0MuzBy
R07GMECI+tmo8=jU#Q^|-4`BcR

diff --git a/tests/data/acpi/pc/DSDT.bridge b/tests/data/acpi/pc/DSDT.bridge
index 6ffae63dd8fcc4f617b9d9d57d79bd46a7253064..623c4c03585c47d4d28adc611823b7cce8f4a5c7 100644
GIT binary patch
delta 24
fcmZ2)+G)z=66_MvDaF9R$gz=2jB&FYW2PhkQA`Ea

delta 62
zcmeA)U2n?e66_MPUW$Q%@$*J5F-BEYz4&0K_yA{5gXkv7fCxilj(A6xARcB0MuzBy
R07GMECI+tmo8=j^BmoNk55)ig

diff --git a/tests/data/acpi/pc/DSDT.cphp b/tests/data/acpi/pc/DSDT.cphp
index b25bbf7dc5bbabea277d3402b90d376beb038043..e0a43ccdadae150c0f39599c85e4e21ed8fff2a4 100644
GIT binary patch
delta 24
fcmdn3HC2ntCD<iIRFr{%(PAT)7~^I)#;?KvO>hPk

delta 62
zcmbQLwOfnJCD<jzT9ko-QF$Ym7^AAHUVN}qe1Nm3L3ER3K!l+&N4%p;5Dzm0BSUmU
RfT6K769d=(&GL-jgaOQn4+H=J

diff --git a/tests/data/acpi/pc/DSDT.dimmpxm b/tests/data/acpi/pc/DSDT.dimmpxm
index 7dffca09865f1c5d4f94e67dfe308bf22a45664a..21eb065a0ee3bd96f1a2e7601aa83fefa833349a 100644
GIT binary patch
delta 24
fcmaE8yxW+|CD<iow<H4tqryfmF~-eqjI$*GULyvu

delta 62
zcmdmO{Lq-oCD<k8p(FzXBlkuwF-BEYz4&0K_yA{5gXkv7fCxilj(A6xARcB0MuzBy
S07GMECI+tmo8=kjNB{r;>kpp*

diff --git a/tests/data/acpi/pc/DSDT.ipmikcs b/tests/data/acpi/pc/DSDT.ipmikcs
index 5a039ac93c42d4b123e21d51c5799ddb42bf12a0..b8f08f266b5735fe6967d4e105ee6b3662dad7e6 100644
GIT binary patch
delta 24
fcmdm@-lxvx66_MvC(OXW7`%~7jB&FYW1bKIQlth8

delta 62
zcmeBE-=fat66_MPMVNts(QYG`7^AAHUVN}qe1Nm3L3ER3K!l+&N4%p;5Dzm0BSUmU
RfT6K769d=(&GL--LIC7(4*CE9

diff --git a/tests/data/acpi/pc/DSDT.memhp b/tests/data/acpi/pc/DSDT.memhp
index a5b60b0e9c7d77fdc770687e28502b7dc6246dcd..9a9418f4bde5fb18883c244ea956122e371ff01a 100644
GIT binary patch
delta 24
fcmdmOIMtBLCD<iosssZA<Hn6#VvL*J7)!+gS_}rG

delta 62
zcmbPgxZ9A+CD<iow*&(N<D89LVvMS)dhx+d@d3`B2GLED0TG7A9Py4WK|IV1j118Y
S0fxrTOblHAH_J1Yi30!tun&>|

diff --git a/tests/data/acpi/pc/DSDT.numamem b/tests/data/acpi/pc/DSDT.numamem
index b82e13cd12017c7197cc236d9cc161e28dcfc8b1..6eec385c2ec00544c6eaa7e19d32b2ccd5a51915 100644
GIT binary patch
delta 24
fcmeyQc1DfMCD<jzN0@<uF>@oA7~^I)MjaslS{4Qu

delta 62
zcmX@3_DPM)CD<jTNSJ|vF=Qi`7^AAHUVN}qe1Nm3L3ER3K!l+&N4%p;5Dzm0BSUmU
RfT6K769d=(&GL-8LIC%74+a1L

-- 
2.18.4


