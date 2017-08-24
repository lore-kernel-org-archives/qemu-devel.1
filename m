Received: from eggs.gnu.org ([2001:4830:134:3::10]:42882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dkqLG-000136-BF
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 07:30:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dkqLF-0007Sw-JK
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 07:30:30 -0400
Received: from mail-ua0-x243.google.com ([2607:f8b0:400c:c08::243]:35777)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dkqLF-0007SK-Eo
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 07:30:29 -0400
Received: by mail-ua0-x243.google.com with SMTP id c3so960231uae.2
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 04:30:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1503564371-26090-11-git-send-email-armbru@redhat.com>
References: <1503564371-26090-1-git-send-email-armbru@redhat.com>
	<1503564371-26090-11-git-send-email-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 24 Aug 2017 13:30:28 +0200
Message-ID: <CAJ+F1CKPMV-r3Jo5+n-aT4wpKLAEjBQbhEhwUnpE7rdc_5rnqg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 10/16] qapi: Use qapi_enum_parse() in
 input_type_enum()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Thu, Aug 24, 2017 at 10:46 AM, Markus Armbruster <armbru@redhat.com> wro=
te:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  qapi/qapi-visit-core.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/qapi/qapi-visit-core.c b/qapi/qapi-visit-core.c
> index ed6d2af..ec83ff6 100644
> --- a/qapi/qapi-visit-core.c
> +++ b/qapi/qapi-visit-core.c
> @@ -14,6 +14,7 @@
>
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
> +#include "qapi/util.h"
>  #include "qemu-common.h"
>  #include "qapi/qmp/qobject.h"
>  #include "qapi/qmp/qerror.h"
> @@ -353,7 +354,7 @@ static void input_type_enum(Visitor *v, const char *n=
ame, int *obj,
>                              const char *const strings[], Error **errp)
>  {
>      Error *local_err =3D NULL;
> -    int64_t value =3D 0;
> +    int64_t value;
>      char *enum_str;
>
>      visit_type_str(v, name, &enum_str, &local_err);
> @@ -362,14 +363,8 @@ static void input_type_enum(Visitor *v, const char *=
name, int *obj,
>          return;
>      }
>
> -    while (strings[value] !=3D NULL) {
> -        if (strcmp(strings[value], enum_str) =3D=3D 0) {
> -            break;
> -        }
> -        value++;
> -    }
> -
> -    if (strings[value] =3D=3D NULL) {
> +    value =3D qapi_enum_parse(strings, enum_str, -1, NULL);
> +    if (value < 0) {
>          error_setg(errp, QERR_INVALID_PARAMETER, enum_str);
>          g_free(enum_str);
>          return;
> --
> 2.7.5
>
>



--=20
Marc-Andr=C3=A9 Lureau
