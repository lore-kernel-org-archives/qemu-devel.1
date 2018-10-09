Received: from eggs.gnu.org ([2001:4830:134:3::10]:45556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g9oAK-0003jz-PI
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 05:18:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g9oAK-0007B3-2H
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 05:18:56 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41294)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1g9oAJ-0007Ae-Rh
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 05:18:55 -0400
Received: by mail-wr1-x443.google.com with SMTP id x12-v6so967733wru.8
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 02:18:55 -0700 (PDT)
MIME-Version: 1.0
References: <20181008173125.19678-1-armbru@redhat.com>
	<20181008173125.19678-10-armbru@redhat.com>
In-Reply-To: <20181008173125.19678-10-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 9 Oct 2018 13:18:41 +0400
Message-ID: <CAJ+F1CKhy3jXb1w4nfY_QgWvqAKb3+1Bt3uq3yNOr+iH=8ihFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 09/31] ioapic: Fix error handling in
 realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>

On Mon, Oct 8, 2018 at 9:35 PM Markus Armbruster <armbru@redhat.com> wrote:
>
> Calling error_report() in a function that takes an Error ** argument
> is suspicious.  ioapic_realize() does that, and then exit()s.
> Currently mostly harmless, as the device cannot be hot-plugged.
>
> Fixes: 20fd4b7b6d9282fe0cb83601f1821f31bd257458
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/intc/ioapic.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
> index b6896ac4ce..4e529729b4 100644
> --- a/hw/intc/ioapic.c
> +++ b/hw/intc/ioapic.c
> @@ -21,7 +21,7 @@
>   */
>
>  #include "qemu/osdep.h"
> -#include "qemu/error-report.h"
> +#include "qapi/error.h"
>  #include "monitor/monitor.h"
>  #include "hw/hw.h"
>  #include "hw/i386/pc.h"
> @@ -393,9 +393,9 @@ static void ioapic_realize(DeviceState *dev, Error **=
errp)
>      IOAPICCommonState *s =3D IOAPIC_COMMON(dev);
>
>      if (s->version !=3D 0x11 && s->version !=3D 0x20) {
> -        error_report("IOAPIC only supports version 0x11 or 0x20 "
> -                     "(default: 0x%x).", IOAPIC_VER_DEF);
> -        exit(1);
> +        error_setg(errp, "IOAPIC only supports version 0x11 or 0x20 "
> +                   "(default: 0x%x).", IOAPIC_VER_DEF);
> +        return;
>      }
>
>      memory_region_init_io(&s->io_memory, OBJECT(s), &ioapic_io_ops, s,
> --
> 2.17.1
>
>


--=20
Marc-Andr=C3=A9 Lureau
