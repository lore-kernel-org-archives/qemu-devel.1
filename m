Received: from eggs.gnu.org ([2001:4830:134:3::10]:56891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cbS3k-0006Zw-M7
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 08:13:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cbS3g-0002LB-98
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 08:13:20 -0500
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
	<20170203154757.36140-12-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <11389742-4861-eb11-422d-4dd19fdaf57c@redhat.com>
Date: Wed, 8 Feb 2017 07:13:01 -0600
MIME-Version: 1.0
In-Reply-To: <20170203154757.36140-12-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QDutftdAF0kV1gs7TK6ipViLpfxhAAH3u"
Subject: Re: [Qemu-devel] [PATCH 11/18] nbd: BLOCK_STATUS for bitmap export:
 server part
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, armbru@redhat.com, den@virtuozzo.com, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QDutftdAF0kV1gs7TK6ipViLpfxhAAH3u
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com,
 pbonzini@redhat.com, armbru@redhat.com, den@virtuozzo.com,
 stefanha@redhat.com
Message-ID: <11389742-4861-eb11-422d-4dd19fdaf57c@redhat.com>
Subject: Re: [PATCH 11/18] nbd: BLOCK_STATUS for bitmap export: server part
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
 <20170203154757.36140-12-vsementsov@virtuozzo.com>
In-Reply-To: <20170203154757.36140-12-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/03/2017 09:47 AM, Vladimir Sementsov-Ogievskiy wrote:
> Only one meta context type is defined: qemu-bitmap:<bitmap-name>.

Why 'qemu-bitmap:' instead of 'qemu:' for our namespace?  I guess it's
okay, though.

> Maximum one query is allowed for NBD_OPT_{SET,LIST}_META_CONTEXT,
> NBD_REP_ERR_TOO_BIG is returned otherwise.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

This is only a high-level review; I may come back and look more closely
at details (and compare against the proposed spec) when I have more time.=


>  /* Request flags, sent from client to server during transmission phase=
 */
>  #define NBD_CMD_FLAG_FUA        (1 << 0) /* 'force unit access' during=
 write */
> @@ -142,6 +155,7 @@ enum {
>      NBD_CMD_TRIM =3D 4,
>      /* 5 reserved for failed experiment NBD_CMD_CACHE */
>      NBD_CMD_WRITE_ZEROES =3D 6,
> +    NBD_CMD_BLOCK_STATUS =3D 7
>  };

Please keep the trailing comma (it makes it easier for later patches to
add new values without having to modify existing lines).

> =20
>  #define NBD_DEFAULT_PORT	10809
> @@ -163,6 +177,7 @@ enum {
>  #define NBD_REPLY_TYPE_NONE 0
>  #define NBD_REPLY_TYPE_OFFSET_DATA 1
>  #define NBD_REPLY_TYPE_OFFSET_HOLE 2
> +#define NBD_REPLY_TYPE_BLOCK_STATUS 5
>  #define NBD_REPLY_TYPE_ERROR ((1 << 15) + 1)
>  #define NBD_REPLY_TYPE_ERROR_OFFSET ((1 << 15) + 2)

Might be worth formatting these so that the definitions all start in the
same column (if so, it affects an earlier patch in the series as well).

> =20
> diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
> index 3284bfc85a..fbbcf69925 100644
> --- a/nbd/nbd-internal.h
> +++ b/nbd/nbd-internal.h
> @@ -83,6 +83,10 @@
>  #define NBD_OPT_PEEK_EXPORT     (4)
>  #define NBD_OPT_STARTTLS        (5)
>  #define NBD_OPT_STRUCTURED_REPLY (8)
> +#define NBD_OPT_LIST_META_CONTEXT (9)
> +#define NBD_OPT_SET_META_CONTEXT  (10)
> +
> +#define NBD_META_NS_BITMAPS "qemu-dirty-bitmap"

I still find it odd that we've split our #defines across two different
headers, not your fault.

This name does not match your commit message.  Why can't we use just
'qemu:' as our namespace?

> =20
>  /* NBD errors are based on errno numbers, so there is a 1:1 mapping,
>   * but only a limited set of errno values is specified in the protocol=
=2E
> @@ -105,6 +109,8 @@ static inline const char *nbd_opt_name(int opt)
>      case NBD_OPT_PEEK_EXPORT: return "peek_export";
>      case NBD_OPT_STARTTLS: return "tls";
>      case NBD_OPT_STRUCTURED_REPLY: return "structured_reply";
> +    case NBD_OPT_LIST_META_CONTEXT: return "list_meta_context";
> +    case NBD_OPT_SET_META_CONTEXT: return "set_meta_context";

Same question as earlier as to whether this violates checkpatch
formatting, and whether it belongs in a .c instead of inline in the heade=
r.

>=20
> =20
> +static int nbd_negotiate_read_size_string(QIOChannel *ioc, char **str,=

> +                                          uint32_t max_len)

I probably would have split the creation of this helper function into
its own patch.  Also, can it be utilized in any of the existing code, or
is the new code the only client?

> +
> +/* start handle LIST_META_CONTEXT and SET_META_CONTEXT requests
> + * @opt          should be NBD_OPT_LIST_META_CONTEXT or NBD_OPT_SET_ME=
TA_CONTEXT
> + * @length       related option data to read
> + * @nb_queries   out parameter, number of queries specified by client
> + * @bs           out parameter, bs for export, selected by client
> + *               will be zero if some not critical error occured and e=
rror reply
> + *               was sent.

Wrong spelling of 'occurred', and awkward grammar.  How about:

will be zero if an error reply is successfully sent

> + *
> + * Returns:
> + *   Err. code < 0 on critical error

s/Err./Error/

> + *   Number of bytes read otherwise (will be equal to length on non cr=
itical
> + *     error or if there no queries in request)

will be equal to length if there were no errors, or no queries in the
request

> + */
> +static int nbd_negotiate_opt_meta_context_start(NBDClient *client, uin=
t32_t opt,
> +                                                uint32_t length,
> +                                                uint32_t *nb_queries,
> +                                                BlockDriverState **bs)=

> +{
> +    int ret;
> +    NBDExport *exp;
> +    char *export_name;

Uninitialized...[1]

> +    int nb_read =3D 0;
> +
> +    if (!client->structured_reply) {
> +        uint32_t tail =3D length - nb_read;
> +        LOG("Structured reply is not negotiated");

This LOG() is redundant...[2]

> +
> +        if (nbd_negotiate_drop_sync(client->ioc, tail) !=3D tail) {
> +            return -EIO;
> +        }
> +        ret =3D nbd_negotiate_send_rep_err(client->ioc, NBD_REP_ERR_IN=
VALID, opt,
> +                                         "Structured reply is not nego=
tiated");

[2]...because this function also calls LOG().

> +        g_free(export_name);

[1]...so this crashes.  Oops.

> +
> +        if (ret < 0) {
> +            return ret;
> +        } else {
> +            *bs =3D NULL;
> +            *nb_queries =3D 0;
> +            return length;
> +        }
> +    }
> +


> +static int nbd_negotiate_set_meta_context(NBDClient *client, uint32_t =
length)
> +{
> +    int ret;
> +    BlockDriverState *bs;
> +    uint32_t nb_queries;
> +    int nb_read;
> +
> +    nb_read =3D nbd_negotiate_opt_meta_context_start(client,
> +                                                   NBD_OPT_SET_META_CO=
NTEXT,
> +                                                   length, &nb_queries=
, &bs);
> +    if (nb_read < 0) {
> +        return nb_read;
> +    }
> +    if (bs =3D=3D NULL) {
> +        /* error reply was already sent by nbd_negotiate_opt_meta_cont=
ext_start
> +         * */
> +        return 0;
> +    }
> +
> +    if (nb_queries =3D=3D 0) {
> +        return nbd_negotiate_send_rep(client->ioc, NBD_REP_ACK,
> +                                      NBD_OPT_SET_META_CONTEXT);
> +    }
> +
> +    if (nb_queries > 1) {
> +        return nbd_negotiate_send_rep_err(client->ioc, NBD_REP_ERR_TOO=
_BIG,
> +                                          NBD_OPT_SET_META_CONTEXT,
> +                                          "Only one exporting context =
is"
> +                                          "supported");

Why only one? What's wrong with supporting both 'qemu:xyz' (the dirty
bitmap, with whatever prefix name we actually settle on) and
'base:allocation' at the same time?


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--QDutftdAF0kV1gs7TK6ipViLpfxhAAH3u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYmxldAAoJEKeha0olJ0Nq2kcH/0FEWpNR1rjhWHvLryIj5tHi
cSrcD9dfqeCH5yBAebAA9Wa/5zGqvO5dmjqsS/zgfPEAVMgrskugTQc5pXp/WSaT
rwge9kLSztOR79/sJD1P8lKqTpgPbBKz82xsDmKjpdmSkDXumPa8t6xzOTnwnkpw
tu7quJhzEBdFMh9q2zMqHnQq8/8DIg64XRUOCeZpNkjfVFt5VrUC6bocmn2yRqu7
Qa9zxwlAo+wvpXcqhE8YOL5P4cXsFQiIh6r8xIzvTSISOsfXC8Q0dtbcmFb7nJgS
5IEhMwGtrG+Df+sJFsgSb6lZ4oqKIvC54y/ZHnDKdar+S6g8GWMvBkE+YFwnJLo=
=r0Yr
-----END PGP SIGNATURE-----

--QDutftdAF0kV1gs7TK6ipViLpfxhAAH3u--
