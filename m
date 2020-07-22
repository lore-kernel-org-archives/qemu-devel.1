Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26BEC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 12:12:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99F2520771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 12:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PCWzggeh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99F2520771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyDc1-0002Kl-Ta
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 08:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jyDYw-0005tb-5I
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 08:09:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33856
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jyDYu-0006b5-HU
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 08:09:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595419767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NUjKfU8xPyPB+FtStfFVhRssHx17cxqyTATNtRp+vz4=;
 b=PCWzggehhV14DZpxZxcf/0h6ye+3/43JwbrYa5YexRsVKr57b+ACPeWvsMjVEITW+GRPA7
 ucxDGk94KNs6SFWdT1ygv4gA/gw/KClt4fS9+mkwurdIWdNWNbTbl3WiwGcaxXR8fNNz8V
 qemMVq/yjuluK1KcWEtgBJEZdXZU7IM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-3oi3DBhcM5uXede-ro2VkQ-1; Wed, 22 Jul 2020 08:09:25 -0400
X-MC-Unique: 3oi3DBhcM5uXede-ro2VkQ-1
Received: by mail-wr1-f71.google.com with SMTP id f7so548017wrs.8
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 05:09:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NUjKfU8xPyPB+FtStfFVhRssHx17cxqyTATNtRp+vz4=;
 b=Ovno1iCvVW+/oldduIn70gwxE93BC5RE3zxGV48tIsTlFusxD7JfLhcgDpfCJ+675W
 08RL1GyB3+re3R5VKJkxCdkpM7h6uCFgYNDhbBsd787gwsVJkDws623NuOjfjGGttJV4
 uMjbDRnlPnAetuB/J7IUWEUo9GQko45V8pqkL4NAXdD+coPsG5ORPl/qvACt0htW/FTk
 LjtcMHU7S75Flc0ntzXb+ghTcQ+rZaH6iY/TWmhdqQGvFZg/Q0PTjx2DddG0Sd5vcVcp
 raYLTTfKrtkRU4Yz9rdLCTJvl/pJF/lxq8SUGlu7MNBeo+HPJAa0LNcRk+AvIpdraJSP
 IINA==
X-Gm-Message-State: AOAM530b6lP+1IvG5dfTd0qYgqryjFQ98KBsOpzlz7xGAY9OwNsxFGvd
 gELLgbwLZfBXVV3IGhrrmiHoHCzlZwK1Zpg92I5HRr18PWLzbSlI5b4W1TK8aULfEYbgFBMVI81
 O3nOOInIMiYzbfs8=
X-Received: by 2002:a5d:6452:: with SMTP id d18mr30214148wrw.284.1595419764451; 
 Wed, 22 Jul 2020 05:09:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywLvE/HpaJUjLAnM/Buzt27JVDJOexcCH/TOfLWPum0pulI5tfRhbdYFN6f4VH0laKb/SwyQ==
X-Received: by 2002:a5d:6452:: with SMTP id d18mr30214130wrw.284.1595419764269; 
 Wed, 22 Jul 2020 05:09:24 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id c15sm7030290wme.23.2020.07.22.05.09.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 05:09:23 -0700 (PDT)
Date: Wed, 22 Jul 2020 08:09:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/9] virtio-balloon: Add locking to prevent possible race when
 starting hinting
Message-ID: <20200722120853.9144-5-mst@redhat.com>
References: <20200722120853.9144-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200722120853.9144-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 00:40:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
 Alexander Duyck <alexander.h.duyck@linux.intel.com>, qemu-stable@nongnu.org,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

There is already locking in place when we are stopping free page hinting
but there is not similar protections in place when we start. I can only
assume this was overlooked as in most cases the page hinting should not be
occurring when we are starting the hinting, however there is still a chance
we could be processing hints by the time we get back around to restarting
the hinting so we are better off making sure to protect the state with the
mutex lock rather than just updating the value with no protections.

Based on feedback from Peter Maydell this issue had also been spotted by
Coverity: CID 1430269

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Message-Id: <20200720175122.21935.78013.stgit@localhost.localdomain>
Cc: qemu-stable@nongnu.org
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-balloon.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index ce70adcc69..6e2d129340 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -592,6 +592,8 @@ static void virtio_balloon_free_page_start(VirtIOBalloon *s)
         return;
     }
 
+    qemu_mutex_lock(&s->free_page_lock);
+
     if (s->free_page_report_cmd_id == UINT_MAX) {
         s->free_page_report_cmd_id =
                        VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN;
@@ -600,6 +602,8 @@ static void virtio_balloon_free_page_start(VirtIOBalloon *s)
     }
 
     s->free_page_report_status = FREE_PAGE_REPORT_S_REQUESTED;
+    qemu_mutex_unlock(&s->free_page_lock);
+
     virtio_notify_config(vdev);
 }
 
-- 
MST


