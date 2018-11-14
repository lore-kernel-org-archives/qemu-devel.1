Received: from eggs.gnu.org ([2001:4830:134:3::10]:49519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gMzgp-0005nT-Tx
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 13:15:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gMzgl-0005qP-JH
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 13:14:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39082)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gMzgk-0005oe-H6
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 13:14:54 -0500
Date: Wed, 14 Nov 2018 18:14:36 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181114181435.GB2391@work-vm>
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
	<871s7nstle.fsf@dusky.pond.sub.org>
	<e935a267-a5ae-4dd4-a1a7-064c084671ab@redhat.com>
	<874lcjra28.fsf@dusky.pond.sub.org>
	<0e7341c4-364f-187a-4136-abc607d989df@redhat.com>
	<87lg5vlf8z.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87lg5vlf8z.fsf@dusky.pond.sub.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 00/41] RFC: slirp: make it again a
 standalone project
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, renzo@cs.unibo.it, Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel@nongnu.org, rjones@redhat.com, stefanha@redhat.com, samuel.thibault@ens-lyon.org, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>

* Markus Armbruster (armbru@redhat.com) wrote:
> Thomas Huth <thuth@redhat.com> writes:
>=20
> > On 2018-11-14 15:46, Markus Armbruster wrote:
> >> Thomas Huth <thuth@redhat.com> writes:
> >>=20
> >>> On 2018-11-14 13:59, Markus Armbruster wrote:
> >>>> Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com> writes:
> >>>>
> >>>>> Hi,
> >>>>>
> >>>>> Based-on: https://people.debian.org/~sthibault/qemu.git/ slirp br=
anch
> >>>>>
> >>>>> This series goal is to allow building libslirp as an independent =
library.
> >>>>>
> >>>>> While looking at making SLIRP a seperate running process, I thoug=
ht
> >>>>> that having an independent library from QEMU would be a first ste=
p.
> >>>>>
> >>>>> There has been some attempts to make slirp a seperate project in =
the past.
> >>>>> (https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg01092.h=
tml)
> >>>>> Unfortunately, they forked from QEMU and didn't provide enough
> >>>>> compatibility for QEMU to make use of it (in particular, vmstate
> >>>>> handling was removed, they lost git history etc). Furthermore, th=
ey
> >>>>> are not maintained as far as I can see.
> >>>>>
> >>>>> I would propose to make slirp a seperate project, that can initia=
lly
> >>>>> be used by QEMU as a submodule, keeping Makefile.objs until a pro=
per
> >>>>> shared library with stability guarantees etc is ready..
> >>>>>
> >>>>> The subproject could created by preserving git tags, and cleaning=
 up the code style, this way:
> >>>>>
> >>>>> git filter-branch --tree-filter "if ls * 1> /dev/null 2>&1; then =
clang-format -i * /dev/null; fi " -f --subdirectory-filter "slirp" --prun=
e-empty --tag-name-filter cat -- --all
> >>>>> (my clang-format https://gist.github.com/elmarco/cb20c8d92007df0e=
2fb8a2404678ac73)
> >>>>>
> >>>>> What do you think?
> >>>>
> >>>> Has the slirp code been improved to be generally useful?  I still =
got it
> >>>> filed under "friends don't let friends use that, except for testin=
g"...
> >>>
> >>> The slirp code is already used in a lot of other projects:
> >>=20
> >> The issue I have with SLIRP isn't that it solves a useless problem (=
au
> >> contraire!), it's that it's a useless solution.
> >
> > Ouch, that was completely arrogant and inappropriate. It's far away f=
rom
> > being useless,
>=20
> ... as I immediately admit ...
>=20
> >                and Samuel is doing a very good job in picking up all =
the
> > patches and fixes that have been posted in the past months. Have you =
had
> > a look at the changelog at all before you wrote that sentence?
>=20
> ... right in the next sentence:
>=20
> >> Okay, that's an unfair
> >> exaggeration, it's not useless, I just wouldn't trust it in producti=
on,
> >> unless it has improved significantly since I last looked at it.
>=20
> If my joke offended Samuel, or anyone, I offer my sincere apologies.
>=20
> > Nobody said that the slirp code would suddenly be perfect, but if it'=
s
> > getting even more traction and attention as a separate library (since
> > other projects might contribute their fixes back "upstream" in that
> > case), it could really get a solid building block for a lot of emulat=
ors
> > and similar software.
> [...]
>=20
> I'm afraid we're in violent agreement there.  I wrote:
>=20
> >> No objections to spinning it out, as long as it comes with a fair
> >> assessment of its limitations.
> >>=20
> >> Turning it into a proper project might even improve its chances to
> >> get improved towards production quality, compared to its current
> >> existence as a corner of QEMU next to nobody wants to touch.

One thought is that it might actually be the best standalone stack
around at the moment; I mean while I'm seeing people objecting
to bits of SLIRP, I'm not seeing anyone saying

'Why don't you just use ....'

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
