Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF1CEC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 09:00:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7766C2067D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 09:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h6R8p+mx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7766C2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtSPv-0003Hc-QX
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 05:00:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jtSOp-0002c4-G1
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 04:59:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23267
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jtSOn-0004Yp-DG
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 04:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594285160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Egi2GSTnQuoy/T94xySzGSGiKGKRwMCpOTWvMPr9qcQ=;
 b=h6R8p+mxSMidAl8bcpLxdEw/17cVErXiT0NHzlloDwL8NbXpnM+r3fTWnm8VAUznQKakor
 OGFCcbZ5L0DRJ5O/d0Jkbly+lrO7Q0m0/1BDSe8oyF9M+KE6nQ0XcWs7TFX22CLbhv1IfN
 fT9v2HcOiCjKib3BdTPZoLRaGnBhzuI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-Nw_q60HPPleFEOs5feTcJQ-1; Thu, 09 Jul 2020 04:59:18 -0400
X-MC-Unique: Nw_q60HPPleFEOs5feTcJQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B1AD193248C;
 Thu,  9 Jul 2020 08:59:17 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-127.ams2.redhat.com
 [10.36.113.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 674AF872EE;
 Thu,  9 Jul 2020 08:59:15 +0000 (UTC)
Subject: Re: [PATCH v7 12/47] block: Use bdrv_filter_(bs|child) where obvious
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-13-mreitz@redhat.com>
 <82792291-86a1-34cc-98e8-6d585755c79b@virtuozzo.com>
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
Message-ID: <898d0f61-8994-4750-98bd-d6870335d223@redhat.com>
Date: Thu, 9 Jul 2020 10:59:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <82792291-86a1-34cc-98e8-6d585755c79b@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mdoKsrtirAlCdNADZCrMCRRcHZwin1H9s"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 01:47:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mdoKsrtirAlCdNADZCrMCRRcHZwin1H9s
Content-Type: multipart/mixed; boundary="fa3uYMvzPAovFWUgMg6J4qjXpkXUDa4v8"

--fa3uYMvzPAovFWUgMg6J4qjXpkXUDa4v8
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 08.07.20 20:24, Andrey Shinkevich wrote:
> On 25.06.2020 18:21, Max Reitz wrote:
>> Places that use patterns like
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 if (bs->drv->is_filter && bs->file) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ... something about bs-=
>file->bs ...
>> =C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> should be
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 BlockDriverState *filtered =3D bdrv_filter_bs(b=
s);
>> =C2=A0=C2=A0=C2=A0=C2=A0 if (filtered) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ... something about @fi=
ltered ...
>> =C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> instead.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> =C2=A0 block.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 31 ++++++++++++++++++++-----------
>> =C2=A0 block/io.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
7 +++++--
>> =C2=A0 migration/block-dirty-bitmap.c |=C2=A0 8 +-------
>> =C2=A0 3 files changed, 26 insertions(+), 20 deletions(-)
>>
> ...
>> diff --git a/block/io.c b/block/io.c
>> index df8f2a98d4..385176b331 100644
>> --- a/block/io.c
>> +++ b/block/io.c
>> @@ -3307,6 +3307,7 @@ int coroutine_fn bdrv_co_truncate(BdrvChild
>> *child, int64_t offset, bool exact,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error **err=
p)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockDriverState *bs =3D child->bs;
>> +=C2=A0=C2=A0=C2=A0 BdrvChild *filtered;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockDriver *drv =3D bs->drv;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BdrvTrackedRequest req;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t old_size, new_bytes;
>> @@ -3358,6 +3359,8 @@ int coroutine_fn bdrv_co_truncate(BdrvChild
>> *child, int64_t offset, bool exact,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 +=C2=A0=C2=A0=C2=A0 filtered =3D bdrv_filter_child(bs);
>> +
>=20
> Isn't better to have this initialization right before the relevant
> if/else block?

Hm, well, yes.  In this case, though, maybe not.  Patch 16 will add
another BdrvChild to be initialized here (@backing), and we need to
initialize that one here.  So I felt it made sense to group them together.

They got split up when I decided to put @filtered into this patch and
@backing into its own.  So now it may look a bit weird, but I feel like
after patch 16 it makes sense.

(I=E2=80=99m indifferent, basically.)

Max


--fa3uYMvzPAovFWUgMg6J4qjXpkXUDa4v8--

--mdoKsrtirAlCdNADZCrMCRRcHZwin1H9s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8G3GEACgkQ9AfbAGHV
z0CwCQf/bJiwGqn7lmOdQDEy0Ed6nI1ShQLc6WcVq595vUOY2fKYlXWL8d0KmymH
ouGpHbk63CAX8sXFSUDHANefFP8CJBNtWuITAJn9MAU1eb9XpW8m44EFeP/oHbig
Y7tZFXmySj4lQYEv8THqdlYLdJuc79f1VhihYFh5iBlgfBH+ZOPd42vs7jBXtfAi
5s7XsG38+VUBm+tfT1itRcUZmoVYVPevPGEkgrF6RmJC9/hGrfhQvHvPVWc6HaHd
crI6qkXaMCqBN1WYF8P8rOfHVchhvMyHe8nB5cA+IFf3QWhcIpjhwXDP0K0pJVnT
t8eH65pIaRaX2phfzgswKKIeuOTiOA==
=qNbc
-----END PGP SIGNATURE-----

--mdoKsrtirAlCdNADZCrMCRRcHZwin1H9s--


