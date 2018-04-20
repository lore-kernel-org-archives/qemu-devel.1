Received: from eggs.gnu.org ([2001:4830:134:3::10]:60454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f9Rxy-0005im-SV
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 05:04:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f9Rxs-0000VE-Ts
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 05:04:26 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:42711)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1f9Rxs-0000UD-NX
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 05:04:20 -0400
Received: by mail-wr0-x242.google.com with SMTP id s18-v6so20938169wrg.9
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 02:04:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180420084820.3873-1-kraxel@redhat.com>
References: <20180420084820.3873-1-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 20 Apr 2018 11:04:18 +0200
Message-ID: <CAJ+F1C+r00bbu--tnDaYoE9cOPdWfF0erd=cEAtMJjsiCOW=MA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vnc: fix use-after-free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

Hi

On Fri, Apr 20, 2018 at 10:48 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
> When vnc_client_read() return value is -1
> vs is not valid any more.
>
> Fixes: d49b87f0d1e0520443a990fc610d0f02bc63c556
> Reported-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Tested-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  ui/vnc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/ui/vnc.c b/ui/vnc.c
> index e164eb798c..5526e54f48 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -1539,13 +1539,14 @@ gboolean vnc_client_io(QIOChannel *ioc G_GNUC_UNU=
SED,
>      VncState *vs =3D opaque;
>      if (condition & G_IO_IN) {
>          if (vnc_client_read(vs) < 0) {
> -            goto end;
> +            /* vs is free()ed here */
> +            return TRUE;
>          }
>      }
>      if (condition & G_IO_OUT) {
>          vnc_client_write(vs);
>      }
> -end:
> +
>      if (vs->disconnecting) {
>          if (vs->ioc_tag !=3D 0) {
>              g_source_remove(vs->ioc_tag);
> --
> 2.9.3
>
>



--=20
Marc-Andr=C3=A9 Lureau
