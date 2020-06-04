Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6B7C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 09:45:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E08F206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 09:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Po4ERa8j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E08F206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgmRN-0007oK-9p
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 05:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1jgmQP-0006kE-Gg
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 05:44:37 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20016
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1jgmQO-0004Tr-QR
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 05:44:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591263874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jOsEi/g7jTgDofbCy6CYq7qnzg2t9JhITnLHHzED3m8=;
 b=Po4ERa8jX8H+oN24/o14PlZ28AWYg/eY23iA2Ka4pbc8XoPHRdeQDbjXIOaAD1kuWoEKEX
 OBPlldPZTKLEgG8wZSfYBSAmsHQsfWxVbUuzTHwikyb2bD7+VtNm7yegJR0ZcXxeKa+N2E
 ihNyeK+DmjwVvvvgpibcb2ue/WIl3I4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-0cWiqBPdPGinVjsqvgPgkg-1; Thu, 04 Jun 2020 05:44:30 -0400
X-MC-Unique: 0cWiqBPdPGinVjsqvgPgkg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3996800685;
 Thu,  4 Jun 2020 09:44:29 +0000 (UTC)
Received: from localhost (unknown [10.36.110.61])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 90E01579A3;
 Thu,  4 Jun 2020 09:44:26 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] qga: fix assert regression on guest-shutdown
Date: Thu,  4 Jun 2020 11:44:25 +0200
Message-Id: <20200604094425.63020-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:08:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit 781f2b3d1e ("qga: process_event() simplification"),
send_response() is called unconditionally, but will assert when "rsp" is
NULL. This may happen with QCO_NO_SUCCESS_RESP commands, such as
"guest-shutdown".

Fixes: 781f2b3d1e5ef389b44016a897fd55e7a780bf35
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
Reported-by: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qga/main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/qga/main.c b/qga/main.c
index f0e454f28d3..3febf3b0fdf 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -531,7 +531,11 @@ static int send_response(GAState *s, const QDict *rsp)
     QString *payload_qstr, *response_qstr;
     GIOStatus status;
 
-    g_assert(rsp && s->channel);
+    g_assert(s->channel);
+
+    if (!rsp) {
+        return 0;
+    }
 
     payload_qstr = qobject_to_json(QOBJECT(rsp));
     if (!payload_qstr) {
-- 
2.26.2.561.g07d8ea56f2


