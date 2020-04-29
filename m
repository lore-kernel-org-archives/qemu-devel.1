Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF89C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 09:33:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A868620731
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 09:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T49GSRdL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A868620731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTj5V-0003Gw-SN
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 05:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34106)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTj4U-00029y-W0
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:32:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTj4U-00087D-Ei
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:32:02 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51517
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jTj4U-000876-1H
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:32:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588152720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oR/g+5x+FfVKrr/4XC4/YLlRobK/JuNtbhpN0Zpyg+E=;
 b=T49GSRdLpkUIg16RFTyz0RpYLBAGkqn9uL9rdVBvLH/ks091hrUM1li0fgTvlRmnwVxY59
 GUS7Pnrrvi/S+fLiho/U5M82LER8/DPWLOoAEfkaNC0ngi54jAZY5U/J3P+35REkPoqh+P
 juZy4UfYRu1cc6LwScuAGFS1Kxu7ulA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-moRgEYpBNeWk8Diue25nGg-1; Wed, 29 Apr 2020 05:31:58 -0400
X-MC-Unique: moRgEYpBNeWk8Diue25nGg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 700CD100A692
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 09:31:57 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-19.ams2.redhat.com
 [10.36.113.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 156F25D9C9;
 Wed, 29 Apr 2020 09:31:50 +0000 (UTC)
Subject: Re: [Virtio-fs] [PATCH] virtiofsd: Show submounts
To: Miklos Szeredi <mszeredi@redhat.com>
References: <20200424133516.73077-1-mreitz@redhat.com>
 <20200427175902.GM2923@work-vm>
 <20200428145143.GB107541@stefanha-x1.localdomain>
 <CAOssrKcoXBAxE=Ld5ZY79G=Dy=qBh3HdSxxC+nMGJOX52rUxxg@mail.gmail.com>
 <20200428191523.GU2794@work-vm>
 <0da9422f-6399-6ef0-1042-4b2b90d49ed8@redhat.com>
 <CAOssrKfA_7cAio6i4Zy5hM-6VwBXphja6ps4s_NKrLsoF1yC+Q@mail.gmail.com>
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
Message-ID: <f2d4ced9-fc6d-289d-a979-4745039fcc8d@redhat.com>
Date: Wed, 29 Apr 2020 11:31:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAOssrKfA_7cAio6i4Zy5hM-6VwBXphja6ps4s_NKrLsoF1yC+Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="EwsuK18nZn2W7T7QSjzF9UHriesKfQycx"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 00:53:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: virtio-fs-list <virtio-fs@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EwsuK18nZn2W7T7QSjzF9UHriesKfQycx
Content-Type: multipart/mixed; boundary="WDB7GMBz84t3sPeKFMKQSSDlFSWqHgEWq"

--WDB7GMBz84t3sPeKFMKQSSDlFSWqHgEWq
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 29.04.20 10:52, Miklos Szeredi wrote:
> On Wed, Apr 29, 2020 at 10:31 AM Max Reitz <mreitz@redhat.com> wrote:
>>
>> On 28.04.20 21:15, Dr. David Alan Gilbert wrote:
>=20
>>> So are you saying we need a:
>>>        if (mount(NULL, "/", NULL, MS_REC | MS_SHARED, NULL) < 0) {
>>>
>>>   and can this go straight after (1) ?
>>
>> Isn=E2=80=99t MS_SHARED and MS_SLAVE mutually exclusive, that is, both a=
re just
>> different propagation types?  So shouldn=E2=80=99t putting this after (1=
) be
>> effectively the same as replacing (1)?
>=20
> No, think of it more like a set of groups (mounts in a group have the
> same "shared:$ID" tag in /proc/self/mountinfo) and these groups being
> arranged into a tree, where child groups get propagation from the
> parent group (mounts have a "master:$PARENT_ID" tag), but not the
> other way round.
>=20
> So if a mount is part of a shared group and this group is also the
> child of another shared group, then it will have both a "shared:$ID"
> and a "master:$PARENT_ID" tag in /proc/self/mountinfo.

Ah, OK.

Thanks a lot for the explanation!

> For the gory details see Documentation/filesystems/sharedsubtree.txt

Not sure whether I want to *cough* O:)

Max


--WDB7GMBz84t3sPeKFMKQSSDlFSWqHgEWq--

--EwsuK18nZn2W7T7QSjzF9UHriesKfQycx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6pSYUACgkQ9AfbAGHV
z0BcVAf/Zq6s9xku0URumDj4hVZWaSNCyJaeFYkIsG3rnD1YJgm865JXXNKGVeED
tk4ls7lGyIF12/cisyRUm5EYNv9gIjk7sFrW6PJzh7I5OaLrQoE8OcG/Px0Bcg6B
TGuEEXVj3BJiDY0Pc9l4ljeI/HGG/PxftRMRosHzvV2TWwh/M1p487NMYyWMsW61
P+h4E19uXJjLLsVdrqYpN6fvOuvsRgwGY/n39dRNKqeMsDdTNDse9v1AcYHWaI34
XPYrD4M/7Rxh9IUMcZe/bpkAgQQ4cojKvegtCf7f2xI8nn+9UgqFZlRM76RW3QcI
AaTEUahZHB72K3GhOaQgN2ZrP6hCvA==
=i23r
-----END PGP SIGNATURE-----

--EwsuK18nZn2W7T7QSjzF9UHriesKfQycx--


