Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0FDC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 12:47:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4B6220708
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 12:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JmCXm0M+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4B6220708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLQeK-000291-Nf
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 08:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kLQda-0001ex-7X
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 08:46:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43149)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kLQdX-0006jA-FD
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 08:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600951569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=CGgdG9jGEf6N66KLx/ZohEMslHeSAn+QkcSOMzuO/vg=;
 b=JmCXm0M+my2CKAThrtf3hkJ3Es07O43P5TcEqsN6xTqvjHVvGw+p9IOLbWQjk1WmfErgAU
 d2rNPp0gvQ+IyVThtvDpZ1tK1yftnZOVHfIHFDCXivdqXCEQjUkx7x7+XmARcOuj1KjgxM
 /dVBJvJrgOKPoqXyRI1bRxl69VNLUIA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-4dw7UmddPTCcaR4vUP8hYw-1; Thu, 24 Sep 2020 08:46:07 -0400
X-MC-Unique: 4dw7UmddPTCcaR4vUP8hYw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2101AD502;
 Thu, 24 Sep 2020 12:46:04 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-153.ams2.redhat.com
 [10.36.114.153])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F41B55C1C7;
 Thu, 24 Sep 2020 12:46:01 +0000 (UTC)
Subject: Re: [PATCH v8 6/7] block-stream: freeze link to base node during
 stream job
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1598633579-221780-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1598633579-221780-7-git-send-email-andrey.shinkevich@virtuozzo.com>
 <9739719d-0681-d839-cf8d-398b78b6d323@redhat.com>
 <3a52e54e-22fe-6eee-439a-dc1db0a1bf63@virtuozzo.com>
 <a6bc0dc7-12d8-6a63-6885-2cbff7da580a@redhat.com>
 <c691f24f-a223-f13e-2d48-9a7d1e558572@virtuozzo.com>
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
Message-ID: <0f478f6e-77fe-476e-584f-7b4d4262dca0@redhat.com>
Date: Thu, 24 Sep 2020 14:46:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <c691f24f-a223-f13e-2d48-9a7d1e558572@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="aG8NwhZrel2elzQSH3oIYfvg3lfcgiZtG"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 armbru@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aG8NwhZrel2elzQSH3oIYfvg3lfcgiZtG
Content-Type: multipart/mixed; boundary="r9uZMevWPNOMdeTtkB9BORSNj0JWntqQJ"

--r9uZMevWPNOMdeTtkB9BORSNj0JWntqQJ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07.09.20 14:17, Vladimir Sementsov-Ogievskiy wrote:
> 07.09.2020 14:44, Max Reitz wrote:
>> On 04.09.20 15:48, Vladimir Sementsov-Ogievskiy wrote:
>>> 04.09.2020 16:21, Max Reitz wrote:
>>>> On 28.08.20 18:52, Andrey Shinkevich wrote:
>>>>> To keep the base node unchanged during the block-stream operation,
>>>>> freeze it as the other part of the backing chain with the intermediat=
e
>>>>> nodes related to the job.
>>>>> This patch revers the change made with the commit c624b015bf as the
>>>>> correct base file name and its format have to be written down to the
>>>>> QCOW2 header on the disk when the backing file is being changed after
>>>>> the stream job completes.
>>>>> This reversion incurs changes in the tests 030, 245 and discards the
>>>>> test 258 where concurrent stream/commit jobs are tested. When the lin=
k
>>>>> to a base node is frozen, the concurrent job cannot change the common
>>>>> backing chain.
>>>>>
>>>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>>>> ---
>>>>> =C2=A0=C2=A0 block/stream.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 29 ++------
>>>>> =C2=A0=C2=A0 tests/qemu-iotests/030=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1=
0 +--
>>>>> =C2=A0=C2=A0 tests/qemu-iotests/245=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 2 +-
>>>>> =C2=A0=C2=A0 tests/qemu-iotests/258=C2=A0=C2=A0=C2=A0=C2=A0 | 161
>>>>> ---------------------------------------------
>>>>> =C2=A0=C2=A0 tests/qemu-iotests/258.out |=C2=A0 33 ----------
>>>>> =C2=A0=C2=A0 5 files changed, 14 insertions(+), 221 deletions(-)
>>>>> =C2=A0=C2=A0 delete mode 100755 tests/qemu-iotests/258
>>>>> =C2=A0=C2=A0 delete mode 100644 tests/qemu-iotests/258.out
>>>>
>>>> Does this need to be in this series?=C2=A0 (I=E2=80=99m not entirely s=
ure, based on
>>>> what I can see in patch 7.)
>>>>
>>>> When doing this, should we introduce a @bottom-node option
>>>> alongside, so
>>>> that we can make all the tests that are deleted here pass still, just
>>>> with changes?
>>>>
>>>
>>> That's a question to discuss, and I asked Andrey to make this patch
>>> in this
>>> simple way to see, how much damage we have with this change.
>>>
>>> Honestly, I doubt that we need the new option. Previously, we decided
>>> that
>>> we can make this change without a deprecation. If we still going to
>>> do it,
>>> we shouldn't care about these use cases. So, if we freeze base again
>>> wituhout
>>> a depreaction and:
>>>
>>> 1. add bottom-node
>>>
>>> =C2=A0=C2=A0- we keep the iotests
>>> =C2=A0=C2=A0- If (unlikely) someone will came and say: hey, you've brok=
en my
>>> working scenario, we will say "use bottom-node option, sorry"
>>> =C2=A0=C2=A0- Most likely we'll have unused option and corresponding un=
used logic,
>>> making code more complex for nothing (and we'll have to say "sorry"
>>> anyway)
>>>
>>> 2. without option
>>>
>>> =C2=A0=C2=A0- we loose the iotests. this looks scary, but it is honest:=
 we drop
>>> use-cases and corresponding iotests
>>> =C2=A0=C2=A0- If (unlikely) someone will came and say: hey, you've brok=
en my
>>> working scenario, he will have to wait for next release / package
>>> version / or update the downstream himself
>>> =C2=A0=C2=A0- Most likely all will be OK.
>>
>> Well, yes, we=E2=80=99ll disrupt either way, but it is a difference whet=
her we
>> can tell people immediately that there=E2=80=99s an alternative now, or =
whether
>> we=E2=80=99ll have to make them wait for the next release.
>>
>> Basically, the whole argument hinges on the question of whether anyone
>> uses this right now or not, and we just don=E2=80=99t know.
>>
>> The question remains whether this patch is necessary for this series.
>=20
> Otherwise iotests fail :)
>=20
>> We also have the option of introducing @bottom-node, leaving @base=E2=80=
=99s
>> behavior as-is
>=20
> You mean not make it freeze base again, but just don't care?

Yes.  I think the only problem with that would be that it=E2=80=99s unintui=
tive
in case the graph is modified while the job is running, but I can=E2=80=99t=
 find
that worse than forbidding that case completely.

(And I think it would be easier to explain if we introduced @bottom-node.)

>> and explaining it as a legacy option from which
>> @bottom-node is inferred.=C2=A0 Then specifying @base just becomes weird=
 and
>> problem-prone when the graph is reconfigured while the job is active,
>> but you can get around that by simply using the non-legacy option.
>=20
> Hmm. Last time, I thought that bottom-node was a bad idea, as we have a
> lot of problems with it,

Hm, did we?  Off the top of my head, I can=E2=80=99t remember any.  Besides=
 the
fact that it would require users to use a different parameter and us to
support two parameters unless we decide to deprecate @base.

> but you think it should be kept as preferred
> behavior? But this sounds as working idea.
>=20
> Then, we'll probably want to set skip_filters(bottom->backing) as
> backing of top in qcow2 metadata, and direct bottom->backing as new
> backing of top in block node graph.

I=E2=80=99m not sure whether I agree with skipping filters for the qcow2
metadata, just because then it=E2=80=99s different from the runtime state. =
 But
OTOH I would expect that any application that seriously cares about
filters would override the qcow2 metadata anyway, so I think I do agree
after all.

Yeah, I think skipping filters for the backing file name in the qcow2
header is right.

> Anyway, I like the idea to deprecate filename-based interfaces wherever
> we can.

Who doesn=E2=80=99t...

Max


--r9uZMevWPNOMdeTtkB9BORSNj0JWntqQJ--

--aG8NwhZrel2elzQSH3oIYfvg3lfcgiZtG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9slQgACgkQ9AfbAGHV
z0DtBQf/csyYmpJNkS4uRYTqa/L74f0KYXjBTcYlZIoQN+yXZqBFslJlcPbcDS12
8jk1RLx9iutwsb9wVy1/nLuJG0HZnvjbrlE7cfRA1yP1c6BRHZVPKVaaDQllZP78
0QsT9JYLeQoeEdLCGwglHMZ3MJmwxP+Xxxc8l+Hm9vDdd0zyAqyNoUygqz6nfmUe
gwJmU/e7y0axz6/FLQSvKn3FiwgVewDYpGTnSQtYLPLNCBixLPGJG3RKUjkrsVO+
jzVPDXnEVST0/+CMsdKCU4v7kW0koEBuelWZng0dqfuvdWdnLvYfOumO5DgfpuBD
Thp5J5gDL6M+IvxtvaVmYLqoq0KRxA==
=7FTm
-----END PGP SIGNATURE-----

--aG8NwhZrel2elzQSH3oIYfvg3lfcgiZtG--


