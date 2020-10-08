Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1B3C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 19:02:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A28B207DE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 19:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GOlWO45A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A28B207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQbBP-0001GF-2r
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 15:02:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kQb92-0007sa-Bm
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 15:00:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45975)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kQb8y-0003eh-Q9
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 15:00:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602183600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rMbqo0xt+T/OQzwlre+9lBBzOy3KdXiaGhZEG3FlEfc=;
 b=GOlWO45AinmphwLyCb+3Ii2AnZoJwgJT7RJoZ6FJPLdZVGonLZXVbtX8WrKh5OJdurUL1r
 CcQhGrj+FJH1qcZioSF5XyvswJuZiaW69p+mEyT0+l/s/fwcIKkDh4YW1Cot93RIXn2+nV
 Ij82l4gM6/QDkT+VfQ7ml9/QebZAVVA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-DV8XQzGrMcikI7NI_t6FGQ-1; Thu, 08 Oct 2020 14:59:56 -0400
X-MC-Unique: DV8XQzGrMcikI7NI_t6FGQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0C131018F83;
 Thu,  8 Oct 2020 18:59:54 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-14.phx2.redhat.com [10.3.113.14])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5FA0A5D9E8;
 Thu,  8 Oct 2020 18:59:54 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/8] nbd: silence maybe-uninitialized warnings
Date: Thu,  8 Oct 2020 13:59:44 -0500
Message-Id: <20201008185951.1026052-2-eblake@redhat.com>
In-Reply-To: <20201008185951.1026052-1-eblake@redhat.com>
References: <20201008185951.1026052-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 02:56:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

gcc 10 from Fedora 32 gives me:

Compiling C object libblock.fa.p/nbd_server.c.o
../nbd/server.c: In function ‘nbd_co_client_start’:
../nbd/server.c:625:14: error: ‘namelen’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
  625 |         rc = nbd_negotiate_send_info(client, NBD_INFO_NAME, namelen, name,
      |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  626 |                                      errp);
      |                                      ~~~~~
../nbd/server.c:564:14: note: ‘namelen’ was declared here
  564 |     uint32_t namelen;
      |              ^~~~~~~
cc1: all warnings being treated as errors

As I cannot see how this can happen, let uns silence the warning.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Message-Id: <20200930155859.303148-3-borntraeger@de.ibm.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nbd/server.c b/nbd/server.c
index f74766add7b7..f25cffa334fa 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -556,7 +556,7 @@ static int nbd_negotiate_handle_info(NBDClient *client, Error **errp)
     NBDExport *exp;
     uint16_t requests;
     uint16_t request;
-    uint32_t namelen;
+    uint32_t namelen = 0;
     bool sendname = false;
     bool blocksize = false;
     uint32_t sizes[3];
-- 
2.28.0


