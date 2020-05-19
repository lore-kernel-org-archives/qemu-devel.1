Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF59C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 13:36:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DA5F20709
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 13:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UAa9qOyj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DA5F20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb2QJ-0006Td-Ew
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 09:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60944)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1jb2Kd-00047B-7D
 for qemu-devel@nongnu.org; Tue, 19 May 2020 09:30:55 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25177
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1jb2Ka-0000ve-Vu
 for qemu-devel@nongnu.org; Tue, 19 May 2020 09:30:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589895051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hTxqq6p8ttwYFb2VujGvAIJEthYi+cSfp/DVMM8sKOM=;
 b=UAa9qOyjl0248K6TGcrfj3c8TEQcnk58/rhQhmvR5Y3evn+KwuLJPwkV/WWsyG6z5P17FC
 8O8GFiDIW8CEFwo8bZakwWeCP3p3VlRiv6wtf/MdxqR37mQL7iVfDcztRGPhALfoS1xH7r
 FFv1vsp2sPq/ttJ/D99/+2nDGSBtfdQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-vEsQNhllOhiZC0sv2BDWig-1; Tue, 19 May 2020 09:30:47 -0400
X-MC-Unique: vEsQNhllOhiZC0sv2BDWig-1
Received: by mail-wr1-f72.google.com with SMTP id i9so7329910wrx.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 06:30:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hTxqq6p8ttwYFb2VujGvAIJEthYi+cSfp/DVMM8sKOM=;
 b=Bi8fWj+hHWckvsNYVj5kJ1Zrqy2CIqbEafqCYmTSnK8jXT6FvFugle2qHZUQAaMNME
 FwyWYqIfQxNa8QLvmgZGPbvauDoTSaR2+M1j8nke6H7lLtunm6OvnyQOFT2p/QbfqMv8
 67ot0f+oHmS7VlGuapHmAm0wc5uCALuIxv089ykLwdTJgXlR0+9Mng18OpVytLrzYgLD
 Nmk4/tyKZ7ax4UCPs+LprAci1cdQPaFfr7Dhc2jXQlD7tePnhuT9N/1l92gKRAWS5ElW
 /hJuRM9aWZmyo9BGxFpLEu/3zTbs0JMOi6FFt1giSagttnQWXRNbGHRdQlE2Znb0bis7
 rXNQ==
X-Gm-Message-State: AOAM5323ej+GW5CabEji7PR2JDKbUfU6LfziM66zWGOecZx523VK52AH
 acrvwFq/rq603/4VqjXhpXiyXOzsFWLMinovW5OPv6ojJjWKfzpJjB6jCvOzmFPC3tfJ2i7Y74U
 KpRz8W3AumNGNinw=
X-Received: by 2002:a05:6000:10c3:: with SMTP id
 b3mr26494698wrx.53.1589895045232; 
 Tue, 19 May 2020 06:30:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbxyyN+DSHtc+3Y8wBM+ETMhLMJuO+Lbdxmx9n1Wlw9svCJn+4bnIYkhaU0+NbMxPr0xAd0w==
X-Received: by 2002:a05:6000:10c3:: with SMTP id
 b3mr26494679wrx.53.1589895044929; 
 Tue, 19 May 2020 06:30:44 -0700 (PDT)
Received: from steredhat.redhat.com
 (host108-207-dynamic.49-79-r.retail.telecomitalia.it. [79.49.207.108])
 by smtp.gmail.com with ESMTPSA id 18sm3777218wmj.19.2020.05.19.06.30.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 06:30:44 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] io_uring: retry io_uring_submit() if it fails with errno=EINTR
Date: Tue, 19 May 2020 15:30:41 +0200
Message-Id: <20200519133041.112138-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 00:34:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

As recently documented [1], io_uring_enter(2) syscall can return an
error (errno=EINTR) if the operation was interrupted by a delivery
of a signal before it could complete.

This should happen when IORING_ENTER_GETEVENTS flag is used, for
example during io_uring_submit_and_wait() or during io_uring_submit()
when IORING_SETUP_IOPOLL is enabled.

We shouldn't have this problem for now, but it's better to prevent it.

[1] https://github.com/axboe/liburing/commit/344355ec6619de8f4e64584c9736530b5346e4f4

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 block/io_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/io_uring.c b/block/io_uring.c
index a3142ca989..9765681f7c 100644
--- a/block/io_uring.c
+++ b/block/io_uring.c
@@ -231,7 +231,7 @@ static int ioq_submit(LuringState *s)
         trace_luring_io_uring_submit(s, ret);
         /* Prevent infinite loop if submission is refused */
         if (ret <= 0) {
-            if (ret == -EAGAIN) {
+            if (ret == -EAGAIN || ret == -EINTR) {
                 continue;
             }
             break;
-- 
2.25.4


