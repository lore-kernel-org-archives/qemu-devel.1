Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E66DC47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:51:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58F7B2076D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aslAjimy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58F7B2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUAXJ-0003GO-Eq
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 10:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36316)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jUAWS-0002Gt-1z
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:50:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jUAWQ-0003jj-Nn
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:50:43 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52957
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jUAWQ-0003ib-BL
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588258241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0W5itZWXxJITXvFB4Swtr5VgHwuYzWo1UZiepGmIets=;
 b=aslAjimykwY9AA/NUpwBVr0G7D90wkXJNepBlvENflusF6ohfY/g+6SMhc33a/ld3mZ3hB
 x7xAK+iXB7cmob19Z4sWE5uzfsiTof3Trv33yUjFRlcnkhIeXIz9XjBatCWBJJu3BQeSG1
 UTtNhfldNr8iBR87GLyC9hEb3Hu7nZU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-WTKHrxBWP9aBGu51LsrX5Q-1; Thu, 30 Apr 2020 10:50:36 -0400
X-MC-Unique: WTKHrxBWP9aBGu51LsrX5Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD07D835B42;
 Thu, 30 Apr 2020 14:50:35 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9152A5C1B0;
 Thu, 30 Apr 2020 14:50:32 +0000 (UTC)
Subject: Re: [PATCH v2 2/6] blockdev: Split off basic bitmap operations for
 qemu-img
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20200421212019.170707-1-eblake@redhat.com>
 <20200421212019.170707-3-eblake@redhat.com>
 <6ce69bac-9bbc-05fd-e658-89a2ad63a322@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <a16c3c4d-272b-6c5f-9d67-2a222c8f1f88@redhat.com>
Date: Thu, 30 Apr 2020 09:50:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <6ce69bac-9bbc-05fd-e658-89a2ad63a322@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:04:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/30/20 8:59 AM, Max Reitz wrote:
> On 21.04.20 23:20, Eric Blake wrote:
>> Upcoming patches want to add some basic bitmap manipulation abilities
>> to qemu-img.  But blockdev.o is too heavyweight to link into qemu-img
>> (among other things, it would drag in block jobs and transaction
>> support - qemu-img does offline manipulation, where atomicity is less
>> important because there are no concurrent modifications to compete
>> with), so it's time to split off the bare bones of what we will need
>> into a new file blockbitmaps.o.
>>
>> In addition to exposing 6 QMP commands for use by qemu-img (add,
>> remove, clear, enable, disable, merge), this also has to export three
>> previously-static functions for use by blockdev.c transactions.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>   Makefile.objs             |   2 +-
>>   include/sysemu/blockdev.h |  14 ++
>>   blockbitmaps.c            | 324 ++++++++++++++++++++++++++++++++++++++
>=20
> Hm.  Can we get a better name?  blockdev-bitmaps.c, for example?

Sure, I'm open to bike-shed suggestions.  I'd also _really_ love to make=20
the new file NOT live in the top-level, but that's a harder task that=20
I'm not sure how to do (it's easy to tweak Makefile.objs for another=20
file in the same directory, but harder to see through the magic to=20
figure out how to relocate things).

>=20
>>   blockdev.c                | 293 ----------------------------------
>>   MAINTAINERS               |   1 +
>>   5 files changed, 340 insertions(+), 294 deletions(-)
>>   create mode 100644 blockbitmaps.c
>=20
> [...]
>=20
>> diff --git a/include/sysemu/blockdev.h b/include/sysemu/blockdev.h
>> index a86d99b3d875..523b7493b1cd 100644
>> --- a/include/sysemu/blockdev.h
>> +++ b/include/sysemu/blockdev.h
>> @@ -57,4 +57,18 @@ QemuOpts *drive_add(BlockInterfaceType type, int inde=
x, const char *file,
>>   DriveInfo *drive_new(QemuOpts *arg, BlockInterfaceType block_default_t=
ype,
>>                        Error **errp);
>>
>> +BdrvDirtyBitmap *block_dirty_bitmap_lookup(const char *node,
>> +                                           const char *name,
>> +                                           BlockDriverState **pbs,
>> +                                           Error **errp);
>> +BdrvDirtyBitmap *do_block_dirty_bitmap_remove(const char *node,
>> +                                              const char *name, bool re=
lease,
>> +                                              BlockDriverState **bitmap=
_bs,
>> +                                              Error **errp);
>> +BdrvDirtyBitmap *do_block_dirty_bitmap_merge(const char *node,
>> +                                             const char *target,
>> +                                             BlockDirtyBitmapMergeSourc=
eList *bitmaps,
>> +                                             HBitmap **backup, Error **=
errp);
>=20
> Putting do_* functions into a normal header seems a bit weird.  Would
> these fit better into block_int.h?

I don't care which header gets them, as long as things compile.=20
block_int.h seems reasonable, so I can try that.  I also wonder if I=20
should rename them at all (at which point, maybe I split this into two=20
patches - one doing the rename, the other doing the file motion).


>> +++ b/MAINTAINERS
>> @@ -1989,6 +1989,7 @@ T: git https://github.com/jnsnow/qemu.git jobs
>>   Block QAPI, monitor, command line
>>   M: Markus Armbruster <armbru@redhat.com>
>>   S: Supported
>> +F: blockbitmaps.c
>=20
> The natural choice for something split off of blockdev.c, but I wonder
> if the Dirty Bitmaps section wouldn=E2=80=99t be a better fit.

Or maybe even both?


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


