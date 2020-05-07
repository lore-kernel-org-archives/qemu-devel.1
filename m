Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6A0C38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 09:27:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C9BF20870
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 09:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bDMgJAIz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C9BF20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWcod-00088y-IY
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 05:27:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jWco1-0007Ys-NQ
 for qemu-devel@nongnu.org; Thu, 07 May 2020 05:27:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36275
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jWco0-0001HE-Sc
 for qemu-devel@nongnu.org; Thu, 07 May 2020 05:27:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588843619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3jAj7/8aIeRERQdPZo7DUUI/RhXcJzSiVtXKrfyD5j4=;
 b=bDMgJAIzWywG2kSp4yH+3lQM4XXfYvizJGJRu8GaLCim4mhCMEwB8kLBEIFwYmwfAIs1ay
 0zxvjXM2DX1TIwhS0NqFE+EX9JLuhYw3Jzswaa9QdVMtPMQu/3Rusd8GQ7qkFkIwxnOLQh
 WuRKOh3FSZF3p5BE27XJgWNcKMM1Y/E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-OAi9U1NqNJCk4UKd5Yv8SQ-1; Thu, 07 May 2020 05:26:54 -0400
X-MC-Unique: OAi9U1NqNJCk4UKd5Yv8SQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1F5E1005510;
 Thu,  7 May 2020 09:26:53 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-92.ams2.redhat.com
 [10.36.114.92])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 514CD579AD;
 Thu,  7 May 2020 09:26:51 +0000 (UTC)
Subject: Re: [PATCH v3 18/33] block: Add bdrv_default_perms()
To: Kevin Wolf <kwolf@redhat.com>
References: <20200218124242.584644-1-mreitz@redhat.com>
 <20200218124242.584644-19-mreitz@redhat.com>
 <20200506134712.GG6333@linux.fritz.box>
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
Message-ID: <96f61257-4d85-816a-e114-f3ebefdda029@redhat.com>
Date: Thu, 7 May 2020 11:26:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200506134712.GG6333@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qoN9KoiKYLiLnB6icOCcfO36HcKy6ZpGo"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 03:56:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qoN9KoiKYLiLnB6icOCcfO36HcKy6ZpGo
Content-Type: multipart/mixed; boundary="ohCnhBjC3Rsb1GhwyJ8kJ27GjLVZFNWQj"

--ohCnhBjC3Rsb1GhwyJ8kJ27GjLVZFNWQj
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06.05.20 15:47, Kevin Wolf wrote:
> Am 18.02.2020 um 13:42 hat Max Reitz geschrieben:
>> This callback can be used by BDSs that use child_of_bds with the
>> appropriate BdrvChildRole for their children.
>>
>> Also, make bdrv_format_default_perms() use it for child_of_bds children
>> (just a temporary solution until we can drop bdrv_format_default_perms()
>> altogether).
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> ---
>>  block.c                   | 46 ++++++++++++++++++++++++++++++++-------
>>  include/block/block_int.h | 11 ++++++++++
>>  2 files changed, 49 insertions(+), 8 deletions(-)
>>
>> diff --git a/block.c b/block.c
>> index c0ba274743..3e5b0bc345 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -2383,14 +2383,12 @@ static void bdrv_default_perms_for_metadata(Bloc=
kDriverState *bs, BdrvChild *c,
>>      *nshared =3D shared;
>>  }
>> =20
>> -/* TODO: Use */
>> -static void __attribute__((unused))
>> -bdrv_default_perms_for_data(BlockDriverState *bs, BdrvChild *c,
>> -                            const BdrvChildClass *child_class,
>> -                            BdrvChildRole role,
>> -                            BlockReopenQueue *reopen_queue,
>> -                            uint64_t perm, uint64_t shared,
>> -                            uint64_t *nperm, uint64_t *nshared)
>> +static void bdrv_default_perms_for_data(BlockDriverState *bs, BdrvChild=
 *c,
>> +                                        const BdrvChildClass *child_cla=
ss,
>> +                                        BdrvChildRole role,
>> +                                        BlockReopenQueue *reopen_queue,
>> +                                        uint64_t perm, uint64_t shared,
>> +                                        uint64_t *nperm, uint64_t *nsha=
red)
>>  {
>>      assert(child_class =3D=3D &child_of_bds && (role & BDRV_CHILD_DATA)=
);
>> =20
>> @@ -2425,6 +2423,13 @@ void bdrv_format_default_perms(BlockDriverState *=
bs, BdrvChild *c,
>>                                 uint64_t *nperm, uint64_t *nshared)
>>  {
>>      bool backing =3D (child_class =3D=3D &child_backing);
>> +
>> +    if (child_class =3D=3D &child_of_bds) {
>> +        bdrv_default_perms(bs, c, child_class, role, reopen_queue,
>> +                           perm, shared, nperm, nshared);
>> +        return;
>> +    }
>> +
>>      assert(child_class =3D=3D &child_backing || child_class =3D=3D &chi=
ld_file);
>> =20
>>      if (!backing) {
>> @@ -2436,6 +2441,31 @@ void bdrv_format_default_perms(BlockDriverState *=
bs, BdrvChild *c,
>>      }
>>  }
>> =20
>> +void bdrv_default_perms(BlockDriverState *bs, BdrvChild *c,
>> +                        const BdrvChildClass *child_class, BdrvChildRol=
e role,
>> +                        BlockReopenQueue *reopen_queue,
>> +                        uint64_t perm, uint64_t shared,
>> +                        uint64_t *nperm, uint64_t *nshared)
>> +{
>> +    assert(child_class =3D=3D &child_of_bds);
>> +
>> +    if (role & BDRV_CHILD_FILTERED) {
>> +        bdrv_filter_default_perms(bs, c, child_class, role, reopen_queu=
e,
>> +                                  perm, shared, nperm, nshared);
>> +    } else if (role & BDRV_CHILD_COW) {
>> +        bdrv_default_perms_for_backing(bs, c, child_class, role, reopen=
_queue,
>> +                                       perm, shared, nperm, nshared);
>> +    } else if (role & BDRV_CHILD_METADATA) {
>> +        bdrv_default_perms_for_metadata(bs, c, child_class, role, reope=
n_queue,
>> +                                        perm, shared, nperm, nshared);
>> +    } else if (role & BDRV_CHILD_DATA) {
>> +        bdrv_default_perms_for_data(bs, c, child_class, role, reopen_qu=
eue,
>> +                                    perm, shared, nperm, nshared);
>> +    } else {
>> +        g_assert_not_reached();
>> +    }
>> +}
>=20
> Here the discussion from the start of the series becomes relevant: Which
> flags can be combined with which other flags, and if multiple flags are
> set, which one takes precedence?
>=20
> First undocumented requirement: You must set at least one of FILTERED,
> COW, METADATA and DATA.
>=20
> Then, for FILTERED we decided to document that DATA shouldn't be set at
> the same time. I guess neither should COW and METADATA. Apart for
> documentation, worth an assertion?
>=20
> COW seems to be exclusive in practice, too. I guess you could construct
> a driver that somehow keeps its own (meta)data in its backing file,
> maybe in the VM state area. It also sounds like a really bad idea. So
> forbid it, document it and assert it, too?

Sounds all good.

> METADATA and DATA can be set at the same time. As your previous patch
> shows, the function for DATA is a laxer version of the one for METADATA,
> requesting a subset of the METADATA permissions and sharing a superset.
> So the order in the code makes sense.
>=20
> But can we make sure that this condition will be true in the future?
> Imagine we find a need for a new permission that is used for data files,
> but not for metadata. I think at the very least, this deserves a
> comment. But probably it means that both should stay a single function
> that can check each flag for the exact permission bits it influences.

Maybe, I=E2=80=99ll see whether it looks good.  If it doesn=E2=80=99t, I co=
uld also
rename the _metadata function to _storage, so that it=E2=80=99s generally a
function that handles metadata+data children (i.e. defined to be
stricter than the _data function).

Max


--ohCnhBjC3Rsb1GhwyJ8kJ27GjLVZFNWQj--

--qoN9KoiKYLiLnB6icOCcfO36HcKy6ZpGo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6z1FkACgkQ9AfbAGHV
z0CsywgAqBMUvrEXOBiJnKHxO6P4wkUCZDkEC9757MLpqgBbBSe+pxFcjWZIehVT
1dUtb6gogtkwavlPd89aiXPo2MBEui1WCmYuvL3DFB2jclg4Dg3JMru5e9zcZb+r
GIAq7h8/DwpXfdHn1am9/q02cc6aw4k2vSEWDjE2aK/XMdN0ZlvgSm0DHv2Rb1mr
pXOBaoHLYiVOBBe52/D80Cibai4CN60Akvrm5RExgcpQ3sPzyQQ0Pdb1qe5czzh6
DZT/9TBeEoUI8d8/JBqlqruFd7bXm3Os2DrjWgqkZ4v3fA1bESHCD6RceFT5+DZ6
ZqBUZfBy1YLG/qsa7t/a51o5CqMbWQ==
=BI5s
-----END PGP SIGNATURE-----

--qoN9KoiKYLiLnB6icOCcfO36HcKy6ZpGo--


