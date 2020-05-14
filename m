Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB41C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 11:58:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37EB020722
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 11:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="STAR01ZD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37EB020722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZCV6-00018H-Bs
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 07:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jZCU4-0008GN-2R
 for qemu-devel@nongnu.org; Thu, 14 May 2020 07:57:04 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35080
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jZCU3-0004YQ-6q
 for qemu-devel@nongnu.org; Thu, 14 May 2020 07:57:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589457421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tRd78uKeUApUZZ40K/dH7afnZkI4Z4oh15cb5Bfm/eA=;
 b=STAR01ZD8+mrrCiKqy4D41NRNCzAtbvYO1YJnhnB4PyzyM4h0IH1Ujcoa6cpiOzQE4xPQ1
 htgNaKCUhklLE+Zc6AXQhj0ckvfFa0Un6hWgMJKVJMBGiZpmV0wK+LkkzSX/7RhI58U1fS
 2aLM9SuERIyBVEaEa1wcHnuzKJ2JIoo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-MFvSV5ZIOpy3_pthQHKfYg-1; Thu, 14 May 2020 07:56:57 -0400
X-MC-Unique: MFvSV5ZIOpy3_pthQHKfYg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86E6B18FF660;
 Thu, 14 May 2020 11:56:56 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-212.ams2.redhat.com
 [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DDC3725262;
 Thu, 14 May 2020 11:56:51 +0000 (UTC)
Subject: Re: [PATCH v6 02/14] qcrypto/luks: implement encryption key management
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20200510134037.18487-1-mlevitsk@redhat.com>
 <20200510134037.18487-3-mlevitsk@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <48813eda-4fa9-6988-296d-58793e8b812f@redhat.com>
Date: Thu, 14 May 2020 13:56:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200510134037.18487-3-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZFTR1sPdKbp0IBeCpWDc1lA1gY9qNEQM3"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZFTR1sPdKbp0IBeCpWDc1lA1gY9qNEQM3
Content-Type: multipart/mixed; boundary="bY7VA3Y9wJI7oLWIRSoW7aVamfyeTD2Ma"

--bY7VA3Y9wJI7oLWIRSoW7aVamfyeTD2Ma
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.05.20 15:40, Maxim Levitsky wrote:
> Next few patches will expose that functionality to the user.
>=20
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  crypto/block-luks.c | 395 +++++++++++++++++++++++++++++++++++++++++++-
>  qapi/crypto.json    |  61 ++++++-
>  2 files changed, 452 insertions(+), 4 deletions(-)
>=20
> diff --git a/crypto/block-luks.c b/crypto/block-luks.c
> index 4861db810c..967d382882 100644
> --- a/crypto/block-luks.c
> +++ b/crypto/block-luks.c

[...]

> @@ -1069,6 +1076,119 @@ qcrypto_block_luks_find_key(QCryptoBlock *block,
>      return -1;
>  }
> =20
> +/*
> + * Returns true if a slot i is marked as active
> + * (contains encrypted copy of the master key)
> + */
> +static bool
> +qcrypto_block_luks_slot_active(const QCryptoBlockLUKS *luks,
> +                               unsigned int slot_idx)
> +{
> +    uint32_t val =3D luks->header.key_slots[slot_idx].active;
> +    return val =3D=3D  QCRYPTO_BLOCK_LUKS_KEY_SLOT_ENABLED;

One space too many after the =3D=3D.

[...]

> +/*
> + * Erases an keyslot given its index
> + * Returns:
> + *    0 if the keyslot was erased successfully
> + *   -1 if a error occurred while erasing the keyslot
> + *
> + */
> +static int
> +qcrypto_block_luks_erase_key(QCryptoBlock *block,
> +                             unsigned int slot_idx,
> +                             QCryptoBlockWriteFunc writefunc,
> +                             void *opaque,
> +                             Error **errp)
> +{
> +    QCryptoBlockLUKS *luks =3D block->opaque;
> +    QCryptoBlockLUKSKeySlot *slot =3D &luks->header.key_slots[slot_idx];
> +    g_autofree uint8_t *garbagesplitkey =3D NULL;
> +    size_t splitkeylen =3D luks->header.master_key_len * slot->stripes;

This accesses header.key_slots[slot_idx] before...

> +    size_t i;
> +    Error *local_err =3D NULL;
> +    int ret;
> +
> +    assert(slot_idx < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS);

...we assert that slot_idx is in bounds.

I suppose that=E2=80=99s kind of fine, because assertions aren=E2=80=99t me=
ant to fire
either, but this basically makes the assertion useless.

> +    assert(splitkeylen > 0);
> +    garbagesplitkey =3D g_new0(uint8_t, splitkeylen);
> +
> +    /* Reset the key slot header */
> +    memset(slot->salt, 0, QCRYPTO_BLOCK_LUKS_SALT_LEN);
> +    slot->iterations =3D 0;
> +    slot->active =3D QCRYPTO_BLOCK_LUKS_KEY_SLOT_DISABLED;
> +
> +    ret =3D qcrypto_block_luks_store_header(block,  writefunc,

Superfluous space after the comma.

> +                                          opaque, &local_err);
> +
> +    if (ret < 0) {
> +        error_propagate(errp, local_err);
> +    }

error_propagate() is a no-op with local_err =3D=3D NULL, so you could do
without checking @ret (just calling error_propagate() unconditionally).

(But who cares, we need to set @ret anyway, so we might as well check it.)

[...]

> +static int
> +qcrypto_block_luks_amend_add_keyslot(QCryptoBlock *block,
> +                                     QCryptoBlockReadFunc readfunc,
> +                                     QCryptoBlockWriteFunc writefunc,
> +                                     void *opaque,
> +                                     QCryptoBlockAmendOptionsLUKS *opts_=
luks,
> +                                     bool force,
> +                                     Error **errp)
> +{
> +    QCryptoBlockLUKS *luks =3D block->opaque;
> +    uint64_t iter_time =3D opts_luks->has_iter_time ?
> +                         opts_luks->iter_time :
> +                         QCRYPTO_BLOCK_LUKS_DEFAULT_ITER_TIME_MS;
> +    int keyslot;
> +    g_autofree char *old_password =3D NULL;
> +    g_autofree char *new_password =3D NULL;
> +    g_autofree uint8_t *master_key =3D NULL;

(I assume we don=E2=80=99t really care about purging secrets from memory af=
ter use)

[...]

> +static int
> +qcrypto_block_luks_amend_erase_keyslots(QCryptoBlock *block,
> +                                        QCryptoBlockReadFunc readfunc,
> +                                        QCryptoBlockWriteFunc writefunc,
> +                                        void *opaque,
> +                                        QCryptoBlockAmendOptionsLUKS *op=
ts_luks,
> +                                        bool force,
> +                                        Error **errp)
> +{

[...]

> +        for (i =3D 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
> +            int rv =3D qcrypto_block_luks_load_key(block,
> +                                                 i,
> +                                                 old_password,
> +                                                 tmpkey,
> +                                                 readfunc,
> +                                                 opaque,
> +                                                 errp);
> +            if (rv =3D=3D -1) {
> +                return -1;
> +            } else if (rv =3D=3D 1) {
> +                bitmap_set(&slots_to_erase_bitmap, i, 1);

We should assert that QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS <=3D
sizeof(slots_to_erase_bitmap) * 8.  As it is, this looks like a possible
out-of-bounds access on first glance.

[...]

> +static int
> +qcrypto_block_luks_amend_options(QCryptoBlock *block,
> +                                 QCryptoBlockReadFunc readfunc,
> +                                 QCryptoBlockWriteFunc writefunc,
> +                                 void *opaque,
> +                                 QCryptoBlockAmendOptions *options,
> +                                 bool force,
> +                                 Error **errp)
> +{
> +    QCryptoBlockAmendOptionsLUKS *opts_luks =3D &options->u.luks;
> +
> +    if (opts_luks->state =3D=3D Q_CRYPTO_BLOCKLUKS_KEYSLOT_STATE_ACTIVE)=
 {

switch { case } might be nicer to catch unhandled cases.  Or else if +
else { g_assert_not_reached() }.

> +        return qcrypto_block_luks_amend_add_keyslot(block, readfunc,
> +                                                    writefunc, opaque,
> +                                                    opts_luks, force, er=
rp);
> +    } else {
> +        return qcrypto_block_luks_amend_erase_keyslots(block, readfunc,
> +                                                       writefunc, opaque=
,
> +                                                       opts_luks, force,=
 errp);
> +    }
> +}

[...]

> diff --git a/qapi/crypto.json b/qapi/crypto.json
> index aeb6c7ef7b..29276e5e5e 100644
> --- a/qapi/crypto.json
> +++ b/qapi/crypto.json
> @@ -1,6 +1,8 @@
>  # -*- Mode: Python -*-
>  #
> =20
> +{ 'include': 'common.json' }
> +

Why?  Seems to compile without it just fine.

Max


--bY7VA3Y9wJI7oLWIRSoW7aVamfyeTD2Ma--

--ZFTR1sPdKbp0IBeCpWDc1lA1gY9qNEQM3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl69MgIACgkQ9AfbAGHV
z0B0BQf+JkXvO4MXKpOXtFk3GgQkogvzcCtfNtoCm0K/VBSYcD0CuUtawcp1HpHn
zbbRovYoCOMGoD9twMPV8/NIh1pdmfn0rSCmHZAAfXiNiukTPBPiSrSTcI8XX9Ct
u+YN7A4eL10u2EcPT4f7p4XOoxXPzbSZpebinBq7GqkxWmvXnfzzQkaQ+/FaQY5T
EBmLeh3xEP+Eo6jXY/fvX1O2dppmnerSWtTlYlnr3b/uLn6O66P5Yl6v4hIb/QFB
OqIiPybS58zp8Kjb9invVIdxp75LpQZ7sZKRyv803uyQvMiuoFIRKKXoPpruGpEG
ySJeVOqB9g7XxlNrm45TYrL9srbSyA==
=atZn
-----END PGP SIGNATURE-----

--ZFTR1sPdKbp0IBeCpWDc1lA1gY9qNEQM3--


