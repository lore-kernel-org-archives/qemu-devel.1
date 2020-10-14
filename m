Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303F2C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 15:19:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 908BC21582
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 15:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YxLLrczk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 908BC21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSiYx-0006z6-4q
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 11:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kSiId-0007C5-SN
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 11:02:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57877)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kSiIa-0001hG-4l
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 11:02:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602687757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DUZPcji+2mNoSCvfEXbfL3XMM5mOz1NhxRCiHC3mu2M=;
 b=YxLLrczkc+9LwehG12ZcpK8qibvalYwmGUUtvfQhc5utndhY1qZZxcS/OX/Lvntnj0vZw+
 DIJRFGzHHZW3aZmoJGr+EsOVbltkAXFPHPJZAod8BH066NJOtjsxDmCDWOU2W+P4YQWSsp
 +C9xr4p81l122PthPAno+ZIzYsjk5b0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-YzHlpxxYN3WHuj3uR8qiJQ-1; Wed, 14 Oct 2020 11:02:32 -0400
X-MC-Unique: YzHlpxxYN3WHuj3uR8qiJQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91D661074645;
 Wed, 14 Oct 2020 15:02:30 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.194.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DAE2A5C1C2;
 Wed, 14 Oct 2020 15:02:17 +0000 (UTC)
Subject: Re: [PATCH v11 10/13] stream: skip filters when writing backing file
 name to QCOW2 header
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1602524605-481160-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1602524605-481160-11-git-send-email-andrey.shinkevich@virtuozzo.com>
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
Message-ID: <582fb55d-0d3f-8a16-2134-67d73643da9e@redhat.com>
Date: Wed, 14 Oct 2020 17:02:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1602524605-481160-11-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1ZY81lurmwkk1FVXysZFDJQI6lH1OLAho"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 03:37:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 libvir-list@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanha@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1ZY81lurmwkk1FVXysZFDJQI6lH1OLAho
Content-Type: multipart/mixed; boundary="sF3mM3Ysw8QqWFouSMZ9UTIN0coM7Ajni"

--sF3mM3Ysw8QqWFouSMZ9UTIN0coM7Ajni
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12.10.20 19:43, Andrey Shinkevich wrote:
> Avoid writing a filter JSON-name to QCOW2 image when the backing file
> is changed after the block stream job.
>=20
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>  block/stream.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/block/stream.c b/block/stream.c
> index e0540ee..51462bd 100644
> --- a/block/stream.c
> +++ b/block/stream.c
> @@ -65,6 +65,7 @@ static int stream_prepare(Job *job)
>      BlockDriverState *bs =3D blk_bs(bjob->blk);
>      BlockDriverState *unfiltered_bs =3D bdrv_skip_filters(bs);
>      BlockDriverState *base =3D bdrv_filter_or_cow_bs(s->above_base);
> +    BlockDriverState *base_unfiltered =3D bdrv_skip_filters(base);
>      Error *local_err =3D NULL;
>      int ret =3D 0;
> =20
> @@ -73,10 +74,10 @@ static int stream_prepare(Job *job)
> =20
>      if (bdrv_cow_child(unfiltered_bs)) {
>          const char *base_id =3D NULL, *base_fmt =3D NULL;
> -        if (base) {
> -            base_id =3D s->backing_file_str;
> -            if (base->drv) {
> -                base_fmt =3D base->drv->format_name;
> +        if (base_unfiltered) {
> +            base_id =3D base_unfiltered->filename;

I think you have to leave this querying s->backing_file_str, and instead
change how qmp_block_stream() gets @base_name.  block-stream has a
backing-file parameter that can override the string that should be used
here.

(Or perhaps you can let qmp_block_stream() just set it to NULL if no
backing-file parameter is passed and then fall back to
base_unfiltered->filename only here.  Probably better, actually, in case
base_unfiltered is changed during the job run.)

Max

> +            if (base_unfiltered->drv) {
> +                base_fmt =3D base_unfiltered->drv->format_name;
>              }
>          }
>          bdrv_set_backing_hd(unfiltered_bs, base, &local_err);
>=20



--sF3mM3Ysw8QqWFouSMZ9UTIN0coM7Ajni--

--1ZY81lurmwkk1FVXysZFDJQI6lH1OLAho
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl+HEvcACgkQ9AfbAGHV
z0AQZwf/f5jmGA4hKTLG/ykQLUl4OpviWzsNZb9o1Qbj+no8v7I1B4sNTXriTmiY
O4Tx9vdv1jVm4rRISs2hGe0CYIKVUXj26Wm+nt1NTx+sZHkR8m/14nu1ZOXzX/1L
ve0BWtu0PAVuiFt1wQq/MuwZqE1LMSkhY8UbDwnhgE+3qyReezLDNgRFJlE7qF/g
AxUgZGG6hGXTqcJDN81bg1X0VJ1Ehukarni8+JfAvudRnoYfIr1fmeMyTrS56Wlk
RLzZ2mqLe8aDScVzDo5Vr3Lmlgx0jo3mgFq3+UAoRZeqEP7eIZVYEz45KceHEBxB
YEvcxFSsw1IuEAxQIhINlyf5yB59hQ==
=i6oY
-----END PGP SIGNATURE-----

--1ZY81lurmwkk1FVXysZFDJQI6lH1OLAho--


