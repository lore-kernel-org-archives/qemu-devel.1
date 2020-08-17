Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FDFC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:16:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D44C0205CB
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LrIgyaGv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D44C0205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gsM-0007KI-Ue
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k7gHo-0005pz-3w
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25147
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k7gHm-0006IY-4J
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597675133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9KTq3jSspk152+JLwn2pfpCzjwJCiLCT5V7Zc54WRcQ=;
 b=LrIgyaGvvre5xVuNIcCegZs+9guX4pDNqouzGUx+P4MfOxKcZhsi+8uzIZAhdLDHfw/NXA
 ozm8HwmabVPaqU0YB/OKX0/PMQ0VXOHWZlHigySPFznc3nQYCv9LFOG5q6dpwuOZzBUJ29
 ykmacb+63cX99uOkjfu4hC/0NGVmJuQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-XTVN4asXPoCJstRoJZ4WMg-1; Mon, 17 Aug 2020 10:38:49 -0400
X-MC-Unique: XTVN4asXPoCJstRoJZ4WMg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1D28100CECB;
 Mon, 17 Aug 2020 14:38:48 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-146.ams2.redhat.com
 [10.36.113.146])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9DCFA5D9D2;
 Mon, 17 Aug 2020 14:38:47 +0000 (UTC)
Subject: Re: [RFC PATCH 11/22] qemu-nbd: Use blk_exp_add() to create the export
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200813162935.210070-1-kwolf@redhat.com>
 <20200813162935.210070-12-kwolf@redhat.com>
 <d9d9ce92-291b-7e25-bc32-c0d899e73842@redhat.com>
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
Message-ID: <f106ea79-71eb-e960-59d8-683a9ffd1db7@redhat.com>
Date: Mon, 17 Aug 2020 16:38:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d9d9ce92-291b-7e25-bc32-c0d899e73842@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hX33YpkrMHurNpMiucXDHDFjXsGQYKSjQ"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 05:13:21
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
--hX33YpkrMHurNpMiucXDHDFjXsGQYKSjQ
Content-Type: multipart/mixed; boundary="Ytmp7e0DTHtiqHUs6vxDVhb6dwZitVcz5"

--Ytmp7e0DTHtiqHUs6vxDVhb6dwZitVcz5
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17.08.20 16:27, Max Reitz wrote:
> On 13.08.20 18:29, Kevin Wolf wrote:
>> With this change, NBD exports are only created through the BlockExport
>> interface any more. This allows us finally to move things from the NBD
>> layer to the BlockExport layer if they make sense for other export
>> types, too.
>=20
> I see.
>=20
>> blk_exp_add() returns only a weak reference, so the explicit
>> nbd_export_put() goes away.
>>
>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> ---
>>  include/block/export.h |  2 ++
>>  include/block/nbd.h    |  1 +
>>  block/export/export.c  |  2 +-
>>  blockdev-nbd.c         |  8 +++++++-
>>  qemu-nbd.c             | 28 ++++++++++++++++++++++------
>>  5 files changed, 33 insertions(+), 8 deletions(-)
>=20
> [...]
>=20
>> diff --git a/blockdev-nbd.c b/blockdev-nbd.c
>> index d5b084acc2..8dd127af52 100644
>> --- a/blockdev-nbd.c
>> +++ b/blockdev-nbd.c
>=20
> [...]
>=20
>> @@ -176,7 +182,7 @@ BlockExport *nbd_export_create(BlockExportOptions *e=
xp_args, Error **errp)
>> =20
>>      assert(exp_args->type =3D=3D BLOCK_EXPORT_TYPE_NBD);
>> =20
>> -    if (!nbd_server) {
>> +    if (!nbd_server && !is_qemu_nbd) {
>=20
> (This begs the question of how difficult it would be to let qemu-nbd use
> QMP=E2=80=99s nbd-server-start, but I will not ask it, for I fear the ans=
wer.)
>=20
>>          error_setg(errp, "NBD server not running");
>>          return NULL;
>>      }
>> diff --git a/qemu-nbd.c b/qemu-nbd.c
>> index 48aa8a9d46..d967b8fcb9 100644
>> --- a/qemu-nbd.c
>> +++ b/qemu-nbd.c
>=20
> [...]
>=20
>> @@ -1050,9 +1050,27 @@ int main(int argc, char **argv)
>> =20
>>      bs->detect_zeroes =3D detect_zeroes;
>> =20
>> -    export =3D nbd_export_new(bs, export_name,
>> -                            export_description, bitmap, readonly, share=
d > 1,
>> -                            writethrough, &error_fatal);
>> +    nbd_server_is_qemu_nbd(true);
>> +
>> +    export_opts =3D g_new(BlockExportOptions, 1);
>> +    *export_opts =3D (BlockExportOptions) {
>> +        .type               =3D BLOCK_EXPORT_TYPE_NBD,
>> +        .has_writethrough   =3D true,
>> +        .writethrough       =3D writethrough,
>> +        .u.nbd =3D {
>> +            .device             =3D g_strdup(bdrv_get_node_name(bs)),
>> +            .has_name           =3D true,
>> +            .name               =3D g_strdup(export_name),
>> +            .has_description    =3D !!export_description,
>> +            .description        =3D g_strdup(export_description),
>> +            .has_writable       =3D true,
>> +            .writable           =3D !readonly,
>> +            .has_bitmap         =3D !!bitmap,
>> +            .bitmap             =3D g_strdup(bitmap),
>> +        },
>> +    };
>> +    blk_exp_add(export_opts, &error_fatal);
>=20
> Why not use the already-global qmp_block_export_add(), if we don=E2=80=99=
t need
> the return value here?  (Will we require it at some point?)

In the context of patch 13, which adds more blk_exp_* functions, it
makes sense to make blk_exp_add() global, and then to use it here.  So:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--Ytmp7e0DTHtiqHUs6vxDVhb6dwZitVcz5--

--hX33YpkrMHurNpMiucXDHDFjXsGQYKSjQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl86lnYACgkQ9AfbAGHV
z0Ag5Af+JlrwSUPsrpSimdue9mmKmwmKZbb2fILRJ++qvm5OThSa5i/34gTM+GOL
O+JlxdWBfrSi0vuUf9M+HkyT+eY80HVnONu6apyAT8kQ24FozCaP2echb0RsxbOG
z+cgQV2tI0CTWazij76LWDdOBX2nuME50IwE5Snl9nibFkEN6cPSGxAWp6+r/McQ
3UgwzgGeY3AYcz9XRTaPDx6nEirQfNrmLRgnazK5nJ1RSdDnaRrTqok4qjt3dPQC
1XJzIaEWQxHcF7FwQT5oTo5w6Iv1D8XTmybDx0QLkWkaKDEJgpDHFHCp3zFyE2Mf
nOw3m8TTZQRFAGks2Ymsr9lcs+pUpQ==
=zAYf
-----END PGP SIGNATURE-----

--hX33YpkrMHurNpMiucXDHDFjXsGQYKSjQ--


