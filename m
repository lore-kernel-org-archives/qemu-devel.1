Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30491C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 13:37:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB1F0216F4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 13:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C14GKXf2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB1F0216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iagSa-0001x6-6f
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 08:37:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50064)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iafjg-0004xI-Io
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:51:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iafjc-0003wZ-Gj
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:50:57 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60611
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iafjc-0003ot-9b
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:50:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575031852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/IFWWqj4kplAK4sgvX+mIAWGZFIYWRKKOK5g1eAW+D4=;
 b=C14GKXf26qz+C53DCdkVxT8UoG4lb9+AiJMqIt9jo2iw+Zkkb9sD2FM1ryo7SRi7PLbv5L
 Zzvqq5pAbBGjyUJ8jhcwlRdCs45tqMNcW0esJp0EtCpVxQEtHeGwZhV/3zE7b9l/ABP2Lb
 EvO8VCl6+WYYYTw4GN3jsapJG3u9CvU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-0u3oJvOSM967UFfb0FKtdg-1; Fri, 29 Nov 2019 07:50:49 -0500
X-MC-Unique: 0u3oJvOSM967UFfb0FKtdg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE80780183C;
 Fri, 29 Nov 2019 12:50:47 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-206-40.brq.redhat.com
 [10.40.206.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F6A010013A7;
 Fri, 29 Nov 2019 12:50:46 +0000 (UTC)
Subject: Re: [PATCH for-5.0 v2 10/23] quorum: Implement
 .bdrv_recurse_can_replace()
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20191111160216.197086-1-mreitz@redhat.com>
 <20191111160216.197086-11-mreitz@redhat.com>
 <e3424764-3205-2170-ee00-1d76bfea6df2@virtuozzo.com>
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
Message-ID: <3e99345a-9ded-8801-0697-bd399d8cdfa8@redhat.com>
Date: Fri, 29 Nov 2019 13:50:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <e3424764-3205-2170-ee00-1d76bfea6df2@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JvE7Sm4NgrpILjDg0e8UCXKxCfgBSOMZ6"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JvE7Sm4NgrpILjDg0e8UCXKxCfgBSOMZ6
Content-Type: multipart/mixed; boundary="PnaTogfwbsLqssF4vgZRgKQmo5zh5qJr7"

--PnaTogfwbsLqssF4vgZRgKQmo5zh5qJr7
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 29.11.19 11:18, Vladimir Sementsov-Ogievskiy wrote:
> 11.11.2019 19:02, Max Reitz wrote:
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>   block/quorum.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 62 insertions(+)
>>
>> diff --git a/block/quorum.c b/block/quorum.c
>> index 3a824e77e3..8ee03e9baf 100644
>> --- a/block/quorum.c
>> +++ b/block/quorum.c
>> @@ -825,6 +825,67 @@ static bool quorum_recurse_is_first_non_filter(Bloc=
kDriverState *bs,
>>       return false;
>>   }
>>  =20
>> +static bool quorum_recurse_can_replace(BlockDriverState *bs,
>> +                                       BlockDriverState *to_replace)
>> +{
>> +    BDRVQuorumState *s =3D bs->opaque;
>> +    int i;
>> +
>> +    for (i =3D 0; i < s->num_children; i++) {
>> +        /*
>> +         * We have no idea whether our children show the same data as
>> +         * this node (@bs).  It is actually highly likely that
>> +         * @to_replace does not, because replacing a broken child is
>> +         * one of the main use cases here.
>> +         *
>> +         * We do know that the new BDS will match @bs, so replacing
>> +         * any of our children by it will be safe.  It cannot change
>> +         * the data this quorum node presents to its parents.
>> +         *
>> +         * However, replacing @to_replace by @bs in any of our
>> +         * children's chains may change visible data somewhere in
>> +         * there.  We therefore cannot recurse down those chains with
>> +         * bdrv_recurse_can_replace().
>> +         * (More formally, bdrv_recurse_can_replace() requires that
>> +         * @to_replace will be replaced by something matching the @bs
>> +         * passed to it.  We cannot guarantee that.)
>> +         *
>> +         * Thus, we can only check whether any of our immediate
>> +         * children matches @to_replace.
>> +         *
>> +         * (In the future, we might add a function to recurse down a
>> +         * chain that checks that nothing there cares about a change
>> +         * in data from the respective child in question.  For
>> +         * example, most filters do not care when their child's data
>> +         * suddenly changes, as long as their parents do not care.)
>> +         */
>> +        if (s->children[i].child->bs =3D=3D to_replace) {
>> +            Error *local_err =3D NULL;
>=20
> bdrv_child_refresh_perms returns int, so I suggest instead:

Good to know. :-)

> bool ok;
>=20
>> +
>> +            /*
>> +             * We now have to ensure that there is no other parent
>> +             * that cares about replacing this child by a node with
>> +             * potentially different data.
>> +             */
>> +            s->children[i].to_be_replaced =3D true;
>> +            bdrv_child_refresh_perms(bs, s->children[i].child, &local_e=
rr);
>=20
> ok =3D !bdrv_child_refresh_perms(bs, s->children[i].child, NULL);
>=20
>> +
>> +            /* Revert permissions */
>> +            s->children[i].to_be_replaced =3D false;
>> +            bdrv_child_refresh_perms(bs, s->children[i].child, &error_a=
bort);
>=20
> return ok;
>=20
> Or similar with // int ret; // ret =3D // return !ret; //

Sounds good.

Max


--PnaTogfwbsLqssF4vgZRgKQmo5zh5qJr7--

--JvE7Sm4NgrpILjDg0e8UCXKxCfgBSOMZ6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3hFCQACgkQ9AfbAGHV
z0AaeQgAtg7qZr5+8+IVMow9DUFAisdJq3G2NmOjUI+jFsswhtlxiEEKYm7+YVGO
EP2ErofQJQnFyfjyGlATbCsTTPD3rcI2l5yVkehSTNgYhK4V1iRN8hbbxH+YmHzS
OitNr0plYCdvYwVc0H5ZKG2fHuodaCu8Cp6vSab+QGs+rQfSYagNF3ScY1TOud69
Cbds82+uiwmme3nFLL1T7kaA9a0l+N2aPw4guKBEF+ZnHKT3kBRnJqAvndSmhdP7
2vQe+ozLYP/3FL8JYw9ZRrj3v59HtQLGrLI/JApJnjp+eljOCeFxdM3enu6V5Qtd
eSlxuen1cbeiKwic1dXYyodmc2r/JA==
=d2QR
-----END PGP SIGNATURE-----

--JvE7Sm4NgrpILjDg0e8UCXKxCfgBSOMZ6--


