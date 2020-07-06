Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30861C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 21:15:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECF962070B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 21:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAjdhT1H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF962070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsYSO-00085U-1z
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 17:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jsYRJ-0006oP-5K
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 17:14:13 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:34421)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jsYRH-0000HF-89
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 17:14:12 -0400
Received: by mail-pl1-x644.google.com with SMTP id o1so9253230plk.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 14:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:date:message-id:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=uMeY2M7/mS/0n1w9o0LfcRh5FR+KNB3RWjicNkUWe8A=;
 b=BAjdhT1Hj7d1jWsXXdDMb/DFYgBg6VUnvd9jGpOujAnNH5rNO4phu2cxMLwdHjmfhU
 ul9ud4S7DRBm5pZ4HUSMylrSSDAYNO6JvmXY93so/aZyVvA36aNZXtaNE6FcjH47qgoX
 JeKCqjNYmhyLTBTARFm1lNQIFMSmklvma062taCg2uCuzS3FoBISQ5ofzize4vDEiY/H
 X3mVETwbl9HIMDYH++na2QnWftpragMnsj1J3KZS5pDbFFDoW98xQ56Ab53up3e+PX9u
 pwL3t1khkbenifVvuVhR3vqmKm+Lx3iv2hIGKRl6Gf1Mp/s0iG4fxYHj0Ov7MdWtzUq3
 t34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=uMeY2M7/mS/0n1w9o0LfcRh5FR+KNB3RWjicNkUWe8A=;
 b=InWkS6auqE2ZKNAZGgWtHy+6zbSwVfZ4wMoX2guYngq01Sfb6BYwAvDUA9VhiLET82
 iOGCMyrILMwmFUzgpnUFCUfqgmPlIYWr8jI/ZDYo5HieTsS7QTHrauD3MoQR9LZDkdmY
 ajYOhp64vSEScllKSBa3VncJvWGlWJxmXT8Z4yP8q+zNdXzWt8ZvitbscQSmsofUw4xU
 dTBjL5kYh1ZX+g2ouHDhCP9nToxKBxjRaClvYRgn7epP3y1bFJ8H/V9B2CyNcws9QWty
 Xi74ZtE2y8Md3LWcMZstvcF9mYfNqjj0c9fSgEEcPwIVC98iqV4lXvvFGFfy37UMmpuQ
 0pvg==
X-Gm-Message-State: AOAM531TT1ffjFvY6z1o1+6Y2QP1v4AJtQEWl89ZzG6882joMsneGa0R
 8Y+P4+/biCrtJr48vfxs9SQ=
X-Google-Smtp-Source: ABdhPJxeOxhLlr8JHQ4IBGLFjw5G3q/E2zn5t9OnC1a/HRP/HxgxSIgooJOifd1hle4T/+1RIHiq4w==
X-Received: by 2002:a17:90a:e7cd:: with SMTP id
 kb13mr1016385pjb.138.1594070048882; 
 Mon, 06 Jul 2020 14:14:08 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
 by smtp.gmail.com with ESMTPSA id v28sm20397808pgc.44.2020.07.06.14.14.08
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 06 Jul 2020 14:14:08 -0700 (PDT)
Subject: [PATCH v2 2/3] virtio-balloon: Add locking to prevent possible race
 when starting hinting
From: Alexander Duyck <alexander.duyck@gmail.com>
To: david@redhat.com, mst@redhat.com
Date: Mon, 06 Jul 2020 14:14:07 -0700
Message-ID: <20200706211407.20018.51061.stgit@localhost.localdomain>
In-Reply-To: <20200706211314.20018.89695.stgit@localhost.localdomain>
References: <20200706211314.20018.89695.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=alexander.duyck@gmail.com; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
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

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 hw/virtio/virtio-balloon.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 0c0fd7114799..b3e96a822b4d 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -593,6 +593,8 @@ static void virtio_balloon_free_page_start(VirtIOBalloon *s)
         return;
     }
 
+    qemu_mutex_lock(&s->free_page_lock);
+
     if (s->free_page_report_cmd_id == UINT_MAX) {
         s->free_page_report_cmd_id =
                        VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN;
@@ -601,6 +603,8 @@ static void virtio_balloon_free_page_start(VirtIOBalloon *s)
     }
 
     s->free_page_report_status = FREE_PAGE_REPORT_S_REQUESTED;
+    qemu_mutex_unlock(&s->free_page_lock);
+
     virtio_notify_config(vdev);
 }
 


