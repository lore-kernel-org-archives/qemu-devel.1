Received: from eggs.gnu.org ([2001:4830:134:3::10]:36466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dzgKD-0000nH-F8
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 05:50:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dzgKA-0006lu-CD
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 05:50:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46224)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dzgKA-0006kx-5u
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 05:50:42 -0400
Message-ID: <1507110639.27227.4.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 04 Oct 2017 11:50:39 +0200
In-Reply-To: <9d566b88-7991-b9f4-8b73-737a99d3ac6d@redhat.com>
References: <20170929110052.6111-1-kraxel@redhat.com>
	<CAFEAcA-8gaOhkuNX9hBt0Ofg-CKkJ-v8puHJ4K3QOq0ZGMgB5w@mail.gmail.com>
	<1507106598.27227.2.camel@redhat.com>
	<9d566b88-7991-b9f4-8b73-737a99d3ac6d@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

  Hi,
>=20
> Ah, deja vu. I think you've now run into the problem that I had with
> my
> patch, too - see:
>=20
> =C2=A0https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg01875.ht=
ml
> =C2=A0https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg02082.ht=
ml
>=20
> I think this is a race condition when building with "make -j" in
> parallel. Just add a line like this and you should be fine:
>=20
> common-obj-$(CONFIG_ALL) +=3D host-stub.o

I'd guess when compiling this unconditionally we better move it over to
stubs.

cheers,
  Gerd

diff --git a/hw/usb/host-stub.c b/stubs/usb-host.c
similarity index 100%
rename from hw/usb/host-stub.c
rename to stubs/usb-host.c
diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
index 0e6d54b21f..c2f46ac540 100644
--- a/hw/usb/Makefile.objs
+++ b/hw/usb/Makefile.objs
@@ -44,8 +44,6 @@ redirect.o-libs =3D $(USB_REDIR_LIBS)
=C2=A0# usb pass-through
=C2=A0ifeq ($(CONFIG_USB_LIBUSB)$(CONFIG_USB),yy)
=C2=A0common-obj-y +=3D host-libusb.o host-legacy.o
-else
-common-obj-y +=3D host-stub.o
=C2=A0endif
=C2=A0
=C2=A0host-libusb.o-cflags :=3D $(LIBUSB_CFLAGS)
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index c7594796c3..edccdc5f1e 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -41,3 +41,4 @@ stub-obj-y +=3D vmgenid.o
=C2=A0stub-obj-y +=3D xen-common.o
=C2=A0stub-obj-y +=3D xen-hvm.o
=C2=A0stub-obj-y +=3D pci-host-piix.o
+stub-obj-y +=3D usb-host.o
