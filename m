Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20BDC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:48:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E56622370
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X2d96dbv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E56622370
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZxcE-0004lE-8o
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 09:48:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZxP3-0005FN-7k
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:35:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54282)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZxP1-0006dG-AV
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:35:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604414114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MaK8aBvBSiaUINk0iflL/mAr7Ti2mM7e4TQ+bKVJ1uk=;
 b=X2d96dbvSj6sVPU6BrjstpfBNaINC4sef4rd6mGI+OIyLqcBonsWxfKlLqNX9tULL5ZpJL
 Fx4PMLZuv9+4oqlUmCSXkqqDDkBbrRw1GGfOQjdYp+j0jlUWGG/wN3kMvtSeGVLvimy/0X
 vDJ/WAOn9vYjbCEcw/EAmHNNRZ6FiUw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-nrUvLGhlMpCUMssc9-BaRA-1; Tue, 03 Nov 2020 09:35:07 -0500
X-MC-Unique: nrUvLGhlMpCUMssc9-BaRA-1
Received: by mail-wm1-f69.google.com with SMTP id o19so4683045wme.2
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 06:35:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=MaK8aBvBSiaUINk0iflL/mAr7Ti2mM7e4TQ+bKVJ1uk=;
 b=pLskcOu0fa4by2r4BuNV/Tbx8yY3YHYm5lA3wXG9p9vTzOO1kU8/Ct3bTggiiW2gu0
 4eqdpXRVJWwcgUXCPJ/QneEayMCVohbNPh7czOskqGi8whbYRTdm7dSD28HzZLgoU0Mx
 EU/sjYlUvFR9w8OIrI/RBlELo6FsAtjBG0trcPPZyTjg3W37ExaQGeUJOiKVyudcUcgc
 DhkD9eUoMQ60yxecX04/jyE4rs3WOtDzV3S/haCNGQ2iIQ2VZf3vskzpG4A53pRHB4N9
 v6oEpX6oJ7MkhRjkAMt+n7aNmZo4eiG3/wMLG1174lG5hte6E9CMQtkkiZQf3enP178V
 S39g==
X-Gm-Message-State: AOAM533lQ7nYnAqCyi8n1EGC3A66uyh2UM8d3dv7jjqIxkC27bOnFLDr
 h1xUwbB6gp7/ABmKBnPORMq+OKXG5u6s9cZdDbDE0j3knYFR36aygXuxmCBi0SHXkoDUNfY7SQy
 HAmeYShdNeGO58rk=
X-Received: by 2002:adf:804e:: with SMTP id 72mr15809440wrk.114.1604414105281; 
 Tue, 03 Nov 2020 06:35:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwTQAOm1DKZcntZ9rNaostJDtdyinpLRrrbgx3yPrVUc0zTo8Z5s30M303N7/zcF8/H0ZsmeA==
X-Received: by 2002:adf:804e:: with SMTP id 72mr15809425wrk.114.1604414105142; 
 Tue, 03 Nov 2020 06:35:05 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id m21sm1702974wmi.3.2020.11.03.06.35.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 06:35:04 -0800 (PST)
Date: Tue, 3 Nov 2020 09:35:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 24/38] net: Add vhost-vdpa in show_netdevs()
Message-ID: <20201103142306.71782-25-mst@redhat.com>
References: <20201103142306.71782-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201103142306.71782-1-mst@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
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


