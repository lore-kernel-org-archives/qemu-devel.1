Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27F1C4646B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 07:50:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACA842086D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 07:50:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA842086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg2hb-00022T-UC
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 03:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36832)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hg2fw-0008Uj-TA
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 03:49:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hg2fv-00055n-Ra
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 03:49:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46962)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hg2fv-00055H-Le
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 03:49:03 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C236E81DF6;
 Wed, 26 Jun 2019 07:49:02 +0000 (UTC)
Received: from localhost (ovpn-116-164.ams2.redhat.com [10.36.116.164])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 11A5D1001959;
 Wed, 26 Jun 2019 07:48:52 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 26 Jun 2019 08:48:14 +0100
Message-Id: <20190626074815.19994-4-stefanha@redhat.com>
In-Reply-To: <20190626074815.19994-1-stefanha@redhat.com>
References: <20190626074815.19994-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Wed, 26 Jun 2019 07:49:02 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 3/4] libvhost-user: implement
 VHOST_USER_PROTOCOL_F_MQ
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Sebastien Boeuf <sebastien.boeuf@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Existing vhost-user device backends, including vhost-user-scsi and
vhost-user-blk, support multiqueue but libvhost-user currently does not
advertise this.

VHOST_USER_PROTOCOL_F_MQ enables the VHOST_USER_GET_QUEUE_NUM request
needed for a vhost-user master to query the number of queues.  For
example, QEMU's vhost-user-net master depends on
VHOST_USER_PROTOCOL_F_MQ for multiqueue.

If you're wondering how any device backend with more than one virtqueue
functions today, it's because device types with a fixed number of
virtqueues do not require querying the number of queues.  Therefore the
vhost-user master for vhost-user-input with 2 virtqueues, for example,
doesn't actually depend on VHOST_USER_PROTOCOL_F_MQ.  It just enables
virtqueues 0 and 1 without asking.

Let there be multiqueue!

Suggested-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
index 90bea856dd..4b36e35a82 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -1160,7 +1160,8 @@ vu_set_vring_err_exec(VuDev *dev, VhostUserMsg *vms=
g)
 static bool
 vu_get_protocol_features_exec(VuDev *dev, VhostUserMsg *vmsg)
 {
-    uint64_t features =3D 1ULL << VHOST_USER_PROTOCOL_F_LOG_SHMFD |
+    uint64_t features =3D 1ULL << VHOST_USER_PROTOCOL_F_MQ |
+                        1ULL << VHOST_USER_PROTOCOL_F_LOG_SHMFD |
                         1ULL << VHOST_USER_PROTOCOL_F_SLAVE_REQ |
                         1ULL << VHOST_USER_PROTOCOL_F_HOST_NOTIFIER |
                         1ULL << VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD;
@@ -1200,8 +1201,8 @@ vu_set_protocol_features_exec(VuDev *dev, VhostUser=
Msg *vmsg)
 static bool
 vu_get_queue_num_exec(VuDev *dev, VhostUserMsg *vmsg)
 {
-    DPRINT("Function %s() not implemented yet.\n", __func__);
-    return false;
+    vmsg_set_reply_u64(vmsg, dev->max_queues);
+    return true;
 }
=20
 static bool
--=20
2.21.0


