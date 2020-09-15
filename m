Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D48C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 09:30:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 106B62054F
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 09:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e0F5+Vk8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 106B62054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI7IO-00070Z-0U
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 05:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kI7HM-0006Sf-Db
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 05:29:36 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45021
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kI7HI-0003Aa-8V
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 05:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600162170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HH7Tsp9WRpJA9lw9wvx+7iOVCQFydMjtxvS5a7WyE7c=;
 b=e0F5+Vk8LkOI2fJjSVv8ryHIQw4QEDzvOYHOYwoi6iJpu/GFXirdt9RJgNedxm8hdfGEit
 RDbDhOtxyFjt4Mt43QQcyoS6meD+iP3nxHkyL+WBbyIJeEMhCkN3MfTR8h5mXF7sC90d2V
 ltf9afEMffJVq2CoLDFXn2XhVKvjaOU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-Hu898o8AN6uwVrGYtRjNMQ-1; Tue, 15 Sep 2020 05:29:28 -0400
X-MC-Unique: Hu898o8AN6uwVrGYtRjNMQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 576151006704;
 Tue, 15 Sep 2020 09:29:27 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-7.ams2.redhat.com
 [10.36.113.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D25561975F;
 Tue, 15 Sep 2020 09:29:24 +0000 (UTC)
Subject: Re: [PATCH 1/2] qcow2: Make preallocate_co() resize the image to the
 correct size
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1599833007.git.berto@igalia.com>
 <adeb8b059917b141d5f5b3bd2a016262d3052c79.1599833007.git.berto@igalia.com>
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
Message-ID: <a5a760d1-5b8f-dfd7-93ef-b62e63b3c320@redhat.com>
Date: Tue, 15 Sep 2020 11:29:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <adeb8b059917b141d5f5b3bd2a016262d3052c79.1599833007.git.berto@igalia.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="fVbaoJfLVKZdUGO1UBDo8lZfVPcyFKxMV"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 03:21:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
--fVbaoJfLVKZdUGO1UBDo8lZfVPcyFKxMV
Content-Type: multipart/mixed; boundary="MKYhrGVecw3U7CXZ0tiALkXkhY9rFxHfx"

--MKYhrGVecw3U7CXZ0tiALkXkhY9rFxHfx
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11.09.20 16:09, Alberto Garcia wrote:
> This function preallocates metadata structures and then extends the
> image to its new size, but that new size calculation is wrong because
> it doesn't take into account that the host_offset variable is always
> cluster-aligned.
>=20
> This problem can be reproduced with preallocation=3Dmetadata when the
> original size is not cluster-aligned but the new size is. In this case
> the final image size will be shorter than expected.
>=20
>    qemu-img create -f qcow2 img.qcow2 31k
>    qemu-img resize --preallocation=3Dmetadata img.qcow2 128k
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2.c              |  1 +
>  tests/qemu-iotests/125     | 40 +++++++++++++++++++++-----------------
>  tests/qemu-iotests/125.out | 28 ++++++++++++++++++++++++--
>  3 files changed, 49 insertions(+), 20 deletions(-)

The test additions make this test fail with compat=3D0.10.  Are you OK
with disabling compat=3D0.10 by squashing this in?

diff --git a/tests/qemu-iotests/125 b/tests/qemu-iotests/125
index 1f35598b2b..894d53f2bd 100755
--- a/tests/qemu-iotests/125
+++ b/tests/qemu-iotests/125
@@ -43,6 +43,10 @@ get_image_size_on_host()

 _supported_fmt qcow2
 _supported_proto file
+# Growing a file with a backing file (without preallocation=3Dfull or
+# =3Dfalloc) requires zeroing the newly added area, which is impossible
+# to do quickly for v2 images, and hence is unsupported.
+_unsupported_imgopts 'compat=3D0.10'

 if [ -z "$TEST_IMG_FILE" ]; then
     TEST_IMG_FILE=3D$TEST_IMG


--MKYhrGVecw3U7CXZ0tiALkXkhY9rFxHfx--

--fVbaoJfLVKZdUGO1UBDo8lZfVPcyFKxMV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9giXIACgkQ9AfbAGHV
z0CCeQf/ccKT7224AaTA6TooXTfP4qOLeIv2bu8ghTjfDXx+wsmXXQebXFQbsoO4
O+rRRZil9H5WznSn7BPy4hLLbVIUnWF9HfaL5q6KsCtzToZUTENPF/APnZ+EW7TT
fl8qw33eX1X0gdLUM9xH7QtcbPeUIfvuZLHy6Wq62WcDUSqiovUsC4gCZFESxv5P
R+/9JAmbKWI2Ot78L1nN/PC50Qz+Ebri8VcqdTIBSzzZjZ5jKtrK4seNldg/zJVB
7U2Csjd22eg6q++ZJjwVJsQml/mepzG2CpsTMz1o/+pvo/piZOblzKedI9Xzm0MV
j0RbHLp+5TV5y591MhC4vqj+QMFX2A==
=/g4F
-----END PGP SIGNATURE-----

--fVbaoJfLVKZdUGO1UBDo8lZfVPcyFKxMV--


