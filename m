Received: from eggs.gnu.org ([2001:4830:134:3::10]:49371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1elmhf-0003cE-Ew
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 21:21:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1elmhc-0002i4-5v
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 21:21:47 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2321 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
	id 1elmhb-0002gy-Ql
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 21:21:44 -0500
From: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
Date: Wed, 14 Feb 2018 02:21:33 +0000
Message-ID: <B2D15215269B544CADD246097EACE7473AB94B41@DGGEMM505-MBS.china.huawei.com>
References: <1518116908-10852-1-git-send-email-mst@redhat.com>
	<CAFEAcA8kvkfoxnQbqZ4Y44uWtbsirCKdmTcnZJzu=ege9YRfTg@mail.gmail.com>
	<20180209190703-mutt-send-email-mst@kernel.org>
	<CAFEAcA_CL6P31EJyzxom1oh6j8LNDD2+OXjJ65hKsB=zBw6tWQ@mail.gmail.com>
	<CAFEAcA_z25p0NrRuH3vJm9mJJzHZXbgct2GwyojuHXKqejc8JA@mail.gmail.com>
	<20180213184729-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180213184729-mutt-send-email-mst@kernel.org>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PULL 00/26] virtio, vhost, pci, pc: features,
 fixes and cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

> -----Original Message-----
> From: Qemu-devel [mailto:qemu-devel-
> bounces+jianjay.zhou=3Dhuawei.com@nongnu.org] On Behalf Of Michael S. Tsi=
rkin
> Sent: Wednesday, February 14, 2018 12:52 AM
> To: Peter Maydell <peter.maydell@linaro.org>
> Cc: QEMU Developers <qemu-devel@nongnu.org>
> Subject: Re: [Qemu-devel] [PULL 00/26] virtio, vhost, pci, pc: features,
> fixes and cleanups
>=20
> On Tue, Feb 13, 2018 at 04:33:14PM +0000, Peter Maydell wrote:
> > On 12 February 2018 at 09:35, Peter Maydell <peter.maydell@linaro.org>
> wrote:
> > > This asserts in 'make check' for NetBSD, FreeBSD, OpenBSD, OSX:
> > >
> > > TEST: tests/device-introspect-test... (pid=3D19530)
> > >   /aarch64/device/introspect/list:                                   =
  OK
> > >   /aarch64/device/introspect/list-fields:                            =
  OK
> > >   /aarch64/device/introspect/none:                                   =
  OK
> > >   /aarch64/device/introspect/abstract:                               =
  OK
> > >   /aarch64/device/introspect/concrete:                               =
  **
> > > ERROR:/root/qemu/qom/object.c:372:object_initialize_with_type:
> > > assertion failed: (type !=3D NULL)
> > > Broken pipe
> > > FAIL
> > > GTester: last random seed: R02Sd4e2c04f6ac00d843a31ccac4de0d914
> > > (pid=3D12686)
> > >   /aarch64/device/introspect/abstract-interfaces:                    =
  OK
> > > FAIL: tests/device-introspect-test
> > >
> > > (other archs fail too, aarch64 is just the first one we hit). This
> > > error is often "device A instantiates device B, but device B is
> > > conditionally compiled in and A is always compiled; so test fails
> > > trying to create device A on hosts where device B isn't built" I thin=
k.
> >
> > This part is indeed that problem -- the 'virtio-crypto-device' object
> > is built only if CONFIG_LINUX, but 'virtio-crypto-pci' is built if
> > CONFIG_VIRTIO_PCI, so on systems where the latter is true but not the
> > former you get a virtio-crypto-pci device that crashes when instantiate=
d.
> >
> > The fix should be
> > --- a/hw/virtio/Makefile.objs
> > +++ b/hw/virtio/Makefile.objs
> > @@ -8,7 +8,7 @@ obj-y +=3D virtio.o virtio-balloon.o
> >  obj-$(CONFIG_LINUX) +=3D vhost.o vhost-backend.o vhost-user.o
> >  obj-$(CONFIG_VHOST_VSOCK) +=3D vhost-vsock.o
> >  obj-$(CONFIG_LINUX) +=3D virtio-crypto.o
> > -obj-$(CONFIG_VIRTIO_PCI) +=3D virtio-crypto-pci.o
> > +obj-$(call land,$(CONFIG_LINUX),$(CONFIG_VIRTIO_PCI)) +=3D
> > +virtio-crypto-pci.o
> >  endif
> >
> >  common-obj-$(call lnot,$(CONFIG_LINUX)) +=3D vhost-stub.o
> >
> >
> > thanks
> > -- PMM
>=20
> Thanks for your help with this!
>=20
> I think the root cause is that one of the patches disables virtio-crypto
> build on non linux which used to be enabled.
>=20
> This has been silently done by a patch which was supposed to merely add a
> vhost crypto device, I'm sorry I missed that in the review.

Hi Michael, Peter

Sorry for the late response and the trouble I have made, I just returned
from a vacation.
Thanks for your help and pointing out the root cause, I should explicitly
put the config change of virtio-crypto into a separate patch to make
review much easier.

>=20
> I've dropped the crypto vhost patches from the pull request for now.

Will fix the issue in the next version, sorry again for the inconvenience.

Regards,
Jay

>=20
> Pushed with the same name - should be fine now.
>=20
> --
> MST
