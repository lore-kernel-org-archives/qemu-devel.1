Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEF0C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 15:46:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C09F0222C2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 15:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V9BIr+Pw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C09F0222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiKUM-0007Oh-Vd
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 10:46:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40660)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iiKTY-0006oB-6Q
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 10:46:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iiKTX-0002Hl-1M
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 10:46:00 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49680
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iiKTW-0002Gy-S3
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 10:45:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576856758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QIxtg1cFXP/j/JiiucB+UoaHQz7BBySgFDkGaNqSNtA=;
 b=V9BIr+PwLnDzKmxGI5v4V1a8GqCLKtVKHqpcNEet8DFFN2cSCiArEsg1nbZrB/XBlAp8iV
 RnjKOlwYE9Vnbpr5wJEA5HV5LwajUwHbHBIb0uV1xjTy3AfeNS2iAc4fCKhyzxYImbavg+
 6Yz6sswH5dKEhspjxJrcoDP1pLEOfgQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-Jo7RmUeHMjmMhDxYIezbIg-1; Fri, 20 Dec 2019 10:45:54 -0500
X-MC-Unique: Jo7RmUeHMjmMhDxYIezbIg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66A3E18557C0;
 Fri, 20 Dec 2019 15:45:53 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-205-117.brq.redhat.com
 [10.40.205.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 958A060BF3;
 Fri, 20 Dec 2019 15:45:51 +0000 (UTC)
Subject: Re: [PATCH v12 0/3] qcow2: advanced compression options
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <1575288906-551879-1-git-send-email-andrey.shinkevich@virtuozzo.com>
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
Message-ID: <8ddae8ca-c9ab-1683-45bf-e33ab7cb7b2a@redhat.com>
Date: Fri, 20 Dec 2019 16:45:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1575288906-551879-1-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="n7eeGJSGGdFtLmZ0mKHmPR2s4krexa3mu"
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
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--n7eeGJSGGdFtLmZ0mKHmPR2s4krexa3mu
Content-Type: multipart/mixed; boundary="FQXeFT10tbIgRbTW2Gh54rFRoGSS5gFf9"

--FQXeFT10tbIgRbTW2Gh54rFRoGSS5gFf9
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 02.12.19 13:15, Andrey Shinkevich wrote:
> The compression filter driver is introduced as suggested by Max.
> A sample usage of the filter can be found in the test #214.
> Now, multiple clusters can be written compressed.
> It is useful for the backup job.
>=20
> v12:
>   01: Missed to change the driver interface .bdrv_co_block_status
>       from _status_from_backing to _status_from_file (noticed by
>       Vladimir).
>=20
> Andrey Shinkevich (3):
>   block: introduce compress filter driver
>   qcow2: Allow writing compressed data of multiple clusters
>   tests/qemu-iotests: add case to write compressed data of multiple
>     clusters
>=20
>  block/Makefile.objs        |   1 +
>  block/filter-compress.c    | 168 +++++++++++++++++++++++++++++++++++++++=
++++++
>  block/qcow2.c              | 102 +++++++++++++++++++--------
>  qapi/block-core.json       |  10 +--
>  tests/qemu-iotests/214     |  43 ++++++++++++
>  tests/qemu-iotests/214.out |  14 ++++
>  6 files changed, 307 insertions(+), 31 deletions(-)
>  create mode 100644 block/filter-compress.c

Thanks, fixed patch 1 and applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--FQXeFT10tbIgRbTW2Gh54rFRoGSS5gFf9--

--n7eeGJSGGdFtLmZ0mKHmPR2s4krexa3mu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl387K4ACgkQ9AfbAGHV
z0C+8AgAgoD9WKyZm2+sAsCL9r4PbE6aXI5LLRxjTLmNoAaMuW1LXXNQb+tZb46P
p1dG28xcHTK5aiHJyOBXAF8JH2htX57TomS/I01SCSNzR3NSclDP1sI4RRA5DKWm
Px4t7WvIl3f6vXYHHjpL8LpEY3K3C8MVVlr3n+C6yMMGGnAo/YjtwBh74h+fdCrw
U2Gxft5l8+2ccfeaLPyBODMB6Qk5pRuyQIhiTzHo8bet3TX1xIAH/JpoSHscxTBz
MFTcUDyUqFCkg12e0VDbX9WWEXMTu9LOuvQ01SyPW0EJLP/QDJ86X26Pkdayiv2g
zTICzgdPR131fltxfR6+R0VWtm+5xA==
=zIYB
-----END PGP SIGNATURE-----

--n7eeGJSGGdFtLmZ0mKHmPR2s4krexa3mu--


