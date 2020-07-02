Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BF1C433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 15:10:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 675D4206B7
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 15:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b5HOiwZZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 675D4206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr0rT-0000no-OH
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 11:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jr0qc-00005Z-DL
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 11:09:58 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38869
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jr0qZ-0001jq-IH
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 11:09:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593702594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kXUIIWsomfnf+P2AvevBX0lA6yMWXYA8nyEZOxgGVT8=;
 b=b5HOiwZZKaHvw2YT+DNDoOtw3lq7b43dqySjlbU1JUrP5edVgVjN6c+xi66vYdi8+htORy
 DlHVBdypqRkvn97w/P6AyCJfEqhxvV3Rlhiugp2nUoOLcmzBFLlvMqPzaWTeZp3Aozimhc
 zWQ1IOFsB339aSbR8dl0qaWUGVCGJKY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-MI4riuhAMyKu57YmEIW_eg-1; Thu, 02 Jul 2020 11:09:52 -0400
X-MC-Unique: MI4riuhAMyKu57YmEIW_eg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F12818FE874;
 Thu,  2 Jul 2020 15:09:50 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-196.ams2.redhat.com
 [10.36.113.196])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B3F115C1D6;
 Thu,  2 Jul 2020 15:09:48 +0000 (UTC)
Subject: Re: [PATCH v9 30/34] qcow2: Add prealloc field to QCowL2Meta
To: Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org
References: <cover.1593342067.git.berto@igalia.com>
 <0dd88b3b4d3e90b28267267d7686cf5350d9dea0.1593342067.git.berto@igalia.com>
 <cadd98f7-1fc4-3a54-5999-b988cc79e618@redhat.com>
 <687f5402-2316-e06a-2fd1-37375a4fa119@redhat.com>
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
Message-ID: <a053de54-93f7-8f13-be5e-6f5d276a7d3d@redhat.com>
Date: Thu, 2 Jul 2020 17:09:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <687f5402-2316-e06a-2fd1-37375a4fa119@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HdFlgJKSlTkC4UQbumK6M1IlEeZ4vPMSu"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 04:18:28
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
--HdFlgJKSlTkC4UQbumK6M1IlEeZ4vPMSu
Content-Type: multipart/mixed; boundary="gBbKa85tsaw1OY0EIl3UmxdPH4BuWiV5g"

--gBbKa85tsaw1OY0EIl3UmxdPH4BuWiV5g
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 02.07.20 16:58, Eric Blake wrote:
> On 7/2/20 9:50 AM, Max Reitz wrote:
>> On 28.06.20 13:02, Alberto Garcia wrote:
>>> This field allows us to indicate that the L2 metadata update does not
>>> come from a write request with actual data but from a preallocation
>>> request.
>>>
>>> For traditional images this does not make any difference, but for
>>> images with extended L2 entries this means that the clusters are
>>> allocated normally in the L2 table but individual subclusters are
>>> marked as unallocated.
>>>
>>> This will allow preallocating images that have a backing file.
>>>
>>> There is one special case: when we resize an existing image we can
>>> also request that the new clusters are preallocated. If the image
>>> already had a backing file then we have to hide any possible stale
>>> data and zero out the new clusters (see commit 955c7d6687 for more
>>> details).
>>>
>>> In this case the subclusters cannot be left as unallocated so the L2
>>> bitmap must be updated.
>>>
>>> Signed-off-by: Alberto Garcia <berto@igalia.com>
>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>> ---
>>> =C2=A0 block/qcow2.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
8 ++++++++
>>> =C2=A0 block/qcow2-cluster.c | 2 +-
>>> =C2=A0 block/qcow2.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
6 ++++++
>>> =C2=A0 3 files changed, 15 insertions(+), 1 deletion(-)
>>
>> Sounds good, but I=E2=80=99m just not quite sure about the details on
>> falloc/full allocation: With .prealloc =3D true, writing to the
>> preallocated subclusters will require a COW operation.=C2=A0 That=E2=80=
=99s not
>> ideal, and avoiding those COWs may be a reason to do preallocation in
>> the first place.
>=20
> I'm not sure I follow the complaint.=C2=A0 If a cluster is preallocated b=
ut
> the subcluster is marked unallocated, then doing a partial write to that
> subcluster must provide the correct contents for the rest of the
> subcluster (either filling with zero, or reading from a backing file) -
> but this COW can be limited to just the portion of the subcluster, and
> is no different than the COW you have to perform without subclusters
> when doing a write to a preallocated cluster in general.

It was my impression that falloc/full preallocation would create normal
data clusters, not zero clusters, so no COW was necessary when writing
to them.

>> Now, with backing files, it=E2=80=99s entirely correct.=C2=A0 You need a=
 COW
>> operation, because that=E2=80=99s the point of having a backing file.
>>
>> But without a backing file I wonder if it wouldn=E2=80=99t be better to =
set
>> .prealloc =3D false to avoid that COW.
>=20
> Without a backing file, there is no read required - writing to an
> unallocated subcluster within a preallocated cluster merely has to
> provide zeros to the rest of the write.=C2=A0 And depending on whether we=
 can
> intelligently guarantee that the underlying protocol already reads as
> zeroes when preallocated, we even have an optimization where even that
> is not necessary.=C2=A0 We can still lump it in the "COW" terminology, in
> that our write is more complex than merely writing in place, but it
> isn't a true copy-on-write operation as there is nothing to be copied.

The term =E2=80=9CCOW=E2=80=9D specifically in the qcow2 driver also refers=
 to having to
write zeroes to an area that isn=E2=80=99t written to by the guest as part =
of
the process of having to allocate a (sub)cluster.

(Of course there is no COW from a backing file if there is no backing file.=
)

Max


--gBbKa85tsaw1OY0EIl3UmxdPH4BuWiV5g--

--HdFlgJKSlTkC4UQbumK6M1IlEeZ4vPMSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl79+LsACgkQ9AfbAGHV
z0A+zgf+PY5V3idD3Ln0vlcdyUiEarWY7/+B5ee9dHpMxUSW7z7wDJtzS9x5hhHH
036IDxFxtMO617c/wwuZyfVD/gSKSfay+z3IsMRcCNnO1VK4XdJ9XS9yx5/awEw6
asRndmLSMB2WMVBrQxA3Fbdyrpz9Lataz51QADAfz63xOYZ2R/YhHu8f2hsSXKxO
lt+hcgq4RR8r0FQWAhtWuj2dHm2BJw4QVrJbpH27H4alN3BCiAmW5GW1PjO7dihv
DE/gu656Yjd3rKsn0q0/iLndCI+VJHIDB9cWnKE5fwW7fydCiNY4+xmzduARh4b6
RnVbXl95XShKAlVtC6KbuJ24OIzBaQ==
=ATnD
-----END PGP SIGNATURE-----

--HdFlgJKSlTkC4UQbumK6M1IlEeZ4vPMSu--


