Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D91DC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 08:47:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1E9020665
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 08:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OgQVAlU/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1E9020665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGeiI-0002fY-O7
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 04:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kGehQ-0000ub-Ny
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 04:46:28 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30331
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kGehP-00032h-0k
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 04:46:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599813986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=F1z4iVP+6kMvtlzS1eRRE7RgixOQjf4iGUxcEMSKBTM=;
 b=OgQVAlU/BNUHD2M1kBUfEJVR1YKQqeQQ40mF7di+8mP89g/ngO7LTnMqmf75jU7vCPbwvZ
 fxIkw9M/t3oWf2jTrVL+x2v3N/SaaVknazqTrrQWcUjXN8v/r2uXol8icStusDc5Y8mnz+
 AZIJLLZjh/XSYZr4hEPg3aeJNS7M5Js=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-CiCa77baMsqvnYh68YIEog-1; Fri, 11 Sep 2020 04:46:20 -0400
X-MC-Unique: CiCa77baMsqvnYh68YIEog-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A71FF108E8A2;
 Fri, 11 Sep 2020 08:46:19 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-148.ams2.redhat.com
 [10.36.113.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F81E7E8F5;
 Fri, 11 Sep 2020 08:46:18 +0000 (UTC)
Subject: Re: [PATCH 0/2] Fix error handling in preallocate_co()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1599573989.git.berto@igalia.com>
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
Message-ID: <91da123d-f3c1-95f0-d195-8a0dbfa0edeb@redhat.com>
Date: Fri, 11 Sep 2020 10:46:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <cover.1599573989.git.berto@igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cqKQG2m3uQodzFnZDlsRMt0EIR2kOFj6E"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 03:40:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
--cqKQG2m3uQodzFnZDlsRMt0EIR2kOFj6E
Content-Type: multipart/mixed; boundary="btre2uFtxSSgWOTsOXPSBnP24YMMieRKi"

--btre2uFtxSSgWOTsOXPSBnP24YMMieRKi
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 08.09.20 16:08, Alberto Garcia wrote:
> This is a follow-up to "Fix removal of list members from
> BDRVQcow2State.cluster_allocs":
>=20
>    https://lists.gnu.org/archive/html/qemu-block/2020-09/msg00247.html
>=20
> However the patches themselves are independent and can be applied
> separately.
>=20
> Regards,
>=20
> Berto
>=20
> Alberto Garcia (2):
>   qcow2: Handle QCowL2Meta on error in preallocate_co()
>   qcow2: Make qcow2_free_any_clusters() free only one cluster
>=20
>  block/qcow2.h          |  4 ++--
>  block/qcow2-cluster.c  |  6 +++---
>  block/qcow2-refcount.c |  8 ++++----
>  block/qcow2.c          | 40 +++++++++++++++++-----------------------
>  4 files changed, 26 insertions(+), 32 deletions(-)

Thanks, applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block


--btre2uFtxSSgWOTsOXPSBnP24YMMieRKi--

--cqKQG2m3uQodzFnZDlsRMt0EIR2kOFj6E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9bOVkACgkQ9AfbAGHV
z0Bf3ggAlMdxj0pZ6WO8w5xn8YAOiTkIOenl9pX/xiMUPqWU1Vvx4n09/WC8FUv4
aXgOlSf0CstVlxXXHigSisGTvCwki4Auuvop1VRh/m9QHNbAurfgIsKAdWE3ZQmn
/arK+LYJesdkK0apPYmek5y3EdoPgDEVI+cJ34yxsAD/9mSizp7yiBXxTecN/TTw
il+UIHwLaIYjrpIzMT85nmmb3FVyg8osejmUhaDUFHM89WPX+GzVNno1LmetEOS/
Rj5L7VQd+g/0XSWmEc3vscnIl+vj5lHTBG7qTBgmGPKRU/4QMuBZB5LrL0E1Gt8j
nTwqDBv/Uj9JL2Mx18d7MWGQ9KCwqw==
=ikEj
-----END PGP SIGNATURE-----

--cqKQG2m3uQodzFnZDlsRMt0EIR2kOFj6E--


