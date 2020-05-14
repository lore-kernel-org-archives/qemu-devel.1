Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2939C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 15:48:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D3E120657
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 15:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+xPDJ8D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D3E120657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZG68-0003fs-Jy
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 11:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jZG5R-00031M-Pr
 for qemu-devel@nongnu.org; Thu, 14 May 2020 11:47:53 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50341
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jZG5Q-00072L-EL
 for qemu-devel@nongnu.org; Thu, 14 May 2020 11:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589471270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+GM31E/W1LMw9+MEVVteanYLCdv6gyEqhf4YCJ6mykI=;
 b=D+xPDJ8DD4EMeUmD9CZsRzkkonJkltj+lzD3vIhIUwhglyDS58VrsWIoy2NGCsomAv7Vys
 sROEpoy3Ikts/HtdD3x7SbuZXWX73Qf0cFEZr01hQOltfJFxJoskCqrJutgjgjP/bvqHdx
 F1ejf4Ks6b3tYlO4FNNy/xYT2dZTMHI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-m-BCsTKDPJOPgpE6YuadBA-1; Thu, 14 May 2020 11:47:48 -0400
X-MC-Unique: m-BCsTKDPJOPgpE6YuadBA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E18C107B7C7;
 Thu, 14 May 2020 15:47:47 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-212.ams2.redhat.com
 [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B66E881640;
 Thu, 14 May 2020 15:47:45 +0000 (UTC)
Subject: Re: [PATCH v6 11/14] block/core: add generic infrastructure for
 x-blockdev-amend qmp command
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20200510134037.18487-1-mlevitsk@redhat.com>
 <20200510134037.18487-12-mlevitsk@redhat.com>
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
Message-ID: <97dcdce3-bbbf-ab11-2b54-56e7d6ecaeba@redhat.com>
Date: Thu, 14 May 2020 17:47:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200510134037.18487-12-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="EKBt5NDfqbfxEUEmInyy8yZxlJWKjpDR9"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 11:41:05
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
--EKBt5NDfqbfxEUEmInyy8yZxlJWKjpDR9
Content-Type: multipart/mixed; boundary="g0HDDnYiUnkjco6itgd2UQxBflYhhjvyj"

--g0HDDnYiUnkjco6itgd2UQxBflYhhjvyj
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.05.20 15:40, Maxim Levitsky wrote:
> blockdev-amend will be used similiar to blockdev-create
> to allow on the fly changes of the structure of the format based block de=
vices.
>=20
> Current plan is to first support encryption keyslot management for luks
> based formats (raw and embedded in qcow2)
>=20
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  block/Makefile.objs       |   2 +-
>  block/amend.c             | 108 ++++++++++++++++++++++++++++++++++++++
>  include/block/block_int.h |  21 +++++---
>  qapi/block-core.json      |  42 +++++++++++++++
>  qapi/job.json             |   4 +-
>  5 files changed, 169 insertions(+), 8 deletions(-)
>  create mode 100644 block/amend.c

[...]

> diff --git a/block/amend.c b/block/amend.c
> new file mode 100644
> index 0000000000..4840c0ffef
> --- /dev/null
> +++ b/block/amend.c

[...]

> +void qmp_x_blockdev_amend(const char *job_id,
> +                          const char *node_name,
> +                          BlockdevAmendOptions *options,
> +                          bool has_force,
> +                          bool force,
> +                          Error **errp)
> +{
> +    BlockdevAmendJob *s;
> +    const char *fmt =3D BlockdevDriver_str(options->driver);
> +    BlockDriver *drv =3D bdrv_find_format(fmt);
> +    BlockDriverState *bs =3D bdrv_find_node(node_name);
> +
> +    /*
> +     * If the driver is in the schema, we know that it exists.

I wonder why create.c then still checks whether drv =3D=3D NULL.

I wouldn=E2=80=99t count on the schema.  For example, with modularized bloc=
k
driver I could imagine that a driver appears in the schema, but loading
the module fails, so that drv still ends up NULL.

>         But it may not
> +     * be whitelisted.
> +     */
> +    assert(drv);
> +    if (bdrv_uses_whitelist() && !bdrv_is_whitelisted(drv, false)) {
> +        error_setg(errp, "Driver is not whitelisted");
> +        return;
> +    }

[...]

> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 0a71357b50..fdb0cdbcdd 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -133,12 +133,27 @@ struct BlockDriver {
>      int (*bdrv_file_open)(BlockDriverState *bs, QDict *options, int flag=
s,
>                            Error **errp);
>      void (*bdrv_close)(BlockDriverState *bs);
> +
> +
>      int coroutine_fn (*bdrv_co_create)(BlockdevCreateOptions *opts,
>                                         Error **errp);
>      int coroutine_fn (*bdrv_co_create_opts)(BlockDriver *drv,
>                                              const char *filename,
>                                              QemuOpts *opts,
>                                              Error **errp);
> +
> +    int coroutine_fn (*bdrv_co_amend)(BlockDriverState *bs,
> +                                      BlockdevAmendOptions *opts,
> +                                      bool force,
> +                                      Error **errp);
> +
> +    int (*bdrv_amend_options)(BlockDriverState *bs,
> +                              QemuOpts *opts,
> +                              BlockDriverAmendStatusCB *status_cb,
> +                              void *cb_opaque,
> +                              bool force,
> +                              Error **errp);
> +
>      int (*bdrv_make_empty)(BlockDriverState *bs);
> =20
>      /*
> @@ -433,12 +448,6 @@ struct BlockDriver {
>                                        BdrvCheckResult *result,
>                                        BdrvCheckMode fix);
> =20
> -    int (*bdrv_amend_options)(BlockDriverState *bs, QemuOpts *opts,
> -                              BlockDriverAmendStatusCB *status_cb,
> -                              void *cb_opaque,
> -                              bool force,
> -                              Error **errp);
> -

No harm done, but why not just leave it where it was?

>      void (*bdrv_debug_event)(BlockDriverState *bs, BlkdebugEvent event);
> =20
>      /* TODO Better pass a option string/QDict/QemuOpts to add any rule? =
*/
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 943df1926a..74db515414 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -4649,6 +4649,48 @@
>    'data': { 'job-id': 'str',
>              'options': 'BlockdevCreateOptions' } }
> =20
> +##
> +# @BlockdevAmendOptions:
> +#
> +# Options for amending an image format
> +#
> +# @driver           block driver that is suitable for the image

Missing colon after @driver.  Also, what does =E2=80=9Csuitable=E2=80=9D me=
an?
Shouldn=E2=80=99t it be exactly the node=E2=80=99s driver?  (i.e. =E2=80=9C=
Block driver of the
node to amend=E2=80=9D)

Max


--g0HDDnYiUnkjco6itgd2UQxBflYhhjvyj--

--EKBt5NDfqbfxEUEmInyy8yZxlJWKjpDR9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl69aCAACgkQ9AfbAGHV
z0Cl3Af+IMoG6sXQ2uiLZgXhlPIPdvonZFDrpYOT/TXLrcu6AhbzqyegkhxZYNYT
v1X2YXzt4sKuzrW3V8VJ7qjCPUhVLqLbD4WScNndB2igQWonfmwOzYNXnZV3aDJv
LFOvaqT18IIIulU5aCYAtaARLp27oLB3R9PP97GsckZ62WIll0IQNIE3IZdhbs+3
3VrRoQm+pFAimxXP6OU+ZEgpk5rYr64mh6yoDVx83lIYDQnHSTlqwgoMHLYk0HUb
D/gBNkJwzYV2ywTuGyvLF9CKDu/bjreUIr6sxbNWxrM0xd444z/qVkV8fWr5J4n+
AlWjpDM4ExKWJB3Ea6fren2uJMIAhw==
=jQ2f
-----END PGP SIGNATURE-----

--EKBt5NDfqbfxEUEmInyy8yZxlJWKjpDR9--


