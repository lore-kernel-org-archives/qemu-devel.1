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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E07C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 09:24:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DE0C2063A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 09:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c7zXGTiM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DE0C2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jytwS-0007L4-Se
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 05:24:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jytvr-0006h2-U5
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 05:23:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32250
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jytvq-0005w2-6l
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 05:23:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595582636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=e72o4FGX6KD/KS/5tmxy3Mi8ikGXO1RDdmgx4FZTSro=;
 b=c7zXGTiMaekQo730X/EV4zeTJ6k+i/bqbEV3hIk2hgIWgFjt4+VKIelegaYXt40H0qTpFz
 HpcI81dq3fkhQAGCtw3ez04PhL9ptN6F9SPyfzryGgDee855vS79jv4PuuKGTDHdD6Rg2W
 9rpD3YsDb68aQWhSExkLxFAJTq9/SWc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-4ip3koTVPh6gV2V7stG7yA-1; Fri, 24 Jul 2020 05:23:52 -0400
X-MC-Unique: 4ip3koTVPh6gV2V7stG7yA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5E6B800685;
 Fri, 24 Jul 2020 09:23:51 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-32.ams2.redhat.com
 [10.36.113.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7406572684;
 Fri, 24 Jul 2020 09:23:50 +0000 (UTC)
Subject: Re: [PATCH v7 29/47] blockdev: Use CAF in external_snapshot_prepare()
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-30-mreitz@redhat.com>
 <f89e95e4-10c8-f5ae-f085-2da4d936c043@virtuozzo.com>
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
Message-ID: <3c127508-ca2e-a92d-9caf-da707bfb5d0b@redhat.com>
Date: Fri, 24 Jul 2020 11:23:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f89e95e4-10c8-f5ae-f085-2da4d936c043@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BSeumGVnHOeB2ZHbXnSB1WNUYhdkUYHko"
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BSeumGVnHOeB2ZHbXnSB1WNUYhdkUYHko
Content-Type: multipart/mixed; boundary="YPdenUVkjkdkchT1oHgwuFiM8pPa59zFM"

--YPdenUVkjkdkchT1oHgwuFiM8pPa59zFM
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 20.07.20 18:08, Andrey Shinkevich wrote:
> On 25.06.2020 18:21, Max Reitz wrote:
>> This allows us to differentiate between filters and nodes with COW
>> backing files: Filters cannot be used as overlays at all (for this
>> function).
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> =C2=A0 blockdev.c | 7 ++++++-
>> =C2=A0 1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/blockdev.c b/blockdev.c
>> index 1eb0fcdea2..aabe51036d 100644
>> --- a/blockdev.c
>> +++ b/blockdev.c
>> @@ -1549,7 +1549,12 @@ static void
>> external_snapshot_prepare(BlkActionState *common,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 if (state->new_bs->backing !=3D NULL) {
>> +=C2=A0=C2=A0=C2=A0 if (state->new_bs->drv->is_filter) {
>=20
>=20
> Is there a chance to get a filter here? If so, is that when a user
> specifies the file name of such a kind =E2=80=9Cfilter[filter-name]:foo.q=
cow2=E2=80=9D
> or somehow else?

It would be with blockdev-snapshot and by specifying a filter for
@overlay.  Technically that=E2=80=99s already caught by the check whether t=
he
overlay supports backing images (whether drv->supports_backing is true),
but we might as well give a nicer error message.

Example:

{"execute":"qmp_capabilities"}

{"execute":"blockdev-add","arguments":
 {"node-name":"overlay","driver":"copy-on-read",
  "file":{"driver":"null-co"}}}

{"execute":"blockdev-add","arguments":
 {"node-name":"base","driver":"null-co"}}

{"execute":"blockdev-snapshot","arguments":
 {"node":"base","overlay":"overlay"}}

Max


--YPdenUVkjkdkchT1oHgwuFiM8pPa59zFM--

--BSeumGVnHOeB2ZHbXnSB1WNUYhdkUYHko
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8aqKQACgkQ9AfbAGHV
z0DpUAf7Bbo+eQHXgIKyivthXzNdTKUeA1mUa/0S14dRQeqpwq0Z5CxPh4qEFDI+
/2zdX0Mxap4VsnVJ6ntkFLpy+uvCok0aZHrgsEnOTSYS4VFwRGzXABARMsuWMXJ9
PDjIIKXD7WsCCBfPk/GSDzLkwowbEjRtCC1bEOeJospAn5kt2r4sNTKZVRc0RNQd
BSlgVNj5VZBE7lD0qwTXbgsYGx5zDBpg8EyHsusa/d/wyywnUcXx3QJCorUtyaPZ
orDtI2ZyjTs5WViFnIIhEjDbrIboqvamCfyg2OzPDXETp9I3u47lGxAwZYxLoQn0
MzeXLdeWHH36kra94JNWUCLKG97Ylg==
=ffLW
-----END PGP SIGNATURE-----

--BSeumGVnHOeB2ZHbXnSB1WNUYhdkUYHko--


