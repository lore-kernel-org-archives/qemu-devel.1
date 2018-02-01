Received: from eggs.gnu.org ([2001:4830:134:3::10]:57428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ehJYY-0000UU-5a
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:25:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ehJYU-00055R-PE
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:25:53 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:28519)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1ehJYU-00054I-EL
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:25:50 -0500
Date: Thu, 1 Feb 2018 19:25:48 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20180201180033.14255-1-berrange@redhat.com>
Message-ID: <alpine.BSF.2.21.1802011922540.52766@zero.eik.bme.hu>
References: <20180201180033.14255-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1] ui: fix mixup between qnum and qcode in
 SDL1 key handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

On Thu, 1 Feb 2018, Daniel P. Berrang=C3=A9 wrote:
> The previous commit:
>
>  commit 2ec78706d188df7d3dab43d07b19b05ef7800a44
>  Author: Daniel P. Berrange <berrange@redhat.com>
>  Date:   Wed Jan 17 16:47:15 2018 +0000
>
>    ui: convert GTK and SDL1 frontends to keycodemapdb
>
> changed the x_keymap.c keymap so that its target was qcodes instead of
> qnums. It updated the GTK frontend to take account of this change, but
> forgot to update the SDL1 frontend. Thus the SDL frontend was getting
> qcodes but dispatching them as if they were qnums. IOW, keyboard input
> was completely hosed with SDL1. Since the keyboard layout tables are
> still all based on qnums, it is easier to just keep SDL1 using qnums as
> it will be deleted in a few releases time.
>
> Reported-by: BALATON Zoltan <balaton@eik.bme.hu>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Tested-by: BALATON Zoltan <balaton@eik.bme.hu>

Thanks, this seems to fix the issue I have seen with SDL1.

> ---
> ui/sdl.c | 9 ++++++++-
> 1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/ui/sdl.c b/ui/sdl.c
> index c8f102bb9f..a6bff301eb 100644
> --- a/ui/sdl.c
> +++ b/ui/sdl.c
> @@ -242,6 +242,7 @@ static const guint16 *sdl_get_keymap(size_t *maplen=
)
>
> static uint8_t sdl_keyevent_to_keycode(const SDL_KeyboardEvent *ev)
> {
> +    int qcode;
>     if (!keycode_map) {
>         return 0;
>     }
> @@ -249,7 +250,13 @@ static uint8_t sdl_keyevent_to_keycode(const SDL_K=
eyboardEvent *ev)
>         return 0;
>     }
>
> -    return keycode_map[ev->keysym.scancode];
> +    qcode =3D keycode_map[ev->keysym.scancode];
> +
> +    if (qcode > qemu_input_map_qcode_to_qnum_len) {
> +        return 0;
> +    }
> +
> +    return qemu_input_map_qcode_to_qnum[qcode];
> }
>
> static void reset_keys(void)
>
