Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29A1C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 08:09:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E406B20724
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 08:09:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E406B20724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXgW2-0004fd-Mt
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 04:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kXgUm-0003yE-N7
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 04:07:48 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:35788)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kXgUl-00069u-03
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 04:07:48 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-c8vNvxLkPAeSOTyyt22uoQ-1; Wed, 28 Oct 2020 04:07:42 -0400
X-MC-Unique: c8vNvxLkPAeSOTyyt22uoQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5EFED801F95;
 Wed, 28 Oct 2020 08:07:41 +0000 (UTC)
Received: from [192.168.1.34] (ovpn-115-161.ams2.redhat.com [10.36.115.161])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E934955793;
 Wed, 28 Oct 2020 08:07:35 +0000 (UTC)
Subject: [PATCH] block: Move bdrv_drain_all_end_quiesce() to block_int.h
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Oct 2020 09:07:34 +0100
Message-ID: <160387245480.131299.13430357162209598411.stgit@bahia>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=groug@kaod.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=207.211.30.44; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-44.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 04:07:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This function is really an internal helper for bdrv_close(). Update its
doc comment to make this clear and make the function private.

Signed-off-by: Greg Kurz <groug@kaod.org>
---

As suggested by Stefan here:

https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg08235.html
---
 include/block/block.h     |    6 ------
 include/block/block_int.h |    9 +++++++++
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 809987017631..d16c401cb44e 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -779,12 +779,6 @@ void bdrv_drained_end(BlockDriverState *bs);
  */
 void bdrv_drained_end_no_poll(BlockDriverState *bs, int *drained_end_count=
er);
=20
-/**
- * End all quiescent sections started by bdrv_drain_all_begin(). This is
- * only needed when deleting a BDS before bdrv_drain_all_end() is called.
- */
-void bdrv_drain_all_end_quiesce(BlockDriverState *bs);
-
 /**
  * End a quiescent section started by bdrv_subtree_drained_begin().
  */
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 38cad9d15c50..95d9333be14f 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1407,4 +1407,13 @@ static inline BlockDriverState *bdrv_primary_bs(Bloc=
kDriverState *bs)
     return child_bs(bdrv_primary_child(bs));
 }
=20
+/**
+ * End all quiescent sections started by bdrv_drain_all_begin(). This is
+ * needed when deleting a BDS before bdrv_drain_all_end() is called.
+ *
+ * NOTE: this is an internal helper for bdrv_close() *only*. No one else
+ * should call it.
+ */
+void bdrv_drain_all_end_quiesce(BlockDriverState *bs);
+
 #endif /* BLOCK_INT_H */



