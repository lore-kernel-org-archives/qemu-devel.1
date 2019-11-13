Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0EDC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 09:20:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D43B222CD
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 09:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d3YvnyHj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D43B222CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUopY-0001az-OH
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 04:20:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44232)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iUoop-00013D-TF
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 04:20:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iUook-0000H9-Mg
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 04:20:07 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41262
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iUook-0000Fu-HH
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 04:20:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573636801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3pvjWV65p7QLO2nZo4Cy7x7NY19SoRlkUPSuHAuyl2U=;
 b=d3YvnyHjS1eI9+p7zATVAgCxA/L4A7RE6UiVbQn2iFVMFE/iIFhqQdpY9Th2YkFqGit4k6
 p/NAqxuQ1AjZoztbZfGvZ2v0RCwCS0958JnXkreiMpKk/PUq9ER5BCB+g+Mu5KgHT0oujG
 N8QF/sdc8vzafEigQQ/5L+LpuzFIZ3Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-7O3hu0o9MguO7BhMS6SfdA-1; Wed, 13 Nov 2019 04:18:31 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41D801855564;
 Wed, 13 Nov 2019 09:18:30 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-69.ams2.redhat.com
 [10.36.116.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F2BA4D9E1;
 Wed, 13 Nov 2019 09:18:27 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 5086116E08; Wed, 13 Nov 2019 10:18:24 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: seabios@seabios.org
Subject: [PATCH] ahci: zero-initialize port struct
Date: Wed, 13 Nov 2019 10:18:09 +0100
Message-Id: <20191113091809.31365-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 7O3hu0o9MguO7BhMS6SfdA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Specifically port->driver.lchs needs clearing, otherwise seabios will
try interpret whatever random crap happens to be there as disk geometry,
which may or may not break boot depending on how lucky you are.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 src/hw/ahci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/hw/ahci.c b/src/hw/ahci.c
index 97a072a1ca81..d45b4307ec68 100644
--- a/src/hw/ahci.c
+++ b/src/hw/ahci.c
@@ -345,6 +345,7 @@ ahci_port_alloc(struct ahci_ctrl_s *ctrl, u32 pnr)
         warn_noalloc();
         return NULL;
     }
+    memset(port, 0, sizeof(*port));
     port->pnr =3D pnr;
     port->ctrl =3D ctrl;
     port->list =3D memalign_tmp(1024, 1024);
--=20
2.18.1


