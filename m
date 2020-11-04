Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466F8C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 05:00:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9984A20BED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 05:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H1b94kJu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9984A20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaAuA-0003ac-GN
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 00:00:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAmB-0006rG-RA
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 23:52:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27046)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAm9-0004lY-0U
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 23:52:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604465520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=APdAnMGOimWpi0/lmUkQSWdNUl1kK18oif2GgMOHc/o=;
 b=H1b94kJuV5Vb5s06X3SIQnWvvlHy8j190kjcHB5arp2yIHn3oxGRVqqkenMxLiMS7kIvWg
 E8HdjtLlXR0Xq2cyzix/eNvP65fI3S+SHJNPOKyN0v6UbldefS1RXvWDPzAtPsTDn385ct
 n3RwFkZkjypFEEdt9ErsGdckG5u5gkI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-csix4jsrOSyhXyJ-pkTWnw-1; Tue, 03 Nov 2020 23:51:58 -0500
X-MC-Unique: csix4jsrOSyhXyJ-pkTWnw-1
Received: by mail-wm1-f70.google.com with SMTP id 8so353004wmg.6
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 20:51:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=APdAnMGOimWpi0/lmUkQSWdNUl1kK18oif2GgMOHc/o=;
 b=porg/kgO/AecjkeV6JQqiI0aJzgs3y0+KKJ0g3YUs+zei+E04hN2XhFvFm+DQs6DSD
 CniwOpCPmTWfGSX6N61tBeAglbx2yVVgyvtRICg/KQ7DQlSPj1JkBbXK6q/6OnUpptlb
 16MIRBzepaxkm9RQqAlStchsKaplS/GUBg6vagkl0x9XUD/UNaKTzgH5r0PjwuD3i/6a
 Ehbz8cDtdt7WVUQwEFAlWQeFnO9eG/nVAuA3keCGaVXxnzKDU+t1Scs7TPh8zoToTFCb
 iWl9jilDxM5Pl30p2KThFzN1B6WdL07De5qgJfPeyXLLW0lEmPqXiEZP2uW1z/lzNIVn
 HD+Q==
X-Gm-Message-State: AOAM5317i6sK8D7NiafiMxjBelxkiLDpr97VoDn2+ddOeqpx36af2G2k
 EkFR719xRHotDD7AqEb9YOwtlUKNFyj5SQgj+iBr565KPVrEH8l3O4jOQ6HC4ERxCVyFzw3+Ar3
 9y/7wDP8Jql3VLpI=
X-Received: by 2002:a7b:cc05:: with SMTP id f5mr318636wmh.123.1604465517128;
 Tue, 03 Nov 2020 20:51:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwVitv4451KFhArVolj6ppqGeiQnZ5Zn6Ci71hiCcrB94xKr7B3Uzrk7dAf6c52g3cGjDRm3A==
X-Received: by 2002:a7b:cc05:: with SMTP id f5mr318619wmh.123.1604465516951;
 Tue, 03 Nov 2020 20:51:56 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id y201sm886172wmd.27.2020.11.03.20.51.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 20:51:56 -0800 (PST)
Date: Tue, 3 Nov 2020 23:51:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 27/38] libvhost-user: follow QEMU comment style
Message-ID: <20201104044937.226370-28-mst@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20201027173528.213464-2-stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 contrib/libvhost-user/libvhost-user.h | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/libvhost-user.h
index 3bbeae8587..a1539dbb69 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -392,7 +392,8 @@ struct VuDev {
     bool broken;
     uint16_t max_queues;
 
-    /* @read_msg: custom method to read vhost-user message
+    /*
+     * @read_msg: custom method to read vhost-user message
      *
      * Read data from vhost_user socket fd and fill up
      * the passed VhostUserMsg *vmsg struct.
@@ -409,15 +410,19 @@ struct VuDev {
      *
      */
     vu_read_msg_cb read_msg;
-    /* @set_watch: add or update the given fd to the watch set,
-     * call cb when condition is met */
+
+    /*
+     * @set_watch: add or update the given fd to the watch set,
+     * call cb when condition is met.
+     */
     vu_set_watch_cb set_watch;
 
     /* @remove_watch: remove the given fd from the watch set */
     vu_remove_watch_cb remove_watch;
 
-    /* @panic: encountered an unrecoverable error, you may try to
-     * re-initialize */
+    /*
+     * @panic: encountered an unrecoverable error, you may try to re-initialize
+     */
     vu_panic_cb panic;
     const VuDevIface *iface;
 
-- 
MST


