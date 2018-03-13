Received: from eggs.gnu.org ([2001:4830:134:3::10]:34834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1evmnh-0002uX-CI
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:29:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1evmne-0000vj-4f
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:29:21 -0400
Received: from 10.mo173.mail-out.ovh.net ([46.105.74.148]:37989)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1evmnd-0000pz-Qq
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:29:18 -0400
Received: from player711.ha.ovh.net (unknown [10.109.105.110])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 74BB6B12BE
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 17:29:07 +0100 (CET)
Date: Tue, 13 Mar 2018 17:28:55 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180313172855.41995f0b@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <CAJSP0QX6jciq69Q69Dv_jsy2_aC6sx-e9ev-8faVn11+YK-xhg@mail.gmail.com>
References: <20180311201239.25506-1-nia.alarie@gmail.com>
	<486e1b60-e453-c3de-040b-8b2951ddf3a5@redhat.com>
	<20180312140229.66930d5d@bahia.lan>
	<20180312130829.GR3493@redhat.com>
	<20180312142131.397c5ba1@bahia.lan>
	<CA+k8WDrpNMcDSqSy_L3Ucyj++Kvz2AQR_DsbHAdOiPbW9WVn5w@mail.gmail.com>
	<CAJSP0QX6jciq69Q69Dv_jsy2_aC6sx-e9ev-8faVn11+YK-xhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] 9p: Convert use of atoi to qemu_strtol to
 allow error checking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: nee <nia.alarie@gmail.com>, "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Jim Mussared <jim@groklearning.com>, Joel Stanley <joel@jms.id.au>

On Tue, 13 Mar 2018 15:52:41 +0000
Stefan Hajnoczi <stefanha@gmail.com> wrote:

> On Tue, Mar 13, 2018 at 3:25 PM, nee <nia.alarie@gmail.com> wrote:
> > On Mon, Mar 12, 2018 at 1:21 PM, Greg Kurz <groug@kaod.org> wrote: =20
> >> On Mon, 12 Mar 2018 13:08:29 +0000
> >> Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> >> =20
> >>> On Mon, Mar 12, 2018 at 02:02:29PM +0100, Greg Kurz wrote: =20
> >>> > On Mon, 12 Mar 2018 07:12:52 -0500
> >>> > Eric Blake <eblake@redhat.com> wrote:
> >>> > =20
> >>> > > On 03/11/2018 03:12 PM, Nia Alarie wrote: =20
> >>> > > > Signed-off-by: Nia Alarie <nia.alarie@gmail.com>
> >>> > > > ---
> >>> > > >   hw/9pfs/9p.c | 12 ++++++++++--
> >>> > > >   1 file changed, 10 insertions(+), 2 deletions(-)
> >>> > > > =20
> >>> > > =20
> >>> > > >       } else if (perm & P9_STAT_MODE_LINK) {
> >>> > > > -        int32_t ofid =3D atoi(extension.data);
> >>> > > > -        V9fsFidState *ofidp =3D get_fid(pdu, ofid);
> >>> > > > +        long ofid;
> >>> > > > +        V9fsFidState *ofidp;
> >>> > > > +
> >>> > > > +        if (qemu_strtol(extension.data, NULL, 10, &ofid) ||
> >>> > > > +            ofid > INT32_MAX || ofid < INT32_MIN) { =20
> >>> > >
> >>> > > Dan has a pending patch that will add qemu_strtoi, which might be=
 a
> >>> > > nicer fit for this situation:
> >>> > >
> >>> > > https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg00952.ht=
ml
> >>> > >
> >>> > > int32_t is not necessarily int, but all platforms that compile qe=
mu have
> >>> > > 'int32_t' and 'int' both at 32 bits, so it's simpler to change to=
 'int
> >>> > > ofid' and use Dan's function than it is to parse to long and then=
 do
> >>> > > bounds checking.  Except that Dan still needs to post an updated =
version
> >>> > > of his patch...
> >>> > > =20
> >>> >
> >>> > I wasn't aware of Dan's patch but I agree it would result in a nicer
> >>> > change for 9p. This being said, tomorrow is soft freeze... is there
> >>> > a chance Dan's patch reaches master anytime soon ? =20
> >>>
> >>> I just sent an update of my series. If it gets acked by Eric, I'd be =
able
> >>> to send a pull request today.
> >>>
> >>> Regards,
> >>> Daniel =20
> >>
> >> Great !
> >>
> >> Nia,
> >>
> >> Could you please respin your patch on top of Daniel's series, using
> >> qemu_strtoui() ?
> >>
> >> Thanks,
> >>
> >> --
> >> Greg =20
> >
> > I'm a bit unclear on how this works so I thought I'd ask here before I
> > send any more patches - this is CCed to my mentors as well. It's
> > "tomorrow" now, but I don't understand how soft freezes work or the
> > process beyond "I send this patch to qemu-devel and people say if I
> > should re-send it with changes, or that it's been accepted" :) =20
>=20
> Don't worry about the soft freeze for now.  The soft freeze is the
> deadline for new features.  People are trying to get their new
> features into the upcoming QEMU 2.12 release.
>=20
> Either Greg will still merge your patch after soft freeze since it can
> be considered a bug fix (fixes are allowed during freeze).  Or Greg
> might keep your patch queued until the QEMU 2.12 release has been made
> (around April 17th 2018).
>=20

Nia (or Nee?) 's patch is a bug fix. I'll happily merge it when it's
ready.

> The QEMU release schedule is here (but don't worry about it):
> https://wiki.qemu.org/Planning/2.12
>=20
> I suggest taking the following action.  Wait until Daniel Berrange's
> pull request is merged (it will probably happen today):
> https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg03662.html
>=20
> Then rebase your patch onto the latest qemu.git/master so you can take
> advantage of qemu_strtoi().  You can use "git rebase -i origin/master"
> to do this.
>=20
> Recompile/test your patch and then send it with "[PATCH v2] 9p:
> Convert use of atoi to qemu_strtoi to allow error checking" as the
> email subject.
>=20

Nia had already sent a v2, which got comments, so it'll be v3.

> > There are several more conversions from ato* to qemu_strto* I'd like
> > to submit from now on. Should I send them as using qemu_strtol now, to
> > get them "out there" before my own personal deadlines, and send
> > further patches to convert them to qemu_strtoi later, or should I
> > submit patches that use qemu_strtoi? I'm not sure of the current
> > status of Daniel's patches. =20
>=20
> Daniel's patches will be in qemu.git/master (probably) later today.  I
> suggest waiting for them and using qemu_strtoi() where using an int
> type is appropriate.
>=20
> If you have questions along the way, feel free to ask on the QEMU IRC
> channel: #qemu on irc.oftc.net.
>=20
> Stefan

Agreed with all of the above. Thanks Stefan for providing this comprehensive
explanation to Nia.

Cheers,

--
Greg
