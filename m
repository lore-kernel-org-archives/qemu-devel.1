Received: from eggs.gnu.org ([2001:4830:134:3::10]:57515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1daQLQ-00020B-CQ
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 13:43:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1daQLM-0001dH-El
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 13:43:36 -0400
Date: Wed, 26 Jul 2017 11:43:28 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170726114328.43416891@w520.home>
In-Reply-To: <20170724182751.18261-13-f4bug@amsat.org>
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-13-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 2.10 12/35] vfio/platform: fix use of
 freed memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On Mon, 24 Jul 2017 15:27:28 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> free the data _after_ using it.
>=20
> hw/vfio/platform.c:126:29: warning: Use of memory after it is freed
>         qemu_set_fd_handler(*pfd, NULL, NULL, NULL);
>                             ^~~~
>=20
> Reported-by: Clang Static Analyzer
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/vfio/platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> index 7c09deda61..da84abf4fc 100644
> --- a/hw/vfio/platform.c
> +++ b/hw/vfio/platform.c
> @@ -120,11 +120,11 @@ static int vfio_set_trigger_eventfd(VFIOINTp *intp,
>      *pfd =3D event_notifier_get_fd(intp->interrupt);
>      qemu_set_fd_handler(*pfd, (IOHandler *)handler, NULL, intp);
>      ret =3D ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, irq_set);
> -    g_free(irq_set);
>      if (ret < 0) {
>          error_report("vfio: Failed to set trigger eventfd: %m");
>          qemu_set_fd_handler(*pfd, NULL, NULL, NULL);
>      }
> +    g_free(irq_set);
>      return ret;
>  }
> =20

I'll snag this and 13/35 for a pull request with Paolo's R-b.  Connie
has already put a fix in for the other vfio related one, 14/35.  Thanks!

Alex
