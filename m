Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A33C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 12:22:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A60BB207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 12:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NPLtnuzu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A60BB207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZDNq-0000Zx-IN
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 07:22:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58931)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iZDM8-0007Hq-6o
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 07:20:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iZDKr-0007Tv-KL
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 07:19:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36537
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iZDKr-0007TV-Fv
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 07:19:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574684360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YArkaHTKwh4qpgiVm5BJjVUH78OxmyQ2lfP1CUQzAcc=;
 b=NPLtnuzup9EmMQBLci6lNq4QB5I0atfJFdLGLB2/ONMlqoaWBwAe0b4sFjJgPvIbWeG8EE
 PqO3HqF1K9xMUCqBVYzoZ0X/ZGm8C/WmAt7CTvnmJAK1DefX/vNsDimY7RrZEm5lOkzuEk
 e2fEg2aVdFTkhWdu5u08arZ1WLdOkJc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-9TlXY63KOEyozqAE65ERFw-1; Mon, 25 Nov 2019 07:19:19 -0500
X-MC-Unique: 9TlXY63KOEyozqAE65ERFw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5410780058F;
 Mon, 25 Nov 2019 12:19:17 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C8620165D3;
 Mon, 25 Nov 2019 12:19:12 +0000 (UTC)
Subject: Re: [PATCH v3 8/8] iotests: Test committing to short backing file
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20191122160511.8377-1-kwolf@redhat.com>
 <20191122160511.8377-9-kwolf@redhat.com>
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
Message-ID: <3d25cde9-5153-8c16-0c47-eeb0038891dc@redhat.com>
Date: Mon, 25 Nov 2019 13:19:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191122160511.8377-9-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KYIag6UH8yblv9yjHl73l8scK7wKsGHmN"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: vsementsov@virtuozzo.com, qemu-devel@nongnu.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KYIag6UH8yblv9yjHl73l8scK7wKsGHmN
Content-Type: multipart/mixed; boundary="EPYg29A41k9mQqBsexcUZihidvCUEZr2g"

--EPYg29A41k9mQqBsexcUZihidvCUEZr2g
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22.11.19 17:05, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/274        | 152 +++++++++++++++++++++++++
>  tests/qemu-iotests/274.out    | 203 ++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/group      |   1 +
>  tests/qemu-iotests/iotests.py |   2 +-
>  4 files changed, 357 insertions(+), 1 deletion(-)
>  create mode 100755 tests/qemu-iotests/274
>  create mode 100644 tests/qemu-iotests/274.out

[...]

> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
> index b46d298766..9135dd52b6 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -149,7 +149,7 @@ def img_info_log(filename, filter_path=3DNone, imgopt=
s=3DFalse, extra_args=3D[]):
>      output =3D qemu_img_pipe(*args)
>      if not filter_path:
>          filter_path =3D filename
> -    log(filter_img_info(output, filter_path))
> +    log(filter_img_info(output, filter_path), filters=3D[filter_testfile=
s])

This doesn=E2=80=99t work when the path contains $IMGFMT.  The test dir fil=
ter
must then run before the image format filter.  For example, I usually
run the tests in /tmp/test-${IMGFMT}-${IMGPROTO} (i.e.
/tmp/test-qcow2-file for -qcow2), and this test fails for me:

@@ -49,7 +49,7 @@
 file format: IMGFMT
 virtual size: 2 MiB (2097152 bytes)
 cluster_size: 65536
-backing file: TEST_DIR/PID-base
+backing file: /tmp/test-IMGFMT-file/40083-base
 Format specific information:
     compat: 1.1
     lazy refcounts: false

Max


--EPYg29A41k9mQqBsexcUZihidvCUEZr2g--

--KYIag6UH8yblv9yjHl73l8scK7wKsGHmN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3bxr4ACgkQ9AfbAGHV
z0C6BQf+IIApyNNBMJCp4kx61NNzweyUoqGv7PszGs/EbGaKlzJAM0cuJIJa+aqm
MF6S1h3cbqvZUVGXwN1grNDGU6wcuBCmAZLlL85fCRCShAId1KdgpK8uNfgkYR0s
gKnVTUo5b5+VCKFo1HmGn8Hz+AIdzstJ7CVd/4o2JfXib6hiFbl0G0fuZLn373Jo
xdMeRntONuMHsuEqiBm96OH6ZxNGVe7BHmyfvk896oFQMPWA5a5Ll94zh3o20FHB
nzapiHlx1ecJpeMZW0VCG9RUUzGZiBRhcyHWq6sPJhw7GLB7qrBoyVI62vNarrBy
+X5TaCjr4Oh2S03/1z8NYhREvgZ1iw==
=jFQp
-----END PGP SIGNATURE-----

--KYIag6UH8yblv9yjHl73l8scK7wKsGHmN--


