Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E522BC18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 14:15:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD6B920663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 14:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD6B920663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jED0W-0007wh-Su
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 10:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53540)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1jECzJ-0005vC-L9
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:14:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1jECzH-00051f-1d
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:14:33 -0400
Received: from 18.mo4.mail-out.ovh.net ([188.165.54.143]:38727)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1jECzG-0004hB-QV
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:14:30 -0400
Received: from player692.ha.ovh.net (unknown [10.108.35.211])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 8555622B646
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 15:14:28 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player692.ha.ovh.net (Postfix) with ESMTPSA id CD55C10629FBF;
 Tue, 17 Mar 2020 14:14:26 +0000 (UTC)
Date: Tue, 17 Mar 2020 15:14:23 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v4 10/11] 9pfs: T_readdir latency optimization
Message-ID: <20200317151423.14fc43d9@bahia.lan>
In-Reply-To: <3047810.ezBau4JpT1@silver>
References: <cover.1579567019.git.qemu_oss@crudebyte.com>
 <2408892.h2sFNKg3ST@silver> <20200311171408.3b3a2dfa@bahia.home>
 <3047810.ezBau4JpT1@silver>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 15799753393225374016
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudefhedgheekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheiledvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.54.143
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

On Wed, 11 Mar 2020 20:54:58 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Mittwoch, 11. M=C3=A4rz 2020 17:14:08 CET Greg Kurz wrote:
> > On Wed, 11 Mar 2020 02:18:04 +0100
> >=20
> > Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > > On Dienstag, 10. M=C3=A4rz 2020 19:33:36 CET Greg Kurz wrote:
> > > > > This patch is also too big for my preference, but I don't see a v=
iable
> > > > > way
> > > > > to split it further into separate patches. I already separated al=
l the
> > > > > patches I could. If you have suggestions, very much appreciated!
> > > >=20
> > > > Well, the patch could be split in two or three parts at least:
> > > >=20
> > > > (1) introduce the new function that reads multiple entries in codir=
.c
> > > >=20
> > > > (2) use it from 9p.c
> > > >=20
> > > > (3) remove unused stuff if anything remains
> > > >=20
> > > > This doesn't seem to change much but the smaller diffstats
> > > > for each individual patch make them less scary :) and with
> > > > (1) applied only it is easier to compare what the old code
> > > > in 9p.c and the new one in codir.c do.
> > > >=20
> > > > > The reason for this is that in order to fix these issues with cur=
rent
> > > > > T_readdir implementation, it requires to separate what's currentl=
y one
> > > > > task
> > > > > (i.e. one function) into two separate tasks (i.e. two functions).
> > > > > There is
> > > > > no sensible way to do that.
> > > >=20
> > > > Yeah, I won't ask for finer grain.
> > >=20
> > > Me confused. Does that mean your split suggestion was just theoretica=
l, or
> > > do you need it?
> >=20
> > I need it and I won't ask for more splitting. Promised ! :)
>=20
> Okay then. :)
>=20
> > > > > Current code on master is much more tricky and error prone due to=
 the
> > > > > huge
> > > > > amount of potential branches, individual error/cleanup handlers, =
high
> > > > > amount of thread dispatching and much more. In the patched versio=
n all
> > > > > these code complexities and error sources are removed.
> > > >=20
> > > > Come on :) The 9pfs code has been a can of worms from the beginning.
> > > > It produced more than the average amount of security-related bugs,
> > > > and most sadly, due to the overall lack of interest, it bitrotted
> > > > and missed a lot of cool improvements like an appropriate support of
> > > > unlinked files, QOM-ification of fsdev, conversion of proxy fsdev to
> > > > vhost-user, hot plug/unplug support, live migration support and
> > > > "much more"... The performance aspect of things is a full time job
> > >=20
> > > No, the performance issues are actually very managable in case of 9pf=
s.
> > > I already addressed readdir with this patch (by far the worst perform=
ance
> >=20
> > They're very manageable if someone cares and spends time. Thanks again
> > for doing this.
>=20
> Thanks!
>=20
> > > My intention is not to squeeze out the last fractional percent of
> > > performance for 9pfs, but you certainly agree that a simple "ls" bloc=
king
> > > for more than 1 second is something that should be fixed, and fortuna=
tely
> > > the amount of
> > I never observed such timeouts with my personal toy use of 9p but
> > you did and this motivated you to step in, which is very welcome.
>=20
> Probably you don't notice it much because of the dirent cache on guest si=
de.=20
> If guest's dirent cache is cold, and you do a readdir() ("ls") on some=20
> directory with e.g. several hundred entries, you should notice it.
>=20
> > > I think the cause of disagreements we have are solely our use cases of
> > > 9pfs: your personal use case does not seem to require any performance
> > > considerations or multi-user aspects, whereas my use case requires at
> > > least some minimum performance grade for utilizing 9pfs for server
> > > applications.
> >=20
> > Your point about the personal use case is right indeed but our
> > disagreements, if any, aren't uniquely related to that. It's more about
> > maintainership and available time really. I'm 100% benevolent "Odd fixe=
r"
> > now and I just try to avoid being forced into fixing things after my PR=
 is
> > merged. If you want to go faster, then you're welcome to upgrade to
> > maintainer and send PRs. This would make sense since you care for 9p, y=
ou
> > showed a good understanding of the code and you provided beneficial
> > contributions so far :)
>=20
> That maintainership upgrade is planned. The question is just when. What w=
as=20
> your idea, co-maintainership?
>=20

Basically yes.

> > > > > > Oh, so we'd still have the current implementation being used, e=
ven
> > > > > > with this patch applied... This would be okay for a RFC patch b=
ut
> > > > > > in the end I'd really like to merge something that also converts
> > > > > > v9fs_do_readdir_with_stat().
> > > > >=20
> > > > > Yes, I know, but I would not recommend mixing these things at this
> > > > > point,
> > > > > because it would be an entire effort on its own.
> > > > >=20
> > > > > v9fs_do_readdir_with_stat() is used for 9P2000.u, while
> > > > > v9fs_do_readdir()
> > > > > is used for 9P2000.L. They're behaving very differently, so it wo=
uld
> > > > > not
> > > > > only require me to update v9fs_do_readdir_with_stat() and v9fs_re=
ad(),
> > > > > I
> > > > > would also need to write their own test cases (plural, since ther=
e are
> > > > > none at all yet) and benchmarks, and of course somebody what need=
 to
> > > > > review all that additional amount of code, and who would actually=
 test
> > > > > it? I am actively testing my 9P2000.L changes, but I am not actua=
lly
> > > > > using 9P2000.u, so I could not guarantee for the same quality.
> > > > >=20
> > > > > Considering the current commitment situation regarding 9pfs, we c=
an
> > > > > only
> > > > > bring things forward with compromises. Hence I suggest I concentr=
ate
> > > > > on
> > > > > fixing the worst performance issues on 9P2000.L side first, and l=
ater
> > > > > on
> > > > > if there are really people interested in seeing these improvement=
s on
> > > > > 9P2000.u side and willing to at least help out with testing, then=
 I
> > > > > can
> > > > > definitely also adjust 9P2000.u side accordingly as well.
> > > > >=20
> > > > > But to also make this clear: this patch 10 is not introducing any
> > > > > behaviour
> > > > > change for 9P2000.u side.
> > > >=20
> > > > Ok, fair enough to leave 9p2000.U behind for now but I had to ask :)
> > > > /me is even wondering if we should start deprecating 9p2000.U since
> > > > most clients can use 9p2000.L now...
> > >=20
> > > I probably wouldn't. On macOS for instance there's only 9p2000.u. In =
the
> > > end
> > Hmm... the only thing I've heard about is:
> >=20
> > https://github.com/benavento/mac9p
> >=20
> > and unless I'm missing something, this seems to only have a socket based
> > transport... the server in QEMU is for virtio-9p and Xen 9p devices onl=
y.
> > Unless mac9p seriously plans to implement a driver for either of those,
> > I'm still not convinced it is worth keeping .U around... and BTW, our
> > deprecation policy imposes a 2 QEMU versions cooling period before
> > actually removing the code. This would leave ample time for someone
> > to speak up.
>=20
> Well, I leave that up to you. I could consider adding a transport for mac=
OS=20
> guests, but that's definitely not going to happen in any near future.
>=20

The whole idea behind dropping support for .U is really just about
reducing the potential attack surface. But I'm also fine to keep
things as is until the next CVE since I'm confident someone will
help ;-)

> > > > Not sure we're talking about the same loop here...
> > > >=20
> > > > I'm just suggesting that v9fs_readdir_lock() could be something lik=
e:
> > > >=20
> > > > static inline void v9fs_readdir_lock(V9fsDir *dir)
> > > > {
> > > >=20
> > > >     while (qemu_mutex_trylock(&dir->readdir_mutex)) {
> > > >    =20
> > > >         warn_report_once("blah");
> > > >    =20
> > > >     }
> > > >=20
> > > > }
> > >=20
> > > Ah yeah, in fact I got you wrong on this one. I thought you meant to =
move
> > > the lock within do_readdir_lowlat(). About your actual suggestion abo=
ve
> > > ...>=20
> > > > > the loop. The normal case is not requiring a lock at all, like the
> > > > > comment
> > > > > describes. Doing multiple locks inside the loop unnecessaririly
> > > > > reduces
> > > > > performance for no reason.
> > > > >=20
> > > > > About *_trylock() instead of v9fs_readdir_lock(): might be a cand=
idate
> > > > > to
> > > >=20
> > > > Hmm... are you suggesting that do_readdir_lowlat() should return if=
 it
> > > > can't take the lock ?
> > >=20
> > > ... yep, that's what I had in mind for it later on. I would not mind
> > > running trylock in a loop like you suggested; if it fails, log a warn=
ing
> > > and return. Because if the lock fails, then client is buggy. User can
> > > read the warning in the logs and report the bug for client to be fixe=
d.
> > > Not worth to handle that case in any fancy way by server.
> >=20
> > The locking is just a safety net because readdir(3) isn't necessarily
> > thread safe. It was never my intention to add an error path for that.
> > And thinking again, sending concurrent Treaddir requests on the same
> > fid is certainly a weird thing to do but is it really a bug ?
>=20
> Well, I was unresolved on that issue as well, hence my decision to only l=
eave=20
> a TODO comment for now. My expectation would be separate fid for concurre=
nt=20
> readdir, but you are right of course, Treaddir (unlike its 9p2000.u=20
> counterpart) is reentrant by design, since it has an offset parameter, so=
 from=20
> protocol perspective concurrent Treaddir is not per se impossible.
>=20
> The lock would not be noticable either with this patch, since unlike on=20
> master, the lock is just retained on driver side now (with this patch), w=
hich=20
> returns very fast even on large directories, as you can see from the benc=
hmark=20
> output.
>=20
> So yes, returning from function with an error is probably not the best ch=
oice.=20
> My tendency is still though logging a message at least. I don't care abou=
t=20
> that too much though to deal with trylock() in a loop or something right =
now.=20
> There are more important things to take care of ATM.
>=20

Yeah, that can wait.

> > > avoid similar mistakes by placing appropriate comment(s).
> > >=20
> > > > > > > > +                                        struct V9fsDirEnt
> > > > > > > > **entries,
> > > > > > > > +                                        int32_t maxsize, b=
ool
> > > > > > > > dostat)
> > > > > >=20
> > > > > > s/maxsize/max_count since this is the wording use in the caller.
> > > > >=20
> > > > > Wouldn't do that. This is the driver side, not the 9p protocol re=
quest
> > > > > handler. As you might have relized before, "max_count" is semanti=
cally
> > > > > completely wrong. This variable does not count integral entries, =
it is
> > > > > rather a maximum size (in bytes) of the destination buffer being
> > > > > filled.
> > > > >=20
> > > > > On 9p request handler side it is ok to use "max_count" instead,
> > > > > because
> > > > > the
> > > > > protocol definition uses exactly this term for the request parame=
ter,
> > > > > but
> > > > > on driver side it's IMO inappropriate.
> > > >=20
> > > > I agree the max_count wording sucks and I don't care that much to
> > > > name variables according to protocol definitions, but I do care
> > > > to use the same name in caller/callee when it makes sense, for a
> > > > better grep or cscope experience.
> > >=20
> > > So you insist on that max_count change?
> >=20
> > Rather the opposite. Kill max_count and make it maxsize, in a preparato=
ry
> > patch with the reasons you've exposed.
>=20
> Ah got it. OK then.
>=20
> Best regards,
> Christian Schoenebeck
>=20
>=20


