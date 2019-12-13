Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46561C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 10:54:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 126012073D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 10:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SmhfqhXw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 126012073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifia9-0008EF-6P
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 05:54:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60022)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ifiXY-0005Xu-V3
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 05:51:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ifiXY-0001XP-10
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 05:51:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36755
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ifiXX-0001WZ-T1
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 05:51:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576234279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qldGLiiIvORkmocMy3ZfZ/9V4HJH7IaEKp8UIxpLO4E=;
 b=SmhfqhXw2AoFCz6bXwZEs1oK6ztDoA0cN1lhoLgmXHTw555F7tzPxkqLZuktiTgenCBTCF
 b26UIWyErSfAwDHePfotA6KFh3i6U0f2EwoxH7/aQgLNzXljyztT+Z4NMwMiyepnbszG0o
 LuRaArRoRwdK+8cr1lGv02rEdDHak5M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-0UTCnE0HMZKOPAo3aeUShw-1; Fri, 13 Dec 2019 05:51:18 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45039107ACC5;
 Fri, 13 Dec 2019 10:51:17 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-134.brq.redhat.com [10.40.204.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CD27C1001901;
 Fri, 13 Dec 2019 10:51:14 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] hw/i386/pc: Use TYPE_PORT92 instead of hardcoded string
Date: Fri, 13 Dec 2019 11:50:58 +0100
Message-Id: <20191213105100.8173-3-philmd@redhat.com>
In-Reply-To: <20191213105100.8173-1-philmd@redhat.com>
References: <20191213105100.8173-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 0UTCnE0HMZKOPAo3aeUShw-1
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
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

By using the TYPE_* definitions for devices, we can:
- quickly find where devices are used with 'git-grep'
- easily rename a device (one-line change).

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/i386/pc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 66a30cfdf5..2c2ae27447 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1353,7 +1353,7 @@ static void pc_superio_init(ISABus *isa_bus, bool cre=
ate_fdctrl, bool no_vmport)
         qdev_prop_set_ptr(dev, "ps2_mouse", i8042);
         qdev_init_nofail(dev);
     }
-    port92 =3D isa_create_simple(isa_bus, "port92");
+    port92 =3D isa_create_simple(isa_bus, TYPE_PORT92);
=20
     a20_line =3D qemu_allocate_irqs(handle_a20_line_change, first_cpu, 2);
     i8042_setup_a20_line(i8042, a20_line[0]);
--=20
2.21.0


