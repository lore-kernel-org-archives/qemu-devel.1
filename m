Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4062AC43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 08:43:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF5AA2078D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 08:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="CMzi9Ix7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF5AA2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGeej-0003sI-UG
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 04:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1kGebX-0005xp-Fm; Fri, 11 Sep 2020 04:40:23 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:46174)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1kGebV-0002GJ-LG; Fri, 11 Sep 2020 04:40:23 -0400
Received: from sas1-ec30c78b6c5b.qloud-c.yandex.net
 (sas1-ec30c78b6c5b.qloud-c.yandex.net
 [IPv6:2a02:6b8:c14:2704:0:640:ec30:c78b])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id C9CD02E1550;
 Fri, 11 Sep 2020 11:40:19 +0300 (MSK)
Received: from sas2-32987e004045.qloud-c.yandex.net
 (sas2-32987e004045.qloud-c.yandex.net [2a02:6b8:c08:b889:0:640:3298:7e00])
 by sas1-ec30c78b6c5b.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id
 rz6eo6z8ph-eIv0t21e; Fri, 11 Sep 2020 11:40:19 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1599813619; bh=WvDaa3hSpu22HYXSrE0AB6SNRFMXv7/ySSV2Yhk7Oqg=;
 h=In-Reply-To:In-Reply-To:Message-Id:References:References:Date:
 Subject:To:From:Cc;
 b=CMzi9Ix71BXiqr8jIBbSbEIOLf6coLrAUaCKxzcC/J292xUZTxaWFDZl04TUSrLBV
 dCfKNs6ydo6ozRtllmjQ+nFQs4k+DE4eVtVbU8dXEUuSe+Xixd6Y/6f0jFxLSRN8Yf
 z7q4IW/eJsmOMg9yCeC0W5JtAFOYOyGQmm/QQiJg=
Authentication-Results: sas1-ec30c78b6c5b.qloud-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b080:7216::1:a])
 by sas2-32987e004045.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 v35icu4tRa-eIlWoU0S; Fri, 11 Sep 2020 11:40:18 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (Client certificate not present)
From: Dima Stepanov <dimastep@yandex-team.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 4/7] tests/qtest/libqos/virtio-blk: add support for
 vhost-user-blk
Date: Fri, 11 Sep 2020 11:39:46 +0300
Message-Id: <4d3e683a87557bcef520826c54aa3e5ab7c64111.1599813294.git.dimastep@yandex-team.ru>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1599813294.git.dimastep@yandex-team.ru>
References: <cover.1599813294.git.dimastep@yandex-team.ru>
In-Reply-To: <cover.1599813294.git.dimastep@yandex-team.ru>
References: <cover.1599813294.git.dimastep@yandex-team.ru>
Received-SPF: pass client-ip=5.45.199.163;
 envelope-from=dimastep@yandex-team.ru; helo=forwardcorp1j.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 04:40:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, lvivier@redhat.com, thuth@redhat.com,
 qemu-block@nongnu.org, mst@redhat.com, stefanha@gmail.com, jasowang@redhat.com,
 dgilbert@redhat.com, mreitz@redhat.com, fengli@smartx.com,
 yc-core@yandex-team.ru, pbonzini@redhat.com, raphael.norwitz@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add support for the vhost-user-blk-pci device. This node can be used by
the vhost-user-blk tests. Tests for the vhost-user-blk device are added
in the following patches.

Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
---
 tests/qtest/libqos/virtio-blk.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/libqos/virtio-blk.c b/tests/qtest/libqos/virtio-blk.c
index 5da0259..c0fd9d2 100644
--- a/tests/qtest/libqos/virtio-blk.c
+++ b/tests/qtest/libqos/virtio-blk.c
@@ -30,7 +30,8 @@
 static void *qvirtio_blk_get_driver(QVirtioBlk *v_blk,
                                     const char *interface)
 {
-    if (!g_strcmp0(interface, "virtio-blk")) {
+    if (!g_strcmp0(interface, "virtio-blk") ||
+            !g_strcmp0(interface, "vhost-user-blk")) {
         return v_blk;
     }
     if (!g_strcmp0(interface, "virtio")) {
@@ -120,6 +121,17 @@ static void virtio_blk_register_nodes(void)
     qos_node_produces("virtio-blk-pci", "virtio-blk");
 
     g_free(arg);
+
+    /* vhost-user-blk-pci */
+    arg = g_strdup_printf("id=drv0,chardev=chdev0,addr=%x.%x",
+                                PCI_SLOT, PCI_FN);
+    opts.extra_device_opts = arg;
+    add_qpci_address(&opts, &addr);
+    qos_node_create_driver("vhost-user-blk-pci", virtio_blk_pci_create);
+    qos_node_consumes("vhost-user-blk-pci", "pci-bus", &opts);
+    qos_node_produces("vhost-user-blk-pci", "vhost-user-blk");
+
+    g_free(arg);
 }
 
 libqos_init(virtio_blk_register_nodes);
-- 
2.7.4


