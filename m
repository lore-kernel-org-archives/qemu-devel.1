Received: from eggs.gnu.org ([209.51.188.92]:39480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hBf6J-0005ys-3o
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 08:34:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hBf6I-0003Z9-35
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 08:34:43 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:53028)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hBf6H-0003XJ-Oo
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 08:34:42 -0400
Received: by mail-wm1-x32d.google.com with SMTP id a184so7195231wma.2
	for <qemu-devel@nongnu.org>; Wed, 03 Apr 2019 05:34:41 -0700 (PDT)
Date: Wed, 3 Apr 2019 13:34:38 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190403123438.GE32425@stefanha-x1.localdomain>
References: <20190401163240.xw24ezsloy5ds2hz@steredhat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ffoCPvUAPMgSXi6H"
Content-Disposition: inline
In-Reply-To: <20190401163240.xw24ezsloy5ds2hz@steredhat>
Subject: Re: [Qemu-devel] VSOCK benchmark and optimizations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: alex.bennee@linaro.org, netdev@vger.kernel.org, qemu devel list <qemu-devel@nongnu.org>


--ffoCPvUAPMgSXi6H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2019 at 06:32:40PM +0200, Stefano Garzarella wrote:
> Hi Alex,
> I'm sending you some benchmarks and information about VSOCK CCing qemu-de=
vel
> and linux-netdev (maybe this info could be useful for others :))
>=20
> One of the VSOCK advantages is the simple configuration: you don't need t=
o set
> up IP addresses for guest/host, and it can be used with the standard POSIX
> socket API. [1]
>=20
> I'm currently working on it, so the "optimized" values are still work in
> progress and I'll send the patches upstream (Linux) as soon as possible.
> (I hope in 1 or 2 weeks)
>=20
> Optimizations:
> + reducing the number of credit update packets
>   - RX side sent, on every packet received, an empty packet only to infor=
m the
>     TX side about the space in the RX buffer.
> + increase RX buffers size to 64 KB (from 4 KB)
> + merge packets to fill RX buffers
>=20
> As benchmark tool I used iperf3 [2] modified with VSOCK support:
>=20
>              host -> guest [Gbps]      guest -> host [Gbps]
> pkt_size    before opt.  optimized    before opt.  optimized
>   1K            0.5         1.6           1.4         1.4

This is a "large" small package size.  I think 64 bytes is a common
"small" packet size and is worth benchmarking too.

>   2K            1.1         3.1           2.3         2.5
>   4K            2.0         5.6           4.2         4.4
>   8K            3.2        10.2           7.2         7.5
>   16K           6.4        14.2           9.4        11.3
>   32K           9.8        18.9           9.2        17.8
>   64K          13.8        22.9           8.8        25.0
>   128K         17.6        24.5           7.7        25.7
>   256K         19.0        24.8           8.1        25.6
>   512K         20.8        25.1           8.1        25.4

Nice improvements!

Stefan

--ffoCPvUAPMgSXi6H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcpKheAAoJEJykq7OBq3PIOhMH/jn0n/B4SJRqNcVaK9jkIf+F
B62z06ZVBmtX1xBExOpb5uCCHv4SSy/lqBRSXWbbOAqnxHDLj8Tua+d4ps2naUEt
PzfOaA4+QCmQYjyj4ZHSTgS695U0Q6/SEN64CWNcWF+gzUXVPdMnl3qfwkt5toEn
6kd3fG5Ovo5X+VPuZpQfz004pBizQb9NSKqRbKq0omYROhq+O/m8qr0uvbpivrcA
nfJQB65W84BODa8mM4O9zVZFc6Btm7eF7OTIbf7AyaFU7mj00hh+Ls1GoWO0KA4l
bCTOyLeOswCpqvxfvC6pr6tXE9KmQdEO7Hk2vyckw9orpyFWQqiLa0Qvp5iFXb0=
=tXoU
-----END PGP SIGNATURE-----

--ffoCPvUAPMgSXi6H--
