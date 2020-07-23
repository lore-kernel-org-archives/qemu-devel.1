Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AECC433EC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 07:44:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CB9C20714
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 07:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FD2GRniA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CB9C20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyVu3-0001SK-IQ
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 03:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jyVtK-0000yY-RR
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 03:43:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46888
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jyVtI-0002NG-9n
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 03:43:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595490222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lVoX3YccBjKZxJAG75IW82TJ54s9gdjpEk/2CsQ60jE=;
 b=FD2GRniAK/FYU1ggB9IlURNVG6tLa0DNFZ9fwC2e8Xm9yfWxdN1uuiQKzkCtuQjAhiOdc5
 Z6UAXP1wWiHNO9Hp5fkvZoMt6BB3FzRRBdK2dHCCpjitnF31ldGbTcMr9eHk7JRiLOOZ9N
 88RGcPd96RFhSaiH6LUkw2XoAGpjPkI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-wV2wqJ70Od6r-kvNklWOvQ-1; Thu, 23 Jul 2020 03:43:39 -0400
X-MC-Unique: wV2wqJ70Od6r-kvNklWOvQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4AB16800685;
 Thu, 23 Jul 2020 07:43:38 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-146.ams2.redhat.com
 [10.36.113.146])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D976E19C4F;
 Thu, 23 Jul 2020 07:43:35 +0000 (UTC)
Subject: Re: [PATCH v2 11/20] qapi: backup: add x-max-chunk and x-max-workers
 parameters
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200601181118.579-1-vsementsov@virtuozzo.com>
 <20200601181118.579-12-vsementsov@virtuozzo.com>
 <2117c54a-c9b3-59c6-c0b2-9fd84cb965b6@redhat.com>
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
Message-ID: <76c4e42b-db7d-4cde-5db7-b86d24432d21@redhat.com>
Date: Thu, 23 Jul 2020 09:43:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2117c54a-c9b3-59c6-c0b2-9fd84cb965b6@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="iZSqDSUmgZMAnyy37NU3OLerVPjpmMHCr"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:33:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, wencongyang2@huawei.com, xiechanglong.d@gmail.com,
 armbru@redhat.com, qemu-devel@nongnu.org, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iZSqDSUmgZMAnyy37NU3OLerVPjpmMHCr
Content-Type: multipart/mixed; boundary="oWKfCHzcPrIttCioJATyURVS00dZ1DPhQ"

--oWKfCHzcPrIttCioJATyURVS00dZ1DPhQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22.07.20 14:22, Max Reitz wrote:
> On 01.06.20 20:11, Vladimir Sementsov-Ogievskiy wrote:
>> Add new parameters to configure future backup features. The patch
>> doesn't introduce aio backup requests (so we actually have only one
>> worker) neither requests larger than one cluster. Still, formally we
>> satisfy these maximums anyway, so add the parameters now, to facilitate
>> further patch which will really change backup job behavior.
>>
>> Options are added with x- prefixes, as the only use for them are some
>> very conservative iotests which will be updated soon.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>  qapi/block-core.json      |  9 ++++++++-
>>  include/block/block_int.h |  7 +++++++
>>  block/backup.c            | 21 +++++++++++++++++++++
>>  block/replication.c       |  2 +-
>>  blockdev.c                |  5 +++++
>>  5 files changed, 42 insertions(+), 2 deletions(-)

[...]

>> diff --git a/block/replication.c b/block/replication.c
>> index 25987eab0f..a9ee82db80 100644
>> --- a/block/replication.c
>> +++ b/block/replication.c
>> @@ -563,7 +563,7 @@ static void replication_start(ReplicationState *rs, =
ReplicationMode mode,
>>          s->backup_job =3D backup_job_create(
>>                                  NULL, s->secondary_disk->bs, s->hidden_=
disk->bs,
>>                                  0, MIRROR_SYNC_MODE_NONE, NULL, 0, fals=
e, NULL,
>> -                                true,
>> +                                true, 0, 0,
>=20
> Passing 0 for max_workers will error out immediately, won=E2=80=99t it?

Ah, oops.  Saw your own reply only now.  Yep, 1 worker would be nice. :)


--oWKfCHzcPrIttCioJATyURVS00dZ1DPhQ--

--iZSqDSUmgZMAnyy37NU3OLerVPjpmMHCr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8ZP6UACgkQ9AfbAGHV
z0DJgwgAo7YR751kMp6k1M2ATYfCD+u8H65E3zNr/p5XsAL9qVSHq7nFuOFyy47U
MTcMX3+YtEZcvdIqElnHUNGEQTJ+/aEtYJgz+PXcdy1NN+uwtQuJI43yjCGne6BD
Bc1diNSp3vrgB6NMa5RBDHf9g7HII5jUHkN38moxKU3VZ5Fv5qTVKCdJm1C8wMBs
Xpjgf3ZjxMjcBpRT1fT9pG4qChwLEFu+CfOYPXSOMCSUMCvYjnA43oksem2i9GiU
diXgyk9MarlbmB7NTa6B9wFg9p0brNuU8ZpZZ0fuIbNpvxMr/PRufW23EU1D9z9M
unV793ACVnyRkJYSR+wthklc+x0k3w==
=ycgW
-----END PGP SIGNATURE-----

--iZSqDSUmgZMAnyy37NU3OLerVPjpmMHCr--


