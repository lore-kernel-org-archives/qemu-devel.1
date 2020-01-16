Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBD4C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 15:58:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 795DB2077C
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 15:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="azNdze8N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 795DB2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is7X1-0000Xe-AG
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 10:58:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37134)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1is7Vg-0007eX-Tq
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 10:56:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1is7Vc-0002YS-BG
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 10:56:40 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49483
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1is7Vc-0002Y0-7W
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 10:56:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579190195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TH24nhe22Y16HBrPv1GdmiiSsaafoYR1B7XBJSzF/9U=;
 b=azNdze8NnZiMIlcW4yghMJ8rGaBqIoQztP6idx21PmNIfgia6FcMbFf9bVBfzvdeGgs9V+
 SjZPgyEqyuW0NbGhU5eXRUYu/XTqQMMfqV5o3efh0gp4usujqcsl3ucHEygdaR/edkX0uw
 Z1ulgrfIbb+LvCFbdlSBBSpsR8SqmxI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-4KoEK70nMhWQsWtJv1krXQ-1; Thu, 16 Jan 2020 10:56:32 -0500
X-MC-Unique: 4KoEK70nMhWQsWtJv1krXQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 184FE477;
 Thu, 16 Jan 2020 15:56:31 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-185.ams2.redhat.com
 [10.36.117.185])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BE2D184668;
 Thu, 16 Jan 2020 15:56:17 +0000 (UTC)
Subject: Re: Bug? qemu-img convert to preallocated image makes it sparse
To: Maxim Levitsky <mlevitsk@redhat.com>, Kevin Wolf <kwolf@redhat.com>
References: <20200116141352.GA32053@redhat.com>
 <7586b832-ecd2-e766-6781-3a25f382c9ed@redhat.com>
 <20200116145048.GG9470@linux.fritz.box>
 <5fcb531c-24ef-6e91-294d-517631c5a2cb@redhat.com>
 <03ebf1f7ad780fca65dfc7486e860beb33c71d20.camel@redhat.com>
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
Message-ID: <4d6ca271-d666-4ba2-4115-5d60f94e4c32@redhat.com>
Date: Thu, 16 Jan 2020 16:56:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <03ebf1f7ad780fca65dfc7486e860beb33c71d20.camel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RxKNL5H1hBLliYRkHbD4wnLb6ltJH5MkD"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: sgarzare@redhat.com, "Richard W.M. Jones" <rjones@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RxKNL5H1hBLliYRkHbD4wnLb6ltJH5MkD
Content-Type: multipart/mixed; boundary="NMR8t0eA30ni3Vsd26c0n8Bs3mvGEJ9gh"

--NMR8t0eA30ni3Vsd26c0n8Bs3mvGEJ9gh
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 16.01.20 16:38, Maxim Levitsky wrote:
> On Thu, 2020-01-16 at 15:55 +0100, Max Reitz wrote:
>> On 16.01.20 15:50, Kevin Wolf wrote:
>>> Am 16.01.2020 um 15:37 hat Max Reitz geschrieben:
>>>> On 16.01.20 15:13, Richard W.M. Jones wrote:
>>>>> I'm not necessarily saying this is a bug, but a change in behaviour i=
n
>>>>> qemu has caused virt-v2v to fail.  The reproducer is quite simple.
>>>>>
>>>>> Create sparse and preallocated qcow2 files of the same size:
>>>>>
>>>>>   $ qemu-img create -f qcow2 sparse.qcow2 50M
>>>>>   Formatting 'sparse.qcow2', fmt=3Dqcow2 size=3D52428800 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>>>>>
>>>>>   $ qemu-img create -f qcow2 prealloc.qcow2 50M -o preallocation=3Dfa=
lloc,compat=3D1.1
>>>>>   Formatting 'prealloc.qcow2', fmt=3Dqcow2 size=3D52428800 compat=3D1=
.1 cluster_size=3D65536 preallocation=3Dfalloc lazy_refcounts=3Doff refcoun=
t_bits=3D16
>>>>>
>>>>>   $ du -m sparse.qcow2 prealloc.qcow2=20
>>>>>   1 sparse.qcow2
>>>>>   51=09prealloc.qcow2
>>>>>
>>>>> Now copy the sparse file into the preallocated file using the -n
>>>>> option so qemu-img doesn't create the target:
>>>>>
>>>>>   $ qemu-img convert -p -n -f qcow2 -O qcow2 sparse.qcow2 prealloc.qc=
ow2
>>>>>       (100.00/100%)
>>>>>
>>>>> In new qemu that makes the target file sparse:
>>>>>
>>>>>   $ du -m sparse.qcow2 prealloc.qcow2=20
>>>>>   1 sparse.qcow2
>>>>>   1 prealloc.qcow2         <-- should still be 51
>>>>>
>>>>> In old qemu the target file remained preallocated, which is what
>>>>> I and virt-v2v are expecting.
>>>>>
>>>>> I bisected this to the following commit:
>>>>>
>>>>> 4d7c487eac1652dfe4498fe84f32900ad461d61b is the first bad commit
>>>>> commit 4d7c487eac1652dfe4498fe84f32900ad461d61b
>>>>> Author: Max Reitz <mreitz@redhat.com>
>>>>> Date:   Wed Jul 24 19:12:29 2019 +0200
>>>>>
>>>>>     qemu-img: Fix bdrv_has_zero_init() use in convert
>>>>>    =20
>>>>>     bdrv_has_zero_init() only has meaning for newly created images or=
 image
>>>>>     areas.  If qemu-img convert did not create the image itself, it c=
annot
>>>>>     rely on bdrv_has_zero_init()'s result to carry any meaning.
>>>>>    =20
>>>>>     Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>>>     Message-id: 20190724171239.8764-2-mreitz@redhat.com
>>>>>     Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
>>>>>     Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>>>>>     Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>>>
>>>>>  qemu-img.c | 11 ++++++++---
>>>>>  1 file changed, 8 insertions(+), 3 deletions(-)
>>>>>
>>>>> Reverting this commit on the current master branch restores the
>>>>> expected behaviour.
>>>>
>>>> The commit changed the behavior because now qemu-img realizes that it
>>>> cannot skip writing to areas that are supposed to be zero when it
>>>> converts to an existing image (because we have no idea what data that
>>>> existing image contains).  So that=E2=80=99s a bug fix, and I don=E2=
=80=99t think we can
>>>> undo it without being wrong.
>>>>
>>>> The problem is that qemu-img will try to be quickthat about making the=
se
>>>> areas zero, and so it does zero writes (actually, it even zeroes the
>>>> whole image) and in the process it will of course discard all prealloc=
ation.
>>>>
>>>> Now, about fixing the problem I=E2=80=99m not so sure.
>>>
>>> Wouldn't just passing -S 0 solve the problem? It should tell qemu-img
>>> convert that you don't want it to sparsify anything.
>>
>> But it would also convert the falloc preallocation to a full one.
>>
>> (I had a section to this effect in my first draft, but then I
>> accidentally deleted it and forgot it in my second version...)
>>
>> Max
>>
>=20
> How about doing write zeros without discard only in this particular case =
(convert to existing image)
> Basically omitting the BDRV_REQ_MAY_UNMAP flag to blk_co_pwrite_zeroes.
> It will be slow, but maybe for this particular case, it is acceptable?

I don=E2=80=99t think so, because AFAIA one relatively common case is to co=
nvert
to an existing block device, and we want to zero that quickly.

Or if the target image actually stores some data, I can imagine that
people actually want a discarding unmap so the image doesn=E2=80=99t use mo=
re
space than necessary.

(Also, if we resolve this without any new kind of flag, I=E2=80=99m not sur=
e
whether we can guarantee to keep the desired behavior in the future,
because maybe something else will force us to forego existing
preallocation unless we know that the user really wants to keep it.  I
think there are just different use cases that convert -n is used for and
it makes sense to add a flag to distinguish between them.)

Max


--NMR8t0eA30ni3Vsd26c0n8Bs3mvGEJ9gh--

--RxKNL5H1hBLliYRkHbD4wnLb6ltJH5MkD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl4gh58ACgkQ9AfbAGHV
z0AIuQf7B/kLNWBgwIFxpR+O0HfRpRAocEAfDDvgL9Hj1byAHBnxa2Fru5omnRpK
eXu8Pq/8dqyYoLu7ugs45n3uIBXlqtnh9LVvGb0215vCiNKwe/oQ2S8PzUekhqH+
Ol8F0T8WCZ4qYbEfTa7xKmGFBXyTn6LbsMXtRQG8OXTATrrtT86VeGL2xQsK8+0/
kRqtKqkoN+QRHq0CqlnTfRJKJRRn9rSJNBvSbBQCygvTEGBZJmP4vkoSDMxapwUX
INktp3oDYJELKMbN2s2AHf+2MxIiVIwJ2VeMfCSe9WJJgFGr4WJXFEwZYfGjWutQ
H8BHu3w+AE2ZYu9oHm78p1Sa3O6g9g==
=yDe+
-----END PGP SIGNATURE-----

--RxKNL5H1hBLliYRkHbD4wnLb6ltJH5MkD--


