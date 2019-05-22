Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36606C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 17:05:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A87221473
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 17:05:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A87221473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47968 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTUgO-0004F1-8Q
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 13:05:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hTUf6-0003Uw-FO
	for qemu-devel@nongnu.org; Wed, 22 May 2019 13:04:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hTUf2-0007ZN-Bd
	for qemu-devel@nongnu.org; Wed, 22 May 2019 13:04:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hTUep-0007K9-DV; Wed, 22 May 2019 13:04:04 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9D44280F91;
	Wed, 22 May 2019 17:03:56 +0000 (UTC)
Received: from localhost (ovpn-204-123.brq.redhat.com [10.40.204.123])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3600E5D9C3;
	Wed, 22 May 2019 17:03:53 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed, 22 May 2019 19:03:44 +0200
Message-Id: <20190522170352.12020-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Wed, 22 May 2019 17:04:01 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 0/8] block: Ignore loosening perm
 restrictions failures
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

Hi,

This series is mainly a fix for
https://bugzilla.redhat.com/show_bug.cgi?id=3D1703793.  The problem
described there is that mirroring to a gluster volume, then switching
off the volume makes qemu crash.  There are two problems here:

(1) file-posix reopens the FD all the time because it thinks the FD it
    has is RDONLY.  It actually isn=E2=80=99t after the first reopen, we =
just
    forgot to change the internal flags.  That=E2=80=99s what patch 1 is =
for.

(2) Even then, when mirror completes, it drops its write permission on
    the FD.  This requires a reopen, which will fail if the volume is
    down.  Mirror doesn=E2=80=99t expect that.  Nobody ever expects that
    dropping permissions can fail, and rightfully so because that=E2=80=99=
s what
    I think we have generally agreed on.
    Therefore, the block layer should hide this error.  This is what the
    last two patches are for.

The penultimate patch adds two assertions: bdrv_replace_child() (for the
old BDS) and bdrv_inactivate_recurse() assume they only ever drop
assertions.  This is now substantiated by these new assertions.
It turns out that this assumption was just plain wrong.  Patches 3 to 5
make it right.


v3:
- Received no reply to my =E2=80=9CHm, warnings break 'make check', so ma=
ybe we
  should just keep quiet if loosening restrictions fails?=E2=80=9D questi=
on, so
  I assume silence means agreement.  Changed patch 7 accordingly.

- Added a test: The fact how make check kind-of-but-not-really broke
  showed a nice reproducer: Launching qemu with some file, then deleting
  that file, then quitting qemu.

- Rebase =E2=80=9Cconflict=E2=80=9D in patch 6: The forward declaration o=
f
  bdrv_get_cumulative_perm() is already in qemu thanks to commit
  481e0eeef4f.


git-backport-diff against v2:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/8:[----] [--] 'file-posix: Update open_flags in raw_set_perm()'
002/8:[----] [--] 'block: Add bdrv_child_refresh_perms()'
003/8:[----] [--] 'block/mirror: Fix child permissions'
004/8:[----] [--] 'block/commit: Drop bdrv_child_try_set_perm()'
005/8:[0018] [FC] 'block: Fix order in bdrv_replace_child()'
       ^^^^ Again confuses my v2 patch with 8aecf1d1bd250a, should be:
      [----] : patches are identical
006/8:[0002] [FC] 'block: Add *tighten_restrictions to *check*_perm()'
007/8:[0018] [FC] 'block: Ignore loosening perm restrictions failures'
008/8:[down] 'iotests: Test failure to loosen restrictions'


Max Reitz (8):
  file-posix: Update open_flags in raw_set_perm()
  block: Add bdrv_child_refresh_perms()
  block/mirror: Fix child permissions
  block/commit: Drop bdrv_child_try_set_perm()
  block: Fix order in bdrv_replace_child()
  block: Add *tighten_restrictions to *check*_perm()
  block: Ignore loosening perm restrictions failures
  iotests: Test failure to loosen restrictions

 include/block/block_int.h  |  15 ++++
 block.c                    | 153 +++++++++++++++++++++++++++++++------
 block/commit.c             |   2 -
 block/file-posix.c         |   4 +
 block/mirror.c             |  32 +++++---
 tests/qemu-iotests/182     |  21 +++++
 tests/qemu-iotests/182.out |   6 ++
 7 files changed, 198 insertions(+), 35 deletions(-)

--=20
2.21.0


