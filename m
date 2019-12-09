Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85177C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 09:53:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E1562072D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 09:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U3HV4rr7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E1562072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieFjm-0004PL-G0
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 04:53:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49197)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ieFgj-0008T5-K2
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 04:50:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ieFgi-0000mB-Kg
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 04:50:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56797
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ieFgi-0000ly-HE
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 04:50:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575885044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nQooNv4KuAJbOCpnZQESZEyWieR/hAlT1WGgxUjJTpQ=;
 b=U3HV4rr7iW79bGAKPiRi+Rd8YGmb53rNOOlxOe+UHSKPEVZ738PbEKBO8bIpRz5lfJh0jK
 an7mObpz0dFn/6F2SSK9+ASkaRL37n/Q03TPIi2j1AnvKFP34dt/boOSB0hKd+mWi1p8K3
 isCGQuhhBlUuc4rzv0aJ1TfETmYZ/Lw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-gfa2tifNPLWJqkaOzwt-IQ-1; Mon, 09 Dec 2019 04:50:41 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A7CD800D53;
 Mon,  9 Dec 2019 09:50:40 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-142.brq.redhat.com [10.40.205.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5472519C5B;
 Mon,  9 Dec 2019 09:50:27 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 v3 3/6] hw/pci-host/i440fx: Use size_t to iterate over
 ARRAY_SIZE()
Date: Mon,  9 Dec 2019 10:49:59 +0100
Message-Id: <20191209095002.32194-4-philmd@redhat.com>
In-Reply-To: <20191209095002.32194-1-philmd@redhat.com>
References: <20191209095002.32194-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: gfa2tifNPLWJqkaOzwt-IQ-1
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

We don't enforce the -Wsign-conversion CPPFLAG, but it doesn't hurt
to avoid this warning:

  warning: implicit conversion changes signedness: 'int' to 'size_t' (aka '=
unsigned long') [-Wsign-conversion]

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/pci-host/i440fx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index fbdc563599..0cc80b276d 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -419,12 +419,11 @@ out:
 static void igd_pt_i440fx_realize(PCIDevice *pci_dev, Error **errp)
 {
     uint32_t val =3D 0;
-    int i, num;
+    size_t i;
     int pos, len;
     Error *local_err =3D NULL;
=20
-    num =3D ARRAY_SIZE(igd_host_bridge_infos);
-    for (i =3D 0; i < num; i++) {
+    for (i =3D 0; i < ARRAY_SIZE(igd_host_bridge_infos); i++) {
         pos =3D igd_host_bridge_infos[i].offset;
         len =3D igd_host_bridge_infos[i].len;
         host_pci_config_read(pos, len, &val, &local_err);
--=20
2.21.0


