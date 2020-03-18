Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C81C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 09:40:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0F3F20674
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 09:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OUmIdVsG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0F3F20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEVBQ-0005rs-1k
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 05:40:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51185)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jEVAl-0005KO-MX
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 05:39:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jEVAk-00012Q-8L
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 05:39:35 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:56693)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jEVAk-0000yF-4X
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 05:39:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584524373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kJwKgTSRC6h6xpwjuG1kqNwpe/QKsH+CqsiHa4ub1bA=;
 b=OUmIdVsGtqx7u7XrAeeHB42dDvnczFO28Qbxg2STM+94vEySltWgJ6kpJZCKS4ppx/cMNH
 AphGN5gguVp+Dt4jtn+HL5aYyATQw12k0If2DJ13S7MivD/Zep0O02jZi9qRqwvmjJ4f99
 cciOh4WiYJ9TKzuiI4VJhngpU+7JlF8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-D8a4qpHaOc2WIsVzTvSF-A-1; Wed, 18 Mar 2020 05:39:31 -0400
X-MC-Unique: D8a4qpHaOc2WIsVzTvSF-A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD864800D5C;
 Wed, 18 Mar 2020 09:39:30 +0000 (UTC)
Received: from localhost (ovpn-113-129.ams2.redhat.com [10.36.113.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B1CA5C241;
 Wed, 18 Mar 2020 09:39:27 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0] compat: disable edid on correct virtio-gpu device
Date: Wed, 18 Mar 2020 10:39:19 +0100
Message-Id: <20200318093919.24942-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit bb15791166c1 ("compat: disable edid on virtio-gpu base
device") tried to disable 'edid' on the virtio-gpu base device.
However, that device is not 'virtio-gpu', but 'virtio-gpu-device'.
Fix it.

Fixes: bb15791166c1 ("compat: disable edid on virtio-gpu base device")
Reported-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
Tested-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---

Sorry about my testing failure on the original patch, and thanks
to Luk=C3=A1=C5=A1 for finding this.

---
 hw/core/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 9e8c06036faf..fa9f50db186e 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -53,7 +53,7 @@ GlobalProperty hw_compat_4_0[] =3D {
     { "secondary-vga",  "edid", "false" },
     { "bochs-display",  "edid", "false" },
     { "virtio-vga",     "edid", "false" },
-    { "virtio-gpu",     "edid", "false" },
+    { "virtio-gpu-device", "edid", "false" },
     { "virtio-device", "use-started", "false" },
     { "virtio-balloon-device", "qemu-4-0-config-size", "true" },
     { "pl031", "migrate-tick-offset", "false" },
--=20
2.21.1


