Received: from eggs.gnu.org ([2001:4830:134:3::10]:34681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Alexandru.Avadanii@enea.com>) id 1cu1Bj-0002vY-IV
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 14:22:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Alexandru.Avadanii@enea.com>) id 1cu1Bi-0004SK-37
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 14:22:19 -0400
From: Alexandru Avadanii <Alexandru.Avadanii@enea.com>
Date: Fri, 31 Mar 2017 18:22:05 +0000
Message-ID: <058D52979F67BF47BCD9EA78EAECA6DC777A00D3@SESTOEX04.enea.se>
References: <20170331152730.12514-1-eblake@redhat.com>
In-Reply-To: <20170331152730.12514-1-eblake@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH for-2.9] rbd: Fix regression in legacy
 key/values containing escaped :
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "jcody@redhat.com" <jcody@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, Josh Durgin <jdurgin@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Tested-by: Alexandru Avadanii <Alexandru.Avadanii@enea.com>

Thank you very much for the quick fix!

> -----Original Message-----
> From: Eric Blake [mailto:eblake@redhat.com]
> Sent: Friday, March 31, 2017 6:28 PM
> To: qemu-devel@nongnu.org
> Cc: qemu-block@nongnu.org; jcody@redhat.com; armbru@redhat.com;
> Alexandru Avadanii; Josh Durgin; Kevin Wolf; Max Reitz
> Subject: [PATCH for-2.9] rbd: Fix regression in legacy key/values contain=
ing
> escaped :
>=20
> Commit c7cacb3 accidentally broke legacy key-value parsing through pseudo=
-
> filename parsing of -drive file=3Drbd://..., for any key that contains an=
 escaped
> ':'.  Such a key is surprisingly common, thanks to mon_host specifying a
> 'host:port' string.  The break happens because passing things from QDict
> through QemuOpts back to another QDict requires that we pack our parsed
> key/value pairs into a string, and then reparse that string, but the
> intermediate string that we created ("key1=3Dvalue1:key2=3Dvalue2") lost =
the \:
> escaping that was present in the original, so that we could no longer see
> which : were used as separators vs. those used as part of the original in=
put.
>=20
> Fix it by collecting the key/value pairs through a QList, and sending tha=
t list on
> a round trip through a JSON QString (as in
> '["key1","value1","key2","value2"]') on its way through QemuOpts, rather
> than hand-rolling our own string.  Since the string is only handled inter=
nally,
> this was faster than creating a full-blown struct of
> '[{"key1":"value1"},{"key2":"value2"}]', and safer at guaranteeing order
> compared to '{"key1":"value1","key2":"value2"}'.
>=20
> It would be nicer if we didn't have to round-trip through QemuOpts in the
> first place, but that's a much bigger task for later.
>=20
> Reproducer:
> ./x86_64-softmmu/qemu-system-x86_64 -nodefaults -nographic -qmp stdio
> \ -drive 'file=3Drbd:volumes/volume-ea141b5c-cdb3-4765-910d-e7008b209a70'=
\
> ':id=3Dcompute:key=3DAQAVkvxXAAAAABAA9ZxWFYdRmV+DSwKr7BKKXg=3D=3D'\
> ':auth_supported=3Dcephx\;none:mon_host=3D192.168.1.2\:6789'\
> ',format=3Draw,if=3Dnone,id=3Ddrive-virtio-disk0,'\
> 'serial=3Dea141b5c-cdb3-4765-910d-e7008b209a70,cache=3Dwriteback'
>=20
> Even without an RBD setup, this serves a test of whether we get the
> incorrect parser error of:
> qemu-system-x86_64: -drive file=3Drbd:...cache=3Dwriteback: conf option 6=
789
> has no value or the correct behavior of hanging while trying to connect t=
o the
> requested mon_host of 192.168.1.2:6789.
>=20
> Reported-by: Alexandru Avadanii <Alexandru.Avadanii@enea.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  block/rbd.c | 83 +++++++++++++++++++++++++++++++------------------------
> ------
>  1 file changed, 42 insertions(+), 41 deletions(-)
>=20
> diff --git a/block/rbd.c b/block/rbd.c
> index 498322b..fbdb131 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -20,6 +20,7 @@
>  #include "crypto/secret.h"
>  #include "qemu/cutils.h"
>  #include "qapi/qmp/qstring.h"
> +#include "qapi/qmp/qjson.h"
>=20
>  /*
>   * When specifying the image filename use:
> @@ -135,18 +136,16 @@ static void qemu_rbd_parse_filename(const char
> *filename, QDict *options,
>                                      Error **errp)  {
>      const char *start;
> -    char *p, *buf, *keypairs;
> +    char *p, *buf;
> +    QList *keypairs =3D NULL;
>      char *found_str;
> -    size_t max_keypair_size;
>=20
>      if (!strstart(filename, "rbd:", &start)) {
>          error_setg(errp, "File name must start with 'rbd:'");
>          return;
>      }
>=20
> -    max_keypair_size =3D strlen(start) + 1;
>      buf =3D g_strdup(start);
> -    keypairs =3D g_malloc0(max_keypair_size);
>      p =3D buf;
>=20
>      found_str =3D qemu_rbd_next_tok(p, '/', &p); @@ -194,33 +193,30 @@
> static void qemu_rbd_parse_filename(const char *filename, QDict *options,
>          } else if (!strcmp(name, "id")) {
>              qdict_put(options, "user" , qstring_from_str(value));
>          } else {
> -            /* FIXME: This is pretty ugly, and not the right way to do t=
his.
> -             *        These should be contained in a structure, and then
> -             *        passed explicitly as individual key/value pairs to
> -             *        rados.  Consider this legacy code that needs to be
> -             *        updated. */
> -            char *tmp =3D g_malloc0(max_keypair_size);
> -            /* only use a delimiter if it is not the first keypair found=
 */
> -            /* These are sets of unknown key/value pairs we'll pass alon=
g
> -             * to ceph */
> -            if (keypairs[0]) {
> -                snprintf(tmp, max_keypair_size, ":%s=3D%s", name, value)=
;
> -                pstrcat(keypairs, max_keypair_size, tmp);
> -            } else {
> -                snprintf(keypairs, max_keypair_size, "%s=3D%s", name, va=
lue);
> +            /*
> +             * We pass these internally to qemu_rbd_set_keypairs(), so
> +             * we can get away with the simpler list of [ "key1",
> +             * "value1", "key2", "value2" ] rather than a raw dict
> +             * { "key1": "value1", "key2": "value2" } where we can't
> +             * guarantee order, or even a more correct but complex
> +             * [ { "key1": "value1" }, { "key2": "value2" } ]
> +             */
> +            if (!keypairs) {
> +                keypairs =3D qlist_new();
>              }
> -            g_free(tmp);
> +            qlist_append(keypairs, qstring_from_str(name));
> +            qlist_append(keypairs, qstring_from_str(value));
>          }
>      }
>=20
> -    if (keypairs[0]) {
> -        qdict_put(options, "=3Dkeyvalue-pairs", qstring_from_str(keypair=
s));
> +    if (keypairs) {
> +        qdict_put(options, "=3Dkeyvalue-pairs",
> +                  qobject_to_json(QOBJECT(keypairs)));
>      }
>=20
> -
>  done:
>      g_free(buf);
> -    g_free(keypairs);
> +    QDECREF(keypairs);
>      return;
>  }
>=20
> @@ -244,36 +240,41 @@ static int qemu_rbd_set_auth(rados_t cluster,
> const char *secretid,
>      return 0;
>  }
>=20
> -static int qemu_rbd_set_keypairs(rados_t cluster, const char *keypairs,
> +static int qemu_rbd_set_keypairs(rados_t cluster, const char
> +*keypairs_json,
>                                   Error **errp)  {
> -    char *p, *buf;
> -    char *name;
> -    char *value;
> +    QList *keypairs;
> +    QString *name;
> +    QString *value;
> +    const char *key;
> +    size_t remaining;
>      int ret =3D 0;
>=20
> -    buf =3D g_strdup(keypairs);
> -    p =3D buf;
> +    if (!keypairs_json) {
> +        return ret;
> +    }
> +    keypairs =3D qobject_to_qlist(qobject_from_json(keypairs_json,
> +                                                  &error_abort));
> +    remaining =3D qlist_size(keypairs) / 2;
> +    assert(remaining);
>=20
> -    while (p) {
> -        name =3D qemu_rbd_next_tok(p, '=3D', &p);
> -        if (!p) {
> -            error_setg(errp, "conf option %s has no value", name);
> -            ret =3D -EINVAL;
> -            break;
> -        }
> +    while (remaining--) {
> +        name =3D qobject_to_qstring(qlist_pop(keypairs));
> +        value =3D qobject_to_qstring(qlist_pop(keypairs));
> +        assert(name && value);
> +        key =3D qstring_get_str(name);
>=20
> -        value =3D qemu_rbd_next_tok(p, ':', &p);
> -
> -        ret =3D rados_conf_set(cluster, name, value);
> +        ret =3D rados_conf_set(cluster, key, qstring_get_str(value));
> +        QDECREF(name);
> +        QDECREF(value);
>          if (ret < 0) {
> -            error_setg_errno(errp, -ret, "invalid conf option %s", name)=
;
> +            error_setg_errno(errp, -ret, "invalid conf option %s",
> + key);
>              ret =3D -EINVAL;
>              break;
>          }
>      }
>=20
> -    g_free(buf);
> +    QDECREF(keypairs);
>      return ret;
>  }
>=20
> --
> 2.9.3
