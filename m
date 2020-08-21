Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188C6C433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 13:04:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8AA3207BB
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 13:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UHSUtdrj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8AA3207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k96ij-0005bN-Vq
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 09:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k96i2-0004lF-2U
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 09:03:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31750
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k96hz-00052v-MO
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 09:03:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598015029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=f7t2If7ejsTBZwvA7OXOzlZAU2q+RUJMODjqGHg/8yk=;
 b=UHSUtdrjwzILDOZ2qjtZWELZdXFH2Aa25HZlwSTkgOIVteqWF16HMke1JBLj2akDSVNFdh
 c07xPAG0ZDqbYnhfLlo1S36o1GwjVBcCYhuhql4r98qHVcjQyHJMLPEOMWL6a/LNCtXFRT
 1wpmbu5cZ2+aDitc9QNS4WI8GbEyAKc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-BB2FQQj9NWmpM-b422rM3w-1; Fri, 21 Aug 2020 09:03:43 -0400
X-MC-Unique: BB2FQQj9NWmpM-b422rM3w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA0E98030A4;
 Fri, 21 Aug 2020 13:03:41 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-198.ams2.redhat.com
 [10.36.113.198])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 74DBD5C1D0;
 Fri, 21 Aug 2020 13:03:39 +0000 (UTC)
Subject: Re: [RFC qemu 0/6] mirror: implement incremental and bitmap modes
To: =?UTF-8?Q?Fabian_Gr=c3=bcnbichler?= <f.gruenbichler@proxmox.com>,
 qemu-devel@nongnu.org
References: <20200218100740.2228521-1-f.gruenbichler@proxmox.com>
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
Message-ID: <d35a76de-78d5-af56-0b34-f7bd2bbd3733@redhat.com>
Date: Fri, 21 Aug 2020 15:03:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200218100740.2228521-1-f.gruenbichler@proxmox.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="uz4C9ppuc0tLwISpwnO22DW8n6fdzCPU9"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 04:55:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uz4C9ppuc0tLwISpwnO22DW8n6fdzCPU9
Content-Type: multipart/mixed; boundary="fhKKR02DTNLMsJsYXiFn1umkkpx3GDToz"

--fhKKR02DTNLMsJsYXiFn1umkkpx3GDToz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 18.02.20 11:07, Fabian Gr=C3=BCnbichler wrote:

[Sorry :/]

> picking up on John's in-progress patch series from last summer, this is
> a stab at rebasing and adding test cases for the low-hanging fruits:
>=20
> - bitmap mirror mode with always/on-success/never bitmap sync mode
> - incremental mirror mode as sugar for bitmap + on-success
>=20
> Fabian Gr=C3=BCnbichler (4):
>   mirror: add check for bitmap-mode without bitmap
>   mirror: switch to bdrv_dirty_bitmap_merge_internal
>   iotests: add test for bitmap mirror
>   mirror: move some checks to QMP
>=20
> John Snow (2):
>   drive-mirror: add support for sync=3Dbitmap mode=3Dnever
>   drive-mirror: add support for conditional and always bitmap sync modes

Looks reasonable to me.  I would indeed merge patches 2 through 4 into a
single one, and perhaps switch patches 5 and 6.

Also, we still need an S-o-b from John on patch 2.

I have one question: When the mirror job completes successfully (or is
cancelled =E2=80=9Csuccessfully=E2=80=9D), the bitmap is always fully clear=
ed when the
job completes, right?  (Unless in =E2=80=9Cnever=E2=80=9D mode.)

Not that I think we should change the current implementation of =E2=80=9Ccl=
ear
sync_bitmap; merge dirty_bitmap into sync_bitmap;=E2=80=9D.  Just a questio=
n for
understanding.


Soo...  What=E2=80=99s the plan?

Max


--fhKKR02DTNLMsJsYXiFn1umkkpx3GDToz--

--uz4C9ppuc0tLwISpwnO22DW8n6fdzCPU9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8/xioACgkQ9AfbAGHV
z0A0XAgArnPlYGRNkpZY79THIpzFIMxowVT7V4pME1M71BehThJu4/zgexs93LHd
KHDt/CiteIdO422px+xUPjLVFjjL2tQx3bUe3Uyct4/k+iIbiI+dhKq1nOhgOHp0
VmTXDpRKN8gKTr7RUMkEjdV+RR8ZfasoeGrC/QSIY8kRZXuUIVlndJ7gnNv0ZseZ
ava5dbotJWsI1kt73z29ZGNVVSJQZw1D3ndxGgRNQmf/leKQMxfvqbCKcI6b6hV2
aB8bTHcX1BRB5P/4fIOBIs/H3M4f9G1DkHjhConXC+u26sOp5Cb02oceRuZ29ImL
tr72Cj0KSXqrY/muLWbzJa3Q8C932A==
=WYyE
-----END PGP SIGNATURE-----

--uz4C9ppuc0tLwISpwnO22DW8n6fdzCPU9--


