Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B520C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 22:11:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2CC1207FD
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 22:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U9AVOKkB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2CC1207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioaaw-0003wu-IN
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 17:11:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57054)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1ioaZQ-0002hP-Ce
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 17:09:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1ioaZP-00025y-4B
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 17:09:56 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42116
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1ioaZO-00024p-Vd
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 17:09:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578348594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UmwZ8Ykqybr4HpXF7fsxJyCZYZqvmljqTFdQrsM5K+g=;
 b=U9AVOKkB3yHToZAOH/f0zE2JjJNL2TRooaqbHI0b3JF9c+om54k7cspYT/ku1pyMxwL1E3
 FBtMKRD+mCm3Htm1ymeXuhbiouoZJ+dZjMEOYHyacXKS6H0SW/hz8fwc1frm+jqFjIko6D
 kf0pORzgKaNRKq8cBENUuicItMW62h0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-f6AqKkt4Pv2Zicmcakx3DA-1; Mon, 06 Jan 2020 17:09:52 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FFD2800D48
 for <qemu-devel@nongnu.org>; Mon,  6 Jan 2020 22:09:51 +0000 (UTC)
Received: from gimli.home (ovpn-116-26.phx2.redhat.com [10.3.116.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 724785DA75;
 Mon,  6 Jan 2020 22:09:48 +0000 (UTC)
Subject: [PULL 1/1] vfio/pci: Don't remove irqchip notifier if not registered
From: Alex Williamson <alex.williamson@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 06 Jan 2020 15:09:48 -0700
Message-ID: <157834857575.18456.9493827635376279964.stgit@gimli.home>
In-Reply-To: <157834844263.18456.7231217269341794728.stgit@gimli.home>
References: <157834844263.18456.7231217269341794728.stgit@gimli.home>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: f6AqKkt4Pv2Zicmcakx3DA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Xu <peterx@redhat.com>

The kvm irqchip notifier is only registered if the device supports
INTx, however it's unconditionally removed.  If the assigned device
does not support INTx, this will cause QEMU to crash when unplugging
the device from the system.  Change it to conditionally remove the
notifier only if the notify hook is setup.

CC: Eduardo Habkost <ehabkost@redhat.com>
CC: David Gibson <david@gibson.dropbear.id.au>
CC: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-stable@nongnu.org # v4.2
Reported-by: yanghliu@redhat.com
Debugged-by: Eduardo Habkost <ehabkost@redhat.com>
Fixes: c5478fea27ac ("vfio/pci: Respond to KVM irqchip change notifier")
Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1782678
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/pci.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 2d40b396f24c..337a173ce7c6 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3076,7 +3076,9 @@ static void vfio_exitfn(PCIDevice *pdev)
     vfio_unregister_req_notifier(vdev);
     vfio_unregister_err_notifier(vdev);
     pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
-    kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
+    if (vdev->irqchip_change_notifier.notify) {
+        kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
+    }
     vfio_disable_interrupts(vdev);
     if (vdev->intx.mmap_timer) {
         timer_free(vdev->intx.mmap_timer);


