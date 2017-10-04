Received: from eggs.gnu.org ([2001:4830:134:3::10]:39178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dzgTS-0005z4-TN
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:00:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dzgTM-000068-SO
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:00:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dzgTM-000054-MV
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:00:12 -0400
References: <20170929110052.6111-1-kraxel@redhat.com>
	<CAFEAcA-8gaOhkuNX9hBt0Ofg-CKkJ-v8puHJ4K3QOq0ZGMgB5w@mail.gmail.com>
	<1507106598.27227.2.camel@redhat.com>
	<9d566b88-7991-b9f4-8b73-737a99d3ac6d@redhat.com>
	<1507110639.27227.4.camel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e45ecd4e-2f7a-a33f-4d65-c206cc3b56f9@redhat.com>
Date: Wed, 4 Oct 2017 11:59:58 +0200
MIME-Version: 1.0
In-Reply-To: <1507110639.27227.4.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/3] Usb 20170929 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 04/10/2017 11:50, Gerd Hoffmann wrote:
>   Hi,
>>
>> Ah, deja vu. I think you've now run into the problem that I had with
>> my
>> patch, too - see:
>>
>> =C2=A0https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg01875.h=
tml
>> =C2=A0https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg02082.h=
tml
>>
>> I think this is a race condition when building with "make -j" in
>> parallel. Just add a line like this and you should be fine:
>>
>> common-obj-$(CONFIG_ALL) +=3D host-stub.o
>=20
> I'd guess when compiling this unconditionally we better move it over to
> stubs.

No, just do what Thomas said.  See hw/pci/Makefile.objs for an example:

common-obj-$(call lnot,$(CONFIG_PCI)) +=3D pci-stub.o
common-obj-$(CONFIG_ALL) +=3D pci-stub.o

So just add the line outside the "if".

Paolo

> cheers,
>   Gerd
>=20
> diff --git a/hw/usb/host-stub.c b/stubs/usb-host.c
> similarity index 100%
> rename from hw/usb/host-stub.c
> rename to stubs/usb-host.c
> diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
> index 0e6d54b21f..c2f46ac540 100644
> --- a/hw/usb/Makefile.objs
> +++ b/hw/usb/Makefile.objs
> @@ -44,8 +44,6 @@ redirect.o-libs =3D $(USB_REDIR_LIBS)
> =C2=A0# usb pass-through
> =C2=A0ifeq ($(CONFIG_USB_LIBUSB)$(CONFIG_USB),yy)
> =C2=A0common-obj-y +=3D host-libusb.o host-legacy.o
> -else
> -common-obj-y +=3D host-stub.o
> =C2=A0endif
> =C2=A0
> =C2=A0host-libusb.o-cflags :=3D $(LIBUSB_CFLAGS)
> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> index c7594796c3..edccdc5f1e 100644
> --- a/stubs/Makefile.objs
> +++ b/stubs/Makefile.objs
> @@ -41,3 +41,4 @@ stub-obj-y +=3D vmgenid.o
> =C2=A0stub-obj-y +=3D xen-common.o
> =C2=A0stub-obj-y +=3D xen-hvm.o
> =C2=A0stub-obj-y +=3D pci-host-piix.o
> +stub-obj-y +=3D usb-host.o
>=20
