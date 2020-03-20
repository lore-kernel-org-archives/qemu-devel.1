Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F0FC4332E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 07:27:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D129620774
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 07:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="esEbEshD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D129620774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFC3Z-0000Ks-Ty
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 03:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35938)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jFC2W-0007qw-W0
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 03:25:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jFC2V-0000nf-Dj
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 03:25:56 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:54545)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jFC2V-0000nD-7i
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 03:25:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584689154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JC0+XTKsqUj6TF5WLQ/yKWtWHwtt9quJgaSUuuAkHbU=;
 b=esEbEshDf8SAwfkIPyD4m+KTvnn5cu6aP+1UBjWUMH8aFa5VHpfX6Q8mq4X8vqauBbWg+K
 FZn3jNrl4/H68ol+bQlDmvpKx0lI1qdCJjhvRnAw6FuF04LlCT9ZS2AFiMeuEsx9ioczGK
 oki/J/zNUW9Eshhf4Q7ZGj2bYc+hKZ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-whxFBIg1PKibh8O2G-W82A-1; Fri, 20 Mar 2020 03:25:52 -0400
X-MC-Unique: whxFBIg1PKibh8O2G-W82A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 823D61857BE3;
 Fri, 20 Mar 2020 07:25:51 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-49.ams2.redhat.com
 [10.36.112.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 98D59A7EB;
 Fri, 20 Mar 2020 07:25:48 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 7A0B99B0C; Fri, 20 Mar 2020 08:25:47 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/1] compat: disable edid on correct virtio-gpu device
Date: Fri, 20 Mar 2020 08:25:47 +0100
Message-Id: <20200320072547.19003-2-kraxel@redhat.com>
In-Reply-To: <20200320072547.19003-1-kraxel@redhat.com>
References: <20200320072547.19003-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cornelia Huck <cohuck@redhat.com>

Commit bb15791166c1 ("compat: disable edid on virtio-gpu base
device") tried to disable 'edid' on the virtio-gpu base device.
However, that device is not 'virtio-gpu', but 'virtio-gpu-device'.
Fix it.

Fixes: bb15791166c1 ("compat: disable edid on virtio-gpu base device")
Reported-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
Tested-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Message-id: 20200318093919.24942-1-cohuck@redhat.com
Cc: qemu-stable@nongnu.org
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/core/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index b958cd1b991b..de0c42560534 100644
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
2.18.2


