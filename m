Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF61C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 12:33:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AE96206DA
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 12:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YCoG8Y+m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE96206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZD3Q-0007Zy-8n
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 08:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jZCyp-00024A-Kq
 for qemu-devel@nongnu.org; Thu, 14 May 2020 08:28:51 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41986
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jZCyo-0004q5-LZ
 for qemu-devel@nongnu.org; Thu, 14 May 2020 08:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589459329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3mmQ/CNN8DBONTLFVMwYKkm2g3/YzkaRMN3p/1JjmKk=;
 b=YCoG8Y+mnMzemaE08iNZ5Xrv+N/YzyCfAVKuCLlNjXtyPA1Cu55hNFKDO+aXhoLeuyhLM3
 dnYTwK1FbCFt3ahWlgD0kgIPiNS2YEw5zpUM4HSYu2wJiLhJ1ms461THQZrbWC8R3B7XPf
 /WfIfWGUTvJeiPWCb74qm6pIxprpB20=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-qCJKmc4AM_Ows1fRX9yGrw-1; Thu, 14 May 2020 08:28:45 -0400
X-MC-Unique: qCJKmc4AM_Ows1fRX9yGrw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C25FE9116E;
 Thu, 14 May 2020 12:28:44 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-212.ams2.redhat.com
 [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C929476E64;
 Thu, 14 May 2020 12:28:42 +0000 (UTC)
Subject: Re: [PATCH v6 04/14] block/amend: separate amend and create options
 for qemu-img
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20200510134037.18487-1-mlevitsk@redhat.com>
 <20200510134037.18487-5-mlevitsk@redhat.com>
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
Message-ID: <5b389390-eadb-e1d6-48f8-be99c2dfad99@redhat.com>
Date: Thu, 14 May 2020 14:28:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200510134037.18487-5-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UnF82G6PhjA5bBlEpBD7sT2TMo5oLmH9n"
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
--UnF82G6PhjA5bBlEpBD7sT2TMo5oLmH9n
Content-Type: multipart/mixed; boundary="mB1gQNLQDrfwjdukDV7MR1s9tKdSTZh5f"

--mB1gQNLQDrfwjdukDV7MR1s9tKdSTZh5f
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.05.20 15:40, Maxim Levitsky wrote:
> Some options are only useful for creation
> (or hard to be amended, like cluster size for qcow2), while some other
> options are only useful for amend, like upcoming keyslot management
> options for luks
>=20
> Since currently only qcow2 supports amend, move all its options
> to a common macro and then include it in each action option list.
>=20
> In future it might be useful to remove some options which are
> not supported anyway from amend list, which currently
> cause an error message if amended.
>=20
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  block/qcow2.c             | 160 +++++++++++++++++++++-----------------
>  include/block/block_int.h |   4 +
>  qemu-img.c                |  18 ++---
>  3 files changed, 100 insertions(+), 82 deletions(-)
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 79fbad9d76..fc494c7591 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -5520,83 +5520,96 @@ void qcow2_signal_corruption(BlockDriverState *bs=
, bool fatal, int64_t offset,
>      s->signaled_corruption =3D true;
>  }
> =20
> +#define QCOW_COMMON_OPTIONS                                         \
> +    {                                                               \
> +        .name =3D BLOCK_OPT_SIZE,                                     \
> +        .type =3D QEMU_OPT_SIZE,                                      \
> +        .help =3D "Virtual disk size"                                 \
> +    },                                                              \
> +    {                                                               \
> +        .name =3D BLOCK_OPT_COMPAT_LEVEL,                             \
> +        .type =3D QEMU_OPT_STRING,                                    \
> +        .help =3D "Compatibility level (v2 [0.10] or v3 [1.1])"       \
> +    },                                                              \
> +    {                                                               \
> +        .name =3D BLOCK_OPT_BACKING_FILE,                             \
> +        .type =3D QEMU_OPT_STRING,                                    \
> +        .help =3D "File name of a base image"                         \
> +    },                                                              \
> +    {                                                               \
> +        .name =3D BLOCK_OPT_BACKING_FMT,                              \
> +        .type =3D QEMU_OPT_STRING,                                    \
> +        .help =3D "Image format of the base image"                    \
> +    },                                                              \
> +    {                                                               \
> +        .name =3D BLOCK_OPT_DATA_FILE,                                \
> +        .type =3D QEMU_OPT_STRING,                                    \
> +        .help =3D "File name of an external data file"                \
> +    },                                                              \
> +    {                                                               \
> +        .name =3D BLOCK_OPT_DATA_FILE_RAW,                            \
> +        .type =3D QEMU_OPT_BOOL,                                      \
> +        .help =3D "The external data file must stay valid "           \
> +                "as a raw image"                                    \
> +    },                                                              \
> +    {                                                               \
> +        .name =3D BLOCK_OPT_ENCRYPT,                                  \
> +        .type =3D QEMU_OPT_BOOL,                                      \
> +        .help =3D "Encrypt the image with format 'aes'. (Deprecated " \
> +                "in favor of " BLOCK_OPT_ENCRYPT_FORMAT "=3Daes)",    \
> +    },                                                              \
> +    {                                                               \
> +        .name =3D BLOCK_OPT_ENCRYPT_FORMAT,                           \
> +        .type =3D QEMU_OPT_STRING,                                    \
> +        .help =3D "Encrypt the image, format choices: 'aes', 'luks'", \
> +    },                                                              \
> +    BLOCK_CRYPTO_OPT_DEF_KEY_SECRET("encrypt.",                     \
> +        "ID of secret providing qcow AES key or LUKS passphrase"),  \
> +    BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_ALG("encrypt."),               \
> +    BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_MODE("encrypt."),              \
> +    BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_ALG("encrypt."),                \
> +    BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_HASH_ALG("encrypt."),           \
> +    BLOCK_CRYPTO_OPT_DEF_LUKS_HASH_ALG("encrypt."),                 \
> +    BLOCK_CRYPTO_OPT_DEF_LUKS_ITER_TIME("encrypt."),                \
> +    {                                                               \
> +        .name =3D BLOCK_OPT_CLUSTER_SIZE,                             \
> +        .type =3D QEMU_OPT_SIZE,                                      \
> +        .help =3D "qcow2 cluster size",                               \
> +        .def_value_str =3D stringify(DEFAULT_CLUSTER_SIZE)            \
> +    },                                                              \
> +    {                                                               \
> +        .name =3D BLOCK_OPT_PREALLOC,                                 \
> +        .type =3D QEMU_OPT_STRING,                                    \
> +        .help =3D "Preallocation mode (allowed values: off, "         \
> +                "metadata, falloc, full)"                           \
> +    },                                                              \
> +    {                                                               \
> +        .name =3D BLOCK_OPT_LAZY_REFCOUNTS,                           \
> +        .type =3D QEMU_OPT_BOOL,                                      \
> +        .help =3D "Postpone refcount updates",                        \
> +        .def_value_str =3D "off"                                      \
> +    },                                                              \
> +    {                                                               \
> +        .name =3D BLOCK_OPT_REFCOUNT_BITS,                            \
> +        .type =3D QEMU_OPT_NUMBER,                                    \
> +        .help =3D "Width of a reference count entry in bits",         \
> +        .def_value_str =3D "16"                                       \
> +    }                                                               \

I think the last line should have a comma in it (otherwise the final
backslash doesn=E2=80=99t make much sense, because whenever we=E2=80=99d ad=
d a new
option, we would need to modify the line anyway to insert a comma).

Speaking of adding option, this requires a rebase due to the
compression_type option added (not trivial in the strict sense, but
still straightforward to handle).

> +
>  static QemuOptsList qcow2_create_opts =3D {
>      .name =3D "qcow2-create-opts",
>      .head =3D QTAILQ_HEAD_INITIALIZER(qcow2_create_opts.head),
>      .desc =3D {
>

[...]

> +        QCOW_COMMON_OPTIONS,
> +        { /* end of list */ }
> +    }
> +};
> +
> +static QemuOptsList qcow2_amend_opts =3D {
> +    .name =3D "qcow2-amend-opts",
> +    .head =3D QTAILQ_HEAD_INITIALIZER(qcow2_amend_opts.head),
> +    .desc =3D {
> +        QCOW_COMMON_OPTIONS,
>          { /* end of list */ }

If QCOW_COMMON_OPTIONS were to already end in a comma (which I think it
should), then it would become superfluous here.

>      }
>  };

[...]

> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 952b2f033a..0a71357b50 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -412,6 +412,10 @@ struct BlockDriver {
> =20
>      /* List of options for creating images, terminated by name =3D=3D NU=
LL */
>      QemuOptsList *create_opts;
> +
> +    /* List of options for image amend*/

I don=E2=80=99t suppose we have a coding style requirement for this, but I =
still
think there should be a space before the closing asterisk.

With those things fixed:

Reviewed-by: Max Reitz <mreitz@redhat.com>

> +    QemuOptsList *amend_opts;
> +


--mB1gQNLQDrfwjdukDV7MR1s9tKdSTZh5f--

--UnF82G6PhjA5bBlEpBD7sT2TMo5oLmH9n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl69OXkACgkQ9AfbAGHV
z0DXNgf/X4zLaCdsB4kE8jO0+h3flI3vDZ/KOSBxvDxwHkJ/tbg4RMcDPg5RMZiM
zNGgL/UYsJqHrQKgdC6uBuMWwXFi8Guj41PeF3LUbC/A6ii2Oojd6rSInYnTDrfA
cITqRfovPXuIrDlgzd5QUHywj1CpDWHv5Svufo+QFYD9MqigSV5EZljA6T3HgmbE
4EvSwn5niHwoZK9eGvvkKvuuL9UnGFJq1LPxeBGkAK1af59Pb/jM+0orstVi7+U6
PUIMyAQUXQHBPiAD4uXtJx6XjgPS6S+Y05PjvC9CHnM4GBDnhAW6FKQ5Er63vvWA
hayPCxv3Mymi7Sw6KswcbPGmTjQ8zQ==
=hCn8
-----END PGP SIGNATURE-----

--UnF82G6PhjA5bBlEpBD7sT2TMo5oLmH9n--


