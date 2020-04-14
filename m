Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C87C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 17:08:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F86F2076A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 17:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fGwdIH97"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F86F2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOP2o-0001DO-Op
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 13:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40257)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOOy0-0001eK-Pd
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 13:03:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOOxz-0003sw-G3
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 13:03:20 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57567
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOLeu-0008Gn-5U
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 09:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586871083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PwwyvF6CHPHLQYK0ni4C07URn8wv+xD7OizfGx3R5og=;
 b=fGwdIH97qx4S/8MoDdptGB/WaxMutybLUzEZJ/5DhPbXeDEiOQr55WFUPeBUrHleu2VDBy
 ONfZvnB6IsD219XUSNPaVX4RKupaFeGolCdk1hX7VDVk0rUeZmjjX0ubx/1zo+x5aELtxe
 hsguH5IPUCiARWROkAnKxGsy1bfQkQU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-GncWqAcSPV2LwUlmLngDfw-1; Tue, 14 Apr 2020 09:31:22 -0400
X-MC-Unique: GncWqAcSPV2LwUlmLngDfw-1
Received: by mail-wr1-f69.google.com with SMTP id g6so8659613wru.8
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 06:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+J7WGWS9eBH3j6xbXcrU1P0OHfkg4KZSoUk6HMMZuss=;
 b=HT/8p/mPG+2LI1XWzWszw6C28gsd7lsmOnckIpM8YK0T4iSjrM4//SDF0hr65pV6c/
 PXes2HA7lUubafZrvnaUYTCgygYj5FNvQtxaztzCUzODKWndoaeBo0YKvkGc/atZKWuH
 cBkd/qL6YfGefha6etqlRh2J8fFGEkXB6YiermhnKxHzkcNWUC9SInDXMlpLw7ArhEt9
 /8U9BFIrkmDx9Ch6CKKNIefDO32VSGLyr2fCIqEraTFRf/sXIipGLnRTYKg5n0p8pZH1
 3idamePCuvgidWjJtnrTKeb38084Xc9o53WBcEi/DEl8FYpXPWoQqSJPY87YoCEXwF2z
 3kEQ==
X-Gm-Message-State: AGi0PuZ9grZkx/D8kfXlfr1uQNLbOEh2MLi8siZ+YH+9lfUrqES6O0fp
 /FtuBjI/rP2lrvmYjwV4rMLaWyoIrDObYuWCeD8FOWcc6V11W8XtqQ8RWc9f0QBd1gjx3NKtWB6
 wNpoORaFI4IwLNJg=
X-Received: by 2002:a5d:43c6:: with SMTP id v6mr23929048wrr.395.1586871080979; 
 Tue, 14 Apr 2020 06:31:20 -0700 (PDT)
X-Google-Smtp-Source: APiQypKgGUDuJPZuz3ryDLaXtieYi+AGnY2jg/DIB7w+5V0Fi0X8UWoftiRF1dPd3vm50nfUsw9g5Q==
X-Received: by 2002:a5d:43c6:: with SMTP id v6mr23929027wrr.395.1586871080810; 
 Tue, 14 Apr 2020 06:31:20 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a1sm9922751wrn.80.2020.04.14.06.31.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 06:31:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 05/12] vhost-user-gpu: Release memory returned by
 vu_queue_pop() with free()
Date: Tue, 14 Apr 2020 15:30:45 +0200
Message-Id: <20200414133052.13712-6-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200414133052.13712-1-philmd@redhat.com>
References: <20200414133052.13712-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-stable@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Fabien Chouteau <chouteau@adacore.com>, Max Filippov <jcmvbkbc@gmail.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stafford Horne <shorne@gmail.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

vu_queue_pop() returns memory that must be freed with free().

Cc: qemu-stable@nongnu.org
Reported-by: Coverity (CID 1421887 ALLOC_FREE_MISMATCH)
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 contrib/vhost-user-gpu/vhost-user-gpu.c | 4 ++--
 contrib/vhost-user-gpu/virgl.c          | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/vhost-user-gpu/vhost-user-gpu.c b/contrib/vhost-user-g=
pu/vhost-user-gpu.c
index b45d2019b4..a019d0a9ac 100644
--- a/contrib/vhost-user-gpu/vhost-user-gpu.c
+++ b/contrib/vhost-user-gpu/vhost-user-gpu.c
@@ -848,7 +848,7 @@ vg_handle_ctrl(VuDev *dev, int qidx)
             QTAILQ_INSERT_TAIL(&vg->fenceq, cmd, next);
             vg->inflight++;
         } else {
-            g_free(cmd);
+            free(cmd);
         }
     }
 }
@@ -939,7 +939,7 @@ vg_handle_cursor(VuDev *dev, int qidx)
         }
         vu_queue_push(dev, vq, elem, 0);
         vu_queue_notify(dev, vq);
-        g_free(elem);
+        free(elem);
     }
 }
=20
diff --git a/contrib/vhost-user-gpu/virgl.c b/contrib/vhost-user-gpu/virgl.=
c
index 43413e29df..b0bc22c3c1 100644
--- a/contrib/vhost-user-gpu/virgl.c
+++ b/contrib/vhost-user-gpu/virgl.c
@@ -519,7 +519,7 @@ virgl_write_fence(void *opaque, uint32_t fence)
         g_debug("FENCE %" PRIu64, cmd->cmd_hdr.fence_id);
         vg_ctrl_response_nodata(g, cmd, VIRTIO_GPU_RESP_OK_NODATA);
         QTAILQ_REMOVE(&g->fenceq, cmd, next);
-        g_free(cmd);
+        free(cmd);
         g->inflight--;
     }
 }
--=20
2.21.1


