Received: from eggs.gnu.org ([209.51.188.92]:55290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ghW3i-00009G-AC
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 03:51:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ghVoR-0000Mq-QI
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 03:35:40 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41708)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1ghVoR-0000MD-DZ
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 03:35:39 -0500
Received: by mail-wr1-x444.google.com with SMTP id x10so10299744wrs.8
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 00:35:39 -0800 (PST)
MIME-Version: 1.0
References: <20190110020259.8492-1-ehabkost@redhat.com>
	<20190110020259.8492-4-ehabkost@redhat.com>
In-Reply-To: <20190110020259.8492-4-ehabkost@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 10 Jan 2019 12:35:26 +0400
Message-ID: <CAJ+F1C+cADS2WKysnEzH-ZD=C3uj5wymQFXtd4L9BOO2cjbjvA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/3] virtio: Make
 disable-legacy/disable-modern compat properties optional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi

On Thu, Jan 10, 2019 at 6:05 AM Eduardo Habkost <ehabkost@redhat.com> wrote=
:
>
> The disable-legacy and disable-modern properties apply only to
> some virtio-pci devices.  Make those properties optional.
>
> This fixes the crash introduced by commit f6e501a28ef9 ("virtio: Provide
> version-specific variants of virtio PCI devices"):
>
>   $ qemu-system-x86_64 -machine pc-i440fx-2.6 \
>     -device virtio-net-pci-non-transitional
>   Unexpected error in object_property_find() at qom/object.c:1092:
>   qemu-system-x86_64: -device virtio-net-pci-non-transitional: can't appl=
y \
>   global virtio-pci.disable-modern=3Don: Property '.disable-modern' not f=
ound
>   Aborted (core dumped)
>
> Reported-by: Thomas Huth <thuth@redhat.com>
> Fixes: f6e501a28ef9 ("virtio: Provide version-specific variants of virtio=
 PCI devices")
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  hw/core/machine.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 5530b71981..a19143aa44 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -91,8 +91,9 @@ const size_t hw_compat_2_7_len =3D G_N_ELEMENTS(hw_comp=
at_2_7);
>
>  GlobalProperty hw_compat_2_6[] =3D {
>      { "virtio-mmio", "format_transport_address", "off" },
> -    { "virtio-pci", "disable-modern", "on" },
> -    { "virtio-pci", "disable-legacy", "off" },
> +    /* Optional because not all virtio-pci devices support legacy mode *=
/
> +    { "virtio-pci", "disable-modern", "on",  .optional =3D true },
> +    { "virtio-pci", "disable-legacy", "off", .optional =3D true },

Could the generic devices implement a specific interface instead?
virtio-pci-generic?

Adding "optional" handling looks like it may hide some other errors.

>  };
>  const size_t hw_compat_2_6_len =3D G_N_ELEMENTS(hw_compat_2_6);
>
> --
> 2.18.0.rc1.1.g3f1ff2140
>
>


--=20
Marc-Andr=C3=A9 Lureau
