Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D18FC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 19:12:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07204227BF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 19:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sxrfw7la"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07204227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii1Di-00051D-8K
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 14:12:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48732)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ii17a-0006nq-2i
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 14:06:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ii17S-0004k2-2b
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 14:06:01 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50025
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ii17R-0004fP-Py
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 14:05:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576782353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GSdRgzxOYzQsEzux0wWjkBdgIgEaAsZL9Pc7cDeyB44=;
 b=Sxrfw7laF1oFrhHtAcsel57WvbjHChVLl6luonreU6XpyzAK7ppxP1HFzV3/rC1HvUSL9d
 89xlJVvhxP7XnHAJQOleYWJ4B34hs5sk29S+ZLT7h7kT9lgcdJmejT45nkqQz7hqPyj+yY
 4xNJ0/Q43ihCZqr3l+Jfo/bCaT5slu4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-rZ--GmqPNuWKZhpGZJFQMQ-1; Thu, 19 Dec 2019 14:05:49 -0500
X-MC-Unique: rZ--GmqPNuWKZhpGZJFQMQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 613D1800D41;
 Thu, 19 Dec 2019 19:05:48 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-205-138.brq.redhat.com
 [10.40.205.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D3B7620BE;
 Thu, 19 Dec 2019 19:05:46 +0000 (UTC)
Subject: Re: [PATCH 00/18] block: Allow exporting BDSs via FUSE
To: qemu-block@nongnu.org
References: <20191219143818.1646168-1-mreitz@redhat.com>
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
Message-ID: <0e2b9059-8995-7802-e72d-47183c69a1e5@redhat.com>
Date: Thu, 19 Dec 2019 20:05:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191219143818.1646168-1-mreitz@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2KC2lJc1XGIY3KKOJcaQWaAxtjKq6URNU"
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2KC2lJc1XGIY3KKOJcaQWaAxtjKq6URNU
Content-Type: multipart/mixed; boundary="aiGg5uuXMDZpvGE6RHEYHXEwWlafbaNEv"

--aiGg5uuXMDZpvGE6RHEYHXEwWlafbaNEv
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 19.12.19 15:38, Max Reitz wrote:

[...]

> Final rather important notice: I didn=E2=80=99t really run the iotests wi=
th this
> yet.  I wanted to, but they appear rather broken on current master,
> actually.  I=E2=80=99m not yet sure whether that=E2=80=99s because someth=
ing in my setup
> broke in the last two weeks, or because there=E2=80=99s quite something b=
roken
> in master (it does look like there are a couple things broken in master
> currently).

Bit of both, it turns out.  The problems in this series are:

Patch 10: We can=E2=80=99t sprinkle -n into convert statements as generousl=
y as
I=E2=80=99d liked, because for some reason this gives me disk space issues =
with
qcow1 and vmdk.  We can still do it in 028 and 089, but I should
probably drop the rest.  (Of course, this means that this rest also has
to be dropped from patch 17.)

Patch 15: We must not guess TEST_IMG_FILE from TEST_IMG if IMGOPTSSYNTAX
is true.  Otherwise, this breaks basically all luks tests.

Patch 18: This does not work with vpc.  (Because vpc by default aligns
the image size for its CHS magic, and so the output changes when
inquiring the image size.)

These together with the fixes I=E2=80=99ve sent to the list are then enough=
 to
make the iotests pass for me again.

Max


--aiGg5uuXMDZpvGE6RHEYHXEwWlafbaNEv--

--2KC2lJc1XGIY3KKOJcaQWaAxtjKq6URNU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl37yggACgkQ9AfbAGHV
z0AHBQf/U4QBXybL5Qtl9QEcJmLp0ri8/uXZsiF6yYFTtlOlKjlQjlnHnUkxEbUf
YewJDyWhxtMhSRKeM15F/R8k3xkY8PZHOLF/tujRN3xl+Oc5H7xr0HiNxNEzQCFA
pOw9oQV6RllhYUUcaMQvzeNCC0LAUcx0drLXopZ35N1AGyuZ3gzEK/vzX4UWGNtL
ileiYR2YEOEfMS/ecC869DwGonqGapKiKsMZM6XvpHG9VovyhVHBT9QxZITw9x6V
kYnX3htVjYH6SC8NeKWHwmXu57Luz6ZGI7a/qGK1/G2158P1y5uETlAZL1zguhPT
x4T/ldUuSgesfYLwSaG0PhuYn1P/5Q==
=6aVf
-----END PGP SIGNATURE-----

--2KC2lJc1XGIY3KKOJcaQWaAxtjKq6URNU--


