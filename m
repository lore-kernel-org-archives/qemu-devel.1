Received: from eggs.gnu.org ([209.51.188.92]:39949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hBf8U-00073e-I3
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 08:36:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hBf8T-0008H7-BL
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 08:36:58 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35356)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hBf8S-0008DX-W0
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 08:36:57 -0400
Received: by mail-wr1-x441.google.com with SMTP id w1so21151765wrp.2
	for <qemu-devel@nongnu.org>; Wed, 03 Apr 2019 05:36:56 -0700 (PDT)
Date: Wed, 3 Apr 2019 13:36:54 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190403123654.GF32425@stefanha-x1.localdomain>
References: <20190401163240.xw24ezsloy5ds2hz@steredhat>
	<87zhp9599u.fsf@zen.linaroharston>
	<20190402073706.7t5w5gyj5tf7quwk@steredhat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i3lJ51RuaGWuFYNw"
Content-Disposition: inline
In-Reply-To: <20190402073706.7t5w5gyj5tf7quwk@steredhat>
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
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, netdev@vger.kernel.org, qemu devel list <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>


--i3lJ51RuaGWuFYNw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2019 at 09:37:06AM +0200, Stefano Garzarella wrote:
> On Tue, Apr 02, 2019 at 04:19:25AM +0000, Alex Benn=E9e wrote:
> >=20
> > Stefano Garzarella <sgarzare@redhat.com> writes:
> >=20
> > > Hi Alex,
> > > I'm sending you some benchmarks and information about VSOCK CCing qem=
u-devel
> > > and linux-netdev (maybe this info could be useful for others :))
> > >
> > > One of the VSOCK advantages is the simple configuration: you don't ne=
ed to set
> > > up IP addresses for guest/host, and it can be used with the standard =
POSIX
> > > socket API. [1]
> > >
> > > I'm currently working on it, so the "optimized" values are still work=
 in
> > > progress and I'll send the patches upstream (Linux) as soon as possib=
le.
> > > (I hope in 1 or 2 weeks)
> > >
> > > Optimizations:
> > > + reducing the number of credit update packets
> > >   - RX side sent, on every packet received, an empty packet only to i=
nform the
> > >     TX side about the space in the RX buffer.
> > > + increase RX buffers size to 64 KB (from 4 KB)
> > > + merge packets to fill RX buffers
> > >
> > > As benchmark tool I used iperf3 [2] modified with VSOCK support:
> > >
> > >              host -> guest [Gbps]      guest -> host [Gbps]
> > > pkt_size    before opt.  optimized    before opt.  optimized
> > >   1K            0.5         1.6           1.4         1.4
> > >   2K            1.1         3.1           2.3         2.5
> > >   4K            2.0         5.6           4.2         4.4
> > >   8K            3.2        10.2           7.2         7.5
> > >   16K           6.4        14.2           9.4        11.3
> > >   32K           9.8        18.9           9.2        17.8
> > >   64K          13.8        22.9           8.8        25.0
> > >   128K         17.6        24.5           7.7        25.7
> > >   256K         19.0        24.8           8.1        25.6
> > >   512K         20.8        25.1           8.1        25.4
> > >
> > >
> > > How to reproduce:
> > >
> > > host$ modprobe vhost_vsock
> > > host$ qemu-system-x86_64 ... -device vhost-vsock-pci,guest-cid=3D3
> > >       # Note: Guest CID should be >=3D 3
> > >       # (0, 1 are reserved and 2 identify the host)
> > >
> > > guest$ iperf3 --vsock -s
> > >
> > > host$ iperf3 --vsock -c 3 -l ${pkt_size}      # host -> guest
> > > host$ iperf3 --vsock -c 3 -l ${pkt_size} -R   # guest -> host
> > >
> > >
> > > If you want, I can do a similar benchmark (with iperf3) using a netwo=
rking
> > > card (do you have a specific configuration?).
> >=20
> > My main interest is how it stacks up against:
> >=20
> >   --device virtio-net-pci and I guess the vhost equivalent
>=20
> I'll do some tests with virtio-net and vhost.
>=20
> >=20
> > AIUI one of the motivators was being able to run something like NFS for
> > a guest FS over vsock instead of the overhead from UDP and having to
> > deal with the additional complication of having a working network setup.
> >=20
>=20
> CCing Stefan.
>=20
> I know he is working on virtio-fs that maybe suite better with your use c=
ases.
> He also worked on VSOCK support for NFS, but I think it is not merged ups=
tream.

Hi Alex,
David Gilbert, Vivek Goyal, Miklos Szeredi, and I are working on
virtio-fs for host<->guest file sharing.  It performs better than
virtio-9p and we're currently working on getting it upstream (first the
VIRTIO device spec, then Linux and QEMU patches).

You can read about it and try it here:

https://virtio-fs.gitlab.io/

Stefan

--i3lJ51RuaGWuFYNw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcpKjlAAoJEJykq7OBq3PIBLgH+we8Y7SMD5r9vD79slqKba9E
bnyNw0vQAi/n619FOeIhl5cEUcxXk7ytqKxnZ2Q1mf8dKScnO0mCSTBPfffmCLw7
Tl5MDbzhwoz3pDWeQiEFFNxCiyiouxi4vEfA51tFwUzzMb5hM4/pl+D0ofTbiNqn
PMsecLz13/MTvjWJ6hrLbcswkPaBLohM3qgHNwVBJAbBGDBYRK1VyZiQ4PtXnWpQ
su39PDLK6gmTsI5iiIQcvewSpOEiMl7VW2E0iWtdAOwiq8WU9bdCQtgOTV/6Sxmi
5QGbvrmUNte/yGjtm3XWnnVzEbgLTedUwLBpepCJVRZh/yMva7qOMnQX5QZVzdY=
=6r78
-----END PGP SIGNATURE-----

--i3lJ51RuaGWuFYNw--
