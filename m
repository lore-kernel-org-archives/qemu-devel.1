Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBFAC33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 16:48:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE1FB20720
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 16:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dpoZfFGi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE1FB20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izkKn-00072A-VJ
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 11:48:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55965)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1izkJi-00061u-B9
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 11:47:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1izkJg-0000p3-TL
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 11:47:50 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54458
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1izkJf-0000m1-Oe
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 11:47:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581007665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4sTNJYlgQp756jNZAGUB0FXvrZgWAaRSclKnlZC9UbQ=;
 b=dpoZfFGiqyE6h34rbtjKMz5ZaveBnJuGYHt/tPxFh22KbyFN/cU553ToF7073XAR6c0dCw
 OjeMViX5OuGpghnlMVbVHxV9u4x1Z85VXF70Zw4Y/6OKUJHKBjHEvN3pGAgTukS0rE4tpO
 dqTTsbIkE9LHO9qLoP72fZoYJPXLZGo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-iVnNcBhMMO6xO19mQ9h9Jw-1; Thu, 06 Feb 2020 11:47:41 -0500
X-MC-Unique: iVnNcBhMMO6xO19mQ9h9Jw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 595A910A5746;
 Thu,  6 Feb 2020 16:47:40 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.15])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E77E78DC2C;
 Thu,  6 Feb 2020 16:47:38 +0000 (UTC)
Subject: Re: [PATCH v3 09/21] quorum: Add QuorumChild.to_be_replaced
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
References: <20200130214431.333510-1-mreitz@redhat.com>
 <20200130214431.333510-10-mreitz@redhat.com>
 <20200205153859.GE5768@dhcp-200-226.str.redhat.com>
 <92b951da-5e12-e08f-f8f7-a862790b51ac@redhat.com>
 <20200206145825.GD4926@linux.fritz.box>
 <9d767091-4590-9fce-c596-bda5865aa190@redhat.com>
 <20200206155110.GG4926@linux.fritz.box>
 <78bd2830-9b10-9d66-afe1-783226b8edc5@redhat.com>
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
Message-ID: <8a3c03db-3808-0194-ee03-fef6f28667d8@redhat.com>
Date: Thu, 6 Feb 2020 17:47:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <78bd2830-9b10-9d66-afe1-783226b8edc5@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="PXnANC4CH6LWfjTAn8yOOLcXmVubvQEJA"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
--PXnANC4CH6LWfjTAn8yOOLcXmVubvQEJA
Content-Type: multipart/mixed; boundary="qJdfDjipM2Hy6YaNMAsvF8TTfd0Tc6beG"

--qJdfDjipM2Hy6YaNMAsvF8TTfd0Tc6beG
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06.02.20 17:43, Max Reitz wrote:
> On 06.02.20 16:51, Kevin Wolf wrote:
>> Am 06.02.2020 um 16:21 hat Max Reitz geschrieben:
>>> On 06.02.20 15:58, Kevin Wolf wrote:
>>>> Am 06.02.2020 um 11:11 hat Max Reitz geschrieben:
>>>>> On 05.02.20 16:38, Kevin Wolf wrote:
>>>>>> Am 30.01.2020 um 22:44 hat Max Reitz geschrieben:
>>>>>>> We will need this to verify that Quorum can let one of its children=
 be
>>>>>>> replaced without breaking anything else.
>>>>>>>
>>>>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>>>>> ---
>>>>>>>  block/quorum.c | 25 +++++++++++++++++++++++++
>>>>>>>  1 file changed, 25 insertions(+)
>>>>>>>
>>>>>>> diff --git a/block/quorum.c b/block/quorum.c
>>>>>>> index 59cd524502..6a7224c9e4 100644
>>>>>>> --- a/block/quorum.c
>>>>>>> +++ b/block/quorum.c
>>>>>>> @@ -67,6 +67,13 @@ typedef struct QuorumVotes {
>>>>>>> =20
>>>>>>>  typedef struct QuorumChild {
>>>>>>>      BdrvChild *child;
>>>>>>> +
>>>>>>> +    /*
>>>>>>> +     * If set, check whether this node can be replaced without any
>>>>>>> +     * other parent noticing: Unshare CONSISTENT_READ, and take th=
e
>>>>>>> +     * WRITE permission.
>>>>>>> +     */
>>>>>>> +    bool to_be_replaced;
>>>>>>
>>>>>> I don't understand these permission changes. How does (preparing for=
)
>>>>>> detaching a node from quorum make its content invalid?
>>>>>
>>>>> It doesn=E2=80=99t, of course.  What we are preparing for is to repla=
ce it by
>>>>> some other node with some other content.
>>>>>
>>>>>> And why do we
>>>>>> suddenly need WRITE permissions even if the quorum node is only used
>>>>>> read-only?
>>>>>>
>>>>>> The comment is a bit unclear, too. "check whether" implies that both
>>>>>> outcomes could be true, but it doesn't say what happens in either ca=
se.
>>>>>> Is this really "make sure that"?
>>>>>
>>>>> I think the comment is not only unclear, it is the problem.  (Well,
>>>>> maybe the code is also.)
>>>>>
>>>>> This series is about fixing at least some things about replacing node=
s
>>>>> by mirroring.  The original use cases this was introduced for was to =
fix
>>>>> broken quorum children: The other children are still intact, so you r=
ead
>>>>> from the quorum node and replace the broken child (which maybe shows
>>>>> invalid data, or maybe just EIO) by the fixed mirror result.
>>>>>
>>>>> Replacing that broken node by the fixed one changes the data that=E2=
=80=99s
>>>>> visible on that node.
>>>>
>>>> Hm, yes, that's true. But I wonder if this is really something that th=
e
>>>> permission system must catch. Like other graph manipulations, it's
>>>> essentially the user saying "trust me, I know what I'm doing, this nod=
e
>>>> makes sense in this place".
>>>>
>>>> Because if you assume that the user could add a node with unsuitable
>>>> content and you want to prevent this, where do we stop?
>>>> blockdev-snapshot can insert a non-empty overlay, which would result i=
n
>>>> visible data change. Should we therefore only allow snapshots when
>>>> shared writes are allowed? This doesn't work obviously.
>>>>
>>>> So I'm inclined to say that this is the user's responsibility and we
>>>> don't have to jump through hoops to prevent every possible way that th=
e
>>>> user could mess up. (Which often also result in preventing legitimate
>>>> cases like here a quorum of read-only nodes.)
>>>
>>> Well, if you ask the question =E2=80=9Cwhere do we stop=E2=80=9D, we al=
so have to ask
>>> the question =E2=80=9Cwhere do we start=E2=80=9D.  If we say the user k=
nows what they=E2=80=99re
>>> doing, we might as well drop the whole can_replace infrastructure
>>> altogether and just assume that you can replace any node by anything.
>>
>> Well, I don't actually know if that would be completely unreasonable.
>> The idea was obviously to keep graph changes restricted to very specific
>> cases to avoid nasty surprises like triggering latent bugs. Meanwhile we
>> have quite a few more operations that allow changing the graph.
>>
>> So if preventing some cases gives us headaches and is probably more work
>> than dealing with any bugs they might reveal, maybe preventing them is
>> wrong.
>>
>> I'm just afraid that we might be overengineering this and waste time on
>> things that we don't actually get much use from.
>=20
> That=E2=80=99s why I=E2=80=99m asking.

(One thing to consider here, though, is that this series exists and has
been reviewed by Vladimir in full, so most of the engineering effort has
already been done.  In contrast, writing a new series to drop the whole
can_replace infrastructure with no replacement may actually cost more.)

Max


--qJdfDjipM2Hy6YaNMAsvF8TTfd0Tc6beG--

--PXnANC4CH6LWfjTAn8yOOLcXmVubvQEJA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl48QykACgkQ9AfbAGHV
z0BOyQf/V9G/wepwkRtmzgfZAdK4VgRJ3UAG04ENBSOG/0rE/Cj9JFH5IWYQrgQS
iI/6J+SAk2KQrifYqdfU4EzV2AcCP6tN4pH+8Kh/2IVeC530EUclUeMCKsGr85xb
z62OuPG4sFyyvUzK+fxINUMPMAc8yY0sg72VEp34sNWvatU9DmaBn+Ye+fpcwM2H
JQ/ceBi30KgU4BTsMVGuze23r3xUJ6S7F9rgvjI5oanvm6POTZk9H+lDAnCHe/Gm
ZfIplwu/hJnZrbmHDw/Aw5fe3wNnYdRenLGDlxauTdVQ4eR1LhIeJkleeeLIz0ie
iS6OswXwEAMUX2M8q0RmEnymOoxMwA==
=vhm8
-----END PGP SIGNATURE-----

--PXnANC4CH6LWfjTAn8yOOLcXmVubvQEJA--


