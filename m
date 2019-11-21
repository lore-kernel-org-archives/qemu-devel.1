Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAAEC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 15:26:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 664AC20674
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 15:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dUCutkX3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 664AC20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXoLb-00079X-I9
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 10:26:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49968)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iXoKk-0006DI-Qd
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 10:25:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iXoKj-0006x1-8u
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 10:25:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37209
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iXoKh-0006uL-4X
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 10:25:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574349922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MKgx0Sdmj3YcEkB0LV/HC5BNcrlYQ4rPknRtpxKpPgg=;
 b=dUCutkX37RS5XqlzFe4FYSlUulj++xKgkBkjIMSvkhEc+3G9ikuhG3efm9nq5qdBir9jLZ
 +5gtLAPcpkLMSkRs7IPysBaEryus+L/5Wnc3Rzfv/ujQ2MfZ84NuxBwoBSXZAh4dQ4NX/e
 Y18QkQb4+/yDL8DzBaVwnp5wHPYeNNg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-ALtei2YeMwqCxxQ34c8weg-1; Thu, 21 Nov 2019 10:25:21 -0500
X-MC-Unique: ALtei2YeMwqCxxQ34c8weg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4784911BB;
 Thu, 21 Nov 2019 15:25:19 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-196.ams2.redhat.com
 [10.36.117.196])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4CFBD692B7;
 Thu, 21 Nov 2019 15:25:14 +0000 (UTC)
Subject: Re: [PATCH v2 2/6] block: truncate: Don't make backing file data
 visible
To: Kevin Wolf <kwolf@redhat.com>
References: <20191120184501.28159-1-kwolf@redhat.com>
 <20191120184501.28159-3-kwolf@redhat.com>
 <c53f6f2d-2451-2fb3-cbf0-2a1a686cccf5@redhat.com>
 <20191121113405.GE6007@linux.fritz.box>
 <38b48cd4-a7b6-c2c0-db38-99c2192b6d05@redhat.com>
 <20191121143331.GG6007@linux.fritz.box>
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
Message-ID: <f6224b51-c7c3-aa7f-00f2-c3a9c7e031a8@redhat.com>
Date: Thu, 21 Nov 2019 16:25:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191121143331.GG6007@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="M7mzQSUYWLNzmgmdf65PyOoh1RWlowitd"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: vsementsov@virtuozzo.com, stefanha@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--M7mzQSUYWLNzmgmdf65PyOoh1RWlowitd
Content-Type: multipart/mixed; boundary="EnegxIDTQ8Y5vXtKHIkKdzSJlUz7KMKuZ"

--EnegxIDTQ8Y5vXtKHIkKdzSJlUz7KMKuZ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 21.11.19 15:33, Kevin Wolf wrote:
> Am 21.11.2019 um 13:21 hat Max Reitz geschrieben:
>> On 21.11.19 12:34, Kevin Wolf wrote:
>>> Am 21.11.2019 um 09:59 hat Max Reitz geschrieben:
>>>> On 20.11.19 19:44, Kevin Wolf wrote:
>>>>> When extending the size of an image that has a backing file larger th=
an
>>>>> its old size, make sure that the backing file data doesn't become
>>>>> visible in the guest, but the added area is properly zeroed out.
>>>>>
>>>>> Consider the following scenario where the overlay is shorter than its
>>>>> backing file:
>>>>>
>>>>>     base.qcow2:     AAAAAAAA
>>>>>     overlay.qcow2:  BBBB
>>>>>
>>>>> When resizing (extending) overlay.qcow2, the new blocks should not st=
ay
>>>>> unallocated and make the additional As from base.qcow2 visible like
>>>>> before this patch, but zeros should be read.
>>>>>
>>>>> A similar case happens with the various variants of a commit job when=
 an
>>>>> intermediate file is short (- for unallocated):
>>>>>
>>>>>     base.qcow2:     A-A-AAAA
>>>>>     mid.qcow2:      BB-B
>>>>>     top.qcow2:      C--C--C-
>>>>>
>>>>> After commit top.qcow2 to mid.qcow2, the following happens:
>>>>>
>>>>>     mid.qcow2:      CB-C00C0 (correct result)
>>>>>     mid.qcow2:      CB-C--C- (before this fix)
>>>>>
>>>>> Without the fix, blocks that previously read as zeros on top.qcow2
>>>>> suddenly turn into A.
>>>>>
>>>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>>>> ---
>>>>>  block/io.c | 32 ++++++++++++++++++++++++++++++++
>>>>>  1 file changed, 32 insertions(+)
>>>>
>>>> Zeroing the intersection may take some time.  So is it right for QMP=
=E2=80=99s
>>>> block_resize to do this, seeing it is a synchronous operation?
>>>
>>> What else would be right? Returning an error?
>>
>> Going through a deprecation cycle.
>=20
> And keeping the buggy behaviour for two more releases?

This sounds like you don=E2=80=99t care about adding another bug when it me=
ans
fixing this bug.  I do care.  And so all I was saying is that it seemed
problematic to me to fix the problem in this way, because clearly this
would make block_resize block the monitor in some cases and clearly that
would be a problem, if not a bug.

(And that=E2=80=99s precisely what can be said about the current block_resi=
ze
behavior of revealing previous backing file data: It is a problem, but I
wouldn=E2=80=99t call it a full-on bug.  It just seems to me that nobody ha=
s
ever really thought about it.)

Also, I don=E2=80=99t see this as a really pressing issue for block_resize =
at
least, because this isn=E2=80=99t a recent regression or anything.  It was =
just
the behavior we had, I believe everyone knew it, we just never thought
about whether it really is the best kind of behavior.  So, yes, I=E2=80=99m=
 in
absolutely no hurry to fix this for block_resize.  (Commit is a
different story, but then again commit is a job already, so it doesn=E2=80=
=99t
suffer from the blocking issue.)


But of course this wasn=E2=80=99t all that you=E2=80=99re saying, you give =
a very good
point next.

>>> Common cases (raw and qcow2 v3 without external data files) are quick
>>> anyway.
>>
>> Well, but quick enough for a fully blocking operation?> For qcow2, block=
_resize can already block for a relatively long time
> while metadata tables are resized, clusters are discarded etc. I just
> don't really see the difference in quality between that and allocating
> some zero clusters in a corner case like having a short overlay.

Discarding cropped clusters when shrinking is a good point.  I didn=E2=80=
=99t
think of that.  So block_resize already has the very problem I was
afraid you=E2=80=99d introduce, because of course discarding isn=E2=80=99t =
very
different from quick-zeroing.

> Would you feel more comfortable if we set BDRV_REQ_NO_FALLBACK and
> return an error if we can't zero out the area? We would have to
> advertise that flag in bs->supported_zero_flags for qcow2 then (but
> probably we should do that anyway?)

Hm.  I don=E2=80=99t feel that bad about disallowing this edge case (growin=
g a
shrunken overlay) for potentially all non-qcow2v3 formats.  I don=E2=80=99t=
 know
how bad it would be for users other than block_resize, though.

(And I suppose we want a resize job anyway then, and that would work for
those cases?)

>>>> As far as I can tell, jobs actually have the same problem.  I don=E2=
=80=99t
>>>> think mirror or commit have a pause point before truncating, so they
>>>> still block the monitor there, don=E2=80=99t they?
>>>
>>> Do you really need a pause point? They call bdrv_co_truncate() from
>>> inside the job coroutine, so it will yield. I would expect that this
>>> is enough.
>>
>> OK then.
>>
>>> But in fact, all jobs have a pause point before even calling .run(), so
>>> even if that made a difference, it should still be fine.
>>
>> Good.
>>
>> But I believe this is still a problem for block_resize.  I don=E2=80=99t=
 see why
>> this needs to be fixed in 4.2-rc3.  What=E2=80=99s the problem with goin=
g
>> through a proper deprecation cycle other than the fact that we can=E2=80=
=99t
>> start it in 4.2 because we don=E2=80=99t have a resize job yet?
>=20
> That the behaviour is wrong.

I know a couple of wrong behaviors that won=E2=80=99t be fixed in 4.2.

> For commit it's an image corruptor.

That=E2=80=99s a reason why we need it in 4.2.  It=E2=80=99s no reason why =
we need it
for block_resize.

> For resize, I'll admit that it's
> just wrong behaviour that is probably harmless in most cases, but it's
> still wrong behaviour. It would be a corruptor in the same way as commit
> if it allowed resizing intermediate nodes, but I _think_ the old-style
> op blockers still forbid this. We'd have to double-check this if we
> leave things broken for block_resize.
>> Anyway, so are you suggesting adding another parameter to
> bdrv_co_truncate() that enables wrong, but quicker semantics, and that
> would only be used by block_resize?

That would certainly be a possibility, yes.

I like your suggestion of only allowing it with NO_FALLBACK, but I
suppose we=E2=80=99d want the same parameter for that, too, because users o=
ther
than block_resize probably prefer a slow zeroing over an error.

So to me the question then is whether the added complexity is worth it
for an rc3.

Max


--EnegxIDTQ8Y5vXtKHIkKdzSJlUz7KMKuZ--

--M7mzQSUYWLNzmgmdf65PyOoh1RWlowitd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3WrFkACgkQ9AfbAGHV
z0BQmwf+JjHUyMvEsj1TGM1iilEq1c6Bn3uX8p45YhfYxfACvTNzdlis19dJfM8b
5vaynwmoY1uVEY2K4eb9iR/CT8/gVwfckcUujjo8N1QO+Pod4gQRZWMH+NyYDxYQ
nne5/PSDLIgyfQJAJlVawnnvgYuLmWyGCIVKw9gaAZ20PcQk+H0opcKlY8U1qTa6
l4cZr2+Bxvia0C2xgSqow2VVZkyIEqRV6WNpk3giDxzeCvoCDMFPfTLRUlc2850z
3BhjgJG6zFrNUcAC7rnJ2l1FIElexL1Y9CnP8aptn4oFPztF63RW2pcqBD2o7GkO
H8Rypv46Rg5OIfhPw5J3bvq8Pyrdbg==
=NrI4
-----END PGP SIGNATURE-----

--M7mzQSUYWLNzmgmdf65PyOoh1RWlowitd--


