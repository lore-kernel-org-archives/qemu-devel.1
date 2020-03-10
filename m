Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5361AC18E5C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 18:35:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1536D20727
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 18:35:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1536D20727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBjj2-0000nr-6E
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 14:35:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49157)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1jBjhQ-0006q4-DL
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:33:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1jBjhN-0005Gb-Nm
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:33:52 -0400
Received: from 20.mo4.mail-out.ovh.net ([46.105.33.73]:53810)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1jBjhN-00052L-E6
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:33:49 -0400
Received: from player795.ha.ovh.net (unknown [10.110.171.5])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id B39B62297E3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 19:33:39 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player795.ha.ovh.net (Postfix) with ESMTPSA id 165FA1025A14A;
 Tue, 10 Mar 2020 18:33:38 +0000 (UTC)
Date: Tue, 10 Mar 2020 19:33:36 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v4 10/11] 9pfs: T_readdir latency optimization
Message-ID: <20200310193336.37029536@bahia.home>
In-Reply-To: <1651612.bE1MAdl4rA@silver>
References: <cover.1579567019.git.qemu_oss@crudebyte.com>
 <1706149.tZr2OiJYdg@silver> <20200309164259.2affe4bc@bahia.home>
 <1651612.bE1MAdl4rA@silver>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 15961601507089160512
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedruddvtddguddtiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvffukfgjfhfogggtgfesthhqfedtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejleehrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.33.73
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 10 Mar 2020 16:10:41 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Montag, 9. M=C3=A4rz 2020 16:42:59 CET Greg Kurz wrote:
> > The main issue I see with this patch is that it is too big. At
> > least from my POV, with the little time I have for 9p, that's
> > the first thing that pushes me back... So if you could split
> > this patch down to some reviewable chunks, this may help
> > going forward.
>=20
> This patch is also too big for my preference, but I don't see a viable wa=
y to=20
> split it further into separate patches. I already separated all the patch=
es I=20
> could. If you have suggestions, very much appreciated!
>=20

Well, the patch could be split in two or three parts at least:

(1) introduce the new function that reads multiple entries in codir.c

(2) use it from 9p.c

(3) remove unused stuff if anything remains

This doesn't seem to change much but the smaller diffstats
for each individual patch make them less scary :) and with
(1) applied only it is easier to compare what the old code
in 9p.c and the new one in codir.c do.

> The reason for this is that in order to fix these issues with current=20
> T_readdir implementation, it requires to separate what's currently one ta=
sk=20
> (i.e. one function) into two separate tasks (i.e. two functions). There i=
s no=20
> sensible way to do that.
>=20

Yeah, I won't ask for finer grain.

> But don't be too scared about this patch; if you look just at the diff=20
> directly then yes, the diff is not very human readable. However if you ap=
ply=20
> the patch and look at the resulting code, you'll notice that there are=20
> actually only 2 functions (v9fs_do_readdir() in 9p.c and do_readdir_lowla=
t()=20
> in codir.c) which require careful reviewing and that their resulting code=
 is=20
> actually very, very straight forward, and not long either.
>=20

These are personal opinions. Careful reviewing can take a lot of time :)

> Current code on master is much more tricky and error prone due to the hug=
e=20
> amount of potential branches, individual error/cleanup handlers, high amo=
unt=20
> of thread dispatching and much more. In the patched version all these cod=
e=20
> complexities and error sources are removed.
>=20

Come on :) The 9pfs code has been a can of worms from the beginning.
It produced more than the average amount of security-related bugs,
and most sadly, due to the overall lack of interest, it bitrotted
and missed a lot of cool improvements like an appropriate support of
unlinked files, QOM-ification of fsdev, conversion of proxy fsdev to
vhost-user, hot plug/unplug support, live migration support and
"much more"... The performance aspect of things is a full time job
I never had the opportunity to even consider. So yes, your changes
are likely beneficial but the code base is still extremely fragile
and sensible to huge changes... not breaking things that happen
to work, even in a sub-optimal way, is essentially what I care for
these days.

> > > > diff --git a/hw/9pfs/codir.c b/hw/9pfs/codir.c
> > > > index 73f9a751e1..6ce7dc8cde 100644
> > > > --- a/hw/9pfs/codir.c
> > > > +++ b/hw/9pfs/codir.c
> > > > @@ -18,28 +18,189 @@
> > > >=20
> > > >  #include "qemu/main-loop.h"
> > > >  #include "coth.h"
> > > >=20
> > > > +/*
> > > > + * This is solely executed on a background IO thread.
> > > > + */
> > > > +static int do_readdir(V9fsPDU *pdu, V9fsFidState *fidp, struct dir=
ent
> > > > **dent) +{
> > > > +    int err =3D 0;
> > > > +    V9fsState *s =3D pdu->s;
> > > > +    struct dirent *entry;
> > > > +
> > > > +    errno =3D 0;
> > > > +    entry =3D s->ops->readdir(&s->ctx, &fidp->fs);
> > > > +    if (!entry && errno) {
> > > > +        *dent =3D NULL;
> > > > +        err =3D -errno;
> > > > +    } else {
> > > > +        *dent =3D entry;
> > > > +    }
> > > > +    return err;
> > > > +}
> > > > +
> > > > +/*
> > > > + * TODO: This will be removed for performance reasons.
> > > > + * Use v9fs_co_readdir_lowlat() instead.
> >=20
> > Oh, so we'd still have the current implementation being used, even
> > with this patch applied... This would be okay for a RFC patch but
> > in the end I'd really like to merge something that also converts
> > v9fs_do_readdir_with_stat().
>=20
> Yes, I know, but I would not recommend mixing these things at this point,=
=20
> because it would be an entire effort on its own.
>=20
> v9fs_do_readdir_with_stat() is used for 9P2000.u, while v9fs_do_readdir()=
 is=20
> used for 9P2000.L. They're behaving very differently, so it would not onl=
y=20
> require me to update v9fs_do_readdir_with_stat() and v9fs_read(), I would=
 also=20
> need to write their own test cases (plural, since there are none at all y=
et)=20
> and benchmarks, and of course somebody what need to review all that addit=
ional=20
> amount of code, and who would actually test it? I am actively testing my=
=20
> 9P2000.L changes, but I am not actually using 9P2000.u, so I could not=20
> guarantee for the same quality.
>=20
> Considering the current commitment situation regarding 9pfs, we can only =
bring=20
> things forward with compromises. Hence I suggest I concentrate on fixing =
the=20
> worst performance issues on 9P2000.L side first, and later on if there ar=
e=20
> really people interested in seeing these improvements on 9P2000.u side an=
d=20
> willing to at least help out with testing, then I can definitely also adj=
ust=20
> 9P2000.u side accordingly as well.
>=20
> But to also make this clear: this patch 10 is not introducing any behavio=
ur=20
> change for 9P2000.u side.
>=20

Ok, fair enough to leave 9p2000.U behind for now but I had to ask :)
/me is even wondering if we should start deprecating 9p2000.U since
most clients can use 9p2000.L now...

> > > >  int coroutine_fn v9fs_co_readdir(V9fsPDU *pdu, V9fsFidState *fidp,
> > > > =20
> > > >                                   struct dirent **dent)
> > > > =20
> > > >  {
> > > > =20
> > > >      int err;
> > > >=20
> > > > -    V9fsState *s =3D pdu->s;
> > > >=20
> > > >      if (v9fs_request_cancelled(pdu)) {
> > > >     =20
> > > >          return -EINTR;
> > > >     =20
> > > >      }
> > > >=20
> > > > -    v9fs_co_run_in_worker(
> > > > -        {
> > > > -            struct dirent *entry;
> > > > +    v9fs_co_run_in_worker({
> > > > +        err =3D do_readdir(pdu, fidp, dent);
> > > > +    });
> > > > +    return err;
> > > > +}
> > > > +
> > > > +/*
> > > > + * This is solely executed on a background IO thread.
> > > > + *
> > > > + * See v9fs_co_readdir_lowlat() (as its only user) below for detai=
ls.
> >=20
> > Since the only user is quite small, maybe just open-code this.
>=20
> Mmm... maybe later on, as a cleanup patch or something. Current version i=
s=20
> tested. I would like to avoid to make things more complicated than they=20
> already are (i.e. accidental introduction of some bug just due to this).
>=20

It seems we might agree on not breaking things that work ;-)

> >=20
> > > > + */
> > > > +static int do_readdir_lowlat(V9fsPDU *pdu, V9fsFidState *fidp,
> > > > +                             struct V9fsDirEnt **entries,
> > > > +                             int32_t maxsize, bool dostat)
> > > > +{
> > > > +    V9fsState *s =3D pdu->s;
> > > > +    V9fsString name;
> > > > +    int len, err =3D 0;
> > > > +    int32_t size =3D 0;
> > > > +    off_t saved_dir_pos;
> > > > +    struct dirent *dent;
> > > > +    struct V9fsDirEnt *e =3D NULL;
> > > > +    V9fsPath path;
> > > > +    struct stat stbuf;
> > > > +
> > > > +    *entries =3D NULL;
> > > > +    v9fs_path_init(&path);
> > > > +
> > > > +    /*
> > > > +     * TODO: Here should be a warn_report_once() if lock failed.
> > > > +     *
> > > > +     * With a good 9p client we should not get into concurrency he=
re,
> > > > +     * because a good client would not use the same fid for concur=
rent
> > > > +     * requests. We do the lock here for safety reasons though. Ho=
wever
> > > > +     * the client would then suffer performance issues, so better =
log
> > > > that
> > > > +     * issue here.
> > > > +     */
> >=20
> > This should probably be done with qemu_mutex_trylock() in a loop direct=
ly
> > in v9fs_readdir_lock().
>=20
> No definitely not in the loop. That's intentionally *one* lock *outside* =
of=20

Not sure we're talking about the same loop here...

I'm just suggesting that v9fs_readdir_lock() could be something like:

static inline void v9fs_readdir_lock(V9fsDir *dir)
{
    while (qemu_mutex_trylock(&dir->readdir_mutex)) {
        warn_report_once("blah");
    }
}

> the loop. The normal case is not requiring a lock at all, like the commen=
t=20
> describes. Doing multiple locks inside the loop unnecessaririly reduces=20
> performance for no reason.
>=20
> About *_trylock() instead of v9fs_readdir_lock(): might be a candidate to=
=20

Hmm... are you suggesting that do_readdir_lowlat() should return if it
can't take the lock ?

> address the TODO comment, but I would like to pospone that for the same=20
> reasons: it is an odd/ill case encountering concurrency here. So for all =
well=20
> implemented clients this is not an issue at all, and security (concerning=
=20
> malicious clients) is provided already by this lock. Addressing this TODO=
=20
> already now would potentially unnecessarily introduce bugs due to added=20
> complexity, so really I would postpone that.
>=20

:)

> > > > +/**
> > > > + * @brief Low latency variant of fs driver readdir handling.
> > > > + *
> >=20
> > Not sure it brings much to mention latency here... telling what this
> > function does actually ie. "read multiple directory entries in a row"
> > would be more informative.
>=20
> NP
>=20
> > > > + * Retrieves the requested (max. amount of) directory entries from=
 the
> > > > fs
> > > > + * driver. This function must only be called by the main IO thread=
 (top
> > > > half). + * Internally this function call will be dispatched to a
> > > > background
> > > > IO thread + * (bottom half) where it is eventually executed by the =
fs
> > > > driver. + *
> > > > + * The old readdir implementation above just retrieves always one =
dir
> > > > entry + * per call. The problem of that implementation above is that
> > > > latency is + * added for (retrieval of) each directory entry, which=
 in
> > > > practice lead to + * latencies of several hundred ms for readdir of
> > > > only one directory. + * + * This is avoided in this function by let=
ting
> > > > the fs driver retrieve all + * required directory entries with only
> > > > call of this function and hence with + * only a single fs driver
> > > > request.
> >=20
> > True but these kind of considerations rather belong to the changelog...
> > otherwise, we'll have to not forget to kill these lines when the "old
> > readdir implementation" is no more.
>=20
> Mmm... I do think this overall latency issue should be clarified somewher=
e as=20

The issue itself is best described in a changelog, but...

> a comment. Where exactly is not that important to me. For instance it cou=
ld=20
> also be described on v9fs_co_run_in_worker() macro definition in coth.h=20
> instead, as general rule of thumb when dispatching stuff.

... if you have useful recommendations that don't involve referring to a
piece of code that might go away, a comment in coth.h is certainly a good
idea.

> The thing is: for >10 years several developers obviously did not realize =
the=20
> severe negative performance impact of frivolously dispatching tasks to=20

I won't dare to comment on some people I don't know not doing the obvious
right things at the time... what I do know is that for >10 years, nobody
cared for this code. Period. You're lucky it is still functional ;-)

> different threads too often. It looks like linear code, right? But no, it=
 is=20
> not.
>=20
> > > > + *
> > > > + * @param pdu - the causing 9p (T_readdir) client request
> > > > + * @param fidp - already opened directory where readdir shall be
> > > > performed
> > > > on + * @param entries - output for directory entries (must not be N=
ULL)
> > > > + *
> > > > @param maxsize - maximum result message body size (in bytes)
> > > > + * @param dostat - whether a stat() should be performed and return=
ed
> > > > for
> > > > + *                 each directory entry
> > > > + * @returns resulting response message body size (in bytes) on suc=
cess,
> > > > + *          negative error code otherwise
> > > > + */
> > > > +int coroutine_fn v9fs_co_readdir_lowlat(V9fsPDU *pdu, V9fsFidState
> > > > *fidp,
> >=20
> > Not really a fan of the _lowlat (low fat ?) wording.
> >=20
> > v9fs_co_readdir_many() or anything else that suggests we're going to
> > read several entries in a row.
>=20
> NP
>=20
> >=20
> > > > +                                        struct V9fsDirEnt **entrie=
s,
> > > > +                                        int32_t maxsize, bool dost=
at)
> >=20
> > s/maxsize/max_count since this is the wording use in the caller.
>=20
> Wouldn't do that. This is the driver side, not the 9p protocol request=20
> handler. As you might have relized before, "max_count" is semantically=20
> completely wrong. This variable does not count integral entries, it is ra=
ther=20
> a maximum size (in bytes) of the destination buffer being filled.
>=20
> On 9p request handler side it is ok to use "max_count" instead, because t=
he=20
> protocol definition uses exactly this term for the request parameter, but=
 on=20
> driver side it's IMO inappropriate.
>=20

I agree the max_count wording sucks and I don't care that much to
name variables according to protocol definitions, but I do care
to use the same name in caller/callee when it makes sense, for a
better grep or cscope experience.

> Best regards,
> Christian Schoenebeck
>=20
>=20


