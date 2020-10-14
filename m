Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFEDC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:30:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48D2420B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eu8QZFEn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48D2420B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSjfb-00080P-30
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 12:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kSjcn-00051l-OB
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 12:27:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25335)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kSjck-0004ba-4Q
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 12:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602692853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oiznkTb3dYAB5QBwOw7LYEnl5/bHclaMKZl3dWzJ0s4=;
 b=eu8QZFEni+xteG93Ih3AVRg7utxVguzdHnwUDaNuAiGeTm3G1kBRtRr7eQ68qkaP8/lD+3
 2O3m76eqdBop2jgwnW4EtR+mUKnePdsNBG82o5Wz9n786pselfM7URApAJQvo/X+WBRrB0
 CTACcA+iu1ffp75aLw2YGnhrtHsQWAk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-575-h2Jfcs4WOaO5y0XC2I3brg-1; Wed, 14 Oct 2020 12:27:29 -0400
X-MC-Unique: h2Jfcs4WOaO5y0XC2I3brg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 158B8195D58E;
 Wed, 14 Oct 2020 16:27:27 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.194.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1575E1002382;
 Wed, 14 Oct 2020 16:27:23 +0000 (UTC)
Subject: Re: [PATCH v11 04/13] copy-on-read: pass overlay base node name to
 COR driver
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1602524605-481160-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1602524605-481160-5-git-send-email-andrey.shinkevich@virtuozzo.com>
 <3c6699f3-e061-c2ae-c5e9-a12660405624@redhat.com>
 <bbcb3d60-fbc2-b22c-2660-5e9d8dc4ce5e@redhat.com>
 <380352ca-2450-e4be-885f-c826296618df@virtuozzo.com>
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
Message-ID: <6d39eb6f-4a64-62be-9d28-fc5c7cfd2ae7@redhat.com>
Date: Wed, 14 Oct 2020 18:27:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <380352ca-2450-e4be-885f-c826296618df@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KEVfQ4P2gw83U6XWvNJbgBGeUHKUJMKia"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 01:12:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, fam@euphon.net, libvir-list@redhat.com,
 qemu-devel@nongnu.org, armbru@redhat.com, stefanha@redhat.com, den@openvz.org,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KEVfQ4P2gw83U6XWvNJbgBGeUHKUJMKia
Content-Type: multipart/mixed; boundary="ZFxkdsuc9FWwRE6MRl7y0AQPq9bQMmfzN"

--ZFxkdsuc9FWwRE6MRl7y0AQPq9bQMmfzN
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.10.20 16:56, Vladimir Sementsov-Ogievskiy wrote:
> 14.10.2020 14:57, Max Reitz wrote:
>> On 14.10.20 13:09, Max Reitz wrote:
>>> On 12.10.20 19:43, Andrey Shinkevich wrote:
>>>> We are going to use the COR-filter for a block-stream job.
>>>> To limit COR operations by the base node in the backing chain during
>>>> stream job, pass the name of overlay base node to the copy-on-read
>>>> driver as base node itself may change due to possible concurrent jobs.
>>>> The rest of the functionality will be implemented in the patch that
>>>> follows.
>>>>
>>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>>> ---
>>>> =C2=A0 block/copy-on-read.c | 14 ++++++++++++++
>>>> =C2=A0 1 file changed, 14 insertions(+)
>>>
>>> Is there a reason why you didn=E2=80=99t add this option to QAPI (as pa=
rt of a
>>> yet-to-be-created BlockdevOptionsCor)?=C2=A0 Because I=E2=80=99d really=
 like it
>>> there.
>>>
>>>> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
>>>> index bcccf0f..c578b1b 100644
>>>> --- a/block/copy-on-read.c
>>>> +++ b/block/copy-on-read.c
>>>> @@ -24,19 +24,24 @@
>>>> =C2=A0 #include "block/block_int.h"
>>>> =C2=A0 #include "qemu/module.h"
>>>> =C2=A0 #include "qapi/error.h"
>>>> +#include "qapi/qmp/qerror.h"
>>>> =C2=A0 #include "qapi/qmp/qdict.h"
>>>> =C2=A0 #include "block/copy-on-read.h"
>>>> =C2=A0 =C2=A0 =C2=A0 typedef struct BDRVStateCOR {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool active;
>>>> +=C2=A0=C2=A0=C2=A0 BlockDriverState *base_overlay;
>>>> =C2=A0 } BDRVStateCOR;
>>>> =C2=A0 =C2=A0 =C2=A0 static int cor_open(BlockDriverState *bs, QDict *=
options, int
>>>> flags,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error **errp)
>>>> =C2=A0 {
>>>> +=C2=A0=C2=A0=C2=A0 BlockDriverState *base_overlay =3D NULL;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BDRVStateCOR *state =3D bs->opaque;
>>>> +=C2=A0=C2=A0=C2=A0 /* We need the base overlay node rather than the b=
ase itself */
>>>> +=C2=A0=C2=A0=C2=A0 const char *base_overlay_node =3D qdict_get_try_st=
r(options,
>>>> "base");
>>>
>>> Shouldn=E2=80=99t it be called base-overlay or above-base then?
>>
>> While reviewing patch 5, I realized this sould indeed be base-overlay

(Just realized that sounds different from how I meant it.  I meant that
 =E2=80=9Cabove-base=E2=80=9D would be wrong, so from the two, if any, it s=
hould be
=E2=80=9Cbase-overlay=E2=80=9D.)

>> (i.e. the next allocation-bearing layer above the base, not just a
>> filter on top of base), but that should be noted somewhere, of course.
>> Best would be the QAPI documentation for this option. O:)
>>
>=20
> What about naming it just "bottom" or "bottom-node"? If we don't have
> base, it's strange to have something "relative to base". And we can
> document, that "bottom" must be a non-filter node in a backing chain of
> "top".

Works for me, too.

Max


--ZFxkdsuc9FWwRE6MRl7y0AQPq9bQMmfzN--

--KEVfQ4P2gw83U6XWvNJbgBGeUHKUJMKia
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl+HJuoACgkQ9AfbAGHV
z0CPYwf/ZQ0MiE3Je0/whykRi5QyM5T5nkxYBwlcHB6bgedOb3lf53QCgV+lGPMf
aAnRPzeFIdRgttrbK+GB5269bjOpnF4srD0rFgtJz9VEVbNka+tL4/9CJGd9es0P
UMIYiar/7z7QcjoxmCBGrZLBQB2L/R/JYwdSIgiD58OcQc+/5/DAUV6LRBE3N6MY
0WPf/8azlWw/a8GYCwcnVRqLn3yc2V5jN16F+RaidkKyQoIt6ECbhm9y92NoJDNv
+83y07P+Mp1qI5Gy77HxTjaG7FUcp2oO+nfBr+N7lgxZt15AkVXEtxYLAohe3aep
lw5Ry7/rS/U3TfrPu2wCu2hWd/ZYTw==
=nj/Y
-----END PGP SIGNATURE-----

--KEVfQ4P2gw83U6XWvNJbgBGeUHKUJMKia--


