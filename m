Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFEAC4363C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 21:33:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6591B23A60
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 21:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ov4RUPjm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6591B23A60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKTRJ-0006Hw-K0
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 17:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1kKTQE-0005fG-Jb
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 17:32:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58908)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1kKTQC-0005HU-To
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 17:32:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600723947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=AmaGFTevTljYUgExxR+nBv5J9s3FJ1UdrnEKjTex4k0=;
 b=Ov4RUPjmAjTAZdRwipf0Mhp9+UL4fHGWs3biCewQc//gcTNKNkSCkN1IQAo9h+aMo4mmVA
 wwwMwihPuulqizZDlE+Lj9l7wNKoz97aRbOkHGsDlxtKmwtF0BGMmd8uNoecNX+EgBbNRF
 zJleP26sGGUnmcTYscY7hsLIZi4l9M4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-fVLC4bm3NZu_ieFI93bvSA-1; Mon, 21 Sep 2020 17:32:23 -0400
X-MC-Unique: fVLC4bm3NZu_ieFI93bvSA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6C71420EA;
 Mon, 21 Sep 2020 21:32:22 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-27.rdu2.redhat.com [10.10.114.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BC76E5C1D0;
 Mon, 21 Sep 2020 21:32:16 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 43D35220C56; Mon, 21 Sep 2020 17:32:16 -0400 (EDT)
Date: Mon, 21 Sep 2020 17:32:16 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: virtio-fs-list <virtio-fs@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH] virtiofsd: Used glib "shared" thread pool
Message-ID: <20200921213216.GE13362@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vgoyal@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:44:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

glib offers thread pools and it seems to support "exclusive" and "shared"
thread pools.

https://developer.gnome.org/glib/stable/glib-Thread-Pools.html#g-thread-pool-new

Currently we use "exlusive" thread pools but its performance seems to be
poor. I tried using "shared" thread pools and performance seems much
better. I posted performance results here.

https://www.redhat.com/archives/virtio-fs/2020-September/msg00080.html

So lets switch to shared thread pools. We can think of making it optional
once somebody can show in what cases exclusive thread pools offer better
results. For now, my simple performance tests across the board see
better results with shared thread pools.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 tools/virtiofsd/fuse_virtio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: qemu/tools/virtiofsd/fuse_virtio.c
===================================================================
--- qemu.orig/tools/virtiofsd/fuse_virtio.c	2020-09-21 17:28:27.444438015 -0400
+++ qemu/tools/virtiofsd/fuse_virtio.c	2020-09-21 17:28:30.584568910 -0400
@@ -695,7 +695,7 @@ static void *fv_queue_thread(void *opaqu
     struct fuse_session *se = qi->virtio_dev->se;
     GThreadPool *pool;
 
-    pool = g_thread_pool_new(fv_queue_worker, qi, se->thread_pool_size, TRUE,
+    pool = g_thread_pool_new(fv_queue_worker, qi, se->thread_pool_size, FALSE,
                              NULL);
     if (!pool) {
         fuse_log(FUSE_LOG_ERR, "%s: g_thread_pool_new failed\n", __func__);


