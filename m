Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EAC3C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:53:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 390242070A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TkdqpEpr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 390242070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k03ZB-0002Nq-Dd
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 09:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k03Vs-0005aD-OG
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 09:49:56 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23847
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k03Vr-0001wh-2u
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 09:49:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595857794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SlYRcRi7Yo9IrPxeu+mUP+g3rj5dPNkuezWzuDEddIw=;
 b=TkdqpEprmcv69rXIsuSypc0oE95Y7qQa39ILStKf6/lndYiK1jExJmBK2flqgR7HZe1YRg
 f0GyFuZBxg1cwkyFNvppp9M1rejFilPOtveCMxq4bH0JqiMo1AlVIPm+MTAT/37bCn9GpB
 87ZDB6O9NtPwCmOKZTlr5OQJXY+dglE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-JA6b0JLENf2o4EATBwhmGg-1; Mon, 27 Jul 2020 09:49:52 -0400
X-MC-Unique: JA6b0JLENf2o4EATBwhmGg-1
Received: by mail-wm1-f71.google.com with SMTP id z74so6543253wmc.4
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 06:49:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=SlYRcRi7Yo9IrPxeu+mUP+g3rj5dPNkuezWzuDEddIw=;
 b=cozG8ovcCP7qc7ofpsgRCL0XtST4V2lq8VFWtPIPPf52xlXBr+XoXOcxzoihQcZZcU
 cCQpvv6LKEnvaED9C+goCO08HUPcjy1AWZ0PsFIoHqkS8VfGMrzeBQbgVHeAEhb05ZZV
 25FCzozXJtD1U3DehvY2Jru9LzV2cviZhZclEEDi/SeDJSdfyWxcwEYJIt2u9TDhbv8H
 exSWmCIxxT4AQkCs39ktohnPJr3wHEI1Ie3s2hr8fP3qBSPbwNboAyVJCCkoif2zOjEf
 HDJjYitK5SNyygDtA3VUXk8+RCu8NM63ImvmG81I0hTIz3yZ1hs3zKb0uy6wzywifIGV
 h1eQ==
X-Gm-Message-State: AOAM53249M+zHgNZ6VJvqKXpeAWoZ3Jf6J9mgVA1OUMimAVknUsy1Orf
 L+ywn+XpxvPzgZFQm837JhBXGcyi4vFhUB4RfAWn53aOFrTPYN0gX2GhSvrH1m0XfvUli5HAYGv
 FzyNA8nH6taHFxJI=
X-Received: by 2002:adf:9c8c:: with SMTP id d12mr20032799wre.369.1595857791077; 
 Mon, 27 Jul 2020 06:49:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzr5EMwKTZ0Jz+dKzgtog9m9+h7xvhRQu/erFzdAYyun6tOWypZ8hoHXo/Rncc8fCcuehGxhw==
X-Received: by 2002:adf:9c8c:: with SMTP id d12mr20032779wre.369.1595857790901; 
 Mon, 27 Jul 2020 06:49:50 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id l67sm19650046wml.13.2020.07.27.06.49.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 06:49:50 -0700 (PDT)
Date: Mon, 27 Jul 2020 09:49:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 5/7] libvhost-user: Report descriptor index on panic
Message-ID: <20200727134614.96376-6-mst@redhat.com>
References: <20200727134614.96376-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200727134614.96376-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:46:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Johannes Berg <johannes.berg@intel.com>, qemu-stable@nongnu.org,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

We want to report the index of the descriptor,
not its pointer.

Fixes: 7b2e5c65f4 ("contrib: add libvhost-user")
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200723171935.18535-1-philmd@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-stable@nongnu.org
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index d315db1396..53f16bdf08 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -2074,7 +2074,7 @@ virtqueue_get_head(VuDev *dev, VuVirtq *vq,
 
     /* If their number is silly, that's a fatal mistake. */
     if (*head >= vq->vring.num) {
-        vu_panic(dev, "Guest says index %u is available", head);
+        vu_panic(dev, "Guest says index %u is available", *head);
         return false;
     }
 
@@ -2133,7 +2133,7 @@ virtqueue_read_next_desc(VuDev *dev, struct vring_desc *desc,
     smp_wmb();
 
     if (*next >= max) {
-        vu_panic(dev, "Desc next is %u", next);
+        vu_panic(dev, "Desc next is %u", *next);
         return VIRTQUEUE_READ_DESC_ERROR;
     }
 
-- 
MST


