Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2492C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 14:53:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7968120714
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 14:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="URpwk+1E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7968120714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEa4G-0001Nu-L7
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 10:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46151)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jEa3Q-0000Jh-3a
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 10:52:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jEa3P-0005Ri-0e
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 10:52:20 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:21286)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jEa3O-0005P6-Sx
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 10:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584543138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N/FzVSHMR5XZjET3ZcevxZb9TJHsbHJRszWRidlyteM=;
 b=URpwk+1EGgiT/eF3V627nHN79bIffsfq+jpihC+BPB4zU7lfqRQY3Tr5TnuwCt03bv0lNJ
 M5y7+SdWjPRT/5ngw44Eqi8Tq9NTbTsZVlgkxpPJM5RF1c2Rax0eVhHC0iQ1c81FdIoN3K
 X+q1MwYiA4e2MQ5VPL9EcTBbS7QUM6s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-IcYOk9j7P0ycMBo5xYAs7A-1; Wed, 18 Mar 2020 10:52:16 -0400
X-MC-Unique: IcYOk9j7P0ycMBo5xYAs7A-1
Received: by mail-wm1-f70.google.com with SMTP id z26so1145654wmk.1
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 07:52:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZgrIZqCisTEH3B29D69xtc42FXCdiaXNL/5zv4PuJqI=;
 b=MwuNMtaAvkuH/JYnsFUhNSuEYUqyOokTDEtkQcilMybm3G9YZI9GBSCnQm2VEw1cwf
 spgPYhkOpVm/B2nxGVXGpStXfJai0yOa5h9dS4RXgl5MaF5bg3fmz/hmBXFqoSF0OZCt
 F8dplggzW7Pfx32Aqe63+IOY/uEB1Q+A2Ede5+7tv7BXtceCy428JHItLe0Ivc5lpljz
 RV7oEMsAp+mx2VSNrvm0jIQC2fdBO5wPuSGKthiOaS/aUOpOREafMBgGENSIK1caPGKJ
 GblsfunsO8h+erE9gq7Dp5jY+Hfs9ys7vtMFlxEX4D1KrfCgIhipMhRVvpI+TXPB8Y1S
 hfww==
X-Gm-Message-State: ANhLgQ3lf70vgPwORGACYkGIVsB0Ka4j2z4GxJdFNQ2Ff6CwyrbIpUFL
 VCTYnwf/mklrky2Xr/XtrGCknclCH7Fbp7Lt5GamjYtB+Xn0/B2LhPeuqYWQnR+LsFVpsaj2dTR
 a1yDhnpZ8kuytHI4=
X-Received: by 2002:a1c:f60d:: with SMTP id w13mr5781079wmc.171.1584543135071; 
 Wed, 18 Mar 2020 07:52:15 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt+sMn4Jd6HnCPd+og48mBg7PRmrfzSJ0A8aDwUGv3z+q4KjCIAbU8od8/k1UqYA1bc/p2M4A==
X-Received: by 2002:a1c:f60d:: with SMTP id w13mr5781059wmc.171.1584543134820; 
 Wed, 18 Mar 2020 07:52:14 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id c23sm8711520wrb.79.2020.03.18.07.52.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2020 07:52:14 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 1/5] vfio/pci: Disable INTx fast path if using split irqchip
Date: Wed, 18 Mar 2020 10:52:00 -0400
Message-Id: <20200318145204.74483-2-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200318145204.74483-1-peterx@redhat.com>
References: <20200318145204.74483-1-peterx@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
 Cornelia Huck <cohuck@redhat.com>, peterx@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's currently broken.  Let's use the slow path to at least make it
functional.

Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Acked-by: Alex Williamson <alex.williamson@redhat.com>
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


