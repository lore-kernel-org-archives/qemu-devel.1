Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E85DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:42:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF58120734
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KSgyCjCy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF58120734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jisZV-0004qa-2V
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 00:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisL7-0000Ov-DQ
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:27:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44157
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisL5-0008JU-Ml
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:27:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591763267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rgenchyFDewl0zzAhVvbXUqfOzcRf49oDVzgaZXFxPI=;
 b=KSgyCjCynbLpYWoCuIO3dFcK23eBO+0pHhNg3SojG/aOGvc/3WAcoHEiDSPHDl2BIvYnyv
 S6CLq1KPGvFQ5QCvqMHlkDYkPL3Qr+h9ixSGCfQRwWi3EGaGr1TWS/eoN0C7JGOuHJqxty
 Uw4RJ3A5RLtyIH5iM72KW1pfulcbEz8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-8WAvIgAqN2qnWJmDqgmzYQ-1; Wed, 10 Jun 2020 00:27:44 -0400
X-MC-Unique: 8WAvIgAqN2qnWJmDqgmzYQ-1
Received: by mail-wr1-f72.google.com with SMTP id w4so506427wrl.13
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 21:27:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=rgenchyFDewl0zzAhVvbXUqfOzcRf49oDVzgaZXFxPI=;
 b=JJfkNrmFTDsM3L2HbduGy7Z/ZddccrPwYoaismQh2BoR0J3i0dK8+FgEEiDmq4KTTW
 EWCMDRIoXS7+ijGNuxxmmEjYjbLE81STuXziJToKuBMAb3N/xxF/dkUVYC9fNfdG0der
 W5zULjCrlwfUWZXNpDZIioZ6EVCjRtcsmhVabZejNxRgK76No+YRbB1OFCwHwhl6ak3o
 ZAcNMM4cD/SMQja1RuORDliBYHCdhIxX5dH87U4w4wGozl0lTY2HwlJQvdApZ6THBbV9
 N2vAjQwTIostQkEiKFu0WI1EuL9XvuKJk5JvK2CtKA7J2bMDZhD55WJRNDE6gUUPlWrT
 yEMw==
X-Gm-Message-State: AOAM531Mnz07HUqEgo0GbsW39nHoxiH7XYsYlLBTCFpVH6EDg1ABf1Bz
 iUq2h1MkEHFUrALDrGNeQfxjMOiseJV3n8re4oxrvGl9NXOu1eryKB/69DHZyInufw1NTn2O2bV
 dw+yFwpWeapIXvTc=
X-Received: by 2002:a1c:44c3:: with SMTP id r186mr1130137wma.67.1591763263551; 
 Tue, 09 Jun 2020 21:27:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytjTTaUnMPnjI3Hxn7S9HFcpZphaw/Q8AIjXBDjzPuZ30s7TgYEFKc75cuxidzakykNyKYow==
X-Received: by 2002:a1c:44c3:: with SMTP id r186mr1130126wma.67.1591763263357; 
 Tue, 09 Jun 2020 21:27:43 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id b18sm5885144wrn.88.2020.06.09.21.27.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 21:27:42 -0700 (PDT)
Date: Wed, 10 Jun 2020 00:27:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 31/56] hw/pci/pci_bridge: Correct pci_bridge_io memory region
 size
Message-ID: <20200610042613.1459309-32-mst@redhat.com>
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
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

memory_region_set_size() handle the 16 Exabytes limit by
special-casing the UINT64_MAX value. This is not a problem
for the 32-bit maximum, 4 GiB.
By using the UINT32_MAX value, the pci_bridge_io MemoryRegion
ends up missing 1 byte:

  (qemu) info mtree
  memory-region: pci_bridge_io
    0000000000000000-00000000fffffffe (prio 0, i/o): pci_bridge_io
      0000000000000060-0000000000000060 (prio 0, i/o): i8042-data
      0000000000000064-0000000000000064 (prio 0, i/o): i8042-cmd
      00000000000001ce-00000000000001d1 (prio 0, i/o): vbe
      0000000000000378-000000000000037f (prio 0, i/o): parallel
      00000000000003b4-00000000000003b5 (prio 0, i/o): vga
      ...

Fix by using the correct value. We now have:

  memory-region: pci_bridge_io
    0000000000000000-00000000ffffffff (prio 0, i/o): pci_bridge_io
      0000000000000060-0000000000000060 (prio 0, i/o): i8042-data
      0000000000000064-0000000000000064 (prio 0, i/o): i8042-cmd
      ...

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200601142930.29408-4-f4bug@amsat.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/pci/pci_bridge.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
index 97967d12eb..3ba3203f72 100644
--- a/hw/pci/pci_bridge.c
+++ b/hw/pci/pci_bridge.c
@@ -30,6 +30,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_bus.h"
 #include "qemu/module.h"
@@ -381,7 +382,7 @@ void pci_bridge_initfn(PCIDevice *dev, const char *typename)
     memory_region_init(&br->address_space_mem, OBJECT(br), "pci_bridge_pci", UINT64_MAX);
     sec_bus->address_space_io = &br->address_space_io;
     memory_region_init(&br->address_space_io, OBJECT(br), "pci_bridge_io",
-                       UINT32_MAX);
+                       4 * GiB);
     br->windows = pci_bridge_region_init(br);
     QLIST_INIT(&sec_bus->child);
     QLIST_INSERT_HEAD(&parent->child, sec_bus, sibling);
-- 
MST


