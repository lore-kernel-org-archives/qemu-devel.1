Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96874C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 19:05:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B223217D7
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 19:05:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B223217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48657 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPApo-0000PG-LQ
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 15:05:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hPAne-0007Vm-SD
	for qemu-devel@nongnu.org; Fri, 10 May 2019 15:03:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hPAnc-0005u2-Tx
	for qemu-devel@nongnu.org; Fri, 10 May 2019 15:03:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>)
	id 1hPAnZ-0005r7-Is; Fri, 10 May 2019 15:03:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 434FA13A5C;
	Fri, 10 May 2019 19:03:12 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-164.bos.redhat.com [10.18.17.164])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 529065ED4A;
	Fri, 10 May 2019 19:03:11 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Date: Fri, 10 May 2019 15:03:04 -0400
Message-Id: <20190510190307.17647-2-jsnow@redhat.com>
In-Reply-To: <20190510190307.17647-1-jsnow@redhat.com>
References: <20190510190307.17647-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Fri, 10 May 2019 19:03:12 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 1/4] blockdev-backup: don't check
 aio_context too early
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
Cc: Kevin Wolf <kwolf@redhat.com>, aihua liang <aliang@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, qemu-stable@nongnu.org,
	Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
 blockdev.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 79fbac8450..a81d88980c 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1872,10 +1872,6 @@ static void blockdev_backup_prepare(BlkActionState=
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
2.20.1


