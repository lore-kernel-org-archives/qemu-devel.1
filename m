Return-Path: <SRS0=60Ee=WH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA023C0650F
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 20:21:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CBD12085A
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 20:21:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CBD12085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sk2.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwuLO-0006Pz-Eo
	for qemu-devel@archiver.kernel.org; Sun, 11 Aug 2019 16:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46061)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <steve@sk2.org>) id 1hwtjr-000137-8l
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 15:42:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <steve@sk2.org>) id 1hwtjq-0007VN-9K
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 15:42:47 -0400
Received: from smtp5-g21.free.fr ([2a01:e0c:1:1599::14]:16206)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <steve@sk2.org>) id 1hwtjq-0007QM-0G
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 15:42:46 -0400
Received: from heffalump.sk2.org (unknown [88.186.243.14])
 by smtp5-g21.free.fr (Postfix) with ESMTPS id 401D85FFAC
 for <qemu-devel@nongnu.org>; Sun, 11 Aug 2019 21:42:36 +0200 (CEST)
Received: from steve by heffalump.sk2.org with local (Exim 4.92)
 (envelope-from <steve@sk2.org>)
 id 1hwtjz-0002aY-Tt; Sun, 11 Aug 2019 21:42:56 +0200
From: Stephen Kitt <steve@sk2.org>
To: qemu-devel@nongnu.org
Date: Sun, 11 Aug 2019 21:42:47 +0200
Message-Id: <20190811194247.9861-1-steve@sk2.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:e0c:1:1599::14
X-Mailman-Approved-At: Sun, 11 Aug 2019 16:21:04 -0400
Subject: [Qemu-devel] [PATCH] Fix hw/rdma/vmw/pvrdma_cmd.c build
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
Cc: Stephen Kitt <steve@sk2.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This was broken by the cherry-pick in 41dd30f. Fix by handling errors
as in the rest of the function: "goto out" instead of "return rc".

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 hw/rdma/vmw/pvrdma_cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
index bb9a9f1cd1..a3a86d7c8e 100644
--- a/hw/rdma/vmw/pvrdma_cmd.c
+++ b/hw/rdma/vmw/pvrdma_cmd.c
@@ -514,7 +514,7 @@ static int create_qp(PVRDMADev *dev, union pvrdma_cmd=
_req *req,
                                      cmd->recv_cq_handle, rings, &resp->=
qpn);
     if (resp->hdr.err) {
         destroy_qp_rings(rings);
-        return rc;
+        goto out;
     }
=20
     resp->max_send_wr =3D cmd->max_send_wr;
--=20
2.20.1


