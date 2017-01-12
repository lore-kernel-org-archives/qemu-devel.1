Received: from eggs.gnu.org ([2001:4830:134:3::10]:47635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cRgYD-0000qV-PW
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 09:40:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cRgYC-0005ZI-1Z
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 09:40:25 -0500
Date: Thu, 12 Jan 2017 14:40:06 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170112144006.GE14042@stefanha-x1.localdomain>
References: <586CB62C.6080504@huawei.com>
	<c7c4fd91-1374-7371-1ff9-533a8e916f2a@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/2994txjAzEdQwm5"
Content-Disposition: inline
In-Reply-To: <c7c4fd91-1374-7371-1ff9-533a8e916f2a@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] NBD handshake may block qemu main
 thread when socket delays or has packet loss
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "Fangyi (C)" <eric.fangyi@huawei.com>, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, lina.lulina@huawei.com, qemu-block@nongnu.org, subo7@huawei.com, qemu-devel@nongnu.org, wu.wubin@huawei.com, "jiangxiaoqing (C)" <sochin.jiang@huawei.com>


--/2994txjAzEdQwm5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 04, 2017 at 02:44:53PM -0600, Eric Blake wrote:
> On 01/04/2017 02:45 AM, Fangyi (C) wrote:
> >     As we all know, socket is in blocking mode when nbd is negotiating
> > with the other end. If the network is poor because of delay or packet
> > loss, socket read or write will return very slowly. The mainloop events
> > won't be handled in time util nbd handshake ends.
>=20
> I wonder if Paolo's work to improve NBD coroutine usage after handshakes
> can be leveraged here?
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2016-12/msg03224.html
>=20
> >=20
> >     Any advices to solve the problem?
>=20
> At any rate, it sounds like someone will have to patch NBD code to use
> coroutines instead of blocking for the handshake portion (and that's
> true in general - ANY operation that can block should probably be
> refactored into aio or coroutines so that the main loop can remain
> responsive).

This is a general issue with network block drivers.  They tend to do
blocking DNS resolution, blocking connection, and blocking protocol
handshake/negotiation in .bdrv_open().

We cannot expose a block device to the guest before it has been opened
because the disk's capacity is unknown plus the guest would experience
I/O timeouts or errors.

I think we need to agree on how to handle this for all different types
of network protocols, not just nbd, before code can be written.

One starting point is:

Should we make .drv_open() a coroutine and introduce a async concept to
blockdev_add, reopen, etc?

The BlockDriverState would be in a special OPENING or OFFLINE state
where its name is reserved but it cannot be used for I/O or emulated
devices yet.

QMP clients would have watch out for an event that tells them that it's
now okay to device-add the emulated storage device using the drive.

Any ideas for a nicer solution?

Stefan

--/2994txjAzEdQwm5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYd5VGAAoJEJykq7OBq3PI2sUH/1OnCgZmmvWTUVjD688++GGM
cSl+vgvwhmbf7yMqHvUiyT+agLdPU6DC7VX2U8bKX/oDtQRromL4tT5iltj+MECA
vrAO5NWXcUzn5/80Dw8Q761IBqNEuRI1QPCharZiwXhBclBqAuFPn3TdtbrW5kfy
xE/A0XBjz4v1OM4kR5KYSHClDJ0e7PZgCIota7+TYDLL4MMHcP4BD1FEfupz6jGI
b0ktHuH0DXE/FBfxX+YpWQZ53ezaH61adc+TJbZ+417vv3+WoWUkLFgXGFrvNDg2
k5AG5ORZX9+UPL7mmkL7UBBZ6+KtKGkIPQwxVXE5F0spVO7dGCYtuNLo9pWtqMI=
=pXHG
-----END PGP SIGNATURE-----

--/2994txjAzEdQwm5--
