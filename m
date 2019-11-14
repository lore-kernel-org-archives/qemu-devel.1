Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3162C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 13:34:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FA63205C9
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 13:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OvPSI+Il"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FA63205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVFGY-00070Q-RL
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 08:34:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33984)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iVFFk-0006TZ-5B
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 08:33:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iVFFi-0005P4-3B
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 08:33:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37766
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iVFFg-0005Nb-EZ
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 08:33:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573738415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rE+OsOm1tzwoGvgsDCgHmvJ+eQxX6GL50Yt7y8Ah0Mc=;
 b=OvPSI+IlAaP9UAI9+yUEeBDRFni8xIM7Pb3i0TLiifA83bM7W6Ueowc7jzcH+r6tjZwHWB
 XwDpVWD5u4AZ5Yo26eut9CkBXw09gAi7IFrxhOKrai5jqBJEY7iPBAhQ6p+Piojh30F8je
 AvmqLqe00yhpC14LFpH8l5mlDAX02/0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-PRROUcamMDyWuyCGrlMB1A-1; Thu, 14 Nov 2019 08:33:32 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C20CA107ACC8;
 Thu, 14 Nov 2019 13:33:30 +0000 (UTC)
Received: from [10.3.116.242] (ovpn-116-242.phx2.redhat.com [10.3.116.242])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D153110013D9;
 Thu, 14 Nov 2019 13:33:29 +0000 (UTC)
Subject: Re: [PATCH v3 1/4] nbd/server: Prefer heap over stack for parsing
 client names
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20191114024635.11363-1-eblake@redhat.com>
 <20191114024635.11363-2-eblake@redhat.com>
 <afcf9e178e7fa28b495756020c0b9bbf189d67b8.camel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <4fe7cc9a-f798-de4c-2480-b2b29d319072@redhat.com>
Date: Thu, 14 Nov 2019 07:33:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <afcf9e178e7fa28b495756020c0b9bbf189d67b8.camel@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: PRROUcamMDyWuyCGrlMB1A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/14/19 4:04 AM, Maxim Levitsky wrote:
> On Wed, 2019-11-13 at 20:46 -0600, Eric Blake wrote:
>> As long as we limit NBD names to 256 bytes (the bare minimum permitted
>> by the standard), stack-allocation works for parsing a name received
>> from the client.  But as mentioned in a comment, we eventually want to
>> permit up to the 4k maximum of the NBD standard, which is too large
>> for stack allocation; so switch everything in the server to use heap
>> allocation.  For now, there is no change in actually supported name
>> length.
>=20
> I am just curios, why is this so?
> I know that kernel uses 8K stacks due to historical limitation
> of 1:1 physical memory mapping which creates fragmentation,
> but in the userspace stacks shouldn't really be limited and grow on deman=
d.

Actually, 4k rather than 8k stack overflow guard pages are typical on=20
some OS.  The problem with stack-allocating anything larger than the=20
guard page size is that you can end up overshooting the guard page, and=20
then the OS is unable to catch stack overflow in the normal manner of=20
sending SIGSEGV.  Also, when using coroutines, it is very common to have=20
limited stack size in the first place, where large stack allocations can=20
run into issues.  So in general, it's a good rule of thumb to never=20
stack-allocate something if it can be larger than 4k.

> Some gcc security option limits this?

Not by default, but you can compile with -Wframe-larger-than=3D4096 (or=20
even smaller) to catch instances where stack allocation is likely to run=20
into trouble.


>> @@ -427,7 +431,7 @@ static void nbd_check_meta_export(NBDClient *client)
>>   static int nbd_negotiate_handle_export_name(NBDClient *client, bool no=
_zeroes,
>>                                               Error **errp)
>>   {
>> -    char name[NBD_MAX_NAME_SIZE + 1];
>> +    g_autofree char *name;
>=20
> That is what patchew complained about I think.

Yes, and I've already fixed the missing initializer.

>=20
> Isn't it wonderful how g_autofree fixes one issue
> and introduces another. I mean 'name' isn't really
> used here prior to allocation according to plain C,
> but due to g_autofree, it can be now on any error
> path. Nothing against g_autofree though, just noting this.

Yes, and our documentation for g_auto* reminds that all such variables=20
with automatic cleanup must have an initializer or be set prior to any=20
exit path.  I think I see why I didn't catch it beforehand - I'm=20
compiling with --enable-debug, which passes CFLAGS=3D-g, while the=20
compiler warning occurs when -O2 is in effect; but it is rather annoying=20
that gcc doesn't catch the bug when not optimizing.

>=20
> Looks correct, but I might have missed something.
>=20
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
>=20

Thanks, and assuming that's with my initializer fix squashed in.

> Best regards,
> =09Maxim Levitsky
>=20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


