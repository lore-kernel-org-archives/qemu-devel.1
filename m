Received: from eggs.gnu.org ([208.118.235.92]:59875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gf4ew-0004x7-6j
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 10:11:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gf4eu-0004pz-1R
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 10:11:46 -0500
MIME-Version: 1.0
From: Li Qiang <liq3ea@163.com>
Date: Thu, 3 Jan 2019 23:08:08 +0800
In-Reply-To: <20190103155438.68d6afe3.cohuck@redhat.com>
References: <20190103140246.50791-1-liq3ea@163.com>
	<20190103155438.68d6afe3.cohuck@redhat.com>
Message-Id: <5C2E255B.DA5742.23880@m12-17.163.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] =?utf-8?b?562U5aSNOiBbUEFUQ0hdIHMzOTA6IGF2b2lkIHBv?=
 =?utf-8?q?tential_null_dereference_ins390=5Fpcihost=5Funplug=28=29?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: "walling@linux.ibm.com" <walling@linux.ibm.com>, "rth@twiddle.net" <rth@twiddle.net>, "david@redhat.com" <david@redhat.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Pierre Morel <pmorel@linux.ibm.com>

I=E2=80=99m inspired by the function =E2=80=98ich9_pm_device_unplug_cb=E2=
=80=99.
>From the =E2=80=98plug=E2=80=99 ich9_pm_device_plug_cb it set an error.
So I think we can also set this is this s390 device plug.

I will send out revised patch soon.

Thanks,
Li Qiang

=E5=8F=91=E4=BB=B6=E4=BA=BA: Cornelia Huck
=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2019=E5=B9=B41=E6=9C=883=E6=97=A5 22:=
54
=E6=94=B6=E4=BB=B6=E4=BA=BA: Li Qiang
=E6=8A=84=E9=80=81: walling@linux.ibm.com; rth@twiddle.net; david@redhat.co=
m; pasic@linux.ibm.com; borntraeger@de.ibm.com; qemu-s390x@nongnu.org; qemu=
-devel@nongnu.org; peter.maydell@linaro.org; Pierre Morel
=E4=B8=BB=E9=A2=98: Re: [PATCH] s390: avoid potential null dereference ins3=
90_pcihost_unplug()

On Thu,  3 Jan 2019 06:02:46 -0800
Li Qiang <liq3ea@163.com> wrote:

> When getting the 'pbdev', the if...else has no default branch.
> From Coverity, the 'pbdev' maybe null when the 'dev' is not
> the TYPE_PCI_BRIDGE/TYPE_PCI_DEVICE/TYPE_S390_PCI_DEVICE.
>=20
> Spotted by Coverity: CID 1398593
>=20
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  hw/s390x/s390-pci-bus.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 15759b6514..b3122268a3 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -956,6 +956,10 @@ static void s390_pcihost_unplug(HotplugHandler *hotp=
lug_dev, DeviceState *dev,
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_S390_PCI_DEVICE)) {
>          pbdev =3D S390_PCI_DEVICE(dev);
>          pci_dev =3D pbdev->pdev;
> +    } else {
> +        error_setg(errp, "s390: device unplug for not supported device"
> +                   " type: %s", object_get_typename(OBJECT(dev)));
> +        return;

I think that is something that really Should Not Happen. However,
looking at s390_pcihost_plug, we just do nothing if the plugged device
does not match any of the expected three values. Maybe we should also
set an error in that case there?

>      }
> =20
>      switch (pbdev->state) {
