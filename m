Received: from eggs.gnu.org ([2001:4830:134:3::10]:42115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f0nJF-0001aK-MS
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 08:02:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f0nJC-0007ot-KG
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 08:02:37 -0400
Date: Tue, 27 Mar 2018 14:02:15 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180327140215.18c51d41.cohuck@redhat.com>
In-Reply-To: <d0443435-a2d2-e256-3663-4e591f0e48bf@linux.vnet.ibm.com>
References: <1521156300-19296-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1521156300-19296-6-git-send-email-akrowiak@linux.vnet.ibm.com>
	<4deae7b2-ae8a-f5a9-7979-0dcd20894729@linux.vnet.ibm.com>
	<d0443435-a2d2-e256-3663-4e591f0e48bf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 5/7] s390x/vfio: ap: Introduce VFIO AP
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, qemu-devel@nongnu.org, mjrosato@linux.vnet.ibm.com, peter.maydell@linaro.org, alifm@linux.vnet.ibm.com, eskultet@redhat.com, david@redhat.com, heiko.carstens@de.ibm.com, alex.williamson@redhat.com, agraf@suse.de, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, schwidefsky@de.ibm.com, pbonzini@redhat.com, bjsdjshi@linux.vnet.ibm.com, eric.auger@redhat.com, rth@twiddle.net

On Fri, 16 Mar 2018 14:22:52 +0100
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 03/16/2018 11:42 AM, Pierre Morel wrote:
> > On 16/03/2018 00:24, Tony Krowiak wrote: =20
> >> Introduces a VFIO based AP device. The device is defined via
> >> the QEMU command line by specifying:
> >>
> >> =C2=A0=C2=A0=C2=A0=C2=A0 -device vfio-ap,sysfsdev=3D<path-to-mediated-=
matrix-device>
> >>
> >> The mediated matrix device is created by the VFIO AP device
> >> driver by writing a UUID to a sysfs attribute file (see
> >> docs/vfio-ap.txt). The mediated matrix device will be named
> >> after the UUID. Symbolic links to the $uuid are created in
> >> many places, so the path to the mediated matrix device $uuid
> >> can be specified in any of the following ways:
> >>
> >> /sys/devices/vfio_ap/matrix/$uuid
> >> /sys/devices/vfio_ap/matrix/mdev_supported_types/vfio_ap-passthrough/d=
evices/$uuid
> >> /sys/bus/mdev/devices/$uuid
> >> /sys/bus/mdev/drivers/vfio_mdev/$uuid
> >>
> >> When the vfio-ap device is realized, it acquires and opens the
> >> VFIO iommu group to which the mediated matrix device is
> >> bound. This causes a VFIO group notification event to be
> >> signaled. The vfio_ap device driver's group notification
> >> handler will get called at which time the device driver
> >> will configure the the AP devices to which the guest will
> >> be granted access.
> >>
> >> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> >> --- =20
> [..]
> >> +static void vfio_ap_realize(DeviceState *dev, Error **errp)
> >> +{
> >> +=C2=A0=C2=A0=C2=A0 VFIODevice *vbasedev;
> >> +=C2=A0=C2=A0=C2=A0 VFIOGroup *vfio_group;
> >> +=C2=A0=C2=A0=C2=A0 APDevice *apdev =3D DO_UPCAST(APDevice, parent_obj=
, dev);
> >> +=C2=A0=C2=A0=C2=A0 VFIOAPDevice *vapdev =3D DO_UPCAST(VFIOAPDevice, a=
pdev, apdev);
> >> +=C2=A0=C2=A0=C2=A0 char *mdevid;
> >> +=C2=A0=C2=A0=C2=A0 Error *local_err =3D NULL;
> >> +=C2=A0=C2=A0=C2=A0 int ret;
> >> +
> >> +=C2=A0=C2=A0=C2=A0 if (!s390_has_feat(S390_FEAT_AP)) {
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(&local_err, "AP=
 support not enabled");
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_err;
> >> +=C2=A0=C2=A0=C2=A0 }
> >> +
> >> +=C2=A0=C2=A0=C2=A0 ret =3D kvm_s390_set_interpret_ap(1); =20
> >=20
> > If we have several devices, this is called once per device. =20
>=20
> I don't think having several of these in a single vm makes
> any sense. Or does it? IMHO we should make sure there is at
> most one device taking care of the crypto pass-through.

Yes, I think we should fence off adding a second device in the realize
function (probably by checking a global variable?)
