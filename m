Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67825C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 12:01:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26D4C20771
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 12:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e0jbnYws"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26D4C20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH4j9-0005iI-By
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 08:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jH4iP-0005Dr-HK
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 08:01:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jH4iO-00078R-9V
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 08:00:57 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:56757)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jH4iO-00078F-58
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 08:00:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585137655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ysFStvStVDZO/TjKusmdH/8M3t20987K8/VmeQpImzY=;
 b=e0jbnYwsBYro0l9jxY0oLmaJOkAsfTyqURyFQXhe6Qz7gkaksG/9QXrJ2fZ+FcNkXQIKZo
 vdpD4Ip3YCdRk4QJJt0dBJQ+I9ryvNVwRqjCeCe0wM3LilJxps6T1DS9IZcL+rUMBTDVyv
 689CXM71Wvxd6c3oK7uhIXMEC/IetC0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-dRbNzePCOHijzOo1WZkj4w-1; Wed, 25 Mar 2020 08:00:52 -0400
X-MC-Unique: dRbNzePCOHijzOo1WZkj4w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52983189D6CE;
 Wed, 25 Mar 2020 12:00:50 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-115-33.ams2.redhat.com
 [10.36.115.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A2F0896F88;
 Wed, 25 Mar 2020 12:00:32 +0000 (UTC)
Subject: Re: [PATCH 2/6] block/mirror: fix use after free of local_err
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200324153630.11882-1-vsementsov@virtuozzo.com>
 <20200324153630.11882-3-vsementsov@virtuozzo.com>
 <8cb2bda7-55f5-2646-3c35-d901089ccde5@redhat.com>
 <f6882909-0c4a-145b-bfb1-e4b92e788f36@virtuozzo.com>
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
Message-ID: <4d67184c-48d3-28d5-c09e-94439283aa0a@redhat.com>
Date: Wed, 25 Mar 2020 13:00:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <f6882909-0c4a-145b-bfb1-e4b92e788f36@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GpuqyCOjHQGRA8zo3BS5EerbOxzEsqOUu"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: kwolf@redhat.com, zhang.zhanghailiang@huawei.com, qemu-block@nongnu.org,
 quintela@redhat.com, armbru@redhat.com, dgilbert@redhat.com,
 mdroth@linux.vnet.ibm.com, den@openvz.org, marcandre.lureau@redhat.com,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GpuqyCOjHQGRA8zo3BS5EerbOxzEsqOUu
Content-Type: multipart/mixed; boundary="G9BKAIKe32gTYK2Bv8QZJXUwTJLqrsfIY"

--G9BKAIKe32gTYK2Bv8QZJXUwTJLqrsfIY
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.03.20 12:47, Vladimir Sementsov-Ogievskiy wrote:
> 25.03.2020 14:11, Max Reitz wrote:
>> On 24.03.20 16:36, Vladimir Sementsov-Ogievskiy wrote:
>>> local_err is used again in mirror_exit_common() after
>>> bdrv_set_backing_hd(), so we must zero it. Otherwise try to set
>>> non-NULL local_err will crash.
>>
>> OK, but wouldn=92t it be better hygiene to set it to NULL every time it =
is
>> freed?=A0 (There is a second instance of error_report_err() in this
>> function.=A0 I=92m a bit worried we might introduce another local_err us=
e
>> after that one at some point in the future, and forget to run the cocci
>> script then.)
>=20
> Yes, it's better. But if we now decide to fix all such things, it would b=
e
> huge series. May be too huge for 5.0..
>=20
> So I decided to fix only real obvious problems now.

Reasonable, yes.

> Hmm huge or not?
>=20
> Ok, let's try with less restrictions:
>=20
> --- a/scripts/coccinelle/error-use-after-free.cocci
> +++ b/scripts/coccinelle/error-use-after-free.cocci
> @@ -28,7 +28,7 @@ expression err;
>=20
> =A0 fn(...)
> =A0 {
> -=A0=A0=A0=A0 <...
> +=A0=A0=A0=A0 ... when any
> =A0(
> =A0=A0=A0=A0=A0 error_free(err);
> =A0+=A0=A0=A0 err =3D NULL;
> @@ -46,7 +46,5 @@ expression err;
> =A0+=A0=A0=A0 err =3D NULL;
> =A0)
> =A0=A0=A0=A0=A0 ... when !=3D err =3D NULL
> -=A0=A0=A0=A0=A0=A0=A0=A0 when !=3D exit(...)
> -=A0=A0=A0=A0 fn2(..., err, ...)
> -=A0=A0=A0=A0 ...>
> +=A0=A0=A0=A0=A0=A0=A0=A0 when any
> =A0 }
>=20
>=20
> on block/ directory:
>=20
> spatch --sp-file scripts/coccinelle/error-use-after-free.cocci
> --macro-file scripts/cocci-macro-file.h --in-place --no-show-diff
> --use-gitgrep block
> git diff --stat
> =A0scripts/coccinelle/error-use-after-free.cocci |=A0 6 ++----
> =A0block/block-backend.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 1 +
> =A0block/commit.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 4 ++++
> =A0block/crypto.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 1 +
> =A0block/file-posix.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 5 +++++
> =A0block/mirror.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 2 ++
> =A0block/monitor/block-hmp-cmds.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 |=A0 4 ++++
> =A0block/parallels.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 3 +++
> =A0block/qapi-sysemu.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 2 ++
> =A0block/qapi.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 1 +
> =A0block/qcow.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 2 ++
> =A0block/qcow2-cluster.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 1 +
> =A0block/qcow2-refcount.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 |=A0 1 +
> =A0block/qcow2-snapshot.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 |=A0 3 +++
> =A0block/qcow2.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 4 ++++
> =A0block/replication.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 1 +
> =A0block/sheepdog.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 13 +++++++++++++
> =A0block/stream.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 1 +
> =A0block/vdi.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 2 ++
> =A0block/vhdx.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 2 ++
> =A0block/vmdk.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 2 ++
> =A0block/vpc.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 2 ++
> =A0block/vvfat.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 2 ++
> =A023 files changed, 61 insertions(+), 4 deletions(-)
>=20
>=20
> If you want, I'll send series.
>=20
>>
>> Are the cocci scripts run regularly by someone?=A0 E.g. as part of a pul=
l
>> to master?
>=20
> I'm afraid not. I have a plan in my mind, to make python checkcode,
> which will
> work in pair with checkpatch somehow, and will work on workdir instead of
> patch. It will simplify significantly adding different code checks,
> including
> starting coccinelle scripts.
Hm.  I think we need to prepare for noone running the cocci scripts
(i.e., we should use the above variant with less restrictions so that
future patches are less likely to reintroduce the problem), or we need
to ensure the cocci scripts are run regularly.

We can of course also do both.  In this case I think it makes sense to
do a less-restricted version, because I think it can never hurt to set
pointers to NULL after freeing them.  (We could do an exception for when
the error-freeing is immediately followed by a goto out, but I think
that would make it too complicated.)

I=92d like to start running the cocci scripts myself before every pull
request, but unfortunately there are still a number of diffs in the
block area.  I think I=92ll send a series to fix those and then I can run
the scripts regularly to prevent regressions.  So I=92ll leave it up to
you whether you think a less-restricted version would make sense.

Max


--G9BKAIKe32gTYK2Bv8QZJXUwTJLqrsfIY--

--GpuqyCOjHQGRA8zo3BS5EerbOxzEsqOUu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl57R94ACgkQ9AfbAGHV
z0CXfQgAoVC+RsAgjxGjfmu2jgXwgftTc6YDErUGZpEyOcnVOFIDfwikgDK8StNk
fmhVzcyfiQYSnDgymdITiObLoWlsqLXbPzDtuB2xlfxDm/wRJitjh+GvF2/C2Mci
7FLobnK0rvEyH8kfyZU4ieB9LD+guMa0tVX0IEndKAcQg731tcKxVzqnbQVtMAeC
Wpn8YjsTrahydHIuDD91Ef9GeHtcFexgFrX4R0BWDHx+AS0Z6BUuOfIPlZl5+YAU
If1B5AO1zK+OEo6IJt4BjJ4bfdhk1xAwM+vG8snphWwNaMI32vmuGpq25KdfZkS6
wy2aGKAwOpEcwc6fmGNC8rENnL/fTQ==
=BNjS
-----END PGP SIGNATURE-----

--GpuqyCOjHQGRA8zo3BS5EerbOxzEsqOUu--


