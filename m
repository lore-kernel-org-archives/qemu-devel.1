Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1380AC04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 14:20:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF54C214AE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 14:20:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF54C214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36379 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSj93-00062B-Jl
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 10:20:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hSj7S-0005AW-NK
	for qemu-devel@nongnu.org; Mon, 20 May 2019 10:18:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hSj7R-00036h-Pn
	for qemu-devel@nongnu.org; Mon, 20 May 2019 10:18:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hSj7P-00035P-KO; Mon, 20 May 2019 10:18:23 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DCB2981E00;
	Mon, 20 May 2019 14:18:22 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-208.ams2.redhat.com
	[10.36.117.208])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A10E54124;
	Mon, 20 May 2019 14:18:21 +0000 (UTC)
Date: Mon, 20 May 2019 16:18:20 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190520141820.GH5699@localhost.localdomain>
References: <20190515201503.19069-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190515201503.19069-1-mreitz@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Mon, 20 May 2019 14:18:23 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/4] iotests: Make 245 faster and more
 reliable
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
Cc: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 15.05.2019 um 22:14 hat Max Reitz geschrieben:
> 245 is a bit flakey for me, because it uses block jobs that copy 1 MB o=
f
> data but have a buffer size of 512 kB, so they may be done before the
> test gets to do the things it wants to do while the check is running.
> (Rate limiting doesn=E2=80=99t change this.)
>=20
> The boring way to fix this would be to increase the amount of data.
>=20
> The interesting way to fix this is to make use of auto_finalize=3Dfalse
> and thus keep the jobs around until the test is done with them.
> However, this has one problem: In one case, 245 tries to make the targe=
t
> node of a stream job read-only.  If the job is still copying data, doin=
g
> so will fail because the target node is in COR mode.  Otherwise, we get
> a cryptic =E2=80=9CBlock node is read-only=E2=80=9D message.
>=20
> What the message means is =E2=80=9CAfter reopening, the node will be re=
ad-only,
> and that won=E2=80=99t work, because there is a writer on it.=E2=80=9D =
 It doesn=E2=80=99t say
> that, though, but it should.  So patch 1 makes it say something to that
> effect (=E2=80=9CCannot make block node read-only, there is a writer on=
 it=E2=80=9D).
>=20
> 245 doesn=E2=80=99t care about the actual error message, both reflect t=
hat qemu
> correctly detects that this node cannot be made read-only at this time.
> So the other thing we have to do is let assert_qmp() accept an array of
> valid error messages and choose the one that matches (if any).  Then we
> can just pass both error messages to it and everything works.
>=20
>=20
> Nice side effect: For me, the test duration goes down from about 12 s t=
o
> about 6 s.
> (That=E2=80=99s because the test forgot to disable rate limiting on the=
 jobs
> before waiting for their completion.)

Thanks, applied to the block branch.

Kevin

