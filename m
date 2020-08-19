Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89389C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 14:49:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 367862083B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 14:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bGchlP9g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 367862083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8PPM-0006T4-C4
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 10:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k8POj-0005jh-Dp
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 10:49:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30078)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k8POh-0003kn-DK
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 10:49:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597848542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QD4+MwQRKRFDE1kdCzASjArjtxdwisiXqmByKhI3HZE=;
 b=bGchlP9gd+J9QOL8FLf3exwphWSJYPgVufwCTcF0R8UKblYZVjVcmyr4+mXVZjun3DVttg
 Zhr9qmwuxY0vqzQ95Xt/+dZa6WORuO3kvEj1WKqhJWoY/vltoMY3NHiAN5kXdtTzpjqBHp
 UI1LBrEU9x3sNz7RbXchmsxhToPJuD8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-UlP2V-djPDGExWFCLNe9KA-1; Wed, 19 Aug 2020 10:48:59 -0400
X-MC-Unique: UlP2V-djPDGExWFCLNe9KA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DAB6D1015DCB;
 Wed, 19 Aug 2020 14:48:58 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-120.ams2.redhat.com
 [10.36.113.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CF13959;
 Wed, 19 Aug 2020 14:48:57 +0000 (UTC)
Subject: Re: [RFC PATCH 19/22] block/export: Move strong user reference to
 block_exports
To: Kevin Wolf <kwolf@redhat.com>
References: <20200813162935.210070-1-kwolf@redhat.com>
 <20200813162935.210070-20-kwolf@redhat.com>
 <5bdf307f-0d1e-b64c-978f-c9075a3e2eb0@redhat.com>
 <20200819142300.GD10272@linux.fritz.box>
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
Message-ID: <31aaea72-8352-145f-7f17-995b6cfe0e23@redhat.com>
Date: Wed, 19 Aug 2020 16:48:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200819142300.GD10272@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="v113ZkLpjYGrrHDyhieuA1PEbjOEmzQlq"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 06:57:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--v113ZkLpjYGrrHDyhieuA1PEbjOEmzQlq
Content-Type: multipart/mixed; boundary="FlxPdpppbH9uAHXo3ESAoB9Wl5XH5w4N9"

--FlxPdpppbH9uAHXo3ESAoB9Wl5XH5w4N9
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 19.08.20 16:23, Kevin Wolf wrote:
> Am 19.08.2020 um 13:56 hat Max Reitz geschrieben:
>> On 13.08.20 18:29, Kevin Wolf wrote:
>>> The reference owned by the user/monitor that is created when adding the
>>> export and dropped when removing it was tied to the 'exports' list in
>>> nbd/server.c. Every block export will have a user reference, so move it
>>> to the block export level and tie it to the 'block_exports' list in
>>> block/export/export.c instead. This is necessary for introducing a QMP
>>> command for removing exports.
>>>
>>> Note that exports are present in block_exports even after the user has
>>> requested shutdown. This is different from NBD's exports where exports
>>> are immediately removed on a shutdown request, even if they are still i=
n
>>> the process of shutting down. In order to avoid that the user still
>>> interacts with an export that is shutting down (and possibly removes it
>>> a second time), we need to remember if the user actually still owns it.
>>>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>>  include/block/export.h | 8 ++++++++
>>>  block/export/export.c  | 4 ++++
>>>  blockdev-nbd.c         | 5 -----
>>>  nbd/server.c           | 2 --
>>>  4 files changed, 12 insertions(+), 7 deletions(-)
>>
>> With this patch, there=E2=80=99s an abort in iotest 281.  Perhaps becaus=
e
>> blk_exp_unref() is now done by blk_exp_request_shutdown() outside of
>> where the AIO context is locked?
>=20
> I have two fixes locally that were related to failing qemu-iotests. I
> guess the first one might be for what you're seeing?
>=20
> Kevin
>=20
> diff --git a/block/export/export.c b/block/export/export.c
> index 71d17bd440..d021b98b74 100644
> --- a/block/export/export.c
> +++ b/block/export/export.c
> @@ -105,9 +105,14 @@ void blk_exp_unref(BlockExport *exp)
>  {
>      assert(exp->refcount > 0);
>      if (--exp->refcount =3D=3D 0) {

If this is done without locking the context, should this be an atomic
operation?

> +        AioContext *aio_context =3D exp->ctx;
> +
> +        aio_context_acquire(aio_context);
>          QLIST_REMOVE(exp, next);
>          exp->drv->delete(exp);
>          blk_unref(exp->blk);
> +        aio_context_release(aio_context);
> +

But for the crash I was seeing, this should be sufficient, yes.

Max


--FlxPdpppbH9uAHXo3ESAoB9Wl5XH5w4N9--

--v113ZkLpjYGrrHDyhieuA1PEbjOEmzQlq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl89O9gACgkQ9AfbAGHV
z0CdXwf/Xeyvevz9X5PAt7jt+bOsHGbJZ5PwGxxJJw4BJedVgI50d0ADfTLM7l9H
hF4d3J7eDLcJeiS3r0/2kvJ1jRe1HFiSikD2DQx/iwmq+Y8uPkAdNANnOZOLRRrz
ME+7tybLsFdckGEuKnheOgqYv4+2RQJDhCBWlY3k+M2t8rNzT5dtng4v31t0HgjZ
v2a2zSIBf+fxT83erXKqbYXe0ozIJ+i5m8onlmTYA9wKQ9+BWGyXK9vBAOFqljIO
qOiJ2gDGRc/4i+kokn+ldirhUQBm4TCWEPuNeIyXij3u6/MjEfas4wBfRG7ou9cu
DF0ZuuBPEpw2f6ByUp9tIkkoVRRSfw==
=oyIA
-----END PGP SIGNATURE-----

--v113ZkLpjYGrrHDyhieuA1PEbjOEmzQlq--


