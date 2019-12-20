Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBCCC2D0C0
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 06:07:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CB8E2465E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 06:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iloz8r4S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB8E2465E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiBRn-0001dV-HV
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 01:07:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56362)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iiBQp-0000ks-1d
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 01:06:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iiBQn-00035v-1I
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 01:06:33 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20822
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iiBQm-00030O-CQ
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 01:06:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576821988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z+ZPvh9iN/3dF/yX7R8cNJRFnsOYiCE6G0wjnkePrTY=;
 b=iloz8r4S+6/Vc39HjByhcvXDhSG9HYVSgOjAg0YiHZcOV7BkW7iGc8MNEIbz1Ya7ZMmbpG
 qn4gE0Tlk5tzixDmzpOSSDsEPsK40KzmWSudMuh8bBISSId4a7yTg0nAU2EFWufc5hzRzW
 GDKWNHTVnLwYGvc/uVWmtTfZ5OM+U3Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-ZTuITmQJPLuLu8H-KwgkNQ-1; Fri, 20 Dec 2019 01:06:26 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 569DADBA5;
 Fri, 20 Dec 2019 06:06:25 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-98.ams2.redhat.com
 [10.36.116.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D145B5C548;
 Fri, 20 Dec 2019 06:06:17 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 229079AFB; Fri, 20 Dec 2019 07:06:17 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/2] display/bochs-display: fix memory leak
Date: Fri, 20 Dec 2019 07:06:16 +0100
Message-Id: <20191220060617.32326-3-kraxel@redhat.com>
In-Reply-To: <20191220060617.32326-1-kraxel@redhat.com>
References: <20191220060617.32326-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: ZTuITmQJPLuLu8H-KwgkNQ-1
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cameron Esfahani <dirty@apple.com>

Fix memory leak in bochs_display_update().  Leaks 304 bytes per frame.

Fixes: 33ebad54056
Signed-off-by: Cameron Esfahani <dirty@apple.com>
Message-Id: <d6c26e68db134c7b0c7ce8b61596ca2e65e01e12.1576013209.git.dirty@=
apple.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/bochs-display.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
index dc1bd1641d34..215db9a231d3 100644
--- a/hw/display/bochs-display.c
+++ b/hw/display/bochs-display.c
@@ -252,6 +252,8 @@ static void bochs_display_update(void *opaque)
             dpy_gfx_update(s->con, 0, ys,
                            mode.width, y - ys);
         }
+
+        g_free(snap);
     }
 }
=20
--=20
2.18.1


