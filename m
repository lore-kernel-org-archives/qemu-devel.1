Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D743C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:25:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7367320B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7367320B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIXV7-0003zC-Af
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 08:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51998)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIWrF-0006pW-I6
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:43:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIWrE-0008IC-CZ
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:43:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:20545)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIWrB-0008GR-UA; Thu, 10 Oct 2019 07:43:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2A85A20E9;
 Thu, 10 Oct 2019 11:43:45 +0000 (UTC)
Received: from localhost (unknown [10.36.118.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C4D9C5DA2C;
 Thu, 10 Oct 2019 11:43:44 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 19/36] block: add empty account cookie type
Date: Thu, 10 Oct 2019 13:42:43 +0200
Message-Id: <20191010114300.7746-20-mreitz@redhat.com>
In-Reply-To: <20191010114300.7746-1-mreitz@redhat.com>
References: <20191010114300.7746-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Thu, 10 Oct 2019 11:43:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Anton Nefedov <anton.nefedov@virtuozzo.com>

Each block_acct_done/failed call is designed to correspond to a
previous block_acct_start call, which initializes the stats cookie.
However sometimes it is not the case, e.g. some error paths might
report the same cookie twice because it is hard to accurately track if
the cookie was reported yet or not.

This patch cleans the cookie after report.
(Note: block_acct_failed/done without a previous block_acct_start at
all should be avoided. Uninitialized cookie might hold a garbage value
and there is still "< BLOCK_MAX_IOTYPE" assertion for that)

It will be particularly useful in ide code where it's hard to
keep track whether the request done its accounting or not: in the
following patch of the series, trim requests will do the accounting
separately.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20190923121737.83281-4-anton.nefedov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/accounting.h | 1 +
 block/accounting.c         | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/include/block/accounting.h b/include/block/accounting.h
index ba8b04d572..878b4c3581 100644
--- a/include/block/accounting.h
+++ b/include/block/accounting.h
@@ -33,6 +33,7 @@ typedef struct BlockAcctTimedStats BlockAcctTimedStats;
 typedef struct BlockAcctStats BlockAcctStats;
=20
 enum BlockAcctType {
+    BLOCK_ACCT_NONE =3D 0,
     BLOCK_ACCT_READ,
     BLOCK_ACCT_WRITE,
     BLOCK_ACCT_FLUSH,
diff --git a/block/accounting.c b/block/accounting.c
index 70a3d9a426..8d41c8a83a 100644
--- a/block/accounting.c
+++ b/block/accounting.c
@@ -195,6 +195,10 @@ static void block_account_one_io(BlockAcctStats *sta=
ts, BlockAcctCookie *cookie,
=20
     assert(cookie->type < BLOCK_MAX_IOTYPE);
=20
+    if (cookie->type =3D=3D BLOCK_ACCT_NONE) {
+        return;
+    }
+
     qemu_mutex_lock(&stats->lock);
=20
     if (failed) {
@@ -217,6 +221,8 @@ static void block_account_one_io(BlockAcctStats *stat=
s, BlockAcctCookie *cookie,
     }
=20
     qemu_mutex_unlock(&stats->lock);
+
+    cookie->type =3D BLOCK_ACCT_NONE;
 }
=20
 void block_acct_done(BlockAcctStats *stats, BlockAcctCookie *cookie)
--=20
2.21.0


