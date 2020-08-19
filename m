Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAD2C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 12:40:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 533E0206B5
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 12:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L/TWqvX7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 533E0206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8NOE-0002Az-Ez
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 08:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k8NNT-0001dB-Ss
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 08:39:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42533
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k8NNR-0002L4-4a
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 08:39:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597840775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=le6wAI7UdWsZMiDniNiTEfb0skV4sPOFegGyu3HAcd4=;
 b=L/TWqvX7FIRYXQAxUa6kYN7+EAd2xTsXeH9HPSbk/toj7ST76crUxgEUCO8loM5Ml1gTpy
 UXhp4UD6bxlN44oOPiDCuE6O0dXW37BfczrwZ2vTYW8rwTQfVuUUSkxMtq1486EIc+Ce4h
 r5ZfGgGtXGqj+fZSRK1NJGv0bgWL+h4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-3UtQHGIzPvuYMI3BTA-R_A-1; Wed, 19 Aug 2020 08:39:31 -0400
X-MC-Unique: 3UtQHGIzPvuYMI3BTA-R_A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7C3C186A57A;
 Wed, 19 Aug 2020 12:39:30 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-120.ams2.redhat.com
 [10.36.113.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 726CE1001281;
 Wed, 19 Aug 2020 12:39:29 +0000 (UTC)
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
 <9f8b1eb5-2039-b2c5-6330-7f39f2c21464@redhat.com>
 <0d9ded79-69f3-4875-a19f-b97893268cfb@virtuozzo.com>
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
Message-ID: <5a6ec8b3-f3a5-7763-ba2f-215df6d0e570@redhat.com>
Date: Wed, 19 Aug 2020 14:39:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0d9ded79-69f3-4875-a19f-b97893268cfb@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="U2iezUKAaxioRxz4emhG4zZw3Xf8Pjx3s"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 04:00:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
--U2iezUKAaxioRxz4emhG4zZw3Xf8Pjx3s
Content-Type: multipart/mixed; boundary="h0moW6iwsEndaeoliVEbImf9Zz8RKOzdM"

--h0moW6iwsEndaeoliVEbImf9Zz8RKOzdM
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.08.20 13:04, Vladimir Sementsov-Ogievskiy wrote:
> 10.08.2020 11:12, Max Reitz wrote:
>> On 07.08.20 12:29, Vladimir Sementsov-Ogievskiy wrote:

[...]

>>> But, with our proposed way (freeze only chain up to base_overlay
>>> inclusively, and use backing(base_overlay) as final backing), all will
>>> work as expected, and two parallel jobs will work..
>>
>> I don=E2=80=99t think it will work as expected because users can no long=
er
>> specify which node should be the base node after streaming.=C2=A0 And th=
e
>> QAPI schema says that base-node is to become the backing file of the top
>> node after streaming.
>=20
> But this will never work with either way: base node may disappear during
> stream. Even with you way, they only stable thing is "above-base", which
> backing child may be completely another node at stream finish.

Yeah, but after c624b015bf, that=E2=80=99s just how it is.  I thought the b=
est
would be an approach where if there are no graph changes during the job,
you would indeed end up with @base as the backing file afterwards.

[...]

>> Well, that still leaves the problem that users should be able to specify
>> which node is to become the base after streaming, and that that node
>> maybe shouldn=E2=80=99t be restricted to immediate children of COW image=
s.
>=20
> And again, this is impossible even with your way. I have an idea:
>=20
> What about making the whole thing explicit?
>=20
> We add an optional parameter to stream-job: bottom-node, which is
> mutally exclusive with specifying base.
>=20
> Then, if user specified base node, we freeze base as well, so it can't
> disappear. User will not be able to start parallel stream with this base
> node as top (because new stream can not insert a filter into frozen
> chain), but for sure it's rare case, used only in iotest 30 :)).
> Benefit: user have guarantee of what would be final backing node.

Sounds very nice to me, but...

> Otherwise, if user specified bottom-node, we use the way of this patch.
> So user can run parallel streams (iotest 30 will have to use bottom-node
> argument). No guarantee of final base-node, it would be backing of
> bottom-node at job finish.
>=20
> But, this is incompatible change, and we probably should wait for 3
> releases for deprecation of old behavior..

...yeah.  Hm.  What a pain, but right, we can just deprecate it.

Unfortunately, I don=E2=80=99t think there=E2=80=99s any way we could issue=
 a warning
(we=E2=80=99d want to deprecate using the @base node in something outside o=
f the
stream job, and we can=E2=80=99t really detect this case to issue a warning=
).
So it would be a deprecation found only in the deprecation notes and the
QAPI spec...

> Anyway, I feel now, that you convinced me. I'm not sure that we will not
> have to change it make filter work, but not reason to change something
> now. Andrey, could you try to rebase your series on top of this and fix
> iotest 30 by just specifying=C2=A0 exact node-names in it?..
>=20
>=20
> Hmmm. My thought goes further. Seems, that in this way, introducing
> explicit filter would be incompatible change anyway: it will break
> scenario with parallel stream jobs, when user specifies filenames, not
> node names (user will have to specify filter-node name as base for
> another stream job, as you said). So, it's incompatible anyway.
>=20
> What do you think of it? Could we break this scenario in one release
> without deprecation and don't care?

I don=E2=80=99t know, but I=E2=80=99m afraid I don=E2=80=99t think we can.

> Than I think my idea about base vs
> bottom-node arguments for stream job may be applied. Or what to do?
>=20
> If we can't break this scenario without a deprecation, we'll have to
> implement "implicit" filter, like for mirror, when filter-node-name is
> not specified. And for this implicit filter we'll need additional logic
> (closer to what I've proposed in a previous mail). Or, try to keep
> stream without a filter (not insert it at all and behave the old way),
> when filter-node-name is not specified. Than new features based on
> filter will be available only when filter-node-name is specified, but
> this is OK. The latter seems better for me.

If that works...


OK.  So what I think we can do is first just take this patch as part of
this series.  Then, we add @bottom-node separately and deprecate @base
not being frozen.

If it=E2=80=99s feasible to not add a stream filter node until the deprecat=
ion
period is over, then that should work.

Max


--h0moW6iwsEndaeoliVEbImf9Zz8RKOzdM--

--U2iezUKAaxioRxz4emhG4zZw3Xf8Pjx3s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl89HX8ACgkQ9AfbAGHV
z0DpsQf/dmZv7vJoG7iKGF6TfOObhqhVHKXpRWD3B9eZakOK/jo59tKk4bykEdLp
fvZCSXpx31HN4ie3cmFSQ2PjKHXKZe6ocMRff7wfmOZVsV3o20gQ7EaGDZRdJgLT
UjyPbh3xkaxDX2XWzpwoI+9R8xACyitt0S6S6Xy9l0njoJpYrQSl9Uv5go/xfoqG
GHRv/LvvYcJIOPcTtYhQezB+RmcpLiPY7j/4xXq7SBOMwLOG+EOl0Bzas/Q7ZudO
4JjmSbMCJTpUUqjg89JdB/aLCtoM16qspvt8zrOzFhk1gsgv5z0e0yg9GKROUUkV
m6781dqzY2r++Yda7oPTEOKzO0WJ8A==
=+CyD
-----END PGP SIGNATURE-----

--U2iezUKAaxioRxz4emhG4zZw3Xf8Pjx3s--


