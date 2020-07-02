Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B435C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 13:00:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 658DF20772
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 13:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g0sEzSBp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 658DF20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqyp0-0004AY-H8
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 09:00:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jqylT-0006Jn-6x
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 08:56:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44823
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jqylR-0004VV-Id
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 08:56:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593694589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GX1+GTTTXAISj19ZhNSmu33TWUFWubmX4ZBNaQ039as=;
 b=g0sEzSBpJZjz4838nNSL5pOXfKZQLgtuc1HQ35n8RXUJRl1ic7BIvnXQSxD51uA98xxqh6
 OJo9oJx/th0IoImMGvkUtr7aFLXo7h+M19m/t+UvT3QvTIg4S6cW0AvwvrKgMNmB2/RnsN
 8oo2RPeCFDrD3Hqj1O8CWtZQ9mY60Lc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-PbMYmcbaMNC4z-v-YYVufg-1; Thu, 02 Jul 2020 08:56:26 -0400
X-MC-Unique: PbMYmcbaMNC4z-v-YYVufg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC16864AD6;
 Thu,  2 Jul 2020 12:56:25 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-196.ams2.redhat.com
 [10.36.113.196])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 205CC60CD3;
 Thu,  2 Jul 2020 12:56:23 +0000 (UTC)
Subject: Re: [PATCH v9 22/34] qcow2: Add subcluster support to
 zero_in_l2_slice()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1593342067.git.berto@igalia.com>
 <7551704955c6ea570af4053fb86da5b3a33493c4.1593342067.git.berto@igalia.com>
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
Message-ID: <967c26f7-fc83-68d2-707b-05a90c9d52ac@redhat.com>
Date: Thu, 2 Jul 2020 14:56:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <7551704955c6ea570af4053fb86da5b3a33493c4.1593342067.git.berto@igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0V1IQuQMI64uqlX3HP0jHH21nJVMNHBzj"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 03:23:40
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
--0V1IQuQMI64uqlX3HP0jHH21nJVMNHBzj
Content-Type: multipart/mixed; boundary="9mkfchCS8EtroA2DTBSUA8BNh6p2NVlO6"

--9mkfchCS8EtroA2DTBSUA8BNh6p2NVlO6
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 28.06.20 13:02, Alberto Garcia wrote:
> The QCOW_OFLAG_ZERO bit that indicates that a cluster reads as
> zeroes is only used in standard L2 entries. Extended L2 entries use
> individual 'all zeroes' bits for each subcluster.
>=20
> This must be taken into account when updating the L2 entry and also
> when deciding that an existing entry does not need to be updated.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/qcow2-cluster.c | 36 +++++++++++++++++++-----------------
>  1 file changed, 19 insertions(+), 17 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--9mkfchCS8EtroA2DTBSUA8BNh6p2NVlO6--

--0V1IQuQMI64uqlX3HP0jHH21nJVMNHBzj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl792XYACgkQ9AfbAGHV
z0By/ggAp+FvL97CK3oSKF2uQVVYv0LTOTU3wLfTW7kegC4iX765RAUXunHry4c8
XOnQaBuZNs7ejKYGiGawXblR2177Leg26hHOtFC2Xa6b5ziftSxbBeCgRn23CTFh
BZHIlWq3EMbHmjrhuZAmFQMNjcSlJa5yyaY3VtZQC3etH6RYBmxMbDEXUe6FTqvy
XMJYCp+shGqnH9My+Otf7AkIzebyILu3PtZpq3S4BNd5Cj2GNogoHxyOTofnQp3O
krk03uwPV/C0lxsf+RF27eh5pyoUcH4qTpLezadplndTA3M4Jqk+OGLagB6aNVHF
vW2eyICXquy+CHwW5jTixOC2RsFbrQ==
=UU5U
-----END PGP SIGNATURE-----

--0V1IQuQMI64uqlX3HP0jHH21nJVMNHBzj--


