Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E0CC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 14:29:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B28A22220C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 14:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XHzQ0CTV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B28A22220C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLSFT-0006F4-5z
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 10:29:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kLSC5-0003Gb-6X
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 10:25:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46724)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kLSC3-0003ml-23
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 10:25:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600957551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5VyxZBXk5hzV+N7pNnzNWk6ydGAOofakdPPpivKK78I=;
 b=XHzQ0CTVH/CDnE7eoJcj5P/rY66ORh5MuTmthHdozpDm7ceGVtOXPtK0LFnUCqNPoKcYv0
 EMVS70yrcBXxEh8iqk0rZYtD1E7dfZuElDRzm76O+dt426/2ml0lPP4drIWm8QUbcoMwLX
 zucI4BNPV7s1D61rWk+MDDBoE3jyoio=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-_2jfNxU1OX2prOUrIqZD1g-1; Thu, 24 Sep 2020 10:25:49 -0400
X-MC-Unique: _2jfNxU1OX2prOUrIqZD1g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D626E6408A;
 Thu, 24 Sep 2020 14:25:47 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-153.ams2.redhat.com
 [10.36.114.153])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AC28C19746;
 Thu, 24 Sep 2020 14:25:42 +0000 (UTC)
Subject: Re: [PATCH v6 07/15] block: bdrv_check_perm(): process children anyway
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200918181951.21752-1-vsementsov@virtuozzo.com>
 <20200918181951.21752-8-vsementsov@virtuozzo.com>
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
Message-ID: <b75e87f4-2db6-8c39-aa00-d5c77c9b5dcb@redhat.com>
Date: Thu, 24 Sep 2020 16:25:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200918181951.21752-8-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jc0zKWamn4d7MhyOyVRak4AgjRfdUgS1V"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jc0zKWamn4d7MhyOyVRak4AgjRfdUgS1V
Content-Type: multipart/mixed; boundary="EkgGb4LXzx9EXAZ1yh9eoJa6rPB9LmIF0"

--EkgGb4LXzx9EXAZ1yh9eoJa6rPB9LmIF0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 18.09.20 20:19, Vladimir Sementsov-Ogievskiy wrote:
> Do generic processing even for drivers which define .bdrv_check_perm
> handler. It's needed for further preallocate filter: it will need to do
> additional action on bdrv_check_perm, but don't want to reimplement
> generic logic.
>=20
> The patch doesn't change existing behaviour: the only driver that
> implements bdrv_check_perm is file-posix, but it never has any
> children.
>=20
> Also, bdrv_set_perm() don't stop processing if driver has
> .bdrv_set_perm handler as well.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/block.c b/block.c
> index 9538af4884..165c2d3cb2 100644
> --- a/block.c
> +++ b/block.c
> @@ -1964,8 +1964,7 @@ static void bdrv_child_perm(BlockDriverState *bs, B=
lockDriverState *child_bs,
>  /*
>   * Check whether permissions on this node can be changed in a way that
>   * @cumulative_perms and @cumulative_shared_perms are the new cumulative
> - * permissions of all its parents. This involves checking whether all ne=
cessary
> - * permission changes to child nodes can be performed.
> + * permissions of all its parents.

Why do you want to remove this sentence?

>   *
>   * Will set *tighten_restrictions to true if and only if new permissions=
 have to
>   * be taken or currently shared permissions are to be unshared.  Otherwi=
se,
> @@ -2047,8 +2046,11 @@ static int bdrv_check_perm(BlockDriverState *bs, B=
lockReopenQueue *q,
>      }
> =20
>      if (drv->bdrv_check_perm) {
> -        return drv->bdrv_check_perm(bs, cumulative_perms,
> -                                    cumulative_shared_perms, errp);
> +        ret =3D drv->bdrv_check_perm(bs, cumulative_perms,
> +                                   cumulative_shared_perms, errp);
> +        if (ret < 0) {
> +            return ret;
> +        }
>      }

Sounds good.  It=E2=80=99s also consistent with how bdrv_abort_perm_update(=
) and
bdrv_set_perm() don=E2=80=99t return after calling the respective driver
functions, but always recurse to the children.

Max


--EkgGb4LXzx9EXAZ1yh9eoJa6rPB9LmIF0--

--jc0zKWamn4d7MhyOyVRak4AgjRfdUgS1V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9srGQACgkQ9AfbAGHV
z0AIZggAqL20+Ye1ThHo9NlJgs3w8qCg8K1/CfrAB7NomGsZOK/IzPaXVRaEZd07
uVdbpa2ih+kFsyJO937EB5oHyUcYexQkpHiLekUIoEdSd/z/awLutfUCO8P+Tydo
kogYuhylI099b9SBf+NkeESpMfivNtPFm1v1ujEihsRtxP/KDhciOtp6Ymflas4q
KUVCDT/SKlboTQoyyatXOiNCH2BVjy3hXDOuRuzU6T/IDQQYl4Qv54yzJB+ltXar
RzgvEjFRI4bzwivQ1nmw1wuTXYAsYzHaCjyM+BvbeZZwOPrSV722cx88vhtIR81T
jcQxnA5R5tBRcicRaNPucVp6OWgkCw==
=zUJN
-----END PGP SIGNATURE-----

--jc0zKWamn4d7MhyOyVRak4AgjRfdUgS1V--


