Received: from eggs.gnu.org ([2001:4830:134:3::10]:39269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cEZiG-0001sc-SF
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 05:44:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cEZiF-00051s-ND
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 05:44:36 -0500
Date: Wed, 7 Dec 2016 11:44:25 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20161207104425.GC4773@noname.str.redhat.com>
References: <20161205234235.5728-1-eblake@redhat.com>
	<20161206092523.GA4990@noname.str.redhat.com>
	<871488c7-b870-da8f-1a71-c2462214e650@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lEGEL1/lMxI0MVQ2"
Content-Disposition: inline
In-Reply-To: <871488c7-b870-da8f-1a71-c2462214e650@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] doc: Propose
 NBD_FLAG_INIT_ZEROES extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: nbd-general@lists.sourceforge.net, xieyingtai@huawei.com, subo7@huawei.com, qemu-block@nongnu.org, eric.fangyi@huawei.com, qemu-devel@nongnu.org, pbonzini@redhat.com


--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 06.12.2016 um 16:21 hat Eric Blake geschrieben:
> On 12/06/2016 03:25 AM, Kevin Wolf wrote:
> > Am 06.12.2016 um 00:42 hat Eric Blake geschrieben:
> >> While not directly related to NBD_CMD_WRITE_ZEROES, the qemu
> >> team discovered that it is useful if a server can advertise
> >> whether an export is in a known-all-zeroes state at the time
> >> the client connects.
> >=20
> > Does a server usually have the information to set this flag, other than
> > querying the block status of all blocks at startup? If so, the client
> > could just query this by itself.
>=20
> Well, only if the client can query information at all (we don't have the
> documentation finished for extent queries, let alone a reference
> implementation).

Right, but I think we all agree that this is something that is necessary
and will come sooner or later.

> > The patch that was originally sent to qemu-devel just forwarded qemu's
> > .bdrv_has_zero_init() call to the server. However, what this function
> > returns is not a known-all-zeroes state on open, but just a
> > known-all-zeroes state immediately after bdrv_create(), i.e. creating a
> > new image. Then it becomes information that is easy to get and doesn't
> > involve querying all blocks (e.g. true for COW image formats, true for
> > raw on regular files, false for raw on block devices).
>=20
> Just because the NBD spec describes the bit does NOT require that
> servers HAVE to set the bit on all images that are all zeroes.  It is
> perfectly compliant if the server never advertises the bit.

True, but if no server exists that would actually make use of the
feature, it's kind of useless to include it in the spec.

I think we should have concrete use cases in mind when extending the
spec, and explain them in the commit message. Just "maybe this could be
useful for someone sometime" isn't a good enough justification if you
ask me.

> That said, I think there are cases where qemu can easily advertise the
> bit.
>=20
> I _do_ agree that it is NOT as trivial as the qemu server just
> forwarding the value of .bdrv_has_zero_init() - the server HAS to prove
> that no data has been written to the image.  But for a qcow2 image just
> created with qemu-img, it is a fairly easy proof: If the L1 table has
> all-zero entries, then the image has not been written to yet.  Reading
> the L1 table for all-zeroes is only a single cluster read, which is MUCH
> faster than crawling the entire image for extent status.  And for
> regular files, a single lseek(SEEK_DATA) is sufficient to see if the
> entire image is currently sparse.
>=20
> Note that I only proposed the NBD implementation - it still remains to
> be coded into the qemu code for the client to make use of the bit
> (fairly easy: if the bit is set, the client can make its own
> .bdrv_has_zero_init() return true), as well as for the server to set the
> bit (harder: the server has to check .bdrv_has_zero_init() of the
> wrapped image, but also has to prove the image is still unwritten).
> Maybe this means that qemu's block layer wants to add a new
> .bdrv_has_been_written() [or whatever name] to better abstract the proof
> across drivers.  But those patches would be qemu 2.9 material, and do
> not need to further cc the NBD list.

qemu doesn't really know whether an image has been written to since it
has been created. The interesting case is probably where the image is
created externally with qemu-img before it's exported either with
qemu-nbd or the builtin server, and then we use it as a mirror target.

Even in the rare cases where both image creation and the NBD server are
in the same process, bdrv_create() doesn't work on a BlockDriverState,
but just on a filename. So even then you would have to do hacks like
remembering file names between create and the first open or something
like that.

> > This is useful for 'qemu-img convert', which creates an image and then
> > writes the whole contents, but I'm not sure if this property is
> > applicable for NBD, which I think doesn't even have a create operation.
>=20
> Another option on the NBD server side is to create a server option -
> when firing up a server to serve a particular file as an export, the
> user can explicitly tell the server to advertise the bit because the
> user has side knowledge that the file was just created (and then the
> burden of misbehavior is on the user if they mistakenly request the
> advertisement when it is not true).

Maybe that's the only practical approach.

Kevin

--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYR+gJAAoJEH8JsnLIjy/WEbAP/RCrr6VBqErGo2VR2sby72ek
0P7k3guhPwFnw+Jgz1eRN+UX1VnFlCl2hRZUQeTfJQe2WfRn+q98z88zt3eat6Qx
ApfzUGFaWtSzi2q6eGLQrmsX1oOQfz0FeFa9hHI9Bny9SNPaqqcOWUlZ63rW9zqP
wDAtSirl5AUGiiFd1F+v69jLLuuGeaVY0Ria+glzc+fXk1zg6Xv5QQmwrijPTiCR
fbpe7OY4detQUAvUgswNUpNop/PAA2E3x+dDE5AzCHl+UBfDj2b/dhRHtc1vH0pB
XNjS8C3AaKJewsj9TRaUB5K8JLzPPIytM7ZQsEFhxgd8ZbxgtPpPLScaPeh9HnEY
gN/YoUXZkYY5L47XZyfLsykNfNnrqZuj9oP+9m5AdqboKotpqE+tB3CFjfRvga34
PYgE6UJQr99DoLTRtui0wNplXGJtPdObxmsUT0RrUc9EXQE9+M7HYFnC9wv9DtGK
75uZHX72dlV4G5WzvovBsQQ+2TIhPrsiSt1Fz1NtbDBlfIuteZCrVRXQDTkrYn2a
6r+K31mZ6QaIBS5DwQtNx6/eGcKvbRuFVkeWD1g9KhMzk9MOWOjcBZ91s6PNcqHX
WOWOGg/j19Okc7GgA8GkeFSJEkeMJn8ejO0bwrB1NUd/mSbbATiAaabuKRCYucQe
wej2QN2jBGzmh7tb104o
=sH0K
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--
