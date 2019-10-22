Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4CACA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 09:29:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5572A2064B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 09:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eVjIdfDs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5572A2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMqU7-0005V4-Gu
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 05:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54164)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iMqT3-0004Qr-Hu
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:28:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iMqT2-0002im-EL
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:28:41 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35657
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iMqT2-0002ht-9N
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:28:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571736518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=EQR9nG4elJz+4QBIcXjW+L7/ihX1GDQURAjCVrYlfC8=;
 b=eVjIdfDs2xmLnQfZq6QkZcEeg+GF3Ir1JbEHiPok1/71vl0idKivBU1WjfnTKMJ0Y8rztK
 3lqOxsM5X+0ZrCJ/IEKD+YoTc1TXqh8Cpw3Hwdp//QuQwwj1PIoD3RmYx6AEGwvUASwfom
 LuZNbGqgaaDayCVFIwiI8fv1SgmM8Ys=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-jhbhz5-ZMyqJTNYsZbPJvg-1; Tue, 22 Oct 2019 05:28:36 -0400
X-MC-Unique: jhbhz5-ZMyqJTNYsZbPJvg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 299B6476;
 Tue, 22 Oct 2019 09:28:34 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-215.ams2.redhat.com
 [10.36.117.215])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 65A345DE5B;
 Tue, 22 Oct 2019 09:28:29 +0000 (UTC)
Subject: Re: [PATCH v5 1/4] block: support compressed write at generic layer
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <1571603828-185910-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1571603828-185910-2-git-send-email-andrey.shinkevich@virtuozzo.com>
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
Message-ID: <408ef2ab-1f6c-2c9f-ad50-92269c20fb27@redhat.com>
Date: Tue, 22 Oct 2019 11:28:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1571603828-185910-2-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="PWMb4ANxS6m6ixz3dh6bEPayGQxa0TtMM"
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 armbru@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PWMb4ANxS6m6ixz3dh6bEPayGQxa0TtMM
Content-Type: multipart/mixed; boundary="YnjNuAkRS1GPyADfgxoltB5BdrVBvl4VT"

--YnjNuAkRS1GPyADfgxoltB5BdrVBvl4VT
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 20.10.19 22:37, Andrey Shinkevich wrote:
> To inform the block layer about writing all the data compressed, we
> introduce the 'compress' command line option. Based on that option, the
> written data will be aligned by the cluster size at the generic layer.
>=20
> Suggested-by: Roman Kagan <rkagan@virtuozzo.com>
> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block.c                   | 20 +++++++++++++++++++-
>  block/io.c                | 13 +++++++++----
>  block/qcow2.c             |  4 ++++
>  blockdev.c                |  9 ++++++++-
>  include/block/block.h     |  1 +
>  include/block/block_int.h |  2 ++
>  qapi/block-core.json      |  5 ++++-
>  qemu-options.hx           |  6 ++++--
>  8 files changed, 51 insertions(+), 9 deletions(-)

The problem with compression is that there are such tight constraints on
it that it can really only work for very defined use cases.  Those
constraints are:

- Only write whole clusters,
- Clusters can be written to only once.

The first point is addressed in this patch by setting request_alignment.
 But I don=E2=80=99t see how the second one can be addressed.  Well, maybe =
by
allowing it in all drivers that support compression.  But if I just look
at qcow2, that isn=E2=80=99t going to be trivial: You need to allocate a
completely new cluster where you write the data (in case it grows), and
thus you leave behind a hole, which kind of defeats the purpose of
compression.

(For demonstration:

$ ./qemu-img create -f qcow2 test.qcow2 64M
Formatting 'test.qcow2', fmt=3Dqcow2 size=3D67108864 cluster_size=3D65536
lazy_refcounts=3Doff refcount_bits=3D16
$ x86_64-softmmu/qemu-system-x86_64 \
    -blockdev "{'node-name': 'drv0', 'driver': 'qcow2',
                'compress': true,
                'file': {'driver': 'file', 'filename': 'test.qcow2'}}" \
    -monitor stdio
QEMU 4.1.50 monitor - type 'help' for more information
(qemu) qemu-io drv0 "write -P 42 0 64k"
wrote 65536/65536 bytes at offset 0
64 KiB, 1 ops; 00.02 sec (4.055 MiB/sec and 64.8793 ops/sec)
(qemu) qemu-io drv0 "write -P 23 0 64k"
write failed: Input/output error

)

Compression really only works when you fully write all of an image
exactly once; i.e. as the qemu-img convert or as a backup target.  For
both cases we already have a compression option.  So I=E2=80=99m wondering =
where
this new option is really useful.

(You do add a test for stream, but I don=E2=80=99t know whether that=E2=80=
=99s really a
good example, see my response there.)

Max


--YnjNuAkRS1GPyADfgxoltB5BdrVBvl4VT--

--PWMb4ANxS6m6ixz3dh6bEPayGQxa0TtMM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2uy7wACgkQ9AfbAGHV
z0BRrggAiuA7CbJH3w0BnvVDSkvEh4TUeO+/dWH7siApjaT4MAFswz54YklVEDhD
INdNQnMqJabbjacSKDBpZlHBTZ+/+vJ7gKMh5Maa8A0oT7VTVMxI3kXpexrieAIb
+DKfscmHafaqv2F1hFxHVbnRfXZdN6L+K0q1xMsXSO+Qc371oDDVNIuMHMhW7byc
qL48KoaMqrE33FKsPix+ezxgOfXPnVM1Qylr9qkRVOd92jebTzJTYdfmnOlZc7Ad
bsFIqMtb5dEKgq7jYrvYF5hlM9H8juVWySfsEPX5IpqsiMDx2DYfpCm+a59YCT8D
w4tCBVYPu2ya40T3l9ugNK+sCgtnog==
=j8Hc
-----END PGP SIGNATURE-----

--PWMb4ANxS6m6ixz3dh6bEPayGQxa0TtMM--


