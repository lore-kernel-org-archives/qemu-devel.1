Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BC5C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:02:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F422E207EA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AwOVtTpU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F422E207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDW90-00011p-VK
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 13:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kDW82-0008EN-1r
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:00:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26705
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kDW7z-0000AC-3U
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:00:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599066052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ejwMIFaELkBtdvRSmBTpC7oO/6xFIQUSltBww4B/4zk=;
 b=AwOVtTpU6LSsxyW57HgVLLT9j1AQKQ0RzFzK0XKxpWjsiQzoiceKILWY4ViPoEFHzaL2MC
 wtMy/Ha5YtN8+Vx5AP3FtzuoYAVUgF5KUhEI5mX3GNvCZYGnzpmAquUnP10txaGhqa4mFn
 6JVNKktPPwhx54i9GVmkmMGnpILV0hY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-hde8rhUEMQaqcSBFP6eoZA-1; Wed, 02 Sep 2020 13:00:50 -0400
X-MC-Unique: hde8rhUEMQaqcSBFP6eoZA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C199C801AB1;
 Wed,  2 Sep 2020 17:00:48 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-169.ams2.redhat.com
 [10.36.114.169])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A30F31002D46;
 Wed,  2 Sep 2020 17:00:47 +0000 (UTC)
Subject: Re: [PATCH 2/3] mirror: Freeze backing chain for sync=top
To: qemu-block@nongnu.org
References: <20200902164841.214948-1-mreitz@redhat.com>
 <20200902164841.214948-3-mreitz@redhat.com>
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
Message-ID: <b6346698-4cb5-2c6d-678e-140039a6e687@redhat.com>
Date: Wed, 2 Sep 2020 19:00:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200902164841.214948-3-mreitz@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="e8rj89eHdlRqf2GpkTRutZ3bZvCyRENrK"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.324, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--e8rj89eHdlRqf2GpkTRutZ3bZvCyRENrK
Content-Type: multipart/mixed; boundary="8EUf70wzf2eZaItyEa1h0dIj1hyHrIorG"

--8EUf70wzf2eZaItyEa1h0dIj1hyHrIorG
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 02.09.20 18:48, Max Reitz wrote:
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/mirror.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>=20
> diff --git a/block/mirror.c b/block/mirror.c
> index 11ebffdf99..27422ab7a5 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -649,8 +649,8 @@ static int mirror_exit_common(Job *job)
>      src =3D mirror_top_bs->backing->bs;
>      target_bs =3D blk_bs(s->target);
> =20
> -    if (bdrv_chain_contains(src, target_bs)) {
> -        bdrv_unfreeze_backing_chain(mirror_top_bs, target_bs);
> +    if (s->base) {
> +        bdrv_unfreeze_backing_chain(mirror_top_bs, s->base);
>      }
> =20
>      bdrv_release_dirty_bitmap(s->dirty_bitmap);
> @@ -1780,8 +1780,22 @@ static BlockJob *mirror_start_job(
>                  goto fail;
>              }
>          }
> +    }
> +
> +    if (s->base) {
> +        /*
> +         * For active commit or mirror with sync=3Dtop, we need to
> +         * freeze the backing chain down to the base, because we keep
> +         * pointers to it and its overlay.  For other cases (mirror
> +         * with sync=3Dfull or sync=3Dnone), we do not, so there is no
> +         * need to freeze any part of the chain.
> +         * (s->base is non-NULL only in these cases.)
> +         */
> +        if (target_is_backing) {
> +            assert(s->base =3D=3D target);
> +        }

On second thought, this assertion doesn=E2=80=99t hold true when mirroring =
to an
image in the backing chain (i.e., specifically not using commit).  Now,
this mostly doesn=E2=80=99t work thanks to op blockers, but after =E2=80=9C=
Deal with
filters=E2=80=9D, it=E2=80=99s possible.  I don=E2=80=99t know whether it p=
roduces any sensible
results, though.

Should we leave it possible, or should we make mirroring to a node in
the backing chain (i.e. target_is_backing && s->base !=3D target) an error?

Max

> =20
> -        if (bdrv_freeze_backing_chain(mirror_top_bs, target, errp) < 0) =
{
> +        if (bdrv_freeze_backing_chain(mirror_top_bs, s->base, errp) < 0)=
 {
>              goto fail;
>          }
>      }
>=20



--8EUf70wzf2eZaItyEa1h0dIj1hyHrIorG--

--e8rj89eHdlRqf2GpkTRutZ3bZvCyRENrK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9Pz74ACgkQ9AfbAGHV
z0C/uQf+PLkVKsncJVyQdOx/YXi0ahtK6S8asjYdvqVoZQELh75V0vsLhtCbgMcf
n4ax+H+l94ol69AN+uPcaOOE1sjGn02Hp6y9DeXmtTNC+c5g1oWz/Kb1aHirQnqC
YXXyxHGlP97/h7DQr1FoCBDFbVC6aC99ZF21rpr+/J+pQvGvu3QwfHJZZRD3o51T
SKN4fZeyxRUE6O2F2BgWVLGNWix8sbJegiLwHYk3KeKp+wSov840nGEEZ6ksRv4G
Qo4uKcijqLRLmPK+BHRdIPV8vo5+J2R5zSTMzB5XlgxN9+xtj1RVvtudMAFOHgT1
GQlxKkWlKpbo15T5We8DB8ZgHsNNZw==
=MCzZ
-----END PGP SIGNATURE-----

--e8rj89eHdlRqf2GpkTRutZ3bZvCyRENrK--


