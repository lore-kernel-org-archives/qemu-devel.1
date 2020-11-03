Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA438C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 12:38:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 079842224E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 12:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ea6+KVA/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 079842224E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZvZu-0004fk-PH
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 07:38:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kZvUf-0007Bv-Dm
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 07:32:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22599)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kZvUc-00046F-1K
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 07:32:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604406772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Xmvu/DJeZOXBtmHVNhnqsCCfgmAyHqp5K3zowMGUgVI=;
 b=Ea6+KVA/Hbshjl4Jr7T1TTcYtERk/ilwUkTOg+BZ/lWdqVGsbRQTBOc9bhzvnkGPNICCmK
 FGdMrprCzw3eT4Ifg5x25TKd6td2HQKIMJMtWnGwkqm8uYEtPh25Q/gDdBVTj3JKZGfplr
 nx1OFUj0s8pWFmX4jgm4mAcPqlaZAM4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-CozxhjOoP6qf-nELJUBBMA-1; Tue, 03 Nov 2020 07:32:51 -0500
X-MC-Unique: CozxhjOoP6qf-nELJUBBMA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6CC41074667;
 Tue,  3 Nov 2020 12:32:49 +0000 (UTC)
Received: from gondolin.redhat.com (ovpn-114-68.ams2.redhat.com [10.36.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9CD9C5DA71;
 Tue,  3 Nov 2020 12:32:41 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.2] s390x: fix build for --without-default-devices
Date: Tue,  3 Nov 2020 13:32:37 +0100
Message-Id: <20201103123237.718242-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

s390-pci-vfio.c calls into the vfio code, so we need it to be
built conditionally on vfio (which implies CONFIG_LINUX).

Reported-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Fixes: cd7498d07fbb ("s390x/pci: Add routine to get the vfio dma available count")
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/meson.build             | 2 +-
 include/hw/s390x/s390-pci-vfio.h | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/meson.build b/hw/s390x/meson.build
index f4663a835514..2a7818d94b94 100644
--- a/hw/s390x/meson.build
+++ b/hw/s390x/meson.build
@@ -27,7 +27,7 @@ s390x_ss.add(when: 'CONFIG_KVM', if_true: files(
 ))
 s390x_ss.add(when: 'CONFIG_S390_CCW_VIRTIO', if_true: files('s390-virtio-ccw.c'))
 s390x_ss.add(when: 'CONFIG_TERMINAL3270', if_true: files('3270-ccw.c'))
-s390x_ss.add(when: 'CONFIG_LINUX', if_true: files('s390-pci-vfio.c'))
+s390x_ss.add(when: 'CONFIG_VFIO', if_true: files('s390-pci-vfio.c'))
 
 virtio_ss = ss.source_set()
 virtio_ss.add(files('virtio-ccw.c'))
diff --git a/include/hw/s390x/s390-pci-vfio.h b/include/hw/s390x/s390-pci-vfio.h
index c7984905b3b7..ff708aef500f 100644
--- a/include/hw/s390x/s390-pci-vfio.h
+++ b/include/hw/s390x/s390-pci-vfio.h
@@ -13,8 +13,9 @@
 #define HW_S390_PCI_VFIO_H
 
 #include "hw/s390x/s390-pci-bus.h"
+#include CONFIG_DEVICES
 
-#ifdef CONFIG_LINUX
+#ifdef CONFIG_VFIO
 bool s390_pci_update_dma_avail(int fd, unsigned int *avail);
 S390PCIDMACount *s390_pci_start_dma_count(S390pciState *s,
                                           S390PCIBusDevice *pbdev);
-- 
2.26.2


