Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7899C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 08:09:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B35620787
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 08:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dG86bvoE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B35620787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jThmD-0006Ln-LR
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 04:09:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51028)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jThho-0007cT-EP
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:08:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jThf7-0004ou-OL
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:04:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59256
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jThf7-0004oW-9M
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:01:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588147304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bpboKJQELJcm8CZ2jZTejb6iBD4DWfIg8BnXkkD+ZFg=;
 b=dG86bvoElKxShKphSRCFxApLaRS3B8DJZGhrGWb2sXkw1RRXcmgbyPusm/iQaFVj42e3kX
 2b71t8hVglIeQTkwW/h5OlhmZbo6j7D4LAwRO9Dms0gWB+61+4mDfDXBgwUmETRMgJu6Cv
 DCTzIF40H0777zfq7yVKbc1XxpzPo6o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-1C7u_MQxNaKcmrao7uI31Q-1; Wed, 29 Apr 2020 04:01:42 -0400
X-MC-Unique: 1C7u_MQxNaKcmrao7uI31Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31B4D80B71F;
 Wed, 29 Apr 2020 08:01:41 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-19.ams2.redhat.com
 [10.36.113.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4781A60BEC;
 Wed, 29 Apr 2020 08:01:40 +0000 (UTC)
Subject: Re: [PATCH 4/4] block: Use blk_make_empty() after commits
To: Kevin Wolf <kwolf@redhat.com>
References: <20200428132629.796753-1-mreitz@redhat.com>
 <20200428132629.796753-5-mreitz@redhat.com>
 <20200428150311.GK5789@linux.fritz.box>
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
Message-ID: <dc7f8c0f-cb5c-8c23-ea7a-cdd4a5ac9698@redhat.com>
Date: Wed, 29 Apr 2020 10:01:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428150311.GK5789@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="FDPssQ5QjHaxlKLtzuK1aAluHKhSuGXDs"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:42:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
--FDPssQ5QjHaxlKLtzuK1aAluHKhSuGXDs
Content-Type: multipart/mixed; boundary="2qiUkxfNXlwQxCbycLfYCR1ydz37Pe1Md"

--2qiUkxfNXlwQxCbycLfYCR1ydz37Pe1Md
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 28.04.20 17:03, Kevin Wolf wrote:
> Am 28.04.2020 um 15:26 hat Max Reitz geschrieben:
>> bdrv_commit() already has a BlockBackend pointing to the BDS that we
>> want to empty, it just has the wrong permissions.
>>
>> qemu-img commit has no BlockBackend pointing to the old backing file
>> yet, but introducing one is simple.
>>
>> After this commit, bdrv_make_empty() is the only remaining caller of
>> BlockDriver.bdrv_make_empty().
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/commit.c |  8 +++++++-
>>  qemu-img.c     | 19 ++++++++++++++-----
>>  2 files changed, 21 insertions(+), 6 deletions(-)
>>
>> diff --git a/block/commit.c b/block/commit.c
>> index 8e672799af..24720ba67d 100644
>> --- a/block/commit.c
>> +++ b/block/commit.c
>> @@ -493,10 +493,16 @@ int bdrv_commit(BlockDriverState *bs)
>>      }
>> =20
>>      if (drv->bdrv_make_empty) {
>> -        ret =3D drv->bdrv_make_empty(bs);
>> +        ret =3D blk_set_perm(src, BLK_PERM_WRITE, BLK_PERM_ALL, NULL);
>=20
> This is very likely to fail because the common case is that the source
> node is attached to a guest device that doesn't share writes.
> (qemu-iotests 131 and 274 catch this.)
>=20
> So I think after my theoretical comment in patch 1, this is the
> practical reason why we need WRITE_UNCHANGED rather than WRITE.
>=20
> Also, why don't you take this permission from the start so that we would
> error out right away rather than failing after waiting for the all the
> data to be copied?

Because we only need to take it when the BlockDriver actually supports
bdrv_make_empty(), so I thought I=E2=80=99d put it here where we have the c=
heck
anyway.

However, yes, when we take WRITE_UNCHANGED, we might as well take it
unconditionally from the start.  (And then call blk_make_empty()
unconditionally here, too, and let it figure out -ENOTSUP, like Eric noted.=
)

>>          if (ret < 0) {
>>              goto ro_cleanup;
>>          }
>> +
>> +        ret =3D blk_make_empty(src, NULL);
>> +        if (ret < 0) {
>> +            goto ro_cleanup;
>> +        }
>> +
>>          blk_flush(src);
>>      }
>> =20
>> diff --git a/qemu-img.c b/qemu-img.c
>> index 821cbf610e..a5e8659867 100644
>> --- a/qemu-img.c
>> +++ b/qemu-img.c
>> @@ -1065,11 +1065,20 @@ static int img_commit(int argc, char **argv)
>>          goto unref_backing;
>>      }
>> =20
>> -    if (!drop && bs->drv->bdrv_make_empty) {
>> -        ret =3D bs->drv->bdrv_make_empty(bs);
>> -        if (ret) {
>> -            error_setg_errno(&local_err, -ret, "Could not empty %s",
>> -                             filename);
>> +    if (!drop) {
>> +        BlockBackend *old_backing_blk;
>> +
>> +        old_backing_blk =3D blk_new_with_bs(bs, BLK_PERM_WRITE, BLK_PER=
M_ALL,
>> +                                          &local_err);
>=20
> Oh, you actually depend on another series that you didn't mention in
> the cover letter.

Well, yes.  I didn=E2=80=99t really realize because I just based it on my
block-next...

Max


--2qiUkxfNXlwQxCbycLfYCR1ydz37Pe1Md--

--FDPssQ5QjHaxlKLtzuK1aAluHKhSuGXDs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6pNGIACgkQ9AfbAGHV
z0AT1gf/bqRykFw8IRuIZPA7VzaTGV61KscNPWx6kDMmUoT4d+O66w88vKi2+BZj
EmU+iXK6t+VINcbY5i0/vQbROrrxl0bJGr7IaVkJfCDCZ48BskH/AbJXIdeYLPDJ
ph3xGGMkqR2XOEMQmksVF/mXSdzNKKzLuDLT7PLmHiuoFJ9OCG7mXqschB29zX/l
JbWdAli0w5qm9oGwkBguKYZgUpUGK53yFvfg0dwB2t4u3QiKxYG3UgUof/x2/GEw
FniixzJHFFeBnGHQ8tO6SVg7ET0UpPYp4pfG4BtGxy4mDepg6OTz8x18UaS3tl+o
RMekcqMu9RN5HT/3cpLPEQ9dflmX8A==
=D9i3
-----END PGP SIGNATURE-----

--FDPssQ5QjHaxlKLtzuK1aAluHKhSuGXDs--


