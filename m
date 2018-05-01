Received: from eggs.gnu.org ([2001:4830:134:3::10]:44898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fDTTI-0006pW-RW
	for qemu-devel@nongnu.org; Tue, 01 May 2018 07:29:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fDTTI-0002M8-0o
	for qemu-devel@nongnu.org; Tue, 01 May 2018 07:29:24 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:40906)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fDTTH-0002Lu-QZ
	for qemu-devel@nongnu.org; Tue, 01 May 2018 07:29:23 -0400
Received: by mail-wr0-x242.google.com with SMTP id v60-v6so10564229wrc.7
	for <qemu-devel@nongnu.org>; Tue, 01 May 2018 04:29:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180427115528.345-1-kraxel@redhat.com>
References: <20180427115528.345-1-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 1 May 2018 13:29:21 +0200
Message-ID: <CAJ+F1CKrN7eBC=QuBTfUZnNw38szLawFpvtj=oaqxp+y7dcO0Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qxl: fix local renderer crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

Hi

On Fri, Apr 27, 2018 at 1:55 PM, Gerd Hoffmann <kraxel@redhat.com> wrote:
> Make sure we only ask the spice local renderer for display updates in
> case we have a valid primary surface.  Without that spice is confused
> and throws errors in case a display update request (triggered by
> screendump for example) happens in parallel to a mode switch and hits
> the race window where the old primary surface is gone and the new isn't
> establisted yet.
>
> Fixes: https://bugzilla.redhat.com//show_bug.cgi?id=3D1567733
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Because the update message is handled asynchronously by the spice
worker thread, I wonder if it shouldn't be ignored by spice instead if
the display state is invalid/undefined.

But this patch seems reasonable too:
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  hw/display/qxl-render.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/display/qxl-render.c b/hw/display/qxl-render.c
> index e7ac4f8789..c62b9a5e75 100644
> --- a/hw/display/qxl-render.c
> +++ b/hw/display/qxl-render.c
> @@ -169,7 +169,8 @@ void qxl_render_update(PCIQXLDevice *qxl)
>
>      qemu_mutex_lock(&qxl->ssd.lock);
>
> -    if (!runstate_is_running() || !qxl->guest_primary.commands) {
> +    if (!runstate_is_running() || !qxl->guest_primary.commands ||
> +        qxl->mode =3D=3D QXL_MODE_UNDEFINED) {
>          qxl_render_update_area_unlocked(qxl);
>          qemu_mutex_unlock(&qxl->ssd.lock);
>          return;
> --
> 2.9.3
>
>



--=20
Marc-Andr=C3=A9 Lureau
