Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCD3C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:24:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC309208C4
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C1NtguON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC309208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j43n6-00061Q-MU
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 09:24:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53302)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j43YA-00087U-CA
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j43Y9-0001hh-6y
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51753
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j43Y9-0001hO-28
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582034912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g5nZm9va4Pa7pjKjHP0dcg1FTAVCxORWlyvxrrNh3S8=;
 b=C1NtguONIpwcgEBHS2DZmJ0/vKY8q+EI1p43N8gbvwA8rTalNUrMLYCWdwEoeS8lHG/yq4
 FUXz/FdrqCLKY0h+0z0mG7jrEv97Yw0HzZdDxU0yFHmRbEKK3rFGMntZGexYxjoVpsWIIU
 q3YrD7elxKFvnmkNKp3GhBzsslRVr/Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-1lB3mEwWNOmBsyimzTnhmA-1; Tue, 18 Feb 2020 09:08:27 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B65D18FE860;
 Tue, 18 Feb 2020 14:08:26 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-181.ams2.redhat.com
 [10.36.117.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7146D19E9C;
 Tue, 18 Feb 2020 14:08:25 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 26/36] block: Use bdrv_recurse_can_replace()
Date: Tue, 18 Feb 2020 15:07:12 +0100
Message-Id: <20200218140722.23876-27-kwolf@redhat.com>
In-Reply-To: <20200218140722.23876-1-kwolf@redhat.com>
References: <20200218140722.23876-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 1lB3mEwWNOmBsyimzTnhmA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

Let check_to_replace_node() use the more specialized
bdrv_recurse_can_replace() instead of
bdrv_recurse_is_first_non_filter(), which is too restrictive (or, in the
case of quorum, sometimes not restrictive enough).

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20200218103454.296704-10-mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/block.c b/block.c
index e2fefe5883..80a0806eb0 100644
--- a/block.c
+++ b/block.c
@@ -6272,6 +6272,17 @@ bool bdrv_recurse_can_replace(BlockDriverState *bs,
     return false;
 }
=20
+/*
+ * Check whether the given @node_name can be replaced by a node that
+ * has the same data as @parent_bs.  If so, return @node_name's BDS;
+ * NULL otherwise.
+ *
+ * @node_name must be a (recursive) *child of @parent_bs (or this
+ * function will return NULL).
+ *
+ * The result (whether the node can be replaced or not) is only valid
+ * for as long as no graph or permission changes occur.
+ */
 BlockDriverState *check_to_replace_node(BlockDriverState *parent_bs,
                                         const char *node_name, Error **err=
p)
 {
@@ -6296,8 +6307,11 @@ BlockDriverState *check_to_replace_node(BlockDriverS=
tate *parent_bs,
      * Another benefit is that this tests exclude backing files which are
      * blocked by the backing blockers.
      */
-    if (!bdrv_recurse_is_first_non_filter(parent_bs, to_replace_bs)) {
-        error_setg(errp, "Only top most non filter can be replaced");
+    if (!bdrv_recurse_can_replace(parent_bs, to_replace_bs)) {
+        error_setg(errp, "Cannot replace '%s' by a node mirrored from '%s'=
, "
+                   "because it cannot be guaranteed that doing so would no=
t "
+                   "lead to an abrupt change of visible data",
+                   node_name, parent_bs->node_name);
         to_replace_bs =3D NULL;
         goto out;
     }
--=20
2.20.1


