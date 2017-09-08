Received: from eggs.gnu.org ([2001:4830:134:3::10]:55347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dqLhv-0001aN-B7
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 12:00:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dqLhn-0007Bz-Nz
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 12:00:34 -0400
Date: Fri, 8 Sep 2017 18:00:11 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170908160011.GA17516@localhost.localdomain>
References: <20170825132332.6734-1-el13635@mail.ntua.gr>
	<20170825132332.6734-5-el13635@mail.ntua.gr>
	<20170907132611.GG4461@dhcp-200-186.str.redhat.com>
	<20170908154459.5xpyczgpvim75o62@postretch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <20170908154459.5xpyczgpvim75o62@postretch>
Subject: Re: [Qemu-devel] [PATCH v3 4/7] block: remove legacy I/O throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 08.09.2017 um 17:44 hat Manos Pitsidianakis geschrieben:
> On Thu, Sep 07, 2017 at 03:26:11PM +0200, Kevin Wolf wrote:
> > We shouldn't really need any throttling code in
> > blk_root_drained_begin/end any more now because the throttle node will
> > be drained. If this code is necessary, a bdrv_drain() on an explicit
> > throttle node will work differently from one on an implicit one.
> >=20
> > Unfortunately, this seems to be true about the throttle node. Implicit
> > throttle nodes will keep ignoring the throttle limit in order to
> > complete the drain request quickly, where as explicit throttle nodes
> > will process their requests at the configured speed before the drain
> > request can be completed.
> >=20
> > This doesn't feel right to me, both should behave the same.
> >=20
> > Kevin
> >=20
>=20
> I suppose we can implement bdrv_co_drain and increase io_limits_disabled
> from inside the driver. And then remove the implicit filter logic from
> blk_root_drained_begin. But there's no _end callback equivalent so we can=
't
> decrease io_limits_disabled at the end of the drain. So I think there are
> two options:
>=20
> - make a bdrv_co_drain_end cb and recurse in blk_root_drain_end for all
> children to call it. Old behavior of I/O bursts (?) during a drain is  ke=
pt.

This is the solution I was thinking of. It was always odd to have a
drained_begin/end pair in the external interface and in BdrvChildRole,
but not in BlockDriver. So it was to be expected that we'd need this
sooner or later.

> - remove io_limits_disabled and let throttled requests obey limits  durin=
g a
> drain

This was discussed earlier (at least when the disable code was
introduced in BlockBackend, but I think actually more than once), and
even though everyone agreed that ignoring the limits is ugly, we
seem to have come to the conclusion that it's the least bad option.
blk_drain() blocks and makes everything else hang, so we don't want it
to wait for several seconds.

Kevin

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZsr6LAAoJEH8JsnLIjy/WH2AQAIPgqfHfa1XYO+L18hZ/YuIz
1bRA9JToc5r9pKR4euyvgt0J6HCjB65UzVhm44olVgd/N8uMIKpeUXiTDt3Xq21Q
/b5ctxC8BZb9qZOmZ6FoYiyNgdfzbSyFZ/yNy/AuBI1MfPWXJJ2UP0ZkijpgVpeg
mYlO06hdnIoih6wWzPL0aJYTnIGlUjX+oOrJ7TBmbPvspQB67KuHuv4lZsr/wIp3
GNVLZVKG0InuAUIa+/elj/XLgxzpyhlLCISz+EJxVaLsZ2qVF7K6K9Vp2WEC9fLv
2vQLq5Fflxhn0vCUdxwpk+U7L1tV4HLGheuiimECyGCsRlFiZPPG75jXFCCSwZpn
x4UeyOoMj3qkmtFSFZu8LS/tO4lSrAk2rmo2PHaytfCBJ0T1aSn06uKciUW9mtt9
06Kl6iiRKY4N9z/qImzOpZ3zmX1BXMxMjwaemNEkoWrbnTZx8m954jhw7ZmoBEMc
mugd20vD2VHa4YE91w0/7RAS0WO0s+2OqeDVQxDk551u8jxHSSopGU4pya95Z7mU
caozP3INRaIH7YI4pFiXz6TV7oMFMO4w11Nkc+/f2cz70Z9GVzx13qWPGzIOS2la
YT+6OBwo7MacptMqXjERkXQuyyeY5/oEUFUfn2QRJRs09nGzcI98UweHrUDQXUz0
gF4NEDNhhsf7lDcaIO32
=BJpD
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
