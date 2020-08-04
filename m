Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECFAC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 14:23:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 728A8208A9
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 14:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JBVI5jFr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 728A8208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2xqn-00074Q-Nn
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 10:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k2xmU-0003QM-Sb
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 10:19:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28981)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k2xmS-0005HW-V4
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 10:19:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596550743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iI7KGtS7UrhW3zaOlauuOS3PfCI6dUBTbbFUZTldwKs=;
 b=JBVI5jFruvsAhMIJYk8P4HacfdAanPvlrMxOuP0DiHCY9h9hl/cM3N/gBZo+BjSedEh5e+
 aw1WdjpG5YUtpdr3djpR7y8Cvb7XawFt/RwUS7+X8cTWwfZkYtulQOKhZxYCANyYDxF/oo
 CHIdYNBHrCC1zLUSOmpuPx9qSzOi3UA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-XO3V94EuNNahaQY7U00gcA-1; Tue, 04 Aug 2020 10:17:07 -0400
X-MC-Unique: XO3V94EuNNahaQY7U00gcA-1
Received: by mail-qk1-f200.google.com with SMTP id k142so28603321qke.7
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 07:17:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=iI7KGtS7UrhW3zaOlauuOS3PfCI6dUBTbbFUZTldwKs=;
 b=BVxBKcW1z6RuNceMH+GkvpG0YAokNUj8duKQUiINTRTQw2Gb67pQ9vQQVyOb8jCZll
 p8RShsZBPvfem8gbJYTBS/D0apdVUNE5wUV/lCiSV8sTEoxN/wdW4rblBo3fXisvo2G6
 eo5znhk9udJ2mFRR36CU1FA0krskC/hJL4/0HBrLoB64API4Kq7OBOLGx44Z57LGs7jA
 YkVZrg80+rhTkkVU13nxdjhYpOyOn+1kWpgDPGF3VJWbmmcHiPfi1iUlmT61zE0p8rdM
 UXby28fVn8l+xKxMquFAT7ThByIOmEEmBDYcGcoHBUrp/s//3lTojH5kFrJKOXy4EfgO
 nqAg==
X-Gm-Message-State: AOAM533thUaKSPh/q/jJd1GP3voC3Q5xkQPwj3Gf7RSc+qsApCfofQkm
 JpVj/PAe/cq+MtBiCMhArIl/XeKrtO5B3AKLZapFmxTyH6Zg91JTC5n+NBsUzjA19WuQ9nzYWBW
 FsG6irDh+ub5DeLc=
X-Received: by 2002:ac8:649:: with SMTP id e9mr21384830qth.314.1596550626740; 
 Tue, 04 Aug 2020 07:17:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcFy4uPpKDQxnKvAWu89Pa6cTuVN1eQ7PRKwihAc9kZDkEmg8p2nVc+Wnjv9oME7n5LQLDLA==
X-Received: by 2002:ac8:649:: with SMTP id e9mr21384780qth.314.1596550626271; 
 Tue, 04 Aug 2020 07:17:06 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net.
 [79.177.102.128])
 by smtp.gmail.com with ESMTPSA id 78sm23542644qke.81.2020.08.04.07.17.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2020 07:17:05 -0700 (PDT)
Date: Tue, 4 Aug 2020 10:17:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/3] i386/acpi: fix inconsistent QEMU/OVMF device paths
Message-ID: <20200804141640.591031-2-mst@redhat.com>
References: <20200804141640.591031-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200804141640.591031-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 10:19:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vitaly Cheptsov <vit9696@protonmail.com>, qemu-stable@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

macOS uses ACPI UIDs to build the DevicePath for NVRAM boot options,
while OVMF firmware gets them via an internal channel through QEMU.
Due to a bug in QEMU ACPI currently UEFI firmware and ACPI have
different values, and this makes the underlying operating system
unable to report its boot option.

The particular node in question is the primary PciRoot (PCI0 in ACPI),
which for some reason gets assigned 1 in ACPI UID and 0 in the
DevicePath. This is due to the _UID assigned to it by build_dsdt in
hw/i386/acpi-build.c Which does not correspond to the primary PCI
identifier given by pcibus_num in hw/pci/pci.c

Reference with the device paths, OVMF startup logs, and ACPI table
dumps (SysReport):
https://github.com/acidanthera/bugtracker/issues/1050

In UEFI v2.8, section "10.4.2 Rules with ACPI _HID and _UID" ends with
the paragraph,

    Root PCI bridges will use the plug and play ID of PNP0A03, This will
    be stored in the ACPI Device Path _HID field, or in the Expanded
    ACPI Device Path _CID field to match the ACPI name space. The _UID
    in the ACPI Device Path structure must match the _UID in the ACPI
    name space.

(See especially the last sentence.)

Considering *extra* root bridges / root buses (with bus number > 0),
QEMU's ACPI generator actually does the right thing; since QEMU commit
c96d9286a6d7 ("i386/acpi-build: more traditional _UID and _HID for PXB
root buses", 2015-06-11).

However, the _UID values for root bridge zero (on both i440fx and q35)
have always been "wrong" (from UEFI perspective), going back in QEMU to
commit 74523b850189 ("i386: add ACPI table files from seabios",
2013-10-14).

Even in SeaBIOS, these _UID values have always been 1; see commit
a4d357638c57 ("Port rombios32 code from bochs-bios.", 2008-03-08) for
i440fx, and commit ecbe3fd61511 ("seabios: q35: add dsdt", 2012-12-01)
for q35.

Cc: qemu-stable@nongnu.org
Suggested-by: Laszlo Ersek <lersek@redhat.com>
Tested-by: Vitaly Cheptsov <vit9696@protonmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
---
 hw/i386/acpi-build.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index b7bcbbbb2a..7a5a8b3521 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1497,7 +1497,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         dev = aml_device("PCI0");
         aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A03")));
         aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
-        aml_append(dev, aml_name_decl("_UID", aml_int(1)));
+        aml_append(dev, aml_name_decl("_UID", aml_int(0)));
         aml_append(sb_scope, dev);
         aml_append(dsdt, sb_scope);
 
@@ -1512,7 +1512,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
         aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
         aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
-        aml_append(dev, aml_name_decl("_UID", aml_int(1)));
+        aml_append(dev, aml_name_decl("_UID", aml_int(0)));
         aml_append(dev, build_q35_osc_method());
         aml_append(sb_scope, dev);
         aml_append(dsdt, sb_scope);
-- 
MST


