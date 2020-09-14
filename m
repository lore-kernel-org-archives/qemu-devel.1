Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280FDC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:18:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BE462226B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H8DXkYR0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BE462226B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHnRY-0001U3-LJ
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 08:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kHnNt-0006Tw-06
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:15:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53589)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kHnNq-0006IH-8s
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600085697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=y+7lYl77M8kwTgHhZ5Z427JWMpP/IUJRDR9GK2TzyeY=;
 b=H8DXkYR09SfUMYClnVbL9SQvvTxwrhlTbJj3ToJsimInshFeX6zWO4oCz/qU5H5n6+GW76
 peA6U53QLw1OuW7jbh2aQ0w2JC472YfIG1018gQMa99XXhb0hIBbxcddkGZrTFvwlXHOtf
 fptPCG8nu+3hYmcD0qmRRgg1tvEz04g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-ySg1aS3NPjS-UT22P0XqNw-1; Mon, 14 Sep 2020 08:14:55 -0400
X-MC-Unique: ySg1aS3NPjS-UT22P0XqNw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08ADC18C89C2;
 Mon, 14 Sep 2020 12:14:54 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-80.ams2.redhat.com
 [10.36.114.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E22E97EEB6;
 Mon, 14 Sep 2020 12:14:52 +0000 (UTC)
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
Message-ID: <d9249870-9cab-9fd5-8920-9f531e960279@redhat.com>
Date: Mon, 14 Sep 2020 14:14:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <adeb8b059917b141d5f5b3bd2a016262d3052c79.1599833007.git.berto@igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vdg1Y6LIFUgWjexE7Vf7TG7KgYlvqWldE"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:10:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
--vdg1Y6LIFUgWjexE7Vf7TG7KgYlvqWldE
Content-Type: multipart/mixed; boundary="cARwPf8wuEIdKvn6XG4SvSBtrBrCDo7qO"

--cARwPf8wuEIdKvn6XG4SvSBtrBrCDo7qO
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

Reviewed-by: Max Reitz <mreitz@redhat.com>


--cARwPf8wuEIdKvn6XG4SvSBtrBrCDo7qO--

--vdg1Y6LIFUgWjexE7Vf7TG7KgYlvqWldE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9fXrsACgkQ9AfbAGHV
z0BMoQgAsh8gg17c/OzlB+mW1F5sGTNVLUS7vALpkCkvevI4N8MBbYx0OVSQL2sT
QeSZ/ROKIizmY0Ke25r677EkUzmBbU3b2ugvtlqm+xJHaVWXcTui5J+6hFQV6SQF
/fezrXswgInnNuAcTCiQbRIsdGvtUpIsE9Kf9vb7dnKNWLMaeDWIouBSCSt2kGrd
iLVM/DaaFKcC4W+NDfWhwOBIqt7SqTyd7FnezSdY0/pK9aQUgfirSF0ZuOFKFWGS
NIZTR1UHBLlU+JivUp/xmg+bwnXC8g7lDULf327J+q2FDbW1uENC4O7Qq4eRu2kI
AYOlH0Cd57m/2Lqc+9CJ+2dnGqGWYw==
=lLlI
-----END PGP SIGNATURE-----

--vdg1Y6LIFUgWjexE7Vf7TG7KgYlvqWldE--


