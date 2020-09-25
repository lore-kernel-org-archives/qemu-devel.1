Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11822C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:38:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85CFE20BED
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RhtRc/bN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85CFE20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLmzb-0001lx-GU
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 08:38:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kLmwD-0007z9-V3
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:34:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24603)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kLmwA-0007NB-Uz
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:34:57 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601037292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KVXeMRmeMqNIqlgFdE72AC5JzhM2pUhcSg977J62p70=;
 b=RhtRc/bNuOLrP8S96/Ym01PwOKVDIApqjDkER6ad2qgWo/OXenoUCUy7t/nIyZbERLCwPt
 X2Xd5wqy3fBjHK+bcxu1BGhCDGuupVeZ4s5qvoF8fv2JchFhmxaiAucOcbSY2JtNRLPP0b
 qL0ELQQy7WzG2aCn5GtmY3RWWUNd1Gw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-Zt3T-yJDNgGYhzjdKtO_aw-1; Fri, 25 Sep 2020 08:34:46 -0400
X-MC-Unique: Zt3T-yJDNgGYhzjdKtO_aw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C85AE1008550;
 Fri, 25 Sep 2020 12:34:45 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-113.ams2.redhat.com
 [10.36.113.113])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B5E55D9DC;
 Fri, 25 Sep 2020 12:34:41 +0000 (UTC)
Subject: Re: [PATCH v2 21/31] block/export: Add BLOCK_EXPORT_DELETED event
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200924152717.287415-1-kwolf@redhat.com>
 <20200924152717.287415-22-kwolf@redhat.com>
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
Message-ID: <97ccfa67-05c3-2c56-7710-e8e308074bf8@redhat.com>
Date: Fri, 25 Sep 2020 14:34:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200924152717.287415-22-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MsXMHR1y39YAaka7W1MpPvYZeFM2QngQZ"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.238, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MsXMHR1y39YAaka7W1MpPvYZeFM2QngQZ
Content-Type: multipart/mixed; boundary="VNIlVkunwYBqCtPrAg2mjlqGA9kFNlBsv"

--VNIlVkunwYBqCtPrAg2mjlqGA9kFNlBsv
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 24.09.20 17:27, Kevin Wolf wrote:
> Clients may want to know when an export has finally disappeard
> (block-export-del returns earlier than that in the general case), so add
> a QAPI event for it.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-export.json     | 12 ++++++++++++
>  block/export/export.c      |  2 ++
>  tests/qemu-iotests/140     |  9 ++++++++-
>  tests/qemu-iotests/140.out |  2 +-
>  tests/qemu-iotests/223.out |  4 ++++
>  5 files changed, 27 insertions(+), 2 deletions(-)

[...]

> diff --git a/tests/qemu-iotests/140 b/tests/qemu-iotests/140
> index 8d2ce5d9e3..309b177e77 100755
> --- a/tests/qemu-iotests/140
> +++ b/tests/qemu-iotests/140
> @@ -81,10 +81,17 @@ $QEMU_IO_PROG -f raw -r -c 'read -P 42 0 64k' \
>      "nbd+unix:///drv?socket=3D$SOCK_DIR/nbd" 2>&1 \
>      | _filter_qemu_io | _filter_nbd
> =20
> +# The order of 'return' and the BLOCK_EXPORT_DELETED event is undefined.=
 Just
> +# wait until we've twice seen one of them. Filter the 'return' line out =
so that
> +# the output is defined.
>  _send_qemu_cmd $QEMU_HANDLE \
>      "{ 'execute': 'eject',
>         'arguments': { 'device': 'drv' }}" \
> -    'return'
> +    'return\|BLOCK_EXPORT_DELETED' |
> +    grep -v 'return'
> +
> +_send_qemu_cmd $QEMU_HANDLE '' 'return\|BLOCK_EXPORT_DELETED' |
> +    grep -v 'return'

Funny.  I did basically the same thing (only I filtered the event, not
the return):

https://git.xanclic.moe/XanClic/qemu/commit/e6f7510149a4a26c868013639ec89d2=
8f16857d8#diff-3

and considered it kind of a hack.

Oh well. :)

Reviewed-by: Max Reitz <mreitz@redhat.com>

>  $QEMU_IO_PROG -f raw -r -c close \
>      "nbd+unix:///drv?socket=3D$SOCK_DIR/nbd" 2>&1 \


--VNIlVkunwYBqCtPrAg2mjlqGA9kFNlBsv--

--MsXMHR1y39YAaka7W1MpPvYZeFM2QngQZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9t498ACgkQ9AfbAGHV
z0CSvQf/T8d5pgLYT7P5Pu7d+qBQiz0408JA1na4JIkfVcx3pFE3S1B8y7tKyu8H
OefIHO2NwC9jyvSmalz0MujCnhjCfgEs9c3hmHuHnLfxV3swMY+ZW0vg+6wkprad
dz56cZdxtU199UYMzzommnp6ezmpdwtsFUTa0U7no+aqm8qc/syByqOyB17WYB9X
o+gN2VnBeC3816mJpJxGWGc8+ITPbb8p74f2uBtGYnzKSXHfOuPlr0gdChpq6D5/
6EsI9f66MbCeLBbHRcsJXQ5onLejG+sRTees73xDTXkHODEQIOyvpBT9xtbogQZ0
Aj1+7HiKgIG9fGp3VFD8DOppssbzEg==
=rDSV
-----END PGP SIGNATURE-----

--MsXMHR1y39YAaka7W1MpPvYZeFM2QngQZ--


