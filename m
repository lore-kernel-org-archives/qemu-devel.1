Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44178C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 10:40:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 130D821D56
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 10:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jTk5603c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 130D821D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Mm4-00075d-BH
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 05:40:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58134)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j4MlL-0006KX-Em
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:39:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j4MlK-0006wA-Hc
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:39:27 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51248
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j4MlK-0006vh-D1
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:39:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582108764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1shp02KEA3wKLWnE+d5tjUUyuDjQRH8uD9LRaIRTQqw=;
 b=jTk5603cdgGGwhandDh3VtMawdmiu2RUHMsC/4T+gLxJS6u9tqjj1I7MSziS51WvovcleU
 t+tLDTouegGqwEQPgUIDyFcGxP1e2ZJtd/Wv7/t3Sytm4kCB7Q/S3mqEkcp4FN7nc4bF9q
 AsDOCEqpgn2nCYPK5gHTXJr/N6ePgKk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-WzmPxQW7NVC1iDIli3boAw-1; Wed, 19 Feb 2020 05:39:20 -0500
X-MC-Unique: WzmPxQW7NVC1iDIli3boAw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4D76800D6C;
 Wed, 19 Feb 2020 10:39:18 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-152.ams2.redhat.com
 [10.36.116.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D13C55C28E;
 Wed, 19 Feb 2020 10:39:17 +0000 (UTC)
Subject: Re: [PATCH 0/2] qemu-img: Fix convert -n -B for backing-less targets
To: qemu-block@nongnu.org
References: <20200121155915.98232-1-mreitz@redhat.com>
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
Message-ID: <458b0eb2-ae1e-a052-807c-85fb868a3004@redhat.com>
Date: Wed, 19 Feb 2020 11:39:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200121155915.98232-1-mreitz@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="heZHn1RNxUjKmai9pnRe1cy9AUPTHODFj"
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--heZHn1RNxUjKmai9pnRe1cy9AUPTHODFj
Content-Type: multipart/mixed; boundary="fin62EKKWlUQVlSH3DYM7irqb2ZIcfTLI"

--fin62EKKWlUQVlSH3DYM7irqb2ZIcfTLI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 21.01.20 16:59, Max Reitz wrote:
> Hi,
>=20
> When reviewing David=E2=80=99s series to add --target-is-zero convert, I =
looked
> for a case to show that the current implementation will crash if
> -n --target-is-zero is used together with -B.  It then turned out that
> -B will always crash when combined with -n and the target image does not
> have a backing file set in its image header.
>=20
> This series fixes that.

Thanks for the review, applied to my block branch.

Max


--fin62EKKWlUQVlSH3DYM7irqb2ZIcfTLI--

--heZHn1RNxUjKmai9pnRe1cy9AUPTHODFj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5NEFQACgkQ9AfbAGHV
z0A9UggAokeeChtDP571NNyhWIRHG35OP8cBeV46VncGBkZqj7FkvRnQ7JFPkjIK
3Z1BIPZit/5JN71lhvsC3yorfzGYle07tpy1kT4Fi7wAKMHEGRXPRn7yXA/QFvv8
+zAIjWRRPGCY1FOonDPNP8va9UhHXYex+6mAul4wFoTdLu9UlZSAatiiplj5DFrl
KWNnSQdLSGOhTQZWaCFaD6vIkt6iJm2yRdleYGi3DFiFF936wvTn1y8EIlaWbVky
eOMO3p7GRGWyWlrXUq3eaZiXyfm8is5/oxHTSCL6yoafYrSsArc+w/BDeUlBk11r
d7qn21t8x2e6T2BLuARHle8ROrqCDg==
=F7Wj
-----END PGP SIGNATURE-----

--heZHn1RNxUjKmai9pnRe1cy9AUPTHODFj--


