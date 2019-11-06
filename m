Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BED4C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 09:38:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3E1F2087E
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 09:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P15ztPu4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3E1F2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSHlK-0003tO-2Y
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 04:38:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59452)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iSHkd-0003Nd-6Q
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 04:37:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iSHkb-0004Yb-KO
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 04:37:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60524
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iSHkb-0004YB-Fm
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 04:37:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573033036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=EZPYNjlIUZp2oTI33HoJyQ272UCMgv1fGzUFnrJLKXE=;
 b=P15ztPu4hRyzQrjwwBpGjDYw5X17zijARmmN5BSZIWGgm0Fr5SJXfP0eeKcKhAYnA6Ln5F
 1apWSqv1Mt9M+skD/ulYC3sPvbvSSZgY/nWBXZRT8ZJYo5Eo3zXoYtbz/uZKG6btZgeGPE
 Zh0KEkiCTLcKPVPmu+Peq9PAEyQF71o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-XJ9f5DIvMeO73BpG-nO5tA-1; Wed, 06 Nov 2019 04:37:11 -0500
X-MC-Unique: XJ9f5DIvMeO73BpG-nO5tA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C65111800D53;
 Wed,  6 Nov 2019 09:37:09 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-212.ams2.redhat.com
 [10.36.117.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F70A5D70E;
 Wed,  6 Nov 2019 09:37:07 +0000 (UTC)
Subject: Re: backup_calculate_cluster_size does not consider source
To: Stefan Hajnoczi <stefanha@gmail.com>, Dietmar Maurer <dietmar@proxmox.com>
References: <1767781109.66.1572948164492@webmail.proxmox.com>
 <20191106083222.GA189998@stefanha-x1.localdomain>
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
Message-ID: <ac30110f-6abe-a144-2aa5-b1cc140d7e8c@redhat.com>
Date: Wed, 6 Nov 2019 10:37:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191106083222.GA189998@stefanha-x1.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="I6inXxJXgtK0TokG9xSmSoK3MhdVec3js"
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--I6inXxJXgtK0TokG9xSmSoK3MhdVec3js
Content-Type: multipart/mixed; boundary="EfQH4rUcLEYwhJn50r2sWOG7FvfSM5jAf"

--EfQH4rUcLEYwhJn50r2sWOG7FvfSM5jAf
Content-Type: text/plain; charset=WINDOWS-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06.11.19 09:32, Stefan Hajnoczi wrote:
> On Tue, Nov 05, 2019 at 11:02:44AM +0100, Dietmar Maurer wrote:
>> Example: Backup from ceph disk (rbd_cache=3Dfalse) to local disk:
>>
>> backup_calculate_cluster_size returns 64K (correct for my local .raw ima=
ge)
>>
>> Then the backup job starts to read 64K blocks from ceph.
>>
>> But ceph always reads 4M block, so this is incredibly slow and produces
>> way too much network traffic.
>>
>> Why does backup_calculate_cluster_size does not consider the block size =
from
>> the source disk?=20
>>
>> cluster_size =3D MAX(block_size_source, block_size_target)

So Ceph always transmits 4 MB over the network, no matter what is
actually needed?  That sounds, well, interesting.

backup_calculate_cluster_size() doesn=92t consider the source size because
to my knowledge there is no other medium that behaves this way.  So I
suppose the assumption was always that the block size of the source
doesn=92t matter, because a partial read is always possible (without
having to read everything).


What would make sense to me is to increase the buffer size in general.
I don=92t think we need to copy clusters at a time, and
0e2402452f1f2042923a5 has indeed increased the copy size to 1 MB for
backup writes that are triggered by guest writes.  We haven=92t yet
increased the copy size for background writes, though.  We can do that,
of course.  (And probably should.)

The thing is, it just seems unnecessary to me to take the source cluster
size into account in general.  It seems weird that a medium only allows
4 MB reads, because, well, guests aren=92t going to take that into account.

Max


--EfQH4rUcLEYwhJn50r2sWOG7FvfSM5jAf--

--I6inXxJXgtK0TokG9xSmSoK3MhdVec3js
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3ClEAACgkQ9AfbAGHV
z0Aq6wf/TL3hvpQbibJfd1GJXE9Liio5UkDQdazrSuOjP21/iXyYshM1jsIiCIMZ
W8wDTDQzwIlR0VREN+HpPWP9orD/nK58+EHazMGoNaWutIxKkhZlFctqlNA7L6NJ
GTktm93ThRSDA4NnSSoUxat9LQf1Qj7o0mOKoO2/Whj5CY52Q272mE+hPTT1BAFi
YlA3UfxIP6Q/OyhNiJ/6DiTNxEaxJYKATvDSIdz07GmfzP8ukWnRQc+AOyW4MHtp
RP/82RqWeZB885mvnxhmvYIeO1QP+Y2GC1bGHPEDrN/ROwmFZsOW1aZrmfrKXXF/
VCCzJCYBNRcb1Butoh/w/2CpomqFgA==
=iGxC
-----END PGP SIGNATURE-----

--I6inXxJXgtK0TokG9xSmSoK3MhdVec3js--


