Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3FDC352A4
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 09:26:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 060DB20733
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 09:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fnWCiGn5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 060DB20733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j15L5-00025K-6Y
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 04:26:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j15Ib-0007KR-1l
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 04:24:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j15IZ-00048q-Um
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 04:24:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41498
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j15IZ-00048X-QW
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 04:24:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581326651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JFGWeVit+UK++rdbbm90uJbjVOAPmWOyPnQx3Uw0Kyg=;
 b=fnWCiGn56sPz1V6z9sKE66daI4OpxSdM2SUxbrSCFZCy8IabBFAOaqKp3xI0hYhtnIqhdV
 C/NDQBjWuwknYCHgnecscDaOzMf8aKs0Yetl1ldHdNO3y6eapQGsEgT8fDhSsRX2GgfKHu
 CSLqNowUSaxBteoBkz5hpsrjCuVlzoU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-3fE5YQs-PbK4PbrrhuZIuQ-1; Mon, 10 Feb 2020 04:24:09 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD6DC800EBB;
 Mon, 10 Feb 2020 09:24:07 +0000 (UTC)
Received: from localhost (unknown [10.36.118.86])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F2FFF8ED1C;
 Mon, 10 Feb 2020 09:23:59 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/2] hw/core: Allow setting 'virtio-blk-device.scsi' property
 on OSX host
Date: Mon, 10 Feb 2020 09:23:48 +0000
Message-Id: <20200210092348.398611-3-stefanha@redhat.com>
In-Reply-To: <20200210092348.398611-1-stefanha@redhat.com>
References: <20200210092348.398611-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 3fE5YQs-PbK4PbrrhuZIuQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Commit ed65fd1a2750 ("virtio-blk: switch off scsi-passthrough by
default") changed the default value of the 'scsi' property of
virtio-blk, which is only available on Linux hosts. It also added
an unconditional compat entry for 2.4 or earlier machines.

Trying to set this property on a pre-2.5 machine on OSX, we get:

   Unexpected error in object_property_find() at qom/object.c:1201:
   qemu-system-x86_64: -device virtio-blk-pci,id=3Dscsi0,drive=3Ddrive0: ca=
n't apply global virtio-blk-device.scsi=3Dtrue: Property '.scsi' not found

Fix this error by marking the property optional.

Fixes: ed65fd1a27 ("virtio-blk: switch off scsi-passthrough by default")
Suggested-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-id: 20200207001404.1739-1-philmd@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/core/machine.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 3e288bfceb..d8e30e4895 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -148,7 +148,8 @@ GlobalProperty hw_compat_2_5[] =3D {
 const size_t hw_compat_2_5_len =3D G_N_ELEMENTS(hw_compat_2_5);
=20
 GlobalProperty hw_compat_2_4[] =3D {
-    { "virtio-blk-device", "scsi", "true" },
+    /* Optional because the 'scsi' property is Linux-only */
+    { "virtio-blk-device", "scsi", "true", .optional =3D true },
     { "e1000", "extra_mac_registers", "off" },
     { "virtio-pci", "x-disable-pcie", "on" },
     { "virtio-pci", "migrate-extra", "off" },
--=20
2.24.1


