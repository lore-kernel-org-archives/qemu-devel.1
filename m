Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CCCC433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 23:42:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 755DE206A3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 23:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRq/GR6E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 755DE206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htKid-00072W-OV
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 19:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60080)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1htKhB-0005JN-LV
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 19:41:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1htKhA-0002X9-QG
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 19:41:17 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:41292)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1htKhA-0002WX-Jq; Thu, 01 Aug 2019 19:41:16 -0400
Received: by mail-pf1-x442.google.com with SMTP id m30so34964590pff.8;
 Thu, 01 Aug 2019 16:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kq+GocMZNBzs7h+JrH4HUXS6sT3wW7TSwegih8ayQCc=;
 b=iRq/GR6EwHoD+MuyWgZ5RKCxUU45yxdpe8G6Dh8WARNBMYllQ3iYRLFYBtEtGf45Fl
 M2EEwS2gM/RrEIIPa6DK6A2lpyGeaDhOMJ5o7N3uFIy9kaNVcFogKMbnlPuxkdzBXAZ1
 bn+S9DXu/0uUmlp2nfK6pHqW95BXnkx29jZ9iFLVhulRb1wXcAP+psGNVwoDzPjRveM6
 j7zTZuTSby0LRzeVu3QkLlcHrfqCL7aBjdO3QCei1AsepLw0C4nfZhybiH8JsSfoeh1P
 qBH2n0/b7Yk7f0venYs+NMWzoZDDtjmrLt2idsht/oPSCobT6lRGNK3mGaULRnc7Jpe1
 ENUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kq+GocMZNBzs7h+JrH4HUXS6sT3wW7TSwegih8ayQCc=;
 b=U6+Ej7yhX8Jd8GDxEj1TMeGxm0K0dxJMnwpSlVzExtyQBlKNXHg292WooAJwe1sIni
 lZzio8DilSyT1eRbSNymsZBHIoudDsJHQfV7yglROKNNAZmBtuxGJo6I426FbmCtxwJw
 j8nyZqGy7krNISDxG4Q00yQq0yjghDnZFHnuFf45RDtDaJrryd8HKHX59Lyl6TbD4LuI
 PC046+PqLT0+P00StJLgg0BEw2s2M/NSYQkdWY4cd6KcusBmGHC/Nq4UMIiQiCDI8Vd0
 sA1PljRtOSt5LE3Mt7izg04tcggQn0s2Ux1vb4ZcqpsXXgA6w1bsOtiGu9TzBPa5Axie
 jb2w==
X-Gm-Message-State: APjAAAUuCY3cLSYz2Wkuszx+yRBGm8XsY8Ox3ojmLB32E76oDzpuZgAH
 bVE2g6JE0P7LCYDWEKPgjBmgaG7tWPZ7Hw==
X-Google-Smtp-Source: APXvYqyQ6ojcmIVH3UvGUs5/DI7u/lEkVqLkgbXfItztus3TbN1qCnE476el9yjaQoS0eUPTZ9yR3w==
X-Received: by 2002:a62:1616:: with SMTP id 22mr57310422pfw.120.1564702875261; 
 Thu, 01 Aug 2019 16:41:15 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:572:3de5:765:cb16:92cd:ee3e])
 by smtp.gmail.com with ESMTPSA id
 g18sm117975426pgm.9.2019.08.01.16.41.10
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 01 Aug 2019 16:41:14 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri,  2 Aug 2019 05:10:16 +0530
Message-Id: <20190801234031.29561-3-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190801234031.29561-1-mehta.aaru20@gmail.com>
References: <20190801234031.29561-1-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v9 02/17] qapi/block-core: add option for
 io_uring
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 saket.sinha89@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefan@redhat.com>, Julia Suvorova <jusual@mail.ru>,
 Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Only enumerates option for devices that support it. Since QAPI schema
supports io_uring, which is the actual name of the Linux API, it is
preferred over io-uring.

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 qapi/block-core.json | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 0d43d4f37c..3dc93b483f 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2792,11 +2792,13 @@
 #
 # @threads:     Use qemu's thread pool
 # @native:      Use native AIO backend (only Linux and Windows)
+# @io_uring:    Use linux io_uring (since 4.2)
 #
 # Since: 2.9
 ##
 { 'enum': 'BlockdevAioOptions',
-  'data': [ 'threads', 'native' ] }
+  'data': [ 'threads', 'native',
+            { 'name': 'io_uring', 'if': 'defined(CONFIG_LINUX_IO_URING)' } ] }
 
 ##
 # @BlockdevCacheOptions:
-- 
2.21.0


