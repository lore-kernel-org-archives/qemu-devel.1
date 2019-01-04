Received: from eggs.gnu.org ([208.118.235.92]:42411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gfQYr-0004jQ-PP
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 09:34:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gfQYp-0006Eo-Tf
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 09:34:57 -0500
MIME-Version: 1.0
From: Li Qiang <liq3ea@163.com>
Date: Fri, 4 Jan 2019 22:33:51 +0800
In-Reply-To: <20190104151005.42b6f111.cohuck@redhat.com>
References: <20190103151612.51399-1-liq3ea@163.com>
	<20190104151005.42b6f111.cohuck@redhat.com>
Message-Id: <5C2F6ED2.33D0D1.16460@m12-13.163.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] =?utf-8?b?562U5aSNOiBbUEFUQ0ggdjJdIHMzOTA6IGF2b2lk?=
 =?utf-8?q?_potential_null_dereference_ins390=5Fpcihost=5Funplug=28=29?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: "walling@linux.ibm.com" <walling@linux.ibm.com>, "rth@twiddle.net" <rth@twiddle.net>, "david@redhat.com" <david@redhat.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>

What do you think of =E2=80=98g_assert_not_reached();=E2=80=99. For example=
:

else {
     g_assert_not_reached();
}

Thanks,
Li Qiang


=E5=8F=91=E4=BB=B6=E4=BA=BA: Cornelia Huck
=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2019=E5=B9=B41=E6=9C=884=E6=97=A5 22:=
10
=E6=94=B6=E4=BB=B6=E4=BA=BA: Li Qiang
=E6=8A=84=E9=80=81: walling@linux.ibm.com; rth@twiddle.net; david@redhat.co=
m; pasic@linux.ibm.com; borntraeger@de.ibm.com; qemu-s390x@nongnu.org; qemu=
-devel@nongnu.org; peter.maydell@linaro.org
=E4=B8=BB=E9=A2=98: Re: [PATCH v2] s390: avoid potential null dereference i=
ns390_pcihost_unplug()

On Thu,  3 Jan 2019 07:16:12 -0800
Li Qiang <liq3ea@163.com> wrote:

> When getting the 'pbdev', the if...else has no default branch.
> From Coverity, the 'pbdev' maybe null when the 'dev' is not
> the TYPE_PCI_BRIDGE/TYPE_PCI_DEVICE/TYPE_S390_PCI_DEVICE.
> This patch adds a default branch for device plug and unplug.
>=20
> Spotted by Coverity: CID 1398593
>=20
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
> Adds a default branch for device plug per Cornelia's review.
>=20
>  hw/s390x/s390-pci-bus.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 15759b6514..fe48a36ff6 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -912,6 +912,9 @@ static void s390_pcihost_plug(HotplugHandler *hotplug=
_dev, DeviceState *dev,
>          pbdev->fh =3D pbdev->idx;
>          QTAILQ_INSERT_TAIL(&s->zpci_devs, pbdev, link);
>          g_hash_table_insert(s->zpci_table, &pbdev->idx, pbdev);
> +    } else {
> +        error_setg(errp, "s390: device plug request for not supported de=
vice"
> +                   " type: %s", object_get_typename(OBJECT(dev)));

Maybe make this "s390/pci: plugging device type <%s> is not supported"?

>      }
>  }
> =20
> @@ -956,6 +959,10 @@ static void s390_pcihost_unplug(HotplugHandler *hotp=
lug_dev, DeviceState *dev,
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_S390_PCI_DEVICE)) {
>          pbdev =3D S390_PCI_DEVICE(dev);
>          pci_dev =3D pbdev->pdev;
> +    } else {
> +        error_setg(errp, "s390: device unplug request for not supported =
device"
> +                   " type: %s", object_get_typename(OBJECT(dev)));

Halil has a point when he suggests an assert here. If we fence the
device type in the plug function, I can't think of a way we would end
up here.

> +        return;
>      }
> =20
>      switch (pbdev->state) {
