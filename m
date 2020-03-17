Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1591CC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:28:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D190920714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="ljKIDIND"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D190920714
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEF4r-00077x-3S
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 12:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59586)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1jEEmQ-0002CW-Oc
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:09:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1jEEmO-0003PO-Jg
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:09:22 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:60319)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jEEmO-0003IJ-0m
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:09:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=O3C1DWiovOlIFXopWonrU5czWPELFVg5RjnELw3g5DU=; b=ljKIDIND+8WGk1+VBrZIEPvH0v
 2vs6tQHKhzCJCQI3pWaSKgkLxgHb1zpLChoy/MlggbCF5l+IiAYUq8uf0kwy8n/4bAMA17fICXr2l
 TAp3UiD1Y5O4PPRBGzFM8P2EktOzvqDG3E4M7nXHjllFZsDhPbdViss5+a3f3n03ze7SYvWDxb8uN
 cUnvsSjx+B8TYL2qUS5/MfzEbkL5cWKOZMyogytsAgNTXj1AP99RTjB9oNdX0EAYHrxiBMAWX9kMW
 5cj4FfbMKqb1PoL/FycSGanQnQIF1L4V5ZrBmyz7FeDVBYpJatuROIXJnmP9thNG8EzNd1cd0t09Q
 B374tIVSCG3L9Dq07wO0f9HTK+U/kRHSmttyfF5mdIb1O8emqc5s+G8/So3pT5sklN0DdliVi1h26
 pG4imRA4Qxix5yer2QBzs/7aXFvkiMv31oEUd0tVLSjk5kCTesAzSNF/LP8hC5+i74AyK2JY7y3SV
 d5pFbPtBkO+PEct5JPWGE5Pk6kSwcMbvVgwR+lJPG+i2Vm3pY/4RLltyM+4Qi7WpqTQHjzjHOIAWb
 0BYHmVGz6z1XjSqTSp4XYgtlhyHNR1LPK6mz3ROuQRBpf48cBDFitjvMFpXTgv7tKW82YnhIC/M3B
 0s3j+zX78fPm8J44xvRisXpQ4VM361xgOjuT4B220=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v4 10/11] 9pfs: T_readdir latency optimization
Date: Tue, 17 Mar 2020 17:09:16 +0100
Message-ID: <3151790.FkRGVyreOq@silver>
In-Reply-To: <20200317151423.14fc43d9@bahia.lan>
References: <cover.1579567019.git.qemu_oss@crudebyte.com>
 <3047810.ezBau4JpT1@silver> <20200317151423.14fc43d9@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.189.157.229
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Dienstag, 17. M=E4rz 2020 15:14:23 CET Greg Kurz wrote:
> > > > I think the cause of disagreements we have are solely our use cases=
 of
> > > > 9pfs: your personal use case does not seem to require any performan=
ce
> > > > considerations or multi-user aspects, whereas my use case requires =
at
> > > > least some minimum performance grade for utilizing 9pfs for server
> > > > applications.
> > >=20
> > > Your point about the personal use case is right indeed but our
> > > disagreements, if any, aren't uniquely related to that. It's more abo=
ut
> > > maintainership and available time really. I'm 100% benevolent "Odd
> > > fixer"
> > > now and I just try to avoid being forced into fixing things after my =
PR
> > > is
> > > merged. If you want to go faster, then you're welcome to upgrade to
> > > maintainer and send PRs. This would make sense since you care for 9p,
> > > you
> > > showed a good understanding of the code and you provided beneficial
> > > contributions so far :)
> >=20
> > That maintainership upgrade is planned. The question is just when. What
> > was
> > your idea, co-maintainership?
>=20
> Basically yes.

Ok, I'll send out a MAINTAINERS patch tomorrow or so to make that
co-maintainer upgrade official. But I obviously still need a while to learn=
=20
the bureaucracy involved for PRs, signing, ML tools, Wiki, etc.

> > > > > Ok, fair enough to leave 9p2000.U behind for now but I had to ask=
 :)
> > > > > /me is even wondering if we should start deprecating 9p2000.U sin=
ce
> > > > > most clients can use 9p2000.L now...
> > > >=20
> > > > I probably wouldn't. On macOS for instance there's only 9p2000.u. In
> > > > the
> > > > end
> > >=20
> > > Hmm... the only thing I've heard about is:
> > >=20
> > > https://github.com/benavento/mac9p
> > >=20
> > > and unless I'm missing something, this seems to only have a socket ba=
sed
> > > transport... the server in QEMU is for virtio-9p and Xen 9p devices
> > > only.
> > > Unless mac9p seriously plans to implement a driver for either of thos=
e,
> > > I'm still not convinced it is worth keeping .U around... and BTW, our
> > > deprecation policy imposes a 2 QEMU versions cooling period before
> > > actually removing the code. This would leave ample time for someone
> > > to speak up.
> >=20
> > Well, I leave that up to you. I could consider adding a transport for
> > macOS
> > guests, but that's definitely not going to happen in any near future.
>=20
> The whole idea behind dropping support for .U is really just about
> reducing the potential attack surface. But I'm also fine to keep
> things as is until the next CVE since I'm confident someone will
> help ;-)

Sure, sounds like a plan!

> > > > > > the loop. The normal case is not requiring a lock at all, like =
the
> > > > > > comment
> > > > > > describes. Doing multiple locks inside the loop unnecessaririly
> > > > > > reduces
> > > > > > performance for no reason.
> > > > > >=20
> > > > > > About *_trylock() instead of v9fs_readdir_lock(): might be a
> > > > > > candidate
> > > > > > to
> > > > >=20
> > > > > Hmm... are you suggesting that do_readdir_lowlat() should return =
if
> > > > > it
> > > > > can't take the lock ?
> > > >=20
> > > > ... yep, that's what I had in mind for it later on. I would not mind
> > > > running trylock in a loop like you suggested; if it fails, log a
> > > > warning
> > > > and return. Because if the lock fails, then client is buggy. User c=
an
> > > > read the warning in the logs and report the bug for client to be
> > > > fixed.
> > > > Not worth to handle that case in any fancy way by server.
> > >=20
> > > The locking is just a safety net because readdir(3) isn't necessarily
> > > thread safe. It was never my intention to add an error path for that.
> > > And thinking again, sending concurrent Treaddir requests on the same
> > > fid is certainly a weird thing to do but is it really a bug ?
> >=20
> > Well, I was unresolved on that issue as well, hence my decision to only
> > leave a TODO comment for now. My expectation would be separate fid for
> > concurrent readdir, but you are right of course, Treaddir (unlike its
> > 9p2000.u counterpart) is reentrant by design, since it has an offset
> > parameter, so from protocol perspective concurrent Treaddir is not per =
se
> > impossible.
> >=20
> > The lock would not be noticable either with this patch, since unlike on
> > master, the lock is just retained on driver side now (with this patch),
> > which returns very fast even on large directories, as you can see from
> > the benchmark output.
> >=20
> > So yes, returning from function with an error is probably not the best
> > choice. My tendency is still though logging a message at least. I don't
> > care about that too much though to deal with trylock() in a loop or
> > something right now. There are more important things to take care of AT=
M.
>=20
> Yeah, that can wait.

Okay.

The only thing I actually still need to figure out for this patch series to=
 be=20
complete (at least from my side), is how to fix the test environment bug=20
discussed. Probably I can reset the test environment's buffer after every t=
est=20
somehow ...

Best regards,
Christian Schoenebeck



