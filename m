Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD83DC4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:40:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C19F206DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LHjyjFJo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C19F206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNAFS-0004DR-LN
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 03:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9y6-0004IY-7o
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:22:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58677)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9y3-0001m2-ED
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:22:33 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601364149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IvSRqOV7AyzLJJ7CwX/r6Msv2rBJl4LszOMA3rdKsI8=;
 b=LHjyjFJo2L/GZr6UaMPPXiF1NaxXQss13X2GCuqS8UZXFN4zj+P+ndGmA/2LU9Ue87M+9M
 xQ7qDjhJvcuWogFXsP5mIuuGkE3DJs8WSgp42/5nap/YqDgI1bCqCsnNB44EctRlqlvcz+
 6fm/6uTa9KxYUliBiba5suQ3ZQQC18Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-h7j-MmaGPN-a3qFar59Rmg-1; Tue, 29 Sep 2020 03:22:27 -0400
X-MC-Unique: h7j-MmaGPN-a3qFar59Rmg-1
Received: by mail-wm1-f69.google.com with SMTP id a7so1463220wmc.2
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 00:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=IvSRqOV7AyzLJJ7CwX/r6Msv2rBJl4LszOMA3rdKsI8=;
 b=b5ybGfiBxf9ZrfQ+efaGBv4OfFIRvsPNFy3UsYCxoT5nB0d1gD1Y9Kur11sOvDhWg4
 wtbWiOsw++esM0IPAayHpxEExu0+RXRo89YITmcSKr/RsPtJst9dE+G8fq86d8ZdC3Be
 TFNvvkBBlw76NmzUoeKeJ4KJ08qbISPvRTooOlH8WZaoGE4e43QdyxcRYDqVGb91HCOT
 iAeesD1K4nXGZ4T4YLMSZCKHXeSx1nM6lPIveC4SX5FaFmwMuPOlCu5v0i06eWVzAhtD
 p2Qi5FEv98aWc+R/OJlheEG3qpqCkOUKbpPKifDV4d6j1p+wQaOSjxfx4MawzdP4VAhO
 YVeQ==
X-Gm-Message-State: AOAM532jiYCZrCTMlvokKD8vl0JQUtEXj9NZr0I4mYCVV98GEsEsGin3
 /0gTptXYtlbD5ySTBoexD/mTGWoKEJ6dpIxFf73g31e/srjrUb0bAxFQezVUwzvRJTE/xWf6B+f
 5VH2t+yM9TC6zbOU=
X-Received: by 2002:a5d:5281:: with SMTP id c1mr2538273wrv.184.1601364145669; 
 Tue, 29 Sep 2020 00:22:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNlhYxI6UECrpLOVhbDMNQCUnQ4KKKdG9GdxYE1jDeVR4ZgNN0hEoqpABFe28BQVnnnS9huw==
X-Received: by 2002:a5d:5281:: with SMTP id c1mr2538252wrv.184.1601364145463; 
 Tue, 29 Sep 2020 00:22:25 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id y1sm4342644wmi.36.2020.09.29.00.22.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 00:22:24 -0700 (PDT)
Date: Tue, 29 Sep 2020 03:22:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v4 34/48] vhost-user: save features of multiqueues if chardev
 is closed
Message-ID: <20200929071948.281157-35-mst@redhat.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 =?utf-8?B?aGFpYmluemhhbmco5byg5rW35paMKQ==?= <haibinzhang@tencent.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: haibinzhang(张海斌) <haibinzhang@tencent.com>

Fore-commit(c6beefd674) only saves features of queue0,
this makes wrong features of other queues in multiqueues
situation.
For examples:
  qemu-system-aarch64 ... \
  -chardev socket,id=charnet0,path=/var/run/vhost_sock \
  -netdev vhost-user,chardev=charnet0,queues=2,id=hostnet0 \
  ...
There are two queues in nic assocated with one chardev.
When chardev is reconnected, it is necessary to save and
restore features of all queues.

Signed-of-by: Haibin Zhang <haibinzhang@tencent.com>
Message-Id: <46CBC206-E0CA-4249-81CD-10F75DA30441@tencent.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-user.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/vhost-user.c b/net/vhost-user.c
index 17532daaf3..ffbd94d944 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -226,7 +226,7 @@ static void chr_closed_bh(void *opaque)
     NetClientState *ncs[MAX_QUEUE_NUM];
     NetVhostUserState *s;
     Error *err = NULL;
-    int queues;
+    int queues, i;
 
     queues = qemu_find_net_clients_except(name, ncs,
                                           NET_CLIENT_DRIVER_NIC,
@@ -235,8 +235,12 @@ static void chr_closed_bh(void *opaque)
 
     s = DO_UPCAST(NetVhostUserState, nc, ncs[0]);
 
-    if (s->vhost_net) {
-        s->acked_features = vhost_net_get_acked_features(s->vhost_net);
+    for (i = queues -1; i >= 0; i--) {
+        s = DO_UPCAST(NetVhostUserState, nc, ncs[i]);
+
+        if (s->vhost_net) {
+            s->acked_features = vhost_net_get_acked_features(s->vhost_net);
+        }
     }
 
     qmp_set_link(name, false, &err);
-- 
MST


