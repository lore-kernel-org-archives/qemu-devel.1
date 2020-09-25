Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCA3C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:17:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FC25208B6
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kew8w0oJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FC25208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLpTx-00078H-6h
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 11:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1kLpPy-0004Pq-55
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:13:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27118)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1kLpPv-0004ab-UT
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:13:49 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601046825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TWJJvHe4XhB9H138SGnIZQriUxIvDAmYNqCAxp22+vc=;
 b=Kew8w0oJRlXjQc5C2IqUumksNJD99gTtpGZsH48JQaMB1DjmRYnH4z19ylV31rROOWY6BU
 srSxH34HXHjB4GQTUQ6ozgL8ASHwKza+OQbBgEAtosRao/qfk9s42qqppc0QeB//G/U6QE
 EOwN3dOsHqyZ2E+GTRy8laA8KP+ENq4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-73m9Qjl4NT-ciph7lD2dRA-1; Fri, 25 Sep 2020 11:13:43 -0400
X-MC-Unique: 73m9Qjl4NT-ciph7lD2dRA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAE5C1021202;
 Fri, 25 Sep 2020 15:13:42 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-12-27.pek2.redhat.com [10.72.12.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BEB7B5C1BB;
 Fri, 25 Sep 2020 15:13:36 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH v2] virtio-net: Set mac address to hardware if the peer is vdpa
Date: Fri, 25 Sep 2020 23:13:33 +0800
Message-Id: <20200925151333.6157-1-lulu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lulu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:48:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-stable@nongnu.org, lulu@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If the peer's type is vdpa, we need to set the mac address to hardware
in virtio_net_device_realize,

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 hw/net/virtio-net.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index cb0d27084c..1f2c1643bf 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3399,6 +3399,12 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     nc = qemu_get_queue(n->nic);
     nc->rxfilter_notify_enabled = 1;
 
+   if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
+        struct virtio_net_config netcfg = {};
+        memcpy(&netcfg.mac, &n->nic_conf.macaddr, ETH_ALEN);
+        vhost_net_set_config(get_vhost_net(nc->peer),
+            (uint8_t *)&netcfg, 0, ETH_ALEN, VHOST_SET_CONFIG_TYPE_MASTER);
+    }
     QTAILQ_INIT(&n->rsc_chains);
     n->qdev = dev;
 
-- 
2.21.3


