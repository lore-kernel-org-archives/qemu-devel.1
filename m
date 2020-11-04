Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFCEC4741F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 04:58:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2A5820BED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 04:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K76xfGPU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A5820BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaAsk-0000CC-PD
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 23:58:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAm3-0006ba-NZ
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 23:51:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27417)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAm1-0004j8-HR
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 23:51:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604465512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MaK8aBvBSiaUINk0iflL/mAr7Ti2mM7e4TQ+bKVJ1uk=;
 b=K76xfGPUUSbvGvNw5sSXU7YAZu+g1/d3FRLi/ZuBtUb61TUK2T5p4AcAk7kKkPn0hCnOTb
 qnorTR+5tal2BX/JJjiPRe+PYBPUVB5G6fSQh00m92eY0O2vBwvKBX7JLoIwD7lYNM0SjB
 ikpaDILNxt+VLksjHt2BMDr+zPlNF3c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-1nildKkpPVCljtPkapJE9A-1; Tue, 03 Nov 2020 23:51:50 -0500
X-MC-Unique: 1nildKkpPVCljtPkapJE9A-1
Received: by mail-wr1-f71.google.com with SMTP id w1so8715547wrr.5
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 20:51:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=MaK8aBvBSiaUINk0iflL/mAr7Ti2mM7e4TQ+bKVJ1uk=;
 b=CdiAjhsLk9IHfztGDbfZXglTEvPVxU06FFZ5soiCbSRjIlHLtVeA4c4Ex+RlqIf34F
 TH9OcAUo4jKlEuhOMjW53YmLnWWhCW65zJz5oS2IwMv3iePBPXattayiuPu6AmfJGS4S
 EadxsDqUikLeWD9GBqlIW8nwHaS6GC7nPJvCRKfrE03FpY8MvuTxEZZH1CxCIwLZY8nd
 iBmOPtiMvSnwu8mlv7ACRIUEZbYCeoaJuaKqOkvMC5J30urNouTrj/3zpytU0+nJNgK3
 2/vz95V+vDBGRIh/YJgJzeIz0QhQT4qF8jCdmGIm9IUzaASbjCXzLsREJx4x9g9Ohivb
 o8qA==
X-Gm-Message-State: AOAM530+T0z7jzLjaMP+Qnd1GojIbodLOrxvw/E+tczmLcMBeiedPUqX
 7ITH+S8OrwY2TPM/jC6bS9SMsM9+QlYaDV25q1KTanCyTUX8F1/j396O8wQp70axYYqHm7Q9Y4i
 V8FJHmXoe2AqfJyk=
X-Received: by 2002:a7b:cb09:: with SMTP id u9mr2424751wmj.109.1604465509087; 
 Tue, 03 Nov 2020 20:51:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzMxLv+JaZiHu4RcPVJRW7FNGOc2a8eHWNjlgmREoTUDgMp7oZVs7xCNvk0cNW+rHNLY9LZoQ==
X-Received: by 2002:a7b:cb09:: with SMTP id u9mr2424743wmj.109.1604465508908; 
 Tue, 03 Nov 2020 20:51:48 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id t7sm854570wrx.42.2020.11.03.20.51.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 20:51:48 -0800 (PST)
Date: Tue, 3 Nov 2020 23:51:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 24/38] net: Add vhost-vdpa in show_netdevs()
Message-ID: <20201104044937.226370-25-mst@redhat.com>
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

Fix the bug that while Check qemu supported netdev,
there is no vhost-vdpa

Signed-off-by: Cindy Lu <lulu@redhat.com>
Message-Id: <20201016030909.9522-2-lulu@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/net.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/net.c b/net/net.c
index 7a2a0fb5ac..794c652282 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1049,6 +1049,9 @@ static void show_netdevs(void)
 #endif
 #ifdef CONFIG_POSIX
         "vhost-user",
+#endif
+#ifdef CONFIG_VHOST_VDPA
+        "vhost-vdpa",
 #endif
     };
 
-- 
MST


