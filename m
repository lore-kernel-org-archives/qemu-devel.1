Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E05C83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 14:15:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DAA120B80
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 14:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lg5MZ530"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DAA120B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTnUT-0002Dp-37
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 10:15:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44612)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTnRH-0004ZC-DO
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:11:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTnRH-00045M-0S
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:11:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57055
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jTnRG-00045E-IU
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:11:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588169509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+JfwS4rDpAdfjq6rnTazzWwBEOj7DlcLQ3maGcEHnmo=;
 b=Lg5MZ530CuQtTmIk0j0jvxFW7lOzUHW7VlDwW/zoK8S+NYVzAcHZtPGYLOHQ9R/dqtaAb5
 fFAM/B7La2q37Yrba4r3EI809/kwzYfC8t3nz6xVqefrT66+Yv/i89N6qp3FXJTXDlhmeL
 NBmAHR/CK7PPen28th4DkjBVg+AQ7+o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-oxTgmQrXOtKL2VwXh0QJ2g-1; Wed, 29 Apr 2020 10:11:35 -0400
X-MC-Unique: oxTgmQrXOtKL2VwXh0QJ2g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7AACF100CCE4;
 Wed, 29 Apr 2020 14:11:34 +0000 (UTC)
Received: from localhost (ovpn-113-19.ams2.redhat.com [10.36.113.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DA7B1001281;
 Wed, 29 Apr 2020 14:11:33 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 3/4] block: Add blk_make_empty()
Date: Wed, 29 Apr 2020 16:11:25 +0200
Message-Id: <20200429141126.85159-4-mreitz@redhat.com>
In-Reply-To: <20200429141126.85159-1-mreitz@redhat.com>
References: <20200429141126.85159-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:42:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Two callers of BlockDriver.bdrv_make_empty() remain that should not call
this method directly.  Both do not have access to a BdrvChild, but they
can use a BlockBackend, so we add this function that lets them use it.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/sysemu/block-backend.h |  2 ++
 block/block-backend.c          | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.=
h
index 0917663d89..8203d7f6f9 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -266,4 +266,6 @@ int coroutine_fn blk_co_copy_range(BlockBackend *blk_in=
, int64_t off_in,
=20
 const BdrvChild *blk_root(BlockBackend *blk);
=20
+int blk_make_empty(BlockBackend *blk, Error **errp);
+
 #endif
diff --git a/block/block-backend.c b/block/block-backend.c
index f4944861fa..47bd56244d 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -2402,3 +2402,13 @@ const BdrvChild *blk_root(BlockBackend *blk)
 {
     return blk->root;
 }
+
+int blk_make_empty(BlockBackend *blk, Error **errp)
+{
+    if (!blk_is_available(blk)) {
+        error_setg(errp, "No medium inserted");
+        return -ENOMEDIUM;
+    }
+
+    return bdrv_make_empty(blk->root, errp);
+}
--=20
2.25.4


