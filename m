Received: from eggs.gnu.org ([2001:4830:134:3::10]:47568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gClAT-0000Ed-RE
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:43:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gClAO-0005GJ-DM
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:43:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gClAM-0005Ci-9o
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:43:12 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20181012114916.23532-1-david@redhat.com>
	<20181012114916.23532-2-david@redhat.com>
Date: Wed, 17 Oct 2018 14:42:51 +0200
In-Reply-To: <20181012114916.23532-2-david@redhat.com> (David Hildenbrand's
	message of "Fri, 12 Oct 2018 13:49:10 +0200")
Message-ID: <87lg6wpwvo.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/7] qapi: correctly parse uint64_t
 values from strings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Igor Mammedov <imammedo@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

Quick peek only for now.

David Hildenbrand <david@redhat.com> writes:

> Right now, we parse uint64_t values just like int64_t values, resulting
> in negative values getting accepted and certain valid large numbers only
> being representable as negative numbers. Also, reported errors indicate
> that an int64_t is expected.
>
> Parse uin64_t separately. Implementation inspired by original
> parse_str() implementation.
>
> E.g. we can now specify
>     -device nvdimm,memdev=3Dmem1,id=3Dnv1,addr=3D0xFFFFFFFFC0000000
> Instead of going via negative values
>     -device nvdimm,memdev=3Dmem1,id=3Dnv1,addr=3D-0x40000000
>
> Resulting in the same values
>
> (qemu) info memory-devices
> Memory device [nvdimm]: "nv1"
>   addr: 0xffffffffc0000000
>   slot: 0
>   node: 0
>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Related work on the QObject input visitor:

commit 5923f85fb82df7c8c60a89458a5ae856045e5ab1
Author: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Date:   Wed Jun 7 20:36:03 2017 +0400

    qapi: update the qobject visitor to use QNUM_U64
=20=20=20=20
    Switch to use QNum/uint where appropriate to remove i64 limitation.
=20=20=20=20
    The input visitor will cast i64 input to u64 for compatibility
    reasons (existing json QMP client already use negative i64 for large
    u64, and expect an implicit cast in qemu).
=20=20=20=20
    Note: before the patch, uint64_t values above INT64_MAX are sent over
    json QMP as negative values, e.g. UINT64_MAX is sent as -1. After the
    patch, they are sent unmodified.  Clearly a bug fix, but we have to
    consider compatibility issues anyway.  libvirt should cope fine,
    because its parsing of unsigned integers accepts negative values
    modulo 2^64.  There's hope that other clients will, too.
=20=20=20=20
    Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
    Reviewed-by: Markus Armbruster <armbru@redhat.com>
    Message-Id: <20170607163635.17635-12-marcandre.lureau@redhat.com>
    [check_native_list() tweaked for consistency with signed case]
    Signed-off-by: Markus Armbruster <armbru@redhat.com>

Note who it considers backward compatibility.  Have you done that for
the string input visitor?  The commit message should tell.

> ---
>  qapi/string-input-visitor.c | 117 ++++++++++++++++++++++++++++++++----
>  1 file changed, 106 insertions(+), 11 deletions(-)
>
> diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
> index b3fdd0827d..af0a841152 100644
> --- a/qapi/string-input-visitor.c
> +++ b/qapi/string-input-visitor.c
> @@ -19,6 +19,7 @@
>  #include "qapi/qmp/qnull.h"
>  #include "qemu/option.h"
>  #include "qemu/queue.h"
> +#include "qemu/cutils.h"
>  #include "qemu/range.h"
>=20=20
>=20=20
> @@ -44,7 +45,8 @@ static void free_range(void *range, void *dummy)
>      g_free(range);
>  }
>=20=20
> -static int parse_str(StringInputVisitor *siv, const char *name, Error **=
errp)
> +static int parse_str_int64(StringInputVisitor *siv, const char *name,
> +                           Error **errp)
>  {
>      char *str =3D (char *) siv->string;
>      long long start, end;
> @@ -118,6 +120,75 @@ error:
>      return -1;
>  }
>=20=20
> +static int parse_str_uint64(StringInputVisitor *siv, const char *name,
> +                            Error **errp)
> +{
> +    const char *str =3D (char *) siv->string;
> +    uint64_t start, end;
> +    const char *endptr;
> +    Range *cur;
> +
> +    if (siv->ranges) {
> +        return 0;
> +    }
> +
> +    if (!*str) {
> +        return 0;
> +    }
> +
> +    do {
> +        if (!qemu_strtou64(str, &endptr, 0, &start)) {
> +            if (*endptr =3D=3D '\0') {
> +                cur =3D g_malloc0(sizeof(*cur));
> +                range_set_bounds(cur, start, start);
> +                siv->ranges =3D range_list_insert(siv->ranges, cur);
> +                cur =3D NULL;
> +                str =3D NULL;
> +            } else if (*endptr =3D=3D '-') {
> +                str =3D endptr + 1;
> +                if (!qemu_strtou64(str, &endptr, 0, &end) && start <=3D =
end) {
> +                    if (*endptr =3D=3D '\0') {
> +                        cur =3D g_malloc0(sizeof(*cur));
> +                        range_set_bounds(cur, start, end);
> +                        siv->ranges =3D range_list_insert(siv->ranges, c=
ur);
> +                        cur =3D NULL;
> +                        str =3D NULL;
> +                    } else if (*endptr =3D=3D ',') {
> +                        str =3D endptr + 1;
> +                        cur =3D g_malloc0(sizeof(*cur));
> +                        range_set_bounds(cur, start, end);
> +                        siv->ranges =3D range_list_insert(siv->ranges, c=
ur);
> +                        cur =3D NULL;
> +                    } else {
> +                        goto error;
> +                    }
> +                } else {
> +                    goto error;
> +                }
> +            } else if (*endptr =3D=3D ',') {
> +                str =3D endptr + 1;
> +                cur =3D g_malloc0(sizeof(*cur));
> +                range_set_bounds(cur, start, start);
> +                siv->ranges =3D range_list_insert(siv->ranges, cur);
> +                cur =3D NULL;
> +            } else {
> +                goto error;
> +            }
> +        } else {
> +            goto error;
> +        }
> +    } while (str);
> +
> +    return 0;
> +error:
> +    g_list_foreach(siv->ranges, free_range, NULL);
> +    g_list_free(siv->ranges);
> +    siv->ranges =3D NULL;
> +    error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name ? name : "null",
> +               "an uint64 value or range");
> +    return -1;
> +}
> +

Do we actually need unsigned ranges?  I'm asking because I hate this
code, and duplicating can only make it worse.

[...]
