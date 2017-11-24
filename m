Received: from eggs.gnu.org ([2001:4830:134:3::10]:45989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eICU3-0005iX-5s
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 06:49:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eICU0-0003S8-00
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 06:49:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41224)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eICTz-0003Rj-PC
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 06:49:23 -0500
Date: Fri, 24 Nov 2017 11:49:20 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171124114920.GB12490@stefanha-x1.localdomain>
References: <20171124075542.16979-1-ppandit@redhat.com>
	<20171124075542.16979-3-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qlTNgmc+xy1dBmNv"
Content-Disposition: inline
In-Reply-To: <20171124075542.16979-3-ppandit@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 2/2] tests: add test to check VirtQueue
 object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, zhangboxian <zhangboxian@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>


--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2017 at 01:25:42PM +0530, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>=20
> An uninitialised VirtQueue object or one with Vring.align field
> set to zero(0) could lead to arithmetic exceptions. Add a unit
> test to validate it.
>=20
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  tests/virtio-blk-test.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>=20
> diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
> index e6fb9bac87..d00ceb0501 100644
> --- a/tests/virtio-blk-test.c
> +++ b/tests/virtio-blk-test.c
> @@ -674,6 +674,26 @@ static void pci_hotplug(void)
>      qtest_shutdown(qs);
>  }
> =20
> +static void test_vring_align(void)

It's important to include a doc comment so the purpose of the test is
clear:

/*
 * Check that setting the vring addr on a non-existent virtqueue does
 * not crash.
 */

I think the _align name is confusing since the vring alignment is not
directly affected by this test case.  Please call it
test_nonexistent_virtqueue() instead.

> +{
> +    QPCIBar bar0;
> +    QOSState *qs;
> +    QPCIDevice *dev;
> +
> +    qs =3D pci_test_start();
> +    dev =3D qpci_device_find(qs->pcibus, QPCI_DEVFN(4, 0));
> +    g_assert(dev !=3D NULL);
> +
> +    qpci_device_enable(dev);
> +    bar0 =3D qpci_iomap(dev, 0, NULL);
> +
> +    qpci_io_writeb(dev, bar0, VIRTIO_PCI_QUEUE_SEL, 2);
> +    qpci_io_writel(dev, bar0, VIRTIO_PCI_QUEUE_PFN, 1);
> +
> +    g_free(dev);
> +    qtest_shutdown(qs);
> +}


--qlTNgmc+xy1dBmNv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaGAdAAAoJEJykq7OBq3PIefkIALR6MGQVAdJvInbJDwq2joNC
aFFOfViC7P68KbY1sPEb91shGX0uAK40nx283InPcx8PUwLCVOvU4DBkPkzJ1Kss
MVHMWW8+5DNBxJA+vyY9FCe6LCZHPbcUMR/DURZsVEnOm6Yfdr0I9WxjbWjlJ+fD
dq3s5JDiPjDjHjMrMhGJbgnhxjN5gY6a60BHl/6NBQWk5em5nLYyJ+vsEGn6yULU
RJgRCqbg948zWFRCBAJD6L29+hJMZUWeaqXkEFVboGzwdRPDKbeA/S52kWexN/9a
nky2adm37vyYNQpES6nh9iERzXNY9hYHV4thQq1nORs4T93yHAlliDPjpkWc9zc=
=ctNn
-----END PGP SIGNATURE-----

--qlTNgmc+xy1dBmNv--
