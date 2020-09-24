Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CD6C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 15:18:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3667E20B1F
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 15:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q/7/ocNh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3667E20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLT0V-000766-4z
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 11:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kLSy0-0005Kp-RK
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:15:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25706)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kLSxz-0003kA-26
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:15:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600960526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wAIslqYciIEUl2uXSL7bq/H4x95cQ3FJq69Wr7axTFY=;
 b=Q/7/ocNh0o5tOZpP2l1Tp93rD33fXCbxw4xPJCJrw0QmdfB0iJA+8NhzEJ6Jwth30cpbHg
 VH6Ivq1qtEoEO333WxPIQW6b7iRV+oxAV4CWpX5vbN0vv6D9HbIMNM6tXxqNK89FzI6W4b
 okjmBWwg+vlMexy4123KefHI+MJYCKo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-lnL0ckBAP7uLTSTsi3GN5Q-1; Thu, 24 Sep 2020 11:15:22 -0400
X-MC-Unique: lnL0ckBAP7uLTSTsi3GN5Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9A24188C126;
 Thu, 24 Sep 2020 15:15:20 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-236.ams2.redhat.com
 [10.36.113.236])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B57217881A;
 Thu, 24 Sep 2020 15:15:12 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] docs: add 'io_uring' option to 'aio' param in qemu-options.hx
Date: Thu, 24 Sep 2020 17:15:11 +0200
Message-Id: <20200924151511.131471-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 Julia Suvorova <jusual@redhat.com>, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When we added io_uring AIO engine, we forgot to update qemu-options.hx,
so qemu(1) man page and qemu help were outdated.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 qemu-options.hx | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 47f64be0c0..5b098577fe 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1053,7 +1053,8 @@ SRST
             The path to the image file in the local filesystem
 
         ``aio``
-            Specifies the AIO backend (threads/native, default: threads)
+            Specifies the AIO backend (threads/native/io_uring,
+            default: threads)
 
         ``locking``
             Specifies whether the image file is protected with Linux OFD
@@ -1175,7 +1176,8 @@ DEF("drive", HAS_ARG, QEMU_OPTION_drive,
     "-drive [file=file][,if=type][,bus=n][,unit=m][,media=d][,index=i]\n"
     "       [,cache=writethrough|writeback|none|directsync|unsafe][,format=f]\n"
     "       [,snapshot=on|off][,rerror=ignore|stop|report]\n"
-    "       [,werror=ignore|stop|report|enospc][,id=name][,aio=threads|native]\n"
+    "       [,werror=ignore|stop|report|enospc][,id=name]\n"
+    "       [,aio=threads|native|io_uring]\n"
     "       [,readonly=on|off][,copy-on-read=on|off]\n"
     "       [,discard=ignore|unmap][,detect-zeroes=on|off|unmap]\n"
     "       [[,bps=b]|[[,bps_rd=r][,bps_wr=w]]]\n"
@@ -1247,8 +1249,8 @@ SRST
         The default mode is ``cache=writeback``.
 
     ``aio=aio``
-        aio is "threads", or "native" and selects between pthread based
-        disk I/O and native Linux AIO.
+        aio is "threads", "native", or "io_uring" and selects between pthread
+        based disk I/O, native Linux AIO, or Linux io_uring API.
 
     ``format=format``
         Specify which disk format will be used rather than detecting the
-- 
2.26.2


