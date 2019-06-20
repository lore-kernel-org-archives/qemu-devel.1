Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57345C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 01:27:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CD7E2084B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 01:27:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CD7E2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43004 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdlrp-0005bc-6s
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 21:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40725)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hdleI-0002G1-Nt
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 21:14:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hdlUk-0004kf-FS
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 21:04:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59674)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hdlUj-0004hf-2m; Wed, 19 Jun 2019 21:04:05 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4292E3162902;
 Thu, 20 Jun 2019 01:04:03 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-164.bos.redhat.com [10.18.17.164])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 650C61001DC3;
 Thu, 20 Jun 2019 01:03:57 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Wed, 19 Jun 2019 21:03:44 -0400
Message-Id: <20190620010356.19164-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Thu, 20 Jun 2019 01:04:03 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 00/12] bitmaps: introduce 'bitmap' sync mode
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 vsementsov@virtuozzo.com, Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series adds a new "BITMAP" sync mode that is meant to replace the
existing "INCREMENTAL" sync mode.

This mode can be changed by issuing any of three bitmap sync modes;
passed as arguments to the job.

The three bitmap sync modes are:
- CONDITIONAL: This is an alias for the old incremental mode. The bitmap =
is
               conditionally synchronized based on the return code of the=
 job
               upon completion.
- NEVER: This is, effectively, the differential backup mode. It never cle=
ars
         the bitmap, as the name suggests.
- ALWAYS: Here is the new, exciting thing. The bitmap is always synchroni=
zed,
          even on failure. On success, this is identical to incremental, =
but
          on failure it clears only the bits that were copied successfull=
y.
          This can be used to "resume" incremental backups from later poi=
nts
          in times.

I wrote this series by accident on my way to implement incremental mode
for mirror, but this happened first -- the problem is that Mirror mode
uses its existing modes in a very particular way; and this was the best
way to add bitmap support into the mirror job properly.

In this series:
patches 1-2: Adds CONDITIONAL
patch 3: Adds NEVER
Patches 4-7: Adds ALWAYS.
Patches 8-11: Adds iotest 257
Patch 12: Minor permission loosening for RO bitmaps.

Next up:
 - Add these modes to Mirror. (Done*, but need tests.)
 - Allow the use of bitmaps and bitmap sync modes with non-BITMAP modes;
   This will allow for resumable/re-tryable full backups.

John Snow (12):
  qapi: add BitmapSyncMode enum
  block/backup: Add mirror sync mode 'bitmap'
  block/backup: add 'never' policy to bitmap sync mode
  hbitmap: Fix merge when b is empty, and result is not an alias of a
  hbitmap: enable merging across granularities
  block/dirty-bitmap: add bdrv_dirty_bitmap_claim
  block/backup: add 'always' bitmap sync policy
  iotests: add testing shim for script-style python tests
  iotests: teach run_job to cancel pending jobs
  iotests: teach FilePath to produce multiple paths
  iotests: add test 257 for bitmap-mode backups
  block/backup: loosen restriction on readonly bitmaps

 qapi/block-core.json          |   51 +-
 include/block/block_int.h     |    7 +-
 include/qemu/hbitmap.h        |    8 +
 block/backup.c                |   52 +-
 block/dirty-bitmap.c          |   14 +
 block/mirror.c                |    6 +-
 block/replication.c           |    2 +-
 blockdev.c                    |   12 +-
 util/hbitmap.c                |   36 +-
 tests/qemu-iotests/257        |  412 ++++++
 tests/qemu-iotests/257.out    | 2199 +++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group      |    1 +
 tests/qemu-iotests/iotests.py |   83 +-
 13 files changed, 2830 insertions(+), 53 deletions(-)
 create mode 100755 tests/qemu-iotests/257
 create mode 100644 tests/qemu-iotests/257.out

--=20
2.21.0


