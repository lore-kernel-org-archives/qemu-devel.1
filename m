Received: from eggs.gnu.org ([2001:4830:134:3::10]:54417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fnAr4-0004h7-MY
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 18:53:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fnAr3-0006ZP-Sc
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 18:53:30 -0400
MIME-Version: 1.0
In-Reply-To: <20180807221830.3844-1-peter@lekensteyn.nl>
References: <20180807221830.3844-1-peter@lekensteyn.nl>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 8 Aug 2018 00:53:27 +0200
Message-ID: <CAJ+F1C+fLwqSZ7js7vMym5CGZfvzfziUAtYhL=k0CHT21NZvmQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vnc: fix memleak of the
 "vnc-worker-output" name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Wu <peter@lekensteyn.nl>
Cc: QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, qemu-stable <qemu-stable@nongnu.org>

Hi

On Wed, Aug 8, 2018 at 12:18 AM, Peter Wu <peter@lekensteyn.nl> wrote:
> Fixes repeated memory leaks of 18 bytes when using VNC:
>
>     Direct leak of 831024 byte(s) in 46168 object(s) allocated from:
>         ...
>         #4 0x7f6d2f919bdd in g_strdup_vprintf glib/gstrfuncs.c:514
>         #5 0x56085cdcf660 in buffer_init util/buffer.c:59
>         #6 0x56085ca6a7ec in vnc_async_encoding_start ui/vnc-jobs.c:177
>         #7 0x56085ca6b815 in vnc_worker_thread_loop ui/vnc-jobs.c:240
>
> Fixes: 543b95801f98 ("vnc: attach names to buffers")
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> CC: qemu-stable@nongnu.org
> Signed-off-by: Peter Wu <peter@lekensteyn.nl>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  ui/vnc-jobs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
> index b0b15d42a8..929391f85d 100644
> --- a/ui/vnc-jobs.c
> +++ b/ui/vnc-jobs.c
> @@ -193,6 +193,7 @@ static void vnc_async_encoding_start(VncState *orig, =
VncState *local)
>
>  static void vnc_async_encoding_end(VncState *orig, VncState *local)
>  {
> +    buffer_free(&local->output);
>      orig->tight =3D local->tight;
>      orig->zlib =3D local->zlib;
>      orig->hextile =3D local->hextile;
> @@ -278,7 +279,7 @@ static int vnc_worker_thread_loop(VncJobQueue *queue)
>          /* Copy persistent encoding data */
>          vnc_async_encoding_end(job->vs, &vs);
>
> -       qemu_bh_schedule(job->vs->bh);
> +        qemu_bh_schedule(job->vs->bh);

just fixing a tab, not a big deal, but preferably not in the same patch

>      }  else {
>          buffer_reset(&vs.output);
>          /* Copy persistent encoding data */
> --
> 2.18.0
>
>



--=20
Marc-Andr=C3=A9 Lureau
