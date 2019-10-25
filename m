Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A08CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 10:50:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADAD521929
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 10:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NKGkg6ff"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADAD521929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNxAP-0004DL-1t
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 06:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38383)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iNx5h-0003JR-6B
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:45:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iNx5f-00049s-4l
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:45:09 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30575
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iNx5e-00045b-Uo
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572000296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OX//3DU9fPyNWji4g3JtIxvNOr21IPch+FwWKwMvTRE=;
 b=NKGkg6ffMca6d18aTK5pQ97N2iWYLxyZIYvew054tSbIrkjL968BVFrdZi32MEXifW6hO8
 rvtrbAclqGWtilggeoarJZFeTm2gaOW0u6hirPru5FYE6FRqh0MoK9UKa6zHafpHQd9yb9
 Vhs9toL2TJDeocRMmI78Y7nwl7vXcQw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-u6o2ybtqNr-nASazb14M1Q-1; Fri, 25 Oct 2019 06:44:51 -0400
X-MC-Unique: u6o2ybtqNr-nASazb14M1Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A7685EF;
 Fri, 25 Oct 2019 10:44:50 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-205.ams2.redhat.com
 [10.36.117.205])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AE42F5DC1E;
 Fri, 25 Oct 2019 10:44:47 +0000 (UTC)
Subject: Re: [PATCH v2 0/2] qcow2: Fix image corruption bug in 4.1
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20191024142658.22306-1-kwolf@redhat.com>
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
Message-ID: <d8796036-2a02-681e-f3c2-996edf4f640e@redhat.com>
Date: Fri, 25 Oct 2019 12:44:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191024142658.22306-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="f5VUIRqjZm2gSQ7RTDLKGMUPzK3IQK1qc"
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
Cc: psyhomb@gmail.com, michael@weiser.dinsnail.net, vsementsov@virtuozzo.com,
 den@virtuozzo.com, qemu-stable@nongnu.org, dgilbert@redhat.com,
 qemu-devel@nongnu.org, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--f5VUIRqjZm2gSQ7RTDLKGMUPzK3IQK1qc
Content-Type: multipart/mixed; boundary="8GcfCYtoxGopjT3m4I6raYEdy9ABN813a"

--8GcfCYtoxGopjT3m4I6raYEdy9ABN813a
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 24.10.19 16:26, Kevin Wolf wrote:
> This series fixes an image corruption bug that was introduced in commit
> 69f47505e ('block: avoid recursive block_status call if possible'),
> first contained in the QEMU 4.1.0 release.
>=20
> This bug was reported by Michael Weiser on Launchpad:
> https://bugs.launchpad.net/qemu/+bug/1846427
>=20
> v2:
>=20
> - Dropped the assertion in qcow2_cache_do_get() for now. Making sure
>   that it actually holds true for all callers requires more work and
>   getting the corruption fix in quickly is important.
>=20
> - Use atomic_read() and add comment to qemu_co_mutex_assert_locked()
>   implementation [Denis]
>=20
> Kevin Wolf (2):
>   coroutine: Add qemu_co_mutex_assert_locked()
>   qcow2: Fix corruption bug in qcow2_detect_metadata_preallocation()
>=20
>  include/qemu/coroutine.h | 15 +++++++++++++++
>  block/qcow2-refcount.c   |  2 ++
>  block/qcow2.c            |  3 ++-
>  3 files changed, 19 insertions(+), 1 deletion(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--8GcfCYtoxGopjT3m4I6raYEdy9ABN813a--

--f5VUIRqjZm2gSQ7RTDLKGMUPzK3IQK1qc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2y0h0ACgkQ9AfbAGHV
z0AuoAgAnMRBqW1o3NJuffQCbaTbKYcwg72oScZsgrIoaPYY9QaP66+h7mM96Mnb
9R/Tm5p3UgmjORgNlD5fhdflel5LBH3rvou3DnaCmVXlptObI8d7em2emouwq1YJ
tltAXFAUY88iuRh7Qj8hPMRDjtqYXtIRTkmkcmW/XPssZzSwYMoS1x9kMflrza/3
0fq4xqp3bBcCxGg1WKuxhLUShseKBNLAg/yZhiqyHD/8ulXD8ZemXjZWjvB4Epy9
wjfWveofUK8YF5Jf4Sl1Cicqy6XORdwCXAfctsXJneadqS7BQ+k04jO4ePHemiUP
20WvH+SGKiioYVNpZV0ApEjK2U2Vhw==
=YWa/
-----END PGP SIGNATURE-----

--f5VUIRqjZm2gSQ7RTDLKGMUPzK3IQK1qc--


