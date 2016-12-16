Received: from eggs.gnu.org ([2001:4830:134:3::10]:34358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cHpzL-0004ux-8M
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 05:43:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cHpzG-0006Ry-DN
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 05:43:43 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:32902)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cHpzG-0006RO-6J
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 05:43:38 -0500
Received: by mail-wm0-x242.google.com with SMTP id u144so4553246wmu.0
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 02:43:38 -0800 (PST)
Date: Fri, 16 Dec 2016 10:43:34 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20161216104334.GC4129@stefanha-x1.localdomain>
References: <871sx9pj0o.fsf@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xesSdrSSBC0PokLI"
Content-Disposition: inline
In-Reply-To: <871sx9pj0o.fsf@163.com>
Subject: Re: [Qemu-devel] Measure virtio-vsock speed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Shuaiyi <zhang_syi@163.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com


--xesSdrSSBC0PokLI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 15, 2016 at 05:00:35PM +0800, Zhang Shuaiyi wrote:
> I used kernel 4.8 and qemu v2.8.0-rc3.
> Qemu command line:
>   -device vhost-vsock-pci,id=3Dvhost-vsock-pci0,guest-cid=3D3
>=20
> I try to use nc-vsock to test vsock speed.
> 1. In host:
>   # modprobe vhost-vsock
>   # ./nc-vsock -l 1234 > /dev/null
> 2. In guest:
>   a. use pv and nc-vsock, speed is about 62MB/s.
>      # pv /dev/zero | ./nc-vsock 3 1234
>   b. use dd and nc-vsock, speed is about 67MB/s.
>      # dd if=3D/dev/zero bs=3D1M count=3D2000 | ./nc-vsock 3 1234
>     =20
> I think nc-vsock can not get the maximum speed, so I modified
> nc-vsock.c.

Good idea, nc-vsock is not a performance benchmark.

> 1. In host, just recv data without printf.
> 2. In guest, use gettimeofday to record interval and send zero bufs.
>   #define MAXLEN 65536
>   char buf[MAXLEN] =3D {0};
>   unsigned long long num =3D 0;
>=20
>   gettimeofday(&start_time, NULL);
>   for (n =3D 0; n  1000000; n++) {
>       ret =3D send(fd, buf, MAXLEN, 0);
>       if (ret  0) {
>          fprintf(stderr, "send error ret:%d\n", ret);
>          break;
>       }
>       num +=3D ret;
>   }
>   gettimeofday(&end_time, NULL);

This is benchmarking how quickly send(2) returns but it doesn't
guarantee that the guest has received everything.  Is it necessary to
add a final recv(fd, &status, sizeof(status), 0) to check that the other
side has seen all the data?

> In this way, the virtio-vsock speed is about 500MB/s. But use iperf to
> test virtio-net, the speed is about 1.5GB/s.

Your vsock benchmark may not be doing the same thing as iperf.  I
suggest adding AF_VSOCK support to iperf for a fair comparison.

> Iperf can be used to test virtio-net, is there a tool to test maximum vir=
tio-vsock speed?
> At present, virtio-vsock is faster than virtio-net?

I expect virtio-net to be faster than virtio-vsock and to remain faster
in the future.  The goal of vsock is to provide reliable,
zero-configuration communication between guest and host.  The goal is
not to be a faster transport than virtio-net.

If you are considering running something over AF_VSOCK for performance
reasons then that's not what it was designed for.  If performance is the
*most* important thing look at vhost-user (i.e. shared memory) but it
has a lot of trade-offs because you need to implement virtio-net and a
network stack.

--xesSdrSSBC0PokLI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYU8VWAAoJEJykq7OBq3PIudgH/RcWxwUtVYy2BP62KH8mUzCx
n1NtnjnCl+iszRfNp/S0hXn5OuMTn1McxrnBEP1MxUnjnDvEch0WsU6KnSiJdjDM
dtlZuxFwfvGKo7iVbSAeJdz58DUibDwmuX98wU9yioJN0l5F/RzMAee4YFNqRluI
IXKPl30f7u9sNf6OPCBurz1ytz2RXPnLDD+Zr3ll4loGWXnxZVsSEIlfyJofJUsd
Mny+8HfyzD7ne3PA7Frn+eaMyTXdCmfwlCxBXVEGNwvvn+wgIGDnYH5oMkSQpprz
QyiBoXdnudBlNpdxTOk0xwLAIXUmErOkSCSxgq4VJ/mkF8gdE5ZjeaaLlcZV9cI=
=mLFq
-----END PGP SIGNATURE-----

--xesSdrSSBC0PokLI--
