Received: from eggs.gnu.org ([2001:4830:134:3::10]:49227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d0sRl-0001AM-Hz
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 12:27:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d0sRh-00086H-Jt
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 12:27:13 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:35006)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d0sRh-00085Z-Cz
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 12:27:09 -0400
Received: by mail-wm0-x242.google.com with SMTP id d79so5876914wmi.2
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 09:27:09 -0700 (PDT)
Date: Wed, 19 Apr 2017 17:27:05 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170419162705.GG3343@stefanha-x1.localdomain>
References: <1491277689-24949-1-git-send-email-Ashish.Mittal@veritas.com>
	<1491277689-24949-2-git-send-email-Ashish.Mittal@veritas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JkW1gnuWHDypiMFO"
Content-Disposition: inline
In-Reply-To: <1491277689-24949-2-git-send-email-Ashish.Mittal@veritas.com>
Subject: Re: [Qemu-devel] [PATCH v11 1/2] block/vxhs.c: Add support for a
 new block device type called "vxhs"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashish Mittal <ashmit602@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, kwolf@redhat.com, armbru@redhat.com, berrange@redhat.com, jcody@redhat.com, famz@redhat.com, ashish.mittal@veritas.com, Ketan.Nilangekar@veritas.com, jferlan@redhat.com, Buddhi.Madhav@veritas.com, Suraj.Singh@veritas.com, Nitin.Jerath@veritas.com, peter.maydell@linaro.org, venkatesha.mg@veritas.com, Rakesh.Ranjan@veritas.com, eblake@redhat.com, Abhijit.Dey@veritas.com


--JkW1gnuWHDypiMFO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 03, 2017 at 08:48:08PM -0700, Ashish Mittal wrote:
> Source code for the qnio library that this code loads can be downloaded f=
rom:
> https://github.com/VeritasHyperScale/libqnio.git
>=20
> Sample command line using JSON syntax:
> ./x86_64-softmmu/qemu-system-x86_64 -name instance-00000008 -S -vnc 0.0.0=
=2E0:0
> -k en-us -vga cirrus -device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0=
,addr=3D0x5
> -msg timestamp=3Don
> 'json:{"driver":"vxhs","vdisk-id":"c3e9095a-a5ee-4dce-afeb-2a59fb387410",
> "server":{"host":"172.172.17.4","port":"9999"}}'
>=20
> Sample command line using URI syntax:
> qemu-img convert -f raw -O raw -n
> /var/lib/nova/instances/_base/0c5eacd5ebea5ed914b6a3e7b18f1ce734c386ad
> vxhs://192.168.0.1:9999/c6718f6b-0401-441d-a8c3-1f0064d75ee0
>=20
> Sample command line using TLS credentials (run in secure mode):
> ./qemu-io --object
> tls-creds-x509,id=3Dtls0,dir=3D/etc/pki/qemu/vxhs,endpoint=3Dclient -c 'r=
ead
> -v 66000 2.5k' 'json:{"server.host": "127.0.0.1", "server.port": "9999",
> "vdisk-id": "/test.raw", "driver": "vxhs", "tls-creds":"tls0"}'
>=20
> Signed-off-by: Ashish Mittal <Ashish.Mittal@veritas.com>
> ---
> v11 changelog:
> (1) Replaced InetSocketAddress with InetSocketAddressBase.
> (2) Removed access to qemu_uuid.
> (3) Removed unnecessary g_strdup()/g_free().
> (4) Removed unused acb->qiov.
> (5) Changed vxhs_init_and_ref() and vxhs_unref() per suggestion.
> (6) Removed unnecessary initializations from local variables.

QEMU code:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

libvxhs is not robust yet.  Here are two examples:

1. If the response from the server has an invalid magic number then the
   whole VM is aborted:

   QNIO_API_(void) kvset_unmarshal(qnio_byte_t * bs, kvset_t * *p)
   {
       ...
       assert(magic =3D=3D kvset_magic);

2. There are buffer overflows and other memory corruptions.  For example
   when kv_binary_unpack() gets size=3D-1 over the wire.

The code needs to be audited line-by-line by someone aware of secure
coding practices.  Please look into this.

Also, is there a plan for getting libvxhs into Fedora and Debian?

--JkW1gnuWHDypiMFO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY94/ZAAoJEJykq7OBq3PIMycIALgzJkOcSVfloQ5W+XgPfwgZ
9fkXRy7w6tzWbKG+Jz7H5bgzWImXY17IDrRG+MEHiGb1+p1/N+RxcD2DtBpsozee
3SLB7oPhcOMd046YakrjoeJi9Bcj/iD+nvWomhAX6mtzhCIytiRgZdo2bYPgROfE
PA8zdkAAzFrvw+uFNXRJOisYYRi2hU3Vf96V5PrLiwss1KewEoK6zNzbxYwfWDn0
tPQfFwl5g4n9d1pHAQYoXWrLDFNqrGRSDAicEbSFP54KXz5sj6wwY1uCiHSTP/bm
4LYApQoANDYwl8x9sIBv+mChu16k1p9fnFKVCpuabS/W/CDlYf7RyuiZytI5P9w=
=vnf7
-----END PGP SIGNATURE-----

--JkW1gnuWHDypiMFO--
