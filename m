Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2E2C4332E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 08:07:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 941472072C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 08:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ikTpvKwU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 941472072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEqCz-0002gn-Nz
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 04:07:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39644)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jEq7R-0001TR-NC
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 04:01:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jEq7Q-0004tK-Js
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 04:01:33 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:36257)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jEq7Q-0004sb-Gf
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 04:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584604892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vsnWX1gIlwcFz9XB8Dcx8GS4744XFdzTMJ5wUPOnbtw=;
 b=ikTpvKwUwS09/C7t4XvLuCPDqO0vw8xlCFXmON4xqQPHeMr9Qng14tfDEdUaQds7vcXON+
 yuXp6cQsgsJPEY6AKsSsRyBwVFSIQdYCGz4IkJwI0yyu9lNRnJZJNGo0pl6RBjPOS1jmM4
 2EXfOgf4m7TZ7EFqV72z0b7SbP3E1XY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-0IyYCKUKP_2TRYyg05ZVzw-1; Thu, 19 Mar 2020 04:01:29 -0400
X-MC-Unique: 0IyYCKUKP_2TRYyg05ZVzw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7BA3E18B9FC1;
 Thu, 19 Mar 2020 08:01:28 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-49.ams2.redhat.com
 [10.36.112.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2282817B91;
 Thu, 19 Mar 2020 08:01:28 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 378DC3EC0C; Thu, 19 Mar 2020 09:01:18 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/13] microvm/acpi: use GSI 16-23 for virtio
Date: Thu, 19 Mar 2020 09:01:17 +0100
Message-Id: <20200319080117.7725-14-kraxel@redhat.com>
In-Reply-To: <20200319080117.7725-1-kraxel@redhat.com>
References: <20200319080117.7725-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With ACPI enabled and IO-APIC being properly declared in the ACPI tables
we can use interrupt lines 16-23 for virtio and avoid shared interrupts.

With acpi disabled we continue to use lines 8-15.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/i386/microvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 834b10aee0a2..139181daed06 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -122,7 +122,7 @@ static void microvm_devices_init(MicrovmMachineState *m=
ms)
=20
     kvmclock_create();
=20
-    mms->virtio_irq_base =3D 8;
+    mms->virtio_irq_base =3D acpi_enabled ? 16 : 8;
     for (i =3D 0; i < VIRTIO_NUM_TRANSPORTS; i++) {
         sysbus_create_simple("virtio-mmio",
                              VIRTIO_MMIO_BASE + i * 512,
--=20
2.18.2


