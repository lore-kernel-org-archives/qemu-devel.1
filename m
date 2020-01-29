Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD064C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 21:26:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7958620702
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 21:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UtQAKr2e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7958620702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwurS-0000uf-LR
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 16:26:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59301)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwuoc-0004KA-NH
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:24:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwuoa-0008IM-Qs
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:24:01 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23908
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwuoa-0008GL-NV
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:24:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580333040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZxYM/8vZCZoRvS4ov0VLdYO5xn/fDjBpklYZAqLhJLs=;
 b=UtQAKr2eMxfismdi+VfGEdc5SBkHeIg5A+ggiOPtftJkEdLt7BDc83A3Wnx6Xv4iOy3lFT
 P4OoMw7PXAuWAYiqOhXh3D9m5r5UAET9BI9NoDfQtREqdrb8D2WAHgMcCrTYkQCt5GKCiD
 CCBzDmxeMrqKe7hEUW689ipDQsr8eLY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-e2-A0yiFNbqDckbco-icaQ-1; Wed, 29 Jan 2020 16:23:58 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DE36800D48;
 Wed, 29 Jan 2020 21:23:57 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-184.brq.redhat.com [10.40.205.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E1A860BF3;
 Wed, 29 Jan 2020 21:23:54 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 01/29] hw/core: Allow setting 'virtio-blk-device.scsi'
 property on OSX host
Date: Wed, 29 Jan 2020 22:23:17 +0100
Message-Id: <20200129212345.20547-2-philmd@redhat.com>
In-Reply-To: <20200129212345.20547-1-philmd@redhat.com>
References: <20200129212345.20547-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: e2-A0yiFNbqDckbco-icaQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit ed65fd1a27 restricted the 'scsi' property to Linux hosts:

  1261 static Property virtio_blk_properties[] =3D {
  1262     DEFINE_BLOCK_PROPERTIES(VirtIOBlock, conf.conf),
  ...
  1268 #ifdef __linux__
  1269     DEFINE_PROP_BIT64("scsi", VirtIOBlock, host_features,
  1270                       VIRTIO_BLK_F_SCSI, false),
  1271 #endif

When we try to set this property on a pre-2.4 machine on OSX,
we get:

   Unexpected error in object_property_find() at qom/object.c:1201:
   qemu-system-x86_64: -device virtio-blk-pci,id=3Dscsi0,drive=3Ddrive0: ca=
n't apply global virtio-blk-device.scsi=3Dtrue: Property '.scsi' not found

Fix this error by marking the property optional.

Fixes: ed65fd1a27
Suggested-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
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
2.21.1


