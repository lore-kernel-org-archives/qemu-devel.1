Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1D9C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 12:06:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62C2F20848
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 12:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iSu0uuOV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62C2F20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSfXy-0007Ba-5o
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 08:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kSfQ0-0006Jc-Uf
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 07:58:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27672)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kSfPu-00017J-H3
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 07:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602676681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JWNsx2Xojid0fgXYgxzECegIoEXfKwFz+umvD5SY4LQ=;
 b=iSu0uuOVJet56yJcKC0ZWsoHvsXr6NVWexrUM/i2CJGdqakjQG2BX/J5oBRqJRkxQUJQpv
 Od2RaKehSU7p6CVbofbiNVHYvcsI+UIXeZ7GHXjTnT8VZ8UiUUMkXOIn8me/f2GoVlpxNv
 tL510KX8uesrwhGS4kJ3ct9CKn9vJJU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-pDGVIQEQNK2RXe-FhXGDMA-1; Wed, 14 Oct 2020 07:57:59 -0400
X-MC-Unique: pDGVIQEQNK2RXe-FhXGDMA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 368EE64175;
 Wed, 14 Oct 2020 11:57:58 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.194.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C92355778;
 Wed, 14 Oct 2020 11:57:48 +0000 (UTC)
Subject: Re: [PATCH v11 04/13] copy-on-read: pass overlay base node name to
 COR driver
From: Max Reitz <mreitz@redhat.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1602524605-481160-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1602524605-481160-5-git-send-email-andrey.shinkevich@virtuozzo.com>
 <3c6699f3-e061-c2ae-c5e9-a12660405624@redhat.com>
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
Message-ID: <bbcb3d60-fbc2-b22c-2660-5e9d8dc4ce5e@redhat.com>
Date: Wed, 14 Oct 2020 13:57:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <3c6699f3-e061-c2ae-c5e9-a12660405624@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="A9z3lyveoGkt8hS5559kBRX4FEI5v2CwW"
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 libvir-list@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanha@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--A9z3lyveoGkt8hS5559kBRX4FEI5v2CwW
Content-Type: multipart/mixed; boundary="O9WOYT3oyToRkS2qdlxfQBxlgbwVh025M"

--O9WOYT3oyToRkS2qdlxfQBxlgbwVh025M
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.10.20 13:09, Max Reitz wrote:
> On 12.10.20 19:43, Andrey Shinkevich wrote:
>> We are going to use the COR-filter for a block-stream job.
>> To limit COR operations by the base node in the backing chain during
>> stream job, pass the name of overlay base node to the copy-on-read
>> driver as base node itself may change due to possible concurrent jobs.
>> The rest of the functionality will be implemented in the patch that
>> follows.
>>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> ---
>>  block/copy-on-read.c | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>=20
> Is there a reason why you didn=E2=80=99t add this option to QAPI (as part=
 of a
> yet-to-be-created BlockdevOptionsCor)?  Because I=E2=80=99d really like i=
t there.
>=20
>> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
>> index bcccf0f..c578b1b 100644
>> --- a/block/copy-on-read.c
>> +++ b/block/copy-on-read.c
>> @@ -24,19 +24,24 @@
>>  #include "block/block_int.h"
>>  #include "qemu/module.h"
>>  #include "qapi/error.h"
>> +#include "qapi/qmp/qerror.h"
>>  #include "qapi/qmp/qdict.h"
>>  #include "block/copy-on-read.h"
>> =20
>> =20
>>  typedef struct BDRVStateCOR {
>>      bool active;
>> +    BlockDriverState *base_overlay;
>>  } BDRVStateCOR;
>> =20
>> =20
>>  static int cor_open(BlockDriverState *bs, QDict *options, int flags,
>>                      Error **errp)
>>  {
>> +    BlockDriverState *base_overlay =3D NULL;
>>      BDRVStateCOR *state =3D bs->opaque;
>> +    /* We need the base overlay node rather than the base itself */
>> +    const char *base_overlay_node =3D qdict_get_try_str(options, "base"=
);
>=20
> Shouldn=E2=80=99t it be called base-overlay or above-base then?

While reviewing patch 5, I realized this sould indeed be base-overlay
(i.e. the next allocation-bearing layer above the base, not just a
filter on top of base), but that should be noted somewhere, of course.
Best would be the QAPI documentation for this option. O:)

Max


--O9WOYT3oyToRkS2qdlxfQBxlgbwVh025M--

--A9z3lyveoGkt8hS5559kBRX4FEI5v2CwW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl+G57oACgkQ9AfbAGHV
z0Bp4Af5ARzirR19xTe3ha1EeP1S0ccFIYJ4JYMJTUhTeVTHISYe4rxvp6v51WVX
aBVnoNeJNbH+4qCRYMpptitKaV6cflt+kzvbRnglyU1sTTR4ePmTB5j4cgZnRHHR
bAD2awVUMZgAM6239zSM0LdjvSbsXt8HqThpyZV8p4RLZiWTezgGRa76BU/SYG+5
lw2Mt6DjdrVWrWFVZ/NRwRN5oDCzUdTg5szpc3XAj6XZViRwYt7PvE3WJk+PVJ+O
KImBUEc4154ZkJXaRFlBn26t46mGhxyNxR5/W9P3d4txWrKyefpRsL+FcITzf2I5
6xAI4qhbU9xV9wymkOlqP4rWEfVYKw==
=a6+i
-----END PGP SIGNATURE-----

--A9z3lyveoGkt8hS5559kBRX4FEI5v2CwW--


