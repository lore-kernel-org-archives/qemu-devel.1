Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B47C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 08:03:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E9B220B1F
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 08:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hOEeciwi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E9B220B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxnFm-0003YM-LV
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 04:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jxnEg-0002Y7-Fw
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 04:02:50 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22037
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jxnEd-0002dg-DK
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 04:02:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595318565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OtLmgmRYozzvyDN1Ns8X/iKE6xRukz4E5XvZh2SRFa8=;
 b=hOEeciwixh3ZEkxRydjvW3qz3yp2FCWBLt9sm0EQABTsKpBgxnvRIeux3oaiMNB96rr0Sy
 WroJPt7oWkEqQBpj3DuYJTBB5UQhVSDdBdyb/QifhM+nOMbZxoc/oDDdM8JDYRdRQobkNl
 A/G28QUVwKcj5aueVoeeK4iflfSDlzM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-wSpRMyp6PuqszxLVTaMCIA-1; Tue, 21 Jul 2020 04:02:43 -0400
X-MC-Unique: wSpRMyp6PuqszxLVTaMCIA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76AAD800460;
 Tue, 21 Jul 2020 08:02:42 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-68.ams2.redhat.com
 [10.36.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 31BF1872FD;
 Tue, 21 Jul 2020 08:02:40 +0000 (UTC)
Subject: Re: [PATCH v2 1/3] migration: Add block-bitmap-mapping parameter
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200716135303.319502-1-mreitz@redhat.com>
 <20200716135303.319502-2-mreitz@redhat.com>
 <ab6c9048-868f-23bc-5366-ca53f11f01a5@virtuozzo.com>
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
Message-ID: <c6245682-d688-1596-964c-8b08c46e53fd@redhat.com>
Date: Tue, 21 Jul 2020 10:02:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ab6c9048-868f-23bc-5366-ca53f11f01a5@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="82leYXn046kF4QNaT6bD0e4JVFeVLpelu"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 03:39:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 Juan Quintela <quintela@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--82leYXn046kF4QNaT6bD0e4JVFeVLpelu
Content-Type: multipart/mixed; boundary="pIfcnmXylONN5OfLc1u3QVvthft9aWZLe"

--pIfcnmXylONN5OfLc1u3QVvthft9aWZLe
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 20.07.20 18:31, Vladimir Sementsov-Ogievskiy wrote:
> 16.07.2020 16:53, Max Reitz wrote:
>> This migration parameter allows mapping block node names and bitmap
>> names to aliases for the purpose of block dirty bitmap migration.
>>
>> This way, management tools can use different node and bitmap names on
>> the source and destination and pass the mapping of how bitmaps are to be
>> transferred to qemu (on the source, the destination, or even both with
>> arbitrary aliases in the migration stream).
>>
>> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> Vladimir noted in v1 that it would be better to ignore bitmaps whose
>> names aren't mapped, or that are on nodes whose names aren't mapped.
>> One of the reasons he gave was that bitmap migration is inherently a
>> form of postcopy migration, and we should not break the target when it
>> is already running because of a bitmap issue.
>>
>> So in this version, I changed the behavior to just ignore bitmaps
>> without a mapping on the source side.=C2=A0 On the destination, however,=
 I
>> kept it an error when an incoming bitmap or node alias is unknown.
>>
>> This is in violation of Vladimir's (rightful) reasoning that such
>> errors should never break the already running target, but I decided to
>> do so anyway for a couple of reasons:
>>
>> - Ignoring unmapped bitmaps on the source is trivial: We just have to
>> =C2=A0=C2=A0 not put them into the migration stream.
>> =C2=A0=C2=A0 On the destination, it isn't so easy: We (I think) would ha=
ve to
>> =C2=A0=C2=A0 modify the code to actively skip the bitmap in the stream.
>> =C2=A0=C2=A0 (On the other hand, erroring out is always easy.)
>=20
> Agree. Actually, my series "[PATCH v2 00/22] Fix error handling during
> bitmap postcopy"
> do something like this. But no sense in mixing such logic into your
> series :)
>=20
>>
>> - Incoming bitmaps with unknown names are already an error before this
>> =C2=A0=C2=A0 series.=C2=A0 So this isn't introducing new breakage.
>>
>> - I think it makes sense to drop all bitmaps you don't want to migrate
>> =C2=A0=C2=A0 (or implicitly drop them by just not specifying them if you=
 don't care
>> =C2=A0=C2=A0 about them) on the source.=C2=A0 I can't imagine a scenario=
 where it would
>> =C2=A0=C2=A0 be really useful if the destination could silently drop unk=
nown
>> =C2=A0=C2=A0 bitmaps.=C2=A0 Unknown bitmaps should just be dropped on th=
e source.
>>
>> - Choosing to make it an error now doesn't prevent us from relaxing that
>> =C2=A0=C2=A0 restriction in the future.
>=20
> Agree, that's all OK. Still we can at least ignore, if we don't get some
> bitmap on destination, for which mapping is set (I think you do exactly
> this, will see below).
>=20
>=20
>> ---
>> =C2=A0 qapi/migration.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 92 +++++++-
>> =C2=A0 migration/migration.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +
>> =C2=A0 migration/block-dirty-bitmap.c | 373 ++++++++++++++++++++++++++++=
-----
>> =C2=A0 migration/migration.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 30 +++
>> =C2=A0 monitor/hmp-cmds.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 30 +++
>> =C2=A0 5 files changed, 473 insertions(+), 55 deletions(-)
>>
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index d5000558c6..1b0fbcef96 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -507,6 +507,44 @@
>=20
> [..]
>=20
>> =C2=A0 #
>> +# @block-bitmap-mapping: Maps block nodes and bitmaps on them to
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aliases for the=
 purpose of dirty bitmap migration.=C2=A0 Such
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aliases may for=
 example be the corresponding names on the
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 opposite site.
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The mapping mus=
t be one-to-one, and on the destination also
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 complete: On th=
e source, bitmaps on nodes where either the
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitmap or the n=
ode is not mapped will be ignored.=C2=A0 In
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 contrast, on th=
e destination, receiving a bitmap (by alias)
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from a node (by=
 alias) when either alias is not mapped will
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result in an er=
ror.
>=20
> Still, not receiving some bitmap is not an error. It's good. I think,
> should
> be mentioned here too (does it violate "compelete" term?).

Hm.  Well, from the implementation=E2=80=99s perspective, it obviously isn=
=E2=80=99t an
error, because there=E2=80=99s no list of bitmaps that=E2=80=99s transferre=
d outside of
the bitmaps themselves; so if some bitmap isn=E2=80=99t transferred, the
destination of course never knows about it.  (And =E2=80=9Ccomplete=E2=80=
=9D just means
that all received bitmaps must be mapped.)

So I never thought about mentioning that detail here.

How would we even go about documenting that?  =E2=80=9CNote that the destin=
ation
does not know about bitmaps it does not receive, so there is no
limitation or requirement about the number of bitmaps received, or how
they are named, or on which nodes they are placed.=E2=80=9D

>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 By default (whe=
n this parameter has never been set), bitmap
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 names are mappe=
d to themselves.=C2=A0 Nodes are mapped to their
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 block device na=
me if there is one, and to their node name
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 otherwise. (Sin=
ce 5.2)
>> +#
>> =C2=A0 # Since: 2.4
>=20
> [..]
>=20
>> -static int dirty_bitmap_load_header(QEMUFile *f, DirtyBitmapLoadState
>> *s)
>> +static int dirty_bitmap_load_header(QEMUFile *f, DirtyBitmapLoadState
>> *s,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GHashTab=
le *alias_map)
>> =C2=A0 {
>> +=C2=A0=C2=A0=C2=A0 GHashTable *bitmap_alias_map =3D NULL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error *local_err =3D NULL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool nothing;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->flags =3D qemu_get_bitmap_flags(f);
>> @@ -676,25 +890,68 @@ static int dirty_bitmap_load_header(QEMUFile *f,
>> DirtyBitmapLoadState *s)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nothing =3D s->flags =3D=3D (s->flags & D=
IRTY_BITMAP_MIG_FLAG_EOS);
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s->flags & DIRTY_BITMAP_MIG_FL=
AG_DEVICE_NAME) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!qemu_get_counted_string=
(f, s->node_name)) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 erro=
r_report("Unable to read node name string");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!qemu_get_counted_string=
(f, s->node_alias)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 erro=
r_report("Unable to read node alias string");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return -EINVAL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->bs =3D bdrv_lookup_bs(s->=
node_name, s->node_name, &local_err);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (alias_map) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cons=
t AliasMapInnerNode *amin;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 amin=
 =3D g_hash_table_lookup(alias_map, s->node_alias);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (=
!amin) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 error_report("Error: Unknown node alias '%s'",
>> s->node_alias);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitm=
ap_alias_map =3D amin->subtree;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->b=
s =3D bdrv_lookup_bs(NULL, amin->string, &local_err);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->b=
s =3D bdrv_lookup_bs(s->node_alias, s->node_alias,
>> &local_err);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!s->bs) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 error_report_err(local_err);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return -EINVAL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 } else if (!s->bs && !nothing) {
>> +=C2=A0=C2=A0=C2=A0 } else if (s->bs) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (alias_map) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cons=
t AliasMapInnerNode *amin;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* M=
ust be present in the map, or s->bs would not be set */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 amin=
 =3D g_hash_table_lookup(alias_map, s->node_alias);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 asse=
rt(amin !=3D NULL);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitm=
ap_alias_map =3D amin->subtree;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 } else if (!nothing) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("Err=
or: block device name is not set");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 +=C2=A0=C2=A0=C2=A0 assert(!!alias_map =3D=3D !!bitmap_alias_map)=
;
>=20
> Actually one '!' is enough. But '!!' looks good too (usual convertion to
> bool, why not).
>=20
> But what's more serious: this assertion will fail in case of "nothing"
> (sorry my architecture :(.
>=20
> I assume, by protocol, chunk with EOS flag may contain bitmap and/or
> node information or may not.
>=20
> So, it most probably should be: assert(nothing || (!alias_map =3D=3D
> !bitmap_alias_map))

Right, sure.

> (You can cover "nothing" case in test, if enable bitmap migrations when
> no bitmaps to migrate)

Thanks, will do.

>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s->flags & DIRTY_BITMAP_MIG_FLAG_BITM=
AP_NAME) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!qemu_get_counted_string=
(f, s->bitmap_name)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *bitmap_name;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!qemu_get_counted_string=
(f, s->bitmap_alias)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 error_report("Unable to read bitmap name string");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return -EINVAL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bitmap_alias_map) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitm=
ap_name =3D g_hash_table_lookup(bitmap_alias_map,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->bitmap_alias);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (=
!bitmap_name) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 error_report("Error: Unknown bitmap alias '%s' on
>> node '%s' "
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 "(alias '%s')", s->bitmap_alias,
>> s->bs->node_name,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 s->node_alias);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitm=
ap_name =3D s->bitmap_alias;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_strlcpy(s->bitmap_name, bi=
tmap_name, sizeof(s->bitmap_name));
>=20
> Hmm. Actually, we should check that in alias map target bitmap_name is
> short enough. It may be done later.

OK.

>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->bitmap =3D bdr=
v_find_dirty_bitmap(s->bs, s->bitmap_name);
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* bitmap =
may be NULL here, it wouldn't be an error if it
>> is the
>> @@ -702,7 +959,7 @@ static int dirty_bitmap_load_header(QEMUFile *f,
>> DirtyBitmapLoadState *s)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!s->bitmap &&=
 !(s->flags & DIRTY_BITMAP_MIG_FLAG_START)) {
>=20
>=20
> OK, with assertion fixed;
>=20
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Thanks again!

> It's a bit weak, because:
>=20
> =C2=A0- I don't have good understanding all these migration parameters lo=
gics
> with this triple duplication. So if it works in test, it should be good
> enough.

I hope so, yes.

> =C2=A0- The whole logic of bitmap migration is a bit hard to follow (I kn=
ow,
> that it's my code :).

O:)

> I'll revisit it when rebasing my big series
> "[PATCH v2 00/22] Fix error handling during bitmap postcopy".



--pIfcnmXylONN5OfLc1u3QVvthft9aWZLe--

--82leYXn046kF4QNaT6bD0e4JVFeVLpelu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8WoR0ACgkQ9AfbAGHV
z0AfpwgAkhhtuDFKdXKQ6Ow4FVTNxmnVzigxp36c84LYaV+3oLSnZ7OpPAvirZay
CfzybIvhnBEnKzTTmXwjOSwwotqAnidNDJz1cjAHmGGz/oEfmjs6RG/XrR2nkQEh
k+kcuPOI4z3Q/OOSr/ebhbd1pbl166/c2vtg5z0GEZpHi5PiSEr/t9qP0UIzwFIO
nO1D3cxYKO+4wIwd2+XAazxN2aVdbZu9ShbncYzn8JTpknAuDrEbmt9t2ry2jUSp
i1UW6nrYv4FyXPPQprm+8DOSYhM7KhUDU5TLBkJCtnHY4uaxQ/WORcMBH/MaNdNM
2kkswmM8nI9WyZ8S292NmGmNwE1UFA==
=5HGo
-----END PGP SIGNATURE-----

--82leYXn046kF4QNaT6bD0e4JVFeVLpelu--


