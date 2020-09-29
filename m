Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E80AC4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:28:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C7DF207F7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hRj8MdTU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C7DF207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNA3s-0003Ws-CO
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 03:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9xT-0003RE-5n
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:21:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29137)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9xO-0001ef-Ri
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:21:54 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601364110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/Hogw7T/QnmLtf59Wzlc7OPSCDTBdeKjm88GBrhDZBI=;
 b=hRj8MdTUtXlmQmqF3l6vGF3/wp9TiKs9MVBQt2ent/yV8iDZSr2c1aKbDJzLwd6l7my8V9
 F+TlXQdfnZAAyxUb9DBbCh8axdUQKA/tVWvKzsZ60/YuQVhMNXnlA3AA6JyO2RMtMNwX8P
 iVpgvNrbLdXkqtfFtNLF2D8LHgYRSRs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-FGyYXFG6Om-arPU6lsoTDg-1; Tue, 29 Sep 2020 03:21:47 -0400
X-MC-Unique: FGyYXFG6Om-arPU6lsoTDg-1
Received: by mail-wr1-f69.google.com with SMTP id o6so1364292wrp.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 00:21:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/Hogw7T/QnmLtf59Wzlc7OPSCDTBdeKjm88GBrhDZBI=;
 b=ccdhgA7kjAy8nVSerdvZrvJwUGwQ9RW6KWLG3TyfeAaaAZMOxJRohuoUIQ/DbpHYfM
 W7oKoUuPr/xEBLHdxx7m+YzUxjOKfem/joeloMbVZ1dE17g9PXG1LilqTnax9PYEjSl4
 CNQHccE4GmslJ1de2zWsTaRsCnvTglQE2Zs8BHU6672ck0J3fbNNB3j8cifhA0l8OEcB
 BvgOh8dwkZs30MI2lAc5LGzra1Alv83D5K3pEWba66v4mog9tw16eW9BCwjhCJ34mkjk
 2RZ9EicvVKZm12zAseixO8QfhGI99fQJUBCjplmEAy99BxEPjtXPPByk4TcRJdwRDfFE
 Lo0A==
X-Gm-Message-State: AOAM530R4+qc4qqwXq0KlntV1QCjhXGlpg0hczxpYcpl91xX9SETuHg2
 YBwOB/t2VqF1oyodcdphhttDaNTu9hUU9on1P8Q23FxYrQpIcNyKGo6kfoEab28G+ItUmUlYRvj
 lr9Yk1mDE4DCknMI=
X-Received: by 2002:a7b:c753:: with SMTP id w19mr2872216wmk.157.1601364105739; 
 Tue, 29 Sep 2020 00:21:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzltlsRSEYdMW5aNyk4rcSHrNsrbulbMUcC6c+XIsRAqtRK4LfPWke2U/JppE4yqYen9cQMEQ==
X-Received: by 2002:a7b:c753:: with SMTP id w19mr2872195wmk.157.1601364105538; 
 Tue, 29 Sep 2020 00:21:45 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id v204sm4360003wmg.20.2020.09.29.00.21.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 00:21:44 -0700 (PDT)
Date: Tue, 29 Sep 2020 03:21:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v4 19/48] vhost-vsock-ccw: force virtio version 1
Message-ID: <20200929071948.281157-20-mst@redhat.com>
References: <20200929071948.281157-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200929071948.281157-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-stable@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>, Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefano Garzarella <sgarzare@redhat.com>

virtio-vsock was introduced after the release of VIRTIO 1.0
specifications, so it should be 'modern-only'.

This patch forces virtio version 1 as done for vhost-vsock-pci.

To avoid migration issues, we force virtio version 1 only when
legacy check is enabled in the new machine types (>= 5.1).

Cc: qemu-stable@nongnu.org
Suggested-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20200921122506.82515-5-sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/s390x/vhost-vsock-ccw.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/s390x/vhost-vsock-ccw.c b/hw/s390x/vhost-vsock-ccw.c
index 0822ecca89..246416a8f9 100644
--- a/hw/s390x/vhost-vsock-ccw.c
+++ b/hw/s390x/vhost-vsock-ccw.c
@@ -40,9 +40,21 @@ static void vhost_vsock_ccw_class_init(ObjectClass *klass, void *data)
 static void vhost_vsock_ccw_instance_init(Object *obj)
 {
     VHostVSockCCWState *dev = VHOST_VSOCK_CCW(obj);
+    VirtioCcwDevice *ccw_dev = VIRTIO_CCW_DEVICE(obj);
+    VirtIODevice *virtio_dev;
 
     virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
                                 TYPE_VHOST_VSOCK);
+
+    virtio_dev = VIRTIO_DEVICE(&dev->vdev);
+
+    /*
+     * To avoid migration issues, we force virtio version 1 only when
+     * legacy check is enabled in the new machine types (>= 5.1).
+     */
+    if (!virtio_legacy_check_disabled(virtio_dev)) {
+        ccw_dev->force_revision_1 = true;
+    }
 }
 
 static const TypeInfo vhost_vsock_ccw_info = {
-- 
MST


