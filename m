Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556F3C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 19:53:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DF3F206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 19:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xe6lV2V5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DF3F206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEIHF-0002fF-8j
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 15:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34589)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jEIFD-0008H3-Ns
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 15:51:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jEIFC-0003BF-Oa
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 15:51:19 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:43488)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jEIFC-0003A0-L7
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 15:51:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584474678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XzobTypzUqN3M+rDLvFSV4NqJmV33xE7RPCGY0NoN9k=;
 b=Xe6lV2V55U8R3hE0OFMdOuMuxsSJI5928kBu0PIp5+4MZlu4DmFLVLto5qrQb2DEe/CWwF
 DfOSd3RAZoLlCe+MOTEcX06hMQhFfTAmbY8yeJoyEE8hPZnu/y8dm6rqkVx5sPeBzGC9nl
 uUD3l/cCyOcCC5muecjt7GHTU9R23/g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-tT3BjMQFPHaTxNS_IEq6pA-1; Tue, 17 Mar 2020 15:51:16 -0400
X-MC-Unique: tT3BjMQFPHaTxNS_IEq6pA-1
Received: by mail-wm1-f72.google.com with SMTP id r23so176806wmn.3
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 12:51:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Y/QoJwARiHNYw+6RfuxR8p/GSGTeGS8OuqmLslSWCWw=;
 b=Lb5BxuZ2T6OFuKRl+UEdeHlvtgxVdsJhxwu8jyzhhXrTJyZ+vk1xlP9qXEOWgLYLF4
 u0PT1+Juo+atGIez8krkgTgiM94mhGgeTNPIHTg570QuS47xv1spNo/SMcRZUKIjcWfM
 eZFhgfkvAtVzMrGnRsZ9th1KxZ29iW1scgNdBCcWU6vc09HnKr7nHSHK6UeZ1fXb01It
 BNzwTt5OiqYUU2Bfwf8ta/BN2nwBicq1OQiy2zrvxs2J5yklY+pRIqFf5Ph8x2ylhkBa
 260sJikCX3FvHnZSLQ6JBNUp2IjuIgMZfgVaWx70PH03t4sXVRu9r/9Vlr45IgATGbxS
 QUFA==
X-Gm-Message-State: ANhLgQ1b/wZftMmQrOMD/mI7107YZ++R0eiXIuXPsSp7uvmT55cNstpg
 QrlFAxnM0N2h6FjtX3qzuaDaKW2GJeY5jt70LDunV8zaQ0QhibcuELZtYENyJV6rhSzwdRfIY0A
 K4zA8RsC3Bksu2wE=
X-Received: by 2002:a1c:7f10:: with SMTP id a16mr651837wmd.1.1584474673492;
 Tue, 17 Mar 2020 12:51:13 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvTf4uG1wz8HGsLnJQ71nGbbF/9DlkV/cKRTkaVnjLkMoZ9c32nus2s8MbG6wbGVucCKRXcKw==
X-Received: by 2002:a1c:7f10:: with SMTP id a16mr651822wmd.1.1584474673280;
 Tue, 17 Mar 2020 12:51:13 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id c23sm4681495wrb.79.2020.03.17.12.51.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 12:51:12 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 5/5] Revert "vfio/pci: Disable INTx fast path if using
 split irqchip"
Date: Tue, 17 Mar 2020 15:50:42 -0400
Message-Id: <20200317195042.282977-6-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317195042.282977-1-peterx@redhat.com>
References: <20200317195042.282977-1-peterx@redhat.com>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, peterx@redhat.com,
 Eric Auger <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With the resamplefd list introduced, we can savely enable VFIO INTx
fast path again with split irqchip so it can still be faster than the
complete slow path.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
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


