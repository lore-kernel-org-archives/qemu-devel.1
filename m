Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86D8C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 16:19:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EBAF206A5
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 16:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AGMaZUZx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EBAF206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if4hy-0004Jd-5A
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 11:19:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33579)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1if4az-0007vk-8M
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 11:12:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1if4ax-0004rq-Ek
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 11:12:13 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50592
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1if4ax-0004qi-8H
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 11:12:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576080730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JhS92mXe7FmbMg9/on1vvQi0NAIBQusoDqAkHd4skdU=;
 b=AGMaZUZxdknQURHre7p1VULxZs7hgllk7MqUfvco0IE0O0k8U8Syxni4WUm9hv9Hd3TruM
 AwFPhS14zv4ZAK+IP5wG8bQ9C7YgSEuLrPlfZDlxXIT57TBCPleuCe5pirKl/JUusN4471
 fngZFTvo7apyJNg/tZSyNakvHQyK/wM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-Ky-dZZl5OhmT2SUAWciaGQ-1; Wed, 11 Dec 2019 11:12:07 -0500
X-MC-Unique: Ky-dZZl5OhmT2SUAWciaGQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82A9B1085927;
 Wed, 11 Dec 2019 16:12:06 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-36.ams2.redhat.com
 [10.36.117.36])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 49C0160BA9;
 Wed, 11 Dec 2019 16:12:05 +0000 (UTC)
Subject: Re: [PATCH v6 28/42] stream: Deal with filters
To: Kevin Wolf <kwolf@redhat.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-29-mreitz@redhat.com>
 <20190913141653.GH8312@dhcp-200-226.str.redhat.com>
 <0da03f2f-e7ca-1aad-f156-bbd8a0e9dbc7@redhat.com>
 <1b849809-ac7e-091b-4987-b3ee9383cb15@redhat.com>
 <20191211155224.GC6505@linux.fritz.box>
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
Message-ID: <38b4e4bf-9553-e231-98f5-91dcb6994462@redhat.com>
Date: Wed, 11 Dec 2019 17:12:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191211155224.GC6505@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0u0IFYw6TVGPgDtiGVNN6uebI7sBoNiab"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
--0u0IFYw6TVGPgDtiGVNN6uebI7sBoNiab
Content-Type: multipart/mixed; boundary="lNqW56A3vW276fFyCBHK6auo7tfZbOqLV"

--lNqW56A3vW276fFyCBHK6auo7tfZbOqLV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11.12.19 16:52, Kevin Wolf wrote:
> Am 11.12.2019 um 13:52 hat Max Reitz geschrieben:
>> On 16.09.19 11:52, Max Reitz wrote:
>>> On 13.09.19 16:16, Kevin Wolf wrote:
>>>> Am 09.08.2019 um 18:13 hat Max Reitz geschrieben:
>>>>> Because of the recent changes that make the stream job independent of
>>>>> the base node and instead track the node above it, we have to split t=
hat
>>>>> "bottom" node into two cases: The bottom COW node, and the node direc=
tly
>>>>> above the base node (which may be an R/W filter or the bottom COW nod=
e).
>>>>>
>>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>>> ---
>>>>>  qapi/block-core.json |  4 ++++
>>>>>  block/stream.c       | 52 ++++++++++++++++++++++++++++--------------=
--
>>>>>  blockdev.c           |  2 +-
>>>>>  3 files changed, 38 insertions(+), 20 deletions(-)
>>
>>
>> [...]
>>
>>>>> +    if (bdrv_freeze_chain(bs, above_base, errp) < 0) {
>>>>>          return;
>>>>>      }
>>>>
>>>> Hm... This feels odd. There are two places where stopping to freeze th=
e
>>>> chain would make obvious sense: At base, like we originally did; or at
>>>> base_overlay, like we (intend to) do since commit c624b015, because we
>>>> say that we don't actually mind if the user replaces the base image. I
>>>> don't see how stopping at the first filter above base makes sense.
>>>>
>>>> So should this use bottom_cow_node/base_overlay instead of above_base?
>>>
>>> I suppose I thought =E2=80=9CBetter be safe than sorry=E2=80=9D.
>>>
>>>> You couldn't use StreamBlockJob.above_base any more then because it
>>>> could change, but you also don't really need it anywhere. It's only us=
ed
>>>> for unfreezing (which would change) and for finding the base (you can
>>>> still find bdrv_backing_chain_next(s->base_overlay)). I guess this wou=
ld
>>>> even be a code simplification.
>>>
>>> Great, I=E2=80=99ll see to it.
>>
>> On second thought (yes, I know, it=E2=80=99s been a couple of months...)=
 I=E2=80=99m not
>> so sure.
>>
>> If @base is a filter, then bdrv_backing_chain_next(s->base_overlay) will
>> not return it.  So then the filter will be dropped, but that probably
>> isn=E2=80=99t what the user intended.
>>
>> (In fact, the block-stream doc says =E2=80=9CWhen streaming completes th=
e image
>> file will have the base file as its backing file.=E2=80=9D)
>=20
> Hm... Okay, let's try an example:
>=20
>     ... <- backing <- filter1 <- filter2 <- filter3 <- top
>                          |         |                    |
>                       @base    above_base            @device
>                                                    base_overlay
>=20
>=20
> The expected result after the job has completed is:
>=20
>     ... <- backing <- filter1 <- top
>=20
> This means that filter1 must not go away until the job has completed. In
> other words, we would need to freeze the link between @base and
> above_base.
>=20
> If we use backing_bs(above_base) as we currently do, we wouldn't
> necessarily get filter1 as the new backing child of top (as the
> documentation promises), but whatever is the backing child of filter2
> when the job completes. In other words, documentation and code don't
> match currently.

Correct.

> Let's look at a few more examples to see which of the options makes more
> sense:
>=20
> 1. Assume we drop filter1 while the stream job is running, i.e. backing
>    is now the backing child of filter 2. I think it's obvious that when
>    the stream job completes, you want backing to be the new backing
>    child of top and not add filter1 back to the chain.
>=20
> 2. If we add filter1b between filter1 and filter2, do we want to drop it
>    when the job completes? It's not entirely clear, but there are
>    probably cases where keeping it makes sense. The user can always drop
>    it manually again, but if we delete a node, some requests will go
>    through unfiltered.

Depends.  If the base-node was given to be literally "backing", then I=E2=
=80=99d
say the user wants us to use "backing" as the new base still.

> 3. Imagine we replace filter1 wholesale, for example because a
>    concurrently running mirror job performs a storage migration for
>    everything up to filter1. Do we then want to reinstate the whole old
>    subtree when the stream job completes? Certainly not.

I=E2=80=99m not sure.  Again, if I as the user specified the "backing" node=
-name
as the base, I=E2=80=99d expect that to be the new backing file in all case=
s.

> So from this I would probably conclude that the bug is the
> documentation, not necessarily in the code.

It certainly is true that it does not address what happens when you
meddle with base.

(Except it can be argued (and I suppose I did argue that) that as it is
it does say the base file should be the backing file after stream, so if
the base file is still there, I do interpret that to mean that the
stream job always uses that as the backing node.  Of course even if it
says that, that doesn=E2=80=99t mean that it makes sense.  And if it doesn=
=E2=80=99t
make sense, then that=E2=80=99s the definition of a bug in the documentatio=
n, yes.)

>> So now this gets hairy.  We do want exactly @base as the backing file
>> unless the user changed the graph.  But how can we detect that and if it
>> hasn=E2=80=99t changed find @base again?
>>
>> What this patch did in this version worked because the graph was frozen
>> until @above_base.
>=20
> No, it didn't provide the promised semantics, because "unless the user
> changed the graph" isn't part of the documentation.But the promised
> semantics are probably not what we want, so it's okay.

I would have said that no semantics are promised for when the node is no
longer a valid base, so we can basically do what we think makes sense.

>> Alternatively, we could store a pointer to @base directly (or its node
>> nmae) and then see whether there is some node between s->base_overlay
>> and bdrv_backing_chain_next(s->base_overlay) that matches that at the
>> end of streaming.
>>
>> Well, actually, a pointer won=E2=80=99t work because of course maybe tha=
t node
>> was deleted and the area is now used for an unrelated node that the user
>> doesn=E2=80=99t want as the new backing file.
>>
>> The node name could actually work, though.  I mean, if there is some
>> node in the immediate backing filter chain of base_overlay with that
>> node name after streaming, it does make sense to assume that the user
>> wants this to be the backing file; regardless of whether that=E2=80=99s =
exactly
>> the same node as it was at the start of streaming.
>>
>> But we now also have to think about what to do when there is no node
>> with such a node name.  Should we keep all filters below base_overlay?
>> Or should we drop all of them?  I actually think keeping them is the
>> safer choice...
>=20
> Using node names feels completely wrong to me. If we can't keep a
> pointer (with a reference) because we want the user to be able to
> delete the node, then we certainly can't keep the node name either
> because that could refer to an entirely different node when the job
> completes.

I was thinking that if the user does graph manipulation, we can expect
them to have given base-node.  So they actually did refer to a node name
and it makes sense to me to keep looking it up.

(As a side note: I originally intended to say =E2=80=9Cstoring a pointer or=
 the
node-name are the only things that come to mind, but obviously both are
stupid=E2=80=9D =E2=80=93 but then I changed my mind and realized that the =
node name
maybe actually isn=E2=80=99t that stupid.)

> I don't think it's useful to waste too much thought on how to implement
> the behaviour required by the documentation. The requirement seems to be
> just wrong.
>=20
> So in the end, maybe your current code is fine, and the way to address
> the "doesn't make obvious sense" part is having a comment that explains
> why above_base is where we stop freezing.

Let=E2=80=99s maybe talk about it tomorrow. :-)

Max


--lNqW56A3vW276fFyCBHK6auo7tfZbOqLV--

--0u0IFYw6TVGPgDtiGVNN6uebI7sBoNiab
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3xFVMACgkQ9AfbAGHV
z0Dz6Qf/VIVsBzjcEOHNT/RDPN/SxJyRGegn/DmGi5LLgHE9gxVBLeWV/EQk0TG0
pTLmhZhpHFCQsyRiYPOBRkpUDHiqTJnxjoyuofOz8i/3hw2bcWYlrrq/fp8w2Zwv
nhyAD68rrsNlm6ZMg5KheACKz2KjMdjRPJZZK4HqWSlYXs1VNgZyS7NkB6xUN5w7
W7FyK9ye7tEZkaor2Sf4lkCa5YTlAQthKOK1zuTj5zw5HyOho602DzZuk+Gtd8hT
7/w86/HyfyBUQeox8+CRzztg9xcttacCp+IeVgeO7V1CX7ylMQXKXhKdVrotBKa2
2DKBe3jiSr3GUeyjFejpCDGtUFX++Q==
=HNKp
-----END PGP SIGNATURE-----

--0u0IFYw6TVGPgDtiGVNN6uebI7sBoNiab--


