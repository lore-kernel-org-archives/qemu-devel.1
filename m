Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4BCC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 07:37:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66D4920771
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 07:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XmXjuADL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66D4920771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jndUn-0004Gr-NL
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 03:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jndLr-0000P7-Ss
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 03:28:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57536
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jndLq-0005DD-2r
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 03:28:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592897293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ihzvmGKj2FtF1uT24perq1wQOg2x05VnpWS6Mf9i4U4=;
 b=XmXjuADLLAcE5CSdfXDILvW3cdXKJ3wn0BAfs3ON5sTS3rppMDlHzc4vLQQjEyMY2tQ6zP
 dx285lFvlRKJmNYKUlWOKatmpi15ca5QHi0aTlOjMkGjKrpDI7BXKxSl9EQVdkCt5K8HrH
 JT7PEgVaXGLwCaeq3DdwEXLbaf9znic=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-unu7_tz1MEyPgOsI0oV4lA-1; Tue, 23 Jun 2020 03:28:11 -0400
X-MC-Unique: unu7_tz1MEyPgOsI0oV4lA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6AB1A18A8220;
 Tue, 23 Jun 2020 07:28:10 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-138.ams2.redhat.com
 [10.36.113.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E36DD60F80;
 Tue, 23 Jun 2020 07:28:08 +0000 (UTC)
Subject: Re: [PATCH 0/2] qcow2: Force preallocation with data-file-raw
To: Alberto Garcia <berto@igalia.com>, Nir Soffer <nsoffer@redhat.com>
References: <20200619104012.235977-1-mreitz@redhat.com>
 <CAMRbyyu1ZC2qMKSHJXNy7-98-nXHh00dL-v_D0BKcEL6Rmmj+g@mail.gmail.com>
 <72eb5700-faf6-22ee-69be-1e7653cf06c6@redhat.com>
 <w51lfkf807y.fsf@maestria.local.igalia.com>
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
Message-ID: <66581529-dc44-5fd0-54a3-1117b073077a@redhat.com>
Date: Tue, 23 Jun 2020 09:28:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <w51lfkf807y.fsf@maestria.local.igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="seCU8vtQ3X1sUkaVbz7EQs3Fr8YeQaCna"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 01:53:54
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--seCU8vtQ3X1sUkaVbz7EQs3Fr8YeQaCna
Content-Type: multipart/mixed; boundary="iIECAPImeEA1VTCPjlTKLtSXHceUQc3DE"

--iIECAPImeEA1VTCPjlTKLtSXHceUQc3DE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22.06.20 19:44, Alberto Garcia wrote:
> On Mon 22 Jun 2020 11:47:32 AM CEST, Max Reitz wrote:
>>> I don't know the internals of qcow2 data_file, but are we really using
>>> qcow2 metadata when accessing the data file?
>>
>> Yes.
>>
>>> This may have unwanted performance consequences.
>>
>> I don=E2=80=99t think so, because in practice normal lookups of L1/L2 ma=
ppings
>> generally don=E2=80=99t cost that much performance.
>=20
> ...if the L2 cache size is large enough. Otherwise you need one extra
> read operation to retrieve the L2 metadata.
>=20
> Possible performance problems when you have preallocation:
>=20
>    - If a block hasn't been written yet (it's all zeroes) then you still
>      need to read the L2 entry and read the data block. If there is not
>      L2 table then you can simply return zeroes without going to disk at
>      all. This of course assumes that the contents of the unwritten data
>      block are zeroes.
>=20
>    - QEMU still needs to read from disk (and cache in memory) the L2
>      metadata, when it already knows in advance the contents of the L2
>      entry (guest_offset =3D=3D host_offset).

We could well optimize this regardless of preallocation.  With
data-file-raw, qemu doesn=E2=80=99t have to look at the L2 metadata at all.

So the problem isn=E2=80=99t preallocation at all, it=E2=80=99s the fact th=
at we don=E2=80=99t
have such an optimization.  But note that to implement such an
optimization, we really do need preallocation: Because it would mean
that we wouldn=E2=80=99t touch the L1/L2 tables for data-file-raw images du=
ring
runtime, which would effectively make those images empty to today=E2=80=99s=
 qemu
versions.

(OTOH, preallocation would then be pretty much superfluous for all newer
versions of qemu.  To address that, we could then add an incompatible
version of data-file-raw.  But I think we should only think about that
once we get to that point.)

You make a good point that data-file-raw was introduced alongside
data-file.  But, well.  I personally can=E2=80=99t get myself to treating a=
n
autoclear flag like an incompatible one...

Max


--iIECAPImeEA1VTCPjlTKLtSXHceUQc3DE--

--seCU8vtQ3X1sUkaVbz7EQs3Fr8YeQaCna
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl7xrwcACgkQ9AfbAGHV
z0Aokwf/Wya+AwABVfK+TbjFXpvXBW0pN44MZoq99nDHRxX8QRB90XCEzd77+2LZ
HB2TFan9WwtSuJ+3lHy0SbKUVn6sJrTC5wGREHdOCElMsFMVHCZOQ9canLhrv+PK
sLNhB+mICZSFhVzaLZ4nwgkm6qpdXNAfgC0kZjtf/lkjArxdXvlr6T17jBlrFZEH
ULCyHjd1F7fYKQOK+Qs8XxDxzM9BZclwGNQEmPSv42VMaXWTfOw8ZQFooD53hxgn
NRvt85d/YBQSS+GY3Ug9oY93e1me+LI5LdP4jTIt+rQSP+qAQdsgTc9Xye/x2Jyh
PGeXu30hNnY3woG6zhfcTESQrF5qvw==
=Y2E7
-----END PGP SIGNATURE-----

--seCU8vtQ3X1sUkaVbz7EQs3Fr8YeQaCna--


