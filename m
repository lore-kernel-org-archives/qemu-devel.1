Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA8CC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 15:13:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE46B20727
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 15:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="pKBQiuG2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE46B20727
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBgZd-0003HE-0W
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 11:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55856)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1jBgWt-0007G1-48
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 11:10:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1jBgWr-0005j5-1c
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 11:10:46 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:42177)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jBgWq-0005Yk-GI
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 11:10:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=XLVSFPAhfyc6r9DBj7+GItSI8pVcZm4xZEhpsjpyDM4=; b=pKBQiuG2BZZ1qoxMSGARb5aVKZ
 IUURyMdHUawX5YazlK7unnRhxLQewdhXzsDeU3pDOnq0Uvm2CsyCrIytYJa/CTYjLz39YDvhE68Y5
 AGM6js/HBGO1Xl9JMnPgqJvBtqnEuseY4UjBrxcI7VB1N+6tQHH13MxjEwsQpgj0z3jeCZ5o9ZQ+K
 hTNZ/4EMXBXvOlQ5+YrgA9WhPwMJXBzWGM4jyPE7moWukL1g7k7b8jxFJAhA4dVZbao7dsKmvMFEn
 +FtxnQDGYRTrfhXtyYSWCQUHBn43ibgJb3jdDLy1qVQjdsYWh/Mja8SycmSNOfMLM5NOaFS2dtq/o
 TXcZeFWNb5v8iHqcyQYzedcvR06You+NyHAI/YoMayKXhJipzsBIqv9A0dRGYhehKemb/a7njc+Uk
 nPMvZu0XSMMvFJWxMMgkC64ptA3SBj71zKWPRmctLAhCNH3ErMqPefiu5akzzwT3HEBwAFuCrqhIz
 08bKwEkrq48iWhPnDHQbQVVsr2KKE58BD2Kc3jF67g3nb14angwfQHjJZiPZtwGs8NPm45ZJJ/rlK
 lZm+NqclqlbcOgscuV7xMFSgsILadly9HFNZv90YFw+8d1w6PsFCBEWJh1ZCtAdzddQQnDs3wOS/1
 aL/E480Gt0/I0rn8vA7Y6L4eUzRXTK+l8TDxe8Xko=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v4 10/11] 9pfs: T_readdir latency optimization
Date: Tue, 10 Mar 2020 16:10:41 +0100
Message-ID: <1651612.bE1MAdl4rA@silver>
In-Reply-To: <20200309164259.2affe4bc@bahia.home>
References: <cover.1579567019.git.qemu_oss@crudebyte.com>
 <1706149.tZr2OiJYdg@silver> <20200309164259.2affe4bc@bahia.home>
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

On Montag, 9. M=E4rz 2020 16:42:59 CET Greg Kurz wrote:
> The main issue I see with this patch is that it is too big. At
> least from my POV, with the little time I have for 9p, that's
> the first thing that pushes me back... So if you could split
> this patch down to some reviewable chunks, this may help
> going forward.

This patch is also too big for my preference, but I don't see a viable way =
to=20
split it further into separate patches. I already separated all the patches=
 I=20
could. If you have suggestions, very much appreciated!

The reason for this is that in order to fix these issues with current=20
T_readdir implementation, it requires to separate what's currently one task=
=20
(i.e. one function) into two separate tasks (i.e. two functions). There is =
no=20
sensible way to do that.

But don't be too scared about this patch; if you look just at the diff=20
directly then yes, the diff is not very human readable. However if you appl=
y=20
the patch and look at the resulting code, you'll notice that there are=20
actually only 2 functions (v9fs_do_readdir() in 9p.c and do_readdir_lowlat(=
)=20
in codir.c) which require careful reviewing and that their resulting code i=
s=20
actually very, very straight forward, and not long either.

Current code on master is much more tricky and error prone due to the huge=
=20
amount of potential branches, individual error/cleanup handlers, high amoun=
t=20
of thread dispatching and much more. In the patched version all these code=
=20
complexities and error sources are removed.

> > > diff --git a/hw/9pfs/codir.c b/hw/9pfs/codir.c
> > > index 73f9a751e1..6ce7dc8cde 100644
> > > --- a/hw/9pfs/codir.c
> > > +++ b/hw/9pfs/codir.c
> > > @@ -18,28 +18,189 @@
> > >=20
> > >  #include "qemu/main-loop.h"
> > >  #include "coth.h"
> > >=20
> > > +/*
> > > + * This is solely executed on a background IO thread.
> > > + */
> > > +static int do_readdir(V9fsPDU *pdu, V9fsFidState *fidp, struct dirent
> > > **dent) +{
> > > +    int err =3D 0;
> > > +    V9fsState *s =3D pdu->s;
> > > +    struct dirent *entry;
> > > +
> > > +    errno =3D 0;
> > > +    entry =3D s->ops->readdir(&s->ctx, &fidp->fs);
> > > +    if (!entry && errno) {
> > > +        *dent =3D NULL;
> > > +        err =3D -errno;
> > > +    } else {
> > > +        *dent =3D entry;
> > > +    }
> > > +    return err;
> > > +}
> > > +
> > > +/*
> > > + * TODO: This will be removed for performance reasons.
> > > + * Use v9fs_co_readdir_lowlat() instead.
>=20
> Oh, so we'd still have the current implementation being used, even
> with this patch applied... This would be okay for a RFC patch but
> in the end I'd really like to merge something that also converts
> v9fs_do_readdir_with_stat().

Yes, I know, but I would not recommend mixing these things at this point,=20
because it would be an entire effort on its own.

v9fs_do_readdir_with_stat() is used for 9P2000.u, while v9fs_do_readdir() i=
s=20
used for 9P2000.L. They're behaving very differently, so it would not only=
=20
require me to update v9fs_do_readdir_with_stat() and v9fs_read(), I would a=
lso=20
need to write their own test cases (plural, since there are none at all yet=
)=20
and benchmarks, and of course somebody what need to review all that additio=
nal=20
amount of code, and who would actually test it? I am actively testing my=20
9P2000.L changes, but I am not actually using 9P2000.u, so I could not=20
guarantee for the same quality.

Considering the current commitment situation regarding 9pfs, we can only br=
ing=20
things forward with compromises. Hence I suggest I concentrate on fixing th=
e=20
worst performance issues on 9P2000.L side first, and later on if there are=
=20
really people interested in seeing these improvements on 9P2000.u side and=
=20
willing to at least help out with testing, then I can definitely also adjus=
t=20
9P2000.u side accordingly as well.

But to also make this clear: this patch 10 is not introducing any behaviour=
=20
change for 9P2000.u side.

> > >  int coroutine_fn v9fs_co_readdir(V9fsPDU *pdu, V9fsFidState *fidp,
> > > =20
> > >                                   struct dirent **dent)
> > > =20
> > >  {
> > > =20
> > >      int err;
> > >=20
> > > -    V9fsState *s =3D pdu->s;
> > >=20
> > >      if (v9fs_request_cancelled(pdu)) {
> > >     =20
> > >          return -EINTR;
> > >     =20
> > >      }
> > >=20
> > > -    v9fs_co_run_in_worker(
> > > -        {
> > > -            struct dirent *entry;
> > > +    v9fs_co_run_in_worker({
> > > +        err =3D do_readdir(pdu, fidp, dent);
> > > +    });
> > > +    return err;
> > > +}
> > > +
> > > +/*
> > > + * This is solely executed on a background IO thread.
> > > + *
> > > + * See v9fs_co_readdir_lowlat() (as its only user) below for details.
>=20
> Since the only user is quite small, maybe just open-code this.

Mmm... maybe later on, as a cleanup patch or something. Current version is=
=20
tested. I would like to avoid to make things more complicated than they=20
already are (i.e. accidental introduction of some bug just due to this).

>=20
> > > + */
> > > +static int do_readdir_lowlat(V9fsPDU *pdu, V9fsFidState *fidp,
> > > +                             struct V9fsDirEnt **entries,
> > > +                             int32_t maxsize, bool dostat)
> > > +{
> > > +    V9fsState *s =3D pdu->s;
> > > +    V9fsString name;
> > > +    int len, err =3D 0;
> > > +    int32_t size =3D 0;
> > > +    off_t saved_dir_pos;
> > > +    struct dirent *dent;
> > > +    struct V9fsDirEnt *e =3D NULL;
> > > +    V9fsPath path;
> > > +    struct stat stbuf;
> > > +
> > > +    *entries =3D NULL;
> > > +    v9fs_path_init(&path);
> > > +
> > > +    /*
> > > +     * TODO: Here should be a warn_report_once() if lock failed.
> > > +     *
> > > +     * With a good 9p client we should not get into concurrency here,
> > > +     * because a good client would not use the same fid for concurre=
nt
> > > +     * requests. We do the lock here for safety reasons though. Howe=
ver
> > > +     * the client would then suffer performance issues, so better log
> > > that
> > > +     * issue here.
> > > +     */
>=20
> This should probably be done with qemu_mutex_trylock() in a loop directly
> in v9fs_readdir_lock().

No definitely not in the loop. That's intentionally *one* lock *outside* of=
=20
the loop. The normal case is not requiring a lock at all, like the comment=
=20
describes. Doing multiple locks inside the loop unnecessaririly reduces=20
performance for no reason.

About *_trylock() instead of v9fs_readdir_lock(): might be a candidate to=20
address the TODO comment, but I would like to pospone that for the same=20
reasons: it is an odd/ill case encountering concurrency here. So for all we=
ll=20
implemented clients this is not an issue at all, and security (concerning=20
malicious clients) is provided already by this lock. Addressing this TODO=20
already now would potentially unnecessarily introduce bugs due to added=20
complexity, so really I would postpone that.

> > > +/**
> > > + * @brief Low latency variant of fs driver readdir handling.
> > > + *
>=20
> Not sure it brings much to mention latency here... telling what this
> function does actually ie. "read multiple directory entries in a row"
> would be more informative.

NP

> > > + * Retrieves the requested (max. amount of) directory entries from t=
he
> > > fs
> > > + * driver. This function must only be called by the main IO thread (=
top
> > > half). + * Internally this function call will be dispatched to a
> > > background
> > > IO thread + * (bottom half) where it is eventually executed by the fs
> > > driver. + *
> > > + * The old readdir implementation above just retrieves always one dir
> > > entry + * per call. The problem of that implementation above is that
> > > latency is + * added for (retrieval of) each directory entry, which in
> > > practice lead to + * latencies of several hundred ms for readdir of
> > > only one directory. + * + * This is avoided in this function by letti=
ng
> > > the fs driver retrieve all + * required directory entries with only
> > > call of this function and hence with + * only a single fs driver
> > > request.
>=20
> True but these kind of considerations rather belong to the changelog...
> otherwise, we'll have to not forget to kill these lines when the "old
> readdir implementation" is no more.

Mmm... I do think this overall latency issue should be clarified somewhere =
as=20
a comment. Where exactly is not that important to me. For instance it could=
=20
also be described on v9fs_co_run_in_worker() macro definition in coth.h=20
instead, as general rule of thumb when dispatching stuff.

The thing is: for >10 years several developers obviously did not realize th=
e=20
severe negative performance impact of frivolously dispatching tasks to=20
different threads too often. It looks like linear code, right? But no, it i=
s=20
not.

> > > + *
> > > + * @param pdu - the causing 9p (T_readdir) client request
> > > + * @param fidp - already opened directory where readdir shall be
> > > performed
> > > on + * @param entries - output for directory entries (must not be NUL=
L)
> > > + *
> > > @param maxsize - maximum result message body size (in bytes)
> > > + * @param dostat - whether a stat() should be performed and returned
> > > for
> > > + *                 each directory entry
> > > + * @returns resulting response message body size (in bytes) on succe=
ss,
> > > + *          negative error code otherwise
> > > + */
> > > +int coroutine_fn v9fs_co_readdir_lowlat(V9fsPDU *pdu, V9fsFidState
> > > *fidp,
>=20
> Not really a fan of the _lowlat (low fat ?) wording.
>=20
> v9fs_co_readdir_many() or anything else that suggests we're going to
> read several entries in a row.

NP

>=20
> > > +                                        struct V9fsDirEnt **entries,
> > > +                                        int32_t maxsize, bool dostat)
>=20
> s/maxsize/max_count since this is the wording use in the caller.

Wouldn't do that. This is the driver side, not the 9p protocol request=20
handler. As you might have relized before, "max_count" is semantically=20
completely wrong. This variable does not count integral entries, it is rath=
er=20
a maximum size (in bytes) of the destination buffer being filled.

On 9p request handler side it is ok to use "max_count" instead, because the=
=20
protocol definition uses exactly this term for the request parameter, but o=
n=20
driver side it's IMO inappropriate.

Best regards,
Christian Schoenebeck



