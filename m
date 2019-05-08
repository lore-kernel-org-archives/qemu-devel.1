Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCA8C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 18:27:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95D26205ED
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 18:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95D26205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41454 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hORI1-0005kd-MD
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 14:27:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hORGO-0004LL-8T
	for qemu-devel@nongnu.org; Wed, 08 May 2019 14:25:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hORGN-0002xm-1i
	for qemu-devel@nongnu.org; Wed, 08 May 2019 14:25:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hORGK-0002kC-3J; Wed, 08 May 2019 14:25:52 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 655718110D;
	Wed,  8 May 2019 18:25:51 +0000 (UTC)
Received: from localhost (ovpn-204-94.brq.redhat.com [10.40.204.94])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BF07862672;
	Wed,  8 May 2019 18:25:48 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed,  8 May 2019 20:25:39 +0200
Message-Id: <20190508182546.2239-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Wed, 08 May 2019 18:25:51 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 0/7] block: Ignore loosening perm
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
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

The last patch adds two assertions: bdrv_replace_child() (for the old
BDS) and bdrv_inactivate_recurse() assume they only ever drop
assertions.  This is now substantiated by these new assertions.
It turns out that this assumption was just plain wrong.  Patches 3 to 5
make it right.


v2:
- Patch 1: Set s->perm_change_flags for reopen, too [Kevin]
- Patch 6:
  - Rename loosen_restrictions to tighten_restrictions and kind of
    invert its meaning [Kevin]
  - Assert and document that we cannot return useful information about
    whether restrictions are loosened or tightened if the caller wants
    to reopen the node [Kevin]
- Patch 7: Handle loosen_restrictions -> tighten_restrictions fallout


git backport-diff output against v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/7:[0001] [FC] 'file-posix: Update open_flags in raw_set_perm()'
002/7:[----] [--] 'block: Add bdrv_child_refresh_perms()'
003/7:[----] [--] 'block/mirror: Fix child permissions'
004/7:[----] [--] 'block/commit: Drop bdrv_child_try_set_perm()'
005/7:[0018] [FC] 'block: Fix order in bdrv_replace_child()'
       ^^^^ Confuses my v1 patch with 8aecf1d1bd250a, should be:
      [----] [--]
006/7:[down] 'block: Add *tighten_restrictions to *check*_perm()'
       ^^^^ Commit title has changed, but should be something like:
      [0061] [FC]
007/7:[0022] [FC] 'block: Ignore loosening perm restrictions failures'


Max Reitz (7):
  file-posix: Update open_flags in raw_set_perm()
  block: Add bdrv_child_refresh_perms()
  block/mirror: Fix child permissions
  block/commit: Drop bdrv_child_try_set_perm()
  block: Fix order in bdrv_replace_child()
  block: Add *tighten_restrictions to *check*_perm()
  block: Ignore loosening perm restrictions failures

 include/block/block_int.h |  15 ++++
 block.c                   | 151 ++++++++++++++++++++++++++++++++------
 block/commit.c            |   2 -
 block/file-posix.c        |   4 +
 block/mirror.c            |  32 +++++---
 5 files changed, 169 insertions(+), 35 deletions(-)

--=20
2.20.1


