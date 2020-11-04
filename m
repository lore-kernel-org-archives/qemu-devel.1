Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D090C4741F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 05:15:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9DAA20BED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 05:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cyh0pX55"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9DAA20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaB90-0006qx-Oo
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 00:15:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAnC-0000sK-86
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 23:53:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20794)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAn9-00057C-A8
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 23:53:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604465582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IbXx/en61PP6xw7L1bYEyVwqp2fnuXoDT6+6BHQY4zY=;
 b=cyh0pX55oKKvv81nHpZUzsj51FWkxfMSOsewD+pA7vUOML5Y5riubtaE7C8Q3zEUbAjm74
 LpRi1wiiNTxfSfXiiUnMlWe4SWVgYFbE9h2FUt3hW+gAFzzQJmYDLT1QJqhHoxARGKK3Qu
 H5qzAP7WjP7pVJTBkC1v8wLecrgdsgw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-obTMKEvPP0qHUJCV7fxJNA-1; Tue, 03 Nov 2020 23:52:15 -0500
X-MC-Unique: obTMKEvPP0qHUJCV7fxJNA-1
Received: by mail-wm1-f71.google.com with SMTP id o19so740576wme.2
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 20:52:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=IbXx/en61PP6xw7L1bYEyVwqp2fnuXoDT6+6BHQY4zY=;
 b=PE8LjYQoKbrO9fVWVlqdWaFkc+mThy534ebldKVjViUZmx4GxPgfva8mTmWk3O5YHl
 AVLqhqGL0r9dydvcCXjEyjSOy2MrEiV2Kq47q2uFOlHCihPQpTGySVod+p+g4DjOZgnd
 vxUPoI1f2pB4dLHp2XHsit/aR7OqDWd3B/x50hxcfErH9nx+3wLchYGADoaWNG2F+2os
 riZWJDCvtvfPOnpPqtnqjVVqx4fUEJrDTqqnHWdo9OBO5lEpmQbiXH/hNqEVaqdBz8AM
 Z/Z4X50wWpCinNq8ZF+kjfOYv5R8sTi1x5hWDrX1BbVnRZHJHV+D4UAbxK1U9CHj6V/z
 5mzQ==
X-Gm-Message-State: AOAM533Eu3bpRJfARmCOiQIl9md820tlKv1EKZS/7Uux7MEq1f+mBwtL
 GOwkwfh4WW4hHbNA7i4nRK+LtEWarYRJ7mWzYTwD6ta9Tk/hiq88LRAUjx4y/2DgT3d05OskQt2
 xUCtGRF85FgNnBMs=
X-Received: by 2002:a1c:1f91:: with SMTP id f139mr2339632wmf.187.1604465533632; 
 Tue, 03 Nov 2020 20:52:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxJHdoe4WImVutJSVXm+ed/c7WdUsDEtjtgNrpmiR//+5yqtddfmQwmG92+m8ccY5GJa/s6Bw==
X-Received: by 2002:a1c:1f91:: with SMTP id f139mr2339620wmf.187.1604465533503; 
 Tue, 03 Nov 2020 20:52:13 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id y11sm790618wmj.36.2020.11.03.20.52.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 20:52:12 -0800 (PST)
Date: Tue, 3 Nov 2020 23:52:11 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 33/38] tests/qtest: add multi-queue test case to
 vhost-user-blk-test
Message-ID: <20201104044937.226370-34-mst@redhat.com>
References: <20201104044937.226370-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201104044937.226370-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20201001144604.559733-3-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20201027173528.213464-8-stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/vhost-user-blk-test.c | 81 +++++++++++++++++++++++++++++--
 1 file changed, 76 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/vhost-user-blk-test.c b/tests/qtest/vhost-user-blk-test.c
index e7e44f9bf0..31f2335f97 100644
--- a/tests/qtest/vhost-user-blk-test.c
+++ b/tests/qtest/vhost-user-blk-test.c
@@ -559,6 +559,67 @@ static void pci_hotplug(void *obj, void *data, QGuestAllocator *t_alloc)
     qpci_unplug_acpi_device_test(qts, "drv1", PCI_SLOT_HP);
 }
 
+static void multiqueue(void *obj, void *data, QGuestAllocator *t_alloc)
+{
+    QVirtioPCIDevice *pdev1 = obj;
+    QVirtioDevice *dev1 = &pdev1->vdev;
+    QVirtioPCIDevice *pdev8;
+    QVirtioDevice *dev8;
+    QTestState *qts = pdev1->pdev->bus->qts;
+    uint64_t features;
+    uint16_t num_queues;
+
+    /*
+     * The primary device has 1 queue and VIRTIO_BLK_F_MQ is not enabled. The
+     * VIRTIO specification allows VIRTIO_BLK_F_MQ to be enabled when there is
+     * only 1 virtqueue, but --device vhost-user-blk-pci doesn't do this (which
+     * is also spec-compliant).
+     */
+    features = qvirtio_get_features(dev1);
+    g_assert_cmpint(features & (1u << VIRTIO_BLK_F_MQ), ==, 0);
+    features = features & ~(QVIRTIO_F_BAD_FEATURE |
+                            (1u << VIRTIO_RING_F_INDIRECT_DESC) |
+                            (1u << VIRTIO_F_NOTIFY_ON_EMPTY) |
+                            (1u << VIRTIO_BLK_F_SCSI));
+    qvirtio_set_features(dev1, features);
+
+    /* Hotplug a secondary device with 8 queues */
+    qtest_qmp_device_add(qts, "vhost-user-blk-pci", "drv1",
+                         "{'addr': %s, 'chardev': 'char2', 'num-queues': 8}",
+                         stringify(PCI_SLOT_HP) ".0");
+
+    pdev8 = virtio_pci_new(pdev1->pdev->bus,
+                           &(QPCIAddress) {
+                               .devfn = QPCI_DEVFN(PCI_SLOT_HP, 0)
+                           });
+    g_assert_nonnull(pdev8);
+    g_assert_cmpint(pdev8->vdev.device_type, ==, VIRTIO_ID_BLOCK);
+
+    qos_object_start_hw(&pdev8->obj);
+
+    dev8 = &pdev8->vdev;
+    features = qvirtio_get_features(dev8);
+    g_assert_cmpint(features & (1u << VIRTIO_BLK_F_MQ),
+                    ==,
+                    (1u << VIRTIO_BLK_F_MQ));
+    features = features & ~(QVIRTIO_F_BAD_FEATURE |
+                            (1u << VIRTIO_RING_F_INDIRECT_DESC) |
+                            (1u << VIRTIO_F_NOTIFY_ON_EMPTY) |
+                            (1u << VIRTIO_BLK_F_SCSI) |
+                            (1u << VIRTIO_BLK_F_MQ));
+    qvirtio_set_features(dev8, features);
+
+    num_queues = qvirtio_config_readw(dev8,
+            offsetof(struct virtio_blk_config, num_queues));
+    g_assert_cmpint(num_queues, ==, 8);
+
+    qvirtio_pci_device_disable(pdev8);
+    qos_object_destroy(&pdev8->obj);
+
+    /* unplug secondary disk */
+    qpci_unplug_acpi_device_test(qts, "drv1", PCI_SLOT_HP);
+}
+
 /*
  * Check that setting the vring addr on a non-existent virtqueue does
  * not crash.
@@ -643,7 +704,8 @@ static void quit_storage_daemon(void *qmp_test_state)
     g_free(qmp_test_state);
 }
 
-static char *start_vhost_user_blk(GString *cmd_line, int vus_instances)
+static char *start_vhost_user_blk(GString *cmd_line, int vus_instances,
+                                  int num_queues)
 {
     const char *vhost_user_blk_bin = qtest_qemu_storage_daemon_binary();
     int fd, qmp_fd, i;
@@ -675,8 +737,8 @@ static char *start_vhost_user_blk(GString *cmd_line, int vus_instances)
         g_string_append_printf(storage_daemon_command,
             "--blockdev driver=file,node-name=disk%d,filename=%s "
             "--export type=vhost-user-blk,id=disk%d,addr.type=unix,addr.path=%s,"
-            "node-name=disk%i,writable=on ",
-            i, img_path, i, sock_path, i);
+            "node-name=disk%i,writable=on,num-queues=%d ",
+            i, img_path, i, sock_path, i, num_queues);
 
         g_string_append_printf(cmd_line, "-chardev socket,id=char%d,path=%s ",
                                i + 1, sock_path);
@@ -705,7 +767,7 @@ static char *start_vhost_user_blk(GString *cmd_line, int vus_instances)
 
 static void *vhost_user_blk_test_setup(GString *cmd_line, void *arg)
 {
-    start_vhost_user_blk(cmd_line, 1);
+    start_vhost_user_blk(cmd_line, 1, 1);
     return arg;
 }
 
@@ -719,7 +781,13 @@ static void *vhost_user_blk_test_setup(GString *cmd_line, void *arg)
 static void *vhost_user_blk_hotplug_test_setup(GString *cmd_line, void *arg)
 {
     /* "-chardev socket,id=char2" is used for pci_hotplug*/
-    start_vhost_user_blk(cmd_line, 2);
+    start_vhost_user_blk(cmd_line, 2, 1);
+    return arg;
+}
+
+static void *vhost_user_blk_multiqueue_test_setup(GString *cmd_line, void *arg)
+{
+    start_vhost_user_blk(cmd_line, 2, 8);
     return arg;
 }
 
@@ -746,6 +814,9 @@ static void register_vhost_user_blk_test(void)
 
     opts.before = vhost_user_blk_hotplug_test_setup;
     qos_add_test("hotplug", "vhost-user-blk-pci", pci_hotplug, &opts);
+
+    opts.before = vhost_user_blk_multiqueue_test_setup;
+    qos_add_test("multiqueue", "vhost-user-blk-pci", multiqueue, &opts);
 }
 
 libqos_init(register_vhost_user_blk_test);
-- 
MST


