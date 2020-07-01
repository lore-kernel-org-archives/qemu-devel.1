Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6954C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 13:52:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7730C20663
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 13:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="nMYFZFgb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7730C20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqd9y-00075o-Pi
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 09:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45026)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xieyongji@bytedance.com>)
 id 1jqaOX-0004rD-Uy
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 06:55:14 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:56119)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xieyongji@bytedance.com>)
 id 1jqaOT-0002UJ-Gd
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 06:55:11 -0400
Received: by mail-pj1-x1043.google.com with SMTP id a9so415207pjh.5
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 03:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UZHzWR+E0LxnRTeSK/Ph3y9pMWnejwZXmeIJnIYRE1E=;
 b=nMYFZFgb6E8akjSjCdvQBcvIOas7bTet+dyFJkOyhk/+RFDHua/QMaSnhPWpx3fA6+
 muQdPriJmIvktY4QyfUergs5ri66dyQoR/PCDU2jntY8ye+SUDRYO4wfRuKLCV7iwEvA
 jQFIsYjZQDI3tRzD/pZiJurFVOgC78Uf19403OAJq+2FOt4TeDcZoSvnCepPTXb34tJ1
 6J24+ED739qFYJ5v9J8+opcTDiMa9sXEAhdXjcqFhf7sMh7kdflxmpKi64OqQjW4uimM
 UBDy286XQeyBRKuohb7Ag6DxlIKEqaeQc5npSdWfo4zn6ix2aDigwd1/WBAa7VuSlD0o
 /XHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UZHzWR+E0LxnRTeSK/Ph3y9pMWnejwZXmeIJnIYRE1E=;
 b=fHBsXSPbcaj0PtSMETNcGUa3xvEIsPonw9iIs7C3Xq0f9Dzi9D50hiRlpv9kC+jx4t
 fRvLf8ojR+Wmqhp3wqxQ3/tzIVs+F5gG9A2g+AlgDrtKNc4tiefbQfwkgdrkmG9EkVPy
 MA9R3BTG+r739esrWkefwD7DKnKGBXSN9y98vWUtQxiiCweeyF/rutoJ3OxR8V7kvfqu
 hqIDolXos49hZo9i/zYUE3vVwrmID/8oQB6pmDWkI4WSQbhPvpJ0RzZb47j9hst3g8sr
 i0dPXA/PDvB1DW30z6qaBsInr9GPlScgXSAoOBLj63cRLcu82AxIlMVzJu6VFyix6ijO
 HQIQ==
X-Gm-Message-State: AOAM530lpJUR4+Hvs2NlAdNmUgA5HtR83Lhs54YWX6daq5wqwQJ6Azsi
 gNNGsygcZh3/jUEbkhKuMB8c
X-Google-Smtp-Source: ABdhPJwj6Kh8UgVvOPnxUZQv0dPv/CorpH7/CEiTXRWs40Oxl3I4ilnnRhSAEahy609mn6hXMPOeJw==
X-Received: by 2002:a17:90a:a115:: with SMTP id
 s21mr21694283pjp.232.1593600906870; 
 Wed, 01 Jul 2020 03:55:06 -0700 (PDT)
Received: from localhost ([103.136.221.70])
 by smtp.gmail.com with ESMTPSA id f23sm4797310pja.8.2020.07.01.03.55.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2020 03:55:06 -0700 (PDT)
From: Xie Yongji <xieyongji@bytedance.com>
To: pbonzini@redhat.com,
	kwolf@redhat.com,
	mreitz@redhat.com
Subject: [PATCH 1/2] iscsi: handle check condition status in retry loop
Date: Wed,  1 Jul 2020 18:54:43 +0800
Message-Id: <20200701105444.3226-1-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=xieyongji@bytedance.com; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 01 Jul 2020 09:50:45 -0400
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
Cc: xieyongji@bytedance.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 elohimes@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The handling of check condition was incorrect because
we would only do it after retries exceed maximum.

Fixes: 8c460269aa ("iscsi: base all handling of check condition on scsi_sense_to_errno")
Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 block/iscsi.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index a8b76979d8..2964c9f8d2 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -266,16 +266,16 @@ iscsi_co_generic_cb(struct iscsi_context *iscsi, int status,
                 timer_mod(&iTask->retry_timer,
                           qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + retry_time);
                 iTask->do_retry = 1;
-            }
-        } else if (status == SCSI_STATUS_CHECK_CONDITION) {
-            int error = iscsi_translate_sense(&task->sense);
-            if (error == EAGAIN) {
-                error_report("iSCSI CheckCondition: %s",
-                             iscsi_get_error(iscsi));
-                iTask->do_retry = 1;
-            } else {
-                iTask->err_code = -error;
-                iTask->err_str = g_strdup(iscsi_get_error(iscsi));
+            } else if (status == SCSI_STATUS_CHECK_CONDITION) {
+                int error = iscsi_translate_sense(&task->sense);
+                if (error == EAGAIN) {
+                    error_report("iSCSI CheckCondition: %s",
+                                 iscsi_get_error(iscsi));
+                    iTask->do_retry = 1;
+                } else {
+                    iTask->err_code = -error;
+                    iTask->err_str = g_strdup(iscsi_get_error(iscsi));
+                }
             }
         }
     }
-- 
2.11.0


