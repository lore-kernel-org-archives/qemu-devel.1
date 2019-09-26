Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD35C432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 11:05:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D50B721A4A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 11:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D50B721A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDRaf-00081B-Vm
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 07:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49704)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iDRZ5-000758-2r
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 07:04:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iDRZ3-0002AQ-OH
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 07:04:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:61585)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iDRZ0-00026O-Rd; Thu, 26 Sep 2019 07:03:59 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 040C72117;
 Thu, 26 Sep 2019 11:03:58 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.151])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E0846CE40;
 Thu, 26 Sep 2019 11:03:56 +0000 (UTC)
Subject: Re: [PATCH 06/22] block: Add bdrv_recurse_can_replace()
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190920152804.12875-1-mreitz@redhat.com>
 <20190920152804.12875-7-mreitz@redhat.com>
 <37b5883c-b4e9-4b9d-fae4-8a1f0b04cd54@virtuozzo.com>
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
Message-ID: <3cdf9ba3-d79c-b62b-cccf-3fd444c0e252@redhat.com>
Date: Thu, 26 Sep 2019 13:03:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <37b5883c-b4e9-4b9d-fae4-8a1f0b04cd54@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="pdYScZK8JiNDa2ipGbmGD3v75iI6BkysL"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Thu, 26 Sep 2019 11:03:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
--pdYScZK8JiNDa2ipGbmGD3v75iI6BkysL
Content-Type: multipart/mixed; boundary="1xh6BKN9IhAqShQl3luLDb2P4Qdjgb1KL"

--1xh6BKN9IhAqShQl3luLDb2P4Qdjgb1KL
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.09.19 14:39, Vladimir Sementsov-Ogievskiy wrote:
> 20.09.2019 18:27, Max Reitz wrote:
>> After a couple of follow-up patches, this function will replace
>> bdrv_recurse_is_first_non_filter() in check_to_replace_node().
>>
>> bdrv_recurse_is_first_non_filter() is both not sufficiently specific f=
or
>> check_to_replace_node() (it allows cases that should not be allowed,
>> like replacing child nodes of quorum with dissenting data that have mo=
re
>> parents than just quorum), and it is too restrictive (it is perfectly
>> fine to replace filters).
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>   include/block/block_int.h | 10 ++++++++++
>>   block.c                   | 38 +++++++++++++++++++++++++++++++++++++=
+
>>   2 files changed, 48 insertions(+)
>>
>> diff --git a/include/block/block_int.h b/include/block/block_int.h
>> index 5fd4f17d93..0be7d12f04 100644
>> --- a/include/block/block_int.h
>> +++ b/include/block/block_int.h
>> @@ -103,6 +103,13 @@ struct BlockDriver {
>>        */
>>       bool (*bdrv_recurse_is_first_non_filter)(BlockDriverState *bs,
>>                                                BlockDriverState *candi=
date);
>> +    /*
>> +     * Return true if @to_replace can be replaced by a BDS with the
>> +     * same data as @bs without it affecting @bs's behavior (that is,=

>> +     * without it being visible to @bs's parents).
>> +     */
>> +    bool (*bdrv_recurse_can_replace)(BlockDriverState *bs,
>> +                                     BlockDriverState *to_replace);
>>  =20
>>       int (*bdrv_probe)(const uint8_t *buf, int buf_size, const char *=
filename);
>>       int (*bdrv_probe_device)(const char *filename);
>> @@ -1254,6 +1261,9 @@ void bdrv_format_default_perms(BlockDriverState =
*bs, BdrvChild *c,
>>                                  uint64_t perm, uint64_t shared,
>>                                  uint64_t *nperm, uint64_t *nshared);
>>  =20
>> +bool bdrv_recurse_can_replace(BlockDriverState *bs,
>> +                              BlockDriverState *to_replace);
>> +
>>   /*
>>    * Default implementation for drivers to pass bdrv_co_block_status()=
 to
>>    * their file.
>> diff --git a/block.c b/block.c
>> index 7d99ca692c..a2deca4ac9 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -6206,6 +6206,44 @@ bool bdrv_recurse_is_first_non_filter(BlockDriv=
erState *bs,
>>       return false;
>>   }
>>  =20
>> +/*
>> + * This function checks whether the given @to_replace is allowed to b=
e
>> + * replaced by a node that always shows the same data as @bs.  This i=
s
>> + * used for example to verify whether the mirror job can replace
>> + * @to_replace by the target mirrored from @bs.
>> + * To be replaceable, @bs and @to_replace may either be guaranteed to=

>> + * always show the same data (because they are only connected through=

>> + * filters), or some driver may allow replacing one of its children
>> + * because it can guarantee that this child's data is not visible at
>> + * all (for example, for dissenting quorum children that have no othe=
r
>> + * parents).
>> + */
>> +bool bdrv_recurse_can_replace(BlockDriverState *bs,
>> +                              BlockDriverState *to_replace)
>> +{
>> +    if (!bs || !bs->drv) {
>> +        return false;
>> +    }
>> +
>> +    if (bs =3D=3D to_replace) {
>> +        return true;
>> +    }
>> +
>> +    /* For filters, we can recurse on our own */
>> +    if (bs->drv->is_filter) {
>> +        BdrvChild *child =3D bs->file ?: bs->backing;
>=20
> then, maybe asset(!bs->drv->bdrv_recurse_can_replace)

It=E2=80=99s actually the other way around.  As you find yourself, blkver=
ify is
a filter and has its own implementation.  That is entirely correct
because we cannot recurse to just bs->file in blkverify's case.  So we
should first invoke the driver-specific function, and then have the
generic filter code.

Max

>> +        return bdrv_recurse_can_replace(child->bs, to_replace);
>> +    }
>=20
> or, this may be filter-skipping loop instead of recursion, like
>=20
> while (bs && bs->drv && bs->drv->is_filter) {
>    bs =3D (bs->file ?: bs->backing)->bs;
> }
>=20
> at function start.
>=20
> either way:
>=20
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20
>> +
>> +    /* See what the driver can do */
>> +    if (bs->drv->bdrv_recurse_can_replace) {
>> +        return bs->drv->bdrv_recurse_can_replace(bs, to_replace);
>> +    }
>> +
>> +    /* Safe default */
>> +    return false;
>> +}
>> +
>>   BlockDriverState *check_to_replace_node(BlockDriverState *parent_bs,=

>>                                           const char *node_name, Error=
 **errp)
>>   {
>>
>=20
>=20



--1xh6BKN9IhAqShQl3luLDb2P4Qdjgb1KL--

--pdYScZK8JiNDa2ipGbmGD3v75iI6BkysL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2MmxsACgkQ9AfbAGHV
z0DW8Af4tvgpUvfJ8qrXU1MCLnrXF0WqVQY1s9ZmFZlddHD4lqOrgstXs0tDXS9x
41HrdcpTQfIQUGkAEu3En3KOK5btP4sPVZhN3ydYifbiTyrsbaAJXlQz1u9n/zNz
b5awGZmSKSGTbl2CYEHdR9IvSWKcNwhXgt2+B6mfYNA5ODUCYMRK+duWL1/z2Tf2
n2vC8Q9lODZi64T/CSM8OaIoSVZeO7LjXFmuarAg0TVIu3uhZBRM/Dyx198t5mpS
P3LdPkf68lyufzwfObDnuGtD1JEEsGKkpnouwOlLPl1VDcoC6q2T5ZtbVqcimXgV
f3CluiZd+8Y4HGpvCXEas2Vx9CIR
=4kmX
-----END PGP SIGNATURE-----

--pdYScZK8JiNDa2ipGbmGD3v75iI6BkysL--

