Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7290C5ACD6
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 19:51:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A81C5206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 19:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gnns0oqF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A81C5206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEIFg-0000KA-P2
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 15:51:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34270)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jEIEq-0007kI-HZ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 15:50:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jEIEp-0001qL-JW
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 15:50:56 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:41161)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jEIEp-0001p0-Fh
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 15:50:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584474655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rX4c44rhuMkGop3AxusgS1sFdsudEKDgbJvrNqbBkWs=;
 b=Gnns0oqFZ7hoRzRvgrVuwn2CnZj8UQr3Obx2n8jXc0iC1IlNQ8Vd0etADD79u8jxQh/S1b
 QrvkPwVtMgCuZnEYgeS7HQEPPK3vgp5RjUXfVkTdlU3e81JMT1MGz83fxFpWA0bVbG3h5W
 cmcsisuyQD1zCQd5EvnM+QZt46NwtRQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-6R5yaCiDORKM5GGsExcYRg-1; Tue, 17 Mar 2020 15:50:53 -0400
X-MC-Unique: 6R5yaCiDORKM5GGsExcYRg-1
Received: by mail-wr1-f70.google.com with SMTP id t10so4872713wrp.15
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 12:50:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HdePRUJwnDwXnzR9QSorBgIKeVRO36+j82UD9j+Yyjs=;
 b=FUzD2JwJBVmW9BMjhB7QOtsN6wy3+nJBccEpXGqSDX0hrv7+fyn+vkJ/H2l87wrkzo
 cmcEhmRzilYsFF72aDVtgI+QDD9Sc3wkXZaN28mb41EFbWmj5JaZKKAPTonD0yzfllS3
 BYuqS+unXwu/VOIfHuBDq1jD7evNE7t09pqN4Ter6jNf2Ua2uWnrGE99aLHRGf8Ga2Gx
 aa+d8rYWUUjwnbiCnhXPcg0t2JuhSX6yv5UPfmLjvMSZH1JV2KORx5W8Nf5gd6bvL47F
 iuNTuAXJNlLNPGbEbJeW3GCe1ZhRV1CMA4tGQVFK2RtBJIhYWgMKXajoX4lwHjrZRyba
 eHHw==
X-Gm-Message-State: ANhLgQ2PxeLMg+awg5YfZRE/NBvjzEqSBNl3xTJ30fj4q0qmDEoVPSaj
 jdE/ZkowKbXlN+dRkHRkJPIkNeRW210j3g9ZeawmxDEEccKr1JXswOkavlUAIsOiVHW9JuJ7IFZ
 E7/RX6Rip0pLvvY0=
X-Received: by 2002:adf:ec82:: with SMTP id z2mr724397wrn.302.1584474652093;
 Tue, 17 Mar 2020 12:50:52 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvJGi70HBi0Xf5GQp5SQ6NguwAnJKgP9G9b/auYTiWn1NytsHjMbFFk8bzOLn5JuP+g615MNQ==
X-Received: by 2002:adf:ec82:: with SMTP id z2mr724370wrn.302.1584474651780;
 Tue, 17 Mar 2020 12:50:51 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id z22sm596119wmi.1.2020.03.17.12.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 12:50:51 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/5] vfio/pci: Disable INTx fast path if using split irqchip
Date: Tue, 17 Mar 2020 15:50:38 -0400
Message-Id: <20200317195042.282977-2-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317195042.282977-1-peterx@redhat.com>
References: <20200317195042.282977-1-peterx@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, peterx@redhat.com,
 Eric Auger <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's currently broken.  Let's use the slow path to at least make it
functional.

Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/vfio/pci.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 5e75a95129..98e0e0c994 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -128,6 +128,18 @@ static void vfio_intx_enable_kvm(VFIOPCIDevice *vdev, =
Error **errp)
         return;
     }
=20
+    if (kvm_irqchip_is_split()) {
+        /*
+         * VFIO INTx is currently not working with split kernel
+         * irqchip for level triggered interrupts.  Go the slow path
+         * as long as split is enabled so we can be at least
+         * functional (even with poor performance).
+         *
+         * TODO: Remove this after all things fixed up.
+         */
+        return;
+    }
+
     /* Get to a known interrupt state */
     qemu_set_fd_handler(irqfd.fd, NULL, NULL, vdev);
     vfio_mask_single_irqindex(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
--=20
2.24.1


