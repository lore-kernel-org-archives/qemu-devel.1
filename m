Received: from eggs.gnu.org ([2001:4830:134:3::10]:39243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dZu9H-0004br-78
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 03:20:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dZu9C-00042S-2z
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 03:20:55 -0400
Date: Tue, 25 Jul 2017 09:20:40 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170725092040.6406aa94@gondolin>
In-Reply-To: <20170724182751.18261-15-f4bug@amsat.org>
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-15-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 2.10 14/35] vfio/ccw: fix incorrect
 malloc() size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On Mon, 24 Jul 2017 15:27:30 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> Since sizeof(struct vfio_irq_info) < sizeof(struct vfio_irq_set) a heap o=
verflow
> never occured. Still, let's use the correct size.
>=20
> hw/vfio/ccw.c:170:16: warning: Cast a region whose size is not a multiple=
 of the destination type size
>     irq_info =3D g_malloc0(sizeof(*irq_set));
>                ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> Reported-by: Clang Static Analyzer
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/vfio/ccw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 12d0262336..8d97b53e77 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -168,7 +168,7 @@ static void vfio_ccw_register_io_notifier(VFIOCCWDevi=
ce *vcdev, Error **errp)
>          return;
>      }
> =20
> -    argsz =3D sizeof(*irq_set);
> +    argsz =3D sizeof(*irq_info);
>      irq_info =3D g_malloc0(argsz);
>      irq_info->index =3D VFIO_CCW_IO_IRQ_INDEX;
>      irq_info->argsz =3D argsz;

Thanks for the patch, but I already have "vfio/ccw: allocate irq info
with the right size" queued in my s390-next branch (for which I plan to
send a pull req today).
