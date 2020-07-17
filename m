Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DADC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 11:51:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D1F42070E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 11:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+mnxty0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D1F42070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwOtw-0004GH-Qf
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 07:51:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jwOtC-0003cy-Fe
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 07:50:54 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57943
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jwOt9-0001gA-Kt
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 07:50:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594986650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eJS1NvS96UrLyFCSqlZrT5AZeGlmfPcPYXclcJsawo0=;
 b=D+mnxty0DAfDWjq+ck+XPEDpdoZRl1kQS+sBnivDWsZq30BH4WhziGjtQq8EdZEr5i1ci8
 GWHloZbJ0Ts6RQLGhTxGS+E4M97rhP1nZ8TrMjxcY2/wx+QwNqqKHSQ6oeG28JxJ8iedZl
 EkaVvr3Ob3W60I4dkzx4iPsspcxgo/U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-XpckwKYvNSaZBnfKkBLuMQ-1; Fri, 17 Jul 2020 07:50:48 -0400
X-MC-Unique: XpckwKYvNSaZBnfKkBLuMQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1338A800597;
 Fri, 17 Jul 2020 11:50:47 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-123.ams2.redhat.com
 [10.36.113.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2FDB972AEC;
 Fri, 17 Jul 2020 11:50:45 +0000 (UTC)
Subject: Re: [PATCH for-5.1 2/3] file-posix: Fix check_hdev_writable() with
 auto-read-only
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200717105426.51134-1-kwolf@redhat.com>
 <20200717105426.51134-3-kwolf@redhat.com>
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
Message-ID: <6edffcd1-ac03-b0ad-dd87-5ba923f4763a@redhat.com>
Date: Fri, 17 Jul 2020 13:50:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717105426.51134-3-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="yuGPWKWACmqhuKbhN7MeGnhbdQSJQg9sW"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 05:27:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yuGPWKWACmqhuKbhN7MeGnhbdQSJQg9sW
Content-Type: multipart/mixed; boundary="dmXSVOmZUq7JUnOWie2PHWPYZ4623qeoH"

--dmXSVOmZUq7JUnOWie2PHWPYZ4623qeoH
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17.07.20 12:54, Kevin Wolf wrote:
> For Linux block devices, being able to open the device read-write
> doesn't necessarily mean that the device is actually writable (one
> example is a read-only LV, as you get with lvchange -pr <device>). We
> have check_hdev_writable() to check this condition and fail opening the
> image read-write if it's not actually writable.
>=20
> However, this check doesn't take auto-read-only into account, but
> results in a hard failure instead of downgrading to read-only where
> possible.
>=20
> Fix this and do the writable check not based on BDRV_O_RDWR, but only
> when this actually results in opening the file read-write. A second
> check is inserted in raw_reconfigure_getfd() to have the same check when
> dynamic auto-read-only upgrades an image file from read-only to
> read-write.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/file-posix.c | 33 +++++++++++++++++++++------------
>  1 file changed, 21 insertions(+), 12 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--dmXSVOmZUq7JUnOWie2PHWPYZ4623qeoH--

--yuGPWKWACmqhuKbhN7MeGnhbdQSJQg9sW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8RkJQACgkQ9AfbAGHV
z0DNhAgAlDL11iW/L1xdhfa0HU/7tky7lImDnbEPmTqTUA5Gm0xpsNLmJ/KTGVgj
v95p5jC0ODUHcetdJ6gz/qgcZCUkoRfDC4usSeww+n4PC/TGRF7IyhsOEFsbiV7d
qRAGKDfEA2rQmLcsYf+GJmhqvRtUblV8o/rh4JgjC/NPMTzaJL9Bjo0RRiSAbxB1
/qcZN1w3yHvE6JQkC5lma1duDheAFduGV8WN3JurQrkVde3zaDRRjM3qsTyOgqDv
S5bxOAgTLdNT/OohLnPlvzp6evXroWemcqriNv4CwBhkn5wEFOAn2ebdYMZd8taJ
fxQgX2tNXnGq3QDVgv2QumEONiJYfw==
=BdIS
-----END PGP SIGNATURE-----

--yuGPWKWACmqhuKbhN7MeGnhbdQSJQg9sW--


