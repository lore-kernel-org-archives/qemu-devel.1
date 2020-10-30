Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C0EC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 12:53:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB0F9206ED
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 12:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HYLKmMv+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB0F9206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYTtw-0000vI-MS
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 08:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYTpG-0003dK-MP
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 08:48:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25202)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYTpE-0001Wb-Nz
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 08:48:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604062092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zjLk5rYnsVamvL3ZAKIsdxK/c57DAaLzJqbsx6rIiu4=;
 b=HYLKmMv+c5DFFheqOfkJR0dKpChvtnxBnNKzQd4p5+/GoWCAlhf6QdlCV3VfRc+FhsibXq
 3MZufwoiJUkdFyfV+6GWjx1NGlePcP+80I7DmAje/QGJC3NS4hrd4lCIyMob2AhIAn7jAb
 76IYNamqqfcFpJnDoj9l8tRxtd6jCI8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-y7wG7fAOMaKx_wRogQbqBQ-1; Fri, 30 Oct 2020 08:45:10 -0400
X-MC-Unique: y7wG7fAOMaKx_wRogQbqBQ-1
Received: by mail-wr1-f69.google.com with SMTP id v5so2641026wrr.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 05:45:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=zjLk5rYnsVamvL3ZAKIsdxK/c57DAaLzJqbsx6rIiu4=;
 b=X/dNbtqIGnuuuuqU7vTQe7RNeS6qVmcKlk84urr5kcS5BVSuNUZEutHmUNp9bT+CcT
 1kyDkVI9hCRfZGwet5DQvhl5rYh7uM7Vo4nAOAhqxXbKbS4bqIcCKZ4mrbOt9Pt9HbF3
 ucB9FBhw5B5N3kIxgX9xB7BVWGuAEGZanOqbg0XDDDyGcXPgYSNqGAOxobs5U2h9Ui1U
 i3Z3DjJdF6VIyLyqs7J8v+XjwKs4xlpZ8AF/BWU6MYpZwZWiq1FNbEUokdQay4Z2L94Z
 5ckCpeiZp1Qq8FVirmXCvWM/Mr1+qeaCfeTaha4p4/3n+3P9YrzESF47/48eKxiqA5hK
 xHZA==
X-Gm-Message-State: AOAM5320dpIk1uJ+6lCU6NJ/KhKMKBJeRwq1VMQq4vUVu/34+1cxcLHx
 BxXMZHEB8NWlIarFtHI5J8kY3UOQOh+p9h9HfhHEfaYwU1ho8KWIJvDLOTWVtbji32XdHavc422
 Mcq+y4G6Pihk49OE=
X-Received: by 2002:adf:f2c9:: with SMTP id d9mr2902165wrp.319.1604061908635; 
 Fri, 30 Oct 2020 05:45:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhdldf1PLZKGFqfxKTtjrj7dHkgJ7RFpuFpMRrruoYxFrON9PQYYu+iiDQZDJ+XLz7Jr68ig==
X-Received: by 2002:adf:f2c9:: with SMTP id d9mr2902143wrp.319.1604061908469; 
 Fri, 30 Oct 2020 05:45:08 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id a199sm4901495wmd.8.2020.10.30.05.45.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 05:45:07 -0700 (PDT)
Date: Fri, 30 Oct 2020 08:45:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/15] vhost-vdpa: negotiate VIRTIO_NET_F_STATUS with driver
Message-ID: <20201030124454.854286-2-mst@redhat.com>
References: <20201030124454.854286-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201030124454.854286-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 02:24:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Si-Wei Liu <si-wei.liu@oracle.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Si-Wei Liu <si-wei.liu@oracle.com>

Vendor driver may not support or implement config
interrupt delivery for link status notifications.
In this event, vendor driver is expected to NACK
the feature, but guest will keep link always up.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
Message-Id: <1601582985-14944-1-git-send-email-si-wei.liu@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index e2b3ba85bf..99c476db8c 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -55,6 +55,7 @@ const int vdpa_feature_bits[] = {
     VIRTIO_F_IOMMU_PLATFORM,
     VIRTIO_F_RING_PACKED,
     VIRTIO_NET_F_GUEST_ANNOUNCE,
+    VIRTIO_NET_F_STATUS,
     VHOST_INVALID_FEATURE_BIT
 };
 
-- 
MST


