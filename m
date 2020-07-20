Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43D2C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 17:52:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 773AF20709
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 17:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8uirNNR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 773AF20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxZxf-0000hy-NF
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 13:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jxZwj-0007rK-Uu
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 13:51:25 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:52934)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jxZwi-0007iZ-BO
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 13:51:25 -0400
Received: by mail-pj1-x1041.google.com with SMTP id gc9so187795pjb.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 10:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:date:message-id:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=nCKUBraGXRlMO/ENL1FojgjZW4PKZM/+PVsaTrP9Vag=;
 b=V8uirNNRA5UV1t0s7+TCIyz7WsX+UPn4LHC6d8SaNUkDulrAvhiGM5SZ91iBk6izpW
 GfyRWVg0h0AI0xVBiNxo8b3/XOYEenMtmpzNxox/lsKdfmZE4E3JRPf7t8evvVdM3R4B
 ih2kIEQG+PHwiDH0BaRcB89Y5m6g5W6yu6wrXflAK7/kDI3reWPjOa86komoJ5bJFREm
 iSi8tYKz9fQGhAT/a+et6VEc/FRkcxih6vGdCKOr7qLPZbJ01dpvMELQJe2ZqYJG7h+/
 +waFQ0ByRbHDX/WmYwnlWLRDNw4CZlLofYsayPl1URFxLVf0E02zZLr01dq5HA0vKCXy
 SA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=nCKUBraGXRlMO/ENL1FojgjZW4PKZM/+PVsaTrP9Vag=;
 b=cHR1dDhnFkPhQI9GeJ8K3ZT4uoOIn2aQKjVhrK+XGFXWHZJKA4G4G6znSXBspgasP2
 48nnHlvc8NaRW7UOFjJhbOy2XbeoJxVhukCCa7qBkdOf4oyGgMPlyq0sYC47mCBpzYPT
 a8l6cp8r63C7nDfSOyjTVlXHRh+6f9hDBiAYyIMxWvmKQAj+m/t0Rxld/FWlKDMUx++Z
 hEuiXO9kYsQPTaTaMED39g8nIgEyd+6tTjVrNNFyn/Po7GInNv/ZwdgJC78nhRHcZRDL
 C0bD8X9u8aBgwNHtKV/+2c7hvQ3TV4uW8kOjNRn1f62wTFM88NPfXt/bC8Rwj7P6nEFh
 cHEw==
X-Gm-Message-State: AOAM532N0o0VS1t1fq4P7tY5WQbwqx13+0lRdF24vaPwRguqXJwl9yxu
 YCFX+QPe3gVeKM/5xYqI8yc=
X-Google-Smtp-Source: ABdhPJxBxMKYWsEEQsVFaX+bDOXBAjSsPcA2rsUjyVGVCJ4chEqcdQEugziEbRXruJCCOmXrSASGhQ==
X-Received: by 2002:a17:90b:102:: with SMTP id p2mr540561pjz.227.1595267483054; 
 Mon, 20 Jul 2020 10:51:23 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
 by smtp.gmail.com with ESMTPSA id g28sm17087908pfr.70.2020.07.20.10.51.22
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 20 Jul 2020 10:51:22 -0700 (PDT)
Subject: [PATCH v3 QEMU 2/3] virtio-balloon: Add locking to prevent possible
 race when starting hinting
From: Alexander Duyck <alexander.duyck@gmail.com>
To: david@redhat.com, mst@redhat.com
Date: Mon, 20 Jul 2020 10:51:22 -0700
Message-ID: <20200720175122.21935.78013.stgit@localhost.localdomain>
In-Reply-To: <20200720175030.21935.80052.stgit@localhost.localdomain>
References: <20200720175030.21935.80052.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=alexander.duyck@gmail.com; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org,
 peter.maydell@linaro.org
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
---
 hw/virtio/virtio-balloon.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index ce70adcc6925..6e2d1293402f 100644
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
 


