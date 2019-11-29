Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E59C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 13:01:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7015D21721
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 13:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JkGwgQXb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7015D21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaftP-0002D4-IS
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 08:01:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47607)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iafiF-0003OJ-J6
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:49:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iafi9-0007u5-3O
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:49:28 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57634
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iafi8-0007fa-VT
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:49:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575031762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=s4p+WzTSZ25A8c0rSIuH0mBx9LJfTwgqIj2AF5c6uRU=;
 b=JkGwgQXbk5CJYnhyGqdbm2LyNty/U9sZNajIcymDdrTLkg2UC1EA9cuIB6OB/45fONkN0n
 TQRkRTzxJyuyXu6A2g7fFeU/uF+7tO5BGrkj2s1bX8LrzTqmgZfBL/c3Tm4abnHc5SPziJ
 YZ2scJaDJj6KpwAEqmC4graOCx36Wvg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-INkWfQXtPlOLEPjxVST_RQ-1; Fri, 29 Nov 2019 07:49:18 -0500
X-MC-Unique: INkWfQXtPlOLEPjxVST_RQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 516A918557C0;
 Fri, 29 Nov 2019 12:49:17 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-206-40.brq.redhat.com
 [10.40.206.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F3DA91001281;
 Fri, 29 Nov 2019 12:49:15 +0000 (UTC)
Subject: Re: [PATCH for-5.0 v2 00/23] block: Fix check_to_replace_node()
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20191111160216.197086-1-mreitz@redhat.com>
 <a134c8a6-17c1-34bc-79f6-76062ff0c668@virtuozzo.com>
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
Message-ID: <2fd76d27-d60e-a9d1-f42a-89b9bd0d5dcb@redhat.com>
Date: Fri, 29 Nov 2019 13:49:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <a134c8a6-17c1-34bc-79f6-76062ff0c668@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="LMEiHe91IaBnmo8BxjhFaaMMpmL0Bw1WO"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LMEiHe91IaBnmo8BxjhFaaMMpmL0Bw1WO
Content-Type: multipart/mixed; boundary="OMmrX9A78RoVAFCtcPab66gxQGHyjdmbI"

--OMmrX9A78RoVAFCtcPab66gxQGHyjdmbI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 29.11.19 13:24, Vladimir Sementsov-Ogievskiy wrote:
> 3 last iotests patches don't apply now.. Do you have a branch pushed some=
where?

Hm, it=E2=80=99s based on =E2=80=9Ciotests: Test failing mirror complete=E2=
=80=9D, maybe because
of that.

Does this work?

https://git.xanclic.moe/XanClic/qemu.git fix-can-replace-v2

Max


--OMmrX9A78RoVAFCtcPab66gxQGHyjdmbI--

--LMEiHe91IaBnmo8BxjhFaaMMpmL0Bw1WO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3hE8oACgkQ9AfbAGHV
z0AyUAf/UszUz6SNcMUjGGSO/Cba0BWSJeK1UVWLjJPQokB/vy76ajgqvS/MBB7o
/Q/r5yMbYmIS/bBGqEtYA0yvJqmKwILrxsQoQ+tnEzrb8WpeuOUxeVnhtk2IN8UF
DSbvtKXKxffhONmNKAaSXZoUFvOmuGu3M/0tQqXLWpJlM109OfMq7G3E2DOCkmi6
7D57K3+QiBdkNAvKUJ5HgQDHRU03TjEfkvLElqzOfCjubE4jIqgLD10Dl+4llFIp
LKzAlKoE4w3sTwY6788Ya7HpyOyWDJezNslJjOUGQQM6pCXlIfL/nCvFt5cBamGg
kDXWP9WUwm9ML4niuWYaRLCBgYD5/A==
=ZC7l
-----END PGP SIGNATURE-----

--LMEiHe91IaBnmo8BxjhFaaMMpmL0Bw1WO--


