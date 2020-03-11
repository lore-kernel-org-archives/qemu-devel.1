Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08772C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 01:18:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A41E620727
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 01:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="cHplOhH0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A41E620727
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBq1R-0003XD-Qr
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 21:18:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45705)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1jBq0i-00036s-AZ
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 21:18:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1jBq0f-0001T1-3I
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 21:18:12 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:59519)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jBq0e-0001QU-Jy
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 21:18:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=UCJhrVzjyJ95bSvh7/+CLTzQZ9eVliGPlETtEZUNTqQ=; b=cHplOhH0RqQFQU50+ZRBYDVbBW
 fdFBNzx2Uh/9n3rZk6NefO/nJwrh4qmLw2YxYNRTBHezjRbWjJSobpZRNgGq7+R1QzYaYm19MHM76
 Efxpdwa/2ra7mKeDM1tkYQpa+K//EwCHfRQDgj9WuZmiAxAYUkg9hST8LdcwWAj408BkcF6nF/8LB
 fwH5NXUiNegsaBCORlAdf9NmdhLjiXT0Lo+TuEDeLYNtt1n+L8hLmR6xLuNwaFco79QeNABlILegC
 F1+TeCkEraj/htBpHaFqJUcazT2P3HiL6uBALLMpL1lK4kBpsOWOUdooj3mPguZnG2Pgd42Q4BzV/
 eoVllOoPb/TjOlDVw3USfFG4h6T2nzC1Bk/XI8EwyYCDd77ytMXNxwc+JpD6fuXLCYoAtv9HLgMTm
 goIERrTbOYKcOiUnlSrBYTcGJ8lXlWpjUEdGhSVOKAj2McF/2PjMclK7Hjskw89V3J9BzG0mmMkg5
 pHU6gSl80DaWg0CZdLc3dtiiyncCw+wko3gOWneMv4Qs1/fzmAG3vmyoNkOlSuM6T3JgD++yR7lks
 e0BPjngyY19n5ZSGmWb3CaUQHOSCg8Y8bT0z9xAaNopM4GTXTHQlwuG6BPUxpNWzCb4lx4rQMXoWj
 msAlczPheaNAqprSukRHf7UfAWBOTTfUIgg/dEkyc=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v4 10/11] 9pfs: T_readdir latency optimization
Date: Wed, 11 Mar 2020 02:18:04 +0100
Message-ID: <2408892.h2sFNKg3ST@silver>
In-Reply-To: <20200310193336.37029536@bahia.home>
References: <cover.1579567019.git.qemu_oss@crudebyte.com>
 <1651612.bE1MAdl4rA@silver> <20200310193336.37029536@bahia.home>
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

On Dienstag, 10. M=E4rz 2020 19:33:36 CET Greg Kurz wrote:
> > This patch is also too big for my preference, but I don't see a viable =
way
> > to split it further into separate patches. I already separated all the
> > patches I could. If you have suggestions, very much appreciated!
>=20
> Well, the patch could be split in two or three parts at least:
>=20
> (1) introduce the new function that reads multiple entries in codir.c
>=20
> (2) use it from 9p.c
>=20
> (3) remove unused stuff if anything remains
>=20
> This doesn't seem to change much but the smaller diffstats
> for each individual patch make them less scary :) and with
> (1) applied only it is easier to compare what the old code
> in 9p.c and the new one in codir.c do.
>=20
> > The reason for this is that in order to fix these issues with current
> > T_readdir implementation, it requires to separate what's currently one
> > task
> > (i.e. one function) into two separate tasks (i.e. two functions). There=
 is
> > no sensible way to do that.
>=20
> Yeah, I won't ask for finer grain.

Me confused. Does that mean your split suggestion was just theoretical, or =
do=20
you need it?

> > But don't be too scared about this patch; if you look just at the diff
> > directly then yes, the diff is not very human readable. However if you
> > apply the patch and look at the resulting code, you'll notice that there
> > are actually only 2 functions (v9fs_do_readdir() in 9p.c and
> > do_readdir_lowlat() in codir.c) which require careful reviewing and that
> > their resulting code is actually very, very straight forward, and not
> > long either.
>=20
> These are personal opinions. Careful reviewing can take a lot of time :)

Well, depends on what precisely you mean with opinion. :) That this patch=20
actually reduces code complexity is a fact (less branches, less locks, less=
=20
dispatches, less side effects, less error/cleanup handlers). These are=20
objectively measurable quantities.

But yes, nevertheless reviewing it costs time.

> > Current code on master is much more tricky and error prone due to the h=
uge
> > amount of potential branches, individual error/cleanup handlers, high
> > amount of thread dispatching and much more. In the patched version all
> > these code complexities and error sources are removed.
>=20
> Come on :) The 9pfs code has been a can of worms from the beginning.
> It produced more than the average amount of security-related bugs,
> and most sadly, due to the overall lack of interest, it bitrotted
> and missed a lot of cool improvements like an appropriate support of
> unlinked files, QOM-ification of fsdev, conversion of proxy fsdev to
> vhost-user, hot plug/unplug support, live migration support and
> "much more"... The performance aspect of things is a full time job

No, the performance issues are actually very managable in case of 9pfs.
I already addressed readdir with this patch (by far the worst performance=20
issue), and then there would just be one more severe performance issue:=20
walkdir.

My intention is not to squeeze out the last fractional percent of performan=
ce=20
for 9pfs, but you certainly agree that a simple "ls" blocking for more than=
 1=20
second is something that should be fixed, and fortunately the amount of=20
changes involved are far less than I originally feared they would.

> I never had the opportunity to even consider. So yes, your changes
> are likely beneficial but the code base is still extremely fragile
> and sensible to huge changes... not breaking things that happen
> to work, even in a sub-optimal way, is essentially what I care for
> these days.

And I think I'm also very careful not breaking anything. I carefully consid=
er=20
what to touch and what not. I wrote test cases and I am actively testing my=
=20
changes with real installations and snapshots as well.

I think the cause of disagreements we have are solely our use cases of 9pfs=
:=20
your personal use case does not seem to require any performance considerati=
ons=20
or multi-user aspects, whereas my use case requires at least some minimum=20
performance grade for utilizing 9pfs for server applications.

> > > Oh, so we'd still have the current implementation being used, even
> > > with this patch applied... This would be okay for a RFC patch but
> > > in the end I'd really like to merge something that also converts
> > > v9fs_do_readdir_with_stat().
> >=20
> > Yes, I know, but I would not recommend mixing these things at this poin=
t,
> > because it would be an entire effort on its own.
> >=20
> > v9fs_do_readdir_with_stat() is used for 9P2000.u, while v9fs_do_readdir=
()
> > is used for 9P2000.L. They're behaving very differently, so it would not
> > only require me to update v9fs_do_readdir_with_stat() and v9fs_read(), I
> > would also need to write their own test cases (plural, since there are
> > none at all yet) and benchmarks, and of course somebody what need to
> > review all that additional amount of code, and who would actually test
> > it? I am actively testing my 9P2000.L changes, but I am not actually
> > using 9P2000.u, so I could not guarantee for the same quality.
> >=20
> > Considering the current commitment situation regarding 9pfs, we can only
> > bring things forward with compromises. Hence I suggest I concentrate on
> > fixing the worst performance issues on 9P2000.L side first, and later on
> > if there are really people interested in seeing these improvements on
> > 9P2000.u side and willing to at least help out with testing, then I can
> > definitely also adjust 9P2000.u side accordingly as well.
> >=20
> > But to also make this clear: this patch 10 is not introducing any
> > behaviour
> > change for 9P2000.u side.
>=20
> Ok, fair enough to leave 9p2000.U behind for now but I had to ask :)
> /me is even wondering if we should start deprecating 9p2000.U since
> most clients can use 9p2000.L now...

I probably wouldn't. On macOS for instance there's only 9p2000.u. In the en=
d=20
9p2000.L is Linux specific. By deprecating 9p2000.u that would mean a shift=
=20
towards only supporting Linux guests.

> > Mmm... maybe later on, as a cleanup patch or something. Current version=
 is
> > tested. I would like to avoid to make things more complicated than they
> > already are (i.e. accidental introduction of some bug just due to this).
>=20
> It seems we might agree on not breaking things that work ;-)

Of course! All the things I work on 9pfs are just fixes. But that's probabl=
y=20
where we start to disagree. :)

> > > > > +static int do_readdir_lowlat(V9fsPDU *pdu, V9fsFidState *fidp,
> > > > > +                             struct V9fsDirEnt **entries,
> > > > > +                             int32_t maxsize, bool dostat)
> > > > > +{
> > > > > +    V9fsState *s =3D pdu->s;
> > > > > +    V9fsString name;
> > > > > +    int len, err =3D 0;
> > > > > +    int32_t size =3D 0;
> > > > > +    off_t saved_dir_pos;
> > > > > +    struct dirent *dent;
> > > > > +    struct V9fsDirEnt *e =3D NULL;
> > > > > +    V9fsPath path;
> > > > > +    struct stat stbuf;
> > > > > +
> > > > > +    *entries =3D NULL;
> > > > > +    v9fs_path_init(&path);
> > > > > +
> > > > > +    /*
> > > > > +     * TODO: Here should be a warn_report_once() if lock failed.
> > > > > +     *
> > > > > +     * With a good 9p client we should not get into concurrency
> > > > > here,
> > > > > +     * because a good client would not use the same fid for
> > > > > concurrent
> > > > > +     * requests. We do the lock here for safety reasons though.
> > > > > However
> > > > > +     * the client would then suffer performance issues, so better
> > > > > log
> > > > > that
> > > > > +     * issue here.
> > > > > +     */
> > >=20
> > > This should probably be done with qemu_mutex_trylock() in a loop
> > > directly
> > > in v9fs_readdir_lock().
> >=20
> > No definitely not in the loop. That's intentionally *one* lock *outside*
> > of
>=20
> Not sure we're talking about the same loop here...
>=20
> I'm just suggesting that v9fs_readdir_lock() could be something like:
>=20
> static inline void v9fs_readdir_lock(V9fsDir *dir)
> {
>     while (qemu_mutex_trylock(&dir->readdir_mutex)) {
>         warn_report_once("blah");
>     }
> }

Ah yeah, in fact I got you wrong on this one. I thought you meant to move t=
he=20
lock within do_readdir_lowlat(). About your actual suggestion above ...

> > the loop. The normal case is not requiring a lock at all, like the comm=
ent
> > describes. Doing multiple locks inside the loop unnecessaririly reduces
> > performance for no reason.
> >=20
> > About *_trylock() instead of v9fs_readdir_lock(): might be a candidate =
to
>=20
> Hmm... are you suggesting that do_readdir_lowlat() should return if it
> can't take the lock ?

=2E.. yep, that's what I had in mind for it later on. I would not mind runn=
ing=20
trylock in a loop like you suggested; if it fails, log a warning and return.
Because if the lock fails, then client is buggy. User can read the warning =
in=20
the logs and report the bug for client to be fixed. Not worth to handle tha=
t=20
case in any fancy way by server.

> > > > > + * Retrieves the requested (max. amount of) directory entries fr=
om
> > > > > the
> > > > > fs
> > > > > + * driver. This function must only be called by the main IO thre=
ad
> > > > > (top
> > > > > half). + * Internally this function call will be dispatched to a
> > > > > background
> > > > > IO thread + * (bottom half) where it is eventually executed by the
> > > > > fs
> > > > > driver. + *
> > > > > + * The old readdir implementation above just retrieves always one
> > > > > dir
> > > > > entry + * per call. The problem of that implementation above is t=
hat
> > > > > latency is + * added for (retrieval of) each directory entry, whi=
ch
> > > > > in
> > > > > practice lead to + * latencies of several hundred ms for readdir =
of
> > > > > only one directory. + * + * This is avoided in this function by
> > > > > letting
> > > > > the fs driver retrieve all + * required directory entries with on=
ly
> > > > > call of this function and hence with + * only a single fs driver
> > > > > request.
> > >=20
> > > True but these kind of considerations rather belong to the changelog.=
=2E.
> > > otherwise, we'll have to not forget to kill these lines when the "old
> > > readdir implementation" is no more.
> >=20
> > Mmm... I do think this overall latency issue should be clarified somewh=
ere
> > as
> The issue itself is best described in a changelog, but...
>=20
> > a comment. Where exactly is not that important to me. For instance it
> > could
> > also be described on v9fs_co_run_in_worker() macro definition in coth.h
> > instead, as general rule of thumb when dispatching stuff.
>=20
> ... if you have useful recommendations that don't involve referring to a
> piece of code that might go away, a comment in coth.h is certainly a good
> idea.

Ok, I'll move it to coth.h then.

> > The thing is: for >10 years several developers obviously did not realize
> > the severe negative performance impact of frivolously dispatching tasks
> > to
> I won't dare to comment on some people I don't know not doing the obvious
> right things at the time... what I do know is that for >10 years, nobody
> cared for this code. Period. You're lucky it is still functional ;-)

This was not about judging individuals, just to express that the latency=20
impact of dispatching does not seem to be obvious for people, and trying to=
=20
avoid similar mistakes by placing appropriate comment(s).

> > > > > +                                        struct V9fsDirEnt
> > > > > **entries,
> > > > > +                                        int32_t maxsize, bool
> > > > > dostat)
> > >=20
> > > s/maxsize/max_count since this is the wording use in the caller.
> >=20
> > Wouldn't do that. This is the driver side, not the 9p protocol request
> > handler. As you might have relized before, "max_count" is semantically
> > completely wrong. This variable does not count integral entries, it is
> > rather a maximum size (in bytes) of the destination buffer being filled.
> >=20
> > On 9p request handler side it is ok to use "max_count" instead, because
> > the
> > protocol definition uses exactly this term for the request parameter, b=
ut
> > on driver side it's IMO inappropriate.
>=20
> I agree the max_count wording sucks and I don't care that much to
> name variables according to protocol definitions, but I do care
> to use the same name in caller/callee when it makes sense, for a
> better grep or cscope experience.

So you insist on that max_count change?

Best regards,
Christian Schoenebeck



