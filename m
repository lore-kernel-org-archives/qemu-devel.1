Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BA4C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 15:58:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FC3922248
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 15:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NbCqpvKg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FC3922248
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT5dp-00080D-6a
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 11:58:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kT5cW-0007FM-55
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 11:56:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56494)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kT5cT-0002Rd-Px
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 11:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602777404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3Hiydog49W35cRls/qEUehaVmRWZqc38/b8HEvt+5yQ=;
 b=NbCqpvKgzkwrGQyTaSaDc06vzZZAHxeZkbb96WFCYpJtYa2NzjMYbUDppU9e0uV780TA43
 rMHCGm9xA+2e1AjhKh8Sc3+BIc80Z5eC9C5BiGV6X8A4C4gTK4ivbM7VNyneJdXG8CXub0
 EbRMRzY9iAbJ2Es7k7dXe52KMMYU2Rk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-RR-6OQNzPzqcfTW6jJXbWQ-1; Thu, 15 Oct 2020 11:56:42 -0400
X-MC-Unique: RR-6OQNzPzqcfTW6jJXbWQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D38A810E2185;
 Thu, 15 Oct 2020 15:56:40 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.194.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D5ADE10013C1;
 Thu, 15 Oct 2020 15:56:31 +0000 (UTC)
Subject: Re: [PATCH v11 05/13] copy-on-read: limit COR operations to base in
 COR driver
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1602524605-481160-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1602524605-481160-6-git-send-email-andrey.shinkevich@virtuozzo.com>
 <6dc38263-ad9c-f238-7197-68e920b6080d@redhat.com>
 <7b649922-6c4d-7d5f-fb52-c97c1c34b7d8@virtuozzo.com>
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
Message-ID: <80f81abd-c810-c3a1-48aa-b1d94bdfda32@redhat.com>
Date: Thu, 15 Oct 2020 17:56:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <7b649922-6c4d-7d5f-fb52-c97c1c34b7d8@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="YFbTjZ9QxMVMuPBpTnRYvQGQ2tGvGNjP0"
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 libvir-list@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanha@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YFbTjZ9QxMVMuPBpTnRYvQGQ2tGvGNjP0
Content-Type: multipart/mixed; boundary="HV32CcTo85vfOwUqWxgnEHCojFDxMqr92"

--HV32CcTo85vfOwUqWxgnEHCojFDxMqr92
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.10.20 20:57, Andrey Shinkevich wrote:
> On 14.10.2020 15:01, Max Reitz wrote:
>> On 12.10.20 19:43, Andrey Shinkevich wrote:
>>> Limit COR operations by the base node in the backing chain when the
>>> overlay base node name is given. It will be useful for a block stream
>>> job when the COR-filter is applied. The overlay base node is passed as
>>> the base itself may change due to concurrent commit jobs on the same
>>> backing chain.
>>>
>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>> ---
>>> =C2=A0 block/copy-on-read.c | 39 +++++++++++++++++++++++++++++++++++++-=
-
>>> =C2=A0 1 file changed, 37 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
>>> index c578b1b..dfbd6ad 100644
>>> --- a/block/copy-on-read.c
>>> +++ b/block/copy-on-read.c
>>> @@ -122,8 +122,43 @@ static int coroutine_fn
>>> cor_co_preadv_part(BlockDriverState *bs,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t qiov_offset,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int flags)
>>> =C2=A0 {
>=20
> [...]
>=20
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
 =3D bdrv_is_allocated_above(bdrv_cow_bs(bs->file->bs),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 state->base_overlay, true,
>>> offset,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 n, &n);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
(ret) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 local_flags |=3D BDRV_REQ_COPY_ON_READ;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> Furthermore, I just noticed =E2=80=93 can the is_allocated functions not=
 return
>> 0 in @n, when @offset is a the EOF?=C2=A0 Is that something to look out =
for?
>> =C2=A0 (I=E2=80=99m not sure.)
>>
>> Max
>>
>=20
> The check for EOF is managed earlier in the stream_run() for a
> block-stream job. For other cases of using the COR-filter, the check for
> EOF can be added to the cor_co_preadv_part().
> I would be more than happy if we can escape the duplicated checking for
> is_allocated in the block-stream. But how the stream_run() can stop
> calling the blk_co_preadv() when EOF is reached if is_allocated removed
> from it?

True.  Is it that bad to lose that optimization, though?  (And I would
expect the case of a short backing file to be rather rare, too.)

> May the cor_co_preadv_part() return EOF (or other error code)
> to be handled by a caller if (ret =3D=3D 0 && n =3D=3D 0 && (flags &
> BDRV_REQ_PREFETCH)?

That sounds like a bad hack.  I=E2=80=99d rather keep the double is_allocat=
ed().

But what would be the problem with losing the short backing file
optimization?  Just performance?  Or would we end up writing actual
zeroes into the overlay past the end of the backing file?  Hm, probably
not, if the COR filter would detect that case and handle it like stream
does.

So it seems only a question of performance to me, and I don=E2=80=99t think=
 it
would be that bad to in this rather rare case to have a bunch of useless
is_allocated and is_allocated_above calls past the backing file=E2=80=99s E=
OF.
(Maybe I=E2=80=99m wrong, though.)

Max


--HV32CcTo85vfOwUqWxgnEHCojFDxMqr92--

--YFbTjZ9QxMVMuPBpTnRYvQGQ2tGvGNjP0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl+IcS4ACgkQ9AfbAGHV
z0BJhQf8D+CD8Z/L1H0fR0ei7hStuHJZ0Lt1Xt/rVFuWta38UT2OJ3kALrvKrqXW
lhozv/vvnQ9Rocp2lfvXrxkXHLsSI8gVD6C5tKLxtvMzcJA6dbg8rr7YfG1KbuGW
qncAf1d7yIfRxrXU6bnvETu4u2vGfVIP7cTGis+dqXTdd8fQ50YEYV9hCvfUezpR
eDMptgO7N7gDgSzfzEHU3+AeAiXn9/DLwmkrXwuIgMKzHKWxvVqc/IQcqeDiXTOx
3ifPhlq/3AnSLGLR+AbkdKO4vvoIohSwufxzWxyTS8qYb3++4XsMQbVxbPk0ZNer
4nHZZF2SA4fQ1i0ynSfRA7/foA/ftQ==
=8Flk
-----END PGP SIGNATURE-----

--YFbTjZ9QxMVMuPBpTnRYvQGQ2tGvGNjP0--


