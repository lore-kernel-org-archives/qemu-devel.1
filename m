Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0E7C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 10:53:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D25712086A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 10:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L7FHQ13k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D25712086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iadtt-0005nX-3K
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 05:53:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iadRV-0003hJ-N0
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 05:24:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iadRR-0000RF-ED
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 05:24:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25572
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iadRR-0008TX-8K
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 05:24:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575023036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+mqEvMMCrRSM43GPLWy/5fFqds4INmHRH+3BYbGbktw=;
 b=L7FHQ13kxRKJEiE75ayjov3J84vgn2JIau2K7sJnJSzPpOEK6HHShJODLGpLvqRoUwMXYi
 UzL4iTAk5Qn1STw5gaCrH5cYLUwCYE4fW/4RWJlP7yAU2BvK7r6KabeW65nFWG0gdw7O//
 ENwz/H5VW30ecbxWa3Q6XOHTJGTkd/Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-oGUQ95lGNFmfu4nUsJoqng-1; Fri, 29 Nov 2019 05:23:52 -0500
X-MC-Unique: oGUQ95lGNFmfu4nUsJoqng-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 384D21856A62;
 Fri, 29 Nov 2019 10:23:51 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-206-40.brq.redhat.com
 [10.40.206.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CBABF19C4F;
 Fri, 29 Nov 2019 10:23:49 +0000 (UTC)
Subject: Re: [PATCH for-5.0 v2 06/23] block: Add bdrv_recurse_can_replace()
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20191111160216.197086-1-mreitz@redhat.com>
 <20191111160216.197086-7-mreitz@redhat.com>
 <5370cd61-413a-0208-541c-49894ad0c630@virtuozzo.com>
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
Message-ID: <c9dff2ff-cea7-8397-8fc6-b393723a4895@redhat.com>
Date: Fri, 29 Nov 2019 11:23:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <5370cd61-413a-0208-541c-49894ad0c630@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VybphVaT0HhmcYlCTJPgfN43ZhFoLxlsx"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VybphVaT0HhmcYlCTJPgfN43ZhFoLxlsx
Content-Type: multipart/mixed; boundary="b6h5Pviy6scTzhRnfLSn32gQwp1sG6M1W"

--b6h5Pviy6scTzhRnfLSn32gQwp1sG6M1W
Content-Type: text/plain; charset=WINDOWS-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 29.11.19 10:34, Vladimir Sementsov-Ogievskiy wrote:
> 11.11.2019 19:01, Max Reitz wrote:
>> After a couple of follow-up patches, this function will replace
>> bdrv_recurse_is_first_non_filter() in check_to_replace_node().
>>
>> bdrv_recurse_is_first_non_filter() is both not sufficiently specific for
>> check_to_replace_node() (it allows cases that should not be allowed,
>> like replacing child nodes of quorum with dissenting data that have more
>> parents than just quorum), and it is too restrictive (it is perfectly
>> fine to replace filters).
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>   block.c                   | 38 ++++++++++++++++++++++++++++++++++++++
>>   include/block/block_int.h | 10 ++++++++++
>>   2 files changed, 48 insertions(+)
>>
>> diff --git a/block.c b/block.c
>> index 9b1049786a..de53addeb0 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -6205,6 +6205,44 @@ bool bdrv_recurse_is_first_non_filter(BlockDriver=
State *bs,
>>       return false;
>>   }
>>  =20
>> +/*
>> + * This function checks whether the given @to_replace is allowed to be
>> + * replaced by a node that always shows the same data as @bs.  This is
>> + * used for example to verify whether the mirror job can replace
>> + * @to_replace by the target mirrored from @bs.
>> + * To be replaceable, @bs and @to_replace may either be guaranteed to
>> + * always show the same data (because they are only connected through
>> + * filters), or some driver may allow replacing one of its children
>> + * because it can guarantee that this child's data is not visible at
>> + * all (for example, for dissenting quorum children that have no other
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
>> +    /* See what the driver can do */
>> +    if (bs->drv->bdrv_recurse_can_replace) {
>> +        return bs->drv->bdrv_recurse_can_replace(bs, to_replace);
>> +    }
>> +
>> +    /* For filters without an own implementation, we can recurse on our=
 own */
>> +    if (bs->drv->is_filter) {
>> +        BdrvChild *child =3D bs->file ?: bs->backing;
>=20
> should we check that child !=3D NULL ?

I=92d say that normally (once they are open) filters must have a child,
and so I=92d make it an assertion.  But then again an assertion isn=92t muc=
h
better than the dereferencing that follows, I think. :?

Max

>> +        return bdrv_recurse_can_replace(child->bs, to_replace);
>> +    }
>> +
>> +    /* Safe default */
>> +    return false;
>> +}
>> +
>>   BlockDriverState *check_to_replace_node(BlockDriverState *parent_bs,
>>                                           const char *node_name, Error *=
*errp)
>>   {
>> diff --git a/include/block/block_int.h b/include/block/block_int.h
>> index dd033d0b37..75f03dcc38 100644
>> --- a/include/block/block_int.h
>> +++ b/include/block/block_int.h
>> @@ -102,6 +102,13 @@ struct BlockDriver {
>>        */
>>       bool (*bdrv_recurse_is_first_non_filter)(BlockDriverState *bs,
>>                                                BlockDriverState *candida=
te);
>> +    /*
>> +     * Return true if @to_replace can be replaced by a BDS with the
>> +     * same data as @bs without it affecting @bs's behavior (that is,
>> +     * without it being visible to @bs's parents).
>> +     */
>> +    bool (*bdrv_recurse_can_replace)(BlockDriverState *bs,
>> +                                     BlockDriverState *to_replace);
>>  =20
>>       int (*bdrv_probe)(const uint8_t *buf, int buf_size, const char *fi=
lename);
>>       int (*bdrv_probe_device)(const char *filename);
>> @@ -1264,6 +1271,9 @@ void bdrv_format_default_perms(BlockDriverState *b=
s, BdrvChild *c,
>>                                  uint64_t perm, uint64_t shared,
>>                                  uint64_t *nperm, uint64_t *nshared);
>>  =20
>> +bool bdrv_recurse_can_replace(BlockDriverState *bs,
>> +                              BlockDriverState *to_replace);
>> +
>>   /*
>>    * Default implementation for drivers to pass bdrv_co_block_status() t=
o
>>    * their file.
>>
>=20
>=20



--b6h5Pviy6scTzhRnfLSn32gQwp1sG6M1W--

--VybphVaT0HhmcYlCTJPgfN43ZhFoLxlsx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3g8bMACgkQ9AfbAGHV
z0A+LQf/Ztu5DPdEOjUvyTjc4OnjaAtEvjQHhjvTleY/lN7XY/tYe8tygvrnNIuR
3sI4W8OWLMc4pM3g62NXGgtWYWQl+7eZi6nX2hw5Qzu51T2kffBrrM9uZQH1+5s0
ocvjEY97FQAH8c+iD1gda25Sx1ra+aVzZJyQF4kjJJiFFkKccfhw8/LP6x4lqDFg
lm9rAkbXb6P/9dxZEhky59h5sQwPFRNWI6Bqu2WGwadKV2vndBzhKwwZP80jA8QE
8Exci/TSDCJAZ3EzJdqnWTyMamyDo8bTgDDSZ59BlS67EPBNnZlwG/i9qZSE9xhB
N4+SlDmQqKM27bGzqEOUqDzMcmoO4w==
=Y0Id
-----END PGP SIGNATURE-----

--VybphVaT0HhmcYlCTJPgfN43ZhFoLxlsx--


