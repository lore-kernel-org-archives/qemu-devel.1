Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B537BC35247
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 00:15:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D3A620838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 00:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X4XBguDR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D3A620838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izrIV-0000Lg-LH
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 19:15:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55422)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izrHq-00086B-5a
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 19:14:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izrHn-0006OH-Lk
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 19:14:20 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26762
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izrHn-0006KY-9B
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 19:14:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581034458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bjeWp3bPxYejO3XUaX9ZkPvlemdPjrc8NiVw/LTueyY=;
 b=X4XBguDRjRaLQ6D3xZXpY9mUI9E1ky4e3fiqcbJe2D92hKsRN59vrYZhu5wZc6alkY0Fb9
 5GG3W6EsAu0A9y8OoPoLtYXiEGfsLWnqDlpvpe5xHLD6Q26tz8PwdZZd/oYtzKZDP8Wf9l
 +4/uONpJSWqi3+jqgEzssVlHZ4/FQPw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-yn6atqcFMX2A_cQdXvaSUg-1; Thu, 06 Feb 2020 19:14:14 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20E2F1081FA0;
 Fri,  7 Feb 2020 00:14:13 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-120.brq.redhat.com [10.40.204.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 72D4F19C7F;
 Fri,  7 Feb 2020 00:14:06 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2] hw/core: Allow setting 'virtio-blk-device.scsi' property
 on OSX host
Date: Fri,  7 Feb 2020 01:14:04 +0100
Message-Id: <20200207001404.1739-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: yn6atqcFMX2A_cQdXvaSUg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
v2: Reworded description (Cornelia)

Extracted from testing series:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg675074.html
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


