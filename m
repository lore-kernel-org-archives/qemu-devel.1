Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA5EC433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:39:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B798D20747
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="USSuj4vj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B798D20747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrn4Z-0003is-VI
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 14:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmw3-0004WY-Mj
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:30:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26766
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmw2-0001bb-07
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:30:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593887445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qOJsVqrCvYFr1+pi9ZUb1wgSPCHp9bN1XR/9RybzirU=;
 b=USSuj4vjQDNoc9e8WWYpiOQkoFUWToxIv1ywJt/4jCXmkUj1YpSQ8qYsE5sGyzU5LsmOZ3
 uKlXzqZlv6od4SFloy9Fdkx/tzGSd9ttD99ExsIkJfz6LeBUAWXXOQblIdFmin60aZtc/b
 Fn1Sa4JXQDcRyDelV09tp9ANBb2vl2U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-4lf72iiqM-C4nbueEmHeZw-1; Sat, 04 Jul 2020 14:30:43 -0400
X-MC-Unique: 4lf72iiqM-C4nbueEmHeZw-1
Received: by mail-wm1-f69.google.com with SMTP id 65so20436641wmd.8
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 11:30:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qOJsVqrCvYFr1+pi9ZUb1wgSPCHp9bN1XR/9RybzirU=;
 b=lQoFJXJYV96SxAz7QiICSFfBUCLKRt2nKP0kCEdPR/4ugrRYkjwkTxhXkRvHtiw0Dn
 jtra1ZDpa/+ZSTy6ZpnzirxJEHFlwvigIU17PGeScvjlnwWbUQaD0hkOzQeZAMEToqot
 B3+4vlaYNI592hKU8TQikjRep+wELnCxjQFvsf/zc7zacci4cf++3hxpDj0Wh7DkPlMl
 4ROtTBxg63X06oppedp2qd3KE8wjExsD82tVV50xj55rYW5GE21ab1WUv+K6iqNuj9Tt
 2T1p4+tmqFwXMfqgiMC1RgEEixiSU1VNrEa9BindVbH4mhjPcQXs8jM4roY9JO11cH3d
 f2KQ==
X-Gm-Message-State: AOAM533/6iBY8z6h1s5SWy+7KLkeDp/xCfCbjHt2L0yl9vnJ9oUP1igR
 VrnT6/GcaJ2KPwLqyWP/4c7crASOj6Dg8fTSc2fg5QBOYvr3gw4z6CYG1FezoYS+/w3AkYhuJyw
 GffkBDIYddXiK/eA=
X-Received: by 2002:a5d:6ac7:: with SMTP id u7mr14069865wrw.25.1593887441612; 
 Sat, 04 Jul 2020 11:30:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWLK5WP2QkFfs8TqG70mHqiHLQgxoVCgQFj1aK2YTNjshYf9P+v5SP0YbYMwg1ugPEjj6UAw==
X-Received: by 2002:a5d:6ac7:: with SMTP id u7mr14069854wrw.25.1593887441461; 
 Sat, 04 Jul 2020 11:30:41 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 59sm18305410wrj.37.2020.07.04.11.30.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 11:30:40 -0700 (PDT)
Date: Sat, 4 Jul 2020 14:30:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 29/41] vhost_net: use the function qemu_get_peer
Message-ID: <20200704182750.1088103-30-mst@redhat.com>
References: <20200704182750.1088103-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200704182750.1088103-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 11:39:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Cindy Lu <lulu@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cindy Lu <lulu@redhat.com>

user the qemu_get_peer to replace the old process

Signed-off-by: Cindy Lu <lulu@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Message-Id: <20200701145538.22333-3-lulu@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/vhost_net.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 6b82803fa7..4096d64aaf 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -306,7 +306,9 @@ int vhost_net_start(VirtIODevice *dev, NetClientState *ncs,
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(dev)));
     VirtioBusState *vbus = VIRTIO_BUS(qbus);
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(vbus);
+    struct vhost_net *net;
     int r, e, i;
+    NetClientState *peer;
 
     if (!k->set_guest_notifiers) {
         error_report("binding does not support guest notifiers");
@@ -314,9 +316,9 @@ int vhost_net_start(VirtIODevice *dev, NetClientState *ncs,
     }
 
     for (i = 0; i < total_queues; i++) {
-        struct vhost_net *net;
 
-        net = get_vhost_net(ncs[i].peer);
+        peer = qemu_get_peer(ncs, i);
+        net = get_vhost_net(peer);
         vhost_net_set_vq_index(net, i * 2);
 
         /* Suppress the masking guest notifiers on vhost user
@@ -335,15 +337,16 @@ int vhost_net_start(VirtIODevice *dev, NetClientState *ncs,
     }
 
     for (i = 0; i < total_queues; i++) {
-        r = vhost_net_start_one(get_vhost_net(ncs[i].peer), dev);
+        peer = qemu_get_peer(ncs, i);
+        r = vhost_net_start_one(get_vhost_net(peer), dev);
 
         if (r < 0) {
             goto err_start;
         }
 
-        if (ncs[i].peer->vring_enable) {
+        if (peer->vring_enable) {
             /* restore vring enable state */
-            r = vhost_set_vring_enable(ncs[i].peer, ncs[i].peer->vring_enable);
+            r = vhost_set_vring_enable(peer, peer->vring_enable);
 
             if (r < 0) {
                 goto err_start;
@@ -355,7 +358,8 @@ int vhost_net_start(VirtIODevice *dev, NetClientState *ncs,
 
 err_start:
     while (--i >= 0) {
-        vhost_net_stop_one(get_vhost_net(ncs[i].peer), dev);
+        peer = qemu_get_peer(ncs , i);
+        vhost_net_stop_one(get_vhost_net(peer), dev);
     }
     e = k->set_guest_notifiers(qbus->parent, total_queues * 2, false);
     if (e < 0) {
-- 
MST


