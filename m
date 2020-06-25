Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DECC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:57:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DF77204EA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DC8GO5un"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DF77204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joX4N-0005pM-Dy
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 14:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joWwR-0000Uq-Ah
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:49:43 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38810
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joWwO-0001DS-Q2
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593110979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vdHB3c1POu+gM3bxvvPOf+lWl4pEeZKZAvtWWJ0/JLg=;
 b=DC8GO5unD7fDJcGcO+1jjYs4PohfyXrq6P7TeDkZn+UuSa0v3hIDqI3rNhBIUvaTo2uMIi
 nOt/DSEmJ+AS5bIinHPu7stt9keLFHcSYNIBSKQ4quFHBI7jQuO6KKCKpUv29lAqUTMnpI
 CUlWous9AHs+xEEl3NoEPw81jaWjDaM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-LiD0eN7JM8WerV7NYl2z-A-1; Thu, 25 Jun 2020 14:49:38 -0400
X-MC-Unique: LiD0eN7JM8WerV7NYl2z-A-1
Received: by mail-wm1-f71.google.com with SMTP id b13so5759117wme.9
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 11:49:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vdHB3c1POu+gM3bxvvPOf+lWl4pEeZKZAvtWWJ0/JLg=;
 b=eeCHjjGuU1tOtit+Ytb3joQIJFGSCrc2jZT/a4rKXBP9OVPJsUCPOURBp3aoMQVR2u
 I8Y0rFP6AlN6FGjoBKQ19s4XdzUt6LwK2+TBHH4xaaPRwU7/hHNHzeCYUpBxH0vH42nU
 GqtdumGLNF3009kyTyk2aibKjjEUuXPkCUc2fjFIdZUF80chRcMDQNda5mkwQUeB9EQK
 QoWy4TTzGyO5WIpelQC8lO/9W0hHVGS1eu2TT4FdZNOf8DOTEXoapaBK2dcTEbe1GaXF
 MCbMtYY49JcsLNYhjaGUOVmySR5wKeaYo/Qvyi9xFC2dxHiDUqn1rMvRHNxKgsiphpsC
 5RFw==
X-Gm-Message-State: AOAM533O06yBVvWAB/fCsJ7Z8C7g2edraC/tirF8F19baIQpjc6wKcUI
 1Da2WYRiEI5sL/uaB61PAzD8241dLh+l2pBuLUzHbrieL/NY2zprtIB2RiGrVG+eWEXo7B4XNSx
 lUjqbILeA//lai7I=
X-Received: by 2002:a1c:4343:: with SMTP id q64mr4972481wma.20.1593110976809; 
 Thu, 25 Jun 2020 11:49:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPNjPcX1y3BgRbnefEuZFWO96dtThFLq0XOx8wNtq258fIXU7m/llkftNUnvww60hczLCQdQ==
X-Received: by 2002:a1c:4343:: with SMTP id q64mr4972473wma.20.1593110976638; 
 Thu, 25 Jun 2020 11:49:36 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id 11sm13769708wmg.41.2020.06.25.11.49.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 11:49:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 12/17] block/nvme: Simplify nvme_kick trace event
Date: Thu, 25 Jun 2020 20:48:33 +0200
Message-Id: <20200625184838.28172-13-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200625184838.28172-1-philmd@redhat.com>
References: <20200625184838.28172-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 02:30:11
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The queues are tied to the hardware, logging the block
driver using them is irrelevant.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c       | 2 +-
 block/trace-events | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 1b7b23cea4..4d2f31a9b3 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -249,7 +249,7 @@ static void nvme_kick(BDRVNVMeState *s, NVMeQueuePair *q)
     if (s->plugged || !q->need_kick) {
         return;
     }
-    trace_nvme_kick(s, q->index);
+    trace_nvme_kick(q->index);
     assert(!(q->sq.tail & 0xFF00));
     /* Fence the write to submission queue entry before notifying the device. */
     smp_wmb();
diff --git a/block/trace-events b/block/trace-events
index 29dff8881c..f0c476110b 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -154,7 +154,7 @@ vxhs_close(char *vdisk_guid) "Closing vdisk %s"
 vxhs_get_creds(const char *cacert, const char *client_key, const char *client_cert) "cacert %s, client_key %s, client_cert %s"
 
 # nvme.c
-nvme_kick(void *s, int queue) "s %p queue %d"
+nvme_kick(int queue) "queue %d"
 nvme_dma_flush_queue_wait(void *s) "s %p"
 nvme_error(int cmd_specific, int sq_head, int sqid, int cid, int status) "cmd_specific %d sq_head %d sqid %d cid %d status 0x%x"
 nvme_process_completion(void *s, int index, int inflight) "s %p queue %d inflight %d"
-- 
2.21.3


