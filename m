Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6673CA9EA0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 06:39:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F00E20862
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 06:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q1wTfufQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F00E20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOygi-0004iA-OY
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 02:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40950)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1iOycz-0007vj-N9
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 02:35:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1iOycw-0007ng-My
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 02:35:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52163
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1iOycw-0007nT-Jl
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 02:35:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572244542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YSk/UNDQ3IMUq5qBNZYXL7t/7GeCkHSvp0PM70NGWVY=;
 b=Q1wTfufQBFcdhMq+qH3UZQJ1v70iyHlLQ/5QfcjW4OtkGa0DDwlMgTIp5tjxJbtMeOxNoJ
 1nFGcvd12j2+/FAa9UP/OhBLXZ/3kNjKxC6pH46tbsE3zIz3Qy5sOfP9L/sAWX+1YwDCCo
 9pFm/kq7xx7T3ebNjYBnjPFdl3/srOk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-sms0zCClMXq-GKypFwQ-jQ-1; Mon, 28 Oct 2019 02:35:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 760F8107AD28;
 Mon, 28 Oct 2019 06:35:37 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-13-12.pek2.redhat.com
 [10.72.13.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9072F5C1D4;
 Mon, 28 Oct 2019 06:35:35 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 3/4] virtio-net: prevent offloads reset on migration
Date: Mon, 28 Oct 2019 14:35:19 +0800
Message-Id: <1572244520-14737-4-git-send-email-jasowang@redhat.com>
In-Reply-To: <1572244520-14737-1-git-send-email-jasowang@redhat.com>
References: <1572244520-14737-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: sms0zCClMXq-GKypFwQ-jQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Jason Wang <jasowang@redhat.com>,
 Mikhail Sennikovsky <mikhail.sennikovskii@cloud.ionos.com>,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Mikhail Sennikovsky <mikhail.sennikovskii@cloud.ionos.com>

Currently offloads disabled by guest via the VIRTIO_NET_CTRL_GUEST_OFFLOADS=
_SET
command are not preserved on VM migration.
Instead all offloads reported by guest features (via VIRTIO_PCI_GUEST_FEATU=
RES)
get enabled.
What happens is: first the VirtIONet::curr_guest_offloads gets restored and=
 offloads
are getting set correctly:

 #0  qemu_set_offload (nc=3D0x555556a11400, csum=3D1, tso4=3D0, tso6=3D0, e=
cn=3D0, ufo=3D0) at net/net.c:474
 #1  virtio_net_apply_guest_offloads (n=3D0x555557701ca0) at hw/net/virtio-=
net.c:720
 #2  virtio_net_post_load_device (opaque=3D0x555557701ca0, version_id=3D11)=
 at hw/net/virtio-net.c:2334
 #3  vmstate_load_state (f=3D0x5555569dc010, vmsd=3D0x555556577c80 <vmstate=
_virtio_net_device>, opaque=3D0x555557701ca0, version_id=3D11)
     at migration/vmstate.c:168
 #4  virtio_load (vdev=3D0x555557701ca0, f=3D0x5555569dc010, version_id=3D1=
1) at hw/virtio/virtio.c:2197
 #5  virtio_device_get (f=3D0x5555569dc010, opaque=3D0x555557701ca0, size=
=3D0, field=3D0x55555668cd00 <__compound_literal.5>) at hw/virtio/virtio.c:=
2036
 #6  vmstate_load_state (f=3D0x5555569dc010, vmsd=3D0x555556577ce0 <vmstate=
_virtio_net>, opaque=3D0x555557701ca0, version_id=3D11) at migration/vmstat=
e.c:143
 #7  vmstate_load (f=3D0x5555569dc010, se=3D0x5555578189e0) at migration/sa=
vevm.c:829
 #8  qemu_loadvm_section_start_full (f=3D0x5555569dc010, mis=3D0x5555569eee=
20) at migration/savevm.c:2211
 #9  qemu_loadvm_state_main (f=3D0x5555569dc010, mis=3D0x5555569eee20) at m=
igration/savevm.c:2395
 #10 qemu_loadvm_state (f=3D0x5555569dc010) at migration/savevm.c:2467
 #11 process_incoming_migration_co (opaque=3D0x0) at migration/migration.c:=
449

However later on the features are getting restored, and offloads get reset =
to
everything supported by features:

 #0  qemu_set_offload (nc=3D0x555556a11400, csum=3D1, tso4=3D1, tso6=3D1, e=
cn=3D0, ufo=3D0) at net/net.c:474
 #1  virtio_net_apply_guest_offloads (n=3D0x555557701ca0) at hw/net/virtio-=
net.c:720
 #2  virtio_net_set_features (vdev=3D0x555557701ca0, features=3D5104441767)=
 at hw/net/virtio-net.c:773
 #3  virtio_set_features_nocheck (vdev=3D0x555557701ca0, val=3D5104441767) =
at hw/virtio/virtio.c:2052
 #4  virtio_load (vdev=3D0x555557701ca0, f=3D0x5555569dc010, version_id=3D1=
1) at hw/virtio/virtio.c:2220
 #5  virtio_device_get (f=3D0x5555569dc010, opaque=3D0x555557701ca0, size=
=3D0, field=3D0x55555668cd00 <__compound_literal.5>) at hw/virtio/virtio.c:=
2036
 #6  vmstate_load_state (f=3D0x5555569dc010, vmsd=3D0x555556577ce0 <vmstate=
_virtio_net>, opaque=3D0x555557701ca0, version_id=3D11) at migration/vmstat=
e.c:143
 #7  vmstate_load (f=3D0x5555569dc010, se=3D0x5555578189e0) at migration/sa=
vevm.c:829
 #8  qemu_loadvm_section_start_full (f=3D0x5555569dc010, mis=3D0x5555569eee=
20) at migration/savevm.c:2211
 #9  qemu_loadvm_state_main (f=3D0x5555569dc010, mis=3D0x5555569eee20) at m=
igration/savevm.c:2395
 #10 qemu_loadvm_state (f=3D0x5555569dc010) at migration/savevm.c:2467
 #11 process_incoming_migration_co (opaque=3D0x0) at migration/migration.c:=
449

Fix this by preserving the state in saved_guest_offloads field and
pushing out offload initialization to the new post load hook.

Cc: qemu-stable@nongnu.org
Signed-off-by: Mikhail Sennikovsky <mikhail.sennikovskii@cloud.ionos.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/virtio-net.c            | 27 ++++++++++++++++++++++++---
 include/hw/virtio/virtio-net.h |  2 ++
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 9f11422..9d64619 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2333,9 +2333,13 @@ static int virtio_net_post_load_device(void *opaque,=
 int version_id)
         n->curr_guest_offloads =3D virtio_net_supported_guest_offloads(n);
     }
=20
-    if (peer_has_vnet_hdr(n)) {
-        virtio_net_apply_guest_offloads(n);
-    }
+    /*
+     * curr_guest_offloads will be later overwritten by the
+     * virtio_set_features_nocheck call done from the virtio_load.
+     * Here we make sure it is preserved and restored accordingly
+     * in the virtio_net_post_load_virtio callback.
+     */
+    n->saved_guest_offloads =3D n->curr_guest_offloads;
=20
     virtio_net_set_queues(n);
=20
@@ -2370,6 +2374,22 @@ static int virtio_net_post_load_device(void *opaque,=
 int version_id)
     return 0;
 }
=20
+static int virtio_net_post_load_virtio(VirtIODevice *vdev)
+{
+    VirtIONet *n =3D VIRTIO_NET(vdev);
+    /*
+     * The actual needed state is now in saved_guest_offloads,
+     * see virtio_net_post_load_device for detail.
+     * Restore it back and apply the desired offloads.
+     */
+    n->curr_guest_offloads =3D n->saved_guest_offloads;
+    if (peer_has_vnet_hdr(n)) {
+        virtio_net_apply_guest_offloads(n);
+    }
+
+    return 0;
+}
+
 /* tx_waiting field of a VirtIONetQueue */
 static const VMStateDescription vmstate_virtio_net_queue_tx_waiting =3D {
     .name =3D "virtio-net-queue-tx_waiting",
@@ -2912,6 +2932,7 @@ static void virtio_net_class_init(ObjectClass *klass,=
 void *data)
     vdc->guest_notifier_mask =3D virtio_net_guest_notifier_mask;
     vdc->guest_notifier_pending =3D virtio_net_guest_notifier_pending;
     vdc->legacy_features |=3D (0x1 << VIRTIO_NET_F_GSO);
+    vdc->post_load =3D virtio_net_post_load_virtio;
     vdc->vmsd =3D &vmstate_virtio_net_device;
 }
=20
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.=
h
index b96f0c6..07a9319 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -182,6 +182,8 @@ struct VirtIONet {
     char *netclient_name;
     char *netclient_type;
     uint64_t curr_guest_offloads;
+    /* used on saved state restore phase to preserve the curr_guest_offloa=
ds */
+    uint64_t saved_guest_offloads;
     AnnounceTimer announce_timer;
     bool needs_vnet_hdr_swap;
     bool mtu_bypass_backend;
--=20
2.5.0


