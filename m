Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 406DBC83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:51:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 094822076B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ju2iB54J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 094822076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jThUo-0001uH-7c
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 03:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48108)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jThJs-0004ja-Rn
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:39:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jThJr-0005Ea-Jk
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:39:48 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55626
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jThJr-0005EH-4Z
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588145986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=j8rSc3GxOznaNlzTU3yZnFsa1fJOX3HQTZ2C/iBYQFw=;
 b=Ju2iB54J/2KvAoaZmo8jC1FejwTTHtPEm/LFrJdeTSAW2ArmWdwQ2biAgYfwqqzwwP1+DX
 374tVP7OUQQIoL/EhMtb9+G22KWw7oCnrDiVvHFSpWw8r8sgwLn+WulMxKXvs5wTQ2VQ5U
 z/JByaEClaFqUGM42tn8qUi5tWPwy0o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38--DmRtkI2Nbu9kAG0n9I-vg-1; Wed, 29 Apr 2020 03:39:43 -0400
X-MC-Unique: -DmRtkI2Nbu9kAG0n9I-vg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1A398014D9;
 Wed, 29 Apr 2020 07:39:42 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-19.ams2.redhat.com
 [10.36.113.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BEF195D9E5;
 Wed, 29 Apr 2020 07:39:41 +0000 (UTC)
Subject: Re: [PATCH 1/4] block: Add bdrv_make_empty()
To: Kevin Wolf <kwolf@redhat.com>
References: <20200428132629.796753-1-mreitz@redhat.com>
 <20200428132629.796753-2-mreitz@redhat.com>
 <20200428142104.GI5789@linux.fritz.box>
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
Message-ID: <a638f036-dd2e-cda2-11b4-c3b15ea8eff0@redhat.com>
Date: Wed, 29 Apr 2020 09:39:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428142104.GI5789@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JELVLaOGRUFLtAwhRmeBpjGTYFhvsltma"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 00:53:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
--JELVLaOGRUFLtAwhRmeBpjGTYFhvsltma
Content-Type: multipart/mixed; boundary="KuoTs7hNC8rCu5jabmJajhuoq1Qemz58b"

--KuoTs7hNC8rCu5jabmJajhuoq1Qemz58b
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 28.04.20 16:21, Kevin Wolf wrote:
> Am 28.04.2020 um 15:26 hat Max Reitz geschrieben:
>> Right now, all users of bdrv_make_empty() call the BlockDriver method
>> directly.  That is not only bad style, it is also wrong, unless the
>> caller has a BdrvChild with a WRITE permission.
>>
>> Introduce bdrv_make_empty() that verifies that it does.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  include/block/block.h |  1 +
>>  block.c               | 23 +++++++++++++++++++++++
>>  2 files changed, 24 insertions(+)
>>
>> diff --git a/include/block/block.h b/include/block/block.h
>> index b05995fe9c..d947fb4080 100644
>> --- a/include/block/block.h
>> +++ b/include/block/block.h
>> @@ -351,6 +351,7 @@ BlockMeasureInfo *bdrv_measure(BlockDriver *drv, Qem=
uOpts *opts,
>>  void bdrv_get_geometry(BlockDriverState *bs, uint64_t *nb_sectors_ptr);
>>  void bdrv_refresh_limits(BlockDriverState *bs, Error **errp);
>>  int bdrv_commit(BlockDriverState *bs);
>> +int bdrv_make_empty(BdrvChild *c, Error **errp);
>>  int bdrv_change_backing_file(BlockDriverState *bs,
>>      const char *backing_file, const char *backing_fmt);
>>  void bdrv_register(BlockDriver *bdrv);
>> diff --git a/block.c b/block.c
>> index 2e3905c99e..b0d5b98617 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -6791,3 +6791,26 @@ void bdrv_del_child(BlockDriverState *parent_bs, =
BdrvChild *child, Error **errp)
>> =20
>>      parent_bs->drv->bdrv_del_child(parent_bs, child, errp);
>>  }
>> +
>> +int bdrv_make_empty(BdrvChild *c, Error **errp)
>> +{
>> +    BlockDriver *drv =3D c->bs->drv;
>> +    int ret;
>> +
>> +    assert(c->perm & BLK_PERM_WRITE);
>=20
> If I understand correctly, bdrv_make_empty() is called to drop an
> overlay whose content is identical to what it would read from its
> backing file (in particular after a commit operation). This means that
> the caller promises that the visible content doesn't change.
>=20
> So should we check BLK_PERM_WRITE_UNCHANGED instead?

Ah, right.  Yes, that would be better.  (Or to check both, whether any
of them has been taken.)

Max


--KuoTs7hNC8rCu5jabmJajhuoq1Qemz58b--

--JELVLaOGRUFLtAwhRmeBpjGTYFhvsltma
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6pLzsACgkQ9AfbAGHV
z0D/bAf7BceJHRlYifeCSsI/PoUyGXfv5/gXVSIf4TjHaef5dnxNtxrBz56ZjOOc
0pMGOQkAbfHn9CKejuZaQYIJG9OxbH8EuIPO1gq6yhzqQSNsxu1Q9H6WgVLTZZ8b
drxjaAoo2YtxxN1BifzIL7O7mz7uLBgpaN6lxXXw3+ANvlYt5b3zqIGbeodKS7cG
0GkOjJBKtA02HPbUmtLdbeKxhEtbdNIBE/3DS/fad02qoQA8wxjkRiMdv48R+TrE
VW5IuAqwV9tJ2lzdaacgB8OlH5w8V1l2tWFUY6Ro3p0WvO4gb3XxaTvOGcSVu2cT
rVORXdvNNdDpQjKgq9Yft3hxrP2VWw==
=G1I7
-----END PGP SIGNATURE-----

--JELVLaOGRUFLtAwhRmeBpjGTYFhvsltma--


