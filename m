Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13537C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 12:17:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7456206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 12:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cwq+DJJk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7456206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiGi4-00053L-1Y
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 08:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jiGgP-0003od-Ek
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 08:15:17 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43857
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jiGgN-0000Q3-5R
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 08:15:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591618513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YxOurBS07OngeBtIL9DRLlVk8y6uTChyJKXvizxDv9M=;
 b=cwq+DJJk+ChGdiFgSK7IkYZfcjwbuj9AGkRnjfXUcZjwFla5j4f7gHuhtfC3VgO12ylPDw
 tORZYafyy0AF9tCd5mgzRhMf09dqhIRZxbOeZ8B4M6w54UIMXvjmpRpbvYeih3ymZRzK7b
 aemGDjKtrPVOaBdWEEIC/fvzNhA9n30=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-4pZDZFRlN569b0GTcQJZkA-1; Mon, 08 Jun 2020 08:15:11 -0400
X-MC-Unique: 4pZDZFRlN569b0GTcQJZkA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8574783DE2D;
 Mon,  8 Jun 2020 12:15:10 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-71.ams2.redhat.com
 [10.36.113.71])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F9B25D9E4;
 Mon,  8 Jun 2020 12:14:58 +0000 (UTC)
Subject: Re: [PATCH v8 07/14] block/crypto: implement the encryption key
 management
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20200608094030.670121-1-mlevitsk@redhat.com>
 <20200608094030.670121-8-mlevitsk@redhat.com>
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
Message-ID: <99997649-bf06-f494-8dce-c12bb1d17b66@redhat.com>
Date: Mon, 8 Jun 2020 14:14:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200608094030.670121-8-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="EDzqjDfpv6hJfQwKHGZejbNJXt3jyC91c"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 05:40:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EDzqjDfpv6hJfQwKHGZejbNJXt3jyC91c
Content-Type: multipart/mixed; boundary="BU0844dVMH9FZDWQ6tRvXOPadETOenLDJ"

--BU0844dVMH9FZDWQ6tRvXOPadETOenLDJ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 08.06.20 11:40, Maxim Levitsky wrote:
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
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/crypto.c | 130 +++++++++++++++++++++++++++++++++++++++++++++++--
>  block/crypto.h |  34 +++++++++++++
>  2 files changed, 161 insertions(+), 3 deletions(-)
>=20
> diff --git a/block/crypto.c b/block/crypto.c
> index 1960b47ceb..b9c40e6922 100644
> --- a/block/crypto.c
> +++ b/block/crypto.c

[...]

> +static void
> +block_crypto_child_perms(BlockDriverState *bs, BdrvChild *c,
> +                         const BdrvChildRole role,

Well, it isn=E2=80=99t wrong to have this be a const, nor is it against any
coding guidelines.  While I do believe this was an accident, I also
think that in fact, maybe being strict about const-ness is what we
should=E2=80=99ve done everywhere from the start.

So this is not a complaint, quite the contrary.

(I felt it was interesting enough to warrant this mail.  *shrug*)

> +                         BlockReopenQueue *reopen_queue,
> +                         uint64_t perm, uint64_t shared,
> +                         uint64_t *nperm, uint64_t *nshared)
> +{
> +
> +    BlockCrypto *crypto =3D bs->opaque;
> +
> +    bdrv_default_perms(bs, c, role, reopen_queue, perm, shared, nperm, n=
shared);
> +
> +    /*
> +     * For backward compatibility, manually share the write
> +     * and resize permission
> +     */
> +    *nshared |=3D (BLK_PERM_WRITE | BLK_PERM_RESIZE);
> +    /*
> +     * Since we are not fully a format driver, don't always request
> +     * the read/resize permission but only when explicitly
> +     * requested
> +     */
> +    *nperm &=3D ~(BLK_PERM_WRITE | BLK_PERM_RESIZE);
> +    *nperm |=3D perm & (BLK_PERM_WRITE | BLK_PERM_RESIZE);

Looks good, thanks!

Max


--BU0844dVMH9FZDWQ6tRvXOPadETOenLDJ--

--EDzqjDfpv6hJfQwKHGZejbNJXt3jyC91c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl7eK8AACgkQ9AfbAGHV
z0D2pgf+O457HVajjTU8O1iH0Y8W1B24LMuhttj6iOmma2inYz4DBTDjpl8R8v5o
HDLq54O4koGo5FzHXfFB9jwz+LdYcCKIkBbzo6BCbWm1HI7oGDuEyQapknLmrmeD
lvV0xpOUQqCjDkUIIi5KF4g98re3lKgbLQ4PkIY9bg1qF9QvPgTFBP1HBhpbiiMz
5fqvtpOrSBV2A/lny8ifmiyOafejPjBdtXDgyCPqbkFxVxZsoKbxv+Yew+lifKNP
k5zdbMQ/nSn6nJN12RIwwUKujfFwB7Zfmuezr4pgwPYO3o91QnlOVX7juwXB994c
rKGfPiLz0mdRxjzYKUY/W2VKd3Ev6w==
=gIWt
-----END PGP SIGNATURE-----

--EDzqjDfpv6hJfQwKHGZejbNJXt3jyC91c--


