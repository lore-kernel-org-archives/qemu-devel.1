Received: from eggs.gnu.org ([2001:4830:134:3::10]:33956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egsfx-0005lL-69
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 08:43:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egsfr-0005tc-AO
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 08:43:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1egsfr-0005t4-4I
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 08:43:39 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180122120351.22369-1-f4bug@amsat.org>
	<20180122120351.22369-4-f4bug@amsat.org>
Date: Wed, 31 Jan 2018 14:43:34 +0100
In-Reply-To: <20180122120351.22369-4-f4bug@amsat.org> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon,
	22 Jan 2018 09:03:47 -0300")
Message-ID: <87wozy3zzt.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/7] usb-ccid: convert
 CCIDCardClass::init -> realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/usb/ccid.h                 |  9 +++++--
>  hw/usb/ccid-card-emulated.c   | 45 ++++++++++++++++++----------------
>  hw/usb/ccid-card-passthru.c   | 10 ++++----
>  hw/usb/dev-smartcard-reader.c | 57 +++++++++++++++----------------------=
------
>  4 files changed, 56 insertions(+), 65 deletions(-)
>
[...]
> diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
> index e646eb243b..a2b608a953 100644
> --- a/hw/usb/ccid-card-emulated.c
> +++ b/hw/usb/ccid-card-emulated.c
> @@ -27,6 +27,7 @@
>   */
>=20=20
>  #include "qemu/osdep.h"
> +#include "qapi/error.h"
>  #include <eventt.h>
>  #include <vevent.h>
>  #include <vreader.h>
> @@ -480,7 +481,7 @@ static uint32_t parse_enumeration(char *str,
>      return ret;
>  }
>=20=20
> -static int emulated_initfn(CCIDCardState *base)
> +static void emulated_realize(CCIDCardState *base, Error **errp)
>  {
>      EmulatedState *card =3D EMULATED_CCID_CARD(base);
>      VCardEmulError ret;
> @@ -495,7 +496,8 @@ static int emulated_initfn(CCIDCardState *base)
>      card->reader =3D NULL;
>      card->quit_apdu_thread =3D 0;
>      if (init_event_notifier(card) < 0) {
> -        return -1;
> +        error_setg(errp, TYPE_EMULATED_CCID ": event notifier creation f=
ailed");
> +        return;
>      }
>=20=20
>      card->backend =3D 0;
> @@ -505,11 +507,12 @@ static int emulated_initfn(CCIDCardState *base)
>      }
>=20=20
>      if (card->backend =3D=3D 0) {
> -        printf("backend must be one of:\n");
> +        error_setg(errp, TYPE_EMULATED_CCID ": no backend specified.");

No period at end of error_setg() messages, please.  More of the same below.

> +        error_append_hint(errp, "backend must be one of:\n");
>          for (ptable =3D backend_enum_table; ptable->name !=3D NULL; ++pt=
able) {
> -            printf("%s\n", ptable->name);
> +            error_append_hint(errp, "%s\n", ptable->name);
>          }
> -        return -1;
> +        return;
>      }
>=20=20
>      /* TODO: a passthru backened that works on local machine. third card=
 type?*/
[...]
