Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CACC3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 09:19:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AC6E246A1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 09:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XQg3HSK3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AC6E246A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8hEs-0005w4-LZ
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 04:19:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1j8hDp-0004WI-Gk
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 04:18:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1j8hDo-0007lX-DD
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 04:18:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43032
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1j8hDo-0007lD-9u
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 04:18:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583140723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KedUN96GU6rjmrhSa4cneIvIuuqPKLfPhsD2cA+tWUg=;
 b=XQg3HSK3C47R9q1cwopJuFRs/hX3QF7kOB9U0iMftiIxMgurNA4x7bMsqHCBOeh0+XurX1
 aUW5caUzFIErT2Niljvg8Pho6gHZZBAJ0B8aK3C0EPkGBS2bmcppPoimPeaYK540aq1z+k
 HRTn+MfM5lJVp1Hrq/8V1cZuQ5qjGoc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-TM0bdKFkOQe6eruaWwRp2A-1; Mon, 02 Mar 2020 04:18:41 -0500
X-MC-Unique: TM0bdKFkOQe6eruaWwRp2A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F7AA800D53;
 Mon,  2 Mar 2020 09:18:40 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-150.ams2.redhat.com
 [10.36.116.150])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A84675C1D6;
 Mon,  2 Mar 2020 09:18:37 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id DD7B89DB6; Mon,  2 Mar 2020 10:18:36 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/2] Arithmetic error in EDID generation fixed
Date: Mon,  2 Mar 2020 10:18:35 +0100
Message-Id: <20200302091836.29012-2-kraxel@redhat.com>
In-Reply-To: <20200302091836.29012-1-kraxel@redhat.com>
References: <20200302091836.29012-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 "Anton V. Boyarshinov" <boyarsh@altlinux.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Anton V. Boyarshinov" <boyarsh@altlinux.org>

To calculate screen size in centimeters we should calculate:
pixels/dpi*2.54
but not
pixels*dpi/2540

Using wrong formula we actually get 65 DPI and very small fonts.

Signed-off-by: Anton V. Boyarshinov <boyarsh@altlinux.org>
Message-id: 20200226122054.366b9cda@table.localdomain
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/edid-generate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/display/edid-generate.c b/hw/display/edid-generate.c
index 75c945a94813..e58472fde501 100644
--- a/hw/display/edid-generate.c
+++ b/hw/display/edid-generate.c
@@ -360,8 +360,8 @@ void qemu_edid_generate(uint8_t *edid, size_t size,
     edid[20] =3D 0xa5;
=20
     /* screen size: undefined */
-    edid[21] =3D info->prefx * info->dpi / 2540;
-    edid[22] =3D info->prefy * info->dpi / 2540;
+    edid[21] =3D info->prefx * 254 / 100 / info->dpi;
+    edid[22] =3D info->prefy * 254 / 100 / info->dpi;
=20
     /* display gamma: 2.2 */
     edid[23] =3D 220 - 100;
--=20
2.18.2


