Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAD4C4332E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 11:32:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67E7D2072D
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 11:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JxMdLQKD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67E7D2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGLJi-0000eI-K4
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 07:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42623)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jGLHH-000633-SI
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:29:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jGLHG-0005oP-Oj
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:29:55 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:27777)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jGLHG-0005oA-Lj
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584962994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CnY3zLI4QPJwJbV3E83s5quIe0UqJksgPfBVqujwwYQ=;
 b=JxMdLQKD3RurIf1ttp5UO1h2Pcgg2hjsT4AKC9pbkfeUVkZfXnO3JFUy1OzCy2APDBG0Nt
 WIZmM+/vChjNCwjyjf7qpbO5Rz2Y1eDfuvpiRHmp46qO6KNreIfA8tAtr7aWSuk+N21OQx
 rZZWuK2D8mXuCGgWIJkvMyUTmFKNv8M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-4gLPi4zqOFieM-ye2pmKgg-1; Mon, 23 Mar 2020 07:29:52 -0400
X-MC-Unique: 4gLPi4zqOFieM-ye2pmKgg-1
Received: by mail-wm1-f70.google.com with SMTP id x23so557976wmj.1
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 04:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7K6WQY9fcdbigH9iiFUH1LhMVHv2gz9dk5QjDw4BfrU=;
 b=pIkvnTEgNEfts8lM45Xyy0j1AkSSu02OoAZ/3k0LaV0MixNvrIxXAsZnehEXesURFK
 kRVwSxkMTaGMHFP3is10IqNwsK/oTNFq9t3PbNBgc1xIko21Cs/i3tH57BDKcohq3wX/
 aMlcV7BeAlhR2/vXbgQLMGadZTLiCNE3IGddDML8sTbXFDHG4niJ+w/Bq1OM1Ps/4yx/
 Wsx7GVngWx8fUmWhtFiV/Z0ogjtEkPW4fBSK3VqJ8co0FOYI0Jc3R53h7UgIq6af7M2u
 cUY87YnPEBXwITSPfogfbXt3jkH/3HUOFDud8JJIfK6cT+KXB+ZzJhhi3DfhGreRsEpM
 CO6Q==
X-Gm-Message-State: ANhLgQ2d7F42aAp8dFpxu9YKq70KyM7+ez02F971Ta9E2OIPYBOi2cRZ
 OhKgVUXO4NH/PItEanHxOtYEyC6B5RGFs8hSIBqHNkF0ihaC68JWg41to5LnoHXDd4ngkxODDic
 E/y2YyF+D+LQmtUw=
X-Received: by 2002:adf:914e:: with SMTP id j72mr29812390wrj.109.1584962991021; 
 Mon, 23 Mar 2020 04:29:51 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vslTSQ7xCR9n4plBG+WaLw6Q8/AzFaXYp9f+feH0KgjDbZvibAWYKH/15acs06uPXO6qtyZCQ==
X-Received: by 2002:adf:914e:: with SMTP id j72mr29812363wrj.109.1584962990781; 
 Mon, 23 Mar 2020 04:29:50 -0700 (PDT)
Received: from localhost.localdomain (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id 9sm3933672wmm.6.2020.03.23.04.29.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2020 04:29:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 1/3] vhost-user-gpu: Release memory returned by
 vu_queue_pop() with free()
Date: Mon, 23 Mar 2020 12:29:41 +0100
Message-Id: <20200323112943.12010-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200323112943.12010-1-philmd@redhat.com>
References: <20200323112943.12010-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

vu_queue_pop() returns memory that must be freed with free().

Cc: qemu-stable@nongnu.org
Reported-by: Coverity (CID 1421887 ALLOC_FREE_MISMATCH)
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
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


