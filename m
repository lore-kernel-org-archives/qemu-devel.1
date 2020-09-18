Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02D3C43465
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 13:12:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D5C6235FD
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 13:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="sK62+hhj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D5C6235FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJGBo-0000Zn-0E
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 09:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangguoqing.kernel@bytedance.com>)
 id 1kJENn-0003ZO-9G
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 07:16:53 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:45274)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangguoqing.kernel@bytedance.com>)
 id 1kJENg-0002Tg-Ur
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 07:16:48 -0400
Received: by mail-pl1-x642.google.com with SMTP id q12so2807231plr.12
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 04:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5mxCGQwCimOdAtxM/dpds225ENuJSa7u2FiepnSwKvE=;
 b=sK62+hhjcqhOfv5jEWR9DeOS56gHJip7CILxQbr+e33KjvH6sxkFet52yhBOVl9EVR
 MWfIgcHtg0L4f+DcEYKtii+LkuptTwAXLYAcK9+TINzjFXzV9GAQT7P7J+Z361OuIGPK
 M+VKqckmdHKTstPsYdV9rfgLbNxCIsQjOR6+yy7+pJcjmp0RbgsxdZCZ1k8GiQgGc800
 SB+pDEp/+RNySiLjOjQtDkXdUe3JJ2U3Q8c0iykKf2gt3/F/UQTyLaG8mzJZIRKNwynl
 Ff/o8boeRkLloBR081WR4x5tfV6sVGfYReKnqfV7ZbD7HNlprZkU52uHqYFIydLdYx1f
 Iohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5mxCGQwCimOdAtxM/dpds225ENuJSa7u2FiepnSwKvE=;
 b=OiSyVqvK0fqLPmPPYjWL4VrHQBJRBgGEeUo8tAHOePAqWyv3nOuDuTiR7OvMCZkaIA
 nA/rBAweO4meKsEgbT9fRqCwOhpkCoPp7ewD6cZE+ac46nhBCB1jm1YbnMPlZDLIBHBH
 7pzo6on9F3lgU5ebXuJs4EKOUgs/Cgcg8Db1cbXhWesXkJzH7NyG3MeRlSfOcbD8jmOJ
 78l7MLIRpHXbBDeJgkXq6l6e4MG51twhIfJdXkPDYHthRYNq0HmzbyvYelV2gfUE3tM5
 gabjysBl6FBtJ1ElPNy1+E3m8b/2mBilwgpfeWl+onRS0k5btI94LGJZTVnKFj0kbHGe
 dOQA==
X-Gm-Message-State: AOAM533HD/tEZ15df6E8TMoVBxV+S8NWt1HrOwiRG8bieS4j619J03hv
 DfO1HRpUlxtC9whiyOwa5epw4Q==
X-Google-Smtp-Source: ABdhPJyGbMJNo3dJsKZnZQapgJ4IT/cmO94Hm/hvECXmhK0EMVLPv2ubayhSYr2m9ARmQCGNTyUDBw==
X-Received: by 2002:a17:90a:e549:: with SMTP id
 ei9mr12638690pjb.52.1600427801643; 
 Fri, 18 Sep 2020 04:16:41 -0700 (PDT)
Received: from C02D25X8MD6R.sso.bytedance.com ([103.136.221.66])
 by smtp.gmail.com with ESMTPSA id q10sm2629478pja.48.2020.09.18.04.16.38
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Sep 2020 04:16:41 -0700 (PDT)
From: Guoqing Zhang <zhangguoqing.kernel@bytedance.com>
To: Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH] virtio-gpu-3d: fix abnormal display after a warm reboot
Date: Fri, 18 Sep 2020 19:16:32 +0800
Message-Id: <20200918111632.37354-1-zhangguoqing.kernel@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=zhangguoqing.kernel@bytedance.com; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 18 Sep 2020 09:10:55 -0400
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
Cc: Guoqing Zhang <zhangguoqing.kernel@bytedance.com>, qemu-devel@nongnu.org,
 Qi Liu <liuqi.16@bytedance.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When resetting virtio-gpu, virgl_renderer_reset() should be
called to ensure that the virglrenderer status is correct.

Signed-off-by: Guoqing Zhang <zhangguoqing.kernel@bytedance.com>
Reviewed-by: Qi Liu<liuqi.16@bytedance.com>
---
 hw/display/virtio-gpu-3d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-3d.c
index 96621576c2..1bd33d7aed 100644
--- a/hw/display/virtio-gpu-3d.c
+++ b/hw/display/virtio-gpu-3d.c
@@ -595,7 +595,7 @@ void virtio_gpu_virgl_reset(VirtIOGPU *g)
 {
     int i;
 
-    /* virgl_renderer_reset() ??? */
+    virgl_renderer_reset();
     for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
         if (i != 0) {
             dpy_gfx_replace_surface(g->parent_obj.scanout[i].con, NULL);
-- 
2.24.3 (Apple Git-128)


