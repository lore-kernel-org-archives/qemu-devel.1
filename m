Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621A4C2D0C9
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 10:54:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 301572073D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 10:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YdWyQRzn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 301572073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifiaI-0008JP-Nq
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 05:54:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60871)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ifiXd-0005cP-UH
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 05:51:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ifiXc-0001fp-KA
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 05:51:25 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41375
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ifiXc-0001f2-FS
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 05:51:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576234284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fuaHjo1osoo+HyN1f6x75XkJZhp6BiU6x58L5nuSaoA=;
 b=YdWyQRzn07Iy/EVfywxys4PiZZfFvcBfrTEq2/b5uoITZKlH8baTiolBZcrn7rUWBzKR2o
 BAYgzWk0XgI3o00pgI4a7iuHY1t+sOikCa4sTJp0+W4jmstxYPDoH+Yex1XM4zdIK8jPW6
 u9CpFnJa2jN7AYq4/p5gSFj+85r/S1U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418--rjuketLMBipZWq6YeNk2w-1; Fri, 13 Dec 2019 05:51:20 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D876ADB62;
 Fri, 13 Dec 2019 10:51:19 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-134.brq.redhat.com [10.40.204.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B12911001B00;
 Fri, 13 Dec 2019 10:51:17 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] hw/i386/pc: Inline port92_init()
Date: Fri, 13 Dec 2019 11:50:59 +0100
Message-Id: <20191213105100.8173-4-philmd@redhat.com>
In-Reply-To: <20191213105100.8173-1-philmd@redhat.com>
References: <20191213105100.8173-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: -rjuketLMBipZWq6YeNk2w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This one-line function is not very helpful, so remove it
by inlining the call to qdev_connect_gpio_out_named().

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/i386/pc.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2c2ae27447..2e8992c7d0 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -770,11 +770,6 @@ static uint64_t port92_read(void *opaque, hwaddr addr,
     return ret;
 }
=20
-static void port92_init(ISADevice *dev, qemu_irq a20_out)
-{
-    qdev_connect_gpio_out_named(DEVICE(dev), PORT92_A20_LINE, 0, a20_out);
-}
-
 static const VMStateDescription vmstate_port92_isa =3D {
     .name =3D "port92",
     .version_id =3D 1,
@@ -830,8 +825,8 @@ static void port92_class_initfn(ObjectClass *klass, voi=
d *data)
     dc->vmsd =3D &vmstate_port92_isa;
     /*
      * Reason: unlike ordinary ISA devices, this one needs additional
-     * wiring: its A20 output line needs to be wired up by
-     * port92_init().
+     * wiring: its A20 output line needs to be wired up with
+     * qdev_connect_gpio_out_named().
      */
     dc->user_creatable =3D false;
 }
@@ -1357,7 +1352,8 @@ static void pc_superio_init(ISABus *isa_bus, bool cre=
ate_fdctrl, bool no_vmport)
=20
     a20_line =3D qemu_allocate_irqs(handle_a20_line_change, first_cpu, 2);
     i8042_setup_a20_line(i8042, a20_line[0]);
-    port92_init(port92, a20_line[1]);
+    qdev_connect_gpio_out_named(DEVICE(port92),
+                                PORT92_A20_LINE, 0, a20_line[1]);
     g_free(a20_line);
 }
=20
--=20
2.21.0


