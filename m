Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D07BC83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 08:09:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6605220787
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 08:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BGyeaJrF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6605220787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jThmS-000726-J8
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 04:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48152)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jThKA-0005Su-Hz
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:40:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jThK9-0005Gt-T0
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:40:06 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34709
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jThK9-0005Gb-E4
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:40:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588146004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YZ8FxVQVSl8F88J2XJzVow3pfa6GEkGlomKrB0SiCqE=;
 b=BGyeaJrFvWjITbFiD68wWeea/LovComPeGV6rgyzMJU4hmfXeZgRdTXsCs+tla++vKiS4z
 iu5gcdTNJWdlFaWQM2NPDAG2SaoKhg7SLJci7RJBRdlNicSqnyKNuinbwxqiPMRQiGAqk+
 ZYb8RKIKIiZav/nc6+qv2eUQQdt0zrU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-HxcaW993OAqIkR9irSQnig-1; Wed, 29 Apr 2020 03:40:02 -0400
X-MC-Unique: HxcaW993OAqIkR9irSQnig-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93733107ACF5;
 Wed, 29 Apr 2020 07:40:01 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-19.ams2.redhat.com
 [10.36.113.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C74E1002397;
 Wed, 29 Apr 2020 07:40:00 +0000 (UTC)
Subject: Re: [PATCH 3/4] block: Add blk_make_empty()
To: Kevin Wolf <kwolf@redhat.com>
References: <20200428132629.796753-1-mreitz@redhat.com>
 <20200428132629.796753-4-mreitz@redhat.com>
 <20200428144706.GJ5789@linux.fritz.box>
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
Message-ID: <af3006f0-a01f-e866-a9f4-91db823d5348@redhat.com>
Date: Wed, 29 Apr 2020 09:39:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428144706.GJ5789@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kqt85QI73IH3PrOUJXzfLGdGldnpGRnig"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:28:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
--kqt85QI73IH3PrOUJXzfLGdGldnpGRnig
Content-Type: multipart/mixed; boundary="lZsCFyW4sn7Gh4T6FBYXqst00VBAGMCJI"

--lZsCFyW4sn7Gh4T6FBYXqst00VBAGMCJI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 28.04.20 16:47, Kevin Wolf wrote:
> Am 28.04.2020 um 15:26 hat Max Reitz geschrieben:
>> Two callers of BlockDriver.bdrv_make_empty() remain that should not call
>> this method directly.  Both do not have access to a BdrvChild, but they
>> can use a BlockBackend, so we add this function that lets them use it.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  include/sysemu/block-backend.h | 2 ++
>>  block/block-backend.c          | 5 +++++
>>  2 files changed, 7 insertions(+)
>>
>> diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backe=
nd.h
>> index d37c1244dd..14338b76dc 100644
>> --- a/include/sysemu/block-backend.h
>> +++ b/include/sysemu/block-backend.h
>> @@ -266,4 +266,6 @@ int coroutine_fn blk_co_copy_range(BlockBackend *blk=
_in, int64_t off_in,
>> =20
>>  const BdrvChild *blk_root(BlockBackend *blk);
>> =20
>> +int blk_make_empty(BlockBackend *blk, Error **errp);
>> +
>>  #endif
>> diff --git a/block/block-backend.c b/block/block-backend.c
>> index 3592066b42..5d36efd32f 100644
>> --- a/block/block-backend.c
>> +++ b/block/block-backend.c
>> @@ -2402,3 +2402,8 @@ const BdrvChild *blk_root(BlockBackend *blk)
>>  {
>>      return blk->root;
>>  }
>> +
>> +int blk_make_empty(BlockBackend *blk, Error **errp)
>> +{
>> +    return bdrv_make_empty(blk->root, errp);
>> +}
>=20
> Should we check that blk->root !=3D NULL? Most other functions do that
> through blk_is_available().

Why not.

Max


--lZsCFyW4sn7Gh4T6FBYXqst00VBAGMCJI--

--kqt85QI73IH3PrOUJXzfLGdGldnpGRnig
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6pL08ACgkQ9AfbAGHV
z0AtNwgArtaMzKI7/5AkWRqWST4Z5hISU/YRUpRMN3au+t3Btj9jzS0hvkSYl1zb
7H/I9DcGCAaI7uR6Eni8k91RtciHN8QKjwLfXq5MAcA45fhQoROKBZoFF6d62Hdw
uJhNo2FECZurxohDU/rV6pp6J3FDno60mtDXjvZ1nDIt6/cJTUFacX/Q00SCBlTF
5ALR5QRCEWoGdY9cuHPGhFSlSCCe/Hd6mRWDnOKPq9klnZzWM3jeFLH7y9Ogvznd
i2SiBjdqZ6tSKPjp0zh0ZFoRKDCY41uT1tiG73AJ4WsxQaScp95lnCyiMWt16CLz
VLWN5KHqhpmZFOSNebmildosMvVoUw==
=AXPL
-----END PGP SIGNATURE-----

--kqt85QI73IH3PrOUJXzfLGdGldnpGRnig--


