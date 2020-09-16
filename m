Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461ADC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 14:58:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9613822287
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 14:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EJOcMeW+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9613822287
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIYtT-0005Hu-Pd
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 10:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kIYsY-0004qB-0Y
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 10:57:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52830)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kIYsV-0001JU-Kn
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 10:57:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600268265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=R2ZPZnCUSqmr6NU6VJA8+dmE/QbJt+ZH89qRnKiLQ6A=;
 b=EJOcMeW+l9NHptjZT37awsFwJyUWNjhsFxkMZ95Uad57fNRG5JKnYgsjH+S8b0dcjxjWmn
 ADy9TgORnUnQkC+WTrUa3sdsN6YOuwYCC7NxYS55VBmy7M2C9pKSi+U7EHbRJgCk9EOKX6
 VZThPWdcuInjP8qa88RW/H+ACKgw9o4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-9QwGSsegOA2cNzthhRmdww-1; Wed, 16 Sep 2020 10:57:43 -0400
X-MC-Unique: 9QwGSsegOA2cNzthhRmdww-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0CD16894C0E;
 Wed, 16 Sep 2020 14:57:39 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-111.ams2.redhat.com
 [10.36.112.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 870318BD73;
 Wed, 16 Sep 2020 14:57:37 +0000 (UTC)
Subject: Re: [PATCH 21/29] block/export: Add BLOCK_EXPORT_DELETED event
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200907182011.521007-1-kwolf@redhat.com>
 <20200907182011.521007-22-kwolf@redhat.com>
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
Message-ID: <1040a85b-61b7-f468-22b9-f132778f0f97@redhat.com>
Date: Wed, 16 Sep 2020 16:57:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200907182011.521007-22-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NopbSA9C7qtkDGXXWiXo4ZPhyR4EBO5uy"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:35:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.062, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NopbSA9C7qtkDGXXWiXo4ZPhyR4EBO5uy
Content-Type: multipart/mixed; boundary="SF2QowxVK5HUKeYBGdjHf0CyGINb4z6Sd"

--SF2QowxVK5HUKeYBGdjHf0CyGINb4z6Sd
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07.09.20 20:20, Kevin Wolf wrote:
> Clients may want to know when an export has finally disappeard
> (block-export-del returns earlier than that in the general case), so add
> a QAPI event for it.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-export.json     | 12 ++++++++++++
>  block/export/export.c      |  2 ++
>  tests/qemu-iotests/140.out |  1 +
>  tests/qemu-iotests/223.out |  4 ++++
>  4 files changed, 19 insertions(+)
>=20
> diff --git a/qapi/block-export.json b/qapi/block-export.json
> index 77a6b595e8..dac3250f08 100644
> --- a/qapi/block-export.json
> +++ b/qapi/block-export.json
> @@ -233,3 +233,15 @@
>  ##
>  { 'command': 'block-export-del',
>    'data': { 'id': 'str', '*mode': 'BlockExportRemoveMode' } }
> +
> +##
> +# @BLOCK_EXPORT_DELETED:
> +#
> +# Emitted when a block export is removed and it's id can be reused.
> +#
> +# @id: Block export id.
> +#
> +# Since: 5.2
> +##
> +{ 'event': 'BLOCK_EXPORT_DELETED',
> +  'data': { 'id': 'str' } }
> diff --git a/block/export/export.c b/block/export/export.c
> index 4af3b69186..ae7879e6a9 100644
> --- a/block/export/export.c
> +++ b/block/export/export.c
> @@ -19,6 +19,7 @@
>  #include "block/nbd.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-block-export.h"
> +#include "qapi/qapi-events-block-export.h"
>  #include "qemu/id.h"
> =20
>  static const BlockExportDriver *blk_exp_drivers[] =3D {
> @@ -113,6 +114,7 @@ static void blk_exp_delete_bh(void *opaque)
>      assert(exp->refcount =3D=3D 0);
>      QLIST_REMOVE(exp, next);
>      exp->drv->delete(exp);
> +    qapi_event_send_block_export_deleted(exp->id);
>      g_free(exp->id);
>      g_free(exp);
> =20
> diff --git a/tests/qemu-iotests/140.out b/tests/qemu-iotests/140.out
> index 86b985da75..f1db409b26 100644
> --- a/tests/qemu-iotests/140.out
> +++ b/tests/qemu-iotests/140.out
> @@ -15,6 +15,7 @@ read 65536/65536 bytes at offset 0
>  qemu-io: can't open device nbd+unix:///drv?socket=3DSOCK_DIR/nbd: Reques=
ted export not available
>  server reported: export 'drv' not present
>  { 'execute': 'quit' }
> +{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "BLOCK_EXPORT_DELETED", "data": {"id": "drv"}}
>  {"return": {}}
>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
>  *** done

With -qed, this event appears immediately when the drive is ejected, so
this test now fails (for qed).

I=E2=80=99m not sure whether there=E2=80=99s much of a point in fixing it o=
r just
marking qed as unsupported.

Max


--SF2QowxVK5HUKeYBGdjHf0CyGINb4z6Sd--

--NopbSA9C7qtkDGXXWiXo4ZPhyR4EBO5uy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9iJ98ACgkQ9AfbAGHV
z0DWngf+Pr3EpQIw0fwFw8F9Zpl9gjCy60NufP4GQMTZPC5d8Un6EfWdJzsFk8kZ
rJcpWjJPkiLmRBzw67VfgX+wyf+K03xLv0xWOTzqvkqU2wt6HmcAZOUGy/eiFU2z
+SRJVHFI0oQabB8p7+mYMNrzYMzyXSQLhlWcVgvRVyPUVJxXxhfDDQ/bGW/yUt3y
Z6AQO6EBIwg/Tm6DBQusQt4SKhe2RZlBYf4RAYsx3MBKdGtX55c+u1biEvq71zLO
0OcwvmA97tJR05Y7V6SYBJZ2sH4x9hJomXCezbgjvb9ueJxHtKz4UL0cMUjtVPWU
21chjkSKLunZytnP7YHaEO9BvEkx8w==
=8SVd
-----END PGP SIGNATURE-----

--NopbSA9C7qtkDGXXWiXo4ZPhyR4EBO5uy--


