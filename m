Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDD6C00454
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D87FD24125
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cUZUvd4J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D87FD24125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifisG-0002OO-IN
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 06:12:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59206)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ifirX-0001wn-BH
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 06:12:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ifirW-0000Yz-Bf
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 06:11:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22790
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ifirW-0000Y5-7v
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 06:11:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576235517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9m3dEZtdHZV4704oi8uUh8EJBV6qZdzh2uIOy9D2PN0=;
 b=cUZUvd4JQJ7yBiToLNGdTXrI9QpAmJTgCm+IXsGx9diLUvT6rjDwP3VVhstYqMqdnVT7HJ
 sb9cJEWpbA3bh+/gwj80ApxFbHxD9pmTyya48xF0sxD0RtNz6qkXBzVwRRS5lSHRbJOPaw
 yRseOFptLsYRq6ZXHu809IDUA7/aCPc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-km6ISO6JOp2eqirXKCoUXw-1; Fri, 13 Dec 2019 06:11:56 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DDB6800D41;
 Fri, 13 Dec 2019 11:11:55 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-134.brq.redhat.com [10.40.204.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 54EC75C3FD;
 Fri, 13 Dec 2019 11:11:47 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/i386/pc: Simplify ioapic_init_gsi()
Date: Fri, 13 Dec 2019 12:11:45 +0100
Message-Id: <20191213111145.11288-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: km6ISO6JOp2eqirXKCoUXw-1
X-Mimecast-Spam-Score: 0
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All callers of ioapic_init_gsi() provide a parent. We want new
uses to follow the same good practice and provide the parent
name, so do not make this optional: assert the parent name is
provided, and simplify the code.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/i386/pc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index ac08e63604..234945d328 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1488,15 +1488,14 @@ void ioapic_init_gsi(GSIState *gsi_state, const cha=
r *parent_name)
     SysBusDevice *d;
     unsigned int i;
=20
+    assert(parent_name);
     if (kvm_ioapic_in_kernel()) {
         dev =3D qdev_create(NULL, TYPE_KVM_IOAPIC);
     } else {
         dev =3D qdev_create(NULL, TYPE_IOAPIC);
     }
-    if (parent_name) {
-        object_property_add_child(object_resolve_path(parent_name, NULL),
-                                  "ioapic", OBJECT(dev), NULL);
-    }
+    object_property_add_child(object_resolve_path(parent_name, NULL),
+                              "ioapic", OBJECT(dev), NULL);
     qdev_init_nofail(dev);
     d =3D SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(d, 0, IO_APIC_DEFAULT_ADDRESS);
--=20
2.21.0


