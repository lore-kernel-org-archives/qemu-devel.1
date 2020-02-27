Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06962C4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:25:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5B4921556
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cNApcJvI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5B4921556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7JAa-0008EG-Up
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 08:25:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60111)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j7J9w-0007ZU-BC
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:25:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j7J9s-0001L2-2w
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:24:57 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28874
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j7J9r-0001K6-Vs
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:24:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582809895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q2GXaTKSF7MYknYt6GSIaXAOMSKcda/JyBINRDYnosY=;
 b=cNApcJvIAEIGabkMPjtUg9qPz6iBj9u2QHJND2/TJhG273tjKeQIdsGPvYJKd48cYfR3n+
 PwtZZdRb20CQa6by6E5TAa1ouqq/GgfSdDaoD/0+hM++rFGgNsANNujOl7n/O+j10FUCRu
 fW2SgojpZH9uY2VnlkgwcYvP60KzoAY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-1g9eTZ3yMMmovzsKyuB2Xg-1; Thu, 27 Feb 2020 08:24:51 -0500
X-MC-Unique: 1g9eTZ3yMMmovzsKyuB2Xg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55C3118A8C82;
 Thu, 27 Feb 2020 13:24:50 +0000 (UTC)
Received: from [10.3.116.57] (ovpn-116-57.phx2.redhat.com [10.3.116.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 99A2319C58;
 Thu, 27 Feb 2020 13:24:49 +0000 (UTC)
Subject: Re: [PATCH v1 1/8] qcow2: introduce compression type feature
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200227072953.25445-1-dplotnikov@virtuozzo.com>
 <20200227072953.25445-2-dplotnikov@virtuozzo.com>
 <4ead22d2-bf1e-e4cb-4b41-7e283bbeaa5b@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <d6c6ca8a-ddd1-06af-8f81-297941b127a2@redhat.com>
Date: Thu, 27 Feb 2020 07:24:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <4ead22d2-bf1e-e4cb-4b41-7e283bbeaa5b@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: kwolf@redhat.com, armbru@redhat.com, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/27/20 2:21 AM, Vladimir Sementsov-Ogievskiy wrote:
> 27.02.2020 10:29, Denis Plotnikov wrote:
>> The patch adds some preparation parts for incompatible compression type
>> feature to Qcow2 that indicates which allow to use different compression
>> methods for image clusters (de)compressing.
>>
>> It is implied that the compression type is set on the image creation and
>> can be changed only later by image conversion, thus compression type
>> defines the only compression algorithm used for the image, and thus,
>> for all image clusters.
>>
>> The goal of the feature is to add support of other compression methods
>> to qcow2. For example, ZSTD which is more effective on compression=20
>> than ZLIB.
>>
>> The default compression is ZLIB. Images created with ZLIB compression=20
>> type
>> are backward compatible with older qemu versions.
>>
>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>> ---
>> =C2=A0 block/qcow2.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 105 ++++++++++++++++++++++++++++++++++++++
>> =C2=A0 block/qcow2.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 31 ++++++++---
>> =C2=A0 include/block/block_int.h |=C2=A0=C2=A0 1 +
>> =C2=A0 qapi/block-core.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 22 +++=
++++-
>> =C2=A0 4 files changed, 150 insertions(+), 9 deletions(-)
>>
>> diff --git a/block/qcow2.c b/block/qcow2.c
>> index 3c754f616b..2ccb2cabd1 100644
>> --- a/block/qcow2.c
>> +++ b/block/qcow2.c
>=20
> Please, add to .git/config:
>=20
> [diff]
>  =C2=A0=C2=A0=C2=A0 orderFile =3D /path/to/qemu/scripts/git.orderfile
>=20
> This will force git format-patch to sort files in more comfortable order=
=20
> (header changes first, etc).

As I learned yesterday, git 2.23 and 2.24 have a bug where git=20
format-patch fails to honor diff.orderfile (fixed in 2.25):=20
https://bugzilla.redhat.com/show_bug.cgi?id=3D1807681
(and that explains why some of my recent patches have not been ordered=20
the way I wanted, as Fedora 31 currently has a git from the broken=20
window in time)


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


