Received: from eggs.gnu.org ([2001:4830:134:3::10]:39910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fnk4D-0006kF-Po
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 08:29:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fnk49-0006R1-S8
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 08:29:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47210 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1fnk49-0006Qx-Mb
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 08:29:21 -0400
References: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
	<20180806143412.27722-4-e.emanuelegiuseppe@gmail.com>
	<938f8b05-a687-8595-5452-8ec5abf7414c@redhat.com>
	<1c703cc4-644b-1ba8-4ec2-8b58ada7028a@gmail.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <050466ae-69e8-20cd-7484-7da7160deaa9@redhat.com>
Date: Thu, 9 Aug 2018 14:29:18 +0200
MIME-Version: 1.0
In-Reply-To: <1c703cc4-644b-1ba8-4ec2-8b58ada7028a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 03/34] tests/qgraph: pci-pc driver and
 interface nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Emanuele <e.emanuelegiuseppe@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>

On 09/08/2018 14:17, Emanuele wrote:
>=20
>>> +=C2=A0=C2=A0=C2=A0 return TRUE;
>>> +}
>>> +
>>> +QPCIDevice *qpci_device_find(QPCIBus *bus, int devfn)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 QPCIDevice *dev;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 dev =3D g_malloc0(sizeof(*dev));
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!qpci_device_set(dev, bus, devfn)) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_free(dev);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> @@ -66,6 +83,21 @@ QPCIDevice *qpci_device_find(QPCIBus *bus, int dev=
fn)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return dev;
>>> =C2=A0 }
>>> =C2=A0 +void qpci_device_init(QPCIDevice *dev, QPCIBus *bus, QPCIAddr=
ess
>>> *addr)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 uint16_t vendor_id, device_id;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!qpci_device_set(dev, bus, addr->devfn)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("PCI Device not fo=
und\n");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abort();
>>> +=C2=A0=C2=A0=C2=A0 }
>> so, here, you should use qpci_device_set() and qpci_device_available()=
...
> I changed qpci_device_set to just set the fields, while
> qpci_device_available simply is doing
> {
> =C2=A0=C2=A0=C2=A0 return qpci_config_readw(...) !=3D 0xFFFF
> }
> Now both qpci_device_init and qpci_device_find call qpci_device_set, an=
d
> check that=C2=A0 qpci_device_available is not false, otherwise it will
> trigger g_assert_not_reached().
>>
>>> +
>>> +=C2=A0=C2=A0=C2=A0 vendor_id =3D qpci_config_readw(dev, PCI_VENDOR_I=
D);
>> or you can only check vendor_id to see it is 0xffff or not...
>>
>>> +=C2=A0=C2=A0=C2=A0 device_id =3D qpci_config_readw(dev, PCI_DEVICE_I=
D);
>>> +=C2=A0=C2=A0=C2=A0 g_assert(vendor_id =3D=3D addr->vendor_id);
>> that should be in fact detected by this g_assert().
> since this case is covered by qpci_device_available, I don't think
> there's the need to insert the assertion.

What I mean is you don't need the qpci_device_available().

The 0xffff case is detected by "g_assert(vendor_id =3D=3D addr->vendor_id=
)".

The functions could be:

static void qpci_device_set(QPCIDevice *dev, QPCIBus *bus, int devfn)
{
     dev->bus =3D bus;
     dev->devfn =3D devfn;
}

void qpci_device_init(QPCIDevice *dev, QPCIBus *bus, QPCIAddress *addr)
{
    uint16_t vendor_id, device_id;

    qpci_device_set(dev, bus, addr->devfn);

    vendor_id =3D qpci_config_readw(dev, PCI_VENDOR_ID);
    device_id =3D qpci_config_readw(dev, PCI_DEVICE_ID);
    g_assert(vendor_id =3D=3D addr->vendor_id);
    g_assert(device_id =3D=3D addr->device_id);
}

Thanks,
Laurent
