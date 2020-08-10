Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFD2C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 08:13:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 108962073A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 08:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SKLC8OhL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 108962073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k52w9-0000pv-8i
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 04:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k52vZ-0000QA-Rj
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 04:13:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35495
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k52vW-0008MW-Df
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 04:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597047180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hl/NHm23uOv/hVf7MeHm5umD6Hmhua9leDkyq0K82zQ=;
 b=SKLC8OhLHRZfsMYI1UWSFV7/T7pRxRwjiFYYFbXGU/cnYNAJTA5lG8S/VtqyY8jfkywMZo
 ZkfaRIA0STmMfKK6X77yVQh3w6UntkwsA21F+OOwnHihlTFtTJOoEKznjROttGDi8zfODf
 jzl7TkUbS/ikfVmYCipvs8Iduox16NM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-Yz3lO-uhOnqZ5qRZOWpVLA-1; Mon, 10 Aug 2020 04:12:56 -0400
X-MC-Unique: Yz3lO-uhOnqZ5qRZOWpVLA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 733151902EA1;
 Mon, 10 Aug 2020 08:12:55 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-36.ams2.redhat.com
 [10.36.113.36])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 91DB588F3E;
 Mon, 10 Aug 2020 08:12:52 +0000 (UTC)
Subject: Re: [PATCH v7 14/47] stream: Deal with filters
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-15-mreitz@redhat.com>
 <ed502f80-f4a2-bfb8-7395-5842f8103991@virtuozzo.com>
 <63ad2152-3861-1f9f-1bb9-1c14fd68cfbd@redhat.com>
 <002af188-5576-1685-9c23-735d9a2cf50c@virtuozzo.com>
 <05650336-fd53-db84-4c57-d3a37c747163@redhat.com>
 <f61033e0-92be-0b9a-7a14-e1c56372b671@virtuozzo.com>
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
Message-ID: <9f8b1eb5-2039-b2c5-6330-7f39f2c21464@redhat.com>
Date: Mon, 10 Aug 2020 10:12:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f61033e0-92be-0b9a-7a14-e1c56372b671@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="z5CbEe2GvzINBRiFCO09I9aSzm98NYORH"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 03:31:01
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--z5CbEe2GvzINBRiFCO09I9aSzm98NYORH
Content-Type: multipart/mixed; boundary="1ALz4PhyWtyyp4WxTnSV1JZpJ2wv3ZVMW"

--1ALz4PhyWtyyp4WxTnSV1JZpJ2wv3ZVMW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07.08.20 12:29, Vladimir Sementsov-Ogievskiy wrote:
> 16.07.2020 17:59, Max Reitz wrote:
>> On 10.07.20 19:41, Andrey Shinkevich wrote:
>>> On 10.07.2020 18:24, Max Reitz wrote:
>>>> On 09.07.20 16:52, Andrey Shinkevich wrote:
>>>>> On 25.06.2020 18:21, Max Reitz wrote:
>>>>>> Because of the (not so recent anymore) changes that make the
>>>>>> stream job
>>>>>> independent of the base node and instead track the node above it, we
>>>>>> have to split that "bottom" node into two cases: The bottom COW node=
,
>>>>>> and the node directly above the base node (which may be an R/W filte=
r
>>>>>> or the bottom COW node).
>>>>>>
>>>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>>>> ---
>>>>>> =C2=A0=C2=A0=C2=A0 qapi/block-core.json |=C2=A0 4 +++
>>>>>> =C2=A0=C2=A0=C2=A0 block/stream.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 63
>>>>>> ++++++++++++++++++++++++++++++++------------
>>>>>> =C2=A0=C2=A0=C2=A0 blockdev.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++-
>>>>>> =C2=A0=C2=A0=C2=A0 3 files changed, 53 insertions(+), 18 deletions(-=
)
>>>>>>
>>>>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>>>>> index b20332e592..df87855429 100644
>>>>>> --- a/qapi/block-core.json
>>>>>> +++ b/qapi/block-core.json
>>>>>> @@ -2486,6 +2486,10 @@
>>>>>> =C2=A0=C2=A0=C2=A0 # On successful completion the image file is upda=
ted to drop the
>>>>>> backing file
>>>>>> =C2=A0=C2=A0=C2=A0 # and the BLOCK_JOB_COMPLETED event is emitted.
>>>>>> =C2=A0=C2=A0=C2=A0 #
>>>>>> +# In case @device is a filter node, block-stream modifies the first
>>>>>> non-filter
>>>>>> +# overlay node below it to point to base's backing node (or NULL if
>>>>>> @base was
>>>>>> +# not specified) instead of modifying @device itself.
>>>>>> +#
>>>>>> =C2=A0=C2=A0=C2=A0 # @job-id: identifier for the newly-created block=
 job. If
>>>>>> =C2=A0=C2=A0=C2=A0 #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 omitted, the device name will be used. (Since 2.7)
>>>>>> =C2=A0=C2=A0=C2=A0 #
>>>>>> diff --git a/block/stream.c b/block/stream.c
>>>>>> index aa2e7af98e..b9c1141656 100644
>>>>>> --- a/block/stream.c
>>>>>> +++ b/block/stream.c
>>>>>> @@ -31,7 +31,8 @@ enum {
>>>>>> =C2=A0=C2=A0=C2=A0 =C2=A0 typedef struct StreamBlockJob {
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockJob common;
>>>>>> -=C2=A0=C2=A0=C2=A0 BlockDriverState *bottom;
>>>>>> +=C2=A0=C2=A0=C2=A0 BlockDriverState *base_overlay; /* COW overlay (=
stream from
>>>>>> this) */
>>>>>> +=C2=A0=C2=A0=C2=A0 BlockDriverState *above_base;=C2=A0=C2=A0 /* Nod=
e directly above the
>>>>>> base */
>>>>> Keeping the base_overlay is enough to complete the stream job.
>>>> Depends on the definition.=C2=A0 If we decide it isn=E2=80=99t enough,=
 then it isn=E2=80=99t
>>>> enough.
>>>>
>>>>> The above_base may disappear during the job and we can't rely on it.
>>>> In this version of this series, it may not, because the chain is
>>>> frozen.
>>>> =C2=A0=C2=A0 So the above_base cannot disappear.
>>>
>>> Once we insert a filter above the top bs of the stream job, the paralle=
l
>>> jobs in
>>>
>>> the iotests #030 will fail with 'frozen link error'. It is because of
>>> the
>>>
>>> independent parallel stream or commit jobs that insert/remove their
>>> filters
>>>
>>> asynchroniously.
>>
>> I=E2=80=99m not sure whether that=E2=80=99s a problem with this series s=
pecifically.
>>
>>>> We can discuss whether we should allow it to disappear, but I think
>>>> not.
>>>>
>>>> The problem is, we need something to set as the backing file after
>>>> streaming.=C2=A0 How do we figure out what that should be?=C2=A0 My pr=
oposal
>>>> is we
>>>> keep above_base and use its immediate child.
>>>
>>> We can do the same with the base_overlay.
>>>
>>> If the backing node turns out to be a filter, the proper backing
>>> child will
>>>
>>> be set after the filter is removed. So, we shouldn't care.
>>
>> And what if the user manually added some filter above the base (i.e.
>> below base_overlay) that they want to keep after the job?
>=20
>=20
> It's automatically kept, if we use base_overlay->backing->bs as final
> backing node.
>=20
> You mean, that they want it to be dropped?

Er, yes.  Point is, the graph structure below with @base at the root may
be different than the one right below @base_overlay.

> so, assuming the following:
>=20
> top -(backing)-> manually-inserted-filter -(file)-> base
>=20
> and user do stream with base=3Dbase, and expects filter to be removed by
> stream job?
>=20
> Hmm, yes, such use-case is broken with our proposed way...
>=20
> =3D=3D=3D=3D
>=20
> Let me now clarify the problem we'll have with your way.
>=20
> When stream don't have any filter, we can easily imagine two parallel
> stream jobs:
>=20
> top -(backing)-> mid1 -(backing)-> mid2 -(backing)-> base
>=20
> stream1: top=3Dtop, base=3Dmid2
> stream2: top=3Dmid2, base=3DNULL
>=20
> final picture is obvious:
>=20
> top (merged with mid1) -(backing)-> mid2 (merged with base)

Yes, and I don=E2=80=99t think this currently working case is broken by thi=
s series.

> But we want stream job has own filter, like mirror.

Which it does not have yet, right?  Which is why I was saying that I
don=E2=80=99t think this is a problem with this series.  We could try to ad=
dress
it later.

Or do you think we can=E2=80=99t address it later because right now all fil=
ter
cases are broken anyway so now would be the time to make a breaking
change (which the suggestion to not use @base as the final backing node is)=
?

> So the picture becomes more complex.
>=20
> Assume stream2 starts first.
>=20
> top -(backing)-> mid1 -(backing)-> stream2-filter -(backing)-> mid2
> -(backing)-> base

stream2-filter would be on top of mid2, right?

> Now, when we run stream1, with your solution, stream1 will freeze
> stream2-filter
> (wrong thing, stream2 will fail to remove it if it finished first), and
> stream1 will
> remove stream2-filter on finish (which is wrong as well, stream2 is not
> prepared to
> removing of its filter)..

Note that the user first needs to pass =E2=80=9Cmid2=E2=80=9D as the base t=
o the stream
job stream1.  Why don=E2=80=99t they just pass =E2=80=9Cstream2-filter=E2=
=80=9D?  In my model,
the user should specify exactly which node they want not to be touched
by this stream job, and so that would be stream2-filter, not mid1.

I feel like the answer to this question has to do with implicit nodes.
AFAIU you wanted to remove them, so I don=E2=80=99t think we=E2=80=99d want=
 to
special-case them here.

If you think that we can=E2=80=99t expect users to pass =E2=80=9Cstream2-fi=
lter=E2=80=9D because
currently it should work with =E2=80=9Cmid2=E2=80=9D, then that=E2=80=99s a=
 case of implicit
nodes and it means we should ascend from @base up to the first
non-implicit node to get the @above_base we want.

> But, with our proposed way (freeze only chain up to base_overlay
> inclusively, and use backing(base_overlay) as final backing), all will
> work as expected, and two parallel jobs will work..

I don=E2=80=99t think it will work as expected because users can no longer
specify which node should be the base node after streaming.  And the
QAPI schema says that base-node is to become the backing file of the top
node after streaming.

I suppose you=E2=80=99re arguing that streaming through filters basically j=
ust
doesn=E2=80=99t work at all right now, so we=E2=80=99re free to do whatever=
?

Well, that still leaves the problem that users should be able to specify
which node is to become the base after streaming, and that that node
maybe shouldn=E2=80=99t be restricted to immediate children of COW images.

> =3D=3D=3D=3D
>=20
> So, these are two mutually exclusive cases.. I vote for freezing up to
> base_overlay, and use backing(base_overlay) as final backing, because:
>=20
> 1. I can't imaging other way to fix the case with parallel streams with
> filters (it's not a problem of current master, but we have pending
> series which will introduce stream job filter, and the problem will
> appear and even break iotest 30)

Besides the question of whether the top job could just use the bottom
job=E2=80=99s filter node as the base, there=E2=80=99s also the alternative=
 of admitting
defeat and declaring that you just cannot use a single node in two
streams, because we didn=E2=80=99t find a way to make it work after all.

You could still create a temporary overlay in between that=E2=80=99s never =
used
and then drop it with a trivial stream afterwards.

(But that just in case specifying the bottom job=E2=80=99s stream node some=
how
wouldn=E2=80=99t work.)

> 2. I don't think that removing filters above base node by stream job is
> so important case to break parallel stream jobs in future:
>=20
> =C2=A0- Stream job is not intended to remove filters, but to stream data.
> Filters between base_overlay and base don't contain any data and
> unrelated to stream process

Well, it is intended to remove nodes.  You can only remove data-bearing
nodes by moving data around.  I suspect if there was a way to get the
to-be-removed nodes removed without having to move their data around,
that would be popular.

> =C2=A0- I think, that filters are "more related" to their children than t=
o
> their parents. So, removing filters related to base node, when we just
> remove all data-containing nodes between top and base (and are not going
> to remove base node) is at least questionable.

Yes.

Although it could be argued that it is a handy way to remove filters, in
a backing chain at least.  (Thanks to bdrv_find_overlay(), @base and
@top still need to refer to different levels of the backing chain, but
if we lifted that restriction, I suppose it could work for any filter
chain.)

*shrug*

> On the contrary, removing
> all intermediate data containing nodes _together_ with their filters is
> absolutely correct thing to do.

I don=E2=80=99t think so, actually.  Like, you have a throttle node somewhe=
re in
the chain, shouldn=E2=80=99t you maybe want to move it down below the chain=
?  Or
a COR node, shouldn=E2=80=99t that go above the chain after streaming?

I=E2=80=99m not making an argument here, I just don=E2=80=99t quite underst=
and why you=E2=80=99d
bring up what happens with intermediate filters here.  The only reason
to drop them is because that=E2=80=99s what I expect users to expect of the
stream job.

> Next, with your way, what about filters, inserted above base during
> stream job? They will be between above_base and base, and will not be
> removed. So with your way, filters above base, existing before job start
> will be frozen during the job and removed after it, but filters appended
> above base during the job will be untouched. With our way, just all base
> node related filters are untouched by the job. It seems simpler
> definition for me and simpler to document.

Hm.  The documentation seems the same to me.  Either it=E2=80=99s =E2=80=9C=
The backing
node (at the end of the job) of @base=E2=80=99s parent node (when starting =
the
job)=E2=80=9D or =E2=80=9CThe backing node (at the end of the job) of the n=
ext
non-filter node above @base (when starting the job)=E2=80=9D.

The problem you describe (that @above_base at the end of the job isn=E2=80=
=99t
necessarily above @base anymore) also exists with your suggestion,
namely that you can add overlays above @base after the job has started,
so @base_overlay at the end of the job isn=E2=80=99t necessarily the first
non-filter node above @base anymore.


OK, so after all this text, maybe some more original problem searching.
 I think it the root of the problem is that the stream job takes a @base
parameter, but as of c624b015bf14fe01, it doesn=E2=80=99t really matter any=
more.
 Maybe c624b015bf14fe01 should have introduced a new parameter for users
to specify the bottom node instead of @base.

Well, that would have made everything a parameter mess, but it would
have saved us the trouble now.

In any case, the problem we have now is that we want a way to
automagically find out which node the bottom node should be, because the
user can=E2=80=99t specify it.  So the documentation is always going to be
written as =E2=80=9CThe backing node (at the end of the job) of $bottom=E2=
=80=9D, where
=E2=80=9C$bottom=E2=80=9D is what we=E2=80=99re interested in figuring out.

I thought it would be best if we stick as close as possible to the
spirit of the current documentation, which basically requires @base-node
to be the backing node of the top after streaming.  (If you do graph
modifications during the job, that=E2=80=99s on you, because since
c624b015bf14fe01 we can=E2=80=99t keep the base frozen.)

Your suggestion to do basically what you consider to be right, which
comes at the caveat of being untruthful to the current documentation
even if there are no graph modifications during the job.  Luckily, the
stream job right now doesn=E2=80=99t work in the cases we=E2=80=99re lookin=
g at, so it
wouldn=E2=80=99t be a breaking change.  The problem I have with it is that
you=E2=80=99re assuming what is right and what isn=E2=80=99t (i.e. =E2=80=
=9CWho would want to
remove filter nodes directly above @base=E2=80=9D) without giving the user =
a
chance to specify.


I think it would be nice if we could have something that remains
truthful to the current documentation.  If just ignoring implicit
filters above @base would work, then I=E2=80=99d find that nice.  If it doe=
sn=E2=80=99t,
I suppose there=E2=80=99s indeed little we can do but to indeed forego
@above_base and just use @base_overlay for all cases.

Max


--1ALz4PhyWtyyp4WxTnSV1JZpJ2wv3ZVMW--

--z5CbEe2GvzINBRiFCO09I9aSzm98NYORH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8xAYIACgkQ9AfbAGHV
z0AzLQgAq4ROu26fbztndvREUtw+SDgvof15KQVzXQ5cqQJeVxNrHzf2rRxfLGZc
gz3KgNl1a5KbLMLayUAFb2ZiZkqYAYLcyAylVCSKTTZxNxuuktRhCI1t3tj+iW9W
Yt1iRfSIFRMdHvOJFHZ1alT1lK6i+ezk523xO+b48/XlKLbiIuG1OpoVGhmNvpwe
/lXrBgc3+WpeyYpkUsi9YimEdaHfacNZjLJs5bHb3TpcXFSlEWqNGjrwLL3XQOQG
PF+RM9xY3gXPGaXepg2E496oBznzUrQXa3EhgVqVIJrs5y3wCxY/z2n2D1C4DpOR
Sc9AH8l7fz28kH+B/rAUE8jab9DyvQ==
=XY7L
-----END PGP SIGNATURE-----

--z5CbEe2GvzINBRiFCO09I9aSzm98NYORH--


