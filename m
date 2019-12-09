Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2E0C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 09:51:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05A672072D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 09:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I4s9Kfy6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A672072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieFht-0001OX-Tg
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 04:51:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49223)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ieFgn-00005z-GM
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 04:50:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ieFgm-0000nB-GT
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 04:50:49 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33166
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ieFgm-0000n4-DI
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 04:50:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575885048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2iD6T3th+ueTgWBqM5ey4lwC4HSji2/frVsA2WgJMg0=;
 b=I4s9Kfy6GrSZBIcNR4Q8VwQZEEu34DLpthVAIRd+AY1kDahU8PHTo2m/I5py/Ew6GwIRON
 oYw+72zq6C9OJzPy9iseMrJ9rF/3mg4Z9vHgkS76VB46cJo1Sr2Mm5sSLbnwMkYAxvjUmt
 M+RHyGZ004uc528auRXPWA59xIAm1iw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-Z6Cj3bucPzC0clLYFX03TA-1; Mon, 09 Dec 2019 04:50:46 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 515A01005512;
 Mon,  9 Dec 2019 09:50:45 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-142.brq.redhat.com [10.40.205.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EBBF719C5B;
 Mon,  9 Dec 2019 09:50:40 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 v3 4/6] hw/pci-host/i440fx: Use definitions instead of
 magic values
Date: Mon,  9 Dec 2019 10:50:00 +0100
Message-Id: <20191209095002.32194-5-philmd@redhat.com>
In-Reply-To: <20191209095002.32194-1-philmd@redhat.com>
References: <20191209095002.32194-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Z6Cj3bucPzC0clLYFX03TA-1
X-Mimecast-Spam-Score: 0
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
Cc: Thomas Huth <thuth@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paul Durrant <paul@xen.org>,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use definitions from "hw/pci/pci_regs.h".
This also helps when using git-grep.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/pci-host/i440fx.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index 0cc80b276d..414138595b 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -376,13 +376,13 @@ typedef struct {
=20
 /* Here we just expose minimal host bridge offset subset. */
 static const IGDHostInfo igd_host_bridge_infos[] =3D {
-    {0x08, 2},  /* revision id */
-    {0x2c, 2},  /* sybsystem vendor id */
-    {0x2e, 2},  /* sybsystem id */
-    {0x50, 2},  /* SNB: processor graphics control register */
-    {0x52, 2},  /* processor graphics control register */
-    {0xa4, 4},  /* SNB: graphics base of stolen memory */
-    {0xa8, 4},  /* SNB: base of GTT stolen memory */
+    {PCI_REVISION_ID,         2},
+    {PCI_SUBSYSTEM_VENDOR_ID, 2},
+    {PCI_SUBSYSTEM_ID,        2},
+    {0x50,                    2}, /* SNB: processor graphics control regis=
ter */
+    {0x52,                    2}, /* processor graphics control register *=
/
+    {0xa4,                    4}, /* SNB: graphics base of stolen memory *=
/
+    {0xa8,                    4}, /* SNB: base of GTT stolen memory */
 };
=20
 static void host_pci_config_read(int pos, int len, uint32_t *val, Error **=
errp)
--=20
2.21.0


