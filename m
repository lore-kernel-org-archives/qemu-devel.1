Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA19C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:12:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCB512081A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HPul0Gma"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCB512081A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjlLl-0002NO-2P
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 11:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl37-0000Vl-UG
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:52:53 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49237
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl35-0001a8-AD
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591973570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kF29j1OTXstILIv0rMUhyWfGCjzS5Fq6k2w7s6M2f5A=;
 b=HPul0GmaX72Pez3lHY7zmKKQws9thWrFvSCXY3Ls2UZQYMeoecx63UQHnY1RC0TGF6fUq1
 qc7TwAd7iRFncdg5zfAnAQkFiSG4+GkoQ5SCy/oL4q/4C/ofwN2034Nr4C2GeGML9SCgbs
 Rycq5Xhf7L7Pl/krKoC6zB/JEYqKQ6c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-GeWjsw_VNry1kdInVepOeQ-1; Fri, 12 Jun 2020 10:52:47 -0400
X-MC-Unique: GeWjsw_VNry1kdInVepOeQ-1
Received: by mail-wr1-f69.google.com with SMTP id n6so3999847wrv.6
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 07:52:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=kF29j1OTXstILIv0rMUhyWfGCjzS5Fq6k2w7s6M2f5A=;
 b=F/wdDSQY4tRxCgLubccSrp/lFQBxpH9EKd1hYk2GUBvz3UramCFAa08xfGC5X9a3EI
 zNeC04F1+xmiL7+uPTBhYy5+4n18gO6w8+VNmCE2M84TvdjNj7iaLqfIQ82x0SmVkqDv
 u9vfqQl2IzRfK3Q29lyX0M8w1SUFW29a6HXCqUn2iP5UhyCM0KEttR48iBNXDo6JIrx6
 2zxEj3kt9weFR+nnWXrXU9cATJUteDQosy8MEveReyxKGWOsCYBprzzpSMyXkEV93EpX
 YdNSOhEhPTK49dpadEmheYC9xfhEzPunmS8i880XYOTRqQVeJFBY18vBQoFTa8wbl298
 jxkw==
X-Gm-Message-State: AOAM533jdSlJko87YAgb+X7Ya292ttNXJICIRfj/bzPuEbSz34/bsCa9
 xT4ZMd2+4vRv7AZmypDcWXN0ebrSZn+qFYOo9mReNcNaRA7PuweiQggs2Is/h/LVmmPQGuTii7F
 fPE3oB57nQUTXgME=
X-Received: by 2002:a1c:3c6:: with SMTP id 189mr13554781wmd.81.1591973566077; 
 Fri, 12 Jun 2020 07:52:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzIUN24kRkXTK+qkh9f3ZqA2ipoAKt+lZuazLbr/C1qQRIoO4wwxn/5EVh3B0bqkDcgaC/18g==
X-Received: by 2002:a1c:3c6:: with SMTP id 189mr13554762wmd.81.1591973565845; 
 Fri, 12 Jun 2020 07:52:45 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
 by smtp.gmail.com with ESMTPSA id d17sm11158256wrg.75.2020.06.12.07.52.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 07:52:45 -0700 (PDT)
Date: Fri, 12 Jun 2020 10:52:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 46/58] libvhost-user: advertise vring features
Message-ID: <20200612141917.9446-47-mst@redhat.com>
References: <20200612141917.9446-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200612141917.9446-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 09:30:54
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


