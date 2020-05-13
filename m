Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311EECA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:12:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED9A420740
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iyLaf8pQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED9A420740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYpJA-0002Ax-40
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 07:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYpDO-0001OT-0s
 for qemu-devel@nongnu.org; Wed, 13 May 2020 07:06:18 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26787
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYpDM-0003PH-Vv
 for qemu-devel@nongnu.org; Wed, 13 May 2020 07:06:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589367976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yaieVUWyFMwIV9089m/IahT5n0ZKbqt0b1zGMkjW9Qk=;
 b=iyLaf8pQfwvH1EUxQLK60XHzGi5ElyQRa4i9PlgFuE4tv7EBhvHvw5lcGssAK7lKtTadzn
 BkulbpgtXeinehkNojh1f8eaoq7/vg1n6nvmSP+NNuHeFyH8oFrYdYX4WhU4Da5zF0pT+W
 HfPGdV4JHvAKQ7Zy20BuDxCjY+tvE6A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-7dGLNru0OB2USnzZpDrfJg-1; Wed, 13 May 2020 07:06:14 -0400
X-MC-Unique: 7dGLNru0OB2USnzZpDrfJg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1478919200C0;
 Wed, 13 May 2020 11:06:13 +0000 (UTC)
Received: from localhost (unknown [10.40.193.218])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E0D85C1C3;
 Wed, 13 May 2020 11:06:12 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 09/34] block: Rename bdrv_inherited_options()
Date: Wed, 13 May 2020 13:05:19 +0200
Message-Id: <20200513110544.176672-10-mreitz@redhat.com>
In-Reply-To: <20200513110544.176672-1-mreitz@redhat.com>
References: <20200513110544.176672-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 04:17:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The other two .inherit_options implementations specify exactly for what
case they are used in their name, so do it for this one as well.

(The actual intention behind this patch is to follow it up with a
generic bdrv_inherited_options() that works for all three cases.)

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block.c b/block.c
index b78e2dc141..a17c29f54b 100644
--- a/block.c
+++ b/block.c
@@ -1154,9 +1154,9 @@ static void bdrv_temp_snapshot_options(int *child_flags, QDict *child_options,
  * Returns the options and flags that bs->file should get if a protocol driver
  * is expected, based on the given options and flags for the parent BDS
  */
-static void bdrv_inherited_options(BdrvChildRole role, bool parent_is_format,
-                                   int *child_flags, QDict *child_options,
-                                   int parent_flags, QDict *parent_options)
+static void bdrv_protocol_options(BdrvChildRole role, bool parent_is_format,
+                                  int *child_flags, QDict *child_options,
+                                  int parent_flags, QDict *parent_options)
 {
     int flags = parent_flags;
 
@@ -1188,7 +1188,7 @@ static void bdrv_inherited_options(BdrvChildRole role, bool parent_is_format,
 const BdrvChildClass child_file = {
     .parent_is_bds   = true,
     .get_parent_desc = bdrv_child_get_parent_desc,
-    .inherit_options = bdrv_inherited_options,
+    .inherit_options = bdrv_protocol_options,
     .drained_begin   = bdrv_child_cb_drained_begin,
     .drained_poll    = bdrv_child_cb_drained_poll,
     .drained_end     = bdrv_child_cb_drained_end,
-- 
2.26.2


