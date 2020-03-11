Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3509C0044D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 19:55:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B921D20737
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 19:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="K6zzj9cd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B921D20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC7SB-0005VD-NZ
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 15:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37178)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1jC7RY-0004xz-8m
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 15:55:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1jC7RV-0001Am-Vn
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 15:55:04 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:51743)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jC7RV-00016M-Iy
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 15:55:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=MCyuuO7OuQiOy0F4XFMFde14slPV+Utf2uFedJpRoJw=; b=K6zzj9cd6e3xuq+ehTPjS/I77Y
 EAV9trQ5bI+MdYZOwT1TfRMtsBR1ED5BQ15nGLpPwc4uR4tvoQbI9/fSg7ziUH0Vu2R7OILoUhTCj
 iJJ3B2tv4AjlZcnmRMdeIIgq/M2cfmCwTRincL4F31F6UNpOOY9vPsDndGGLbIJe7hzq3PU837Ny6
 d738xt8rUQCW6axFlik+QaybJfKygM1HoFqUdZnkRd4362CU0r1B/TbN/oaTgxYn5NkGWh4+LQZ2n
 qyG/YzeZS1iyHJPf3NBLiPfY094u6dGVorGpKL459SuMpJsXfPpg01xZUF6Xxaf3h2vpr2mwUxIXY
 GobseaQffLGfMFW39xlwkvfSkAC6Hp2YdfvirPysXPz6YJc2zBggleYaIs/Rsn07yeJ5ItQfcTpdR
 noVneEoESLKqF55GCPQW4LLTVPIUePfqv2JN4wF726NVTaGzyLrYpF9Rc0wc1BDyiIQa2EAr5VMlF
 MFRLPOlw6+D4OhU/pl9VFLmOOGa1DWj/SGYLIvp13DNp0oLXdAVXO3sonEQP6l8d8JZ/67KDIrVJo
 S4nXz31JJcre/Q8BgRNt6s8z3COKXVLIbR6KIa/m7fGGAWTgoAe7j/hfurO2iUwFbVRuTXu1LuQ1O
 JeGGjUDcfvMMX5RLN1xcc8UpVTqHc2iVlOPlVBPZg=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v4 10/11] 9pfs: T_readdir latency optimization
Date: Wed, 11 Mar 2020 20:54:58 +0100
Message-ID: <3047810.ezBau4JpT1@silver>
In-Reply-To: <20200311171408.3b3a2dfa@bahia.home>
References: <cover.1579567019.git.qemu_oss@crudebyte.com>
 <2408892.h2sFNKg3ST@silver> <20200311171408.3b3a2dfa@bahia.home>
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

On Mittwoch, 11. M=E4rz 2020 17:14:08 CET Greg Kurz wrote:
> On Wed, 11 Mar 2020 02:18:04 +0100
>=20
> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > On Dienstag, 10. M=E4rz 2020 19:33:36 CET Greg Kurz wrote:
> > > > This patch is also too big for my preference, but I don't see a via=
ble
> > > > way
> > > > to split it further into separate patches. I already separated all =
the
> > > > patches I could. If you have suggestions, very much appreciated!
> > >=20
> > > Well, the patch could be split in two or three parts at least:
> > >=20
> > > (1) introduce the new function that reads multiple entries in codir.c
> > >=20
> > > (2) use it from 9p.c
> > >=20
> > > (3) remove unused stuff if anything remains
> > >=20
> > > This doesn't seem to change much but the smaller diffstats
> > > for each individual patch make them less scary :) and with
> > > (1) applied only it is easier to compare what the old code
> > > in 9p.c and the new one in codir.c do.
> > >=20
> > > > The reason for this is that in order to fix these issues with curre=
nt
> > > > T_readdir implementation, it requires to separate what's currently =
one
> > > > task
> > > > (i.e. one function) into two separate tasks (i.e. two functions).
> > > > There is
> > > > no sensible way to do that.
> > >=20
> > > Yeah, I won't ask for finer grain.
> >=20
> > Me confused. Does that mean your split suggestion was just theoretical,=
 or
> > do you need it?
>=20
> I need it and I won't ask for more splitting. Promised ! :)

Okay then. :)

> > > > Current code on master is much more tricky and error prone due to t=
he
> > > > huge
> > > > amount of potential branches, individual error/cleanup handlers, hi=
gh
> > > > amount of thread dispatching and much more. In the patched version =
all
> > > > these code complexities and error sources are removed.
> > >=20
> > > Come on :) The 9pfs code has been a can of worms from the beginning.
> > > It produced more than the average amount of security-related bugs,
> > > and most sadly, due to the overall lack of interest, it bitrotted
> > > and missed a lot of cool improvements like an appropriate support of
> > > unlinked files, QOM-ification of fsdev, conversion of proxy fsdev to
> > > vhost-user, hot plug/unplug support, live migration support and
> > > "much more"... The performance aspect of things is a full time job
> >=20
> > No, the performance issues are actually very managable in case of 9pfs.
> > I already addressed readdir with this patch (by far the worst performan=
ce
>=20
> They're very manageable if someone cares and spends time. Thanks again
> for doing this.

Thanks!

> > My intention is not to squeeze out the last fractional percent of
> > performance for 9pfs, but you certainly agree that a simple "ls" blocki=
ng
> > for more than 1 second is something that should be fixed, and fortunate=
ly
> > the amount of
> I never observed such timeouts with my personal toy use of 9p but
> you did and this motivated you to step in, which is very welcome.

Probably you don't notice it much because of the dirent cache on guest side=
=2E=20
If guest's dirent cache is cold, and you do a readdir() ("ls") on some=20
directory with e.g. several hundred entries, you should notice it.

> > I think the cause of disagreements we have are solely our use cases of
> > 9pfs: your personal use case does not seem to require any performance
> > considerations or multi-user aspects, whereas my use case requires at
> > least some minimum performance grade for utilizing 9pfs for server
> > applications.
>=20
> Your point about the personal use case is right indeed but our
> disagreements, if any, aren't uniquely related to that. It's more about
> maintainership and available time really. I'm 100% benevolent "Odd fixer"
> now and I just try to avoid being forced into fixing things after my PR is
> merged. If you want to go faster, then you're welcome to upgrade to
> maintainer and send PRs. This would make sense since you care for 9p, you
> showed a good understanding of the code and you provided beneficial
> contributions so far :)

That maintainership upgrade is planned. The question is just when. What was=
=20
your idea, co-maintainership?

> > > > > Oh, so we'd still have the current implementation being used, even
> > > > > with this patch applied... This would be okay for a RFC patch but
> > > > > in the end I'd really like to merge something that also converts
> > > > > v9fs_do_readdir_with_stat().
> > > >=20
> > > > Yes, I know, but I would not recommend mixing these things at this
> > > > point,
> > > > because it would be an entire effort on its own.
> > > >=20
> > > > v9fs_do_readdir_with_stat() is used for 9P2000.u, while
> > > > v9fs_do_readdir()
> > > > is used for 9P2000.L. They're behaving very differently, so it would
> > > > not
> > > > only require me to update v9fs_do_readdir_with_stat() and v9fs_read=
(),
> > > > I
> > > > would also need to write their own test cases (plural, since there =
are
> > > > none at all yet) and benchmarks, and of course somebody what need to
> > > > review all that additional amount of code, and who would actually t=
est
> > > > it? I am actively testing my 9P2000.L changes, but I am not actually
> > > > using 9P2000.u, so I could not guarantee for the same quality.
> > > >=20
> > > > Considering the current commitment situation regarding 9pfs, we can
> > > > only
> > > > bring things forward with compromises. Hence I suggest I concentrate
> > > > on
> > > > fixing the worst performance issues on 9P2000.L side first, and lat=
er
> > > > on
> > > > if there are really people interested in seeing these improvements =
on
> > > > 9P2000.u side and willing to at least help out with testing, then I
> > > > can
> > > > definitely also adjust 9P2000.u side accordingly as well.
> > > >=20
> > > > But to also make this clear: this patch 10 is not introducing any
> > > > behaviour
> > > > change for 9P2000.u side.
> > >=20
> > > Ok, fair enough to leave 9p2000.U behind for now but I had to ask :)
> > > /me is even wondering if we should start deprecating 9p2000.U since
> > > most clients can use 9p2000.L now...
> >=20
> > I probably wouldn't. On macOS for instance there's only 9p2000.u. In the
> > end
> Hmm... the only thing I've heard about is:
>=20
> https://github.com/benavento/mac9p
>=20
> and unless I'm missing something, this seems to only have a socket based
> transport... the server in QEMU is for virtio-9p and Xen 9p devices only.
> Unless mac9p seriously plans to implement a driver for either of those,
> I'm still not convinced it is worth keeping .U around... and BTW, our
> deprecation policy imposes a 2 QEMU versions cooling period before
> actually removing the code. This would leave ample time for someone
> to speak up.

Well, I leave that up to you. I could consider adding a transport for macOS=
=20
guests, but that's definitely not going to happen in any near future.

> > > Not sure we're talking about the same loop here...
> > >=20
> > > I'm just suggesting that v9fs_readdir_lock() could be something like:
> > >=20
> > > static inline void v9fs_readdir_lock(V9fsDir *dir)
> > > {
> > >=20
> > >     while (qemu_mutex_trylock(&dir->readdir_mutex)) {
> > >    =20
> > >         warn_report_once("blah");
> > >    =20
> > >     }
> > >=20
> > > }
> >=20
> > Ah yeah, in fact I got you wrong on this one. I thought you meant to mo=
ve
> > the lock within do_readdir_lowlat(). About your actual suggestion above
> > ...>=20
> > > > the loop. The normal case is not requiring a lock at all, like the
> > > > comment
> > > > describes. Doing multiple locks inside the loop unnecessaririly
> > > > reduces
> > > > performance for no reason.
> > > >=20
> > > > About *_trylock() instead of v9fs_readdir_lock(): might be a candid=
ate
> > > > to
> > >=20
> > > Hmm... are you suggesting that do_readdir_lowlat() should return if it
> > > can't take the lock ?
> >=20
> > ... yep, that's what I had in mind for it later on. I would not mind
> > running trylock in a loop like you suggested; if it fails, log a warning
> > and return. Because if the lock fails, then client is buggy. User can
> > read the warning in the logs and report the bug for client to be fixed.
> > Not worth to handle that case in any fancy way by server.
>=20
> The locking is just a safety net because readdir(3) isn't necessarily
> thread safe. It was never my intention to add an error path for that.
> And thinking again, sending concurrent Treaddir requests on the same
> fid is certainly a weird thing to do but is it really a bug ?

Well, I was unresolved on that issue as well, hence my decision to only lea=
ve=20
a TODO comment for now. My expectation would be separate fid for concurrent=
=20
readdir, but you are right of course, Treaddir (unlike its 9p2000.u=20
counterpart) is reentrant by design, since it has an offset parameter, so f=
rom=20
protocol perspective concurrent Treaddir is not per se impossible.

The lock would not be noticable either with this patch, since unlike on=20
master, the lock is just retained on driver side now (with this patch), whi=
ch=20
returns very fast even on large directories, as you can see from the benchm=
ark=20
output.

So yes, returning from function with an error is probably not the best choi=
ce.=20
My tendency is still though logging a message at least. I don't care about=
=20
that too much though to deal with trylock() in a loop or something right no=
w.=20
There are more important things to take care of ATM.

> > avoid similar mistakes by placing appropriate comment(s).
> >=20
> > > > > > > +                                        struct V9fsDirEnt
> > > > > > > **entries,
> > > > > > > +                                        int32_t maxsize, bool
> > > > > > > dostat)
> > > > >=20
> > > > > s/maxsize/max_count since this is the wording use in the caller.
> > > >=20
> > > > Wouldn't do that. This is the driver side, not the 9p protocol requ=
est
> > > > handler. As you might have relized before, "max_count" is semantica=
lly
> > > > completely wrong. This variable does not count integral entries, it=
 is
> > > > rather a maximum size (in bytes) of the destination buffer being
> > > > filled.
> > > >=20
> > > > On 9p request handler side it is ok to use "max_count" instead,
> > > > because
> > > > the
> > > > protocol definition uses exactly this term for the request paramete=
r,
> > > > but
> > > > on driver side it's IMO inappropriate.
> > >=20
> > > I agree the max_count wording sucks and I don't care that much to
> > > name variables according to protocol definitions, but I do care
> > > to use the same name in caller/callee when it makes sense, for a
> > > better grep or cscope experience.
> >=20
> > So you insist on that max_count change?
>=20
> Rather the opposite. Kill max_count and make it maxsize, in a preparatory
> patch with the reasons you've exposed.

Ah got it. OK then.

Best regards,
Christian Schoenebeck



