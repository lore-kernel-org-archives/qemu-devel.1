Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0B5C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:11:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF75F2070A
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S2nAO9HK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF75F2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZEaN-0003cq-Q7
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jZEYs-00022K-P4
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:10:10 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51573
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jZEYr-0002yl-R7
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:10:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589465408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1rj8+06UplazVqTFCZp6+r+oPJfk7BPeZXx1VzcJNdU=;
 b=S2nAO9HKp9cVA30Ou+uE9WaLGqGP06rsZqfupVakmvXNRBNjqh0efnyxhCZbcGJQAi6PzW
 uo19G/HLU7P6VmCxcdpDZAR2OrgBF4sZiNX+7FKk8Ac4ULZcblJPMqmx6kNY/EYSDeg0wa
 LZGwdJILvVE97Ch/0RYOvumSYYxHyCY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-FffAIb6bNKyM2il65H6Juw-1; Thu, 14 May 2020 10:10:06 -0400
X-MC-Unique: FffAIb6bNKyM2il65H6Juw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C794D189952C;
 Thu, 14 May 2020 14:10:05 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-212.ams2.redhat.com
 [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B2C55D97D;
 Thu, 14 May 2020 14:10:00 +0000 (UTC)
Subject: Re: [PATCH v6 07/14] block/crypto: implement the encryption key
 management
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20200510134037.18487-1-mlevitsk@redhat.com>
 <20200510134037.18487-8-mlevitsk@redhat.com>
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
Message-ID: <1413abb3-f226-5ecc-3ea9-3dd945a134ed@redhat.com>
Date: Thu, 14 May 2020 16:09:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200510134037.18487-8-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VeBzaOP9Qy98J36rukMKceReC1W1X0e5O"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
--VeBzaOP9Qy98J36rukMKceReC1W1X0e5O
Content-Type: multipart/mixed; boundary="8HYaUqdwt2ZUDoQyRh0D8AfCqvl0Nf5az"

--8HYaUqdwt2ZUDoQyRh0D8AfCqvl0Nf5az
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.05.20 15:40, Maxim Levitsky wrote:
> This implements the encryption key management using the generic code in
> qcrypto layer and exposes it to the user via qemu-img
>=20
> This code adds another 'write_func' because the initialization
> write_func works directly on the underlying file, and amend
> works on instance of luks device.
>=20
> This commit also adds a 'hack/workaround' I and Kevin Wolf (thanks)
> made to make the driver both support write sharing (to avoid breaking the=
 users),
> and be safe against concurrent  metadata update (the keyslots)
>=20
> Eventually the write sharing for luks driver will be deprecated
> and removed together with this hack.
>=20
> The hack is that we ask (as a format driver) for BLK_PERM_CONSISTENT_READ
> and then when we want to update the keys, we unshare that permission.
> So if someone else has the image open, even readonly, encryption
> key update will fail gracefully.
>=20
> Also thanks to Daniel Berrange for the idea of
> unsharing read, rather that write permission which allows
> to avoid cases when the other user had opened the image read-only.
>=20
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  block/crypto.c | 127 +++++++++++++++++++++++++++++++++++++++++++++++--
>  block/crypto.h |  34 +++++++++++++
>  2 files changed, 158 insertions(+), 3 deletions(-)
>=20
> diff --git a/block/crypto.c b/block/crypto.c
> index 2e16b62bdc..b14cb0ff06 100644
> --- a/block/crypto.c
> +++ b/block/crypto.c

[...]

> +static void
> +block_crypto_child_perms(BlockDriverState *bs, BdrvChild *c,
> +                         const BdrvChildRole *role,
> +                         BlockReopenQueue *reopen_queue,
> +                         uint64_t perm, uint64_t shared,
> +                         uint64_t *nperm, uint64_t *nshared)
> +{
> +
> +    BlockCrypto *crypto =3D bs->opaque;
> +
> +    bdrv_filter_default_perms(bs, c, role, reopen_queue,
> +            perm, shared, nperm, nshared);
> +    /*
> +     * Ask for consistent read permission so that if
> +     * someone else tries to open this image with this permission
> +     * neither will be able to edit encryption keys, since
> +     * we will unshare that permission while trying to
> +     * update the encryption keys
> +     */
> +    if (!(bs->open_flags & BDRV_O_NO_IO)) {
> +        *nperm |=3D BLK_PERM_CONSISTENT_READ;
> +    }

I=E2=80=99m not sure this is important, because this really means we won=E2=
=80=99t do
I/O.  Its only relevant use in this case is for qemu-img info.  Do we
really care if someone edits the key slots while qemu-img info is
processing?

OTOH, I don=E2=80=99t think it=E2=80=99ll harm much.  Well, apart from the =
fact that
BDRV_O_NO_IO won=E2=80=99t do much for LUKS images.

*shrug*

Reviewed-by: Max Reitz <mreitz@redhat.com>


--8HYaUqdwt2ZUDoQyRh0D8AfCqvl0Nf5az--

--VeBzaOP9Qy98J36rukMKceReC1W1X0e5O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl69UTcACgkQ9AfbAGHV
z0Ct9AgAl+DZriF2IbJmamqOFgHrrnYGfMmaAr0rUMSdY7q8LcDng8fqqnIscHRN
8gO9/lkxL1S30gKf9pZP0U9KBxf6mcxbcY4l1xHPR532BgjeBJKd3DuVA5+pXieP
kcAbQEsxHUghTQOoIXkDhnHJF2aehudvG0U4Se0CyNdKf9hEiepPzYVcf2CxXGWl
XVEN3jqRbltO8EQ23khWiOuHMUuzq48aliMKGcCFeU1ORbW/gUiN6YemvNWIvSKY
RLVYu9URME5uzqwvqjJdBebAU9Jmh6fXcwaknlzQ2VH2XzCj3YXr95mCEvshdY2k
yzdIf4Yfag8bBP+LvOk97ejAkAu31A==
=eLEb
-----END PGP SIGNATURE-----

--VeBzaOP9Qy98J36rukMKceReC1W1X0e5O--


