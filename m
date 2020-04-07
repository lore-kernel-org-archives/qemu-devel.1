Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F6AC2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 11:59:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B35E2051A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 11:59:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B35E2051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLmtI-0005qK-OH
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 07:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56911)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <s.reiter@proxmox.com>) id 1jLmrH-0002gf-F1
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:57:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <s.reiter@proxmox.com>) id 1jLmrG-0007W1-DM
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:57:35 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:7324)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <s.reiter@proxmox.com>)
 id 1jLmrE-0007S0-68; Tue, 07 Apr 2020 07:57:32 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id BA59E457B5;
 Tue,  7 Apr 2020 13:57:21 +0200 (CEST)
From: Stefan Reiter <s.reiter@proxmox.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Subject: [PATCH for-5.0 v5 0/3] Fix some AIO context locking in jobs
Date: Tue,  7 Apr 2020 13:56:48 +0200
Message-Id: <20200407115651.69472-1-s.reiter@proxmox.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.186.127.180
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, t.lamprecht@proxmox.com,
 slp@redhat.com, mreitz@redhat.com, stefanha@redhat.com, jsnow@redhat.com,
 dietmar@proxmox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Contains three seperate but related patches cleaning up and fixing some
issues regarding aio_context_acquire/aio_context_release for jobs. Mostly
affects blockjobs running for devices that have IO threads enabled AFAICT=
.


Changes from v4:
* Do job_ref/job_unref in job_txn_apply and job_exit since we need the jo=
b to
  survive the callback to access the potentially changed lock afterwards
* Reduce patch 2/3 to an assert, the context should already be acquired s=
ince
  it's a bdrv handler
* Collect R-by for 3/3

I've marked it 'for-5.0' this time, I think it would make sense to be
picked up together with Kevin's "block: Fix blk->in_flight during
blk_wait_while_drained()" series. With that series and these three patche=
s
applied I can no longer reproduce any of the reported related crashes/han=
gs.


Changes from v3:
* commit_job appears to be unset in certain cases when replication_close =
is
  called, only access when necessary to avoid SIGSEGV

Missed this when shuffling around patches, sorry for noise with still-bro=
ken v3.

Changes from v2:
* reordered patch 1 to the end to not introduce temporary breakages
* added more fixes to job txn patch (should now pass the tests)

Changes from v1:
* fixed commit message for patch 1
* added patches 2 and 3


qemu: Stefan Reiter (3):
  job: take each job's lock individually in job_txn_apply
  replication: assert we own context before job_cancel_sync
  backup: don't acquire aio_context in backup_clean

 block/backup.c        |  4 ----
 block/replication.c   |  5 ++++-
 blockdev.c            |  9 ++++++++
 job-qmp.c             |  9 ++++++++
 job.c                 | 50 ++++++++++++++++++++++++++++++++++---------
 tests/test-blockjob.c |  2 ++
 6 files changed, 64 insertions(+), 15 deletions(-)

--=20
2.26.0


