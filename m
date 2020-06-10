Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EC5C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:51:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FD202072E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dcr5Ria/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FD202072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jishp-0007aL-IC
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 00:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisLh-0001fS-I7
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:28:25 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26121
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisLg-0008Mz-IX
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:28:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591763303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kF29j1OTXstILIv0rMUhyWfGCjzS5Fq6k2w7s6M2f5A=;
 b=Dcr5Ria/4KgoQ8A4I3oe62zu+vn9R9ScSqvmpAs59nAyWnx34gxsI3aOsQ3o4O+BInZEmN
 teEhUJ8NJwcfj49/R+87sVKi6rzwc/FPMNjFUD9tdRhcz8iUapAAqmW2Zc2N4zmgwqJFdG
 x/UOJge1An6p5sjC8u69GvFCrN5HOsA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-hbDllxHJNlC_z9ZZxxHIJg-1; Wed, 10 Jun 2020 00:28:20 -0400
X-MC-Unique: hbDllxHJNlC_z9ZZxxHIJg-1
Received: by mail-wr1-f70.google.com with SMTP id s17so510332wrt.7
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 21:28:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=kF29j1OTXstILIv0rMUhyWfGCjzS5Fq6k2w7s6M2f5A=;
 b=s3ZmrJQJIKpx5Q6sAkJ8IvOhCTXHfZ2Bfdy8/UzVS/mbGBoaCOh7AhhUE67vRaNPID
 yhrZ5IJ+XwLV4pXfVHctXTknzi3qnGUpdLGaXuVpPSO3UxkdGCxtsylEgkVWF4ahIJ3l
 KlB5upyftHALSfZzM18sSihaJH88ytwqb46VB9/r5/nn3TVALOyhpyeZg54A199YEeqA
 rpd6lnpVyDVWDNjZC2HBjOKZ0y6PTCE9tnYuLqBK19Mcw1vnQzJnutsXEp4jT5V9XjPZ
 TVcHUgVvjsoe5LRq/0qQWDFNkYbpMtG2Dqy+QuNLr77a6VG/XYsKyuy+4sAy3OzFz6MY
 7j1w==
X-Gm-Message-State: AOAM530chejK5BBThXN10iaWZqE6cM9NhPA+koZLe1VjdQZvuEPrWbqA
 X4avkTPjcP16oQRZMJSo1QCngKEgoA6Z/mwzImQHjvW1Q7SxTolpwtpWPmnArZXa3k+x6qsrZPJ
 EVGPeEKZ2G76yVPM=
X-Received: by 2002:adf:fec8:: with SMTP id q8mr1403757wrs.2.1591763299420;
 Tue, 09 Jun 2020 21:28:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyuWUNdJPmvwpY1lC4BaLcP+xBRe7LzeYyXbmI3ke37sxssnnG0zaSwqsWjQkHTdLh3bRQDlg==
X-Received: by 2002:adf:fec8:: with SMTP id q8mr1403735wrs.2.1591763299251;
 Tue, 09 Jun 2020 21:28:19 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id o20sm6345357wra.29.2020.06.09.21.28.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 21:28:18 -0700 (PDT)
Date: Wed, 10 Jun 2020 00:28:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 46/56] libvhost-user: advertise vring features
Message-ID: <20200610042613.1459309-47-mst@redhat.com>
References: <20200610042613.1459309-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200610042613.1459309-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:22:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

libvhost-user implements several vring features without advertising
them. There is no way for the vhost-user master to detect support for
these features.

Things more or less work today because QEMU assumes the vhost-user
backend always implements certain feature bits like
VIRTIO_RING_F_EVENT_IDX. This is not documented anywhere.

This patch explicitly advertises features implemented in libvhost-user
so that the vhost-user master does not need to make undocumented
assumptions.

Feature bits that libvhost-user now advertises can be removed from
vhost-user-blk.c. Devices should not be responsible for advertising
vring feature bits, that is libvhost-user's job.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20200529161338.456017-1-stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c   | 10 ++++++++++
 contrib/vhost-user-blk/vhost-user-blk.c |  4 +---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index b1e607298c..d315db1396 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -498,6 +498,16 @@ static bool
 vu_get_features_exec(VuDev *dev, VhostUserMsg *vmsg)
 {
     vmsg->payload.u64 =
+        /*
+         * The following VIRTIO feature bits are supported by our virtqueue
+         * implementation:
+         */
+        1ULL << VIRTIO_F_NOTIFY_ON_EMPTY |
+        1ULL << VIRTIO_RING_F_INDIRECT_DESC |
+        1ULL << VIRTIO_RING_F_EVENT_IDX |
+        1ULL << VIRTIO_F_VERSION_1 |
+
+        /* vhost-user feature bits */
         1ULL << VHOST_F_LOG_ALL |
         1ULL << VHOST_USER_F_PROTOCOL_FEATURES;
 
diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-user-blk/vhost-user-blk.c
index 6fd91c7e99..25eccd02b5 100644
--- a/contrib/vhost-user-blk/vhost-user-blk.c
+++ b/contrib/vhost-user-blk/vhost-user-blk.c
@@ -382,9 +382,7 @@ vub_get_features(VuDev *dev)
                1ull << VIRTIO_BLK_F_DISCARD |
                1ull << VIRTIO_BLK_F_WRITE_ZEROES |
                #endif
-               1ull << VIRTIO_BLK_F_CONFIG_WCE |
-               1ull << VIRTIO_F_VERSION_1 |
-               1ull << VHOST_USER_F_PROTOCOL_FEATURES;
+               1ull << VIRTIO_BLK_F_CONFIG_WCE;
 
     if (vdev_blk->enable_ro) {
         features |= 1ull << VIRTIO_BLK_F_RO;
-- 
MST


