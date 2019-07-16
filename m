Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87523C7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 14:40:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F6C620880
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 14:40:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F6C620880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnOdD-0002kh-HE
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 10:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45645)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hnOd2-0002M0-FX
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 10:40:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hnOd0-00061h-7l
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 10:40:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:16230)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hnOcx-0005ta-Ec; Tue, 16 Jul 2019 10:40:23 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 29D1B307D84B;
 Tue, 16 Jul 2019 14:40:22 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-24.ams2.redhat.com [10.36.117.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F8A71001B2C;
 Tue, 16 Jul 2019 14:40:18 +0000 (UTC)
Date: Tue, 16 Jul 2019 16:40:16 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190716144016.GE7297@linux.fritz.box>
References: <20190619152603.5937-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190619152603.5937-1-mreitz@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Tue, 16 Jul 2019 14:40:22 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 0/9] block: Delay poll when ending
 drained sections
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 19.06.2019 um 17:25 hat Max Reitz geschrieben:
> Hi,
>=20
> This is v2 to =E2=80=9Cblock: Keep track of parent quiescing=E2=80=9D.
>=20
> Please read this cover letter, because I=E2=80=99m very unsure about th=
e design
> in this series and I=E2=80=99d appreciate some comments.
>=20
> As Kevin wrote in his reply to that series, the actual problem is that
> bdrv_drain_invoke() polls on every node whenever ending a drain.  This
> may cause graph changes, which is actually forbidden.
>=20
> To solve that problem, this series makes the drain code construct a lis=
t
> of undrain operations that have been initiated, and then polls all of
> them on the root level once graph changes are acceptable.
>=20
> Note that I don=E2=80=99t like this list concept very much, so I=E2=80=99=
m open to
> alternatives.

So drain_end is different from drain_begin in that it wants to wait only
for all bdrv_drain_invoke() calls to complete, but not for other
requests that are in flight. Makes sense.

Though instead of managing a whole list, wouldn't a counter suffice?

> Furthermore, all BdrvChildRoles with BDS parents have a broken
> .drained_end() implementation.  The documentation clearly states that
> this function is not allowed to poll, but it does.  So this series
> changes it to a variant (using the new code) that does not poll.
>=20
> There is a catch, which may actually be a problem, I don=E2=80=99t know=
: The new
> variant of that .drained_end() does not poll at all, never.  As
> described above, now every bdrv_drain_invoke() returns an object that
> describes when it will be done and which can thus be polled for.  These
> objects are just discarded when using BdrvChildRole.drained_end().  Tha=
t
> does not feel quite right.  It would probably be more correct to let
> BdrvChildRole.drained_end() return these objects so the top level
> bdrv_drained_end() can poll for their completion.
>=20
> I decided not to do this, for two reasons:
> (1) Doing so would spill the =E2=80=9Clist of objects to poll for=E2=80=
=9D design to
>     places outside of block/io.c.  I don=E2=80=99t like the design very=
 much as
>     it is, but I can live with it as long as it=E2=80=99s constrained t=
o the
>     core drain code in block/io.c.
>     This is made worse by the fact that currently, those objects are of
>     type BdrvCoDrainData.  But it shouldn=E2=80=99t be a problem to add=
 a new
>     type that is externally visible (we only need the AioContext and
>     whether bdrv_drain_invoke_entry() is done).
>=20
> (2) It seems to work as it is.
>=20
> The alternative would be to add the same GSList ** parameter to
> BdrvChildRole.drained_end() that I added in the core drain code in patc=
h
> 2, and then let the .drained_end() implementation fill that with object=
s
> to poll for.  (Which would be accomplished by adding a frontend to
> bdrv_do_drained_end() that lets bdrv_child_cb_drained_poll() pass the
> parameter through.)
>=20
> Opinions?

I think I would add an int* to BdrvChildRole.drained_end() so that we
can just increase the counter whereever we need to.

> And then we have bdrv_replace_child_noperm(), which actually wants a
> polling BdrvChildRole.drained_end().  So this series adds
> BdrvChildRole.drained_end_unquiesce(), which takes that role (if there
> is any polling to do).
>=20
> Note that if I implemented the alternative described above
> (.drained_end() gets said GSList ** parameter), a
> .drained_end_unquiesce() wouldn=E2=80=99t be necessary.
> bdrv_parent_drained_end_single() could just poll the list returned by
> .drained_end() by itself.

The split between .drained_end/.drained_end_unquiesce feels wrong. It
shouldn't be the job of the BdrvChildRole to worry about this. Polling
should be handled inside bdrv_parent_drained_end_single(), like we do in
bdrv_parent_drained_begin_single(), so that the BdrvChildRole never has
to poll.

> Finally, patches 1, 8, and 9 are unmodified from v1.
> [...]
>=20
>  include/block/block.h      |  22 +++++-
>  include/block/block_int.h  |  23 ++++++
>  block.c                    |  24 +++---
>  block/io.c                 | 155 ++++++++++++++++++++++++++++++-------
>  python/qemu/__init__.py    |   5 +-
>  tests/qemu-iotests/040     |  40 +++++++++-
>  tests/qemu-iotests/040.out |   4 +-
>  tests/qemu-iotests/255     |   2 +-
>  8 files changed, 231 insertions(+), 44 deletions(-)

I feel this series should add something to tests/test-bdrv-drain.c, too.
qemu-iotests can only test high-level block job commands that happen to
trigger the bug today, but that code may change in the future. Unit
tests allow us to test the problematic cases more directly.

Kevin

