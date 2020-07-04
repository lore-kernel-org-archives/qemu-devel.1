Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AFFC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:53:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC9A120724
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fjHLCf6G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC9A120724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrnHk-0005U1-39
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 14:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmwZ-0005eh-UO
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:31:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23099
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmwX-0001ip-DL
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593887476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4lWrpFH2CiygCO5uciNVA5FaqB2VaYbCK0AZiDA9UeM=;
 b=fjHLCf6GowtCyhkReK4Zq1zDtHCWQOeIH6mq5fUNujYI31uCw0fAZhU1reu7H7E9PUWitm
 0sDVr8WVPuMPE51ZvkfHQqVc8kEDCBdSc1hDkrpWNmJMZBvffoUmK7Tw6tQv2pHQE0aU7m
 GMFpBJJIswsI+DH2G6/2AXqBZl9xDgU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-dNp_sj52PNGqdCQ3br8Dxg-1; Sat, 04 Jul 2020 14:31:13 -0400
X-MC-Unique: dNp_sj52PNGqdCQ3br8Dxg-1
Received: by mail-wm1-f70.google.com with SMTP id g6so34363095wmk.4
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 11:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4lWrpFH2CiygCO5uciNVA5FaqB2VaYbCK0AZiDA9UeM=;
 b=SlyCi58FEJlsa35jIR/hT9frmSTaz3eAy0JvZowKav/7H/uCOQNRfNxUfSQEt1MW9I
 BrOxwp2lkMfABuqmdHafhE432781OViVdRwPBx9cndzIEP6MaiGVrAWlZ+tEx9B50/2m
 iI51nBTxtGCuldYgu7t1L8S55WMpqRyv2PSwNvdfJLkzS1t7jonlls47FtESrmrSOP44
 lS2AQdapFlzWkp/Ys/vXNNdYroWAF5qEnLf7nggo07izVwLN+jrtMsurGZOShsC9gtlV
 /ZJzg+YtyufxFwXNhVrch1t8Pl2oaHc14tAfM5AJlOkTDej4V/iyvu/dmuWE4jnoJIfj
 F8TA==
X-Gm-Message-State: AOAM5322pZ/IjoDycWzZA/KSiBeVOLRIxM3I0tAYInoWKvIkdjM5bnaE
 BZ4CcvfYbkrTliEsa0dBLYU7iui4jfW8krN6r1ZsmUrpgKom9ND3VTV6AoFjNK6NjN4I9L22mA4
 LAA9bTnjjSPnjj2Y=
X-Received: by 2002:adf:9c8c:: with SMTP id d12mr40909300wre.369.1593887471377; 
 Sat, 04 Jul 2020 11:31:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMvJk8BJXRgLhMO9P/k6ZtefYVHAqTbh9hbFSDwPhFpsWNYj6RLANadDBTTHltxG/et/VKOQ==
X-Received: by 2002:adf:9c8c:: with SMTP id d12mr40909282wre.369.1593887471039; 
 Sat, 04 Jul 2020 11:31:11 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 n125sm18032509wme.30.2020.07.04.11.31.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 11:31:10 -0700 (PDT)
Date: Sat, 4 Jul 2020 14:31:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 41/41] vhost-vdpa: introduce vhost-vdpa net client
Message-ID: <20200704182750.1088103-42-mst@redhat.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cindy Lu <lulu@redhat.com>,
 Tiwei Bie <tiwei.bie@intel.com>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Lingshan Zhu <lingshan.zhu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cindy Lu <lulu@redhat.com>

This patch set introduces a new net client type: vhost-vdpa.
vhost-vdpa net client will set up a vDPA device which is specified
by a "vhostdev" parameter.

Signed-off-by: Lingshan Zhu <lingshan.zhu@intel.com>
Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
Signed-off-by: Cindy Lu <lulu@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20200701145538.22333-15-lulu@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 qapi/net.json            |  28 ++++-
 include/net/vhost-vdpa.h |  22 ++++
 net/clients.h            |   2 +
 net/net.c                |   3 +
 net/vhost-vdpa.c         | 228 +++++++++++++++++++++++++++++++++++++++
 net/Makefile.objs        |   2 +-
 6 files changed, 282 insertions(+), 3 deletions(-)
 create mode 100644 include/net/vhost-vdpa.h
 create mode 100644 net/vhost-vdpa.c

diff --git a/qapi/net.json b/qapi/net.json
index 9244c9af56..558d520a2f 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -428,16 +428,39 @@
     '*vhostforce':    'bool',
     '*queues':        'int' } }
 
+##
+# @NetdevVhostVDPAOptions:
+#
+# Vhost-vdpa network backend
+#
+# vDPA device is a device that uses a datapath which complies with the virtio
+# specifications with a vendor specific control path.
+#
+# @vhostdev: path of vhost-vdpa device
+#            (default:'/dev/vhost-vdpa-0')
+#
+# @queues: number of queues to be created for multiqueue vhost-vdpa
+#          (default: 1)
+#
+# Since: 5.1
+##
+{ 'struct': 'NetdevVhostVDPAOptions',
+  'data': {
+    '*vhostdev':     'str',
+    '*queues':       'int' } }
+
 ##
 # @NetClientDriver:
 #
 # Available netdev drivers.
 #
 # Since: 2.7
+#
+# @vhost-vdpa since 5.1
 ##
 { 'enum': 'NetClientDriver',
   'data': [ 'none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde',
-            'bridge', 'hubport', 'netmap', 'vhost-user' ] }
+            'bridge', 'hubport', 'netmap', 'vhost-user', 'vhost-vdpa' ] }
 
 ##
 # @Netdev:
@@ -465,7 +488,8 @@
     'bridge':   'NetdevBridgeOptions',
     'hubport':  'NetdevHubPortOptions',
     'netmap':   'NetdevNetmapOptions',
-    'vhost-user': 'NetdevVhostUserOptions' } }
+    'vhost-user': 'NetdevVhostUserOptions',
+    'vhost-vdpa': 'NetdevVhostVDPAOptions' } }
 
 ##
 # @NetFilterDirection:
diff --git a/include/net/vhost-vdpa.h b/include/net/vhost-vdpa.h
new file mode 100644
index 0000000000..45e34b7cfc
--- /dev/null
+++ b/include/net/vhost-vdpa.h
@@ -0,0 +1,22 @@
+/*
+ * vhost-vdpa.h
+ *
+ * Copyright(c) 2017-2018 Intel Corporation.
+ * Copyright(c) 2020 Red Hat, Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef VHOST_VDPA_H
+#define VHOST_VDPA_H
+
+#define TYPE_VHOST_VDPA "vhost-vdpa"
+
+struct vhost_net *vhost_vdpa_get_vhost_net(NetClientState *nc);
+uint64_t vhost_vdpa_get_acked_features(NetClientState *nc);
+
+extern const int vdpa_feature_bits[];
+
+#endif /* VHOST_VDPA_H */
diff --git a/net/clients.h b/net/clients.h
index a6ef267e19..92f9b59aed 100644
--- a/net/clients.h
+++ b/net/clients.h
@@ -61,4 +61,6 @@ int net_init_netmap(const Netdev *netdev, const char *name,
 int net_init_vhost_user(const Netdev *netdev, const char *name,
                         NetClientState *peer, Error **errp);
 
+int net_init_vhost_vdpa(const Netdev *netdev, const char *name,
+                        NetClientState *peer, Error **errp);
 #endif /* QEMU_NET_CLIENTS_H */
diff --git a/net/net.c b/net/net.c
index 9099a327dd..94dc546fb2 100644
--- a/net/net.c
+++ b/net/net.c
@@ -966,6 +966,9 @@ static int (* const net_client_init_fun[NET_CLIENT_DRIVER__MAX])(
 #ifdef CONFIG_VHOST_NET_USER
         [NET_CLIENT_DRIVER_VHOST_USER] = net_init_vhost_user,
 #endif
+#ifdef CONFIG_VHOST_NET_VDPA
+        [NET_CLIENT_DRIVER_VHOST_VDPA] = net_init_vhost_vdpa,
+#endif
 #ifdef CONFIG_L2TPV3
         [NET_CLIENT_DRIVER_L2TPV3]    = net_init_l2tpv3,
 #endif
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
new file mode 100644
index 0000000000..bc0e0d2d35
--- /dev/null
+++ b/net/vhost-vdpa.c
@@ -0,0 +1,228 @@
+/*
+ * vhost-vdpa.c
+ *
+ * Copyright(c) 2017-2018 Intel Corporation.
+ * Copyright(c) 2020 Red Hat, Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "clients.h"
+#include "net/vhost_net.h"
+#include "net/vhost-vdpa.h"
+#include "hw/virtio/vhost-vdpa.h"
+#include "qemu/config-file.h"
+#include "qemu/error-report.h"
+#include "qemu/option.h"
+#include "qapi/error.h"
+#include <sys/ioctl.h>
+#include <err.h>
+#include "standard-headers/linux/virtio_net.h"
+#include "monitor/monitor.h"
+#include "hw/virtio/vhost.h"
+
+/* Todo:need to add the multiqueue support here */
+typedef struct VhostVDPAState {
+    NetClientState nc;
+    struct vhost_vdpa vhost_vdpa;
+    VHostNetState *vhost_net;
+    uint64_t acked_features;
+    bool started;
+} VhostVDPAState;
+
+const int vdpa_feature_bits[] = {
+    VIRTIO_F_NOTIFY_ON_EMPTY,
+    VIRTIO_RING_F_INDIRECT_DESC,
+    VIRTIO_RING_F_EVENT_IDX,
+    VIRTIO_F_ANY_LAYOUT,
+    VIRTIO_F_VERSION_1,
+    VIRTIO_NET_F_CSUM,
+    VIRTIO_NET_F_GUEST_CSUM,
+    VIRTIO_NET_F_GSO,
+    VIRTIO_NET_F_GUEST_TSO4,
+    VIRTIO_NET_F_GUEST_TSO6,
+    VIRTIO_NET_F_GUEST_ECN,
+    VIRTIO_NET_F_GUEST_UFO,
+    VIRTIO_NET_F_HOST_TSO4,
+    VIRTIO_NET_F_HOST_TSO6,
+    VIRTIO_NET_F_HOST_ECN,
+    VIRTIO_NET_F_HOST_UFO,
+    VIRTIO_NET_F_MRG_RXBUF,
+    VIRTIO_NET_F_MTU,
+    VIRTIO_F_IOMMU_PLATFORM,
+    VIRTIO_F_RING_PACKED,
+    VIRTIO_NET_F_GUEST_ANNOUNCE,
+    VHOST_INVALID_FEATURE_BIT
+};
+
+VHostNetState *vhost_vdpa_get_vhost_net(NetClientState *nc)
+{
+    VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
+    assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
+    return s->vhost_net;
+}
+
+uint64_t vhost_vdpa_get_acked_features(NetClientState *nc)
+{
+    VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
+    assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
+    s->acked_features = vhost_net_get_acked_features(s->vhost_net);
+
+    return s->acked_features;
+}
+
+static int vhost_vdpa_net_check_device_id(struct vhost_net *net)
+{
+    uint32_t device_id;
+    int ret;
+    struct vhost_dev *hdev;
+
+    hdev = (struct vhost_dev *)&net->dev;
+    ret = hdev->vhost_ops->vhost_get_device_id(hdev, &device_id);
+    if (device_id != VIRTIO_ID_NET) {
+        return -ENOTSUP;
+    }
+    return ret;
+}
+
+static void vhost_vdpa_del(NetClientState *ncs)
+{
+    VhostVDPAState *s;
+    assert(ncs->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
+    s = DO_UPCAST(VhostVDPAState, nc, ncs);
+    if (s->vhost_net) {
+        vhost_net_cleanup(s->vhost_net);
+    }
+}
+
+static int vhost_vdpa_add(NetClientState *ncs, void *be)
+{
+    VhostNetOptions options;
+    struct vhost_net *net = NULL;
+    VhostVDPAState *s;
+    int ret;
+
+    options.backend_type = VHOST_BACKEND_TYPE_VDPA;
+    assert(ncs->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
+    s = DO_UPCAST(VhostVDPAState, nc, ncs);
+    options.net_backend = ncs;
+    options.opaque      = be;
+    options.busyloop_timeout = 0;
+
+    net = vhost_net_init(&options);
+    if (!net) {
+        error_report("failed to init vhost_net for queue");
+        goto err;
+    }
+    if (s->vhost_net) {
+        vhost_net_cleanup(s->vhost_net);
+        g_free(s->vhost_net);
+    }
+    s->vhost_net = net;
+    ret = vhost_vdpa_net_check_device_id(net);
+    if (ret) {
+        goto err;
+    }
+    return 0;
+err:
+    if (net) {
+        vhost_net_cleanup(net);
+    }
+    vhost_vdpa_del(ncs);
+    return -1;
+}
+
+static void vhost_vdpa_cleanup(NetClientState *nc)
+{
+    VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
+
+    if (s->vhost_net) {
+        vhost_net_cleanup(s->vhost_net);
+        g_free(s->vhost_net);
+        s->vhost_net = NULL;
+    }
+}
+
+static bool vhost_vdpa_has_vnet_hdr(NetClientState *nc)
+{
+    assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
+
+    return true;
+}
+
+static bool vhost_vdpa_has_ufo(NetClientState *nc)
+{
+    assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
+    VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
+    uint64_t features = 0;
+    features |= (1ULL << VIRTIO_NET_F_HOST_UFO);
+    features = vhost_net_get_features(s->vhost_net, features);
+    return !!(features & (1ULL << VIRTIO_NET_F_HOST_UFO));
+
+}
+
+static NetClientInfo net_vhost_vdpa_info = {
+        .type = NET_CLIENT_DRIVER_VHOST_VDPA,
+        .size = sizeof(VhostVDPAState),
+        .cleanup = vhost_vdpa_cleanup,
+        .has_vnet_hdr = vhost_vdpa_has_vnet_hdr,
+        .has_ufo = vhost_vdpa_has_ufo,
+};
+
+static int net_vhost_vdpa_init(NetClientState *peer, const char *device,
+                               const char *name, const char *vhostdev)
+{
+    NetClientState *nc = NULL;
+    VhostVDPAState *s;
+    int vdpa_device_fd = -1;
+    int ret = 0;
+    assert(name);
+    nc = qemu_new_net_client(&net_vhost_vdpa_info, peer, device, name);
+    snprintf(nc->info_str, sizeof(nc->info_str), TYPE_VHOST_VDPA);
+    nc->queue_index = 0;
+    s = DO_UPCAST(VhostVDPAState, nc, nc);
+    vdpa_device_fd = qemu_open(vhostdev, O_RDWR);
+    if (vdpa_device_fd == -1) {
+        return -errno;
+    }
+    s->vhost_vdpa.device_fd = vdpa_device_fd;
+    ret = vhost_vdpa_add(nc, (void *)&s->vhost_vdpa);
+    assert(s->vhost_net);
+    return ret;
+}
+
+static int net_vhost_check_net(void *opaque, QemuOpts *opts, Error **errp)
+{
+    const char *name = opaque;
+    const char *driver, *netdev;
+
+    driver = qemu_opt_get(opts, "driver");
+    netdev = qemu_opt_get(opts, "netdev");
+    if (!driver || !netdev) {
+        return 0;
+    }
+    if (strcmp(netdev, name) == 0 &&
+        !g_str_has_prefix(driver, "virtio-net-")) {
+        error_setg(errp, "vhost-vdpa requires frontend driver virtio-net-*");
+        return -1;
+    }
+    return 0;
+}
+
+int net_init_vhost_vdpa(const Netdev *netdev, const char *name,
+                        NetClientState *peer, Error **errp)
+{
+    const NetdevVhostVDPAOptions *opts;
+
+    assert(netdev->type == NET_CLIENT_DRIVER_VHOST_VDPA);
+    opts = &netdev->u.vhost_vdpa;
+    /* verify net frontend */
+    if (qemu_opts_foreach(qemu_find_opts("device"), net_vhost_check_net,
+                          (char *)name, errp)) {
+        return -1;
+    }
+    return net_vhost_vdpa_init(peer, TYPE_VHOST_VDPA, name, opts->vhostdev);
+}
diff --git a/net/Makefile.objs b/net/Makefile.objs
index c5d076d19c..5ab45545db 100644
--- a/net/Makefile.objs
+++ b/net/Makefile.objs
@@ -26,7 +26,7 @@ tap-obj-$(CONFIG_SOLARIS) = tap-solaris.o
 tap-obj-y ?= tap-stub.o
 common-obj-$(CONFIG_POSIX) += tap.o $(tap-obj-y)
 common-obj-$(CONFIG_WIN32) += tap-win32.o
-
+common-obj-$(CONFIG_VHOST_NET_VDPA) += vhost-vdpa.o
 vde.o-libs = $(VDE_LIBS)
 
 common-obj-$(CONFIG_CAN_BUS) += can/
-- 
MST


