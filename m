Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3FFC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 13:09:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7141214D8
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 13:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JUratQ2D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7141214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if1ju-00071p-Kx
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 08:09:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36485)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1if1is-0005pi-Ue
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 08:08:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1if1iq-000520-CB
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 08:08:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43540
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1if1iq-00050I-5w
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 08:08:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576069687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hcl1f7ZbKkam6tBSuK8vPbxhuluVrC3L2Pt2vjxkECw=;
 b=JUratQ2DpkhB95zGjt9ZT2AuHudXiwXsGEUV6llQg97RlGW/gecxzS72kIKj7NBuTG025c
 ET6fr6H+Q0sf8e4AMEqsX3TOMXLnrR7Zm87f2vuS3ZRyCFW76iiNRi7hj1ZoFh0nv+BtVq
 dyHMtUS61rfURDxtjQCqZOKYxGNsv5w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-aHNj6VCHOqKhHmc5D4UicQ-1; Wed, 11 Dec 2019 07:52:51 -0500
X-MC-Unique: aHNj6VCHOqKhHmc5D4UicQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07D6ADB60;
 Wed, 11 Dec 2019 12:52:50 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-167.ams2.redhat.com
 [10.36.116.167])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 98E1D5C1B5;
 Wed, 11 Dec 2019 12:52:48 +0000 (UTC)
Subject: Re: [PATCH v6 28/42] stream: Deal with filters
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-29-mreitz@redhat.com>
 <20190913141653.GH8312@dhcp-200-226.str.redhat.com>
 <0da03f2f-e7ca-1aad-f156-bbd8a0e9dbc7@redhat.com>
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
Message-ID: <1b849809-ac7e-091b-4987-b3ee9383cb15@redhat.com>
Date: Wed, 11 Dec 2019 13:52:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <0da03f2f-e7ca-1aad-f156-bbd8a0e9dbc7@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9OTqtuTDjRKDzFW2d6NuhyqCznjmfd9fP"
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9OTqtuTDjRKDzFW2d6NuhyqCznjmfd9fP
Content-Type: multipart/mixed; boundary="k9E2PD3MvLINLOU3ZAjOZBDpzVHbWX27T"

--k9E2PD3MvLINLOU3ZAjOZBDpzVHbWX27T
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 16.09.19 11:52, Max Reitz wrote:
> On 13.09.19 16:16, Kevin Wolf wrote:
>> Am 09.08.2019 um 18:13 hat Max Reitz geschrieben:
>>> Because of the recent changes that make the stream job independent of
>>> the base node and instead track the node above it, we have to split tha=
t
>>> "bottom" node into two cases: The bottom COW node, and the node directl=
y
>>> above the base node (which may be an R/W filter or the bottom COW node)=
.
>>>
>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>> ---
>>>  qapi/block-core.json |  4 ++++
>>>  block/stream.c       | 52 ++++++++++++++++++++++++++++----------------
>>>  blockdev.c           |  2 +-
>>>  3 files changed, 38 insertions(+), 20 deletions(-)


[...]

>>> +    if (bdrv_freeze_chain(bs, above_base, errp) < 0) {
>>>          return;
>>>      }
>>
>> Hm... This feels odd. There are two places where stopping to freeze the
>> chain would make obvious sense: At base, like we originally did; or at
>> base_overlay, like we (intend to) do since commit c624b015, because we
>> say that we don't actually mind if the user replaces the base image. I
>> don't see how stopping at the first filter above base makes sense.
>>
>> So should this use bottom_cow_node/base_overlay instead of above_base?
>=20
> I suppose I thought =E2=80=9CBetter be safe than sorry=E2=80=9D.
>=20
>> You couldn't use StreamBlockJob.above_base any more then because it
>> could change, but you also don't really need it anywhere. It's only used
>> for unfreezing (which would change) and for finding the base (you can
>> still find bdrv_backing_chain_next(s->base_overlay)). I guess this would
>> even be a code simplification.
>=20
> Great, I=E2=80=99ll see to it.

On second thought (yes, I know, it=E2=80=99s been a couple of months...) I=
=E2=80=99m not
so sure.

If @base is a filter, then bdrv_backing_chain_next(s->base_overlay) will
not return it.  So then the filter will be dropped, but that probably
isn=E2=80=99t what the user intended.

(In fact, the block-stream doc says =E2=80=9CWhen streaming completes the i=
mage
file will have the base file as its backing file.=E2=80=9D)

So now this gets hairy.  We do want exactly @base as the backing file
unless the user changed the graph.  But how can we detect that and if it
hasn=E2=80=99t changed find @base again?

What this patch did in this version worked because the graph was frozen
until @above_base.

Alternatively, we could store a pointer to @base directly (or its node
nmae) and then see whether there is some node between s->base_overlay
and bdrv_backing_chain_next(s->base_overlay) that matches that at the
end of streaming.

Well, actually, a pointer won=E2=80=99t work because of course maybe that n=
ode
was deleted and the area is now used for an unrelated node that the user
doesn=E2=80=99t want as the new backing file.

The node name could actually work, though.  I mean, if there is some
node in the immediate backing filter chain of base_overlay with that
node name after streaming, it does make sense to assume that the user
wants this to be the backing file; regardless of whether that=E2=80=99s exa=
ctly
the same node as it was at the start of streaming.

But we now also have to think about what to do when there is no node
with such a node name.  Should we keep all filters below base_overlay?
Or should we drop all of them?  I actually think keeping them is the
safer choice...

Max


--k9E2PD3MvLINLOU3ZAjOZBDpzVHbWX27T--

--9OTqtuTDjRKDzFW2d6NuhyqCznjmfd9fP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3w5p4ACgkQ9AfbAGHV
z0ByDgf/eyFsEiHG8ALOsbHOEd74vOPo1bCUxxAneU8TUzdw41CJPaynepIJICwc
fF3BuA1mdiw+FgcTjMfoNkmSfDdyhfhaKVSNaN1SHvuZLR89JmM0GaL+Zjfw7A29
46b0jjSlB/Lr1wYlSy8q1YKBn+6GE+eaI8/5XJ9J79unPq0IFWlBBmlTurD680Ui
n5hA2vnLZy1xCBYUpj70TxIaLc0/0ca7rIHN1UrgoR6he2SIuFBn66gPftBhDT+k
+btu3PB61esB6Y5bD0rHY5zYMqIgdWQFT4KzYYbfmhCtfTDmVlUGMl1oinMisKwr
xgkUmPBD7ylOn8y70Mp9dqUoAqI43g==
=Zg7l
-----END PGP SIGNATURE-----

--9OTqtuTDjRKDzFW2d6NuhyqCznjmfd9fP--


