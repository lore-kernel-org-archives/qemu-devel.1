Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D4BC4BA2D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 22:53:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26D0F2072D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 22:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WKUKiSq0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26D0F2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51199 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j75YG-0003tv-AR
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 17:53:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38502)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j75W6-0001LO-QG
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 17:50:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j75W4-0002oc-EP
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 17:50:57 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59166
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j75W4-0002mS-5S
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 17:50:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582757454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y3sVHPpC5z7VoY7e/tsZvRp+0nd3/grkPunmOWyrVZc=;
 b=WKUKiSq0b6sno1zpA9TPCfV2Y273LZMiNeHlgnXETrDuR7KgGuLDC4jMyC1CB7GxWAS4XU
 Qw+Ct+tCbC2Gt73mKGUXyph/4gDNueSm3o9LVDT5PERr4x4YF6VMr2RW6hZpfPgDPQWS/C
 wJPStZOWTx1Ops21G5b+wjEJVVLK2Y8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-Dly1K89EPuKsWaSamnmV-g-1; Wed, 26 Feb 2020 17:50:53 -0500
X-MC-Unique: Dly1K89EPuKsWaSamnmV-g-1
Received: by mail-qk1-f199.google.com with SMTP id a10so1268150qkg.11
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 14:50:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=q/wVcbMiAF3eKq8v1pcoDKE6nDvgoEVVFIvpT7KHpuA=;
 b=VBBayYo5Jfrqm7RQUF7Ukyxqdiby9nUqgG9YWFhq9c+oxlS4dAuVmQAsyc49tRSOMg
 K20z9JGa8ph0Hn+nXnQyAUfTZdWhkqRBgrRCB9ESiQhJVL8zpYzTWs0tFnO2nZw0fbQy
 z4sAS4wkxKJdS8Aqs0YgVsJipUwjYxeavxlOR8UK3MePpr3ZH0UnI4adkGn7WHxvfqC1
 drklK8Wf/z+OiPqbdrbgOSM6vuZ8/RS4kg3zJZf4COyV0KPYXZkL+1Lep0t0UIg4SNZu
 4DSxb3rahAeMEEIkPFlXshYB7WDAokxh5NAFPCCR8erPN5titK8SatRo8sCNdBcW191H
 XyJQ==
X-Gm-Message-State: APjAAAXxYXcg1ntJECjl5C3ptGGsxlubOAwbLA5lqUYQCmewmanGgdxn
 cvscccfhG/CK4B/Epyx6w9KhYEP5dQTvls0bh+0LAmOApMyiGlJCO7BFm8eelFeU8ybyY6aPmx1
 57gq7NsZkLBQK4Qk=
X-Received: by 2002:a0c:f412:: with SMTP id h18mr1668493qvl.124.1582757452537; 
 Wed, 26 Feb 2020 14:50:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqyqiQt88tzWWSEvvGiPwIE/00Rrnh9cUeayh/0UanbySLq51p4WPcsRYDcBSSDI3Ln2XphYKw==
X-Received: by 2002:a0c:f412:: with SMTP id h18mr1668470qvl.124.1582757452312; 
 Wed, 26 Feb 2020 14:50:52 -0800 (PST)
Received: from xz-x1.redhat.com
 (CPEf81d0fb19163-CMf81d0fb19160.cpe.net.fido.ca. [72.137.123.47])
 by smtp.gmail.com with ESMTPSA id t23sm1859140qtp.82.2020.02.26.14.50.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 14:50:51 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/5] vfio/pci: Disable INTx fast path if using split irqchip
Date: Wed, 26 Feb 2020 17:50:44 -0500
Message-Id: <20200226225048.216508-2-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200226225048.216508-1-peterx@redhat.com>
References: <20200226225048.216508-1-peterx@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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


