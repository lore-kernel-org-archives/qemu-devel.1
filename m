Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02109C4BA24
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 22:58:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEDF920838
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 22:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jOwlRKJQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEDF920838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51307 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j75dh-0003Zh-1T
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 17:58:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39702)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j75aQ-0007lh-Og
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 17:55:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j75aP-0002gc-Rc
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 17:55:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37431
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j75aP-0002gU-O2
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 17:55:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582757725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=67BJoWVgjqRaE3ez8MIcs6ZgskV92ME7JrNNMKV0joI=;
 b=jOwlRKJQ9hBHfuLgsT7kA3f8Te6ygCGhtQkXH/WZeSZe8Qg/bJ6qSRNFPLDQx8F0oaHiPU
 +NrlpiJxD5B4kb50kTFPSLitG5gn6kZnGPBvqMxBW3oeTyNv0yo9vSPGLUpDnZ/FxtXBNd
 InwGc9eyGlJBW+ZCqK4QtECO0ObKUrI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-Mc33v0rKNwK323RnR6zRWQ-1; Wed, 26 Feb 2020 17:55:23 -0500
X-MC-Unique: Mc33v0rKNwK323RnR6zRWQ-1
Received: by mail-qk1-f200.google.com with SMTP id q123so1317999qkb.1
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 14:55:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wQ1AClskklPLaQx5THQ8KFrAAijnqVsY12r4IQjRE6M=;
 b=pVWwXZXVYT/3P5VrnjIbcAv86PK6XFAgO7RrpQ51vyuc2kGAy6QqMYqM5ZTamU0D/0
 0qaUlGCtcvz8gCgOv0Or1HVv3Qm7DnK2PjnnJRyBOwu6syOfuP0hjv4t5UFf7F5lf9GE
 YiuhApdddMGF09+XPdoUsD85LbhBRnQ+LzU0c9Z+IFAa0bjGMayWEABRruXsvvPmQxr3
 17CXi22KqxN31nL6RnU5j9SwfyF3XFXWde8CUkFAW0dpnlRrHX/5L4L60C1myAbe1GlU
 TGVYW6uNu/nj7CvDjErs3Hcw+iTcfqAwDs7CYBLozFBeY3eC9zhGfCplJ+Fi3W/xqgYh
 n1BQ==
X-Gm-Message-State: APjAAAV9IqHuI2c72pfd4k/yHSYHwDLOImLIJeuXLk13xjkcGg6eU5OP
 cal1t/slJtNzGel1llFUyEvsMevAl2LXJMx15V1SL05UDpcFw2gjkuz00f740vxm2MmZyPimli0
 O6s8/mPfI2LegMC8=
X-Received: by 2002:a37:ba05:: with SMTP id k5mr1834147qkf.257.1582757721826; 
 Wed, 26 Feb 2020 14:55:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqxF+juToEgr9MqlCHQQhjmSwzaOaycUbCGOItKyT6fJZXQQMn4EzJPcbVw19kURPqLv3JA+TA==
X-Received: by 2002:a37:ba05:: with SMTP id k5mr1834127qkf.257.1582757721603; 
 Wed, 26 Feb 2020 14:55:21 -0800 (PST)
Received: from xz-x1.redhat.com
 (CPEf81d0fb19163-CMf81d0fb19160.cpe.net.fido.ca. [72.137.123.47])
 by smtp.gmail.com with ESMTPSA id h8sm1900079qtm.51.2020.02.26.14.55.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 14:55:19 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/5] Revert "vfio/pci: Disable INTx fast path if using split
 irqchip"
Date: Wed, 26 Feb 2020 17:55:18 -0500
Message-Id: <20200226225518.217138-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200226225048.216508-1-peterx@redhat.com>
References: 
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With the resamplefd list introduced, we can savely enable VFIO INTx
fast path again with split irqchip so it can still be faster than the
complete slow path.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/vfio/pci.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 09703362df..1c0aa27386 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -124,18 +124,6 @@ static void vfio_intx_enable_kvm(VFIOPCIDevice *vdev, =
Error **errp)
         return;
     }
=20
-    if (kvm_irqchip_is_split()) {
-        /*
-         * VFIO INTx is currently not working with split kernel
-         * irqchip for level triggered interrupts.  Go the slow path
-         * as long as split is enabled so we can be at least
-         * functional (even with poor performance).
-         *
-         * TODO: Remove this after all things fixed up.
-         */
-        return;
-    }
-
     /* Get to a known interrupt state */
     qemu_set_fd_handler(irq_fd, NULL, NULL, vdev);
     vfio_mask_single_irqindex(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
--=20
2.24.1


