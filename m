Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36269C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 09:11:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0121A2064C
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 09:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ow0c04LN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0121A2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is1Bj-00014Z-6S
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 04:11:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35757)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1is1Aq-0000GV-En
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 04:10:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1is1Am-0001MM-8T
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 04:10:43 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59985
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1is1Am-0001Lh-2Z
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 04:10:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579165839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Bva73YP6DNxiNKQeA09b5kpvaqYZrKgXKa5wFyEtfco=;
 b=Ow0c04LNdPfxWwKAnT3x7HMCKnNSbLb7IHgxY7H8URyx+mmfgyTFRJPZgk1aX2+aMbIkla
 M4ys5+RG07ISlr2+gd7B0xhbbrnNCaEZW7zjGB3w+vntnTx+KeETZCM5iRMQK0dbN5Ahdo
 D5afuFfxPNh7XBVgutD+sh2ucM5CANU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-Zt-WYr_7M4OwBkHJ5WDDYA-1; Thu, 16 Jan 2020 04:10:35 -0500
X-MC-Unique: Zt-WYr_7M4OwBkHJ5WDDYA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 559FCDB2E;
 Thu, 16 Jan 2020 09:10:34 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.11])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3BEF719C5B;
 Thu, 16 Jan 2020 09:10:32 +0000 (UTC)
Subject: Re: [PATCH] block: fix memleaks in bdrv_refresh_filename
To: pannengyuan@huawei.com, kwolf@redhat.com
References: <20200116085600.24056-1-pannengyuan@huawei.com>
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
Message-ID: <9ef64172-aa0f-b73f-56dc-e187141276ac@redhat.com>
Date: Thu, 16 Jan 2020 10:10:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200116085600.24056-1-pannengyuan@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Jjb3XvWYFlzI2ajLnIB09DkuEUXRcqFk0"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Euler Robot <euler.robot@huawei.com>, zhang.zhanghailiang@huawei.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Jjb3XvWYFlzI2ajLnIB09DkuEUXRcqFk0
Content-Type: multipart/mixed; boundary="2cn3yq25aBjdzX7DnyklJ9wescY20yMfy"

--2cn3yq25aBjdzX7DnyklJ9wescY20yMfy
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 16.01.20 09:56, pannengyuan@huawei.com wrote:
> From: Pan Nengyuan <pannengyuan@huawei.com>
>=20
> If we call the qmp 'query-block' while qemu is working on
> 'block-commit', it will cause memleaks, the memory leak stack is as
> follow:
>=20
> Indirect leak of 12360 byte(s) in 3 object(s) allocated from:
>     #0 0x7f80f0b6d970 in __interceptor_calloc (/lib64/libasan.so.5+0xef97=
0)
>     #1 0x7f80ee86049d in g_malloc0 (/lib64/libglib-2.0.so.0+0x5249d)
>     #2 0x55ea95b5bb67 in qdict_new /mnt/sdb/qemu-4.2.0-rc0/qobject/qdict.=
c:29
>     #3 0x55ea956cd043 in bdrv_refresh_filename /mnt/sdb/qemu-4.2.0-rc0/bl=
ock.c:6427
>     #4 0x55ea956cc950 in bdrv_refresh_filename /mnt/sdb/qemu-4.2.0-rc0/bl=
ock.c:6399
>     #5 0x55ea956cc950 in bdrv_refresh_filename /mnt/sdb/qemu-4.2.0-rc0/bl=
ock.c:6399
>     #6 0x55ea956cc950 in bdrv_refresh_filename /mnt/sdb/qemu-4.2.0-rc0/bl=
ock.c:6399
>     #7 0x55ea958818ea in bdrv_block_device_info /mnt/sdb/qemu-4.2.0-rc0/b=
lock/qapi.c:56
>     #8 0x55ea958879de in bdrv_query_info /mnt/sdb/qemu-4.2.0-rc0/block/qa=
pi.c:392
>     #9 0x55ea9588b58f in qmp_query_block /mnt/sdb/qemu-4.2.0-rc0/block/qa=
pi.c:578
>     #10 0x55ea95567392 in qmp_marshal_query_block qapi/qapi-commands-bloc=
k-core.c:95
>=20
> Indirect leak of 4120 byte(s) in 1 object(s) allocated from:
>     #0 0x7f80f0b6d970 in __interceptor_calloc (/lib64/libasan.so.5+0xef97=
0)
>     #1 0x7f80ee86049d in g_malloc0 (/lib64/libglib-2.0.so.0+0x5249d)
>     #2 0x55ea95b5bb67 in qdict_new /mnt/sdb/qemu-4.2.0-rc0/qobject/qdict.=
c:29
>     #3 0x55ea956cd043 in bdrv_refresh_filename /mnt/sdb/qemu-4.2.0-rc0/bl=
ock.c:6427
>     #4 0x55ea956cc950 in bdrv_refresh_filename /mnt/sdb/qemu-4.2.0-rc0/bl=
ock.c:6399
>     #5 0x55ea956cc950 in bdrv_refresh_filename /mnt/sdb/qemu-4.2.0-rc0/bl=
ock.c:6399
>     #6 0x55ea9569f301 in bdrv_backing_attach /mnt/sdb/qemu-4.2.0-rc0/bloc=
k.c:1064
>     #7 0x55ea956a99dd in bdrv_replace_child_noperm /mnt/sdb/qemu-4.2.0-rc=
0/block.c:2283
>     #8 0x55ea956b9b53 in bdrv_replace_node /mnt/sdb/qemu-4.2.0-rc0/block.=
c:4196
>     #9 0x55ea956b9e49 in bdrv_append /mnt/sdb/qemu-4.2.0-rc0/block.c:4236
>     #10 0x55ea958c3472 in commit_start /mnt/sdb/qemu-4.2.0-rc0/block/comm=
it.c:306
>     #11 0x55ea94b68ab0 in qmp_block_commit /mnt/sdb/qemu-4.2.0-rc0/blockd=
ev.c:3459
>     #12 0x55ea9556a7a7 in qmp_marshal_block_commit qapi/qapi-commands-blo=
ck-core.c:407
>=20
> Fixes: bb808d5f5c0978828a974d547e6032402c339555
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---
>  block.c | 1 +
>  1 file changed, 1 insertion(+)

Thanks, applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--2cn3yq25aBjdzX7DnyklJ9wescY20yMfy--

--Jjb3XvWYFlzI2ajLnIB09DkuEUXRcqFk0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl4gKIUACgkQ9AfbAGHV
z0C+aQf/cceaCSN69gdXy/8uPz5wz3y8oe1vEh6Ksv51/pGr5EL1tqi1e4I3buhs
HYN8jHsT9ADcxCmxFHKM0/3OF5UlY2YoOIqJJd4TXljYZ3Snr4CXQBjFZuMZhptB
t7mJI5qprbHUGWNgKYWsUc+ojn6iX6CxJT2/2NjflhOrSaEmwfrH/3K9ngM1qAX7
1xLVCVtjQGkEHayvGx3Z3OCTNXccFzvJq/gAvahH8jwLCoR+yq48Npo5DLRpqw0r
o1gRld7bSwn+0O0I1ASSj4JfJxyGGZdMfLtDf24WNQCAr+lw8sEcJOKv72OQHvOY
TIUsWJoo+iP5k4WtkNsoWzFTSmIE0Q==
=OR+w
-----END PGP SIGNATURE-----

--Jjb3XvWYFlzI2ajLnIB09DkuEUXRcqFk0--


