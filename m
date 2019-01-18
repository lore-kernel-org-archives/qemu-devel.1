Received: from eggs.gnu.org ([209.51.188.92]:46528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gkRAh-0005mO-8L
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:14:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gkRAg-0004fM-5B
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:14:43 -0500
Date: Fri, 18 Jan 2019 11:14:15 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190118101415.GC4530@dhcp-200-176.str.redhat.com>
References: <cover.1547475602.git.berto@igalia.com>
	<20190116135444.GA16898@stefanha-x1.localdomain>
	<w51d0ov2z9h.fsf@maestria.local.igalia.com>
	<20190118095652.GA21579@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <20190118095652.GA21579@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v2 0/6] Acquire the AioContext during
 _realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, armbru@redhat.com


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 18.01.2019 um 10:56 hat Stefan Hajnoczi geschrieben:
> On Thu, Jan 17, 2019 at 02:24:10PM +0100, Alberto Garcia wrote:
> > On Wed 16 Jan 2019 02:54:44 PM CET, Stefan Hajnoczi wrote:
> > > This patch series makes virtio-blk and virtio-scsi more robust,
> > > although I haven't checked what happens if the drive is attached to a
> > > different IOThread than the device - will the switchover work?
> >=20
> > You mean if you use x-blockdev-set-iothread with a drive and then attach
> > it to a device using a different thread? That seems to work (with my
> > patch).
>=20
> Does it work with a running VM that will do I/O?  If yes, then that's
> great and we should merge the virtio-blk/scsi patches to make them
> robust for this case.  I'm a little surprised it works though :-)
> because the code wasn't designed or tested for this.

There are two ways to trigger the crash even without
x-blockdev-set-iothread:

* device_del, then device_add for a device with iothread (virtio-scsi;
  may or may not exist with virtio-blk)
  https://bugzilla.redhat.com/show_bug.cgi?id=3D1656276

* Simply attach two devices with iothread to the the same node
  https://bugzilla.redhat.com/show_bug.cgi?id=3D1662508

Maybe this series is actually papering over the real problems, though.
Unplug should move the BDS back to the main AioContext, and attaching
two users with different AioContexts must fail. If we don't take care
there, the locking will be wrong.

Note that even though there are more problems, we still need this series
so we can allow attaching two devices to the same node while using the
same iothread.

Kevin

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcQab3AAoJEH8JsnLIjy/WyUIQAKVDn8xzC6OqWjvahQ0lSxUV
zkNC+Xan/JpeHzpkL0ekRk5PwxiIsjqvGu8CifYdBpTGFicnRLewUs56FDwSOpCo
OG1ksxqUFhzBaiE9XdxQMQIKEnIXHl4WmWBRzDUNTPhdNQMC9uUi1R6c3RNTvBJt
bht/2VTo8WrTTr52BM5DgN/HTphtO2O3TYroR73Mi/gVSBbjxLS1XCm4oAO2ws3L
+rSFZHHBELSYTkWy6fcT53FdWHQpbhKxqHhXg6f+Z7CPb3s3wNMZpsEQE/FlxQ5c
e2xsdGZzl7ieeRd6mUFlkA3b7EmhlJzZkK1MXcV6fN+nSodvCOrqtg3nX/KzlCAc
SgS7myyZ49k4JvPJA4k/WbKixmtfEPj3pM2/5rpO1lFIi8XxKtmDKPG08cl/R6cX
BFDbtOLJ9gjWrXkeZb2017f3Q6vVv+l9qXjyPB6cAqj0BJ32XLGJzqXUvRrl50vx
CqafFaWKXA+ECSh351rMze15g9/XrjggWhZ2YodS8qUMElqUVKOCqctVsOceoHgF
ZP19WA1uOBxei6xW6IFn2j0yIBlHu0tnS9J+XxOzd1UGMk3DbbJXo61TGxiWE8/A
xuAJYY84gZTY1j984Gzk6hIlkOpRgBTmt25rHRe3DPc+51LXwxtRyp0vcdsGK2b8
YCYQgbYXTJW/TWrNZ5Qn
=vnrH
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
