Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3FFC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:27:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C158F2074B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c1mtD3Qc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C158F2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jisKw-0007pF-NP
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 00:27:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisK3-0006h9-FM
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:26:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59707
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisK1-00085j-6R
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:26:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591763199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vdSt1fYq3b/MNQ0x5ZZmdB8fAeuVH3A8AbIAmGm6Cls=;
 b=c1mtD3Qc4WDj9ZnMy6UUewHrOFfUV8MhyT1crzAoiUZuginaURZMMzfqpqj4SSk4IxtqzK
 CmyE6mbp4cpHr1iUlythil6gRD7JZl67sYyANZEGZt01jdMhPVWCiON8myK1StKs0vnfhj
 xG3dl8a9NNyCC/MAJMil/JIeChoEOIY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-w_S5lCllP7Gix3LoC6dcLQ-1; Wed, 10 Jun 2020 00:26:37 -0400
X-MC-Unique: w_S5lCllP7Gix3LoC6dcLQ-1
Received: by mail-wr1-f72.google.com with SMTP id p10so497993wrn.19
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 21:26:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=vdSt1fYq3b/MNQ0x5ZZmdB8fAeuVH3A8AbIAmGm6Cls=;
 b=tY1G16IMbu4OU0rU3+BmZfDGneUNjtFx908wmkMDnMAmcQZre7aYd3uR87MLUsvauv
 W0cjDZoiOhOue47M2bd/xUs7YxZn18SUMyn03DfiwyAkUkCcIhjZ1T0n/LvuAHJSXw2j
 IQszQfFBWd2tL7RgG2Zye2NmFJDtfcKh0nhD+UtfVsf8XEGEmodUlV/+cO+k3lQ/073L
 3upzo51xp95poQeGBWObV8usMuUosQod/zXkayxwz9HDyjI3hr9trmcRvQGuSFWChcTF
 nAQ/EMTY94CF2+VnKcJVwzdOC3ZaF6stgDVaw0bLd03U6RKIz0DLk9Rc39YgquVOmr9q
 PvNw==
X-Gm-Message-State: AOAM532Yu40M8bKNjepDdNYmaEsCgyAQljPqS5Hp0xTLQbwkIzLhBwmd
 AyRuLjvjbTIjOEo68qBMOt+2VQVkBg5IWjmDsNf1q84rYZ0CK99Ntfwm/2U7Lcwbhwjoc/th7eR
 I8rN0RhGOiMRW8sA=
X-Received: by 2002:a1c:4d0a:: with SMTP id o10mr1182785wmh.150.1591763196103; 
 Tue, 09 Jun 2020 21:26:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyjvbcuKU8ijUVlHkK0n21Y2hQUgw5sUKXUKSkcFRyr26dZMcFGQZ0VXMh37+OP3aiWTaZSdA==
X-Received: by 2002:a1c:4d0a:: with SMTP id o10mr1182766wmh.150.1591763195820; 
 Tue, 09 Jun 2020 21:26:35 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id v27sm6714172wrv.81.2020.06.09.21.26.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 21:26:35 -0700 (PDT)
Date: Wed, 10 Jun 2020 00:26:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/56] msix: allow qword MSI-X table accesses
Message-ID: <20200610042613.1459309-2-mst@redhat.com>
References: <20200610042613.1459309-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200610042613.1459309-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PCI spec says:

For all accesses to MSI-X Table and MSI-X PBA fields, software must use
aligned full DWORD or aligned full QWORD transactions; otherwise, the
result is undefined.

However, since MSI-X was converted to use memory API, QEMU
started blocking qword transactions, only allowing DWORD
ones. Guests do not seem to use QWORD accesses, but let's
be spec compliant.

Fixes: 95524ae8dc8f ("msix: convert to memory API")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/pci/msix.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index 29187898f2..e6a5559038 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -199,6 +199,9 @@ static const MemoryRegionOps msix_table_mmio_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
+        .max_access_size = 8,
+    },
+    .impl = {
         .max_access_size = 4,
     },
 };
@@ -227,6 +230,9 @@ static const MemoryRegionOps msix_pba_mmio_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
+        .max_access_size = 8,
+    },
+    .impl = {
         .max_access_size = 4,
     },
 };
-- 
MST


