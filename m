Received: from eggs.gnu.org ([2001:4830:134:3::10]:50313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkTlk-0008Ve-8K
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 07:24:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkTlj-0004gX-Bg
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 07:24:20 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-12-marcandre.lureau@redhat.com>
Date: Wed, 23 Aug 2017 13:24:09 +0200
In-Reply-To: <20170822132255.23945-12-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 22 Aug 2017
	15:22:12 +0200")
Message-ID: <87efs21q92.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 11/54] quorum: use qapi_enum_parse() in
 quorum_open
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, "open list:Quorum" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  block/quorum.c | 27 ++++++++-------------------
>  1 file changed, 8 insertions(+), 19 deletions(-)
>
> diff --git a/block/quorum.c b/block/quorum.c
> index d04da4f430..e4271caa7a 100644
> --- a/block/quorum.c
> +++ b/block/quorum.c
> @@ -22,6 +22,7 @@
>  #include "qapi/qmp/qjson.h"
>  #include "qapi/qmp/qlist.h"
>  #include "qapi/qmp/qstring.h"
> +#include "qapi/util.h"
>  #include "qapi-event.h"
>  #include "crypto/hash.h"
>=20=20
> @@ -867,24 +868,6 @@ static QemuOptsList quorum_runtime_opts =3D {
>      },
>  };
>=20=20
> -static int parse_read_pattern(const char *opt)
> -{
> -    int i;
> -
> -    if (!opt) {
> -        /* Set quorum as default */
> -        return QUORUM_READ_PATTERN_QUORUM;
> -    }
> -
> -    for (i =3D 0; i < QUORUM_READ_PATTERN__MAX; i++) {
> -        if (!strcmp(opt, QuorumReadPattern_lookup[i])) {
> -            return i;
> -        }
> -    }
> -
> -    return -EINVAL;
> -}
> -
>  static int quorum_open(BlockDriverState *bs, QDict *options, int flags,
>                         Error **errp)
>  {
> @@ -925,7 +908,13 @@ static int quorum_open(BlockDriverState *bs, QDict *=
options, int flags,
>          goto exit;
>      }
>=20=20
> -    ret =3D parse_read_pattern(qemu_opt_get(opts, QUORUM_OPT_READ_PATTER=
N));
> +    if (!qemu_opt_get(opts, QUORUM_OPT_READ_PATTERN)) {
> +        ret =3D QUORUM_READ_PATTERN_QUORUM;
> +    } else {
> +        ret =3D qapi_enum_parse(QuorumReadPattern_lookup,
> +                              qemu_opt_get(opts, QUORUM_OPT_READ_PATTERN=
),
> +                              QUORUM_READ_PATTERN__MAX, -EINVAL, NULL);
> +    }
>      if (ret < 0) {
>          error_setg(&local_err, "Please set read-pattern as fifo or quoru=
m");
>          goto exit;

qapi_enum_parse() copes with null input: it returns its fourth argument
then.  I don't like that also returns it on error, but that shouldn't be
a problem here.

If we can live with qapi_enum_parse()'s sub-par error message, then this
should do:

       ret =3D qapi_enum_parse(QuorumReadPattern_lookup,
                             qemu_opt_get(opts, QUORUM_OPT_READ_PATTERN),
                             QUORUM_READ_PATTERN__MAX,
                             QUORUM_READ_PATTERN_QUORUM, &local_err);
       if (local_err) {
           goto exit;
       }

If not, we'd have to replace @local_err:

       if (local_err) {
           error_free(local_err);
           error_setg(&local_err, "Please set read-pattern as fifo or quoru=
m");
           goto exit;
       }

or amend it with error_append_hint() or error_prepend().

Berto, what do you think?
