Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B215C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 09:56:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 067D520722
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 09:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hXCbAVLw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 067D520722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEruo-0004zI-3A
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 05:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48606)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ppandit@redhat.com>) id 1jErt4-0002GD-BD
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:54:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ppandit@redhat.com>) id 1jErt3-0005AV-5t
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:54:50 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:49811)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1jErt3-0005AI-24
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584611688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oWalXXmn26iGgFC74sio3AVYyqrGlSDZ9Ww7DRhuHRY=;
 b=hXCbAVLw7LXwMBOeKDZBJkySjDsOPMTKHn0LxARO1APKkVQMd0egbUtOwCm0FnpVAzuCY1
 mSt7X90so2ywmSeXt3/yZ1Ky+mGNgapoLvSyBYofx+IMAszMBLpn6pm7+9TVuUN5Jjj6wE
 vlsb+2EPdwYAV+IsdeBDt3dzPLykQyk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-7rBeyPwrO0u-Z_xV_ZV0lw-1; Thu, 19 Mar 2020 05:54:44 -0400
X-MC-Unique: 7rBeyPwrO0u-Z_xV_ZV0lw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1FB1E8010EC;
 Thu, 19 Mar 2020 09:54:43 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C28A912BF;
 Thu, 19 Mar 2020 09:54:32 +0000 (UTC)
From: P J P <ppandit@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: [PATCH v4 2/3] net: tulip: add .can_recieve routine
Date: Thu, 19 Mar 2020 15:22:10 +0530
Message-Id: <20200319095211.741445-3-ppandit@redhat.com>
In-Reply-To: <20200319095211.741445-1-ppandit@redhat.com>
References: <20200319095211.741445-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, Qemu Developers <qemu-devel@nongnu.org>,
 Li Qiang <pangpei.lq@antfin.com>, Sven Schnelle <svens@stackframe.org>,
 Ziming Zhang <ezrakiez@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

Define .can_receive routine to do sanity checks before receiving
packet data.

Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/net/tulip.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

Update v3: define .can_receive routine
  -> https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg06275.html

diff --git a/hw/net/tulip.c b/hw/net/tulip.c
index fbe40095da..757f12c710 100644
--- a/hw/net/tulip.c
+++ b/hw/net/tulip.c
@@ -229,6 +229,18 @@ static bool tulip_filter_address(TULIPState *s, const =
uint8_t *addr)
     return ret;
 }
=20
+static int
+tulip_can_receive(NetClientState *nc)
+{
+    TULIPState *s =3D qemu_get_nic_opaque(nc);
+
+    if (s->rx_frame_len || tulip_rx_stopped(s)) {
+        return false;
+    }
+
+    return true;
+}
+
 static ssize_t tulip_receive(TULIPState *s, const uint8_t *buf, size_t siz=
e)
 {
     struct tulip_descriptor desc;
@@ -236,7 +248,7 @@ static ssize_t tulip_receive(TULIPState *s, const uint8=
_t *buf, size_t size)
     trace_tulip_receive(buf, size);
=20
     if (size < 14 || size > sizeof(s->rx_frame) - 4
-        || s->rx_frame_len || tulip_rx_stopped(s)) {
+        || !tulip_can_receive(s->nic->ncs)) {
         return 0;
     }
=20
@@ -288,6 +300,7 @@ static NetClientInfo net_tulip_info =3D {
     .type =3D NET_CLIENT_DRIVER_NIC,
     .size =3D sizeof(NICState),
     .receive =3D tulip_receive_nc,
+    .can_receive =3D tulip_can_receive,
 };
=20
 static const char *tulip_reg_name(const hwaddr addr)
--=20
2.25.1


