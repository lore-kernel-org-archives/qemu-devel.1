Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4AAC4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 13:18:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46B5B20731
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 13:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="sPG72ua8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46B5B20731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUVYo-00085F-B0
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 09:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46662)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jUVY1-0006oD-Bk
 for qemu-devel@nongnu.org; Fri, 01 May 2020 09:17:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jUVWO-0005jB-F9
 for qemu-devel@nongnu.org; Fri, 01 May 2020 09:17:44 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:45537)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jUVWN-0005Z7-KO; Fri, 01 May 2020 09:16:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From;
 bh=RNJtcWkynC0eMNt0IZCR5t/x6Na8L/ag+KK36WUFHGQ=; 
 b=sPG72ua8GnChH34m4jAaFXk7VYIhv71PGRc6xjpXA6+uRoV+OBp37qPHi1TKpRWjt4W8gny5Mb4uDSIdnfwnMb6bYJiwEC2Fo+kio+q17Rwrv+BtYpPowm+aY/LJJwyZf3kYHw7IXzxMK6Ufw1fn6QXm/R+qL8OlEpqRWZMxqn4POQTPQBWkSZ75Sdky8EctzbaeeBW1aWMsHK30YP482tREhIbIzgk2AjDwltojdJMT2q19eK9X0ainuPMlUAMRDyzeBVW6InUivdKB/v4enlwP1thf2Wlle+CmWhHn8iG2Toa+0Jx3EUR29ex79IH6Exg+oy/UGU3s+cn7O3yk8g==;
Received: from static.47.37.0.81.ibercom.com ([81.0.37.47] helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jUVW0-0007B5-2J; Fri, 01 May 2020 15:15:40 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jUVVm-0001lZ-TT; Fri, 01 May 2020 15:15:26 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] qcow2: Avoid integer wraparound in qcow2_co_truncate()
Date: Fri,  1 May 2020 15:15:25 +0200
Message-Id: <20200501131525.6745-1-berto@igalia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 09:15:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Received-From: 178.60.130.6
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

After commit f01643fb8b47e8a70c04bbf45e0f12a9e5bc54de when an image is
extended and BDRV_REQ_ZERO_WRITE is set then the new clusters are
zeroized.

The code however does not detect correctly situations when the old and
the new end of the image are within the same cluster. The problem can
be reproduced with these steps:

   qemu-img create -f qcow2 backing.qcow2 1M
   qemu-img create -f qcow2 -b backing.qcow2 top.qcow2
   qemu-img resize --shrink top.qcow2 520k
   qemu-img resize top.qcow2 567k

In the last step offset - zero_start causes an integer wraparound.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/qcow2.c b/block/qcow2.c
index 2ba0b17c39..6d34d28c60 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4234,6 +4234,9 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
     if ((flags & BDRV_REQ_ZERO_WRITE) && offset > old_length) {
         uint64_t zero_start = QEMU_ALIGN_UP(old_length, s->cluster_size);
 
+        /* zero_start should not be after the new end of the image */
+        zero_start = MIN(zero_start, offset);
+
         /*
          * Use zero clusters as much as we can. qcow2_cluster_zeroize()
          * requires a cluster-aligned start. The end may be unaligned if it is
-- 
2.20.1


