Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E993BC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 12:30:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFC292071E
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 12:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NJPRjK7r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFC292071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZwSX-0004mj-N4
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 07:30:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iZwQf-00045w-De
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 07:28:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iZwQc-0005cz-Ux
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 07:28:20 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42356
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iZwQc-0005at-Ei
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 07:28:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574857697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=LfRDFH6gCSksgshK05JTUMVpEfzUYYF447jZyp44ULo=;
 b=NJPRjK7r6PC9jJnEKIN4CzCPTOSst0MuRrYAo3ScH90hq4HG7LrxgztoB7magoQtxTkAeE
 wd0inH2WKAPCGH/0Y78ljxfnWB7gjzl1bbnEQd7DDYXMl/uGm24IMQ82mmqRddWxlvxV4i
 Gj9GRlCGSQdSD8NhBkEXIPLg2MfOseE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-OcBHgO_aNzOMDIxSMqdvKQ-1; Wed, 27 Nov 2019 07:28:14 -0500
X-MC-Unique: OcBHgO_aNzOMDIxSMqdvKQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4CDAD80183C;
 Wed, 27 Nov 2019 12:28:12 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-205-186.brq.redhat.com
 [10.40.205.186])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F2815600C8;
 Wed, 27 Nov 2019 12:28:09 +0000 (UTC)
Subject: Re: [PATCH V2] throttle-groups: fix memory leak in
 throttle_group_set_limit:
To: pannengyuan@huawei.com, berto@igalia.com, kwolf@redhat.com
References: <1574835614-42028-1-git-send-email-pannengyuan@huawei.com>
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
Message-ID: <079361c7-8474-ca67-7e7c-8fd49cd913b6@redhat.com>
Date: Wed, 27 Nov 2019 13:28:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1574835614-42028-1-git-send-email-pannengyuan@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NNHSipPOXuX7LFoX7YsDxu4z7zsTG6jpR"
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
Cc: liyiting@huawei.com, kuhn.chenqun@huawei.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NNHSipPOXuX7LFoX7YsDxu4z7zsTG6jpR
Content-Type: multipart/mixed; boundary="GRDK7aBoCN1lcaQUDPYMCpHfEOm3kshtq"

--GRDK7aBoCN1lcaQUDPYMCpHfEOm3kshtq
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 27.11.19 07:20, pannengyuan@huawei.com wrote:
> From: PanNengyuan <pannengyuan@huawei.com>
>=20
> This avoid a memory leak when qom-set is called to set throttle_group
> limits, here is an easy way to reproduce:
>=20
> 1. run qemu-iotests as follow and check the result with asan:
>        ./check -qcow2 184
>=20
> Following is the asan output backtrack:
> Direct leak of 912 byte(s) in 3 object(s) allocated from:
>     #0 0xffff8d7ab3c3 in __interceptor_calloc   (/lib64/libasan.so.4+0xd3=
3c3)
>     #1 0xffff8d4c31cb in g_malloc0   (/lib64/libglib-2.0.so.0+0x571cb)
>     #2 0x190c857 in qobject_input_start_struct  /mnt/sdc/qemu-master/qemu=
-4.2.0-rc0/qapi/qobject-input-visitor.c:295
>     #3 0x19070df in visit_start_struct   /mnt/sdc/qemu-master/qemu-4.2.0-=
rc0/qapi/qapi-visit-core.c:49
>     #4 0x1948b87 in visit_type_ThrottleLimits   qapi/qapi-visit-block-cor=
e.c:3759
>     #5 0x17e4aa3 in throttle_group_set_limits   /mnt/sdc/qemu-master/qemu=
-4.2.0-rc0/block/throttle-groups.c:900
>     #6 0x1650eff in object_property_set     /mnt/sdc/qemu-master/qemu-4.2=
.0-rc0/qom/object.c:1272
>     #7 0x1658517 in object_property_set_qobject   /mnt/sdc/qemu-master/qe=
mu-4.2.0-rc0/qom/qom-qobject.c:26
>     #8 0x15880bb in qmp_qom_set  /mnt/sdc/qemu-master/qemu-4.2.0-rc0/qom/=
qom-qmp-cmds.c:74
>     #9 0x157e3e3 in qmp_marshal_qom_set  qapi/qapi-commands-qom.c:154
>=20
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: PanNengyuan <pannengyuan@huawei.com>
> ---
> Changes v2 to v1:
> - remove unused var 'arg' (suggested by Alberto Garcia)
> ---
>  block/throttle-groups.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks, applied to my block-next branch for 5.0:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block-next

Max


--GRDK7aBoCN1lcaQUDPYMCpHfEOm3kshtq--

--NNHSipPOXuX7LFoX7YsDxu4z7zsTG6jpR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3ea9cACgkQ9AfbAGHV
z0DymAf9HHIqVOi2JmQAP+pBgBj8ovts1JuWoD//L5AlF3o7/p4YUtqupSLU7Dqc
YBAHPT96HAx/6XRYsUFLyiwWFOLz0cw2C1sGT0vVnCV80GTP5jG0hYWK/xV9ok+9
eGos+kKQOyNeJhXw6k6z2NhsEsMDMYpWohtRASSE4OdJCQhbva7DRGLR8Ag3DOrb
s1HTZ1eb2UxkP/BFWvXmQy48Lawdh3WjEaRjjvemoZTJEhiRXumuf4G04B960lzZ
CdSI+yvLYFxJD7WOIzH0SvJiLu/kJk84bruWNTEYlAAOBlPeuT27ZVumetYhw9Mv
yzcsyYA5MwbBLUE9R2Erx3//iPcL5w==
=KTZd
-----END PGP SIGNATURE-----

--NNHSipPOXuX7LFoX7YsDxu4z7zsTG6jpR--


