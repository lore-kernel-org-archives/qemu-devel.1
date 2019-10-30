Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E379CA9EC7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 11:21:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BF0F2054F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 11:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EzLIAHSO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BF0F2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPm33-0000Gq-Ae
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 07:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50732)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iPm2O-0008Ew-PW
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 07:21:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iPm2M-000453-84
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 07:21:15 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58130
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iPm2M-00043I-2x
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 07:21:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572434472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=k5go8S1zOmH+x0PMIjtAIxBfa8etQajo1Hf544O/ASE=;
 b=EzLIAHSOqSW6x2E+wezK2mnt3bUncJnzd4CD7kTFasR5i7p35M3z33e3LykvN3W+8SI1qe
 oMfPWi5mMDTi8QgvbxFRuZ7tRIshGGpEECdM85+PBkw3wEX4C0m7HBdFj85lqA9tOo80MV
 6sZjhowPpRAcoU0+k8NFrRUTm5xFj08=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-1mShDk6GPyeWqtD09y_Wqg-1; Wed, 30 Oct 2019 07:21:10 -0400
X-MC-Unique: 1mShDk6GPyeWqtD09y_Wqg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 612A680183D;
 Wed, 30 Oct 2019 11:21:09 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-147.ams2.redhat.com
 [10.36.117.147])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EF6FB60872;
 Wed, 30 Oct 2019 11:21:04 +0000 (UTC)
Subject: Re: [PATCH v3 4/6] iotests: Skip "make check-block" if QEMU does not
 support virtio-blk
To: Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org
References: <20191022072135.11188-1-thuth@redhat.com>
 <20191022072135.11188-5-thuth@redhat.com>
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
Message-ID: <76688061-c59d-953e-b3db-097e3f46fff0@redhat.com>
Date: Wed, 30 Oct 2019 12:21:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191022072135.11188-5-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4JlnWhI8n2icvUtJusrqwGwP2Pzo1wwZQ"
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4JlnWhI8n2icvUtJusrqwGwP2Pzo1wwZQ
Content-Type: multipart/mixed; boundary="7MNbWIArj50LHoQEQEVUzKJK8j0t6DHes"

--7MNbWIArj50LHoQEQEVUzKJK8j0t6DHes
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22.10.19 09:21, Thomas Huth wrote:
> The next patch is going to add some python-based tests to the "auto"
> group, and these tests require virtio-blk to work properly. Running
> iotests without virtio-blk likely does not make too much sense anyway,
> so instead of adding a check for the availability of virtio-blk to each
> and every test (which does not sound very appealing), let's rather add
> a check for this at the top level in the check-block.sh script instead
> (so that it is possible to run "make check" without the "check-block"
> part for qemu-system-tricore for example).
>=20
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/check-block.sh | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/check-block.sh b/tests/check-block.sh
> index 679aedec50..e9e2978818 100755
> --- a/tests/check-block.sh
> +++ b/tests/check-block.sh
> @@ -26,10 +26,24 @@ if grep -q "CFLAGS.*-fsanitize" config-host.mak 2>/de=
v/null ; then
>      exit 0
>  fi
> =20
> -if [ -z "$(find . -name 'qemu-system-*' -print)" ]; then
> +if [ -n "$QEMU_PROG" ]; then
> +    qemu_prog=3D"$QEMU_PROG"
> +else
> +    for binary in *-softmmu/qemu-system-* ; do

Hm, I know I=E2=80=99ve already given my R-b, but looking at this again =E2=
=80=93 what
if the user builds qemu for multiple targets?  Then this will just test
any target, whereas the iotests might test something else, because the
algorithm there is slightly different:

First, check $QEMU_PROG (same as here).

Second, check $build_iotests/qemu.  I think we can do this here, because
we know that $build_iotests is $PWD/tests/qemu-iotests (or invoking
./check below wouldn=E2=80=99t work).

Third, and this is actually important, I think, is that we first look
for the qemu that matches the host architecture (uname -m, with an
exception for ppc64).  I think we really should do that here, too.

Fourth, look for any qemu, as is done here.


So I think we could do without #2, but it probably doesn=E2=80=99t hurt to =
check
that, too.  I don=E2=80=99t think we should do without #3, though.

Max


--7MNbWIArj50LHoQEQEVUzKJK8j0t6DHes--

--4JlnWhI8n2icvUtJusrqwGwP2Pzo1wwZQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl25ch8ACgkQ9AfbAGHV
z0BTPwf9F4hUOMqoI22q6HR7hUNXzeeHUwfddwXAFvs0QvU1HdWEE4z9pWgLsLeB
pPSfZujemfTNFf/VE0lUe+dcRci1etY5pjoyqOBA3Hw1nO6xduhFzbFNdInH8imo
toIydeF4l75sdDXREAfozQDhrwrzEn2TS/8j5rmbPTjKFAm1ew9MHOkkFv4bj4JV
ZgaN2J+fABd9HAr/bLiZPp57ckwhuwMfc7ImaMlbuqYTzrPmfnpwdalZ1pzHaor8
e30O17djjIdsyg9kpl8fyJakdJVH4o0/qcRDOsiQBL/bPXtY4kdBsqXbc3go7e+a
UMtREVyQVofBwmymy5T2kBUDuC0pgw==
=09aE
-----END PGP SIGNATURE-----

--4JlnWhI8n2icvUtJusrqwGwP2Pzo1wwZQ--


