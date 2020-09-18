Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7022C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:09:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 198872395C
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dgCGo7i5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 198872395C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJI0X-0001iu-St
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 11:09:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kJHy2-0006cF-CA
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 11:06:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32500
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kJHxx-0000ZJ-N8
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 11:06:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600441582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eNjevSPQ6R0xqmmfoOyjpswokZGIHXQPWEYyjWczdt0=;
 b=dgCGo7i54OriYfYsF1j9u4Z8WnVkBujMovExKqJWUH2+ROho5Nvg4vqPUw6uVR0uUOKbxf
 BegC5g1YLKkzXOSIocxJAkf/DWiV4ENdgiVbPDMqbj7/jWP9I1sktDDsws9kPS0efPLleA
 Il2/6fCFUQdWqJ+Axd+REg1pgMHNKRQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-k8lSkUFuMTy3bqQfbhCAhQ-1; Fri, 18 Sep 2020 11:06:17 -0400
X-MC-Unique: k8lSkUFuMTy3bqQfbhCAhQ-1
Received: by mail-wm1-f72.google.com with SMTP id a25so1560438wmb.2
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 08:06:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=eNjevSPQ6R0xqmmfoOyjpswokZGIHXQPWEYyjWczdt0=;
 b=Qx3giyyxaHwEdFUnremxBXaSHgouzr8wbVI5o8oe6dNVo+ePCF9tngEJPPXR2pweRk
 iPZiy0+QJCzGaScCvxMof/rJg4bhJR206vI761rK7RiqqFli8BWzj0YDjKyF75NmuCoh
 NJdzfmIgqJZ8mGz1++ANsFQwG/oQWDwdzBCRfNTUDtaUN1mdmcPP4afg2JNCcfXdvJhp
 1ocdZoTXwL+ukEYGas/cBsGBaSbilpXKILvKrtReGyNFgwXHJYsw5f4D026MHXF0zFNj
 TL218AT/W5+r5KUu2+7ATu7g4Fz6ZvmDn+nbTqutes51+pCroTsnkl9l+sFG5SzyLJUG
 vACg==
X-Gm-Message-State: AOAM531AHCaMbyAasjMV9BweDWQxVD9tvECyZ0K3jrl9807cSo9Pl8pa
 SPDSxgJhH86wFCMqNtQvluiDrv47N1xRkWcgeuBqwWmwcr0IshmOsF+PiiCLk2SdXn06jrEZrlS
 N5Hm+mgEUgN3rjqo=
X-Received: by 2002:a1c:7912:: with SMTP id l18mr16001092wme.124.1600441575398; 
 Fri, 18 Sep 2020 08:06:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvaDVoS5HmvayC4gb29hj45kW67SS7bSYiBnAycJGvKG+yyq5qW65SJKFQdItgGRR96LFpSg==
X-Received: by 2002:a1c:7912:: with SMTP id l18mr16001065wme.124.1600441575175; 
 Fri, 18 Sep 2020 08:06:15 -0700 (PDT)
Received: from redhat.com (bzq-109-65-116-225.red.bezeqint.net.
 [109.65.116.225])
 by smtp.gmail.com with ESMTPSA id a10sm5349670wmj.38.2020.09.18.08.06.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 08:06:14 -0700 (PDT)
Date: Fri, 18 Sep 2020 11:06:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/15] tests/qtest/libqos/virtio-blk: add support for
 vhost-user-blk
Message-ID: <20200918150506.286890-10-mst@redhat.com>
References: <20200918150506.286890-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200918150506.286890-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 03:47:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
 Dima Stepanov <dimastep@yandex-team.ru>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Dima Stepanov <dimastep@yandex-team.ru>

Add support for the vhost-user-blk-pci device. This node can be used by
the vhost-user-blk tests. Tests for the vhost-user-blk device are added
in the following patches.

Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
Message-Id: <50d827a7b383de531ac1452e1e0ce3ad961d00af.1598865610.git.dimastep@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/libqos/virtio-blk.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tests/qtest/libqos/virtio-blk.c b/tests/qtest/libqos/virtio-blk.c
index 5da02591bc..959c5dce18 100644
--- a/tests/qtest/libqos/virtio-blk.c
+++ b/tests/qtest/libqos/virtio-blk.c
@@ -36,6 +36,9 @@ static void *qvirtio_blk_get_driver(QVirtioBlk *v_blk,
     if (!g_strcmp0(interface, "virtio")) {
         return v_blk->vdev;
     }
+    if (!g_strcmp0(interface, "vhost-user-blk")) {
+        return v_blk;
+    }
 
     fprintf(stderr, "%s not present in virtio-blk-device\n", interface);
     g_assert_not_reached();
@@ -120,6 +123,17 @@ static void virtio_blk_register_nodes(void)
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


