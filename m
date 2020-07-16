Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DC3C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 15:01:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0D20207BC
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 15:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pu7ZgQvv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0D20207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw5No-0000k8-On
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 11:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jw5M6-0008Sh-6u
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 10:59:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55421
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jw5M3-0003IQ-42
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 10:59:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594911562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qwbb6wkAarN0R8BEAP1FkiM0cj9JkWT/xWtpPVDZeFs=;
 b=Pu7ZgQvvVsSzX3PfU9hM49amYLKSqQFFZFfy38V2PEkxdNQDvOLDKFEamTWyZf73dogoFb
 OGUeYuVVvhl2P1i3oelxGjQGa3P1fsFRCSD4e2y7n4z194wBF5Hsjs098FKhMyykXRn6XL
 Q3mSn/YFNjj7LawtOCq0KXnCfsDX7EY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-60a-Z7ikNXO1kFcoYFyvOg-1; Thu, 16 Jul 2020 10:59:19 -0400
X-MC-Unique: 60a-Z7ikNXO1kFcoYFyvOg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D6CF18C63C0;
 Thu, 16 Jul 2020 14:59:18 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-160.ams2.redhat.com
 [10.36.112.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CC4AE724C2;
 Thu, 16 Jul 2020 14:59:16 +0000 (UTC)
Subject: Re: [PATCH v7 14/47] stream: Deal with filters
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-15-mreitz@redhat.com>
 <ed502f80-f4a2-bfb8-7395-5842f8103991@virtuozzo.com>
 <63ad2152-3861-1f9f-1bb9-1c14fd68cfbd@redhat.com>
 <002af188-5576-1685-9c23-735d9a2cf50c@virtuozzo.com>
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
Message-ID: <05650336-fd53-db84-4c57-d3a37c747163@redhat.com>
Date: Thu, 16 Jul 2020 16:59:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <002af188-5576-1685-9c23-735d9a2cf50c@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8Sw6JhFkYMMAWYRUciQExffncRAOMdXC4"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 04:25:38
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8Sw6JhFkYMMAWYRUciQExffncRAOMdXC4
Content-Type: multipart/mixed; boundary="CvbMs7xqohNth2cUrpwL2aJI3ZKOtYuwh"

--CvbMs7xqohNth2cUrpwL2aJI3ZKOtYuwh
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.07.20 19:41, Andrey Shinkevich wrote:
> On 10.07.2020 18:24, Max Reitz wrote:
>> On 09.07.20 16:52, Andrey Shinkevich wrote:
>>> On 25.06.2020 18:21, Max Reitz wrote:
>>>> Because of the (not so recent anymore) changes that make the stream jo=
b
>>>> independent of the base node and instead track the node above it, we
>>>> have to split that "bottom" node into two cases: The bottom COW node,
>>>> and the node directly above the base node (which may be an R/W filter
>>>> or the bottom COW node).
>>>>
>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>> ---
>>>> =C2=A0=C2=A0 qapi/block-core.json |=C2=A0 4 +++
>>>> =C2=A0=C2=A0 block/stream.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 63
>>>> ++++++++++++++++++++++++++++++++------------
>>>> =C2=A0=C2=A0 blockdev.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 4 ++-
>>>> =C2=A0=C2=A0 3 files changed, 53 insertions(+), 18 deletions(-)
>>>>
>>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>>> index b20332e592..df87855429 100644
>>>> --- a/qapi/block-core.json
>>>> +++ b/qapi/block-core.json
>>>> @@ -2486,6 +2486,10 @@
>>>> =C2=A0=C2=A0 # On successful completion the image file is updated to d=
rop the
>>>> backing file
>>>> =C2=A0=C2=A0 # and the BLOCK_JOB_COMPLETED event is emitted.
>>>> =C2=A0=C2=A0 #
>>>> +# In case @device is a filter node, block-stream modifies the first
>>>> non-filter
>>>> +# overlay node below it to point to base's backing node (or NULL if
>>>> @base was
>>>> +# not specified) instead of modifying @device itself.
>>>> +#
>>>> =C2=A0=C2=A0 # @job-id: identifier for the newly-created block job. If
>>>> =C2=A0=C2=A0 #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 o=
mitted, the device name will be used. (Since 2.7)
>>>> =C2=A0=C2=A0 #
>>>> diff --git a/block/stream.c b/block/stream.c
>>>> index aa2e7af98e..b9c1141656 100644
>>>> --- a/block/stream.c
>>>> +++ b/block/stream.c
>>>> @@ -31,7 +31,8 @@ enum {
>>>> =C2=A0=C2=A0 =C2=A0 typedef struct StreamBlockJob {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockJob common;
>>>> -=C2=A0=C2=A0=C2=A0 BlockDriverState *bottom;
>>>> +=C2=A0=C2=A0=C2=A0 BlockDriverState *base_overlay; /* COW overlay (st=
ream from
>>>> this) */
>>>> +=C2=A0=C2=A0=C2=A0 BlockDriverState *above_base;=C2=A0=C2=A0 /* Node =
directly above the base */
>>> Keeping the base_overlay is enough to complete the stream job.
>> Depends on the definition.=C2=A0 If we decide it isn=E2=80=99t enough, t=
hen it isn=E2=80=99t
>> enough.
>>
>>> The above_base may disappear during the job and we can't rely on it.
>> In this version of this series, it may not, because the chain is frozen.
>> =C2=A0 So the above_base cannot disappear.
>=20
> Once we insert a filter above the top bs of the stream job, the parallel
> jobs in
>=20
> the iotests #030 will fail with 'frozen link error'. It is because of the
>=20
> independent parallel stream or commit jobs that insert/remove their filte=
rs
>=20
> asynchroniously.

I=E2=80=99m not sure whether that=E2=80=99s a problem with this series spec=
ifically.

>> We can discuss whether we should allow it to disappear, but I think not.
>>
>> The problem is, we need something to set as the backing file after
>> streaming.=C2=A0 How do we figure out what that should be?=C2=A0 My prop=
osal is we
>> keep above_base and use its immediate child.
>=20
> We can do the same with the base_overlay.
>=20
> If the backing node turns out to be a filter, the proper backing child wi=
ll
>=20
> be set after the filter is removed. So, we shouldn't care.

And what if the user manually added some filter above the base (i.e.
below base_overlay) that they want to keep after the job?

>> If we don=E2=80=99t keep above_base, then we=E2=80=99re basically left g=
uessing as to
>> what should be the backing file after the stream job.
>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockdevOnError on_error;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *backing_file_str;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool bs_read_only;
>>>> @@ -53,7 +54,7 @@ static void stream_abort(Job *job)
>>>> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s->chain_frozen) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockJob =
*bjob =3D &s->common;
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_unfreeze_backing_chai=
n(blk_bs(bjob->blk), s->bottom);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_unfreeze_backing_chai=
n(blk_bs(bjob->blk), s->above_base);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0 @@ -62,14 +63,15 @@ static int stream_prepare(Job *job)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 StreamBlockJob *s =3D container_o=
f(job, StreamBlockJob,
>>>> common.job);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockJob *bjob =3D &s->common;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockDriverState *bs =3D blk_bs(b=
job->blk);
>>>> -=C2=A0=C2=A0=C2=A0 BlockDriverState *base =3D backing_bs(s->bottom);
>>>> +=C2=A0=C2=A0=C2=A0 BlockDriverState *unfiltered_bs =3D bdrv_skip_filt=
ers(bs);
>>>> +=C2=A0=C2=A0=C2=A0 BlockDriverState *base =3D bdrv_filter_or_cow_bs(s=
->above_base);
>>> The initial base node may be a top node for a concurrent commit job and
>>>
>>> may disappear.
>> Then it would just be replaced by another node, though, so above_base
>> keeps a child.=C2=A0 The @base here is not necessarily the initial @base=
, and
>> that=E2=80=99s intentional.
>=20
> Not really. In my example, above_base becomes a dangling
>=20
> pointer because after the commit job finishes, its filter that should
> belong to the
>=20
> commit job frozen chain will be deleted. If we freeze the link to the
> above_base
>=20
> for this job, the iotests #30 will not pass.

So it doesn=E2=80=99t become a dangling pointer, because it=E2=80=99s froze=
n.

030 passes after this series, so I=E2=80=99m not sure whether I can conside=
r
that problem part of this series.

I think if adding a filter node becomes a problem, we have to consider
relaxing the restrictions when we do that, not now.

>>> base =3D bdrv_filter_or_cow_bs(s->base_overlay) is more reliable.
>> But also wrong.=C2=A0 The point of keeping above_base around is to get i=
ts
>> child here to use that child as the new backing child of the top node.
>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error *local_err =3D NULL;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>>>> =C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0 bdrv_unfreeze_backing_chain(bs, s->bo=
ttom);
>>>> +=C2=A0=C2=A0=C2=A0 bdrv_unfreeze_backing_chain(bs, s->above_base);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->chain_frozen =3D false;
>>>> =C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0 if (bs->backing) {
>>>> +=C2=A0=C2=A0=C2=A0 if (bdrv_cow_child(unfiltered_bs)) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const cha=
r *base_id =3D NULL, *base_fmt =3D NULL;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (base)=
 {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 base_id =3D s->backing_file_str;
>>>> @@ -77,8 +79,8 @@ static int stream_prepare(Job *job)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 base_fmt =3D base->drv->format_name=
;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_set_backing_hd(bs, ba=
se, &local_err);
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D bdrv_change_backin=
g_file(bs, base_id, base_fmt);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_set_backing_hd(unfilt=
ered_bs, base, &local_err);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D bdrv_change_backin=
g_file(unfiltered_bs, base_id,
>>>> base_fmt);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (local=
_err) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 error_report_err(local_err);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return -EPERM;
>>>> @@ -109,14 +111,15 @@ static int coroutine_fn stream_run(Job *job,
>>>> Error **errp)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 StreamBlockJob *s =3D container_o=
f(job, StreamBlockJob,
>>>> common.job);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockBackend *blk =3D s->common.b=
lk;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockDriverState *bs =3D blk_bs(b=
lk);
>>>> -=C2=A0=C2=A0=C2=A0 bool enable_cor =3D !backing_bs(s->bottom);
>>>> +=C2=A0=C2=A0=C2=A0 BlockDriverState *unfiltered_bs =3D bdrv_skip_filt=
ers(bs);
>>>> +=C2=A0=C2=A0=C2=A0 bool enable_cor =3D !bdrv_cow_child(s->base_overla=
y);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t len;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t offset =3D 0;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t delay_ns =3D 0;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int error =3D 0;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t n =3D 0; /* bytes */
>>>> =C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0 if (bs =3D=3D s->bottom) {
>>>> +=C2=A0=C2=A0=C2=A0 if (unfiltered_bs =3D=3D s->base_overlay) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Nothin=
g to stream */
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> @@ -150,13 +153,14 @@ static int coroutine_fn stream_run(Job *job,
>>>> Error **errp)
>>>> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co=
py =3D false;
>>>> =C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D bdrv_=
is_allocated(bs, offset, STREAM_CHUNK, &n);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D bdrv_is_allocated(=
unfiltered_bs, offset, STREAM_CHUNK,
>>>> &n);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret =
=3D=3D 1) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 /* Allocated in the top, no need to copy.=C2=A0 */
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if=
 (ret >=3D 0) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 /* Copy if allocated in the intermediate images.=C2=A0 Limi=
t
>>>> to the
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * known-unallocated area [offset,
>>>> offset+n*BDRV_SECTOR_SIZE).=C2=A0 */
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
t =3D bdrv_is_allocated_above(backing_bs(bs), s->bottom,
>>>> true,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
t =3D bdrv_is_allocated_above(bdrv_cow_bs(unfiltered_bs),
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->base_overlay, true,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 offset, n, &n);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 /* Finish early if end of backing file has been
>>>> reached */
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (ret =3D=3D 0 && n =3D=3D 0) {
>>>> @@ -223,9 +227,29 @@ void stream_start(const char *job_id,
>>>> BlockDriverState *bs,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockDriverState *iter;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool bs_read_only;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int basic_flags =3D BLK_PERM_CONS=
ISTENT_READ |
>>>> BLK_PERM_WRITE_UNCHANGED;
>>>> -=C2=A0=C2=A0=C2=A0 BlockDriverState *bottom =3D bdrv_find_overlay(bs,=
 base);
>>>> +=C2=A0=C2=A0=C2=A0 BlockDriverState *base_overlay =3D bdrv_find_overl=
ay(bs, base);
>>>> +=C2=A0=C2=A0=C2=A0 BlockDriverState *above_base;
>>>> =C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0 if (bdrv_freeze_backing_chain(bs, bot=
tom, errp) < 0) {
>>>> +=C2=A0=C2=A0=C2=A0 if (!base_overlay) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "'%s' is =
not in the backing chain of '%s'",
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 base->node_name, bs->node_name);
>>> Sorry, I am not clear with the error message.
>>>
>>> In this case, there is no an intermediate COW node but the base, if not
>>> NULL, is
>>>
>>> in the backing chain of bs, isn't it?
>>>
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 /*
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Find the node directly above @base.=C2=A0 =
@base_overlay is a COW
>>>> overlay, so
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * it must have a bdrv_cow_child(), but it is=
 the immediate
>>>> overlay of
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * @base, so between the two there can only b=
e filters.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> +=C2=A0=C2=A0=C2=A0 above_base =3D base_overlay;
>>>> +=C2=A0=C2=A0=C2=A0 if (bdrv_cow_bs(above_base) !=3D base) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 above_base =3D bdrv_cow_bs=
(above_base);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (bdrv_filter_bs(abov=
e_base) !=3D base) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ab=
ove_base =3D bdrv_filter_bs(above_base);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 if (bdrv_freeze_backing_chain(bs, above_base, errp=
) < 0) {
>>> When a concurrent stream job tries to freeze or remove the above_base
>>> node,
>>>
>>> we will encounter the frozen node error. The above_base node is a part
>>> of the
>>>
>>> concurrent job frozen chain.
>> Correct.
>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0 @@ -255,14 +279,19 @@ void stream_start(const char *job_i=
d,
>>>> BlockDriverState *bs,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * and resizes. Reassign the=
 base node pointer because the
>>>> backing BS of the
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * bottom node might change =
after the call to
>>>> bdrv_reopen_set_read_only()
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * due to parallel block job=
s running.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * above_base node might change after the cal=
l to
>>> Yes, if not frozen.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * bdrv_reopen_set_read_only() due to paralle=
l block jobs running.
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> -=C2=A0=C2=A0=C2=A0 base =3D backing_bs(bottom);
>>>> -=C2=A0=C2=A0=C2=A0 for (iter =3D backing_bs(bs); iter && iter !=3D ba=
se; iter =3D
>>>> backing_bs(iter)) {
>>>> +=C2=A0=C2=A0=C2=A0 base =3D bdrv_filter_or_cow_bs(above_base);
>>>> +=C2=A0=C2=A0=C2=A0 for (iter =3D bdrv_filter_or_cow_bs(bs); iter !=3D=
 base;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iter =3D bdrv_filter=
_or_cow_bs(iter))
>>>> +=C2=A0=C2=A0=C2=A0 {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 block_job=
_add_bdrv(&s->common, "intermediate node", iter, 0,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 basic_flags, &error_abort);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0 s->bottom =3D bottom;
>>>> +=C2=A0=C2=A0=C2=A0 s->base_overlay =3D base_overlay;
>>>> +=C2=A0=C2=A0=C2=A0 s->above_base =3D above_base;
>>> Generally, being the filter for a concurrent job, the above_base node
>>> may be deleted any time
>>>
>>> and we will keep the dangling pointer. It may happen even earlier if
>>> above_base is not frozen.
>>>
>>> If it is, as it here, we may get the frozen link error then.
>> I=E2=80=99m not sure what you mean here.=C2=A0 Freezing it was absolutel=
y
>> intentional.=C2=A0 A dangling pointer would be a problem, but that=E2=80=
=99s why it=E2=80=99s
>> frozen, so it stays around and can=E2=80=99t be deleted any time.
>>
>> Max
>=20
> The nodes we freeze should be in one context of the relevant job:
>=20
> filter->top_node->intermediate_node(s)
>=20
> We would not include the base or any filter above it to the frozen chain
>=20
> because they are of a different job context.

They aren=E2=80=99t really, because we need to know the backing node of @de=
vice
after the job.

> Once 'this' job is completed, we set the current backing child of the
> base_overlay
>=20
> and may not care of its character. If that is another job filter, it
> will be replaced
>=20
> with the proper node afterwards.

But what if there are filters above the base that the user wants to keep
after the job?

Max


--CvbMs7xqohNth2cUrpwL2aJI3ZKOtYuwh--

--8Sw6JhFkYMMAWYRUciQExffncRAOMdXC4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8Qa0MACgkQ9AfbAGHV
z0A14wf4pbBdx8xl3aBmUuJbPdGky+UrUrXbfC2dCapKUh+lD8xITLd8ZWpPIStU
EwFkJrp+/44Ju+LyUbgd9cpfAkfJa9YO76u2gZaqD2ayo9aLr4Otpq7Ri1GgEm8b
HR+jSNBRH0LTgy8trCq4vAbSSrVRm0N1oaWDCcUzo0djDrnuV3G7RYpYH7GeDcwG
2+L1XBTAAZp33l08008dWPe4T9aetUAXwqnMQO40Kl3761PlmGl21uCGtoxQoAxx
5azvYHkVPSbgjIi6+PbYPwyHiQRYcgD9/HGSrUfKOxkPy/MPklPt97HHFBFzJIXo
5Fehx47TUgK/ig9h0pP5sUtRnNTF
=Pqem
-----END PGP SIGNATURE-----

--8Sw6JhFkYMMAWYRUciQExffncRAOMdXC4--


