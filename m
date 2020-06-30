Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F46C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 09:38:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BABD220774
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 09:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BKqJIJia"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BABD220774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqCiT-0000o4-0M
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 05:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50152)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jqChj-0000H8-03
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 05:37:27 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33208
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jqChg-0000Ee-U0
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 05:37:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593509844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=u0wmlJvqpaIaVfmPXuD8pWUveb396vWdo+OvgQ30Mvk=;
 b=BKqJIJiadj9PoCWARoaeNVoy91/Q4SVlcJPIBSZU4xrtug34jUfQytCWvUp7xsUjm0ylDe
 BtCB1H7jDdBhkBlNDVGYolpJ1t9oqwzGVVKCFEth3E11Qd68XdJy2y1bInMSU9RPZCdSA+
 VPDfWqtU/PDsW2j5mWsg++kDPglX3kQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-eI4T-cnpOpqLJkn5DYtN1A-1; Tue, 30 Jun 2020 05:37:18 -0400
X-MC-Unique: eI4T-cnpOpqLJkn5DYtN1A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B764D464;
 Tue, 30 Jun 2020 09:37:17 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-102.ams2.redhat.com
 [10.36.113.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 999BF741B1;
 Tue, 30 Jun 2020 09:37:15 +0000 (UTC)
Subject: Re: [PATCH v2] qcow2: Fix preallocation on images with unaligned sizes
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <20200617140036.20311-1-berto@igalia.com>
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
Message-ID: <2171ec86-bc54-813d-c343-8320f9cbbd47@redhat.com>
Date: Tue, 30 Jun 2020 11:37:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200617140036.20311-1-berto@igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cPh66h95RdSn8pHKBT7fE94oJ7ArQXEIE"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 02:00:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cPh66h95RdSn8pHKBT7fE94oJ7ArQXEIE
Content-Type: multipart/mixed; boundary="1aZUEohAJt4PAiEVog2efjF8901Z4ZbPf"

--1aZUEohAJt4PAiEVog2efjF8901Z4ZbPf
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17.06.20 16:00, Alberto Garcia wrote:
> When resizing an image with qcow2_co_truncate() using the falloc or
> full preallocation modes the code assumes that both the old and new
> sizes are cluster-aligned.
>=20
> There are two problems with this:
>=20
>   1) The calculation of how many clusters are involved does not always
>      get the right result.
>=20
>      Example: creating a 60KB image and resizing it (with
>      preallocation=3Dfull) to 80KB won't allocate the second cluster.
>=20
>   2) No copy-on-write is performed, so in the previous example if
>      there is a backing file then the first 60KB of the first cluster
>      won't be filled with data from the backing file.
>=20
> This patch fixes both issues.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
> v2: iotests: don't check the image size if data_file is set [Max]
>=20
>  block/qcow2.c              | 17 ++++++++++++++---
>  tests/qemu-iotests/125     | 24 ++++++++++++++++++++++++
>  tests/qemu-iotests/125.out |  9 +++++++++
>  3 files changed, 47 insertions(+), 3 deletions(-)

Thanks, applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block


--1aZUEohAJt4PAiEVog2efjF8901Z4ZbPf--

--cPh66h95RdSn8pHKBT7fE94oJ7ArQXEIE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl77B8kACgkQ9AfbAGHV
z0BCjwf+M70KBljnfn7oWFwRlrcCGYTQ/6f3UBCaSYJDhh5b7vbBvKWDPJr4s6eE
Y69NK6XqopmbdEyzipOSMYlLVAWJx6bWuRq10ecVYFf+s8j5/cgC8ttCmZsLVHoJ
5vFOSAR0+l/4tswmooTv6EQWMs66UvgwHy01O8jTRizRkXxd/3Yp8cCkuIKsKaw+
362WL4Mr8iYuRE5VlD1riSv4uYzBdObJqMrCnDgWEilIhUyoBCI9vKgoqouyqJ4c
m4oLdrir5Pc9FFOJ+9/ogBe22/8GsqCPsemS4/k2IK/9X+lcgn0x/p6C/5E4hlVx
B58PnSlH5FJwQGcwPurjbA0fm3Iqhg==
=fbq3
-----END PGP SIGNATURE-----

--cPh66h95RdSn8pHKBT7fE94oJ7ArQXEIE--


