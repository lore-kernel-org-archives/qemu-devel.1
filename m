Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254DEC31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 15:31:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1B8B21880
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 15:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1B8B21880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39468 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdcYG-0000Nn-5w
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 11:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42385)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hdcTs-000372-2I
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 11:26:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hdcTq-000299-ON
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 11:26:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56482)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hdcTn-0001wH-NZ; Wed, 19 Jun 2019 11:26:31 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0E5F730C1AE7;
 Wed, 19 Jun 2019 15:26:10 +0000 (UTC)
Received: from localhost (ovpn-116-121.ams2.redhat.com [10.36.116.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 54B36601B6;
 Wed, 19 Jun 2019 15:26:05 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed, 19 Jun 2019 17:25:54 +0200
Message-Id: <20190619152603.5937-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Wed, 19 Jun 2019 15:26:10 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 0/9] block: Delay poll when ending drained
 sections
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This is v2 to =E2=80=9Cblock: Keep track of parent quiescing=E2=80=9D.

Please read this cover letter, because I=E2=80=99m very unsure about the =
design
in this series and I=E2=80=99d appreciate some comments.

As Kevin wrote in his reply to that series, the actual problem is that
bdrv_drain_invoke() polls on every node whenever ending a drain.  This
may cause graph changes, which is actually forbidden.

To solve that problem, this series makes the drain code construct a list
of undrain operations that have been initiated, and then polls all of
them on the root level once graph changes are acceptable.

Note that I don=E2=80=99t like this list concept very much, so I=E2=80=99=
m open to
alternatives.

Furthermore, all BdrvChildRoles with BDS parents have a broken
.drained_end() implementation.  The documentation clearly states that
this function is not allowed to poll, but it does.  So this series
changes it to a variant (using the new code) that does not poll.

There is a catch, which may actually be a problem, I don=E2=80=99t know: =
The new
variant of that .drained_end() does not poll at all, never.  As
described above, now every bdrv_drain_invoke() returns an object that
describes when it will be done and which can thus be polled for.  These
objects are just discarded when using BdrvChildRole.drained_end().  That
does not feel quite right.  It would probably be more correct to let
BdrvChildRole.drained_end() return these objects so the top level
bdrv_drained_end() can poll for their completion.

I decided not to do this, for two reasons:
(1) Doing so would spill the =E2=80=9Clist of objects to poll for=E2=80=9D=
 design to
    places outside of block/io.c.  I don=E2=80=99t like the design very m=
uch as
    it is, but I can live with it as long as it=E2=80=99s constrained to =
the
    core drain code in block/io.c.
    This is made worse by the fact that currently, those objects are of
    type BdrvCoDrainData.  But it shouldn=E2=80=99t be a problem to add a=
 new
    type that is externally visible (we only need the AioContext and
    whether bdrv_drain_invoke_entry() is done).

(2) It seems to work as it is.

The alternative would be to add the same GSList ** parameter to
BdrvChildRole.drained_end() that I added in the core drain code in patch
2, and then let the .drained_end() implementation fill that with objects
to poll for.  (Which would be accomplished by adding a frontend to
bdrv_do_drained_end() that lets bdrv_child_cb_drained_poll() pass the
parameter through.)

Opinions?


And then we have bdrv_replace_child_noperm(), which actually wants a
polling BdrvChildRole.drained_end().  So this series adds
BdrvChildRole.drained_end_unquiesce(), which takes that role (if there
is any polling to do).

Note that if I implemented the alternative described above
(.drained_end() gets said GSList ** parameter), a
.drained_end_unquiesce() wouldn=E2=80=99t be necessary.
bdrv_parent_drained_end_single() could just poll the list returned by
.drained_end() by itself.


Finally, patches 1, 8, and 9 are unmodified from v1.


git backport-diff against v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/9:[----] [--] 'block: Introduce BdrvChild.parent_quiesce_counter'
002/9:[down] 'block: Add @data_objs to bdrv_drain_invoke()'
003/9:[down] 'block: Add bdrv_poll_drain_data_objs()'
004/9:[down] 'block: Move polling out of bdrv_drain_invoke()'
005/9:[down] 'block: Add @poll to bdrv_parent_drained_end_single()'
006/9:[down] 'block: Add bdrv_drained_end_no_poll()'
007/9:[down] 'block: Fix BDS children's .drained_end()'
008/9:[----] [--] 'iotests: Add @has_quit to vm.shutdown()'
009/9:[----] [--] 'iotests: Test commit with a filter on the chain'


Max Reitz (9):
  block: Introduce BdrvChild.parent_quiesce_counter
  block: Add @data_objs to bdrv_drain_invoke()
  block: Add bdrv_poll_drain_data_objs()
  block: Move polling out of bdrv_drain_invoke()
  block: Add @poll to bdrv_parent_drained_end_single()
  block: Add bdrv_drained_end_no_poll()
  block: Fix BDS children's .drained_end()
  iotests: Add @has_quit to vm.shutdown()
  iotests: Test commit with a filter on the chain

 include/block/block.h      |  22 +++++-
 include/block/block_int.h  |  23 ++++++
 block.c                    |  24 +++---
 block/io.c                 | 155 ++++++++++++++++++++++++++++++-------
 python/qemu/__init__.py    |   5 +-
 tests/qemu-iotests/040     |  40 +++++++++-
 tests/qemu-iotests/040.out |   4 +-
 tests/qemu-iotests/255     |   2 +-
 8 files changed, 231 insertions(+), 44 deletions(-)

--=20
2.21.0


