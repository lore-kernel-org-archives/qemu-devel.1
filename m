Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16844C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 13:36:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C61CD20728
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 13:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f9E6RiFj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C61CD20728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZE2h-00070E-1C
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 09:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jZE24-0006F9-7g
 for qemu-devel@nongnu.org; Thu, 14 May 2020 09:36:16 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49251
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jZE23-0003lt-AW
 for qemu-devel@nongnu.org; Thu, 14 May 2020 09:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589463374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sr2AeTSiwgGSM0v1XJSZnUq5IzqAzZMH6aSidx+7EjQ=;
 b=f9E6RiFj67mQyKSfQ0Vh0o0FdxmVaHM0xU/sPPqgqSRRjK+eaoKH/MjbRERPO+Zarn/W6p
 D+Wua4r58QMreXmKp+1UIdiL6gWIVWXddANPfCCQtPs8qGDRvYm5dqBsTrXwCVuom38CTk
 EHROQiPzEgo8GdBCOrONZF5DeNvqFUg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-bfQPnKCpNAOYaW-dkLwgzA-1; Thu, 14 May 2020 09:36:10 -0400
X-MC-Unique: bfQPnKCpNAOYaW-dkLwgzA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8ACAB461;
 Thu, 14 May 2020 13:36:09 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-212.ams2.redhat.com
 [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D25135C1D3;
 Thu, 14 May 2020 13:36:07 +0000 (UTC)
Subject: Re: [PATCH v6 05/14] block/amend: refactor qcow2 amend options
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20200510134037.18487-1-mlevitsk@redhat.com>
 <20200510134037.18487-6-mlevitsk@redhat.com>
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
Message-ID: <0a7e43b3-0404-92f4-feb0-389275791a7e@redhat.com>
Date: Thu, 14 May 2020 15:36:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200510134037.18487-6-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IS4nxCjI9EucduxQuMSMBQhqGNTwgFtAi"
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
--IS4nxCjI9EucduxQuMSMBQhqGNTwgFtAi
Content-Type: multipart/mixed; boundary="vfTlCPrzri55IolvQ3yEFawrjVSdLI29F"

--vfTlCPrzri55IolvQ3yEFawrjVSdLI29F
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.05.20 15:40, Maxim Levitsky wrote:
> Some qcow2 create options can't be used for amend.
> Remove them from the qcow2 create options and add generic logic to detect
> such options in qemu-img
>=20
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  block/qcow2.c              | 108 ++++++---------------
>  qemu-img.c                 |  18 +++-
>  tests/qemu-iotests/049.out | 102 ++++++++++----------
>  tests/qemu-iotests/061.out |  12 ++-
>  tests/qemu-iotests/079.out |  18 ++--
>  tests/qemu-iotests/082.out | 149 ++++------------------------
>  tests/qemu-iotests/085.out |  38 ++++----
>  tests/qemu-iotests/087.out |   6 +-
>  tests/qemu-iotests/115.out |   2 +-
>  tests/qemu-iotests/121.out |   4 +-
>  tests/qemu-iotests/125.out | 192 ++++++++++++++++++-------------------
>  tests/qemu-iotests/134.out |   2 +-
>  tests/qemu-iotests/144.out |   4 +-
>  tests/qemu-iotests/158.out |   4 +-
>  tests/qemu-iotests/182.out |   2 +-
>  tests/qemu-iotests/185.out |   8 +-
>  tests/qemu-iotests/188.out |   2 +-
>  tests/qemu-iotests/189.out |   4 +-
>  tests/qemu-iotests/198.out |   4 +-
>  tests/qemu-iotests/243.out |  16 ++--
>  tests/qemu-iotests/250.out |   2 +-
>  tests/qemu-iotests/255.out |   8 +-
>  tests/qemu-iotests/259.out |   2 +-
>  tests/qemu-iotests/263.out |   4 +-
>  tests/qemu-iotests/280.out |   2 +-

These reference output hunks need some rebasing due to the new
compression_type option.

>  25 files changed, 284 insertions(+), 429 deletions(-)
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index fc494c7591..db86500839 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c

[...]

> @@ -5552,37 +5506,6 @@ void qcow2_signal_corruption(BlockDriverState *bs,=
 bool fatal, int64_t offset,
>          .help =3D "The external data file must stay valid "           \
>                  "as a raw image"                                    \
>      },                                                              \
> -    {                                                               \
> -        .name =3D BLOCK_OPT_ENCRYPT,                                  \
> -        .type =3D QEMU_OPT_BOOL,                                      \
> -        .help =3D "Encrypt the image with format 'aes'. (Deprecated " \
> -                "in favor of " BLOCK_OPT_ENCRYPT_FORMAT "=3Daes)",    \
> -    },                                                              \
> -    {                                                               \
> -        .name =3D BLOCK_OPT_ENCRYPT_FORMAT,                           \
> -        .type =3D QEMU_OPT_STRING,                                    \
> -        .help =3D "Encrypt the image, format choices: 'aes', 'luks'", \
> -    },                                                              \
> -    BLOCK_CRYPTO_OPT_DEF_KEY_SECRET("encrypt.",                     \
> -        "ID of secret providing qcow AES key or LUKS passphrase"),  \
> -    BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_ALG("encrypt."),               \
> -    BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_MODE("encrypt."),              \
> -    BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_ALG("encrypt."),                \
> -    BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_HASH_ALG("encrypt."),           \
> -    BLOCK_CRYPTO_OPT_DEF_LUKS_HASH_ALG("encrypt."),                 \
> -    BLOCK_CRYPTO_OPT_DEF_LUKS_ITER_TIME("encrypt."),                \
> -    {                                                               \
> -        .name =3D BLOCK_OPT_CLUSTER_SIZE,                             \
> -        .type =3D QEMU_OPT_SIZE,                                      \
> -        .help =3D "qcow2 cluster size",                               \
> -        .def_value_str =3D stringify(DEFAULT_CLUSTER_SIZE)            \
> -    },                                                              \
> -    {                                                               \
> -        .name =3D BLOCK_OPT_PREALLOC,                                 \
> -        .type =3D QEMU_OPT_STRING,                                    \
> -        .help =3D "Preallocation mode (allowed values: off, "         \
> -                "metadata, falloc, full)"                           \
> -    },                                                              \
>      {                                                               \
>          .name =3D BLOCK_OPT_LAZY_REFCOUNTS,                           \
>          .type =3D QEMU_OPT_BOOL,                                      \
> @@ -5600,6 +5523,37 @@ static QemuOptsList qcow2_create_opts =3D {
>      .name =3D "qcow2-create-opts",
>      .head =3D QTAILQ_HEAD_INITIALIZER(qcow2_create_opts.head),
>      .desc =3D {
> +        {                                                               =
\
> +            .name =3D BLOCK_OPT_ENCRYPT,                                =
  \
> +            .type =3D QEMU_OPT_BOOL,                                    =
  \
> +            .help =3D "Encrypt the image with format 'aes'. (Deprecated =
" \
> +                    "in favor of " BLOCK_OPT_ENCRYPT_FORMAT "=3Daes)",  =
  \
> +        },                                                              =
\
> +        {                                                               =
\
> +            .name =3D BLOCK_OPT_ENCRYPT_FORMAT,                         =
  \
> +            .type =3D QEMU_OPT_STRING,                                  =
  \
> +            .help =3D "Encrypt the image, format choices: 'aes', 'luks'"=
, \
> +        },                                                              =
\
> +        BLOCK_CRYPTO_OPT_DEF_KEY_SECRET("encrypt.",                     =
\
> +            "ID of secret providing qcow AES key or LUKS passphrase"),  =
\
> +        BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_ALG("encrypt."),               =
\
> +        BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_MODE("encrypt."),              =
\
> +        BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_ALG("encrypt."),                =
\
> +        BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_HASH_ALG("encrypt."),           =
\
> +        BLOCK_CRYPTO_OPT_DEF_LUKS_HASH_ALG("encrypt."),                 =
\
> +        BLOCK_CRYPTO_OPT_DEF_LUKS_ITER_TIME("encrypt."),                =
\
> +        {                                                               =
\
> +            .name =3D BLOCK_OPT_CLUSTER_SIZE,                           =
  \
> +            .type =3D QEMU_OPT_SIZE,                                    =
  \
> +            .help =3D "qcow2 cluster size",                             =
  \
> +            .def_value_str =3D stringify(DEFAULT_CLUSTER_SIZE)          =
  \
> +        },                                                              =
\
> +        {                                                               =
\
> +            .name =3D BLOCK_OPT_PREALLOC,                               =
  \
> +            .type =3D QEMU_OPT_STRING,                                  =
  \
> +            .help =3D "Preallocation mode (allowed values: off, "       =
  \
> +                    "metadata, falloc, full)"                           =
\
> +        },                                                              =
\

compression_type should now be moved as well.

>          QCOW_COMMON_OPTIONS,
>          { /* end of list */ }
>      }
> diff --git a/qemu-img.c b/qemu-img.c
> index 8f69366f03..b291081249 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -3939,9 +3939,8 @@ static int print_amend_option_help(const char *form=
at)
>      /* Every driver supporting amendment must have amend_opts */
>      assert(drv->amend_opts);
> =20
> -    printf("Creation options for '%s':\n", format);
> +    printf("Amend options for '%s':\n", format);
>      qemu_opts_print_help(drv->amend_opts, false);
> -    printf("\nNote that not all of these options may be amendable.\n");
>      return 0;

Hm, this hunk would make more sense in the previous patch, but in
practice it=E2=80=99s better here, because it=E2=80=99s only in this patch =
that
amend_opts is actually limited (compared to create_opts).

>  }
> =20
> @@ -4087,7 +4086,22 @@ static int img_amend(int argc, char **argv)
>      amend_opts =3D qemu_opts_append(amend_opts, bs->drv->amend_opts);
>      opts =3D qemu_opts_create(amend_opts, NULL, 0, &error_abort);
>      qemu_opts_do_parse(opts, options, NULL, &err);
> +
>      if (err) {
> +        /* Try to parse options using the create options*/

Missing a space before the closing asterisk.

> +        Error *err1 =3D NULL;
> +        amend_opts =3D qemu_opts_append(amend_opts, bs->drv->create_opts=
);
> +        qemu_opts_del(opts);
> +        opts =3D qemu_opts_create(amend_opts, NULL, 0, &error_abort);
> +        qemu_opts_do_parse(opts, options, NULL, &err1);
> +
> +        if (!err1) {
> +            error_append_hint(&err,
> +                              "This option is only supported for image c=
reation\n");
> +        } else {
> +            error_free(err1);
> +        }

I=E2=80=99m not sure whether this is really that helpful, but, well, why no=
t,
now that you=E2=80=99ve already written the code for it.

Max

> +
>          error_report_err(err);
>          ret =3D -1;
>          goto out


--vfTlCPrzri55IolvQ3yEFawrjVSdLI29F--

--IS4nxCjI9EucduxQuMSMBQhqGNTwgFtAi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl69SUYACgkQ9AfbAGHV
z0B7vggAwCPOuvjHZrQC7yWReCGRM9u7gFtjprUQlg+NV8g3eGM+hOc1etRlox7P
W5rgkaqG6BpxRnl0eA3Wmhz8phely6XxojVkJCkJDT+okFGFGKWRvjU8/WQ7jfaR
/lX6L9xWvcxbqfaPt+xMK8aIHtVeq4gjmJJJAHA69HqX11oho0qpTMwVOkB9t802
cXa2UxmH4uHWTqGHOmbz0NrWw8HzlfZLUcsnNl94sTJwYyNMg9Iz1tSBXwcOcXWf
ZtREfF889NLFHg3+BQOgtBlKuiCF7EGsgkfouLOleFgvoowlS1rOvFKeWQAu0dqr
xDlZ+YbngQ+iJ7d/bTNyqk8bvxLcVQ==
=5ti7
-----END PGP SIGNATURE-----

--IS4nxCjI9EucduxQuMSMBQhqGNTwgFtAi--


