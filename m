Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B883C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:15:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 667FE2081A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ipgtZ51+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 667FE2081A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjlPO-0001NO-Mj
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 11:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl45-0002nK-Oe
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:53:53 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46009
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl44-0001o2-2q
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591973631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rgenchyFDewl0zzAhVvbXUqfOzcRf49oDVzgaZXFxPI=;
 b=ipgtZ51+bnUadDD/X334jzfsM60+nuooHUxDeRXBD81D1RtLMJ5XGzkmI6shdvOhwkDXIj
 DwOuE8rcx0DXqHyGBEZLPz0X1dZGgNz1gbmifmbiSOIIOG7KUvvdFQTGN7OgyLK1mpjOJp
 yQLsCQwgfngghqocflZnhD6ms8kapnI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-hL0ah5JDOj2VicgLi6Km3A-1; Fri, 12 Jun 2020 10:52:41 -0400
X-MC-Unique: hL0ah5JDOj2VicgLi6Km3A-1
Received: by mail-wm1-f71.google.com with SMTP id a7so2034924wmf.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 07:52:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=rgenchyFDewl0zzAhVvbXUqfOzcRf49oDVzgaZXFxPI=;
 b=jiwoqAaysh3hA8rQACgb20YoDhKKH25hWl1V4QL/KN9X2lXQGiKNicRuE6pP71hmx7
 a1W0B9u/ip7vE9wlkoUpfw1GGmknL0lvXaxu6EOHPfKzoxMqJJ9vdMGhWCAJQLVV0HC/
 M8uwUTl6W0hfVrbfUvKltK+cIyuHd81kdyWWdG9AHb9FIxv7xmm4AeymxLNW3uWt1hKB
 UFneIejuQS30/2+SgCCrqcrIlig+zCumdORzrV06Qd8UBFZcTm2jy5XPaIOVLY3MToQB
 GT1YCkMSA4wQ/uFYLbWVpOY4lCxguk1IoqNayaBlvyYi7fevLyidNKnnmdfT//hwUTVx
 I9rw==
X-Gm-Message-State: AOAM533FWGLA2cp0bFnkip2l3vcxzLSg9uiowV73LKuxi381CK9nXoN3
 l5BDjsnkBMRzXGeEQgyc2NDSSCgjnIBu5beVdGSvQIQ/Dqk60OkMQ7N46XdPJcww4tQFgjcTbju
 d1MNRn0IzbdgxNFQ=
X-Received: by 2002:a7b:c399:: with SMTP id s25mr14520430wmj.185.1591973533507; 
 Fri, 12 Jun 2020 07:52:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxcVSlQF2xcZ5MQrhUpr4XqDBYZpRWVrW8m3JuX22Cr7tZMbg4dgIV9kEa1JiwxmGB9pf19bQ==
X-Received: by 2002:a7b:c399:: with SMTP id s25mr14520412wmj.185.1591973533322; 
 Fri, 12 Jun 2020 07:52:13 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
 by smtp.gmail.com with ESMTPSA id p1sm10100562wrx.44.2020.06.12.07.52.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 07:52:12 -0700 (PDT)
Date: Fri, 12 Jun 2020 10:52:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 31/58] hw/pci/pci_bridge: Correct pci_bridge_io memory
 region size
Message-ID: <20200612141917.9446-32-mst@redhat.com>
References: <20200612141917.9446-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200612141917.9446-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 08:07:17
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


