Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E96BC55178
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 04:53:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 277CE22243
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 04:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Et04BCcf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277CE22243
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaAno-0001ie-6H
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 23:53:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAm0-0006Vv-Mt
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 23:51:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47322)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAly-0004i5-Uq
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 23:51:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604465510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Try6I8+Gzp362j90+uCp08fdMyiL5wC2Bsqj8twh+n4=;
 b=Et04BCcfpAhX8Js1zFMDzE+PxMfDbQsfb7q3/oihujBQvPYE/Vu6XUjkYX+Jc6bLl9XNVy
 NDrMr1X1qP3F96uv9y27v4CCH6szPUp7KuH01zJLexh66hFW+/9I1aila7+2LlgJ0JHNGE
 vcxgkaosaPyIHh5fYphR0va6sY4Y47U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-8v1fAzpSPo2bMxLUT_LIdQ-1; Tue, 03 Nov 2020 23:51:48 -0500
X-MC-Unique: 8v1fAzpSPo2bMxLUT_LIdQ-1
Received: by mail-wr1-f71.google.com with SMTP id t14so8789357wrs.2
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 20:51:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Try6I8+Gzp362j90+uCp08fdMyiL5wC2Bsqj8twh+n4=;
 b=AsWXDeDmCnyUZAU+eKyRaTyW5ftFwaoETghw9p9wTiWLwnpKu2+mRo++99rDzPF1zO
 UlpVwSKc8KaYdxT06g9l2umDLdeLmCB1sMVDIy7DmqzGrPBF6KaxSKrsVU4DmvlrWJiV
 FXULFEuCWvm/9eGPaNDzgyQ9A2gwOIGvVfvbipgjml8HPsKKM/1KOg+Bz0NsDsiPmIrx
 YPrQEat/T75cxOcVuK3LlEJ+3vnd9qyQE7M4O0pZ7z2mI0MPLWoykXid+VXy9N/opyIf
 ObJzGu81VBU3J8vMXAbUN+6kaCzjQjf3DU0CMFGpMAOHfDG7RMWrt2iAWAlGtimz0aWZ
 V3/Q==
X-Gm-Message-State: AOAM532C0+Lx1XBsMdeE9Ht9MC3eA82AgISRmpxbHIpXSSmBkfY+/Psn
 6MxcdpM1l4AQTr44ZZoqehJvbIjUdCtzqqtCIk9ZfBSX7Zpr3T+6ZB7EMkeVP8CqrltDSG9QQRw
 ID1jQ2xYxnfE6mYQ=
X-Received: by 2002:a5d:4ed2:: with SMTP id s18mr29556073wrv.36.1604465506457; 
 Tue, 03 Nov 2020 20:51:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzkC41vEDkSjBzdc5GdhMzxiDNqIdGrNXQ+nOWqCwh93E8qMJx3YdMRIzizvN4ZQjUvOvuvRA==
X-Received: by 2002:a5d:4ed2:: with SMTP id s18mr29556061wrv.36.1604465506336; 
 Tue, 03 Nov 2020 20:51:46 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id l124sm793759wml.48.2020.11.03.20.51.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 20:51:45 -0800 (PST)
Date: Tue, 3 Nov 2020 23:51:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 23/38] vhost-vdpa: Add qemu_close in vhost_vdpa_cleanup
Message-ID: <20201104044937.226370-24-mst@redhat.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Cindy Lu <lulu@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cindy Lu <lulu@redhat.com>

fix the bug that fd will still open after the cleanup

Signed-off-by: Cindy Lu <lulu@redhat.com>
Message-Id: <20201016030909.9522-1-lulu@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 99c476db8c..fe659ec9e2 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -145,6 +145,10 @@ static void vhost_vdpa_cleanup(NetClientState *nc)
         g_free(s->vhost_net);
         s->vhost_net = NULL;
     }
+     if (s->vhost_vdpa.device_fd >= 0) {
+        qemu_close(s->vhost_vdpa.device_fd);
+        s->vhost_vdpa.device_fd = -1;
+    }
 }
 
 static bool vhost_vdpa_has_vnet_hdr(NetClientState *nc)
-- 
MST


