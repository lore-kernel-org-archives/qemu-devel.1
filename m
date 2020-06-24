Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF490C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 23:11:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A566120738
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 23:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dmGlODnJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A566120738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joEY3-0007Zt-T4
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 19:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1joETw-0000K8-1u
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 19:07:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52423
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1joETu-0001Ul-A4
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 19:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593040021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OrDy+2bSGC3EvnrEAuXyXBzNgsnQeum1itKPO21c+vk=;
 b=dmGlODnJOspocfDmQBtvz/pkYNit2xr4cHfkOXYqT3JCdFcIAa2B7MFgf2dAGCX/Ny1VJN
 hAVN0IzptXpsfOnSPe24laRD+Q00mEx69yLKMDWtCyXKO9Kel+ggVVRvi1wMtvYrmKsSp8
 W8xZ9LmggrMGwOUtVSj7m5kvIFL9sek=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-IEfoCfwOMj6aDKgvnc1kMA-1; Wed, 24 Jun 2020 19:06:59 -0400
X-MC-Unique: IEfoCfwOMj6aDKgvnc1kMA-1
Received: by mail-wm1-f69.google.com with SMTP id a21so4588766wmd.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 16:06:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=OrDy+2bSGC3EvnrEAuXyXBzNgsnQeum1itKPO21c+vk=;
 b=EpdNFbugE6r6ZF5dO5n01ev5PcVbAeX3SCErZ4My0HrpDWV0IN4wRia0P7GKzGaHJ4
 OFyAjEcAAI4iIf3xeUClPVQnNLfub657zA5T9L91Piiy5UHo8eMBnZB48BgMVhjJTpjX
 6mmdmoeGwRmJ9sJLJHcQAqQtsOaGNM6CqVIYwEkCwrAojEt+JxIS8+xBMxut4b//eeTM
 lRwPATI9MGkvHJ77Im2vAscyAW7Yw8psZ54xLcUtG8ZPYPc6ftHFgaUyTkCBWlpEl3LD
 HOuoebaOEFFLQHxBNOeZBogvk5eOcGYep21gj4qfkT6bvOtFz5xAHZciJWoDs6AvcmmL
 yImQ==
X-Gm-Message-State: AOAM533B5lbwSu7B0O0BNccwgE+459Uhjbf4esIjIoQuuwmna3j9D8X4
 z9IvXWRf0ADMmmjpDB5UjqGmbU0+bOrLWBRnFnL5frqvagHjjTfDMLsoPGPzpdSgjxbSmHTm2g4
 pdGx74pTgM1RTCHQ=
X-Received: by 2002:a5d:664a:: with SMTP id f10mr33505922wrw.300.1593040017680; 
 Wed, 24 Jun 2020 16:06:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9PT1kTteKSaNNFWjTQ2x+g8uAJj/OQBtYL+CHh+6oI5Fd+TbLDbwVHIfQ5c4N47O7lkx5iw==
X-Received: by 2002:a5d:664a:: with SMTP id f10mr33505909wrw.300.1593040017464; 
 Wed, 24 Jun 2020 16:06:57 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 u15sm23548697wrm.64.2020.06.24.16.06.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 16:06:56 -0700 (PDT)
Date: Wed, 24 Jun 2020 19:06:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/19] acpi: drop build_piix4_pm()
Message-ID: <20200624230609.703104-11-mst@redhat.com>
References: <20200624230609.703104-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200624230609.703104-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 03:27:53
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedow <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

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
Message-Id: <20200619091905.21676-11-kraxel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/acpi-build.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index ffbdbee51a..59f1b4d890 100644
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
-- 
MST


