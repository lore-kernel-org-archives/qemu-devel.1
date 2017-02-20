Received: from eggs.gnu.org ([2001:4830:134:3::10]:45591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cfqIg-0006Y6-BJ
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 10:54:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cfqId-0000aO-8W
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 10:54:54 -0500
References: <1487603763-14932-1-git-send-email-kraxel@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <02a49a30-aa68-6484-0957-85009948296e@redhat.com>
Date: Mon, 20 Feb 2017 16:54:46 +0100
MIME-Version: 1.0
In-Reply-To: <1487603763-14932-1-git-send-email-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RfC PATCH] vga: wire up -g <width>x<height>
 switch for virtio and qxl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

On 20.02.2017 16:16, Gerd Hoffmann wrote:
> FIXME: qxl not working yet.

I think the basic idea of the patch is good, but I'd remove the qxl
FIXMEs for the final version of the patch (spice is likely not working
on Sparc and PPC anyway yet).

> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  arch_init.c             |  8 ++++++--
>  hw/display/qxl.c        | 18 ++++++++++++++++++
>  hw/display/virtio-gpu.c |  9 +++++++--
>  qemu-options.hx         |  6 ++++--
>  4 files changed, 35 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch_init.c b/arch_init.c
> index 0810116..9cd3dfc 100644
> --- a/arch_init.c
> +++ b/arch_init.c
> @@ -34,14 +34,18 @@
>  #include "hw/acpi/acpi.h"
>  #include "qemu/help_option.h"
> =20
> -#ifdef TARGET_SPARC
> +#if defined(TARGET_SPARC)
>  int graphic_width =3D 1024;
>  int graphic_height =3D 768;
>  int graphic_depth =3D 8;
> -#else
> +#elif defined(TARGET_PPC)
>  int graphic_width =3D 800;
>  int graphic_height =3D 600;
>  int graphic_depth =3D 32;
> +#else
> +int graphic_width;
> +int graphic_height;
> +int graphic_depth;
>  #endif

IMHO we could also switch the default resolution on ppc to 1024x768, so
you could simplify that code to something like that:

int graphic_width =3D 1024;
int graphic_height =3D 768;
#ifdef TARGET_SPARC
int graphic_depth =3D 8;
#else
int graphic_depth =3D 32;
#endif

You likely also don't need if-statement in virtio-gpu.c anymore in that
case.

And maybe Sparc can even work fine with 32 bpp nowadays, too, so you
could completely get rid of the ifdefery here?

 Thomas
