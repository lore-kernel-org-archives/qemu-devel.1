Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89733C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 16:39:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44440206C3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 16:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TAv2G5jZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44440206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg9x2-0000L8-5X
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 12:39:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jg9w1-00086L-U7
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 12:38:41 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27140
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jg9w0-0001wU-9d
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 12:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591115918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=p+CSE2ul/8zMqOPGR4sRWHLHclTMwPXudGJTbwnSqCc=;
 b=TAv2G5jZbnWM3wtHuBfi+m8PhGt4IgMiRKqPglwlfnfvhvqrvJIvFuzmx95tFdOmCs6q1N
 jEfL2TniwpUlFXnO0R+kdRV8n5bwSaPoqVRyLurNbD++o9PSGW75WZxJODCgNbgVIMnNus
 quomtPFwW6K25rh3ysyx1rmQtZ9seuk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-PfsYgSDtOROZcCsZcpZZAQ-1; Tue, 02 Jun 2020 12:38:36 -0400
X-MC-Unique: PfsYgSDtOROZcCsZcpZZAQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2060461;
 Tue,  2 Jun 2020 16:38:34 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-81.ams2.redhat.com
 [10.36.114.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D8917E7E6;
 Tue,  2 Jun 2020 16:38:29 +0000 (UTC)
Subject: Re: [PATCH for-4.2 v2 3/3] block/file-posix: Let post-EOF fallocate
 serialize
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20191101152510.11719-1-mreitz@redhat.com>
 <20191101152510.11719-4-mreitz@redhat.com>
 <dfe5fbff-ce04-504e-542b-11095a57fd78@virtuozzo.com>
 <50115120-9d1a-79f7-64f4-cd45508c0e7c@redhat.com>
 <19babc97-3cc9-e924-ef0b-cca3c8cefcae@virtuozzo.com>
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
Message-ID: <562a7703-184c-36b6-3b9e-da5fcb3b9174@redhat.com>
Date: Tue, 2 Jun 2020 18:38:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <19babc97-3cc9-e924-ef0b-cca3c8cefcae@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="QyEbfyiQGRfR2Kl6LG7rW3uJCx6esIMo2"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 03:23:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QyEbfyiQGRfR2Kl6LG7rW3uJCx6esIMo2
Content-Type: multipart/mixed; boundary="ST76PPKWyA71gXNva10g5Do9ovM8cVJ22"

--ST76PPKWyA71gXNva10g5Do9ovM8cVJ22
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 02.06.20 18:16, Vladimir Sementsov-Ogievskiy wrote:
> 02.06.2020 18:46, Max Reitz wrote:
>> On 02.06.20 16:43, Vladimir Sementsov-Ogievskiy wrote:
>>> 01.11.2019 18:25, Max Reitz wrote:
>>>
>>> Sorry for being late, I have some comments
>>
>> Uh, well.=A0 Reasonable, but I hope you don=92t mind me having no longer
>> having this patch fresh on my mind.
>>
>>>> The XFS kernel driver has a bug that may cause data corruption for
>>>> qcow2
>>>> images as of qemu commit c8bb23cbdbe32f.=A0 We can work around it by
>>>> treating post-EOF fallocates as serializing up until infinity
>>>> (INT64_MAX
>>>> in practice).
>>>>
>>>> Cc: qemu-stable@nongnu.org
>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>> ---
>>>> =A0=A0 block/file-posix.c | 36 ++++++++++++++++++++++++++++++++++++
>>>> =A0=A0 1 file changed, 36 insertions(+)
>>>>
>>>> diff --git a/block/file-posix.c b/block/file-posix.c
>>>> index 0b7e904d48..1f0f61a02b 100644
>>>> --- a/block/file-posix.c
>>>> +++ b/block/file-posix.c
>>>> @@ -2721,6 +2721,42 @@ raw_do_pwrite_zeroes(BlockDriverState *bs,
>>>> int64_t offset, int bytes,
>>>> =A0=A0=A0=A0=A0=A0 RawPosixAIOData acb;
>>>> =A0=A0=A0=A0=A0=A0 ThreadPoolFunc *handler;
>>>> =A0=A0 +#ifdef CONFIG_FALLOCATE
>>>> +=A0=A0=A0 if (offset + bytes > bs->total_sectors * BDRV_SECTOR_SIZE) =
{
>>>> +=A0=A0=A0=A0=A0=A0=A0 BdrvTrackedRequest *req;
>>>> +=A0=A0=A0=A0=A0=A0=A0 uint64_t end;
>>>> +
>>>> +=A0=A0=A0=A0=A0=A0=A0 /*
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0 * This is a workaround for a bug in the Linu=
x XFS driver,
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0 * where writes submitted through the AIO int=
erface will be
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0 * discarded if they happen beyond a concurre=
ntly running
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0 * fallocate() that increases the file length=
 (i.e., both the
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0 * write and the fallocate() happen beyond th=
e EOF).
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0 *
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0 * To work around it, we extend the tracked r=
equest for this
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0 * zero write until INT64_MAX (effectively in=
finity), and mark
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0 * it as serializing.
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0 *
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0 * We have to enable this workaround for all =
filesystems and
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0 * AIO modes (not just XFS with aio=3Dnative)=
, because for
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0 * remote filesystems we do not know the host=
 configuration.
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0 */
>>>> +
>>>> +=A0=A0=A0=A0=A0=A0=A0 req =3D bdrv_co_get_self_request(bs);
>>>> +=A0=A0=A0=A0=A0=A0=A0 assert(req);
>>>> +=A0=A0=A0=A0=A0=A0=A0 assert(req->type =3D=3D BDRV_TRACKED_WRITE);
>>>> +=A0=A0=A0=A0=A0=A0=A0 assert(req->offset <=3D offset);
>>>> +=A0=A0=A0=A0=A0=A0=A0 assert(req->offset + req->bytes >=3D offset + b=
ytes);
>>>
>>> Why these assertions?
>>
>> Mostly to see that bdrv_co_get_self_request() (introduced by the same
>> series) actually got the right request.=A0 (I suppose.)
>>
>>> TrackedRequest offset and bytes fields correspond
>>> to the original request. When request is being expanded to satisfy
>>> request_alignment, these fields are not updated.
>>
>> Well, shrunk in this case, but OK.
>>
>>> So, maybe, we should assert overlap_offset and overlap_bytes?
>>
>> Maybe, but would that have any benefit?=A0 Especially after this patch
>> having been in qemu for over half a year?
>>
>> (Also, intuitively off the top of my head I don=92t see how it would mak=
e
>> more sense to check overlap_offset and overlap_bytes, if all the
>> assertions are for is to see that we got the right request.
>> overlap_offset and overlap_bytes may still not exactly match @offset or
>> @bytes, respectively.)
>>
>> Your suggestion makes it sound a bit like you have a different purpose
>> in mind what these assertions might be useful for...?
>=20
> No I just think it may have false-positives, when actual request is large=
r
> than original.

Seems like a bug.  Why would we zero more than originally requested?

> So offset may be < req->offset and req->offset +
> req->bytes may be
> less than offset + bytes. And we will crash. I should make a reproducer t=
o
> prove it, but it seems possible.

I=92m definitely curious.

>>>> +
>>>> +=A0=A0=A0=A0=A0=A0=A0 end =3D INT64_MAX & -(uint64_t)bs->bl.request_a=
lignment;
>>>> +=A0=A0=A0=A0=A0=A0=A0 req->bytes =3D end - req->offset;
>>>
>>> And I doubt that we should update req->bytes. We never updated it in
>>> other places, it corresponds to original request. It's enough to update
>>> overlap_bytes to achieve corresponding serialising.
>>
>> Does it hurt?=A0 If so, would you send a patch?
>>
>> I assume you reply to this patch instead of writing a patch because you
>> have the same feeling of =93It probably doesn=92t really matter, so let=
=92s
>> have a discussion first=94.
>=20
> 1. yes, and
> 2. I probably don't see the full picture around tracked requests

Neither do I, that=92s for sure.

>> My stance is: I don=92t think it matters and this whole piece of code is=
 a
>> hack that shouldn=92t exist, obviously.=A0 So I don=92t really care how =
it
>> fits into all of our other code.
>>
>> I would like to say I wouldn=92t mind a patch to drop the req->bytes
>> assignment, but OTOH it would mean I=92d have to review it and verify th=
at
>> it=92s indeed sufficient to set overlap_bytes.
>>
>> If it=92s in any way inconvenient for you that req->bytes is adjusted,
>> then of course please send one.
>>
>>>> +=A0=A0=A0=A0=A0=A0=A0 req->overlap_bytes =3D req->bytes;
>>>> +
>>>> +=A0=A0=A0=A0=A0=A0=A0 bdrv_mark_request_serialising(req, bs->bl.reque=
st_alignment);
>>>
>>> Not sure, how much should we care about request_alignment here, I think=
,
>>> it's enough to just set req->overlap_bytes =3D INT64_MAX -
>>> req->overlap_offest, but it doesn't really matter.
>>
>> As long as req->bytes is adjusted, we have to care, or the overlap_bytes
>> calculation in bdrv_mark_request_serialising will overflow.
>>
>> Well, one could argue that it doesn=92t matter because the MAX() will
>> still do the right thing, but overflowing is never nice.
>=20
> Hmm I think, if reduce it to just INT64_MAX, we should pass 1 as align
> to bdrv_mark_request_serialising.

True.

>> (Of course, it probably doesn=92t matter at all if we just wouldn=92t to=
uch
>> req->bytes.)
>>
>=20
> OK, thanks for the answer, I'll prepare a patch.

OK?  I=92m not sure where the benefit is (apart from the perhaps failing
assertions).  So it still looks to me like putting too much energy into
a hack.

(I think the original reason I set both req->bytes and
req->overlap_bytes was actually because I just wanted to be sure, and
didn=92t want to have to look too hard whether either would be sufficient.)

((Please also note that I can=92t guarantee I will review your patch in a
timely manner, for one thing because I can already rarely give that
promise (as you are probably painfully aware...); and now there=92s also
two weeks of mail on top for me to wade through after PTO.  So if
there=92s no reason to change anything apart from saving two LoC, well.
Failing assertions are a different matter altogether, though, of course.))

Max


--ST76PPKWyA71gXNva10g5Do9ovM8cVJ22--

--QyEbfyiQGRfR2Kl6LG7rW3uJCx6esIMo2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl7WgIMACgkQ9AfbAGHV
z0Aaagf9G9GPV4BGaomISINtu8QzLxJyT/2Tt9VvuKNVG1AJUKlPYuoXFkmEwyxE
SwVfGitgo4Dvx5p/gS8FFk4bhkaUPGudaABoZiLrQqmlmPh0cFq3tf4OjBvklh8O
RJnxZLmLgrTlu4Fi/c20Jrmx1QnVMaWeGspny/l2a/FTwVfOBB1xjnkO8Q1cNh5I
tPSgQ7A2zXCqsKpsuiiAQB08lqdAR+YnhG1Aum4KolKfwHdU+XXOGzpAhvmrEzlQ
mXYww540vGVgNX+t4PgAzuNKxGk22QoMVMWa3K/+VIZ06mOKv4HySksZLyOFWcv1
f9ktXR2gj8HisholrX84tr/OCE7Yjw==
=mMY7
-----END PGP SIGNATURE-----

--QyEbfyiQGRfR2Kl6LG7rW3uJCx6esIMo2--


