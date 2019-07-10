Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9EBC73C65
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 01:09:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAEB620645
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 01:09:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAEB620645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl16V-0002GT-69
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 21:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49257)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hl13t-0000VB-Oc
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 21:06:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hl13m-0004T5-Vn
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 21:06:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57000)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hl13h-0004Jh-56; Tue, 09 Jul 2019 21:06:11 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 43C9E3082AED;
 Wed, 10 Jul 2019 01:06:07 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-215.bos.redhat.com [10.18.17.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7BCD61001B19;
 Wed, 10 Jul 2019 01:06:06 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 21:05:54 -0400
Message-Id: <20190710010556.32365-7-jsnow@redhat.com>
In-Reply-To: <20190710010556.32365-1-jsnow@redhat.com>
References: <20190710010556.32365-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Wed, 10 Jul 2019 01:06:07 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 6/8] block/backup: issue progress updates for
 skipped regions
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The way bitmap backups work is by starting at 75% if it needs
to copy just 25% of the disk.

The way sync=3Dtop currently works, however, is to start at 0% and then
never update the progress if it doesn't copy a region. If it needs to
copy 25% of the disk, we'll finish at 25%.

Update the progress when we skip regions.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/backup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/backup.c b/block/backup.c
index a64b768e24..38c4a688c6 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -417,6 +417,7 @@ static int coroutine_fn backup_loop(BackupBlockJob *j=
ob)
         if (job->sync_mode =3D=3D MIRROR_SYNC_MODE_TOP &&
             bdrv_is_unallocated_range(bs, offset, job->cluster_size))
         {
+            job_progress_update(&job->common.job, job->cluster_size);
             bdrv_reset_dirty_bitmap(job->copy_bitmap, offset,
                                     job->cluster_size);
             continue;
--=20
2.21.0


