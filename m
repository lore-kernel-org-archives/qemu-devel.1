Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F36C432C3
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 15:52:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7777D20674
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 15:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gpwSqLpL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7777D20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZGei-00032p-CX
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 10:52:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1iZGTS-0000ED-B6
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:40:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1iZGTR-0002U7-7C
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:40:26 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56577
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1iZGTR-0002Sg-2l
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:40:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574696424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sY61yhknOowK74+/u3ndk4J62lzQKRsHnDv4mPDXX3w=;
 b=gpwSqLpL0RquMw+x8z6CbG/RJcGdCt3Ze6zKcBa0wjv31eVZ6euLJYa0C2Z0ylwbLNmykP
 xqM4HW1M1YWNNC6wk+qWfP4hCq9RHju+gtkHST1tKzm0v0QpRU+YdcItDYFYAfsblImzoG
 vlIMGlGm2OQdi5x6Vxw/hMN+pTSZ9yw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-JDcknIFhOZCvvr7aBLAggg-1; Mon, 25 Nov 2019 10:40:22 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B322104ED3F;
 Mon, 25 Nov 2019 15:40:22 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-31.pek2.redhat.com
 [10.72.12.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5E4F15D9CA;
 Mon, 25 Nov 2019 15:40:20 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org
Subject: [PULL 4/4] net/virtio: return error when device_opts arg is NULL
Date: Mon, 25 Nov 2019 23:40:07 +0800
Message-Id: <1574696407-4188-5-git-send-email-jasowang@redhat.com>
In-Reply-To: <1574696407-4188-1-git-send-email-jasowang@redhat.com>
References: <1574696407-4188-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: JDcknIFhOZCvvr7aBLAggg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Jason Wang <jasowang@redhat.com>, Jens Freimann <jfreimann@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jens Freimann <jfreimann@redhat.com>

This fixes CID 1407222.

Fixes: 9711cd0dfc3f ("net/virtio: add failover support")
Signed-off-by: Jens Freimann <jfreimann@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/virtio-net.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 565dea0..3c31471 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2880,9 +2880,12 @@ static int virtio_net_primary_should_be_hidden(Devic=
eListener *listener,
             QemuOpts *device_opts)
 {
     VirtIONet *n =3D container_of(listener, VirtIONet, primary_listener);
-    bool match_found;
-    bool hide;
+    bool match_found =3D false;
+    bool hide =3D false;
=20
+    if (!device_opts) {
+        return -1;
+    }
     n->primary_device_dict =3D qemu_opts_to_qdict(device_opts,
             n->primary_device_dict);
     if (n->primary_device_dict) {
@@ -2890,7 +2893,7 @@ static int virtio_net_primary_should_be_hidden(Device=
Listener *listener,
         n->standby_id =3D g_strdup(qdict_get_try_str(n->primary_device_dic=
t,
                     "failover_pair_id"));
     }
-    if (device_opts && g_strcmp0(n->standby_id, n->netclient_name) =3D=3D =
0) {
+    if (g_strcmp0(n->standby_id, n->netclient_name) =3D=3D 0) {
         match_found =3D true;
     } else {
         match_found =3D false;
--=20
2.5.0


