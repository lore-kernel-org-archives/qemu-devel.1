Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A21BC47420
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:57:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2C3D20773
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jMyqSTEp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2C3D20773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNAVR-0004iR-Ka
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 03:57:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kNA1p-00019K-OE
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:26:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57345)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kNA1n-0002eZ-Mt
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:26:25 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601364383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zmse96ix9uI8MiyDpIwEzkgRhtE5hIeu3p6tVRZ90cA=;
 b=jMyqSTEpN7y/tyHV3xcyOVNajg6RqNm95/WfGJNRP5Iv9jdhJ4dbc5FxJUeubINErjQEBj
 B4H16dgeDi4Y0L/jLdI9TV9xse1+AiD2Bs7Q5btdhUrn/Tc4Ot9kVj4gVk2/6eSiRAxyeQ
 lJeXKQsFAhJSzL3Pgs965iBnauYwUYM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-A7_EiXG3M0CU0BNSCdQw7g-1; Tue, 29 Sep 2020 03:23:12 -0400
X-MC-Unique: A7_EiXG3M0CU0BNSCdQw7g-1
Received: by mail-wr1-f69.google.com with SMTP id v5so1385605wrr.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 00:23:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=zmse96ix9uI8MiyDpIwEzkgRhtE5hIeu3p6tVRZ90cA=;
 b=pElhEvtJ0wPb8ivNp0IxZQYrkZ04yMqWwhDqrUv6arq1GnZG28sc6/nUhDmyRQuc0G
 9vIWy/d3UTCmbhE8+oOHm+n6+uymyFXMmrgQ4uqTVhCUVqEW9RcMNmDnERVzM4UYldJ2
 b6x+JvRAnQ7JH0Y366pZ3aB78aLQVHR37DmduapyI3SCQcKR7Y5K8CRJh8OyuVunVC76
 U3L+XwFEgBIWi8i4vmanHTgeYBz4d7ZOazvjA/cLW+M1gEO84BfYsfe5d9enUC0g7L2B
 maWaSeu1lRzXWNd3ZNS+CQusrxhV4AlNx5SbWRFCz73oMzyCg5y4Z8+RaiNn705+PPA5
 VAhw==
X-Gm-Message-State: AOAM531BvTAvbAVAKrE0+Ww3N09D5hgcqivp9GBseGBMPnLiEDqIvMs8
 EFuwhHkHWExY8nQTCYS6lMhL5BDcAqc6hhhNhbxdjyFqZPd1P2ah25bYEJPIK0c4vCAohgFU22F
 CjIFKCRgMZycaQNk=
X-Received: by 2002:a5d:530f:: with SMTP id e15mr2473784wrv.51.1601364191345; 
 Tue, 29 Sep 2020 00:23:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwfN7S9CdOeW0yRVVqZyMhOntnqzkC1QEbVNbny+8Oz1mn4sZgjVlsQxHP7XCjZa9B1WsfCQ==
X-Received: by 2002:a5d:530f:: with SMTP id e15mr2473764wrv.51.1601364191159; 
 Tue, 29 Sep 2020 00:23:11 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id 88sm5118664wrl.76.2020.09.29.00.23.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 00:23:10 -0700 (PDT)
Date: Tue, 29 Sep 2020 03:23:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v4 47/48] libvhost-user: return early on virtqueue errors
Message-ID: <20200929071948.281157-48-mst@redhat.com>
References: <20200929071948.281157-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200929071948.281157-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

vu_panic() is not guaranteed to exit the program. Return early when
errors are encountered.

Note that libvhost-user does not have an "unmap" operation for mapped
descriptors. Therefore it is correct to return without explicit cleanup.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20200921113420.154378-2-stefanha@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index 70055c98b7..4ebfa4cc40 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -2416,7 +2416,7 @@ vu_queue_set_notification(VuDev *dev, VuVirtq *vq, int enable)
     }
 }
 
-static void
+static bool
 virtqueue_map_desc(VuDev *dev,
                    unsigned int *p_num_sg, struct iovec *iov,
                    unsigned int max_num_sg, bool is_write,
@@ -2428,7 +2428,7 @@ virtqueue_map_desc(VuDev *dev,
 
     if (!sz) {
         vu_panic(dev, "virtio: zero sized buffers are not allowed");
-        return;
+        return false;
     }
 
     while (sz) {
@@ -2436,13 +2436,13 @@ virtqueue_map_desc(VuDev *dev,
 
         if (num_sg == max_num_sg) {
             vu_panic(dev, "virtio: too many descriptors in indirect table");
-            return;
+            return false;
         }
 
         iov[num_sg].iov_base = vu_gpa_to_va(dev, &len, pa);
         if (iov[num_sg].iov_base == NULL) {
             vu_panic(dev, "virtio: invalid address for buffers");
-            return;
+            return false;
         }
         iov[num_sg].iov_len = len;
         num_sg++;
@@ -2451,6 +2451,7 @@ virtqueue_map_desc(VuDev *dev,
     }
 
     *p_num_sg = num_sg;
+    return true;
 }
 
 static void *
@@ -2488,6 +2489,7 @@ vu_queue_map_desc(VuDev *dev, VuVirtq *vq, unsigned int idx, size_t sz)
     if (lduw_le_p(&desc[i].flags) & VRING_DESC_F_INDIRECT) {
         if (ldl_le_p(&desc[i].len) % sizeof(struct vring_desc)) {
             vu_panic(dev, "Invalid size for indirect buffer table");
+            return NULL;
         }
 
         /* loop over the indirect descriptor table */
@@ -2515,22 +2517,29 @@ vu_queue_map_desc(VuDev *dev, VuVirtq *vq, unsigned int idx, size_t sz)
     /* Collect all the descriptors */
     do {
         if (lduw_le_p(&desc[i].flags) & VRING_DESC_F_WRITE) {
-            virtqueue_map_desc(dev, &in_num, iov + out_num,
+            if (!virtqueue_map_desc(dev, &in_num, iov + out_num,
                                VIRTQUEUE_MAX_SIZE - out_num, true,
-                               ldq_le_p(&desc[i].addr), ldl_le_p(&desc[i].len));
+                               ldq_le_p(&desc[i].addr),
+                               ldl_le_p(&desc[i].len))) {
+                return NULL;
+            }
         } else {
             if (in_num) {
                 vu_panic(dev, "Incorrect order for descriptors");
                 return NULL;
             }
-            virtqueue_map_desc(dev, &out_num, iov,
+            if (!virtqueue_map_desc(dev, &out_num, iov,
                                VIRTQUEUE_MAX_SIZE, false,
-                               ldq_le_p(&desc[i].addr), ldl_le_p(&desc[i].len));
+                               ldq_le_p(&desc[i].addr),
+                               ldl_le_p(&desc[i].len))) {
+                return NULL;
+            }
         }
 
         /* If we've got too many, that implies a descriptor loop. */
         if ((in_num + out_num) > max) {
             vu_panic(dev, "Looped descriptor");
+            return NULL;
         }
         rc = virtqueue_read_next_desc(dev, desc, i, max, &i);
     } while (rc == VIRTQUEUE_READ_DESC_MORE);
-- 
MST


