Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BBDC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 12:12:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41DA9206A2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 12:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NL4K1QIu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41DA9206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhBCu-0008D1-FL
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 08:12:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jhBCH-0007j8-6Q
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 08:11:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52725
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jhBCF-0004RY-O1
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 08:11:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591359092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wz74qyR+o+A9u9JGyYFeyuo5nk30JUAB7aom/WbBwgs=;
 b=NL4K1QIu2K2Za3hiSEyU00+iC9pXN4IhdvpeX0hYGp51CKCtfp9vvrSJrR8bqiJNf4jSpf
 jZX1bPdifFpn/46PPWDAO5i6zSe/SW+M/ha5ngh1EqJ/dIjEFi+gmHFRkI1CNqFYtC1BFg
 HekZ7oYn/g6hkBbqzIda13IgKJybtM4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22--nkTc_vNMDWivkbqYfAhCQ-1; Fri, 05 Jun 2020 08:11:27 -0400
X-MC-Unique: -nkTc_vNMDWivkbqYfAhCQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B333D100CCCA;
 Fri,  5 Jun 2020 12:11:26 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-76.ams2.redhat.com
 [10.36.114.76])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E9E37CCFB;
 Fri,  5 Jun 2020 12:11:24 +0000 (UTC)
Subject: Re: [PATCH for-5.1] qcow2: Don't open images with a backing file and
 the data-file-raw bit
To: Kevin Wolf <kwolf@redhat.com>
References: <20200415190207.21118-1-berto@igalia.com>
 <b0202150-5a43-18d5-3716-b758ab7e5824@redhat.com>
 <20200605111431.GI5869@linux.fritz.box>
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
Message-ID: <89f29fa3-d5e4-fd9f-5d51-0b2ffce82ade@redhat.com>
Date: Fri, 5 Jun 2020 14:11:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200605111431.GI5869@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="YAmF7bevsdq0LwKqCClIj3K2LEF2mOZ74"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:27:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YAmF7bevsdq0LwKqCClIj3K2LEF2mOZ74
Content-Type: multipart/mixed; boundary="8YpTImgcIeIOP0If6Lq9a4IKrKGo35vJR"

--8YpTImgcIeIOP0If6Lq9a4IKrKGo35vJR
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 05.06.20 13:14, Kevin Wolf wrote:
> Am 03.06.2020 um 15:53 hat Max Reitz geschrieben:
>> On 15.04.20 21:02, Alberto Garcia wrote:
>>> Although we cannot create these images with qemu-img it is still
>>> possible to do it using an external tool. QEMU should refuse to open
>>> them until the data-file-raw bit is cleared with 'qemu-img check'.
>>>
>>> Signed-off-by: Alberto Garcia <berto@igalia.com>
>>> ---
>>>  block/qcow2.c              | 39 ++++++++++++++++++++++++++++++++++++++
>>>  tests/qemu-iotests/244     | 13 +++++++++++++
>>>  tests/qemu-iotests/244.out | 14 ++++++++++++++
>>>  3 files changed, 66 insertions(+)
>>
>> Sorry for the long delay. :/
>>
>> The patch itself looks good, but I=E2=80=99m not sure whether it is exte=
nsive
>> enough.  Let me just jump straight to the problem:
>>
>> $ ./qemu-img create -f qcow2 \
>>     -o data_file=3Dfoo.qcow2.raw,data_file_raw=3Don \
>>     foo.qcow2 64M
>> (Create some file empty foo.qcow2 with external data file that=E2=80=99s=
 raw)
>>
>> $ ./qemu-img create -f qcow2 backing.qcow2 64M
>> $ ./qemu-io -c 'write -P 42 0 64M' backing.qcow2
>> (Create some file filled with 42s)
>>
>> $ ./qemu-img compare foo.qcow2 foo.qcow2.raw
>> Images are identical.
>> (As expected, foo.qcow2 is identical to its raw data file)
>>
>> $ ./qemu-img compare --image-opts \
>>     file.filename=3Dfoo.qcow2,backing.file.filename=3Dbacking.qcow2 \
>>     file.filename=3Dfoo.qcow2.raw
>> Content mismatch at offset 0!
>> (Oops.)
>>
>> So when the user manually gives a backing file without one having been
>> given by the image file, we run into the same problem.  Now I=E2=80=99m =
not
>> quite sure what the problem is here.  We could make this patch more
>> extensive and also forbid this case.
>=20
> I guess what we should really be checking is that bs->backing is NULL
> after the node is fully opened. The challenging part is that the backing
> child isn't managed by the block driver, but by the generic block layer,
> and .brv_open() comes first. So we don't really have a place to check
> this. (And there is also the case that the image is originally opened
> with BDRV_O_NO_BACKING and the later bdrv_open_backing_file().)
>=20
>> But I think there actually shouldn=E2=80=99t be a problem.  The qcow2 dr=
iver
>> shouldn=E2=80=99t fall back to a backing file for raw external data file=
s.  But
>> how exactly should that be implemented?  I think the correct way would
>> be to preallocate all metadata whenever data_file_raw=3Don =E2=80=93 the=
 qcow2
>> spec doesn=E2=80=99t say to ignore the metadata with data_file_raw=3Don,=
 it just
>> says that the data read from the qcow2 file must match that read from
>> the external data file.
>> (I seem to remember I proposed this before, but I don=E2=80=99t know exa=
ctly...)
>=20
> I don't find preallocation convincing, mostly for two reasons.
>=20
> First is, old images or images created by another program could miss the
> preallocation, but we still shouldn't access the backing file.

I=E2=80=99d take this patch anyway (because its motivation is just that oth=
er
programs might produce invalid images), and then not worry about the
case where we get an image produced by such another program (including
older versions of qemu) for which the user overrides the backing file at
runtime.

> The other one is that discard breaks preallocation,

The preallocation is about ensuring that there are no
fall-through-to-backing holes in the image.  Discarding doesn=E2=80=99t cha=
nge that.

> so we would also
> have to make sure to have a special case in every operation that could
> end up discarding clusters (and to add it to every future operation we
> might add).
>=20
> It just sounds very brittle.
>=20
>> (In contrast, I don=E2=80=99t think it would be correct to just treat
>> unallocated clusters as zero whenever data_file_raw=3Don.)
>>
>> What do you think?  Should we force preallocation with data_file_raw=3Do=
n,
>> and then just take this patch, even though it still lets users give
>> backing files to a qcow2 file at runtime without error?  (Except the
>> backing file wouldn=E2=80=99t have an effect, then.)
>=20
> Honestly, maybe passing a backing file at runtime to an image that
> doesn't logically have one is just a case of "then don't do that".

Perhaps.

But seeing I wondered whether I didn=E2=80=99t already propose this at some
point, there is another reason for preallocation:

https://lists.nongnu.org/archive/html/qemu-block/2020-02/msg00644.html
https://lists.nongnu.org/archive/html/qemu-block/2020-04/msg00329.html

All in all, I think data_file_raw should be interpretable as =E2=80=9CYou d=
on=E2=80=99t
have to look at any metadata to know which data to read or write=E2=80=9D.
(Maybe I=E2=80=99m wrong about that.)
Without any preallocation of metadata structure, it looks to me like we
break that promise.

(Yes, we could also force-zero the external data file during creation,
and blame users who put a backing file on images that don=E2=80=99t have on=
e =E2=80=93
both of which are not unreasonable!  But we could also just preallocate
the metadata.)

Max


--8YpTImgcIeIOP0If6Lq9a4IKrKGo35vJR--

--YAmF7bevsdq0LwKqCClIj3K2LEF2mOZ74
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl7aNmkACgkQ9AfbAGHV
z0DcEQf/eLkzfkiPRjYEcisfQJbB2RoGf5QYfpZ1NBc4jJrkBGrGxaNxv9OWdQnF
WlE4fxFMbiBAuprlB6MH4XAn01vHr4ztq0zdaseFhVZi21t5kaCiwUkJZOL8MC7M
hWZiBp8muJY/B1Tu0rVU7fXToW1p3uu9izdg7bRd7uVQrnIHEqxmERs+dDkVSr7Z
HsQoD07oebGsFFUGeUWqw9/5dRXGn9v7Pvg8egj1bUL5oN1dzt/ZgbeKZApxqu3j
WJkMQ9G1uOwOeAuqgcNWA3Cvu9nGwgtjrnFRyTvwOKkKsADH5NJ27tNw020pZNDz
u0dP0A/sYX4Xe7UF5EqhzrfXBTHZnA==
=c4Nf
-----END PGP SIGNATURE-----

--YAmF7bevsdq0LwKqCClIj3K2LEF2mOZ74--


