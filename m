Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B81EC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 15:54:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AF012063A
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 15:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BNyVBrKb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AF012063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8QQ0-0004G5-EM
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 11:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k8QP4-0003Gb-Bk
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 11:53:30 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37969
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k8QP2-0004BM-PA
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 11:53:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597852408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=baZcXxB5yu1IpLJdXnkr87ty67862Rh/3ejnzrh4Z1Y=;
 b=BNyVBrKbXVGigJyYRNL4WWEjcBf31KM/N+CcNtikjjSaHsSt/fcIXarn/AvOWVu3M/hpKi
 8tLM5wn4XpKUnpNff6wZ7faYpA+AMui78R3decmQrb/AbxdT3XCEvmo6Uz6CLUDPFiT5Ws
 kPs5RI7DXbBXM4qVN9zrmEYabbJqwMA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-527-38ufZfLfPDaTzupiYgAwyQ-1; Wed, 19 Aug 2020 11:53:24 -0400
X-MC-Unique: 38ufZfLfPDaTzupiYgAwyQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F6EC801ADD;
 Wed, 19 Aug 2020 15:53:23 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-120.ams2.redhat.com
 [10.36.113.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 10D877BE98;
 Wed, 19 Aug 2020 15:53:21 +0000 (UTC)
Subject: Re: [PATCH v7 25/47] block: Def. impl.s for get_allocated_file_size
To: Kevin Wolf <kwolf@redhat.com>
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-26-mreitz@redhat.com>
 <20200819105740.GB10272@linux.fritz.box>
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
Message-ID: <e1b46a9e-3021-8018-f587-fd3759ee4cbb@redhat.com>
Date: Wed, 19 Aug 2020 17:53:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200819105740.GB10272@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5qLWyaaWQYJdxWWT3PJz63qPAzgCSHKz4"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 01:46:53
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5qLWyaaWQYJdxWWT3PJz63qPAzgCSHKz4
Content-Type: multipart/mixed; boundary="C0dUQYKt74VyiOLghptmNmUSLJyUWWGn6"

--C0dUQYKt74VyiOLghptmNmUSLJyUWWGn6
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 19.08.20 12:57, Kevin Wolf wrote:
> Am 25.06.2020 um 17:21 hat Max Reitz geschrieben:
>> If every BlockDriver were to implement bdrv_get_allocated_file_size(),
>> there are basically three ways it would be handled:
>> (1) For protocol drivers: Figure out the actual allocated file size in
>>     some protocol-specific way
>> (2) For protocol drivers: If that is not possible (or we just have not
>>     bothered to implement it yet), return -ENOTSUP
>> (3) For drivers with children: Return the sum of some or all their
>>     children's sizes
>>
>> For the drivers we have, case (3) boils down to either:
>> (a) The sum of all children's sizes
>> (b) The size of the primary child
>>
>> (2), (3a) and (3b) can be implemented generically, so this patch adds
>> such generic implementations for drivers to use.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  include/block/block_int.h |  5 ++++
>>  block.c                   | 51 +++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 56 insertions(+)
>>
>> diff --git a/include/block/block_int.h b/include/block/block_int.h
>> index 5da793bfc3..c963ee9f28 100644
>> --- a/include/block/block_int.h
>> +++ b/include/block/block_int.h
>> @@ -1318,6 +1318,11 @@ int coroutine_fn bdrv_co_block_status_from_backin=
g(BlockDriverState *bs,
>>                                                     int64_t *pnum,
>>                                                     int64_t *map,
>>                                                     BlockDriverState **f=
ile);
>> +
>> +int64_t bdrv_sum_allocated_file_size(BlockDriverState *bs);
>> +int64_t bdrv_primary_allocated_file_size(BlockDriverState *bs);
>> +int64_t bdrv_notsup_allocated_file_size(BlockDriverState *bs);
>> +
>>  const char *bdrv_get_parent_name(const BlockDriverState *bs);
>>  void blk_dev_change_media_cb(BlockBackend *blk, bool load, Error **errp=
);
>>  bool blk_dev_has_removable_media(BlockBackend *blk);
>> diff --git a/block.c b/block.c
>> index 1c71ecab7c..fc01ce90b3 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -5003,6 +5003,57 @@ int64_t bdrv_get_allocated_file_size(BlockDriverS=
tate *bs)
>>      return -ENOTSUP;
>>  }
>> =20
>> +/**
>> + * Implementation of BlockDriver.bdrv_get_allocated_file_size() for
>> + * block drivers that want it to sum all children they store data on.
>> + * (This excludes backing children.)
>> + */
>> +int64_t bdrv_sum_allocated_file_size(BlockDriverState *bs)
>> +{
>> +    BdrvChild *child;
>> +    int64_t child_size, sum =3D 0;
>> +
>> +    QLIST_FOREACH(child, &bs->children, next) {
>> +        if (child->role & (BDRV_CHILD_DATA | BDRV_CHILD_METADATA |
>> +                           BDRV_CHILD_FILTERED))
>> +        {
>> +            child_size =3D bdrv_get_allocated_file_size(child->bs);
>> +            if (child_size < 0) {
>> +                return child_size;
>> +            }
>> +            sum +=3D child_size;
>> +        }
>> +    }
>> +
>> +    return sum;
>> +}
>=20
> The only user apart from bdrv_get_allocated_file_size() is blkverify. As
> I argued that blkverify shouldn't use it, this can become static.
>=20
>> +/**
>> + * Implementation of BlockDriver.bdrv_get_allocated_file_size() for
>> + * block drivers that want it to return only the size of a node's
>> + * primary child.
>> + */
>> +int64_t bdrv_primary_allocated_file_size(BlockDriverState *bs)
>> +{
>> +    BlockDriverState *primary_bs;
>> +
>> +    primary_bs =3D bdrv_primary_bs(bs);
>> +    if (!primary_bs) {
>> +        return -ENOTSUP;
>> +    }
>> +
>> +    return bdrv_get_allocated_file_size(primary_bs);
>> +}
>=20
> This can become static, too (never used as a callback), and possibly
> even be inlined.
>=20
>> +/**
>> + * Implementation of BlockDriver.bdrv_get_allocated_file_size() for
>> + * protocol block drivers that just do not support it.
>> + */
>> +int64_t bdrv_notsup_allocated_file_size(BlockDriverState *bs)
>> +{
>> +    return -ENOTSUP;
>> +}
>=20
> Also never used as a callback. I think inlining it would almost
> certainly make more sense.

I think they=E2=80=99re all artifacts from the development process, yeah.

Originally, I wanted to make .bdrv_get_allocated_file_size() mandatory,
but then I saw that led nowhere and could be done well generically.

Max


--C0dUQYKt74VyiOLghptmNmUSLJyUWWGn6--

--5qLWyaaWQYJdxWWT3PJz63qPAzgCSHKz4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl89SvAACgkQ9AfbAGHV
z0CvkQf/bLtXYtL7zyNaEIoDfFwtMq3MjNNdbVKqnSlUEqp+LL9Bw0oxLXWYsxs0
rGC6Kdi2Ouk+GWunoUT0Q2Gx8bC1ERhaFDPlHAFMYogLL7MNmNYXX5epGYkLoieo
/mGyEkC3qIGl4xRyxSsQFu5IDiOX+xxl/bquyiO8fHfUgvg+NFz8Lv1pUIrG68Ia
pmYUmqlBHGM+7AnvxNqciqLJfWrMEO5q2d0ymPzcNEgclGejyMf+3yYjKNwtzxh5
McCG8mzcj8ginRLYjqZqB7oqK+JHISexZ2O6P8YeeSIqRKKvzKejxs4sfeBm46Z/
g9wXlI91bA/JTyzTlVv73Xp6DsojjQ==
=iCGS
-----END PGP SIGNATURE-----

--5qLWyaaWQYJdxWWT3PJz63qPAzgCSHKz4--


