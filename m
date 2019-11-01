Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BE2CA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 11:21:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D00A20656
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 11:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MTcEaVZ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D00A20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQUzo-0000sX-N1
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 07:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53764)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iQUyv-0000F8-9I
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 07:20:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iQUys-0005Ej-RH
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 07:20:40 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48655
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iQUys-0005CF-DD
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 07:20:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572607237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=e5r/WLxNQRIQwpegBCWGTGF7w21jtcHn6b00Ra3TFXg=;
 b=MTcEaVZ1x1McsrqQwTtUYtmzAY+IfdF+T/XgAeAAOs6k8Aj/1btFjQlfqrS96G48qFzzia
 UuyGZWISSuN5In69y5i8304B9hTDN94B4knh02wY+7f0YB2BXCVBtzfp9gIvxiZEgIQjZ6
 Pf7pwB/UTVPg9w72FfwNIuUd2Cux7XA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-A3WUXSdXOvm3ertHpjj-hA-1; Fri, 01 Nov 2019 07:20:35 -0400
X-MC-Unique: A3WUXSdXOvm3ertHpjj-hA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B38F81800D67;
 Fri,  1 Nov 2019 11:20:33 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-28.ams2.redhat.com
 [10.36.117.28])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 10068166B8;
 Fri,  1 Nov 2019 11:20:28 +0000 (UTC)
Subject: Re: [PATCH for-4.2 0/4] qcow2: Fix data corruption on XFS
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20191101100019.9512-1-mreitz@redhat.com>
 <fbf32283-2ec5-28ae-f4c9-5bd7d4af7b3f@redhat.com>
 <783a805a-3a3a-e8c5-41ac-f6476378975e@virtuozzo.com>
 <908ffc42-8328-969d-641b-4596ec0b6b45@redhat.com>
 <fb5ae941-622f-c82d-9eb8-be3fe66e3fb6@virtuozzo.com>
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
Message-ID: <909d8474-0e8f-b9b9-5647-b604f956900a@redhat.com>
Date: Fri, 1 Nov 2019 12:20:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <fb5ae941-622f-c82d-9eb8-be3fe66e3fb6@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8ZGQs2xraKZ4F9504g6ODIM43MPK7a0hY"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8ZGQs2xraKZ4F9504g6ODIM43MPK7a0hY
Content-Type: multipart/mixed; boundary="HM9pVeEtajDgxAhbEL4Ei9S3gfQAffIee"

--HM9pVeEtajDgxAhbEL4Ei9S3gfQAffIee
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 01.11.19 12:16, Vladimir Sementsov-Ogievskiy wrote:
> 01.11.2019 14:12, Max Reitz wrote:
>> On 01.11.19 11:28, Vladimir Sementsov-Ogievskiy wrote:
>>> 01.11.2019 13:20, Max Reitz wrote:
>>>> On 01.11.19 11:00, Max Reitz wrote:
>>>>> Hi,
>>>>>
>>>>> This series builds on the previous RFC.  The workaround is now applie=
d
>>>>> unconditionally of AIO mode and filesystem because we don=E2=80=99t k=
now those
>>>>> things for remote filesystems.  Furthermore, bdrv_co_get_self_request=
()
>>>>> has been moved to block/io.c.
>>>>>
>>>>> Applying the workaround unconditionally is fine from a performance
>>>>> standpoint, because it should actually be dead code, thanks to patch =
1
>>>>> (the elephant in the room).  As far as I know, there is no other bloc=
k
>>>>> driver but qcow2 in handle_alloc_space() that would submit zero write=
s
>>>>> as part of normal I/O so it can occur concurrently to other write
>>>>> requests.  It still makes sense to take the workaround for file-posix
>>>>> because we can=E2=80=99t really prevent that any other block driver w=
ill submit
>>>>> zero writes as part of normal I/O in the future.
>>>>>
>>>>> Anyway, let=E2=80=99s get to the elephant.
>>>>>
>>>>>   From input by XFS developers
>>>>> (https://bugzilla.redhat.com/show_bug.cgi?id=3D1765547#c7) it seems c=
lear
>>>>> that c8bb23cbdbe causes fundamental performance problems on XFS with
>>>>> aio=3Dnative that cannot be fixed.  In other cases, c8bb23cbdbe impro=
ves
>>>>> performance or we wouldn=E2=80=99t have it.
>>>>>
>>>>> In general, avoiding performance regressions is more important than
>>>>> improving performance, unless the regressions are just a minor corner
>>>>> case or insignificant when compared to the improvement.  The XFS
>>>>> regression is no minor corner case, and it isn=E2=80=99t insignifican=
t.  Laurent
>>>>> Vivier has found performance to decrease by as much as 88 % (on ppc64=
le,
>>>>> fio in a guest with 4k blocks, iodepth=3D8: 1662 kB/s from 13.9 MB/s)=
.
>>>>
>>>> Ah, crap.
>>>>
>>>> I wanted to send this series as early today as possible to get as much
>>>> feedback as possible, so I=E2=80=99ve only started doing benchmarks no=
w.
>>>>
>>>> The obvious
>>>>
>>>> $ qemu-img bench -t none -n -w -S 65536 test.qcow2
>>>>
>>>> on XFS takes like 6 seconds on master, and like 50 to 80 seconds with
>>>> c8bb23cbdbe reverted.  So now on to guest tests...
>>>
>>> Aha, that's very interesting) What about aio-native which should be slo=
wed down?
>>> Could it be tested like this?
>>
>> That is aio=3Dnative (-n).
>>
>> But so far I don=E2=80=99t see any significant difference in guest tests=
 (i.e.,
>> fio --rw=3Dwrite --bs=3D4k --iodepth=3D8 --runtime=3D1m --direct=3D1
>> --ioengine=3Dlibaio --thread --numjobs=3D16 --size=3D2G --time_based), n=
either
>> with 64 kB nor with 2 MB clusters.  (But only on XFS, I=E2=80=99ll have =
to see
>> about ext4 still.)
>=20
> hmm, this possibly mostly tests writes to already allocated clusters. Has=
 fio
> an option to behave like qemu-img bench with -S 65536, i.e. write once in=
to
> each cluster?

Maybe, but is that a realistic depiction of whether this change is worth
it?  That is why I=E2=80=99m doing the guest test, to see whether it actual=
ly
has much impact on the guest.

(The thing is that Laurent and our QE has seen significant real-world
performance regression on pcc64.)

Max


--HM9pVeEtajDgxAhbEL4Ei9S3gfQAffIee--

--8ZGQs2xraKZ4F9504g6ODIM43MPK7a0hY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl28FPsACgkQ9AfbAGHV
z0Cgvwf/RJqepYFVslXy/5MkeIWkny1kjd2dTBT/Sub+R7pJOFMOa+WJx0JX65gB
zkQQYczf0glraHPCFl1VI4tHTxCnP1hdNbn9AH0fxTO8jRKS52LYTE7SF+HJkhTU
2t20G4gFQOCEy/6xWy8ZMkkWeWWNIkc1O4G5UNAJ39dv6YlqqjhYC1Er7W92ZaNw
apF2TzOJhugyNKBGDEdmk2XJwfEOEBkceFw9XgizN4lwYrVY6oEsU+XU+Xwz7Zte
JMnmCWpvq7wwBLicS3CZxBFjZcPogV8kfoQ0BozmaxBqC/gTsXD6goGDaP5bpa1h
fPt84qayEi3LtluDKzC90z0cTnTMlg==
=rBe4
-----END PGP SIGNATURE-----

--8ZGQs2xraKZ4F9504g6ODIM43MPK7a0hY--


