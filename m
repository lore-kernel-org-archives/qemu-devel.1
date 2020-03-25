Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D18C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 14:02:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B1A32077D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 14:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OCMIEZ3J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B1A32077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH6cR-0007og-D3
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 10:02:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59219)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jH6be-0006wu-De
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 10:02:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jH6bc-0002T7-Qb
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 10:02:06 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:47531)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jH6bb-0002QL-E0
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 10:02:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585144921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SWYwuV+09qqEn5mawjwgoWhIFhL7BuoMkGRSxZL9bEw=;
 b=OCMIEZ3J6zRgAAsVa8s/mOsBUlfVQGwSO0nj4iG+x+bO1SbFznJ7pN3CZGE5aQv2BU+0Di
 mK6sOYYOj8+0RjYwWGpseipm4dboA2YduI1T9QX1AvUULxYFwt8+GZzkX5gAXVrAe3NSPF
 +2Hp+OiGFjnFGrHfDamPmMlPcResXLY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-FwhqUuwPNKqMK5_-jT5eVA-1; Wed, 25 Mar 2020 10:01:49 -0400
X-MC-Unique: FwhqUuwPNKqMK5_-jT5eVA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46C0D18B9FAA;
 Wed, 25 Mar 2020 14:01:46 +0000 (UTC)
Received: from [10.3.113.103] (ovpn-113-103.phx2.redhat.com [10.3.113.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3665D953DD;
 Wed, 25 Mar 2020 14:01:43 +0000 (UTC)
Subject: Re: [PATCH v2 3/4] qcow2: Avoid feature name extension on small
 cluster size
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20200324174233.1622067-1-eblake@redhat.com>
 <20200324174233.1622067-4-eblake@redhat.com>
 <d28f2dfc-1f85-1157-0a57-341894205883@redhat.com>
 <f900616b-8e98-d0b1-efd7-f53b8c241c8f@redhat.com>
 <61b5c2d0-fc76-cc70-ab25-bd75cd785d69@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <ba268a08-12ad-4290-c754-a1e7d39f7748@redhat.com>
Date: Wed, 25 Mar 2020 09:01:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <61b5c2d0-fc76-cc70-ab25-bd75cd785d69@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: kwolf@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/25/20 8:52 AM, Max Reitz wrote:

>> If we want to write it like that, which size limit
>> do you propose?=C2=A0 Or asked differently, how much space should we res=
erve
>> for other extension headers + backing file name?
>=20
> Well, that was the =E2=80=9C2k/3k/...=E2=80=9D list. :)
>=20
> The backing file name is limited to 1k, so I suppose that plus 1k for a
> potential external data filename, plus 1k for the rest, so 3k in total?
>=20
> Now that I look into the spec, I see that it actually doesn=E2=80=99t say=
 that
> the backing filename has to be part of the header cluster.  But, well.

qemu enforces that the header is one cluster.  But you're right, that=20
does not appear to directly be a limitation mandated by the spec, and we=20
could relax qemu to allow the header to be several consecutive clusters.=20
  The tricky part, however, is that the backing file name is NOT=20
described by a header extension, but rather is just whatever bytes occur=20
after the final header extension.  There's no clear indication anywhere=20
on when to stop reading those bytes, other than by an implicit limit=20
such as insisting those bytes fall within the first cluster.

Had we been smarter when designing v3, we would have made the backing=20
file name a header extension (in fact, it would have been possible to=20
design the additional fields of v3 to look like an unknown header=20
extension when parsed by a v2 binary) - but hindsight is 20/20.

>=20
> It also only says that the image header must be part of the first
> cluster, which in my opinion doesn=E2=80=99t necessarily include its exte=
nsions.
>   So header extensions (and the backing filename) could actually be in
> consecutive clusters.  But that of course would be much more difficult
> to implement.

We'd still want a sane limit even for small-cluster images (maybe "no=20
more than 2M of header information, regardless of cluster size); or=20
maybe even introduce a NEW header field and/or extension to make it=20
obvious how many clusters are being used for the purpose of the metadata=20
header in this particular image (with sane fallbacks for when that=20
extension is not present).  But you're right - it comes with complexity.=20
  This patch as written is safe for 5.0-rc1, but this discussion about=20
teaching qemu to permit headers larger than 1 cluster is squarely in the=20
5.1 category, if at all.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


