Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49647C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 15:52:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54E6822254
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 15:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b1uASh3i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E6822254
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT5Xr-0006Ls-Ft
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 11:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kT5WC-0005Kn-6t
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 11:50:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20431)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kT5W6-0001NI-SN
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 11:50:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602777005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TvhUwzny599fy2pKJv3NJLl2xvCRYC0S8/dQL97VZ6o=;
 b=b1uASh3itZYQxZ+pl7DrdXNixAyzWraM8Df1mBpBjWAlBxFbRHEaB5RjJokyOFzb9JFteD
 l/GE6ifD0Y8HJcpGn4lUE6a4/ggtKR2SIDjN/5jpNbIszGZTT6P3XIk5ISxkU7hOmWr/z4
 5520afZ5XkX2Mpc/5FBXX1sfD+ObuG4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-bIj53fVXP8u07Ot4RfyHCA-1; Thu, 15 Oct 2020 11:50:03 -0400
X-MC-Unique: bIj53fVXP8u07Ot4RfyHCA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2ED4109106A;
 Thu, 15 Oct 2020 15:50:01 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.194.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C4FBB73661;
 Thu, 15 Oct 2020 15:49:52 +0000 (UTC)
Subject: Re: [PATCH v11 09/13] copy-on-read: skip non-guest reads if no copy
 needed
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1602524605-481160-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1602524605-481160-10-git-send-email-andrey.shinkevich@virtuozzo.com>
 <59ff1f29-149a-0870-b600-1a54f0421c05@redhat.com>
 <c363d263-1854-d766-e9d3-c8ae8008740f@virtuozzo.com>
 <bc862a74-6223-3c8d-d354-36f62bee2d3a@redhat.com>
 <cf5c632f-3edf-6526-c275-7c8c9d3460cd@virtuozzo.com>
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
Message-ID: <44883c53-23aa-786d-bf27-37a71103cef9@redhat.com>
Date: Thu, 15 Oct 2020 17:49:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <cf5c632f-3edf-6526-c275-7c8c9d3460cd@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jgGkrZYTCkyVdcxzy8kr5Bky8Ted2Bb2i"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:10:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.019, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, fam@euphon.net, libvir-list@redhat.com,
 qemu-devel@nongnu.org, armbru@redhat.com, stefanha@redhat.com, den@openvz.org,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jgGkrZYTCkyVdcxzy8kr5Bky8Ted2Bb2i
Content-Type: multipart/mixed; boundary="P2Zz7Z81tiseYjkhHzQyWl23xCi0Zv39o"

--P2Zz7Z81tiseYjkhHzQyWl23xCi0Zv39o
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.10.20 18:39, Vladimir Sementsov-Ogievskiy wrote:
> 14.10.2020 19:30, Max Reitz wrote:
>> On 14.10.20 17:22, Vladimir Sementsov-Ogievskiy wrote:
>>> 14.10.2020 15:51, Max Reitz wrote:
>>>> On 12.10.20 19:43, Andrey Shinkevich wrote:
>>>>> If the flag BDRV_REQ_PREFETCH was set, pass it further to the
>>>>> COR-driver to skip unneeded reading. It can be taken into account for
>>>>> the COR-algorithms optimization. That check is being made during the
>>>>> block stream job by the moment.
>>>>>
>>>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>>>> ---
>>>>> =C2=A0=C2=A0 block/copy-on-read.c | 13 +++++++++----
>>>>> =C2=A0=C2=A0 block/io.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 3 ++-
>>>>> =C2=A0=C2=A0 2 files changed, 11 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
>>>>> index b136895..278a11a 100644
>>>>> --- a/block/copy-on-read.c
>>>>> +++ b/block/copy-on-read.c
>>>>> @@ -148,10 +148,15 @@ static int coroutine_fn
>>>>> cor_co_preadv_part(BlockDriverState *bs,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 }
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> =C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D bdrv=
_co_preadv_part(bs->file, offset, n, qiov,
>>>>> qiov_offset,
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 local_flags);
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn ret;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!!(flags & BDRV_REQ_P=
REFETCH) &
>>>>
>>>> How about dropping the double negation and using a logical &&
>>>> instead of
>>>> the binary &?
>>>>
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !=
(local_flags & BDRV_REQ_COPY_ON_READ)) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /=
* Skip non-guest reads if no copy needed */
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>>>
>>>> Hm.=C2=A0 I would have just written the negated form
>>>>
>>>> (!(flags & BDRV_REQ_PREFETCH) || (local_flags & BDRV_REQ_COPY_ON_READ)=
)
>>>>
>>>> and put the =E2=80=9Cskip=E2=80=9D comment above that condition.
>>>>
>>>> (Since local_flags is initialized to flags, it can be written as a
>>>> single comparison, but that=E2=80=99s a matter of taste and I=E2=80=99=
m not going to
>>>> recommend either over the other:
>>>>
>>>> ((local_flags & (BDRV_REQ_PREFETCH | BDRV_REQ_COPY_ON_READ)) !=3D
>>>> BDRV_REQ_PREFETCH)
>>>>
>>>> )
>>>>
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
et =3D bdrv_co_preadv_part(bs->file, offset, n, qiov,
>>>>> qiov_offset,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 local_flags);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f (ret < 0) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 o=
ffset +=3D n;
>>>>> diff --git a/block/io.c b/block/io.c
>>>>> index 11df188..bff1808 100644
>>>>> --- a/block/io.c
>>>>> +++ b/block/io.c
>>>>> @@ -1512,7 +1512,8 @@ static int coroutine_fn
>>>>> bdrv_aligned_preadv(BdrvChild *child,
>>>>> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max_bytes =3D ROUND_UP(MA=
X(0, total_bytes - offset), align);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bytes <=3D max_bytes && byte=
s <=3D max_transfer) {
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D bdrv_driver_pread=
v(bs, offset, bytes, qiov,
>>>>> qiov_offset, 0);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D bdrv_driver_pread=
v(bs, offset, bytes, qiov,
>>>>> qiov_offset,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags & bs->supported_r=
ead_flags);
>>>
>>>
>>> When BDRV_REQ_PREFETCH is passed, qiov may be (and generally should be)
>>> NULL. This means, that we can't just drop the flag when call the driver
>>> that doesn't support it.
>>
>> True. :/
>>
>>> Actually, if driver doesn't support the PREFETCH flag we should do
>>> nothing.
>>
>> Hm.=C2=A0 But at least in the case of COR, PREFETCH is not something tha=
t can
>> be optimized to be a no-op (unless the COR is a no-op); it still denotes
>> a command that must be executed.
>>
>> So if we can=E2=80=99t pass it to the driver, I don=E2=80=99t think we s=
hould do
>> nothing, but to return an error.=C2=A0 Or maybe we could even assert tha=
t it
>> isn=E2=80=99t set for drivers that don=E2=80=99t support it, because at =
least right now
>> such a case would just be a bug.
>=20
> Hmm. Reasonable..
>=20
> So, let me summarize the cases:
>=20
> 1. bdrv_co_preadv(.. , PREFETCH | COR)
>=20
> =C2=A0 In this case generic layer should handle both flags and pass flags=
=3D0
> to driver
>=20
> 2. bdrv_co_preadv(.., PREFETCH)
>=20
> 2.1 driver supporst PREFETCH
> =C2=A0 =C2=A0 OK, pass PREFETCH to driver, no problems
>=20
> 2.2 driver doesn't support PREFETCH
>=20
> =C2=A0 We can just abort() here, as the only source of PREFETCH without C=
OR
> would be
> =C2=A0 stream job driver, which must read from COR filter.
>=20
> =C2=A0 More generic solution is to allocate temporary buffer (at least if
> qiov is NULL)
> =C2=A0 and call underlying driver .preadv with flags=3D0 on that temporar=
y
> buffer. But
> =C2=A0 just abort() is simpler and should work for now.

Agreed.

Max


--P2Zz7Z81tiseYjkhHzQyWl23xCi0Zv39o--

--jgGkrZYTCkyVdcxzy8kr5Bky8Ted2Bb2i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl+Ib54ACgkQ9AfbAGHV
z0CIygf/a5Z8Nhoj1hvxyznENOA2b3f5LBnNZJOayJyDoZM1+k09wEE3DokMwClT
1j5jnchQ+CMKWA7Jl6Nhu1h6isqYLJ1BUHiF9xKpzzrI6G2pGGL3Ea19nlruKy4R
SsM5DrQk9d09UT8LadnHvdk+nlNMlW5gRNvik26zenCYr1v98sCMnIdAMbgyH6B2
QcuqRlqy9yW3gt1BSoe73lH5gKPNhFvGKBAg5lw0tofa0Xdc0rEopA2CVojU5swL
4SWPYl+UPyJDLO19m0jfRmbpvNav4Q/yncWUjDcV3CVREV29E5Y/+uu6x4auyCRj
bmMe+KvkHsUrEdAqyIYFIrF1WRh86A==
=w7kd
-----END PGP SIGNATURE-----

--jgGkrZYTCkyVdcxzy8kr5Bky8Ted2Bb2i--


