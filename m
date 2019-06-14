Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E89C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 13:53:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B8512084E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 13:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B8512084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51738 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbmdr-0000WV-E2
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 09:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46291)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hbmRd-0001dF-F0
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:40:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hbmRc-0005ol-AQ
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:40:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44781)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hbmRW-0005jG-Bj; Fri, 14 Jun 2019 09:40:34 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B45D72EED2D;
 Fri, 14 Jun 2019 13:40:25 +0000 (UTC)
Received: from localhost (unknown [10.40.205.125])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 426507F464;
 Fri, 14 Jun 2019 13:40:25 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 14 Jun 2019 15:40:02 +0200
Message-Id: <20190614134021.32486-2-mreitz@redhat.com>
In-Reply-To: <20190614134021.32486-1-mreitz@redhat.com>
References: <20190614134021.32486-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Fri, 14 Jun 2019 13:40:30 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 01/20] blockdev-backup: don't check aio_context
 too early
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

From: John Snow <jsnow@redhat.com>

in blockdev_backup_prepare, we check to make sure that the target is
associated with a compatible aio context. However, do_blockdev_backup is
called later and has some logic to move the target to a compatible
aio_context. The transaction version will fail certain commands
needlessly early as a result.

Allow blockdev_backup_prepare to simply call do_blockdev_backup, which
will ultimately decide if the contexts are compatible or not.

Note: the transaction version has always disallowed this operation since
its initial commit bd8baecd (2014), whereas the version of
qmp_blockdev_backup at the time, from commit c29c1dd312f, tried to
enforce the aio_context switch instead. It's not clear, and I can't see
from the mailing list archives at the time, why the two functions take a
different approach. It wasn't until later in efd7556708b (2016) that the
standalone version tried to determine if it could set the context or
not.

Reported-by: aihua liang <aliang@redhat.com>
Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1683498
Signed-off-by: John Snow <jsnow@redhat.com>
Message-id: 20190523170643.20794-2-jsnow@redhat.com
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 blockdev.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 3f44b891eb..fdafa173cc 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1876,10 +1876,6 @@ static void blockdev_backup_prepare(BlkActionState=
 *common, Error **errp)
     }
=20
     aio_context =3D bdrv_get_aio_context(bs);
-    if (aio_context !=3D bdrv_get_aio_context(target)) {
-        error_setg(errp, "Backup between two IO threads is not implement=
ed");
-        return;
-    }
     aio_context_acquire(aio_context);
     state->bs =3D bs;
=20
--=20
2.21.0


