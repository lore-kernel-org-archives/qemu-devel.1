Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E99C433E1
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:48:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1EAD20772
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B6OFO5D+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1EAD20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrnCr-0003zW-Vs
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 14:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmw7-0004e6-4d
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:30:51 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51167
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmw5-0001ec-J4
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593887449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p8xQzlc8evAUo7O9syva6ExL2iB8bosWtyuBg9IIFRI=;
 b=B6OFO5D+Vz/J/nlFOGx+WeGNinn0rw537Vynh7FolU2eC7V2dfE/gC8HU2JzAhu4/Y0vPm
 WIgh5JVx3QqrVI7pPls8eCiYAmkcgG/rz4dBcAkydKSgt7aTIqlVL95/h0aH9GGJ2jWBRa
 KvsPEPoDBAws7djAWpEG6rdmyrS2yZk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-UXnnwfpYPKCIAsYCPoYmFw-1; Sat, 04 Jul 2020 14:30:45 -0400
X-MC-Unique: UXnnwfpYPKCIAsYCPoYmFw-1
Received: by mail-wr1-f69.google.com with SMTP id i12so36236114wrx.11
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 11:30:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=p8xQzlc8evAUo7O9syva6ExL2iB8bosWtyuBg9IIFRI=;
 b=VLPMoHn1Rda/dN9WSA8BeA3/Hd+855QkTnj/y8ZOaTfJ2nW4ESnEX9iAyUyOgd2fFZ
 X+RFhULbXx7r7NV/OQxvF2YvS1B2u/1LHmbPbH6uGAfKnM9vQw51mm4j3W8nHffai4uL
 sI/aauo03H+jkuqqmFfR87wjnuGkiUJQ657DXu4ERwsegW46p5ppXwN8P5q0HaXuvqRO
 /c/M0e1JxI1vo9o/OlD8DEAfj3kTXEhALXrR5ymAlZU3pxwycIj5v3ouuHaFaj2952/U
 LwexzTRIdjockgj41SM/HyCuPJ67O8a/uCkxM4pgAXW+jpD+RG0xkP0O05hZoU8co7ju
 x3hg==
X-Gm-Message-State: AOAM530TcXjCXYo4oORQNnnmX5G3T4US06TKDVSRKDKo8zTeqSjXHbOm
 QS5iQaQ1+4+cD3gDZ2MDmyjpSFQxFd3reXtdpTuuGwSjATRBxisDetenA5XsXbVGuQWg5X9yek1
 iuMwP2SjGdjowyLM=
X-Received: by 2002:a5d:6846:: with SMTP id o6mr42103701wrw.370.1593887443873; 
 Sat, 04 Jul 2020 11:30:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+3Ki+T9XV2NXUjwWV99TwYEajjX9+kfSLQN8tzLaLUOvMpv/1reoum1OlKvYxZmRSmpwhXA==
X-Received: by 2002:a5d:6846:: with SMTP id o6mr42103691wrw.370.1593887443701; 
 Sat, 04 Jul 2020 11:30:43 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 t15sm17561762wmj.14.2020.07.04.11.30.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 11:30:43 -0700 (PDT)
Date: Sat, 4 Jul 2020 14:30:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 30/41] virtio-bus: introduce queue_enabled method
Message-ID: <20200704182750.1088103-31-mst@redhat.com>
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
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 08:57:02
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Cindy Lu <lulu@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jason Wang <jasowang@redhat.com>

This patch introduces queue_enabled() method which allows the
transport to implement its own way to report whether or not a queue is
enabled.

Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Cindy Lu <lulu@redhat.com>
Message-Id: <20200701145538.22333-4-lulu@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 include/hw/virtio/virtio-bus.h | 4 ++++
 hw/virtio/virtio.c             | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/include/hw/virtio/virtio-bus.h b/include/hw/virtio/virtio-bus.h
index 38c9399cd4..0f6f215925 100644
--- a/include/hw/virtio/virtio-bus.h
+++ b/include/hw/virtio/virtio-bus.h
@@ -83,6 +83,10 @@ typedef struct VirtioBusClass {
      */
     int (*ioeventfd_assign)(DeviceState *d, EventNotifier *notifier,
                             int n, bool assign);
+    /*
+     * Whether queue number n is enabled.
+     */
+    bool (*queue_enabled)(DeviceState *d, int n);
     /*
      * Does the transport have variable vring alignment?
      * (ie can it ever call virtio_queue_set_align()?)
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index cc9c9dc162..5bd2a2f621 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3286,6 +3286,12 @@ hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n)
 
 bool virtio_queue_enabled(VirtIODevice *vdev, int n)
 {
+    BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
+    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+
+    if (k->queue_enabled) {
+        return k->queue_enabled(qbus->parent, n);
+    }
     return virtio_queue_get_desc_addr(vdev, n) != 0;
 }
 
-- 
MST


