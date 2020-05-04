Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC77EC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:34:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B641120757
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AEIwx7ED"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B641120757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVcB5-0005KB-OE
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc61-0004dT-4l
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:29:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27640
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc60-0005rC-BC
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:29:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588602563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EadBmenG36bb/hqwInBfhSfoAlf8ggiqJ0AKPIGwVHo=;
 b=AEIwx7EDb1YAr0fsXyG+lCLYyqkES6sF/g/nAH+xmMMfxHvSCyjyBO0DgKjoc0dLhqLR3v
 OXJFBmRY5pLiqMhyrx8OlUEyNDbCyg8nOJR4dO5ICyNQgAUxe+pBoWqbyKNDL4CoF/OSpI
 2L2kxXcPSZayyKlGTjd32Onx4X+07J0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-92GkdTQoMb-kBULHCgrmiA-1; Mon, 04 May 2020 10:29:21 -0400
X-MC-Unique: 92GkdTQoMb-kBULHCgrmiA-1
Received: by mail-wr1-f72.google.com with SMTP id q13so1981110wrn.14
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 07:29:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/am6Xn+onHCJUusiQFfDxyjcP5qPREb7gnWXW/2S1G4=;
 b=oWBE7g4ZSRgiimtKWpcGnnNTrP9954AcqvyLoBYXyQgW6iVrLOKI6TcuoREgWtBblW
 K3ml2UKKEPX4JDSaVC+XUxHF/isvc6TJfiF+HS/gZ9EcSz1FTkA9pWWiVGnDR09+mOjS
 YS1B7o0ul9QINFO8qkSED3V7wStIlNtIxyEayQhuvDVKs4z4e25R4clStIhIuQakc/Wk
 8JW7FNnKns0isNJt53xTDAXUIgR0KpRx5FfcDZI13vFq6sssqFq1TohKMM/ObhPY4LSi
 rY9i6mTxur96JfN0+tH6CjGIr4pZj8IpuLYYmFP0AMEsf6sOsQNaHl/VPtepKiqWbwZp
 ZI4g==
X-Gm-Message-State: AGi0PuY9Zr1/Dv1VXf7/klY/O+Q3du5zkAEALwsDGeyf2JY6fYAXTcNo
 bjdNrjkms3QgNVWfMT2f0gXIKTMc9xoIIZsMVpr8pUJ8k+/2FlpUU5uZSAO5UKLmYsqmEwCA+G9
 AJ+MOY1w3gdRviKg=
X-Received: by 2002:a5d:4991:: with SMTP id r17mr11919287wrq.150.1588602560199; 
 Mon, 04 May 2020 07:29:20 -0700 (PDT)
X-Google-Smtp-Source: APiQypIxvIUENcOZRUmgu2yxY0Nt9R2lRufAL7KTTO6KdMPRw9MPi9uTlVyOh88R5Y7SGNITQstlSg==
X-Received: by 2002:a5d:4991:: with SMTP id r17mr11919263wrq.150.1588602559976; 
 Mon, 04 May 2020 07:29:19 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 l5sm13169870wmi.22.2020.05.04.07.29.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 07:29:19 -0700 (PDT)
Date: Mon, 4 May 2020 10:29:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/29] hw/pci/pcie: Replace PCI_DEVICE() casts with existing
 variable
Message-ID: <20200504142814.157589-3-mst@redhat.com>
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
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 05:09:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Julia Suvorova <jusual@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Julia Suvorova <jusual@redhat.com>

A little cleanup is possible because of hotplug_pdev introduction.

Signed-off-by: Julia Suvorova <jusual@redhat.com>
Message-Id: <20200427182440.92433-3-jusual@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/pci/pcie.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 6b48d04d2c..abc99b6eff 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -449,7 +449,7 @@ void pcie_cap_slot_plug_cb(HotplugHandler *hotplug_dev,=
 DeviceState *dev,
             pci_word_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA,
                                        PCI_EXP_LNKSTA_DLLLA);
         }
-        pcie_cap_slot_event(PCI_DEVICE(hotplug_dev),
+        pcie_cap_slot_event(hotplug_pdev,
                             PCI_EXP_HP_EV_PDC | PCI_EXP_HP_EV_ABP);
     }
 }
@@ -490,7 +490,7 @@ void pcie_cap_slot_unplug_request_cb(HotplugHandler *ho=
tplug_dev,
         return;
     }
=20
-    pcie_cap_slot_plug_common(PCI_DEVICE(hotplug_dev), dev, &local_err);
+    pcie_cap_slot_plug_common(hotplug_pdev, dev, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -509,7 +509,7 @@ void pcie_cap_slot_unplug_request_cb(HotplugHandler *ho=
tplug_dev,
         return;
     }
=20
-    pcie_cap_slot_push_attention_button(PCI_DEVICE(hotplug_dev));
+    pcie_cap_slot_push_attention_button(hotplug_pdev);
 }
=20
 /* pci express slot for pci express root/downstream port
--=20
MST


