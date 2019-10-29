Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEEECA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 13:15:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBED520856
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 13:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/v0aisE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBED520856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPRKs-0003os-OO
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 09:14:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51560)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iPRJ3-0002AO-Cf
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 09:13:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iPRAy-0000xW-Lv
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 09:04:46 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29464
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iPRAw-0000wX-Oj
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 09:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572354280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mnDd2C/yzFnKWQDt4L8A3Sz0Net6+pQ60Il7Yu3FYiA=;
 b=Y/v0aisEoeTqs1lMU8YFD0Uw8CmPEG+rFW8om7rcQlzuYJQA1iiKgEF69J+YitMzBupCfe
 YRsTzb6pxWkA3jQdTnuKl8fhkS2GHEan0CvbL84KHwSNRwMk7j6PJFkK/tWPfwquYIeSqc
 /FI9XB3xPFm+0c8hrOtkIqZT8qK+WSc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-a5dTXFXJPiOrM4noxNOFog-1; Tue, 29 Oct 2019 09:04:34 -0400
X-MC-Unique: a5dTXFXJPiOrM4noxNOFog-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 842F11005500;
 Tue, 29 Oct 2019 13:04:33 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-124.ams2.redhat.com
 [10.36.116.124])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C377B19C69;
 Tue, 29 Oct 2019 13:04:29 +0000 (UTC)
Subject: Re: [PATCH v7 1/4] block/replication.c: Ignore requests after failover
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel <qemu-devel@nongnu.org>
References: <cover.1571925699.git.lukasstraub2@web.de>
 <039d59f89205824273eef070cdfa7d5e94f95697.1571925699.git.lukasstraub2@web.de>
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
Message-ID: <f11c009c-76d3-561d-bda6-e263d2c6138b@redhat.com>
Date: Tue, 29 Oct 2019 14:04:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <039d59f89205824273eef070cdfa7d5e94f95697.1571925699.git.lukasstraub2@web.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="G5w5xAFZjRmfUdirfZZbEa0Nh5GHYViWz"
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 Wen Congyang <wency@cn.fujitsu.com>, Wen Congyang <wencongyang2@huawei.com>,
 Jason Wang <jasowang@redhat.com>, Zhang Chen <chen.zhang@intel.com>,
 Xie Changlong <xiechanglong.d@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--G5w5xAFZjRmfUdirfZZbEa0Nh5GHYViWz
Content-Type: multipart/mixed; boundary="sU5vgnSlHozkac5CU7sYovxW2WdRiJBFR"

--sU5vgnSlHozkac5CU7sYovxW2WdRiJBFR
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 24.10.19 16:25, Lukas Straub wrote:
> After failover the Secondary side of replication shouldn't change state, =
because
> it now functions as our primary disk.
>=20
> In replication_start, replication_do_checkpoint, replication_stop, ignore
> the request if current state is BLOCK_REPLICATION_DONE (sucessful failove=
r) or
> BLOCK_REPLICATION_FAILOVER (failover in progres i.e. currently merging ac=
tive
> and hidden images into the base image).
>=20
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> Reviewed-by: Zhang Chen <chen.zhang@intel.com>
> ---
>  block/replication.c | 35 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)

Acked-by: Max Reitz <mreitz@redhat.com>


--sU5vgnSlHozkac5CU7sYovxW2WdRiJBFR--

--G5w5xAFZjRmfUdirfZZbEa0Nh5GHYViWz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl24ONsACgkQ9AfbAGHV
z0CveggAxDEXJjSFmRWnhD/7duNU71Ewszls7Re6ApzH0Aac2A6m0S83CVY0C4DE
qpAaAu3myy/+XpWMsZw0EulV3LJKdiAvQqkEOIrpByoHchi8nTwUizy2lFn79W6p
LGF4WS6VyPedcaY47FRnWdJzjKiw43cSl2hU4LbYrWz+Q2iVm37+NkyYKtA6u5RB
IxAHgNCyzyttpOt2oGCpf9j7C2ysZVy2wyZcTDepu+1pdbuakSm6GbRuvuUgm9tu
R8UK9KExzwWGC7jLSiWZv7VKyFuFE2IuL232gqIcnOfPmsmOmcU2ldrwFNCScFDz
cy1McB5px/r2yNvjY1/Bf3Eq2wKX+A==
=B+by
-----END PGP SIGNATURE-----

--G5w5xAFZjRmfUdirfZZbEa0Nh5GHYViWz--


