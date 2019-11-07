Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31ED2C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 16:58:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F23402077C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 16:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RUmggNaD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F23402077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSl74-0004dh-Mh
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 11:58:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43993)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iSkuf-0005LS-Qb
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:45:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iSkue-0008ME-IW
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:45:37 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51181
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iSkue-0008M2-Cu
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:45:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573145135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6cfsRXV7C0oNXAxuOWdHLmuNRNJK67SojT9JqbA9HLU=;
 b=RUmggNaDCCZyai+mn9e2xuvtmxtf7+TQ4X7OOxStBsEdvQLvdwWWTk7FPaRRvp6eTsP/yj
 8Ft4gb9md1f1CRtOqJs+LrZR2bqeWJMJ9sDUaAVuM+e3rf2GAgY9vIw8K3fkColppJW5Mp
 TdS+x2L/BCg1AAEsvmM/Ats4XEPxxqw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-pto9P0doM2OLZEBrt5K-6w-1; Thu, 07 Nov 2019 11:45:34 -0500
X-MC-Unique: pto9P0doM2OLZEBrt5K-6w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1FAB21800D6B;
 Thu,  7 Nov 2019 16:45:33 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-149.ams2.redhat.com
 [10.36.117.149])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E6B0A608DC;
 Thu,  7 Nov 2019 16:45:31 +0000 (UTC)
Subject: Re: [PATCH v3 21/22] iotests: Disable data_file where it cannot be
 used
To: qemu-block@nongnu.org
References: <20191107163708.833192-1-mreitz@redhat.com>
 <20191107163708.833192-22-mreitz@redhat.com>
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
Message-ID: <cc30846b-c238-4a83-9ce4-7c1b914e5e6c@redhat.com>
Date: Thu, 7 Nov 2019 17:45:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191107163708.833192-22-mreitz@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0DAAvFmnO9YWa47YxiT4dmzG3JRbkrbrj"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0DAAvFmnO9YWa47YxiT4dmzG3JRbkrbrj
Content-Type: multipart/mixed; boundary="MBYf4zI7DGzhjwmqR1E4HbOFMpWffMzQv"

--MBYf4zI7DGzhjwmqR1E4HbOFMpWffMzQv
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07.11.19 17:37, Max Reitz wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/007 | 5 +++--
>  tests/qemu-iotests/014 | 2 ++
>  tests/qemu-iotests/015 | 5 +++--
>  tests/qemu-iotests/026 | 5 ++++-
>  tests/qemu-iotests/029 | 5 +++--
>  tests/qemu-iotests/031 | 6 +++---
>  tests/qemu-iotests/036 | 5 +++--
>  tests/qemu-iotests/039 | 3 +++
>  tests/qemu-iotests/046 | 2 ++
>  tests/qemu-iotests/048 | 2 ++
>  tests/qemu-iotests/051 | 5 +++--
>  tests/qemu-iotests/058 | 5 +++--
>  tests/qemu-iotests/060 | 6 ++++--
>  tests/qemu-iotests/061 | 6 ++++--
>  tests/qemu-iotests/062 | 2 +-
>  tests/qemu-iotests/066 | 4 +++-
>  tests/qemu-iotests/067 | 6 ++++--
>  tests/qemu-iotests/068 | 5 +++--
>  tests/qemu-iotests/071 | 3 +++
>  tests/qemu-iotests/073 | 4 ++++
>  tests/qemu-iotests/074 | 2 ++
>  tests/qemu-iotests/080 | 5 +++--
>  tests/qemu-iotests/090 | 2 ++
>  tests/qemu-iotests/098 | 6 ++++--
>  tests/qemu-iotests/099 | 3 ++-
>  tests/qemu-iotests/103 | 5 +++--
>  tests/qemu-iotests/108 | 6 ++++--
>  tests/qemu-iotests/112 | 5 +++--
>  tests/qemu-iotests/114 | 2 ++
>  tests/qemu-iotests/121 | 3 +++
>  tests/qemu-iotests/138 | 3 +++
>  tests/qemu-iotests/156 | 2 ++
>  tests/qemu-iotests/176 | 7 +++++--
>  tests/qemu-iotests/191 | 2 ++
>  tests/qemu-iotests/201 | 6 +++---
>  tests/qemu-iotests/214 | 3 ++-
>  tests/qemu-iotests/217 | 3 ++-
>  tests/qemu-iotests/220 | 5 +++--
>  tests/qemu-iotests/243 | 6 ++++--
>  tests/qemu-iotests/244 | 5 +++--
>  tests/qemu-iotests/250 | 2 ++
>  tests/qemu-iotests/261 | 3 ++-
>  tests/qemu-iotests/267 | 5 +++--
>  43 files changed, 124 insertions(+), 53 deletions(-)

[...]

> diff --git a/tests/qemu-iotests/067 b/tests/qemu-iotests/067
> index 926c79b37c..3bc6e719eb 100755
> --- a/tests/qemu-iotests/067
> +++ b/tests/qemu-iotests/067
> @@ -32,8 +32,10 @@ status=3D1=09# failure is the default!
> =20
>  _supported_fmt qcow2
>  _supported_proto file
> -# Because anything other than 16 would change the output of query-block
> -_unsupported_imgopts 'refcount_bits=3D\([^1]\|.\([^6]\|$\)\)'
> +# Because anything other than 16 would change the output of query-block,
> +# and external data files would change the output of
> +# query-named-block-ndoes

s/ndoes/nodes/...


--MBYf4zI7DGzhjwmqR1E4HbOFMpWffMzQv--

--0DAAvFmnO9YWa47YxiT4dmzG3JRbkrbrj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3ESikACgkQ9AfbAGHV
z0DyYwf/T0f14y+hpGGVW+iVe4oK5Knf5qEq8FHNYJOuW21vbroKefqGKCSIRy2i
M8lGmAxSaL3L0S1B5FTNHv+ZbqEiPWIM9sz6t0HWw0UY1ac3JfVwkJWJ1ZrWsI9M
F86wv+cjMnkZy7p58jgDt4jTOxgIAK9YFRHPD2ewRJxWtcDugNtfvJHzqtulzURi
fFxfWls5upMcHcdWE/kBcy6SRFKR/hXPlftkXV+pw66eWYcbHwbxJu5NTQZdBzJl
GB5vFCfgCU7X90yR13PSUiA67UKqfajce/rWs9qXu96ZFqryO7bpgyh0vm1PAy1X
1ENcnTRaDE1vpSnMhHD4k2pqUY/RGg==
=NVTP
-----END PGP SIGNATURE-----

--0DAAvFmnO9YWa47YxiT4dmzG3JRbkrbrj--


