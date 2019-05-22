Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4F0C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 17:09:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72A3E2081C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 17:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72A3E2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47995 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTUjo-0006rt-KT
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 13:09:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hTUfE-0003a8-Gd
	for qemu-devel@nongnu.org; Wed, 22 May 2019 13:04:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hTUfC-0007nK-DW
	for qemu-devel@nongnu.org; Wed, 22 May 2019 13:04:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59272)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hTUf8-0007VG-CK; Wed, 22 May 2019 13:04:22 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 94EC53082137;
	Wed, 22 May 2019 17:04:12 +0000 (UTC)
Received: from localhost (ovpn-204-123.brq.redhat.com [10.40.204.123])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F2D65C29A;
	Wed, 22 May 2019 17:04:09 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed, 22 May 2019 19:03:48 +0200
Message-Id: <20190522170352.12020-5-mreitz@redhat.com>
In-Reply-To: <20190522170352.12020-1-mreitz@redhat.com>
References: <20190522170352.12020-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Wed, 22 May 2019 17:04:12 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 4/8] block/commit: Drop
 bdrv_child_try_set_perm()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

commit_top_bs never requests or unshares any permissions.  There is no
reason to make this so explicit here.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 block/commit.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index 14e5bb394c..44b3083b84 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -110,8 +110,6 @@ static void commit_abort(Job *job)
      * XXX Can (or should) we somehow keep 'consistent read' blocked eve=
n
      * after the failed/cancelled commit job is gone? If we already wrot=
e
      * something to base, the intermediate images aren't valid any more.=
 */
-    bdrv_child_try_set_perm(s->commit_top_bs->backing, 0, BLK_PERM_ALL,
-                            &error_abort);
     bdrv_replace_node(s->commit_top_bs, backing_bs(s->commit_top_bs),
                       &error_abort);
=20
--=20
2.21.0


