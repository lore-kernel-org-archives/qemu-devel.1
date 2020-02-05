Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945C0C35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:37:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 643F32082E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GpAR8rVb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 643F32082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izLo0-0006IB-L3
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 09:37:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57635)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1izLnG-0005Tq-BX
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:36:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1izLnF-0001gj-9O
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:36:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60957
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1izLnF-0001gA-6M
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:36:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580913400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yrlc6HDStESZRhIP2CpgGluBGKZfl+1mtu/uEt0nqco=;
 b=GpAR8rVb+OlfpMrVqi22FsRt1tPMKv8/GrEYYnXlIQdFjEjplSFnnz7k78fFx6ogqzHjUZ
 K9MCCa6FQ3zBgfq3jk1ozUdWO7cgNrwI1nAKDaJmAbZYGlKvNjIPBQ3VNqO8Cljhw4kyH8
 qC1wkm/R5o3YxXA5oOndGTOi2QvgTuI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-P2FIMRFHNz63zKP5taBnbQ-1; Wed, 05 Feb 2020 09:36:36 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 985091922961;
 Wed,  5 Feb 2020 14:36:34 +0000 (UTC)
Received: from [10.3.116.181] (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B7601001B05;
 Wed,  5 Feb 2020 14:36:27 +0000 (UTC)
Subject: Re: [PATCH 09/17] block: Refactor bdrv_has_zero_init{,_truncate}
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20200131174436.2961874-1-eblake@redhat.com>
 <20200131174436.2961874-10-eblake@redhat.com>
 <339f0a60-1e4f-286c-6594-1153bf284082@virtuozzo.com>
 <62078ab7-b46f-cb70-ffb1-5e84c7e1bee5@redhat.com>
 <8debd8e0-52bd-a962-0877-53dd0e610f1d@virtuozzo.com>
 <945a62b8-6b50-70bf-bb7e-daacc00d5e43@redhat.com>
 <c63179c1-671c-20fe-0dbc-4cc570e026a7@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <5f0ecf50-cbcf-a7f2-9c3e-2c806abf8dcd@redhat.com>
Date: Wed, 5 Feb 2020 08:36:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <c63179c1-671c-20fe-0dbc-4cc570e026a7@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: P2FIMRFHNz63zKP5taBnbQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

On 2/5/20 8:25 AM, Vladimir Sementsov-Ogievskiy wrote:

>>>> But when you truncate them (with PREALLOC_MODE_OFF, as
>>>> BlockDriver.bdrv_has_zero_init_truncate()=E2=80=99s comment explains),=
 the new
>>>> area is always going to be 0, regardless of initial preallocation.
>>>
>>> ah yes, due to qcow2 zero clusters.
>>
>> Hmm. Do we actually set the zero flag on unallocated clusters when=20
>> resizing a qcow2 image?=C2=A0 That would be an O(n) operation (we have t=
o=20
>> visit the L2 entry for each added cluster, even if only to set the=20
>> zero cluster bit).=C2=A0 Or do we instead just rely on the fact that qco=
w2=20
>> is inherently sparse, and that when you resize the guest-visible size=20
>> without writing any new clusters, then it is only subsequent guest=20
>> access to those addresses that finally allocate clusters, making=20
>> resize O(1) (update the qcow2 metadata cluster, but not any L2 tables)=
=20
>> while still reading 0 from the new data.=C2=A0 To some extent, that's wh=
at=20
>> the allocation mode is supposed to control.
>=20
> We must mark as ZERO new cluster at least if there is a _larger_ backing=
=20
> file, to prevent data from backing file become available for the guest.=
=20
> But we don't do it. It's a bug and there is fixing series from Kevin,=20
> I've just pinged it:
> "[PATCH for-4.2? v3 0/8] block: Fix resize (extending) of short overlays"

There's a difference for a backing file larger than the qcow2 file, and=20
the protocol layer larger than the qcow2 file.  Visually, with the=20
following four nodes:

f1 [qcow2 format] <- f2 [qcow2 format]
   v                        v
p1 [file protocol]    p2 [file protocol]

If f1 is larger than f2, then resizing f2 without writing zero clusters=20
leaks the data from f1 into f2.  The block layer knows this: prior to=20
this series, bdrv_has_zero_init_truncate() returns 0 if bs->backing is=20
present; and even in this series, see patch 6/17 which continues to=20
force a 0 return rather than calling into the driver if the sizes are=20
suspect.  But that is an uncommon corner case; in short, the qcow2=20
callback .bdrv_has_zero_init_truncate is NOT reachable in that scenario,=20
whether before or after this series.

On the other hand, if p2 is larger than f2, resizing f2 reads zeroes.=20
That's because qcow2 HAS to add L2 mappings into p2 before data from p2=20
can leak, but .bdrv_co_truncate(PREALLOC_MODE_OFF) does not add any L2=20
mappings.  Thus, qcow2 blindly returning 1 for=20
.bdrv_has_zero_init_truncate was correct (other than the anomaly of=20
bs->encrypted, also fixed earlier in this series).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


