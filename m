Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F891C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 19:20:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F41D20678
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 19:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F41D20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAJ1U-0000UV-1r
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 15:20:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44028)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <amorenoz@redhat.com>) id 1iAJ0V-0008LN-9W
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 15:19:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amorenoz@redhat.com>) id 1iAJ0S-0003F4-Vv
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 15:19:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43918)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amorenoz@redhat.com>) id 1iAJ0P-0003B1-0Q
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 15:19:18 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3DE141893FA3;
 Tue, 17 Sep 2019 19:19:12 +0000 (UTC)
Received: from amorenoz.users.ipa.redhat.com (ovpn-117-92.ams2.redhat.com
 [10.36.117.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DE9AD19C6A;
 Tue, 17 Sep 2019 19:19:10 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 17 Sep 2019 21:19:01 +0200
Message-Id: <20190917191901.28348-1-amorenoz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Tue, 17 Sep 2019 19:19:12 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] vhost-user: save features if the char dev is
 closed
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
Cc: ddstreet@canonical.com, Adrian Moreno <amorenoz@redhat.com>,
 Pei Zhang <pezhang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

That way the state can be correctly restored when the device is opened
again. This might happen if the backend is restarted.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1738768
Reported-by: Pei Zhang <pezhang@redhat.com>
Fixes: 6ab79a20af3a (do not call vhost_net_cleanup() on running net from =
char user event)
Cc: ddstreet@canonical.com
Cc: Michael S. Tsirkin <mst@redhat.com>

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 net/vhost-user.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/vhost-user.c b/net/vhost-user.c
index 51921de443..acf20cb9e0 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -235,6 +235,13 @@ static void chr_closed_bh(void *opaque)
=20
     s =3D DO_UPCAST(NetVhostUserState, nc, ncs[0]);
=20
+    if (s->vhost_net) {
+        uint64_t features =3D vhost_net_get_acked_features(s->vhost_net)=
;
+        if (features) {
+            s->acked_features =3D features;
+         }
+    }
+
     qmp_set_link(name, false, &err);
=20
     qemu_chr_fe_set_handlers(&s->chr, NULL, NULL, net_vhost_user_event,
--=20
2.21.0


