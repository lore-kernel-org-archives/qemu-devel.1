Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10861C2D0EF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 20:25:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD8C620724
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 20:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yr1LD2hF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD8C620724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPXYg-0000V5-W7
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 16:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32935)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jPXXu-00080J-6Q
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 16:25:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jPXXr-000686-V8
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 16:25:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41747
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jPXXr-00065u-P7
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 16:25:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587155100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IlGVH0jDcgY8G+8A/9c7Gq29RK8hHh1VoHllYeH3Q1o=;
 b=Yr1LD2hF0oouBAXaetPCDKiJ7Ni7/UEg+Wt4sg2+McARssYl6OX9p3Ez7dDEhkg2TkItrU
 G4u+oz2YsBS5MlOegaHrEKSBVkwx0JodV1DSDkZUcSEyNihRShniI29yx9fzUIOl9uKGJU
 oSeD6UvGi/ojxAtywuzWVahQv6ncxyc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-O2wvpwLnPrey_XOQKuSuWg-1; Fri, 17 Apr 2020 16:24:54 -0400
X-MC-Unique: O2wvpwLnPrey_XOQKuSuWg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 424A413F6;
 Fri, 17 Apr 2020 20:24:53 +0000 (UTC)
Received: from [10.3.115.59] (ovpn-115-59.phx2.redhat.com [10.3.115.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9157060BE0;
 Fri, 17 Apr 2020 20:24:52 +0000 (UTC)
Subject: Re: Avoid copying unallocated clusters during full backup
To: John Snow <jsnow@redhat.com>, Leo Luan <leoluan@gmail.com>,
 qemu-devel@nongnu.org, Qemu-block <qemu-block@nongnu.org>
References: <CAD_3s9Jnd9BzkZAe6SEKz7unuxJHY502pNdUgxrC3MOQAFj9Hw@mail.gmail.com>
 <ba8ff0c2-2e56-c8d7-a13a-4af48372f172@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <7c722a98-29ab-ba65-2f19-088628ce8f00@redhat.com>
Date: Fri, 17 Apr 2020 15:24:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <ba8ff0c2-2e56-c8d7-a13a-4af48372f172@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/17/20 3:11 PM, John Snow wrote:

>> +
>> + =C2=A0 =C2=A0if (s->sync_mode =3D=3D MIRROR_SYNC_MODE_FULL &&
>> + =C2=A0 =C2=A0 =C2=A0 s->bcs->target->bs->drv !=3D NULL &&
>> + =C2=A0 =C2=A0 =C2=A0 strncmp(s->bcs->target->bs->drv->format_name, "qc=
ow2", 5) =3D=3D 0 &&
>> + =C2=A0 =C2=A0 =C2=A0 s->bcs->source->bs->backing_file[0] =3D=3D '\0')
>=20
> This isn't going to suffice upstream; the backup job can't be performing
> format introspection to determine behavior on the fly.

Agreed.  The idea is right (we NEED to make backup operations smarter=20
based on knowledge about both source and destination block status), but=20
the implementation is not (a check for strcncmp("qcow2") is not ideal).

>=20
> I think what you're really after is something like
> bdrv_unallocated_blocks_are_zero().

The fact that qemu-img already has a lot of optimizations makes me=20
wonder what we can salvage from there into reusable code that both=20
qemu-img and block backup can share, so that we're not reimplementing=20
block status handling in multiple places.

> So the basic premise is that if you are copying a qcow2 file and the
> unallocated portions as defined by the qcow2 metadata are zero, it's
> safe to skip those, so you can treat it like SYNC_MODE_TOP.
>=20
> I think you *also* have to know if the *source* needs those regions
> explicitly zeroed, and it's not always safe to just skip them at the
> manifest level.
>=20
> I thought there was code that handled this to some extent already, but I
> don't know. I think Vladimir has worked on it recently and can probably
> let you know where I am mistaken :)

Yes, I'm hoping Vladimir (or his other buddies at Virtuozzo) can chime=20
in.  Meanwhile, I've working on v2 of some patches that will improve=20
qemu's ability to tell if a destination qcow2 file already reads as all=20
zeroes, and we already have bdrv_block_status() for telling which=20
portions of a source image already read as all zeroes (whether or not it=20
is due to not being allocated, the goal here is that we should NOT have=20
to copy anything that reads as zero on the source over to the=20
destination if the destination already starts life as reading all zero).

And if nothing else, qemu 5.0 just added 'qemu-img convert=20
--target-is-zero' as a last-ditch means of telling qemu to assume the=20
destination reads as all zeroes, even if it cannot quickly prove it; we=20
probably want to add a similar knob into the QMP commands for initiating=20
block backup, for the same reasons.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


