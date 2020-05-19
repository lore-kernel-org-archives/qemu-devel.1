Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F88C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 13:50:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E537207D8
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 13:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T5+JpIAP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E537207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb2dX-0004dS-CR
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 09:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1jb2cy-00045Q-V9
 for qemu-devel@nongnu.org; Tue, 19 May 2020 09:49:52 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23909
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1jb2cx-0004qS-Lv
 for qemu-devel@nongnu.org; Tue, 19 May 2020 09:49:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589896190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LPQKzrorlkitimHazIF9B/qi3vPNIF0FGX6JapCdhOo=;
 b=T5+JpIAPsuXKcoashJBMp20IuHDkt4RWhcjl+t4qZLoeoN9LCsuayM0sdBqeOBmMMZTQD9
 8b04dN7EtaIePb3i5gpcZfjY9hdeYIBWp13rSLFv0aF4QRt8HpywbcdcV+G5jUNjbeqnRu
 /fhRHNZjvX+AyVypgSr1j8y0zZroFZA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-UvfbccODNLmrPsSiXH7ekA-1; Tue, 19 May 2020 09:49:49 -0400
X-MC-Unique: UvfbccODNLmrPsSiXH7ekA-1
Received: by mail-wm1-f71.google.com with SMTP id g10so1485674wme.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 06:49:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LPQKzrorlkitimHazIF9B/qi3vPNIF0FGX6JapCdhOo=;
 b=qBQr3BukJn1KCp5Xsp/1wBXi0Qd6IBocrzbFV3XbcTcHy1M2MDi0DiSS/ERcVVswVw
 wUv8gP1eRNm2yP6P+yI2FXly6nBt3kAv3ZF8qCkXaQDHh2CP5l5qX/VYDf4CC95sq+NY
 lr8+vQysxq7+1Qjqe2tx6X7bejvWFrrN4wj29PHCPICMep8Hq0N2Xjq02NQ/3e8XuAbs
 Tv8nb3JM9J4lIAeeu84OqW+5OXADB9l9jB4vzZ69TDcS0vQVmDt5SgYvt1GhawvTBkO6
 zn7LCU/TcUQoq/Xs7A3/0xSdKQ1AGwfK7nYqIzeU+Uzg0t0VUZT9p1ZXd37/Bxh96nhN
 UXeA==
X-Gm-Message-State: AOAM5305XkS9Z8IO0C5+NDKPaJzOG8+cXebn8JO4f09hYvyJzODldSy0
 D6y1U11EQdrbmJJxm3RguF7d+bneztThagtc/gCNxKwLlaN0c8uGhJlFF5k0/uZbQ80msP7gxzB
 5W0pQhxZvJnQLpdk=
X-Received: by 2002:a05:600c:21c1:: with SMTP id
 x1mr5452235wmj.173.1589896187603; 
 Tue, 19 May 2020 06:49:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4urmxTzo4MRttsAT8DgPKSR9/AxjBB/MZz0D6Wmh/0GiP30bMIwYgcSRL9isrGyf9Cm6huA==
X-Received: by 2002:a05:600c:21c1:: with SMTP id
 x1mr5452212wmj.173.1589896187324; 
 Tue, 19 May 2020 06:49:47 -0700 (PDT)
Received: from steredhat.redhat.com
 (host108-207-dynamic.49-79-r.retail.telecomitalia.it. [79.49.207.108])
 by smtp.gmail.com with ESMTPSA id y10sm22348721wrd.95.2020.05.19.06.49.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 06:49:46 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] io_uring: use io_uring_cq_ready() to check for ready cqes
Date: Tue, 19 May 2020 15:49:42 +0200
Message-Id: <20200519134942.118178-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 23:19:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Julia Suvorova <jusual@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In qemu_luring_poll_cb() we are not using the cqe peeked from the
CQ ring. We are using io_uring_peek_cqe() only to see if there
are cqes ready, so we can replace it with io_uring_cq_ready().

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 block/io_uring.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/block/io_uring.c b/block/io_uring.c
index a3142ca989..bdf3dec3a1 100644
--- a/block/io_uring.c
+++ b/block/io_uring.c
@@ -277,13 +277,10 @@ static void qemu_luring_completion_cb(void *opaque)
 static bool qemu_luring_poll_cb(void *opaque)
 {
     LuringState *s = opaque;
-    struct io_uring_cqe *cqes;
 
-    if (io_uring_peek_cqe(&s->ring, &cqes) == 0) {
-        if (cqes) {
-            luring_process_completions_and_submit(s);
-            return true;
-        }
+    if (io_uring_cq_ready(&s->ring)) {
+        luring_process_completions_and_submit(s);
+        return true;
     }
 
     return false;
-- 
2.25.4


