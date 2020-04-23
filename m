Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E903FC54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 13:57:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2AFB20728
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 13:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YWr15TUn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2AFB20728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRcM8-0004S0-Sk
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 09:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49642)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jRcLM-0003Uj-UU
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 09:56:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jRcLM-0007ra-Ip
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 09:56:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49755
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jRcLL-0007r2-VC
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 09:56:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587650202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hhcXPrEFaldtxuNp0IxhqrDFJ81hgx5pHnIeg4XFEZ8=;
 b=YWr15TUnRg9muVhrGjg/LfQFhRA13zvepPAMKlrmWU5z30vDaaPrI80911EUBgtHuEqGTW
 lrW9KvjqllHZBpOoJeJ3p0uJ3guS+tOQdtuDyOTFmlxvflP8IMaxGjkcR6x9JQUznFe0uz
 CObbUcemdy2Ya7EKTAkib8FI536FNhA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-lxRqhEm4Na647Lluku3E_A-1; Thu, 23 Apr 2020 09:56:38 -0400
X-MC-Unique: lxRqhEm4Na647Lluku3E_A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA5EB8014D6;
 Thu, 23 Apr 2020 13:56:36 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-212.ams2.redhat.com
 [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F864600E5;
 Thu, 23 Apr 2020 13:56:34 +0000 (UTC)
Subject: Re: [PATCH v5 4/9] qcow2: Support BDRV_REQ_ZERO_WRITE for truncate
To: Kevin Wolf <kwolf@redhat.com>
References: <20200422152129.167074-1-kwolf@redhat.com>
 <20200422152129.167074-5-kwolf@redhat.com>
 <282cd7bb-71e0-f3df-13cb-c098597cf704@redhat.com>
 <20200423132545.GB23654@linux.fritz.box>
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
Message-ID: <58ed8a55-ad6c-4d36-19c3-240392b93ff6@redhat.com>
Date: Thu, 23 Apr 2020 15:56:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200423132545.GB23654@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="irHALV5ce2mbEgO5BZ4NQE9wHwOT4hofP"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 06:43:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: berto@igalia.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--irHALV5ce2mbEgO5BZ4NQE9wHwOT4hofP
Content-Type: multipart/mixed; boundary="VGNxfhMvnOQL1M53xeK7zRQkLHcbw3nqr"

--VGNxfhMvnOQL1M53xeK7zRQkLHcbw3nqr
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 23.04.20 15:25, Kevin Wolf wrote:
> Am 23.04.2020 um 12:53 hat Max Reitz geschrieben:
>> On 22.04.20 17:21, Kevin Wolf wrote:
>>> If BDRV_REQ_ZERO_WRITE is set and we're extending the image, calling
>>> qcow2_cluster_zeroize() with flags=3D0 does the right thing: It doesn't
>>> undo any previous preallocation, but just adds the zero flag to all
>>> relevant L2 entries. If an external data file is in use, a write_zeroes
>>> request to the data file is made instead.
>>>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>>  block/qcow2.c | 30 ++++++++++++++++++++++++++++++
>>>  1 file changed, 30 insertions(+)
>>>
>>> diff --git a/block/qcow2.c b/block/qcow2.c
>>> index 9cfbdfc939..bd632405d1 100644
>>> --- a/block/qcow2.c
>>> +++ b/block/qcow2.c
>>
>> [...]
>>
>>> @@ -4214,6 +4215,35 @@ static int coroutine_fn qcow2_co_truncate(BlockD=
riverState *bs, int64_t offset,
>>>          g_assert_not_reached();
>>>      }
>>> =20
>>> +    if ((flags & BDRV_REQ_ZERO_WRITE) && offset > old_length) {
>>> +        uint64_t zero_start =3D QEMU_ALIGN_UP(old_length, s->cluster_s=
ize);
>>> +        uint64_t zero_end =3D QEMU_ALIGN_UP(offset, s->cluster_size);
>>> +
>>> +        /* Use zero clusters as much as we can */
>>> +        ret =3D qcow2_cluster_zeroize(bs, zero_start, zero_end - zero_=
start, 0);
>>
>> It=E2=80=99s kind of a pity that this changes the cluster mappings that =
were
>> established when using falloc/full preallocation already (i.e., they
>> become preallocated zero clusters then, so when writing to them, we need
>> COW again).
>>
>> But falloc/full preallocation do not guarantee that the new data is
>> zero, so I suppose this is the only thing we can reasonably do.
>=20
> If we really want, I guess we could make full preallocation first try
> passing BDRV_REQ_ZERO_WRITE to the protocol layer and if that succeeds,
> we could skip setting the zero cluster flag at the qcow2 level.

That might be nice.

> Feels like a separate patch, though.

Definitely, yes.

Max


--VGNxfhMvnOQL1M53xeK7zRQkLHcbw3nqr--

--irHALV5ce2mbEgO5BZ4NQE9wHwOT4hofP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6hnpAACgkQ9AfbAGHV
z0Cq9ggAqSlk8yUvQTXWUKq9dbFxKYOfaa3Ng6sMS6VLiusjeAFlC2mPeT0bjH63
9UglMKjB2HRUpkcJ0y6yqTShNZlNjnP6tEIyj0NgBr+I9J9N2CBrZ9DLbk93CLwZ
LS19wpuLAmOQrINa021URD7HTUWTV/G3R+ZFHBcKXoQOg84hlSglToqlcs0OQyEP
ZpAmprj8UFj8Xfb+WRnb4gPE/59mNouyWhZT4fuhzzm+Zii3rplZr2GQQs129QEH
WVBlYwjp3fPeV+s2yB8gIjvviLhZNQByzelRn2akkVF6i+8Jue43WeAYmO7ji9XA
TH9it8RNTowXizBGhidMEm+gTavdQg==
=dGFF
-----END PGP SIGNATURE-----

--irHALV5ce2mbEgO5BZ4NQE9wHwOT4hofP--


