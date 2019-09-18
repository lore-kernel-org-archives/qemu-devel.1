Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02923C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 08:52:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C642B21897
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 08:52:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C642B21897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAVh6-0002Ih-Qg
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 04:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50570)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <amorenoz@redhat.com>) id 1iAVfS-0001Mq-Hx
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 04:50:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amorenoz@redhat.com>) id 1iAVfQ-0006U4-IK
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 04:50:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33544)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amorenoz@redhat.com>) id 1iAVdn-0005NZ-M8
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 04:50:28 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A86EAA3D381;
 Wed, 18 Sep 2019 08:48:46 +0000 (UTC)
Received: from amorenoz.users.ipa.redhat.com (ovpn-117-92.ams2.redhat.com
 [10.36.117.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 10753600CC;
 Wed, 18 Sep 2019 08:48:42 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 18 Sep 2019 10:48:34 +0200
Message-Id: <20190918084834.9729-1-amorenoz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Wed, 18 Sep 2019 08:48:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2] vhost-user: save features if the char dev
 is closed
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
 net/vhost-user.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/vhost-user.c b/net/vhost-user.c
index 51921de443..014199d600 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -235,6 +235,10 @@ static void chr_closed_bh(void *opaque)
=20
     s =3D DO_UPCAST(NetVhostUserState, nc, ncs[0]);
=20
+    if (s->vhost_net) {
+        s->acked_features =3D vhost_net_get_acked_features(s->vhost_net)=
;
+    }
+
     qmp_set_link(name, false, &err);
=20
     qemu_chr_fe_set_handlers(&s->chr, NULL, NULL, net_vhost_user_event,
--=20
2.21.0


