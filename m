Received: from eggs.gnu.org ([2001:4830:134:3::10]:46026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1eRzb7-00052N-Ut
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 07:05:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1eRzb1-0005sK-OB
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 07:05:13 -0500
Date: Thu, 21 Dec 2017 13:04:53 +0100
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20171221120453.GB1903@andariel.pipo.sk>
References: <2cd24073-b6d9-6479-59b1-869db6c25103@redhat.com>
	<87ind4gxcb.fsf@dusky.pond.sub.org>
	<20171220104436.fzucmsombnpyxoke@eukaryote>
	<20171220105740.GQ21216@redhat.com>
	<20171220133354.GD6374@localhost.localdomain>
	<20171220134018.GT21216@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ghzN8eJ9Qlbqn3iT"
Content-Disposition: inline
In-Reply-To: <20171220134018.GT21216@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] Raw notes from a small block
 layer/QAPI/something pre-christmas meeting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Qemu-block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>


--ghzN8eJ9Qlbqn3iT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2017 at 13:40:18 +0000, Daniel Berrange wrote:
> On Wed, Dec 20, 2017 at 02:33:54PM +0100, Kevin Wolf wrote:
> > Am 20.12.2017 um 11:57 hat Daniel P. Berrange geschrieben:
> > > On Wed, Dec 20, 2017 at 11:44:36AM +0100, Kashyap Chamarthy wrote:
> > > > On Mon, Dec 18, 2017 at 11:11:00AM +0100, Markus Armbruster wrote:
> > > > > Max Reitz <mreitz@redhat.com> writes:
> > > >=20
> > > > [...]
> > > >=20
> > > > Thanks, Max, for the detailed notes.
> > > >=20
> > > > > > Image creation in qemu-system-* vs. qemu-img:
> > > > > >   In order to get proper introspection for qemu-img create, we =
need a
> > > > > >   QAPI schema.  If we have a QAPI schema, we might as well add
> > > > > >   blockdev-create to QMP.
> > > > > >   As long as we do not have a really-none (null, void, ...) mac=
hine type
> > > > > >   for qemu-system-*, launching such a process just for creating=
 an image
> > > > > >   will bring quite a bit of overhead (e.g. with -M none -accel =
qtest).
> > > > > >   However, as for libvirt, this is not exactly a regression sin=
ce
> > > > > >   libvirt currently cannot create images at all (apart from imp=
licitly
> > > > > >   through drive-mirror etc.).  Further work on voidifying qemu-=
system-*
> > > > > >   will improve performance.
> > > > >=20
> > > > > Another thought: do we want to give qemu-system-* the necessary
> > > > > privileges for creating images?  Two cases: running with and with=
out a
> > > > > guest.
> > > >=20
> > > > Related: Just curious -- was it an explicit design decision to not =
give
> > > > `qemu-system-*` permissions to create disk images?
> > >=20
> > > Our security model considers QEMU broadly untrustworthy, and so any r=
esources
> > > it needs to use must either be passed in by libvirt, or have permissi=
ons
> > > explicitly assigned to permit usage by QEMU. QEMU is allowed to creat=
e tmp
> > > files, and create RAM files for memory backing, but in general we don=
't want
> > > to have QEMU able to create arbitrary files, only open things that are
> > > already created.
> >=20
> > Which kind of suggests that libvirt should use an external qemu-img
> > process rather than a QMP command to create images?
>=20
> That is my gut feeling, though Peter K might have other opinions as the
> person doing most libvirt work in this area.

Well then we need a way to do capability probing for qemu-img. And also
libvirt will then need a way to override the qemu-img binary on a per-VM
basis as we do with qemu binaries, so that users can switch to a more
capable binary.

If that will not be possible, block jobs for a VM might be impossible if
an old qemu-img is installed system-wide.

Also I really doubt it will save any qemu work when forcing us to do it
via qemu-img, since qemu-img still needs to be improved to support e.g.
creating an image on a multi-host gluster server [1], which currently is
not possible (basically we need the same capabilities as when opening an
image).


Peter


[1] You could argue, that if you select the properly functioning volfile
server from the list of servers configured by the user only one is
necessary for creating the image. Libvirt has no way of nowing which one
works though, so let's just have gluster figure it out by themselves.

--ghzN8eJ9Qlbqn3iT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAlo7o1wACgkQHGwCByjY
1Gp7Xg/+KhLiS2TnYFNn5Z9gy0ppioHIAXw2qm9Gn1dI9GrlS2AQXmZa4HiJcOas
Crvp5P3PadZLqhkRHGSbqq/0E3QzJcJd1P/gwADRbh+7b31xlUVUxM4b2w0OSHGC
s2evttRY7+mGLNR58gYgcvv3jfApE6HvXHgHLU4Qh0z9PC7umYXOghxm2jV9tidH
7ktYB+ndnQ58d99SDwL9+1O6+yocUUTVuGXF4NzANlia1fdbE+KQZjC8bn/bgRh2
4We+Vy4uF1qXLq8phjhq8rzykh+vRUXV8pSgOReJaH0v9XJj4H8K58N/xh7aJik3
eWONIhj4z/Thlz+f+rUuLJ321Jw3ZSflKsbVWBklE7j52EaypVTftQMm60/eq1w6
sg4JskvuP38V4pUE8hIydeQ2GWXgmeI/d9Tb1ezjir2/FituLHcMCDVmKjSY4rLk
BCbAE94uUVf6WZ3TGo4opgzAJyyAfZIezFuZfj5uMjL3HM2k/mCXNlPQihFSgxjY
Ax9ORmF/Gfe7/0parOqNUxp24Cr3akAvVOYIc25qSBYq85LOsMC5mK9eQcBWY+z8
wzZYMlu967GJM2bqLXHwvWgajwdwBRy/lzjeOj0r5CNy0UgycTu47OlPd5jgl/RZ
y/vAD0YBh7vbxseYW8fNH8u/YmgsgQjLxdRQDPN5l6WQZIYWEsU=
=qBQ9
-----END PGP SIGNATURE-----

--ghzN8eJ9Qlbqn3iT--
