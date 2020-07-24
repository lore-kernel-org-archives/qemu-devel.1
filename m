Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1C2C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 09:56:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 654B320714
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 09:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EGHOngaj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 654B320714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyuRC-0007p4-OB
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 05:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jyuQX-0007Hn-KL
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 05:55:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49753
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jyuQU-0003a8-EU
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 05:55:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595584537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tOqQ66tv86CHycVbj+i45ATOxG5K7QbpU42hR/DOJuM=;
 b=EGHOngajEoLA9Bo/EWh+C0457458XtEFZAZr+36Uc6e96xXJpoUMs/YVxxFHeNKn1eyPZZ
 zpu7ygyN8byhz9uGSNnKnjnesAra6Tohs10BkXV1A5/wCXXSFwwt0I+ZS5ZrcYPRYj4nsj
 mWFx/IHGc4fe15m2UJEARRWJTAvhKac=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-791JLQIQNeKwdN33K57vlA-1; Fri, 24 Jul 2020 05:55:35 -0400
X-MC-Unique: 791JLQIQNeKwdN33K57vlA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E918C800597;
 Fri, 24 Jul 2020 09:55:33 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-32.ams2.redhat.com
 [10.36.113.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B8CE369326;
 Fri, 24 Jul 2020 09:55:32 +0000 (UTC)
Subject: Re: [PATCH v7 34/47] backup: Deal with filters
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-35-mreitz@redhat.com>
 <be4213b2-75b9-c1e1-69d6-171d704013ea@virtuozzo.com>
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
Message-ID: <b6653e3d-2b2e-7cb7-53ca-f52015557ac2@redhat.com>
Date: Fri, 24 Jul 2020 11:55:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <be4213b2-75b9-c1e1-69d6-171d704013ea@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="pedGqhMB1Q0hdh4oacSsq2dohxUUjN5Hm"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 00:01:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pedGqhMB1Q0hdh4oacSsq2dohxUUjN5Hm
Content-Type: multipart/mixed; boundary="UGaSVmeJhIU6iRKNmZaS6aPkdBw6rwrSn"

--UGaSVmeJhIU6iRKNmZaS6aPkdBw6rwrSn
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 23.07.20 17:51, Andrey Shinkevich wrote:
> On 25.06.2020 18:22, Max Reitz wrote:
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> =C2=A0 block/backup-top.c |=C2=A0 2 +-
>> =C2=A0 block/backup.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 9 +++++----
>> =C2=A0 blockdev.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 19 +=
++++++++++++++----
>> =C2=A0 3 files changed, 21 insertions(+), 9 deletions(-)
>>
>>
>> diff --git a/block/backup.c b/block/backup.c
>> index 4f13bb20a5..9afa0bf3b4 100644
>> --- a/block/backup.c
>> +++ b/block/backup.c
>> @@ -297,6 +297,7 @@ static int64_t
>> backup_calculate_cluster_size(BlockDriverState *target,
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockDriverInfo bdi;
>> +=C2=A0=C2=A0=C2=A0 bool target_does_cow =3D bdrv_backing_chain_next(tar=
get);
>> =C2=A0=20
>=20
>=20
> Wouldn't it better to make the explicit type conversion or use "!!"
> approach?

I don=E2=80=99t know. O:)

I personally don=E2=80=99t like too may exclamation marks because I feel li=
ke
the code is screaming at me.  So I tend to use them only where necessary.

As for doing an explicit cast...  I think I=E2=80=99ll keep that in mind to
reduce my future use of !!.  But in this case, the type name is in the
same line, so I feel like it=E2=80=99s sufficiently clear.

Max


--UGaSVmeJhIU6iRKNmZaS6aPkdBw6rwrSn--

--pedGqhMB1Q0hdh4oacSsq2dohxUUjN5Hm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8asBMACgkQ9AfbAGHV
z0ALGQf+MG6rWTlAk7zwC7P1SvUbJIKyE7M12+1FGUn046n6Jqj0R1qCin+6Fg4r
icbgj+D/8lcUarkRYmyli53CGekMLfJP7qOMbbM2D92IwJ1TMgP61uHA7YQllkVn
mk0wZ0CgXm9gu5ScWMvFM/a++rKCmlsyUvsCNnGPPO5tkeqgbU1mofSAS5OZM8nx
+iQE0c5dzwzncsSWA3547rrtgQLPZp1Dkl3Q72Fu56s8p/WplE0ZHV0T34IMmgcN
y6ikP8o1tngL/ADTj2l7W6aFMrLenOi+uPUZhmDpo9hKI9p538EZRPmGk31LX3/u
l5LXx1cspaeQifDZQ5Y3NRl03KBLxg==
=WJ9D
-----END PGP SIGNATURE-----

--pedGqhMB1Q0hdh4oacSsq2dohxUUjN5Hm--


