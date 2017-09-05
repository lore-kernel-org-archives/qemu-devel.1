Received: from eggs.gnu.org ([2001:4830:134:3::10]:58016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dp9gG-00016z-5y
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 04:58:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dp9gB-0001sw-Hw
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 04:58:00 -0400
Received: from 2.mo178.mail-out.ovh.net ([46.105.39.61]:49949)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dp9gB-0001sD-Bf
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 04:57:55 -0400
Received: from player728.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id AECAF4B576
	for <qemu-devel@nongnu.org>; Tue,  5 Sep 2017 10:57:53 +0200 (CEST)
Date: Tue, 5 Sep 2017 10:57:37 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170905105737.6c1df601@bahia>
In-Reply-To: <75f2f6f9-7d23-dced-6920-4b0be04876b9@huawei.com>
References: <1504541267-36954-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1504541267-36954-7-git-send-email-pradeep.jagadeesh@huawei.com>
	<w51tw0h7f9t.fsf@maestria.local.igalia.com>
	<75f2f6f9-7d23-dced-6920-4b0be04876b9@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/3j1mJ8bAedP+5FyeuQGIMEv";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v10 6/6] fsdev: hmp interface for throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Cc: Alberto Garcia <berto@igalia.com>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, eric blake <eblake@redhat.com>, "Dr. David
	Alan Gilbert" <dgilbert@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

--Sig_/3j1mJ8bAedP+5FyeuQGIMEv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 5 Sep 2017 10:28:02 +0200
Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com> wrote:

> On 9/5/2017 9:53 AM, Alberto Garcia wrote:
> > On Mon 04 Sep 2017 06:07:47 PM CEST, Pradeep Jagadeesh wrote:
> > =20
> >> +void hmp_info_fsdev_iothrottle(Monitor *mon, const QDict *qdict)
> >> +{
> >> +    Error *err =3D NULL;
> >> +    IOThrottleList *fsdev_list, *info;
> >> +    fsdev_list =3D qmp_query_fsdev_io_throttle(&err);
> >> +
> >> +    for (info =3D fsdev_list; info; info =3D info->next) {
> >> +        print_fsdev_throttle_config(mon, info->value);
> >> +    }
> >> +    qapi_free_IOThrottleList(fsdev_list);
> >> +} =20
> >
> > You're passing an Error to qmp_query_fsdev_io_throttle() but then you
> > don't handle it. Use hmp_handle_error() as I said in my previous e-mail=
. =20
> OK I will handle it.
> >
> > I know that with the current code qmp_query_fsdev_io_throttle() is never
> > going to fail, but that's no reason to declare an Error and then ignore
> > it. =20
> I need to pass err because the function=20
> qmp_query_fsdev_io_throttle(Error *) is created by the scripts. So, I=20

It isn't created by the scripts, it is introduced by patch 5 of this series.
But yes, the generated code expects this function to have an Error ** (not
Error *) argument.

> have to declare and pass it. I do not is there any way to avoid this.
>=20

If you don't care for errors (because you know that the function can't
fail), then you just need to pass NULL. But as Berto is saying, if you
do pass an non-null Error ** then you should handle it.

Cheers,

--
Greg

> -Pradeep
> >
> > Berto
> > =20
>=20


--Sig_/3j1mJ8bAedP+5FyeuQGIMEv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQr1DtEU17Ap5iU26IC/DrrAQHbwgUCWa5nAQAKCRAC/DrrAQHb
whFLAKCc/XqHy9co65cpXpPNPZkAYxZz6QCfV+cCGl3H4UNrAmMCiRUsSYHnPtY=
=c3JZ
-----END PGP SIGNATURE-----

--Sig_/3j1mJ8bAedP+5FyeuQGIMEv--
