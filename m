Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDC1C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 07:23:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D63E208B8
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 07:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RGtsQFYe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D63E208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrG2z-0001FK-QJ
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 03:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jrG2O-0000jV-VK
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 03:23:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59679
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jrG2N-0006PO-6g
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 03:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593760986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XIigvZd9Z2uWkjHFrckfetoGI6W1G4nSAOx3MROEtxs=;
 b=RGtsQFYeXIhCTNx2rm/7sogLWdT36AsdUYUTeppK2cguDhTmQz/bbFwbzVj9sW1aVp9Of0
 7VR8ROnK+G/s9phd66379vmaNjuIf0bqm5avltTKa1tz6Xl72W8EhnvWVu6xGCLjPqTMZc
 jGpFXwza20j5KcIJEFVwuJvdJZo6SX0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-it7_BpcMNtefvfUCqI_hSw-1; Fri, 03 Jul 2020 03:23:04 -0400
X-MC-Unique: it7_BpcMNtefvfUCqI_hSw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF6C118A8221;
 Fri,  3 Jul 2020 07:23:02 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-131.ams2.redhat.com
 [10.36.113.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 374D06FEF1;
 Fri,  3 Jul 2020 07:23:01 +0000 (UTC)
Subject: Re: [PATCH v9 30/34] qcow2: Add prealloc field to QCowL2Meta
To: Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>,
 qemu-devel@nongnu.org
References: <cover.1593342067.git.berto@igalia.com>
 <0dd88b3b4d3e90b28267267d7686cf5350d9dea0.1593342067.git.berto@igalia.com>
 <cadd98f7-1fc4-3a54-5999-b988cc79e618@redhat.com>
 <687f5402-2316-e06a-2fd1-37375a4fa119@redhat.com>
 <a053de54-93f7-8f13-be5e-6f5d276a7d3d@redhat.com>
 <w511rlttt5h.fsf@maestria.local.igalia.com>
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
Message-ID: <1c121afb-bf65-5879-f9de-2edcaabb11f4@redhat.com>
Date: Fri, 3 Jul 2020 09:22:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <w511rlttt5h.fsf@maestria.local.igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="EmTAO6k8dAzKIV2fEb4eHv6Tiaug3YmBM"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 02:53:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Derek Su <dereksu@qnap.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EmTAO6k8dAzKIV2fEb4eHv6Tiaug3YmBM
Content-Type: multipart/mixed; boundary="VdarrO38aYCofpw1VDWFt1uu6a54avhGL"

--VdarrO38aYCofpw1VDWFt1uu6a54avhGL
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03.07.20 01:05, Alberto Garcia wrote:
> On Thu 02 Jul 2020 05:09:47 PM CEST, Max Reitz wrote:
>>> Without a backing file, there is no read required - writing to an
>>> unallocated subcluster within a preallocated cluster merely has to
>>> provide zeros to the rest of the write.=C2=A0 And depending on whether =
we
>>> can intelligently guarantee that the underlying protocol already
>>> reads as zeroes when preallocated, we even have an optimization where
>>> even that is not necessary.=C2=A0 We can still lump it in the "COW"
>>> terminology, in that our write is more complex than merely writing in
>>> place, but it isn't a true copy-on-write operation as there is
>>> nothing to be copied.
>>
>> The term =E2=80=9CCOW=E2=80=9D specifically in the qcow2 driver also ref=
ers to having
>> to write zeroes to an area that isn=E2=80=99t written to by the guest as=
 part
>> of the process of having to allocate a (sub)cluster.
>=20
> The question is valid: if the space for the clusters is allocated but
> the subclusters are not marked as such then any partial write request
> will need to fill the rest with zeroes (in practice handle_alloc_space()
> can do that efficiently but that's another question).
>=20
> If there is a backing file then there's no other alternative because we
> do need to copy the data from the backing file.
>=20
> If there is no backing file perhaps we could allocate all subclusters as
> well. I suppose we can detect that scenario at that point in the code (I
> haven't checked) and I don't know what would happen if one later
> attaches a backing file on runtime using the command-line options.
>=20
> But what I would argue is that I don't see the benefit of using extended
> L2 entries on an preallocated image with no backing file: other than
> having twice as much L2 metadata what would be the use? The point of
> subclusters is that they make allocation more efficient, but if the
> image is already fully allocated then they give you nothing.

That=E2=80=99s true.  I didn=E2=80=99t think about it this way.

Then indeed it doesn=E2=80=99t make sense to potentially break cases of lat=
er
adding a backing file:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--VdarrO38aYCofpw1VDWFt1uu6a54avhGL--

--EmTAO6k8dAzKIV2fEb4eHv6Tiaug3YmBM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl7+3NMACgkQ9AfbAGHV
z0C98wf/VoqRpdCDtr0WWPxiAHJS9aYm5Od/PseVlE3LLEQH9yUoYpThElyeuOFW
7O/8kes9445vDEL4WEXW96mDwRcVbe666M1dIdgNEeRTSj2QBCPubM13hdAKrrWl
tts5gK6EM4QhZznWynPRLbpDwHi7e7De6hKRC0U96xnOjmYRjTNBK8R0zOmK/kbK
DRH93Fdh0J3KgqHm94OLe6zVlyJQNbVwcc3pdzXeogiYcRb1qfT3A9/D7Nt2R2u4
HPg/p+x99ZI07dbjmUMhcJXxf4wOH0pPvOJ3tY0Gbe/0txDb0kkI+rF1CV/cPPfO
mhBStSSXhARbYLF1uFz9cn5ERIk3Ww==
=sdsI
-----END PGP SIGNATURE-----

--EmTAO6k8dAzKIV2fEb4eHv6Tiaug3YmBM--


