Received: from eggs.gnu.org ([2001:4830:134:3::10]:40107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ckpya-0002s2-8o
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 05:34:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ckpyZ-0000YE-AS
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 05:34:48 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:35769)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1ckpyY-0000Xw-UZ
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 05:34:47 -0500
Received: by mail-lf0-x244.google.com with SMTP id v2so6299213lfi.2
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 02:34:46 -0800 (PST)
MIME-Version: 1.0
References: <1488789111-27340-1-git-send-email-kraxel@redhat.com>
In-Reply-To: <1488789111-27340-1-git-send-email-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 06 Mar 2017 10:34:33 +0000
Message-ID: <CAJ+F1CJxnhwj0bgturdJrg34CteZBwODgidHjhQYBgmVSxD__g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qxl: clear guest_cursor on QXL_CURSOR_HIDE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On Mon, Mar 6, 2017 at 12:32 PM Gerd Hoffmann <kraxel@redhat.com> wrote:

> Make sure we don't leave guest_cursor pointing into nowhere.  This might
> lead to (rare) live migration failures, due to target trying to restore
> the cursor from the stale pointer.
>
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=3D1421788
> Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>


Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



> ---
>  hw/display/qxl.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/hw/display/qxl.c b/hw/display/qxl.c
> index af4c0ca..0d02f0e 100644
> --- a/hw/display/qxl.c
> +++ b/hw/display/qxl.c
> @@ -477,6 +477,11 @@ static int qxl_track_command(PCIQXLDevice *qxl,
> struct QXLCommandExt *ext)
>              qxl->guest_cursor =3D ext->cmd.data;
>              qemu_mutex_unlock(&qxl->track_lock);
>          }
> +        if (cmd->type =3D=3D QXL_CURSOR_HIDE) {
> +            qemu_mutex_lock(&qxl->track_lock);
> +            qxl->guest_cursor =3D 0;
> +            qemu_mutex_unlock(&qxl->track_lock);
> +        }
>          break;
>      }
>      }
> --
> 1.8.3.1
>
>
> --
Marc-Andr=C3=A9 Lureau
