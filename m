Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C8EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:47:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C229C206F5
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iujwCyjF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C229C206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw5Ab-0000NH-38
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 10:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jw59Y-0007Vo-DQ
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 10:46:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33171
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jw59W-0000aQ-RR
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 10:46:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594910786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7DelS5N2dTTJuyl7q6v4yf6hEXAdzfevBgyZFcGL9W4=;
 b=iujwCyjF82/lCwIeCsIgGASjXzQ2+u1/1Z/urBiWF0YUiV9o1ok7EBf/qZlMwUZnnIoaHg
 Gw+l5rtSktVPZrS/dQLo8AA3AYYvTQKI46bplcXKdpeP8LBIhDcAl5My4h3q5PMgsqLaPu
 qJyltrwPOk3uE9ZorielK8T3Tq+bVEY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-8dleW9RyNCOVg4AxRO7-Hw-1; Thu, 16 Jul 2020 10:46:22 -0400
X-MC-Unique: 8dleW9RyNCOVg4AxRO7-Hw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41443106B276;
 Thu, 16 Jul 2020 14:46:06 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-160.ams2.redhat.com
 [10.36.112.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0053710013D0;
 Thu, 16 Jul 2020 14:46:04 +0000 (UTC)
Subject: Re: [PATCH v7 01/47] block: Add child access functions
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-2-mreitz@redhat.com>
 <12e568be-f931-fc16-0ca2-a7ec54e538ea@virtuozzo.com>
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
Message-ID: <6a40dbf6-5756-8483-680b-23916a6a962b@redhat.com>
Date: Thu, 16 Jul 2020 16:46:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <12e568be-f931-fc16-0ca2-a7ec54e538ea@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="fZr1TwGfLawxLkZabN9s0YGCnkQNZhFww"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 19:36:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fZr1TwGfLawxLkZabN9s0YGCnkQNZhFww
Content-Type: multipart/mixed; boundary="agDegy1On7lw5PhEzEALwnIQ4t4qjedoZ"

--agDegy1On7lw5PhEzEALwnIQ4t4qjedoZ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.07.20 11:06, Vladimir Sementsov-Ogievskiy wrote:
> 25.06.2020 18:21, Max Reitz wrote:
>> There are BDS children that the general block layer code can access,
>> namely bs->file and bs->backing.=C2=A0 Since the introduction of filters=
 and
>> external data files, their meaning is not quite clear.=C2=A0 bs->backing=
 can
>> be a COW source, or it can be a filtered child; bs->file can be a
>> filtered child, it can be data and metadata storage, or it can be just
>> metadata storage.
>>
>> This overloading really is not helpful.=C2=A0 This patch adds functions =
that
>> retrieve the correct child for each exact purpose.=C2=A0 Later patches i=
n
>> this series will make use of them.=C2=A0 Doing so will allow us to handl=
e
>> filter nodes in a meaningful way.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>=20
> [..]
>=20
>> +/*
>> + * Return the primary child of this node: For filters, that is the
>> + * filtered child.=C2=A0 For other nodes, that is usually the child sto=
ring
>> + * metadata.
>> + * (A generally more helpful description is that this is (usually) the
>> + * child that has the same filename as @bs.)
>> + *
>> + * Drivers do not necessarily have a primary child; for example quorum
>> + * does not.
>> + */
>> +BdrvChild *bdrv_primary_child(BlockDriverState *bs)
>> +{
>> +=C2=A0=C2=A0=C2=A0 BdrvChild *c;
>> +
>> +=C2=A0=C2=A0=C2=A0 QLIST_FOREACH(c, &bs->children, next) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (c->role & BDRV_CHILD_PRI=
MARY) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn c;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 return NULL;
>> +}
>>
>=20
> Suggest squash-in to also assert that not more than one primary child:
> --- a/block.c
> +++ b/block.c
> @@ -6998,13 +6998,14 @@ BdrvChild
> *bdrv_filter_or_cow_child(BlockDriverState *bs)
> =C2=A0 */
> =C2=A0BdrvChild *bdrv_primary_child(BlockDriverState *bs)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 BdrvChild *c;
> +=C2=A0=C2=A0=C2=A0 BdrvChild *c, *found =3D NULL;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 QLIST_FOREACH(c, &bs->children, next) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (c->role & BDRV_CHILD=
_PRIMARY) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n c;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 asser=
t(!found);

Hm, why not.

> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 found=
 =3D c;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 return NULL;
> +=C2=A0=C2=A0=C2=A0 return c;
> =C2=A0}
>=20
>=20
> with or without:
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

In any case, thanks for reviewing!

Max


--agDegy1On7lw5PhEzEALwnIQ4t4qjedoZ--

--fZr1TwGfLawxLkZabN9s0YGCnkQNZhFww
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8QaCsACgkQ9AfbAGHV
z0BbQwf+Prf2dHfnnpHeHpvU9TxshsvIw4u89cyi8q+D208LAEYPFnpNxCPiBfQP
zkkzWYRdb0yP21s8fZ874lX4yZ+z0dVU0wTYRJ2SRUOrGhrTbcLVqhmXAaTzX3Jr
BBQTgZ2SB1jUZOVQBDWpepUsZbE+9FLbvlApowchT8Eee7Sf9VbdwuU0i1aGKI9L
LX4wHnt4dxqKyNZMxmDKSeVwrSv/LOf3k0w7K9NKNPoa+Zi5wBiJe8YEkePUivOn
Xw5ZPtlDPg4H2aLz03320t5eYRF00IFelSh5JTk9gCqKySU+OZb21p4j0qFsPobz
ajM63uJDv1fUfZyDfW90WWQOVlHpeA==
=MWap
-----END PGP SIGNATURE-----

--fZr1TwGfLawxLkZabN9s0YGCnkQNZhFww--


