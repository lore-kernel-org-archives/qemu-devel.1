Received: from eggs.gnu.org ([2001:4830:134:3::10]:47073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dovWK-00034c-O8
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 13:50:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dovWF-00022o-W4
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 13:50:48 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:37456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dovWF-00021g-MY
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 13:50:43 -0400
Received: by mail-wm0-x230.google.com with SMTP id u26so7153444wma.0
	for <qemu-devel@nongnu.org>; Mon, 04 Sep 2017 10:50:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170904172500.26513-1-n54@gmx.com>
References: <20170903163455.15132-1-n54@gmx.com>
	<20170904172500.26513-1-n54@gmx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Sep 2017 18:50:21 +0100
Message-ID: <CAFEAcA8ojJteWAuwxhQPVTVvFh5b-S4zWoyCssM0ZxWt5tt4GQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] usb-mtp: Add fallback definition of
 NAME_MAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 4 September 2017 at 18:25, Kamil Rytarowski <n54@gmx.com> wrote:
> This fixes build on SmartOS (Joyent).
>
> Patch cherry-picked from pkgsrc by jperkin (Joyent).
>
> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  include/qemu/osdep.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 6855b94bbf..5d3860f80e 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -306,6 +306,11 @@ void qemu_anon_ram_free(void *ptr, size_t size);
>  #endif
>  #endif
>
> +/* Required by SmartOS (SunOS) */
> +#ifndef NAME_MAX
> +#define NAME_MAX 255
> +#endif

So in hw/usb/dev-mtp.c we're using NAME_MAX in
    char buf[sizeof(struct inotify_event) + NAME_MAX + 1];

because the Linux implementation of inotify documents in inotify(7)
that this is guaranteed to be sufficient to read at least one event:
  http://man7.org/linux/man-pages/man7/inotify.7.html
Looking at the SmartOS manpage
  https://smartos.org/man/5/inotify
there doesn't seem to be any equivalent language.

What is the SmartOS requirement on the buffer size to be
guaranteed to read at least one complete event ?
Defining NAME_MAX to 255 seems like it shuts up the compiler
error but does it give us the correct behaviour?

thanks
-- PMM
