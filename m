Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9181C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 08:33:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7438C20679
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 08:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hTY8IS3X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7438C20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQRsK-0004c2-Ip
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 04:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56470 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jQRrB-0002t2-D6
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 04:32:45 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jQRr9-0006um-SM
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 04:32:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49016
 helo=us-smtp-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jQRr9-0006sl-Fw
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 04:32:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587371562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m0+CdJL/XFx9gkbZZ3J1j8jHjkE2+5dpro1F7ap3j7s=;
 b=hTY8IS3X6MHb8rW6lbPd/MwzpZeLXWL60hgniVbF0bHC8oF9wob3+OuKyvtOMQtay4YKP1
 EWvQru6AiU0nrt9G8PppjSVGjRr8EAoZMvmM3w+HhxE8x2GDSPemUt3mwuS4nUlNYIY7xR
 3X8b3DcjBYArUl3T6kU65mdbAU7F3FQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-nI0LVKH_ONq4iQUgT3TR_w-1; Mon, 20 Apr 2020 04:32:41 -0400
X-MC-Unique: nI0LVKH_ONq4iQUgT3TR_w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F06FDDB22;
 Mon, 20 Apr 2020 08:32:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C1346A188B;
 Mon, 20 Apr 2020 08:32:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ACB4F11358C1; Mon, 20 Apr 2020 10:32:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/11] arm/virt: Fix virt_machine_device_plug_cb() error API
 violation
Date: Mon, 20 Apr 2020 10:32:30 +0200
Message-Id: <20200420083236.19309-6-armbru@redhat.com>
In-Reply-To: <20200420083236.19309-1-armbru@redhat.com>
References: <20200420083236.19309-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 04:32:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Error ** argument must be NULL, &error_abort, &error_fatal, or a
pointer to a variable containing NULL.  Passing an argument of the
latter kind twice without clearing it in between is wrong: if the
first call sets an error, it no longer points to NULL for the second
call.

virt_machine_device_plug_cb() passes @errp to
cryptodev_builtin_sym_close_session() in a loop.  Harmless, because
cryptodev_builtin_sym_close_session() can't actually fail.  Fix by
dropping its Error ** parameter.

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/arm/virt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 7dc96abf72..cca5316256 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1186,7 +1186,7 @@ static void create_smmu(const VirtMachineState *vms,
     g_free(node);
 }
=20
-static void create_virtio_iommu_dt_bindings(VirtMachineState *vms, Error *=
*errp)
+static void create_virtio_iommu_dt_bindings(VirtMachineState *vms)
 {
     const char compat[] =3D "virtio,pci-iommu";
     uint16_t bdf =3D vms->virtio_iommu_bdf;
@@ -2118,7 +2118,7 @@ static void virt_machine_device_plug_cb(HotplugHandle=
r *hotplug_dev,
=20
         vms->iommu =3D VIRT_IOMMU_VIRTIO;
         vms->virtio_iommu_bdf =3D pci_get_bdf(pdev);
-        create_virtio_iommu_dt_bindings(vms, errp);
+        create_virtio_iommu_dt_bindings(vms);
     }
 }
=20
--=20
2.21.1


