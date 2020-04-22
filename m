Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E597DC54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:10:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE7B02076C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FTqbFq7J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE7B02076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRF8k-0007xy-Qt
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 09:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46826)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jRF68-0003ku-CI
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:07:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jRF67-0003ny-Fz
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:07:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55854
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jRF67-0003kG-0R
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:07:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587560846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oGgKscofsQygorrpqjNCPgIrftyN69zP62MTnCqjIBo=;
 b=FTqbFq7JU+nh6cDX9YmwFaSW/jAq2jx4F0kQYOjvWMl2D3at2ptVUFOLglM/wY8+d2XYhh
 oqCS7C4btBresV4f1wMzMzvV3Cj6qDJNjH5++pFLQ/Wub8BWo6QYVdjTcs6aJ32lzd5IFp
 8NznVJ5tuUcER6AewToa3IbVEiVONoU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-wnw-nJ2PPd-N1onAB1v74A-1; Wed, 22 Apr 2020 09:07:24 -0400
X-MC-Unique: wnw-nJ2PPd-N1onAB1v74A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E19C1030980;
 Wed, 22 Apr 2020 13:07:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0BAE710027BA;
 Wed, 22 Apr 2020 13:07:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0E09811358C1; Wed, 22 Apr 2020 15:07:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/14] arm/virt: Fix virt_machine_device_plug_cb() error
 API violation
Date: Wed, 22 Apr 2020 15:07:10 +0200
Message-Id: <20200422130719.28225-6-armbru@redhat.com>
In-Reply-To: <20200422130719.28225-1-armbru@redhat.com>
References: <20200422130719.28225-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 09:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
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
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
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


