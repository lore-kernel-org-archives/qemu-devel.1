Received: from eggs.gnu.org ([2001:4830:134:3::10]:50467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1evNOb-00073b-M2
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:21:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1evNOW-0003Sd-K5
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:21:45 -0400
Received: from 14.mo7.mail-out.ovh.net ([178.33.251.19]:55665)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1evNOW-0003Qx-Cb
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:21:40 -0400
Received: from player693.ha.ovh.net (unknown [10.109.120.161])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id E302295EAD
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 14:21:38 +0100 (CET)
Date: Mon, 12 Mar 2018 14:21:31 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180312142131.397c5ba1@bahia.lan>
In-Reply-To: <20180312130829.GR3493@redhat.com>
References: <20180311201239.25506-1-nia.alarie@gmail.com>
	<486e1b60-e453-c3de-040b-8b2951ddf3a5@redhat.com>
	<20180312140229.66930d5d@bahia.lan>
	<20180312130829.GR3493@redhat.com>
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
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Nia Alarie <nia.alarie@gmail.com>, qemu-devel@nongnu.org, stefanha@gmail.com, jim@groklearning.com, joel@jms.id.au

On Mon, 12 Mar 2018 13:08:29 +0000
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Mon, Mar 12, 2018 at 02:02:29PM +0100, Greg Kurz wrote:
> > On Mon, 12 Mar 2018 07:12:52 -0500
> > Eric Blake <eblake@redhat.com> wrote:
> >  =20
> > > On 03/11/2018 03:12 PM, Nia Alarie wrote: =20
> > > > Signed-off-by: Nia Alarie <nia.alarie@gmail.com>
> > > > ---
> > > >   hw/9pfs/9p.c | 12 ++++++++++--
> > > >   1 file changed, 10 insertions(+), 2 deletions(-)
> > > >    =20
> > >  =20
> > > >       } else if (perm & P9_STAT_MODE_LINK) {
> > > > -        int32_t ofid =3D atoi(extension.data);
> > > > -        V9fsFidState *ofidp =3D get_fid(pdu, ofid);
> > > > +        long ofid;
> > > > +        V9fsFidState *ofidp;
> > > > +
> > > > +        if (qemu_strtol(extension.data, NULL, 10, &ofid) ||
> > > > +            ofid > INT32_MAX || ofid < INT32_MIN) {   =20
> > >=20
> > > Dan has a pending patch that will add qemu_strtoi, which might be a=20
> > > nicer fit for this situation:
> > >=20
> > > https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg00952.html
> > >=20
> > > int32_t is not necessarily int, but all platforms that compile qemu h=
ave=20
> > > 'int32_t' and 'int' both at 32 bits, so it's simpler to change to 'in=
t=20
> > > ofid' and use Dan's function than it is to parse to long and then do=
=20
> > > bounds checking.  Except that Dan still needs to post an updated vers=
ion=20
> > > of his patch...
> > >  =20
> >=20
> > I wasn't aware of Dan's patch but I agree it would result in a nicer
> > change for 9p. This being said, tomorrow is soft freeze... is there
> > a chance Dan's patch reaches master anytime soon ? =20
>=20
> I just sent an update of my series. If it gets acked by Eric, I'd be able
> to send a pull request today.
>=20
> Regards,
> Daniel

Great !

Nia,

Could you please respin your patch on top of Daniel's series, using
qemu_strtoui() ?

Thanks,

--
Greg
