Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF8EC54E4B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 09:29:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9CE9221F7
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 09:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fLO0krVO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9CE9221F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWcqo-0001f1-RH
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 05:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jWcpw-0000k1-JC
 for qemu-devel@nongnu.org; Thu, 07 May 2020 05:29:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48332
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jWcpu-0004gr-2Q
 for qemu-devel@nongnu.org; Thu, 07 May 2020 05:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588843736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=v0NcA2CgeNHB+EgUSP209mkMYGbbkcrknixYKV8jRC4=;
 b=fLO0krVOtGE5NQP7Wd5Ei2V+2I5uTmcuMmnyjkPL8+jNBjyYApG6r6h2z6DtuId+1XsJj5
 to+GZHB1SiUHPbE6AF0IH4rS3Yb9kg95dvYBPFRrJkg4tjIqbu2kFYs3GEqDLdTLkZZb7M
 cLYhQHmF5do336SjwZxKsXL1aG9s2m8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-Ed5t7DKKMfeBH5e4wXuxvw-1; Thu, 07 May 2020 05:28:54 -0400
X-MC-Unique: Ed5t7DKKMfeBH5e4wXuxvw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D949980183C;
 Thu,  7 May 2020 09:28:53 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-92.ams2.redhat.com
 [10.36.114.92])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A41E5D9C5;
 Thu,  7 May 2020 09:28:52 +0000 (UTC)
Subject: Re: [PATCH v3 22/33] block: Make backing files child_of_bds children
To: Kevin Wolf <kwolf@redhat.com>
References: <20200218124242.584644-1-mreitz@redhat.com>
 <20200218124242.584644-23-mreitz@redhat.com>
 <20200506163722.GH6333@linux.fritz.box>
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
Message-ID: <8d7be826-863d-cf99-9ee7-73da4603692a@redhat.com>
Date: Thu, 7 May 2020 11:28:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200506163722.GH6333@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dJPh2xV4uZiQrVY4lWLCqYdKlZCmmFjmS"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 03:15:48
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dJPh2xV4uZiQrVY4lWLCqYdKlZCmmFjmS
Content-Type: multipart/mixed; boundary="q0VLYhSKZhnOe6gYwCmXPz7uzBwUlvmS2"

--q0VLYhSKZhnOe6gYwCmXPz7uzBwUlvmS2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06.05.20 18:37, Kevin Wolf wrote:
> Am 18.02.2020 um 13:42 hat Max Reitz geschrieben:
>> Make all parents of backing files pass the appropriate BdrvChildRole.
>> By doing so, we can switch their BdrvChildClass over to the generic
>> child_of_bds, which will do the right thing when given a correct
>> BdrvChildRole.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> ---
>>  block.c                 | 26 ++++++++++++++++++++------
>>  block/backup-top.c      |  2 +-
>>  block/vvfat.c           |  3 ++-
>>  tests/test-bdrv-drain.c | 13 +++++++------
>>  4 files changed, 30 insertions(+), 14 deletions(-)
>>
>> diff --git a/block.c b/block.c
>> index 43df38ca30..31affcb4ee 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -2770,6 +2770,20 @@ static bool bdrv_inherits_from_recursive(BlockDri=
verState *child,
>>      return child !=3D NULL;
>>  }
>> =20
>> +/*
>> + * Return the BdrvChildRole for @bs's backing child.  bs->backing is
>> + * mostly used for COW backing children (role =3D COW), but also for
>> + * filtered children (role =3D FILTERED | PRIMARY).
>> + */
>> +static BdrvChildRole bdrv_backing_role(BlockDriverState *bs)
>> +{
>> +    if (bs->drv && bs->drv->is_filter) {
>> +        return BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY;
>> +    } else {
>> +        return BDRV_CHILD_COW;
>> +    }
>> +}
>=20
> bdrv_mirror_top and bdrv_commit_top don't set .is_filter, so it will
> return the wrong role for them. (They also don't set .supports_backing,
> so grepping for that wouldn't help...)

I=E2=80=99ll pull in =E2=80=9Cblock: Mark commit and mirror as filter drive=
rs=E2=80=9D from the
main series then.

>>  /*
>>   * Sets the backing file link of a BDS. A new reference is created; cal=
lers
>>   * which don't need their own reference any more must call bdrv_unref()=
.
>> @@ -2797,8 +2811,8 @@ void bdrv_set_backing_hd(BlockDriverState *bs, Blo=
ckDriverState *backing_hd,
>>          goto out;
>>      }
>> =20
>> -    bs->backing =3D bdrv_attach_child(bs, backing_hd, "backing", &child=
_backing,
>> -                                    0, errp);
>> +    bs->backing =3D bdrv_attach_child(bs, backing_hd, "backing", &child=
_of_bds,
>> +                                    bdrv_backing_role(bs), errp);
>>      /* If backing_hd was already part of bs's backing chain, and
>>       * inherits_from pointed recursively to bs then let's update it to
>>       * point directly to bs (else it will become NULL). */
>> @@ -2895,7 +2909,7 @@ int bdrv_open_backing_file(BlockDriverState *bs, Q=
Dict *parent_options,
>>      }
>> =20
>>      backing_hd =3D bdrv_open_inherit(backing_filename, reference, optio=
ns, 0, bs,
>> -                                   &child_backing, 0, errp);
>> +                                   &child_of_bds, BDRV_CHILD_COW, errp)=
;
>=20
> Wouldn't it be more consistent to use bdrv_backing_role() here, too?

It=E2=80=99d be indeed.

Max


--q0VLYhSKZhnOe6gYwCmXPz7uzBwUlvmS2--

--dJPh2xV4uZiQrVY4lWLCqYdKlZCmmFjmS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6z1NIACgkQ9AfbAGHV
z0Cm9Af+INMmgNJpy66buhsgiZGgFIUnev1v93S3NvsS2+9Zslo2RJJ62gEmE7/+
6/aNJBR/W0SPTcnRWR2TdcjDuaN/2OasF0Tu8dPi9Udi2Nm25xvzx4uzQkM0IGty
0QJO1p8Ib+ibGCmE2G9lf6y+vAZQpjSkhOAP+sG1P6m7MkkAJBbHeOvCYuuuuYhk
ZA0m0Mx8FuXKkDrrDq5n4SK+nXnCyggdcc6jelNLrPk+O8ryT4MNgbpiikBi6NNt
MqQZ0aNPeO57ejEPfe2UKCp3HIYuSuPJRVrns0S7JWqi3olHDf4pBIlA259CGo2P
0A0xnQfGbwIOZQr8I0Ah9HjQRXxzpA==
=aL40
-----END PGP SIGNATURE-----

--dJPh2xV4uZiQrVY4lWLCqYdKlZCmmFjmS--


