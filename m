Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2B0C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 10:24:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA2D2207F7
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 10:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D8Y5Q7Ej"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA2D2207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRYWH-00007W-4q
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 06:24:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kRYUC-0006AR-Nd
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 06:21:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23567)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kRYUA-0002ik-Nj
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 06:21:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602411709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WS7e9eNz1602z5VO6+Cnu6hlA9RATysActZiIZR+G9U=;
 b=D8Y5Q7EjctumjDUAYwSCvWVi/DBL1eGTblv7B5GPrrPAxeBQQdlQocFcNnK+chXz/1YBNy
 HWLJwlpAIC069nAeBSaleon9xcX2UP87TxFw3wleKUY4cTabOHroaT53TO+Mep9ui67RZT
 QgBPBhZicu947JkwftJZuQhI+mEDiAs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-kWjCIBUJOyqhKlXgVWwvtg-1; Sun, 11 Oct 2020 06:21:47 -0400
X-MC-Unique: kWjCIBUJOyqhKlXgVWwvtg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1DF5100746B;
 Sun, 11 Oct 2020 10:21:46 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.35.206.144])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D32526EF55;
 Sun, 11 Oct 2020 10:21:44 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] block: qcow2: remove the created file on
 initialization error
Date: Sun, 11 Oct 2020 13:21:36 +0300
Message-Id: <20201011102136.622361-3-mlevitsk@redhat.com>
In-Reply-To: <20201011102136.622361-1-mlevitsk@redhat.com>
References: <20201011102136.622361-1-mlevitsk@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlevitsk@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 06:21:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If the qcow initialization fails after we created the storage file,
we should remove it to avoid leaving stale files around.

We already do this for luks raw images.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 block/qcow2.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/block/qcow2.c b/block/qcow2.c
index b05512718c..4dc6102df8 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3834,6 +3834,18 @@ static int coroutine_fn qcow2_co_create_opts(BlockDriver *drv,
     /* Create the qcow2 image (format layer) */
     ret = qcow2_co_create(create_options, errp);
     if (ret < 0) {
+
+        Error *local_delete_err = NULL;
+        int r_del = bdrv_co_delete_file(bs, &local_delete_err);
+        /*
+         * ENOTSUP will happen if the block driver doesn't support
+         * the 'bdrv_co_delete_file' interface. This is a predictable
+         * scenario and shouldn't be reported back to the user.
+         */
+        if ((r_del < 0) && (r_del != -ENOTSUP)) {
+            error_report_err(local_delete_err);
+        }
+        error_free(local_delete_err);
         goto finish;
     }
 
-- 
2.26.2


