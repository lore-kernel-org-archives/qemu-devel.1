Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2FEC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 10:58:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55D6520717
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 10:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZiQHJtjy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55D6520717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwO43-00076s-Lc
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 06:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jwO0o-0001Pu-IV
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 06:54:42 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36912
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jwO0m-0004Sf-SK
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 06:54:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594983279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YS8LID4pdMqe3cFHW+uHJoMP+wERKy7cl5zNWXXEbpY=;
 b=ZiQHJtjyN/O9VNls+uo0q3gPA5a45vWNSLOCZRxdQiKqLxwp7lc5y2OtVxKqyUkG6LV7hB
 Ah7rjRDrDiBpOmHQ+kcpbHu8u3DtXnJkQMGDkIMjFCUhzP4I56itW79PvnxCEIdAnYLBHr
 LDuhimAFoTc1TgmmNDdjxXyeFF1B7E8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-qlibcSbwNZWqG1RSLcXCpA-1; Fri, 17 Jul 2020 06:54:37 -0400
X-MC-Unique: qlibcSbwNZWqG1RSLcXCpA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE3BA1888AB0;
 Fri, 17 Jul 2020 10:54:36 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-80.ams2.redhat.com [10.36.113.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C52106FED1;
 Fri, 17 Jul 2020 10:54:35 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.1 3/3] file-posix: Fix leaked fd in raw_open_common()
 error path
Date: Fri, 17 Jul 2020 12:54:26 +0200
Message-Id: <20200717105426.51134-4-kwolf@redhat.com>
In-Reply-To: <20200717105426.51134-1-kwolf@redhat.com>
References: <20200717105426.51134-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 01:33:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index 659f780570..b2ed9d7eb2 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -749,6 +749,9 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
     }
     ret = 0;
 fail:
+    if (ret < 0 && s->fd != -1) {
+        qemu_close(s->fd);
+    }
     if (filename && (bdrv_flags & BDRV_O_TEMPORARY)) {
         unlink(filename);
     }
-- 
2.25.4


