Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FDFC43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 11:44:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AA9520EDD
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 11:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ekBOn+UX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AA9520EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKKF3-00010j-2W
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 07:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kKK1J-0002zP-UR
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 07:30:11 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26764
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kKK1I-0000kn-20
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 07:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600687807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cQLHX1DoJKJj5W3DVopK1pVavkbFhdLI78v3G2Q4YW4=;
 b=ekBOn+UXZ95i9bhy6sPC2cKbghpn1u7NU4OYhgrw58BfeFGxn7lhsnbuGurycj8hdZoUMn
 csEpxQZdDcUFTNL75LWKWux6ciko//7Edg6/tEIoPOWq0H+rGKrl4fPRjoKnxzXEH1KAIq
 /Sz39eZ86ijnIkT3F/03tbvSEveDs6E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-aSiBmOz0MaG5Ir9Un5Z6TQ-1; Mon, 21 Sep 2020 07:30:05 -0400
X-MC-Unique: aSiBmOz0MaG5Ir9Un5Z6TQ-1
Received: by mail-wm1-f72.google.com with SMTP id m25so3630244wmi.0
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 04:30:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=cQLHX1DoJKJj5W3DVopK1pVavkbFhdLI78v3G2Q4YW4=;
 b=TjdeHw319HFI4AlnmRxlsMo/clpzqsr8mCx7qh55WR6wCtlPkTeMdPZ3xtTuoiP2Qj
 y6K+dJUBDsWxDx5Z1jqMb4U3XY7+zp0dLeGLkdA2c10B9AnzLq8chn1YuvKAz1yMpBUJ
 wi/C7o+HRjcEnA7S4vPJNdDngWngJ2ZHunhg/aI/NzSD7njQYw92wNhQr1pGAdkagkor
 nTUeOLqxrFkkUmugvrWzBbAgbNYfJgmkx6eynW4zzoqdLz9DqNJflckmpy1QuT529D7k
 z2ciqcT5gGCY2F88ioeF+Qb25VqzHLZf7T9xQ8VzkrXZ7H7YVCKtjAYHaDJc74cTrROT
 r1Ug==
X-Gm-Message-State: AOAM532yc2lYw/KSy7kID6VUq/EYJ/nIoE3v1z6I+FlaYskowQjvZjUL
 UjHDxa3N2H5Pyi4hnbeWcq5S3hxOwHF04e3meQnBjhuSVq3ZeY8tjmVOL1XktVKt5nfToVM9R4/
 DBCP1mWmxh26LC+M=
X-Received: by 2002:a1c:8115:: with SMTP id c21mr30483530wmd.153.1600687803700; 
 Mon, 21 Sep 2020 04:30:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrRbMEGccnhmsiFdwd8VU4AetpjDNRf6etteU7xNpH3LPY3MJVgNqm50bsUrqvhC03DzHYpA==
X-Received: by 2002:a1c:8115:: with SMTP id c21mr30483504wmd.153.1600687803559; 
 Mon, 21 Sep 2020 04:30:03 -0700 (PDT)
Received: from redhat.com (bzq-109-65-116-225.red.bezeqint.net.
 [109.65.116.225])
 by smtp.gmail.com with ESMTPSA id u186sm19575150wmu.34.2020.09.21.04.30.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2020 04:30:02 -0700 (PDT)
Date: Mon, 21 Sep 2020 07:30:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 09/15] tests/qtest/libqos/virtio-blk: add support for
 vhost-user-blk
Message-ID: <20200921112913.555392-10-mst@redhat.com>
References: <20200921112913.555392-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200921112913.555392-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 03:43:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Dima Stepanov <dimastep@yandex-team.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Dima Stepanov <dimastep@yandex-team.ru>

Add support for the vhost-user-blk-pci device. This node can be used by
the vhost-user-blk tests. Tests for the vhost-user-blk device are added
in the following patches.

Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
Message-Id: <4d3e683a87557bcef520826c54aa3e5ab7c64111.1599813294.git.dimastep@yandex-team.ru>
Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/libqos/virtio-blk.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/libqos/virtio-blk.c b/tests/qtest/libqos/virtio-blk.c
index 5da02591bc..c0fd9d24e3 100644
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
MST


