Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DBAC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 13:25:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 649652078A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 13:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JDGz8QpM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 649652078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH62C-0004ei-GT
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 09:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53442)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jH5vw-0001yG-DA
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 09:19:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jH5vv-0008Pq-8D
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 09:19:00 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:45748)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jH5vv-0008P7-52
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 09:18:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585142337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZkUOFvcHWW6V0HJteHJ1Wd/9F9GXgmZG1/8ZLI0b0f4=;
 b=JDGz8QpMjIxXz8tiAZ70N0OHVslZ2LMDDwTgx2o89TNr1wZZfsh2g8Rv8HDAKhvKUFGKOz
 Qll6kGsNfmLtU0XtfNUyOKNOqTorRqHwyJ/AiWydIVv6mNkERJXsRQ0u2A8GdruezvaCha
 ASkGqPaZ4bacfs5ri5CYfU8Wdfr/RoE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-xcFRU_ssMf6ksW96d3dFxA-1; Wed, 25 Mar 2020 09:18:52 -0400
X-MC-Unique: xcFRU_ssMf6ksW96d3dFxA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 537E9800D53;
 Wed, 25 Mar 2020 13:18:50 +0000 (UTC)
Received: from [10.3.113.103] (ovpn-113-103.phx2.redhat.com [10.3.113.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F35555C57E;
 Wed, 25 Mar 2020 13:18:46 +0000 (UTC)
Subject: Re: [PATCH v2 3/4] qcow2: Avoid feature name extension on small
 cluster size
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20200324174233.1622067-1-eblake@redhat.com>
 <20200324174233.1622067-4-eblake@redhat.com>
 <d28f2dfc-1f85-1157-0a57-341894205883@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <f900616b-8e98-d0b1-efd7-f53b8c241c8f@redhat.com>
Date: Wed, 25 Mar 2020 08:18:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <d28f2dfc-1f85-1157-0a57-341894205883@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

On 3/25/20 7:42 AM, Max Reitz wrote:
> On 24.03.20 18:42, Eric Blake wrote:
>> As the feature name table can be quite large (over 9k if all 64 bits
>> of all three feature fields have names; a mere 8 features leaves only
>> 8 bytes for a backing file name in a 512-byte cluster), it is unwise
>> to emit this optional header in images with small cluster sizes.
>>
>> Update iotest 036 to skip running on small cluster sizes; meanwhile,
>> note that iotest 061 never passed on alternative cluster sizes
>> (however, I limited this patch to tests with output affected by adding
>> feature names, rather than auditing for other tests that are not
>> robust to alternative cluster sizes).
>=20

>> -    /* Feature table */
>> -    if (s->qcow_version >=3D 3) {
>> +    /*
>> +     * Feature table.  A mere 8 feature names occupies 392 bytes, and
>> +     * when coupled with the v3 minimum header of 104 bytes plus the
>> +     * 8-byte end-of-extension marker, that would leave only 8 bytes
>> +     * for a backing file name in an image with 512-byte clusters.
>> +     * Thus, we choose to omit this header for cluster sizes 4k and
>> +     * smaller.
>=20
> Can=E2=80=99t we do this decision more dynamically?  Like, always omit it=
 when
> cluster_size - sizeof(features) < 2k/3k/...?
>=20
> Max
>=20
>> +     */
>> +    if (s->qcow_version >=3D 3 && s->cluster_size > 4096) {

Yes.  But when you consider that sizeof(features) is a compile-time=20
constant, it isn't really dynamic for a given qemu release, but rather a=20
different way to spell things; about the only thing it would buy us is=20
that our cutoff window for what cluster size no longer gets the header=20
may automatically shift from 2k to 4k to 8k as future qemu versions add=20
more qcow2 features.  If we want to write it like that, which size limit=20
do you propose?  Or asked differently, how much space should we reserve=20
for other extension headers + backing file name?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


