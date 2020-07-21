Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE75C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 15:48:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 666EE20771
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 15:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h5MnBD2u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 666EE20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxuVd-00068b-Iq
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 11:48:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jxuTp-0004Vx-HL
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 11:46:57 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23343
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jxuTl-0001KP-Ot
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 11:46:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595346412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RrxtzR4DSxENttQIvS+S+S/J9BrkxDEVN+RNJP1fn/U=;
 b=h5MnBD2u5qwk9AhzimqUuCnlexM0RD4qaKEakoqnKTLqJ5lZaDb2xmDRfPObvSWA0YZhtt
 BSS814Nr5QHHUnrcOBgEiN9Sp7I0Q5GT29AHPfrURSGSuntdhuLCKsVqU5zn+HlXshLmp7
 4Pyanu/uDPhtoQ00yZhfIDT0O5Z9gdQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-IK-i1nbuNGCPTT73y_Pu7Q-1; Tue, 21 Jul 2020 11:46:49 -0400
X-MC-Unique: IK-i1nbuNGCPTT73y_Pu7Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1A228014D4;
 Tue, 21 Jul 2020 15:46:48 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-97.ams2.redhat.com [10.36.113.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BFC6C74F45;
 Tue, 21 Jul 2020 15:46:47 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 1/3] file-posix: Handle `EINVAL` fallocate return value
Date: Tue, 21 Jul 2020 17:46:35 +0200
Message-Id: <20200721154637.220022-2-kwolf@redhat.com>
In-Reply-To: <20200721154637.220022-1-kwolf@redhat.com>
References: <20200721154637.220022-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 10:17:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Antoine Damhet <antoine.damhet@blade-group.com>

The `detect-zeroes=unmap` option may issue unaligned
`FALLOC_FL_PUNCH_HOLE` requests, raw block devices can (and will) return
`EINVAL`, qemu should then write the zeroes to the blockdev instead of
issuing an `IO_ERROR`.

The problem can be reprodced like this:

$ qemu-io -c 'write -P 0 42 1234' --image-opts driver=host_device,filename=/dev/loop0,detect-zeroes=unmap
write failed: Invalid argument

Signed-off-by: Antoine Damhet <antoine.damhet@blade-group.com>
Message-Id: <20200717135603.51180-1-antoine.damhet@blade-group.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 8cc39a1ef6..9a00d4190a 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1698,7 +1698,11 @@ static int handle_aiocb_write_zeroes_unmap(void *opaque)
 #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
     int ret = do_fallocate(s->fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
                            aiocb->aio_offset, aiocb->aio_nbytes);
-    if (ret != -ENOTSUP) {
+    switch (ret) {
+    case -ENOTSUP:
+    case -EINVAL:
+        break;
+    default:
         return ret;
     }
 #endif
-- 
2.25.4


