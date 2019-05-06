Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24918C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 19:49:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F053720830
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 19:49:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F053720830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33184 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNjcS-0005Gx-3O
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 15:49:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hNjam-0004Mg-KV
	for qemu-devel@nongnu.org; Mon, 06 May 2019 15:48:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hNjal-0001px-DG
	for qemu-devel@nongnu.org; Mon, 06 May 2019 15:48:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hNjai-0001lQ-Uj; Mon, 06 May 2019 15:48:01 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8B26FA405A;
	Mon,  6 May 2019 19:47:59 +0000 (UTC)
Received: from localhost (ovpn-204-185.brq.redhat.com [10.40.204.185])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E2E85DA5B;
	Mon,  6 May 2019 19:47:55 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon,  6 May 2019 21:47:46 +0200
Message-Id: <20190506194753.12464-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Mon, 06 May 2019 19:47:59 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/7] block: Ignore loosening perm restrictions
 failures
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


Max Reitz (7):
  file-posix: Update open_flags in raw_set_perm()
  block: Add bdrv_child_refresh_perms()
  block/mirror: Fix child permissions
  block/commit: Drop bdrv_child_try_set_perm()
  block: Fix order in bdrv_replace_child()
  block: Add *loosen_restrictions to *check*_perm()
  block: Ignore loosening perm restrictions failures

 include/block/block_int.h |  15 ++++
 block.c                   | 143 ++++++++++++++++++++++++++++++++------
 block/commit.c            |   2 -
 block/file-posix.c        |   3 +
 block/mirror.c            |  32 ++++++---
 5 files changed, 161 insertions(+), 34 deletions(-)

--=20
2.20.1


