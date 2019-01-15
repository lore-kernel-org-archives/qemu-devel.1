Received: from eggs.gnu.org ([209.51.188.92]:38756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gjWcZ-0003Ux-99
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 16:51:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gjWcY-0004nJ-5l
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 16:51:43 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43224)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1gjWcX-0004hr-RK
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 16:51:42 -0500
Received: by mail-lj1-f193.google.com with SMTP id q2-v6so3673664lji.10
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 13:51:33 -0800 (PST)
MIME-Version: 1.0
References: <20190115143650.15725-1-jusual@mail.ru>
In-Reply-To: <20190115143650.15725-1-jusual@mail.ru>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 15 Jan 2019 13:51:05 -0800
Message-ID: <CAKmqyKOyfP=ZT-diiFFfAieYKt98DPSxf0HyVdwYE4g+jv5w0w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/core/generic-loader: Fix PC overwriting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair@alistair23.me>

On Tue, Jan 15, 2019 at 7:04 AM Julia Suvorova via Qemu-devel
<qemu-devel@nongnu.org> wrote:
>
> If the memory is set using a file, and PC is specified on the command
> line, it will be overwritten with the value 'entry'. This is not only
> illogical, but also incorrect, because the load_ * functions do not take
> into account the specifics of the ARM-M PC.

How does this come up?
I see that the value of entry will force overwrite the PC addr, but
doesn't force_raw fix that? Is there a common use case of loading an
ELF/uimage but having to manually specify a start address?

Alistair

>
> Signed-off-by: Julia Suvorova <jusual@mail.ru>
> ---
>  hw/core/generic-loader.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
> index fbae05fb3b..fc81fd8e14 100644
> --- a/hw/core/generic-loader.c
> +++ b/hw/core/generic-loader.c
> @@ -152,7 +152,7 @@ static void generic_loader_realize(DeviceState *dev, Error **errp)
>          if (size < 0 || s->force_raw) {
>              /* Default to the maximum size being the machine's ram size */
>              size = load_image_targphys_as(s->file, s->addr, ram_size, as);
> -        } else {
> +        } else if (!s->addr) {
>              s->addr = entry;
>          }
>
> --
> 2.17.1
>
>
