Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C2DC2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 14:11:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA7E42064B
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 14:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QOJ4jpOq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA7E42064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imIEn-0006hb-TD
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 09:11:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54907)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1imHk3-0000Ny-OE
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:39:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1imHk0-0003gH-Cp
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:39:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42369
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1imHk0-0003b7-7Q
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:39:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577799559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fhwohmloHFNfz10OvQXD9ZYCYz5juJudQarfUI3byMA=;
 b=QOJ4jpOqmT7hiM3s/DIJG8X/Wqjz+U8PCtm4r2FB535di15Kra0DKChzFWrD/H2URBxyba
 pIbhYK/NrhZlc7kVoizDyItPnNBStI9ud2rReeAFO6CMeSITslt9sIw58Yw6m7vCCxmfsS
 VRsjI7qBkILrR25vWOqcezlUFRONZQs=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-d_xs_FVqMTqRNgwBxbYQjg-1; Tue, 31 Dec 2019 08:39:18 -0500
Received: by mail-qt1-f197.google.com with SMTP id b14so24675130qtt.1
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 05:39:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Av/SowyPZxgpgizfimyoTAfL5uv5aRNx7KfXWZx2BLY=;
 b=SeI9G2RCnebPTAeVFvd8nHAzUGtgAHi9iCuTj10+kB/HIu5wPSKEdj+hLBPE5bV/IY
 2z93QoDWWt6br6Sy47PuWXRcU2T2ci9pMLW2AyrU0yAbSykHWB6ghX+jttS+ctr5XTmn
 nu/4FmbgEAZ+al+XphK03GYswj/nLI+UKCNFb6IqX21pzZcMAUD6MVGyvUomzokiGxwG
 MD3yoamdmHbaOEeBeXpuCPu4+Oql/6Vp0nLZt8WhjOX/qKy+U5N9Lc9Qf+LUDXpEcWJD
 7iSjfzeJdQCyCB/Ogt/ZTGCX7Cy8AsFmKMvjzDOEggCsRquCOf9cGUFqOP5A+LGUo/E9
 E8/A==
X-Gm-Message-State: APjAAAVotcV213w3wTbPz/krJs0e3EOsFK9K5nCUO6I2jEErySwB3D5y
 faDd3fAFxk0prUoY6bYwf94z2/WkU1GfgOTta+JgnonxxPYK+gFKBujul6Uv8eEp9h+/c+KnCSC
 YeEoKYlIkNzhFMDM=
X-Received: by 2002:a37:e505:: with SMTP id e5mr53066325qkg.324.1577799557258; 
 Tue, 31 Dec 2019 05:39:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqz41MLFmeSA74k5Y7qvfCRlX0SDgenpWNUHCg2t0tzjYNyoSflguk74DgvDcTw9Pjbg+0q/gg==
X-Received: by 2002:a37:e505:: with SMTP id e5mr53066311qkg.324.1577799557030; 
 Tue, 31 Dec 2019 05:39:17 -0800 (PST)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:3f::2])
 by smtp.gmail.com with ESMTPSA id x42sm15024955qtc.25.2019.12.31.05.39.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Dec 2019 05:39:16 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] vfio/pci: Don't remove irqchip notifier if not registered
Date: Tue, 31 Dec 2019 08:39:15 -0500
Message-Id: <20191231133915.115363-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-MC-Unique: d_xs_FVqMTqRNgwBxbYQjg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: yanghliu@redhat.com, Alex Williamson <alex.williamson@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, peterx@redhat.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The kvm irqchip notifier is only registered if the device supports
INTx, however it's unconditionally removed.  If the assigned device
does not support INTx, this will cause QEMU to crash when unplugging
the device from the system.  Change it to conditionally remove the
notifier only if the notify hook is setup.

CC: Eduardo Habkost <ehabkost@redhat.com>
CC: David Gibson <david@gibson.dropbear.id.au>
CC: Alex Williamson <alex.williamson@redhat.com>
Reported-by: yanghliu@redhat.com
Fixes: c5478fea27 ("vfio/pci: Respond to KVM irqchip change notifier", 2019=
-11-26)
Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=3D1782678
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/vfio/pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 2d40b396f2..337a173ce7 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3076,7 +3076,9 @@ static void vfio_exitfn(PCIDevice *pdev)
     vfio_unregister_req_notifier(vdev);
     vfio_unregister_err_notifier(vdev);
     pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
-    kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
+    if (vdev->irqchip_change_notifier.notify) {
+        kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier)=
;
+    }
     vfio_disable_interrupts(vdev);
     if (vdev->intx.mmap_timer) {
         timer_free(vdev->intx.mmap_timer);
--=20
2.24.1


