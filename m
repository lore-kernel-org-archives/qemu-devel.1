Received: from eggs.gnu.org ([2001:4830:134:3::10]:35659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dfoO8-00040O-Kx
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 10:24:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dfoO7-0004EW-8b
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 10:24:40 -0400
Date: Thu, 10 Aug 2017 17:23:51 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170810142351.r2b64siu2slkcegn@postretch>
References: <20170809100734.17540-1-el13635@mail.ntua.gr>
	<20170809100734.17540-6-el13635@mail.ntua.gr>
	<w511sojy1dx.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cvqrupdzpybhfeat"
Content-Disposition: inline
In-Reply-To: <w511sojy1dx.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [PATCH v4 5/7] block: add throttle block filter
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>


--cvqrupdzpybhfeat
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2017 at 03:54:02PM +0200, Alberto Garcia wrote:
>On Wed 09 Aug 2017 12:07:32 PM CEST, Manos Pitsidianakis wrote:
>> +/* Extract ThrottleConfig options. Assumes cfg is initialized and will =
be
>> + * checked for validity.
>> + *
>> + * Returns -1 and sets errp if a burst_length value is over UINT_MAX.
>> + */
>> +static int throttle_extract_options(QemuOpts *opts, ThrottleConfig *cfg,
>> +                                    Error **errp)
>> +{
>> +#define IF_OPT_SET(rvalue, opt_name) \
>> +    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX opt_name)) { \
>> +        rvalue =3D qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX opt_na=
me, 0); }
>> +
>> +    IF_OPT_SET(cfg->buckets[THROTTLE_BPS_TOTAL].avg, QEMU_OPT_BPS_TOTAL=
);
>> +    IF_OPT_SET(cfg->buckets[THROTTLE_BPS_READ].avg, QEMU_OPT_BPS_READ);
>> +    IF_OPT_SET(cfg->buckets[THROTTLE_BPS_WRITE].avg, QEMU_OPT_BPS_WRITE=
);
>> +    IF_OPT_SET(cfg->buckets[THROTTLE_OPS_TOTAL].avg, QEMU_OPT_IOPS_TOTA=
L);
>> +    IF_OPT_SET(cfg->buckets[THROTTLE_OPS_READ].avg, QEMU_OPT_IOPS_READ);
>> +    IF_OPT_SET(cfg->buckets[THROTTLE_OPS_WRITE].avg, QEMU_OPT_IOPS_WRIT=
E);
>> +    IF_OPT_SET(cfg->buckets[THROTTLE_BPS_TOTAL].max, QEMU_OPT_BPS_TOTAL=
_MAX);
>  [...]
>
>This is all the code that I was saying that we'd save if we don't allow
>setting limits here.
>
>> +static int throttle_configure_tgm(BlockDriverState *bs,
>> +                                  ThrottleGroupMember *tgm,
>> +                                  QDict *options, Error **errp)
>> +{
>> +    int ret;
>> +    ThrottleConfig cfg;
>> +    const char *group_name =3D NULL;
>
>No need to set it to NULL here.

I know, I do it out of habit!

>
>> +    Error *local_err =3D NULL;
>> +    QemuOpts *opts =3D qemu_opts_create(&throttle_opts, NULL, 0,=20
>> &error_abort);
>> +
>> +    qemu_opts_absorb_qdict(opts, options, &local_err);
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +        goto err;
>> +    }
>> +
>> +    /* If group_name is NULL, an anonymous group will be created */
>> +    group_name =3D qemu_opt_get(opts, QEMU_OPT_THROTTLE_GROUP_NAME);
>> +
>> +    /* Register membership to group with name group_name */
>> +    throttle_group_register_tgm(tgm, group_name, bdrv_get_aio_context(b=
s));
>> +
>> +    /* Copy previous configuration */
>> +    throttle_group_get_config(tgm, &cfg);
>> +
>> +    /* Change limits if user has specified them */
>> +    if (throttle_extract_options(opts, &cfg, errp) ||
>> +        !throttle_is_valid(&cfg, errp)) {
>> +        throttle_group_unregister_tgm(tgm);
>> +        goto err;
>> +    }
>> +    /* Update group configuration */
>> +    throttle_group_config(tgm, &cfg);
>
>We'd also spare this, and this function would remain much simpler.
>
>> +
>> +    ret =3D 0;
>> +    goto fin;
>> +
>> +err:
>> +    ret =3D -EINVAL;
>> +fin:
>> +    qemu_opts_del(opts);
>> +    return ret;
>> +}
>
>If you set ret =3D -EINVAL before calling goto err you can simplify this
>part as well, but feel free to ignore this suggestion.
>
>> +static int throttle_reopen_prepare(BDRVReopenState *reopen_state,
>> +                                   BlockReopenQueue *queue, Error **err=
p)
>> +{
>> +    ThrottleGroupMember *tgm =3D NULL;
>> +
>> +    assert(reopen_state !=3D NULL);
>> +    assert(reopen_state->bs !=3D NULL);
>> +
>> +    reopen_state->opaque =3D g_new0(ThrottleGroupMember, 1);
>> +    tgm =3D reopen_state->opaque;
>> +
>> +    return throttle_configure_tgm(reopen_state->bs, tgm, reopen_state->=
options,
>> +            errp);
>> +}
>
>I would rename 'reopen_state' as 'state' for consistency with the other
>two functions.

The function signatures in block_int.h have reopen_state, so maybe for=20
consistency I should change the other two to reopen_state as well,=20
instead.

>
>> +static void throttle_reopen_commit(BDRVReopenState *state)
>> +{
>> +    ThrottleGroupMember *tgm =3D state->bs->opaque;
>> +
>> +    throttle_group_unregister_tgm(tgm);
>> +    g_free(state->bs->opaque);
>> +    state->bs->opaque =3D state->opaque;
>> +    state->opaque =3D NULL;
>> +}
>
>I also find the mixing of state->bs->opaque and tgm a bit confusing.
>Here's a suggestion, but feel free to ignore it:

You're right, though it's only a few lines it might require a second=20
read. I will rewrite those more clearly, too.

--cvqrupdzpybhfeat
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlmMbHcACgkQc2J8L2kN
9xBAaQ/8CEUy+5F8PvmdoZTD5VaOXUR/9nO3/1X2AJKuuVLwjOEymcMuFIQrdd1o
gimPByrm8kFQI26IokyJquFx2ZYj4QMrmYPxApsljDeAA6Ad+OXDZ4vuOAavUlTH
BUXB07CaZcmVmZObmD21NtBSJmzC0bWeBRek3gB7JOdw50Iub9RXZPBuLu2Dkx0Y
y1so6H1F8TUHDfoZkvmpsaIdPCYlSM55GeLh/Fzj6PueEj+XqioIzqv2EUHsCoIm
FWxBPWDMJo/C6WnYPtfIAsa3WS4SXrQQ1uIU5bNkMMxa/bpp+cHQKnqOseONAU4x
C+1mq4sSVvX7H8hfVRYl3eKEiy2YoE2SzX6P6eJ7wXencvOyJd6IlhwxtxV372j2
e9mtvJDoNhACCKEKfJGpj0UdP6q72yDZB9l7q6Zk9C9c1Kysf9ES9jLhLee4R1Ob
STB/D6/wxxGUsxQEUQuizKV9tmlbA0bcRpB/DKDccM/xMyATttIjTOisVWCPpDcM
BDssLMAz600futskC5DhSg/0Ul0WYwMkSbwIV+tC8+2PwMaZ3eJwNEogJToOs7wg
RzSXifpiJeiv22ZB8xzkEwntqk8gmDHp8mL06hPNyaQ+uniWPIDibDYiGwTID3PO
bOpukw8IQ8rMkvuic/q09lZ9DVE7bqAES3MULI6HMjcIsmCzuIE=
=ibjK
-----END PGP SIGNATURE-----

--cvqrupdzpybhfeat--
