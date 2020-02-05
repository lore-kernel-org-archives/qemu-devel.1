Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC67C35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:08:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BBDB21741
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hbvbdS78"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BBDB21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izLMC-00070a-Bq
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 09:08:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36600)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1izLLZ-0006No-Ik
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:08:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1izLLY-0002Aj-83
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:08:05 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28789
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1izLLY-00025C-04
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:08:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580911683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BNsBleuDBM3wjS25ALTYlhXJiYZfDXKamHTMk5BLggI=;
 b=hbvbdS780s38ZjEz6Aoamfoz+Q4fE+AAfx0VCFMcnOx1O++qnHj4oeuXpqVp5+29M9YrDO
 QWkDIq+xwo0a7ehAcoIwQTi280/yV/8TUsYdkGmC/wxB0h1HvuMIXE+QXKoJgLOik6b0Wv
 N/TCuYu94bXFHEZkH9yA2RFZWLNrUyE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-308qPeB-Nz26arw6Zg-4Mg-1; Wed, 05 Feb 2020 09:08:00 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4D6B107BAB4;
 Wed,  5 Feb 2020 14:07:57 +0000 (UTC)
Received: from [10.3.116.181] (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D185F100EBA7;
 Wed,  5 Feb 2020 14:07:50 +0000 (UTC)
Subject: Re: [PATCH 09/17] block: Refactor bdrv_has_zero_init{,_truncate}
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20200131174436.2961874-1-eblake@redhat.com>
 <20200131174436.2961874-10-eblake@redhat.com>
 <339f0a60-1e4f-286c-6594-1153bf284082@virtuozzo.com>
 <62078ab7-b46f-cb70-ffb1-5e84c7e1bee5@redhat.com>
 <8debd8e0-52bd-a962-0877-53dd0e610f1d@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <945a62b8-6b50-70bf-bb7e-daacc00d5e43@redhat.com>
Date: Wed, 5 Feb 2020 08:07:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <8debd8e0-52bd-a962-0877-53dd0e610f1d@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 308qPeB-Nz26arw6Zg-4Mg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 "open list:Sheepdog" <sheepdog@lists.wpkg.org>, qemu-block@nongnu.org,
 Jeff Cody <codyprime@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 Peter Lieven <pl@kamp.de>, "Richard W.M. Jones" <rjones@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, david.edmondson@oracle.com,
 Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Liu Yuan <namei.unix@gmail.com>, Jason Dillaman <dillaman@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/5/20 1:51 AM, Vladimir Sementsov-Ogievskiy wrote:

>>>> +typedef enum {
>>>> +=C2=A0=C2=A0=C2=A0 /*
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * bdrv_known_zeroes() should include this bi=
t if the contents of
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * a freshly-created image with no backing fi=
le reads as all
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * zeroes without any additional effort.=C2=
=A0 If .bdrv_co_truncate is
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * set, then this must be clear if BDRV_ZERO_=
TRUNCATE is clear.
>>>
>>> I understand that this is preexisting logic, but could I ask: why?
>>> What's wrong
>>> if driver can guarantee that created file is all-zero, but is not sure
>>> about
>>> file resizing? I agree that it's normal for these flags to have the sam=
e
>>> value,
>>> but what is the reason for this restriction?..
>>
>> If areas added by truncation (or growth, rather) are always zero, then
>> the file can always be created with size 0 and grown from there.=C2=A0 T=
hus,
>> images where truncation adds zeroed areas will generally always be zero
>> after creation.
>=20
> This means, that if truncation bit is set, than create bit should be=20
> set.. But
> here we say that if truncation is clear, than create bit must be clear.

Max, did we get the logic backwards?

>=20
>>
>>> So, the only possible combination of flags, when they differs, is
>>> create=3D0 and
>>> truncate=3D1.. How is it possible?
>>
>> For preallocated qcow2 images, it depends on the storage whether they
>> are actually 0 after creation.=C2=A0 Hence qcow2_has_zero_init() then de=
fers
>> to bdrv_has_zero_init() of s->data_file->bs.
>>
>> But when you truncate them (with PREALLOC_MODE_OFF, as
>> BlockDriver.bdrv_has_zero_init_truncate()=E2=80=99s comment explains), t=
he new
>> area is always going to be 0, regardless of initial preallocation.
>=20
> ah yes, due to qcow2 zero clusters.

Hmm. Do we actually set the zero flag on unallocated clusters when=20
resizing a qcow2 image?  That would be an O(n) operation (we have to=20
visit the L2 entry for each added cluster, even if only to set the zero=20
cluster bit).  Or do we instead just rely on the fact that qcow2 is=20
inherently sparse, and that when you resize the guest-visible size=20
without writing any new clusters, then it is only subsequent guest=20
access to those addresses that finally allocate clusters, making resize=20
O(1) (update the qcow2 metadata cluster, but not any L2 tables) while=20
still reading 0 from the new data.  To some extent, that's what the=20
allocation mode is supposed to control.

What about with external data images, where a resize in guest-visible=20
length requires a resize of the underlying data image?  There, we DO=20
have to worry about whether the data image resizes with zeroes (as in=20
the filesystem) or with random data (as in a block device).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


