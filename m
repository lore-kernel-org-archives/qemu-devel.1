Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CF1C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 08:10:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A183D20772
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 08:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e/vpCq4I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A183D20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jquJ7-0003CX-Qr
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 04:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jquIO-0002Un-0F
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 04:10:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53255
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jquIJ-0002aG-8D
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 04:10:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593677405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yllB/i51zkHQoMzTnd7ah+TnMqND3DVpjdogVL9HiMg=;
 b=e/vpCq4IxpcmhO22bAOISVYoPiZCZOg/gSrQ51eo+yShIOkC3eo8YwRTvxuhQ/i4GtPOJ0
 oN8EY3aiownicf1ucOs0NKOAmx4cStYvRDJtbapOJb+CxzYFTNd90USl9ZnSl0s5Atk+PH
 XKPurjQsAr05wH7G1i9Fydsu56d8014=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-rDLkn7o0MEu8wfaS0fHcDA-1; Thu, 02 Jul 2020 04:10:03 -0400
X-MC-Unique: rDLkn7o0MEu8wfaS0fHcDA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12CE1879535;
 Thu,  2 Jul 2020 08:10:02 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-196.ams2.redhat.com
 [10.36.113.196])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9AA9D778AC;
 Thu,  2 Jul 2020 08:09:54 +0000 (UTC)
Subject: Re: [PATCH 2/4] migration: Add block-bitmap-mapping parameter
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200630084552.46362-1-mreitz@redhat.com>
 <20200630084552.46362-3-mreitz@redhat.com>
 <635e40aa-f289-da2f-274f-17c9d0e05003@virtuozzo.com>
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
Message-ID: <02586cc8-138c-2bc8-c79a-cf3371a5afd4@redhat.com>
Date: Thu, 2 Jul 2020 10:09:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <635e40aa-f289-da2f-274f-17c9d0e05003@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="czcKGCLsG8b3sUpoV4EBw4BE588T6P2r5"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 04:00:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--czcKGCLsG8b3sUpoV4EBw4BE588T6P2r5
Content-Type: multipart/mixed; boundary="BJhyXDWL3PPZFkfjVPWtWgXg5uIfY23tH"

--BJhyXDWL3PPZFkfjVPWtWgXg5uIfY23tH
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 01.07.20 16:34, Vladimir Sementsov-Ogievskiy wrote:
> 30.06.2020 11:45, Max Reitz wrote:
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
>> =C2=A0 qapi/migration.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 83 +++++++-
>> =C2=A0 migration/migration.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +
>> =C2=A0 migration/block-dirty-bitmap.c | 372 ++++++++++++++++++++++++++++=
-----
>> =C2=A0 migration/migration.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 29 +++
>> =C2=A0 4 files changed, 432 insertions(+), 55 deletions(-)
>>
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index d5000558c6..5aeae9bea8 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -507,6 +507,44 @@
>> =C2=A0=C2=A0=C2=A0 'data': [ 'none', 'zlib',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 { 'name': 'zstd', 'if': 'defined(CONFIG_ZSTD)' } ] }
>> =C2=A0 +##
>> +# @BitmapMigrationBitmapAlias:
>> +#
>> +# @name: The name of the bitmap.
>> +#
>> +# @alias: An alias name for migration (for example the bitmap name on
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the opposite site).
>> +#
>> +# Since: 5.1
>> +##
>> +{ 'struct': 'BitmapMigrationBitmapAlias',
>> +=C2=A0 'data': {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'name': 'str',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'alias': 'str'
>> +=C2=A0 } }
>> +
>> +##
>> +# @BitmapMigrationNodeAlias:
>> +#
>> +# Maps a block node name and the bitmaps it has to aliases for dirty
>> +# bitmap migration.
>> +#
>> +# @node-name: A block node name.
>> +#
>> +# @alias: An alias block node name for migration (for example the
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node name on the oppo=
site site).
>> +#
>> +# @bitmaps: Mappings for the bitmaps on this node.
>> +#
>> +# Since: 5.1
>> +##
>> +{ 'struct': 'BitmapMigrationNodeAlias',
>> +=C2=A0 'data': {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'node-name': 'str',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'alias': 'str',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'bitmaps': [ 'BitmapMigrationBitmapAlias=
' ]
>=20
> So, we still can't migrate bitmaps from one node to different nodes, but =
we
> also don't know a usecase for it, so it seems OK. But with such scheme we
> can select and rename bitmaps in-flight, and Peter said about correspondi=
ng
> use-case.
>=20
> I'm OK with this, still, just an idea in my mind:
>=20
> we could instead just have a list of
>=20
> BitmapMigrationAlias: {
> =C2=A0node-name
> =C2=A0bitmap-name
> =C2=A0node-alias
> =C2=A0bitmap-alias
> }
>=20
> so, mapping is set for each bitmap in separate.

Well, OK, but why?

>> +=C2=A0 } }
>> +
>> =C2=A0 ##
>> =C2=A0 # @MigrationParameter:
>> =C2=A0 #
>> @@ -641,6 +679,18 @@
>> =C2=A0 #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 will cons=
ume more CPU.
>> =C2=A0 #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Defaults =
to 1. (Since 5.0)
>> =C2=A0 #
>> +# @block-bitmap-mapping: Maps block nodes and bitmaps on them to
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aliases for the=
 purpose of dirty bitmap migration.=C2=A0 Such
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aliases may for=
 example be the corresponding names on the
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 opposite site.
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The mapping mus=
t be one-to-one and complete: On the source,
>=20
> I've recently faced the case where incomplete mapping make sence: shared
> migration of read-only bitmaps in backing files: it seems better to not
> migrate them through migration channel, they are migrating through
> shared storage automatically (yes, we'll pay the time to load them on
> destination, but I'm going to improve it by implementing lazy load of
> read-only and disabled bitmaps, so this will not be a problem).
>=20
> So, now I think that it would be good just ignore all the bitmap not
> described by mapping

OK.

>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 migrating a bit=
map from a node when either is not mapped
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 will result in =
an error.=C2=A0 On the destination, similarly,
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 receiving a bit=
map (by alias) from a node (by alias) when
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 either alias is=
 not mapped will result in an error.
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 By default, all=
 node names and bitmap names are mapped to
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 themselves. (Si=
nce 5.1)
>=20
> This sentense is unclear, want means "by default" - if the mapping is
> not specified at all or if some nodes/bitmaps are not covered.

It is clear.

> Still,
> tha latter will conflict with previous sentencies, so "by default" is
> about when mapping is not set at all.

Precisely.

> I suggest to word it directly:
> "If mapping is not set (the command never called, or mapping was
> removed".

The mapping cannot be removed.

It=E2=80=99s also technically clear because mentioning a default for some
parameter always means that that particular parameter will have that
default.  So in this case =E2=80=9Cby default=E2=80=9D refers to block-bitm=
ap-mapping,
not anything nested in it.  (Defaults for stuff nested in its value
would be described in the respective structs=E2=80=99 definitions.)

I=E2=80=99d be OK with =E2=80=9CBy default (when this parameter has never b=
een set)=E2=80=A6=E2=80=9D.

> And, actual behavior without mapping is not as simple: it actually tries
> to use blk names if possible and node-names if not, and this veries
> from version to version. So, I think not worth to document it in detail,
> just note, that without mapping the behavior is not well defined and
> tries to use block-device name if possible and node-name otherwise. And
> of course direct mapping of bitmap names.

OK.

>> +#
>> =C2=A0 # Since: 2.4
>> =C2=A0 ##
>> =C2=A0 { 'enum': 'MigrationParameter',
>> @@ -655,7 +705,8 @@
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 'multifd-channels',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 'xbzrle-cache-size', 'max-postcopy-bandwidth',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 'max-cpu-throttle', 'multifd-compression',
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'multifd-z=
lib-level' ,'multifd-zstd-level' ] }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'multifd-z=
lib-level' ,'multifd-zstd-level',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'block-bit=
map-mapping' ] }
>> =C2=A0 =C2=A0 ##
>> =C2=A0 # @MigrateSetParameters:
>> @@ -781,6 +832,18 @@
>> =C2=A0 #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 will cons=
ume more CPU.
>> =C2=A0 #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Defaults =
to 1. (Since 5.0)
>> =C2=A0 #
>> +# @block-bitmap-mapping: Maps block nodes and bitmaps on them to
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aliases for the=
 purpose of dirty bitmap migration.=C2=A0 Such
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aliases may for=
 example be the corresponding names on the
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 opposite site.
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The mapping mus=
t be one-to-one and complete: On the source,
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 migrating a bit=
map from a node when either is not mapped
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 will result in =
an error.=C2=A0 On the destination, similarly,
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 receiving a bit=
map (by alias) from a node (by alias) when
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 either alias is=
 not mapped will result in an error.
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 By default, all=
 node names and bitmap names are mapped to
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 themselves. (Si=
nce 5.1)
>=20
> Do we really need this duplication? I'd prefere to document it once if
> possible.

Well, or maybe this just shouldn=E2=80=99t be a migration parameter.  I don=
=E2=80=99t know.

I don=E2=80=99t really want to move this documentation or even just parts o=
f it
to BitmapMigrationNodeAlias, because that=E2=80=99s just one element of the
whole list.

>> +#
>> =C2=A0 # Since: 2.4
>> =C2=A0 ##
>> =C2=A0 # TODO either fuse back into MigrationParameters, or make
>> @@ -811,7 +874,8 @@
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 '*max-cpu-throttle': 'int',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 '*multifd-compression': 'MultiFDCompression',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 '*multifd-zlib-level': 'int',
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '*mu=
ltifd-zstd-level': 'int' } }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '*mu=
ltifd-zstd-level': 'int',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '*bl=
ock-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ] } }
>> =C2=A0 =C2=A0 ##
>> =C2=A0 # @migrate-set-parameters:
>> @@ -957,6 +1021,18 @@
>> =C2=A0 #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 will cons=
ume more CPU.
>> =C2=A0 #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Defaults =
to 1. (Since 5.0)
>> =C2=A0 #
>> +# @block-bitmap-mapping: Maps block nodes and bitmaps on them to
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aliases for the=
 purpose of dirty bitmap migration.=C2=A0 Such
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aliases may for=
 example be the corresponding names on the
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 opposite site.
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The mapping mus=
t be one-to-one and complete: On the source,
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 migrating a bit=
map from a node when either is not mapped
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 will result in =
an error.=C2=A0 On the destination, similarly,
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 receiving a bit=
map (by alias) from a node (by alias) when
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 either alias is=
 not mapped will result in an error.
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 By default, all=
 node names and bitmap names are mapped to
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 themselves. (Si=
nce 5.1)
>=20
> once again..
>=20
>> +#
>> =C2=A0 # Since: 2.4
>> =C2=A0 ##
>> =C2=A0 { 'struct': 'MigrationParameters',
>> @@ -985,7 +1061,8 @@
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 '*max-cpu-throttle': 'uint8',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 '*multifd-compression': 'MultiFDCompression',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 '*multifd-zlib-level': 'uint8',
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '*mu=
ltifd-zstd-level': 'uint8' } }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '*mu=
ltifd-zstd-level': 'uint8',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '*bl=
ock-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ] } }
>> =C2=A0 =C2=A0 ##
>> =C2=A0 # @query-migrate-parameters:
>> diff --git a/migration/migration.h b/migration/migration.h
>> index f617960522..038c318b92 100644
>> --- a/migration/migration.h
>> +++ b/migration/migration.h
>> @@ -336,6 +336,9 @@ void
>> migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value);
>> =C2=A0 =C2=A0 void dirty_bitmap_mig_before_vm_start(void);
>> =C2=A0 void init_dirty_bitmap_incoming_migration(void);
>> +bool check_dirty_bitmap_mig_alias_map(const
>> BitmapMigrationNodeAliasList *bbm,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 Error **errp);
>> +
>> =C2=A0 void migrate_add_address(SocketAddress *address);
>> =C2=A0 =C2=A0 int foreach_not_ignored_block(RAMBlockIterFunc func, void =
*opaque);
>> diff --git a/migration/block-dirty-bitmap.c
>> b/migration/block-dirty-bitmap.c
>> index 47bc0f650c..621eb7e3f8 100644
>> --- a/migration/block-dirty-bitmap.c
>> +++ b/migration/block-dirty-bitmap.c
>> @@ -29,10 +29,10 @@
>> =C2=A0=C2=A0 *
>> =C2=A0=C2=A0 * # Header (shared for different chunk types)
>> =C2=A0=C2=A0 * 1, 2 or 4 bytes: flags (see qemu_{put,put}_flags)
>> - * [ 1 byte: node name size ] \=C2=A0 flags & DEVICE_NAME
>> - * [ n bytes: node name=C2=A0=C2=A0=C2=A0=C2=A0 ] /
>> - * [ 1 byte: bitmap name size ] \=C2=A0 flags & BITMAP_NAME
>> - * [ n bytes: bitmap name=C2=A0=C2=A0=C2=A0=C2=A0 ] /
>> + * [ 1 byte: node alias size ] \=C2=A0 flags & DEVICE_NAME
>> + * [ n bytes: node alias=C2=A0=C2=A0=C2=A0=C2=A0 ] /
>> + * [ 1 byte: bitmap alias size ] \=C2=A0 flags & BITMAP_NAME
>> + * [ n bytes: bitmap alias=C2=A0=C2=A0=C2=A0=C2=A0 ] /
>> =C2=A0=C2=A0 *
>> =C2=A0=C2=A0 * # Start of bitmap migration (flags & START)
>> =C2=A0=C2=A0 * header
>> @@ -72,7 +72,9 @@
>> =C2=A0 #include "migration/register.h"
>> =C2=A0 #include "qemu/hbitmap.h"
>> =C2=A0 #include "qemu/cutils.h"
>> +#include "qemu/id.h"
>> =C2=A0 #include "qapi/error.h"
>> +#include "qapi/qapi-commands-migration.h"
>> =C2=A0 #include "trace.h"
>> =C2=A0 =C2=A0 #define CHUNK_SIZE=C2=A0=C2=A0=C2=A0=C2=A0 (1 << 10)
>> @@ -103,7 +105,8 @@
>> =C2=A0 typedef struct DirtyBitmapMigBitmapState {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Written during setup phase. */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockDriverState *bs;
>> -=C2=A0=C2=A0=C2=A0 const char *node_name;
>> +=C2=A0=C2=A0=C2=A0 char *node_alias;
>> +=C2=A0=C2=A0=C2=A0 char *bitmap_alias;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmap *bitmap;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t total_sectors;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t sectors_per_chunk;
>> @@ -128,7 +131,8 @@ typedef struct DirtyBitmapMigState {
>> =C2=A0 =C2=A0 typedef struct DirtyBitmapLoadState {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t flags;
>> -=C2=A0=C2=A0=C2=A0 char node_name[256];
>> +=C2=A0=C2=A0=C2=A0 char node_alias[256];
>> +=C2=A0=C2=A0=C2=A0 char bitmap_alias[256];
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char bitmap_name[256];
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockDriverState *bs;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmap *bitmap;
>> @@ -144,6 +148,162 @@ typedef struct DirtyBitmapLoadBitmapState {
>> =C2=A0 static GSList *enabled_bitmaps;
>> =C2=A0 QemuMutex finish_lock;
>> =C2=A0 +/* For hash tables that map node/bitmap names to aliases */
>> +typedef struct AliasMapInnerNode {
>> +=C2=A0=C2=A0=C2=A0 char *string;
>> +=C2=A0=C2=A0=C2=A0 GHashTable *subtree;
>> +} AliasMapInnerNode;
>=20
> Probably, would be simpler to have (node,bitmap) <->
> (node-alias,bitmap-alias) mapping than nested hash-tables, but this
> should work too, I don't have real arguments.

I=E2=80=99m not sure it would be simpler.  Instead of this, we=E2=80=99d ne=
ed a
structure to hold two strings (and hash and comparison functions for it,
though they=E2=80=99d be simple).

>> +
>> +static void free_alias_map_inner_node(void *amin_ptr)
>> +{
>> +=C2=A0=C2=A0=C2=A0 AliasMapInnerNode *amin =3D amin_ptr;
>> +
>> +=C2=A0=C2=A0=C2=A0 g_free(amin->string);
>> +=C2=A0=C2=A0=C2=A0 g_hash_table_unref(amin->subtree);
>> +=C2=A0=C2=A0=C2=A0 g_free(amin);
>> +}
>> +
>> +/**
>> + * Construct an alias map based on the given QMP structure.
>> + *
>> + * (Note that we cannot store such maps in the MigrationParameters
>> + * object, because that struct is defined by the QAPI schema, which
>> + * makes it basically impossible to have dicts with arbitrary keys.
>> + * Therefore, we instead have to construct these maps when migration
>> + * starts.)
>> + *
>> + * @bbm is the block_bitmap_mapping from the migration parameters.
>> + *
>> + * If @name_to_alias is true, the returned hash table will map node
>> + * and bitmap names to their respective aliases (for outgoing
>> + * migration).
>> + *
>> + * If @name_to_alias is false, the returned hash table will map node
>> + * and bitmap aliases to their respective names (for incoming
>> + * migration).
>> + *
>> + * The hash table maps node names/aliases to AliasMapInnerNode
>> + * objects, whose .string is the respective node alias/name, and whose
>> + * .subtree table maps bitmap names/aliases to the respective bitmap
>> + * alias/name.
>> + */
>> +static GHashTable *construct_alias_map(const
>> BitmapMigrationNodeAliasList *bbm,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 bool name_to_alias,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 Error **errp)
>> +{
>> +=C2=A0=C2=A0=C2=A0 GHashTable *alias_map =3D NULL;
>=20
> dead assignment

Indeed.

>> +
>> +=C2=A0=C2=A0=C2=A0 alias_map =3D g_hash_table_new_full(g_str_hash, g_st=
r_equal,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 g_free,
>> free_alias_map_inner_node);
>> +
>> +=C2=A0=C2=A0=C2=A0 for (; bbm; bbm =3D bbm->next) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const BitmapMigrationNodeAli=
as *bmna =3D bbm->value;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const BitmapMigrationBitmapA=
liasList *bmbal;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AliasMapInnerNode *amin;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GHashTable *bitmaps_map;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *node_map_from, *=
node_map_to;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!id_wellformed(bmna->ali=
as)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 erro=
r_setg(errp, "The node alias %s is not well-formed",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bmna->alias=
);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto=
 fail;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (name_to_alias) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (=
g_hash_table_contains(alias_map, bmna->node_name)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "The node name %s is mapped twice",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 bmna->node_name);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto fail;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node=
_map_from =3D bmna->node_name;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node=
_map_to =3D bmna->alias;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (=
g_hash_table_contains(alias_map, bmna->alias)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "The node alias %s is used twice",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 bmna->alias);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto fail;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node=
_map_from =3D bmna->alias;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node=
_map_to =3D bmna->node_name;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitmaps_map =3D g_hash_table=
_new_full(g_str_hash, g_str_equal,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_free, g_free);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (bmbal =3D bmna->bitmaps=
; bmbal; bmbal =3D bmbal->next) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cons=
t BitmapMigrationBitmapAlias *bmba =3D bmbal->value;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cons=
t char *bmap_map_from, *bmap_map_to;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (=
name_to_alias) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 bmap_map_from =3D bmba->name;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 bmap_map_to =3D bmba->alias;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (g_hash_table_contains(bitmaps_map, bmba->name)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "The bitmap =
%s/%s is mapped twice",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bmna->node_name, bmba->name);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fail;
>=20
> bitmaps_map is leaked here and ..
>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } el=
se {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 bmap_map_from =3D bmba->alias;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 bmap_map_to =3D bmba->name;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (g_hash_table_contains(bitmaps_map, bmba->alias)) =
{
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "The bitmap =
alias %s/%s is used
>> twice",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bmna->alias, bmba->alias);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fail;
>=20
> .. here
>=20
> Probably, simplest way to fix is to create AliasMapIneerNode and insert
> it into alias_map immediately after allocating bitmaps_map (prior to
> this loop).

Ah, yes.

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_ha=
sh_table_insert(bitmaps_map,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_strdup(bmap_map_from),
>> g_strdup(bmap_map_to));
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 amin =3D g_new(AliasMapInner=
Node, 1);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *amin =3D (AliasMapInnerNode=
){
>=20
> style: space before '{'

Is that required?

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .str=
ing =3D g_strdup(node_map_to),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .sub=
tree =3D bitmaps_map,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_hash_table_insert(alias_ma=
p, g_strdup(node_map_from), amin);
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 return alias_map;
>> +
>> +fail:
>> +=C2=A0=C2=A0=C2=A0 g_hash_table_destroy(alias_map);
>> +=C2=A0=C2=A0=C2=A0 return NULL;
>> +}
>> +
>> +/**
>> + * Run construct_alias_map() in both directions to check whether @bbm
>> + * is valid.
>> + * (This function is to be used by migration/migration.c to validate
>> + * the user-specified block-bitmap-mapping migration parameter.)
>> + *
>> + * Returns true if and only if the mapping is valid.
>> + */
>> +bool check_dirty_bitmap_mig_alias_map(const
>> BitmapMigrationNodeAliasList *bbm,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 Error **errp)
>> +{
>> +=C2=A0=C2=A0=C2=A0 GHashTable *alias_map;
>> +
>> +=C2=A0=C2=A0=C2=A0 alias_map =3D construct_alias_map(bbm, true, errp);
>> +=C2=A0=C2=A0=C2=A0 if (!alias_map) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 g_hash_table_destroy(alias_map);
>> +
>> +=C2=A0=C2=A0=C2=A0 alias_map =3D construct_alias_map(bbm, false, errp);
>> +=C2=A0=C2=A0=C2=A0 if (!alias_map) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 g_hash_table_destroy(alias_map);
>> +
>> +=C2=A0=C2=A0=C2=A0 return true;
>> +}
>> +
>> =C2=A0 void init_dirty_bitmap_incoming_migration(void)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_mutex_init(&finish_lock);
>> @@ -191,11 +351,11 @@ static void send_bitmap_header(QEMUFile *f,
>> DirtyBitmapMigBitmapState *dbms,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_put_bitmap_flags(f, flags);
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (flags & DIRTY_BITMAP_MIG_FLAG_=
DEVICE_NAME) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_put_counted_string(f, d=
bms->node_name);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_put_counted_string(f, d=
bms->node_alias);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (flags & DIRTY_BITMAP_MIG_FLAG_=
BITMAP_NAME) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_put_counted_string(f, b=
drv_dirty_bitmap_name(bitmap));
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_put_counted_string(f, d=
bms->bitmap_alias);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 }
>> =C2=A0 @@ -263,15 +423,20 @@ static void dirty_bitmap_mig_cleanup(void)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QSIMPLEQ_REMOVE_H=
EAD(&dirty_bitmap_mig_state.dbms_list, entry);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap=
_set_busy(dbms->bitmap, false);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_unref(dbms->=
bs);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_free(dbms->node_alias);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_free(dbms->bitmap_alias);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_free(dbms);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 }
>> =C2=A0 =C2=A0 /* Called with iothread lock taken. */
>> -static int add_bitmaps_to_list(BlockDriverState *bs, const char
>> *bs_name)
>> +static int add_bitmaps_to_list(BlockDriverState *bs, const char
>> *bs_name,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GHashTable *alias_map)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmap *bitmap;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DirtyBitmapMigBitmapState *dbms;
>> +=C2=A0=C2=A0=C2=A0 GHashTable *bitmap_aliases;
>=20
> can bitmap_aliases be const ptr too?

Unfortunately no because g_hash_table_lookup() expects the hash table to
not be const, for whatever reason.

>> +=C2=A0=C2=A0=C2=A0 const char *node_alias, *bitmap_name, *bitmap_alias;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error *local_err =3D NULL;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitmap =3D bdrv_dirty_bitmap_first=
(bs);
>> @@ -279,21 +444,40 @@ static int add_bitmaps_to_list(BlockDriverState
>> *bs, const char *bs_name)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 +=C2=A0=C2=A0=C2=A0 bitmap_name =3D bdrv_dirty_bitmap_name(bitmap=
);
>=20
> Note, that bitmap is wrong here: it may be internal unnamed bitmap which
> we should ignore.
> I have sent a patch for this: "[PATCH] migration/block-dirty-bitmap: fix
> add_bitmaps_to_list"
>=20
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!bs_name || strcmp(bs_name, "") =3D=
=3D 0) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("Bit=
map '%s' in unnamed node can't be migrated",
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap_name(=
bitmap));
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitmap_name);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 if (bs_name[0] =3D=3D '#') {
>> +=C2=A0=C2=A0=C2=A0 if (alias_map) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const AliasMapInnerNode *ami=
n =3D
>> g_hash_table_lookup(alias_map, bs_name);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!amin) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 erro=
r_report("Bitmap '%s' on node '%s' with no alias
>> cannot be "
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 "migrated", bitmap_name, bs_name);
>=20
> As I've said before, it may be reasonable to ignore bitmaps not
> referenced in the hash-table.

No problem with that.  We just decided on this behavior when we
discussed the RFC.

> And it seems to be good default behavior. We are really tired from
> problems with bitmaps which
> can't migrate for different reasons, when bitmaps are actually
> non-critical data, and choosing
> from customer problems like:
>=20
> =C2=A01. - Hey, after update migration is broken! It says that some bitma=
ps
> can't be migrated, what is that?
> =C2=A0
> =C2=A02. - Hmm, it seems, that in some cases, incremental backup doesn't =
work
> after migration and full backup
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is automatically done instead.. Why?
>=20
> I now prefer the [2].
>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn -1;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node_alias =3D amin->string;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitmap_aliases =3D amin->sub=
tree;
>> +=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node_alias =3D bs_name;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitmap_aliases =3D NULL;
>> +=C2=A0=C2=A0=C2=A0 }
>=20
> Hmm, actually bs_name argument is incompatiblewith alias_map, let's
> assert that they are not non-null simultaneously.
>=20
> Ah stop, I see, you use bs_name as node-name later and before.. Hmm,
> seems all this a bit confused.
>=20
> Prior the patch, why do we have bs_name: because it may be node-name or
> blk-name, to be use in migration protocol as (actually) an alias, so
> bs_name is more like an alias..
>=20
> So, we have bs, which already have bs->node_name, we have alias_map,
> where we have relation node_name -> alias, and we have bs_name, which is
> something like an alias_name.
>=20
> I think the most clean thing is to allow only one of bs_name and
> alias_map to be non-null, use bs_name only for old scenario, and for new
> scenario use bdrv_get_node_name() for error-reporting. And a comment
> about function semantics won't hurt.
>=20
> upd: aha, I see that in case of new semantics, bs_name is exactly
> bdrv_get_node_name(). It's a bit redundant but OK too.. Let's at least
> add an assertion.

Now I=E2=80=99m confused.  What assertion?  I don=E2=80=99t think I want to=
 add an
assertion that exactly one of bs_name or alias_map is NULL, because that
would complicate the code.  The caller would have to pass NULL for
bs_name, and then add_bitmaps_to_list() would need to fetch the node
name again.  That seems redundant to me.

>> +
>> +=C2=A0=C2=A0=C2=A0 if (node_alias[0] =3D=3D '#') {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("Bit=
map '%s' in a node with auto-generated "
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "name '%s' can=
't be migrated",
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap_name(=
bitmap), bs_name);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitmap_name, node_alias=
);
>=20
> OK, this should not relate to mapped case, as aliases are well-formed.
>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FOR_EACH_DIRTY_BITMAP(bs, bitmap) =
{
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!bdrv_dirty_bitmap_name(=
bitmap)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitmap_name =3D bdrv_dirty_b=
itmap_name(bitmap);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!bitmap_name) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 continue;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 @@ -302,12 +486,24 @@ static int
>> add_bitmaps_to_list(BlockDriverState *bs, const char *bs_name)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return -1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bitmap_aliases) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitm=
ap_alias =3D g_hash_table_lookup(bitmap_aliases,
>> bitmap_name);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (=
!bitmap_alias) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 error_report("Bitmap '%s' with no alias on node '%s'
>> cannot be "
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 "migrated", bitmap_name, bs_name);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return -1;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitm=
ap_alias =3D bitmap_name;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>=20
> Hmm, we don't error-out if we didn't find a bitmap, specified in
> alias-map. But it seems to be an error from the user point-of-view (the
> required action can't be done).
>=20
> So, probably, we want loop through the alias-map (and in this case we
> don't need a map, but can work with QAPI list), find corresponding
> bitmaps and migrate them, and fail if some specified in the alias-map
> bitmap is not found.

Do we?

I don=E2=80=99t consider setting an alias an action request like =E2=80=9CM=
igrate this
bitmap=E2=80=9D.  I just consider it establishing a mapping.  If some eleme=
nts
are not used, so be it.

I don=E2=80=99t know if doing it differently would actually be beneficial f=
or
anyone, but OTOH naively it seems like a more invasive code change.

Max


--BJhyXDWL3PPZFkfjVPWtWgXg5uIfY23tH--

--czcKGCLsG8b3sUpoV4EBw4BE588T6P2r5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl79llEACgkQ9AfbAGHV
z0DPTwgAhqTCfi41KORghSMVG5ve5SW28zstieV0q5I9MlZ8TZ9ciABXRnfjArh9
RHv+fT7lTJ/TKZplglGsr/szof36fV+0c7dgRDUFO8Ml5iTC1ZDCaU5ej5zxuByh
2axSmqYljnpMrGeAk/x+BeZHWaZx6f6PwfmEFdF5T+lAcMo5P5BT+EPZUhAmMaqa
DTYvAll8sOFZIbqRab121/lWNoeY9+rhdkQrNYaMiEDP3wEYlFluSOoV9iAUR89E
eKB4frYHVu87vgoM7IawUqd6pRL0j/EUlMolwbKju631Y2TGYuRtLMz+XoU1BHkV
ZFK+425+RslVA2h88vcMTMWx+M2wxw==
=SHVP
-----END PGP SIGNATURE-----

--czcKGCLsG8b3sUpoV4EBw4BE588T6P2r5--


