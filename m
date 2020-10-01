Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBFBC4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:07:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B14720897
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ge9X3fvY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B14720897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO22x-0000Lm-Hu
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 13:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kO1xE-0003Od-Mb
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:01:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36688)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kO1xA-0000ef-Gt
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:01:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601571671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lNSWFvZMJjifO4EqMIQwqBxWDH5IV2r+y6KBFajrAPY=;
 b=Ge9X3fvYgBzRwQX6MREXYapnXC/wPD+2mNEZc8rPicJO9cIy25Q9oLUy+YCZKhgRWwePQx
 bG+Xe9oVsSsMNhifLFzjov0+4J8QSJahCx6CqynHe9gIR1UG9Z1EBdU6CCXP2GmhUZdJXs
 1zTKJ6BBXZ2GgT9/fiaq/rROwzpH7NI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-VKTH9ESbN0OipgpMGMQysA-1; Thu, 01 Oct 2020 13:01:08 -0400
X-MC-Unique: VKTH9ESbN0OipgpMGMQysA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 990538030B2;
 Thu,  1 Oct 2020 17:01:07 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-181.ams2.redhat.com
 [10.36.113.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BFD6D60BF1;
 Thu,  1 Oct 2020 17:01:05 +0000 (UTC)
Subject: Re: [PATCH qemu 2/4] drive-mirror: add support for conditional and
 always bitmap sync modes
To: =?UTF-8?Q?Fabian_Gr=c3=bcnbichler?= <f.gruenbichler@proxmox.com>,
 qemu-devel@nongnu.org
References: <20200922091418.53562-1-f.gruenbichler@proxmox.com>
 <20200922091418.53562-3-f.gruenbichler@proxmox.com>
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
Message-ID: <5af05c55-3e19-23d6-ee87-554090b56310@redhat.com>
Date: Thu, 1 Oct 2020 19:01:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200922091418.53562-3-f.gruenbichler@proxmox.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Yy7of82k8dEpLvSacSAw8O8nMHPntnceU"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 04:25:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.26, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Yy7of82k8dEpLvSacSAw8O8nMHPntnceU
Content-Type: multipart/mixed; boundary="W4YVaReRUeudxjwb8FI3NxaKNuNsXICHG"

--W4YVaReRUeudxjwb8FI3NxaKNuNsXICHG
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22.09.20 11:14, Fabian Gr=C3=BCnbichler wrote:
> From: John Snow <jsnow@redhat.com>
>=20
> Teach mirror two new tricks for using bitmaps:
>=20
> Always: no matter what, we synchronize the copy_bitmap back to the
> sync_bitmap. In effect, this allows us resume a failed mirror at a later
> date, since the target bdrv should be exactly in the state referenced by
> the bitmap.
>=20
> Conditional: On success only, we sync the bitmap. This is akin to
> incremental backup modes; we can use this bitmap to later refresh a
> successfully created mirror, or possibly re-try the whole failed mirror
> if we are able to rollback the target to the state before starting the
> mirror.
>=20
> Based on original work by John Snow.
>=20
> Signed-off-by: Fabian Gr=C3=BCnbichler <f.gruenbichler@proxmox.com>
> ---
>  block/mirror.c | 28 ++++++++++++++++++++--------
>  blockdev.c     |  3 +++
>  2 files changed, 23 insertions(+), 8 deletions(-)
>=20
> diff --git a/block/mirror.c b/block/mirror.c
> index d64c8203ef..bc4f4563d9 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c

[...]

> @@ -1781,8 +1793,8 @@ static BlockJob *mirror_start_job(
>      }
> =20
>      if (s->sync_mode =3D=3D MIRROR_SYNC_MODE_BITMAP) {
> -        bdrv_merge_dirty_bitmap(s->dirty_bitmap, s->sync_bitmap,
> -                                NULL, &local_err);
> +        bdrv_dirty_bitmap_merge_internal(s->dirty_bitmap, s->sync_bitmap=
,
> +                                         NULL, true);

(Sorry for not catching it in the previous version, but) this hunk needs
to go into patch 1, doesn=E2=80=99t it?

Or, rather...  Do we need it at all?  Is there anything that would
prohibit just moving this merge call to before the set_busy call?
(Which again is probably something that should be done in patch 1.)

(If you decide to keep calling *_internal, I think it would be nice to
add a comment above the call stating why we have to use *_internal here
(because the sync bitmap is busy now), and why it=E2=80=99s safe to do so
(because blockdev.c and/or mirror_start_job() have already checked the
bitmap).  But if it=E2=80=99s possible to do the merge before marking the
sync_bitmap busy, we probably should rather do that.)

>          if (local_err) {
>              goto fail;
>          }
> diff --git a/blockdev.c b/blockdev.c
> index 6baa1a33f5..0fd30a392d 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -3019,6 +3019,9 @@ static void blockdev_mirror_common(const char *job_=
id, BlockDriverState *bs,
>          if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_ALLOW_RO, errp))=
 {
>              return;
>          }
> +    } else if (has_bitmap_mode) {
> +        error_setg(errp, "Cannot specify bitmap sync mode without a bitm=
ap");
> +        return;
>      }

This too I would move into patch 1.

Max


--W4YVaReRUeudxjwb8FI3NxaKNuNsXICHG--

--Yy7of82k8dEpLvSacSAw8O8nMHPntnceU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl92C1AACgkQ9AfbAGHV
z0Ciuwf+J3rytUL5WKCV7NClejw23j71CjK0WRV8WzcLmMg2RzZzAkLdR32H0VzW
aU+9CjKXHIVP/lfV3nLU8Pz/WaWpWDe+t34b9lVaAnihYi1ENx4Fl31Z44pngJT9
dw2H0NTlNuNtotj1JscKCbPEZtPXgViRW8vI9mp59x0c0tKjj1u5k2xc0kZp8QnH
drjRn2KRCD6RzghMLRzfHXDXZpOqybgfTY+Tikgt4iR45oMlSmhLWlADbqrkOsO9
iCw5Nty+BOM3cIe/zqDyAyun5SqeFr7hfYqzruKcSJt4rEb4qtmUZJXbhYOk5uc7
UM4bnJFQbexQbjRjYMC9phUYO/eHwg==
=5rwq
-----END PGP SIGNATURE-----

--Yy7of82k8dEpLvSacSAw8O8nMHPntnceU--


