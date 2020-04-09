Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AA6C2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 14:11:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFAB820692
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 14:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VemCKMpb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFAB820692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMXtY-0002Ws-Ve
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 10:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38100)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jMXsx-00025k-AQ
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 10:10:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jMXsw-0005jU-2K
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 10:10:27 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26446
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jMXsv-0005j6-Tt
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 10:10:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586441425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0zfsTLQeUBwXb8eRt1rR6Q0IohDW/o4KQK/u+tMfgg4=;
 b=VemCKMpbDQVSZNba8/LRF2o92c+EFnlGI821qLDBuYf1OxI08rcqOAvgtBBw8ln4BblWu6
 rT8d9PNEby9bB2PuRpeCjoFfecpF44EU530ZHorPBvbhBpAM7LpAEGHX4ZO0hnZqBGdqCL
 zcBbfKJer+0O409/tZBMTMEUqGPGIHs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-s0jhmro-OKmlppdeKhcyHw-1; Thu, 09 Apr 2020 10:10:22 -0400
X-MC-Unique: s0jhmro-OKmlppdeKhcyHw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B21918017F3;
 Thu,  9 Apr 2020 14:10:21 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-98.ams2.redhat.com
 [10.36.114.98])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 27E9D52735;
 Thu,  9 Apr 2020 14:10:19 +0000 (UTC)
Subject: Re: qcow2: Zero-initialization of external data files
To: Eric Blake <eblake@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>
References: <db0b4b5c-d564-f003-bbbc-9afdcac07cc4@redhat.com>
 <50080252-ff22-78ed-0002-1742c694471b@redhat.com>
 <8b4bc264-7bce-c9c1-1905-a22b4c61cae4@redhat.com>
 <ad2542f0-1faf-88eb-9dac-36d87a2a795f@redhat.com>
 <ff515dc1-0ac1-08c6-b636-cd50c09cab7d@redhat.com>
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
Message-ID: <e91aa2c9-5709-ee1c-d8e9-45f12493613e@redhat.com>
Date: Thu, 9 Apr 2020 16:10:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <ff515dc1-0ac1-08c6-b636-cd50c09cab7d@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="l9Jo7coXkDGO0DsdIEPVzCMmDwGbfS6Mr"
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--l9Jo7coXkDGO0DsdIEPVzCMmDwGbfS6Mr
Content-Type: multipart/mixed; boundary="idvGd8btCdtyC0qSJ9VM7G3c1WpqxGmAX"

--idvGd8btCdtyC0qSJ9VM7G3c1WpqxGmAX
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09.04.20 15:47, Eric Blake wrote:
> On 4/9/20 8:42 AM, Eric Blake wrote:
>=20
>>>> I'd argue that requiring the user to pre-zero the raw data file is
>>>> undesirable; and that we should instead fix our code to not report the
>>>> image as reading all zeroes when creating with data_file_raw=3Don.
>>>
>>> OK.=C2=A0 I think that could be achieved by just enforcing @preallocati=
on to
>>> be at least =E2=80=9Cmetadata=E2=80=9D whenever @data-file-raw is set.=
=C2=A0 Would that make
>>> sense?
>>
>> Is a preallocation of metadata sufficient to report things correctly?
>> If so, it seems like a reasonable compromise to me.=C2=A0 I was more
>> envisioning a fix elsewhere: if we are reporting block status of what
>> looks like an unallocated cluster, but data-file-raw is set, we change
>> our answer to instead report it as allocated with unknown contents.=C2=
=A0
>> But with preallocation, you either force the qcow2 file to list no
>> cluster as unallocated (which matches the fact that the raw image
>> really is fully allocated) while not touching the raw image, or you
>> can go one step further and request full preallocation to wipe the raw
>> image to 0 in the process.
>=20
> What happens when an operation attempts to unmap things?=C2=A0 Do we reje=
ct
> all unmap operations when data-file-raw is set (thus leaving a cluster
> marked as allocated at all times, if we can first guarantee that
> preallocation set things up that way)?
No, unmap operations currently work.  qcow2_free_any_clusters() passes
them through to the external data file.

The problem is that the unmap also zeroes the L2 entry, so if you then
write data to the raw file, it won=E2=80=99t be visible from the qcow2 side=
 of
things.  However, I=E2=80=99m not sure whether we support modifications of =
a raw
file when it is already =E2=80=9Cin use=E2=80=9D by a qcow2 image, so maybe=
 that=E2=80=99s fine.

Max


--idvGd8btCdtyC0qSJ9VM7G3c1WpqxGmAX--

--l9Jo7coXkDGO0DsdIEPVzCMmDwGbfS6Mr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6PLMoACgkQ9AfbAGHV
z0DxnwgAvsjj+h5eMHzm7IExdEmE4Dx4IF6KItyCyhlJ2oR4wS80v9qDj4lhnJgI
KmNbfb7gckKvCNLKTR1Aqlx+/PkQkFIfrzzNriiG+6qFAZOm9E7N2WfJ4OGQa/qy
wKRIOOiY4EMzz1lZKfejGmTkpTq+EGpeLuS5aJPlcNNDvVPVFYUl2NjVuPkihNaH
BQCjFhUF400MBXT6NXJiPOSxojO8Y8yTBiwivD1E0HkyGxNqVuV5B1Hcp3Us3wDH
ytbTTHW4v3P5fT4kWMCiKWzC4rkqD8XmA+9pgRPy2j2SwwttIDlYpJzhU57iANqh
0MIVq+k4cKyWV1mhmtENxOl4hgaOGg==
=JO56
-----END PGP SIGNATURE-----

--l9Jo7coXkDGO0DsdIEPVzCMmDwGbfS6Mr--


