Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7D1C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 15:16:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B925420733
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 15:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JMFyFmC1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B925420733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVdL2-00058H-Is
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 10:16:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41594)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iVdK6-0004JI-Uk
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:15:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iVdK5-0002Oa-HB
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:15:46 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35991
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iVdK5-0002OH-Cl
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:15:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573830944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AFDR3bZ5jOg2lfF3KRzieqxsH3rSR1zO7NJ+2GNzzTo=;
 b=JMFyFmC11or5mM8AahvHOHozqG6e8yAoQ5sMPRwzY6JNkamWgNa3k6qGpZRsN1K5CgxoVH
 wvl750kVpGEn3fROVNfeqje1SOur044NGB9GgUaNFx71UEf5m/INVN8MCNakBHgb/IXAxx
 UdxxWKcN62hMwFbK4de1VSMBY10+cf4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-wNCBf7pxO5GYMAzbY9rNmA-1; Fri, 15 Nov 2019 10:15:43 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43F8618A9E78;
 Fri, 15 Nov 2019 15:15:42 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B356369198;
 Fri, 15 Nov 2019 15:15:37 +0000 (UTC)
Message-ID: <f38bf3f7c5d4ce50ba44dee94230b27331d1043c.camel@redhat.com>
Subject: Re: [PATCH v3 1/4] nbd/server: Prefer heap over stack for parsing
 client names
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Date: Fri, 15 Nov 2019 17:15:36 +0200
In-Reply-To: <4fe7cc9a-f798-de4c-2480-b2b29d319072@redhat.com>
References: <20191114024635.11363-1-eblake@redhat.com>
 <20191114024635.11363-2-eblake@redhat.com>
 <afcf9e178e7fa28b495756020c0b9bbf189d67b8.camel@redhat.com>
 <4fe7cc9a-f798-de4c-2480-b2b29d319072@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: wNCBf7pxO5GYMAzbY9rNmA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2019-11-14 at 07:33 -0600, Eric Blake wrote:
> On 11/14/19 4:04 AM, Maxim Levitsky wrote:
> > On Wed, 2019-11-13 at 20:46 -0600, Eric Blake wrote:
> > > As long as we limit NBD names to 256 bytes (the bare minimum permitte=
d
> > > by the standard), stack-allocation works for parsing a name received
> > > from the client.  But as mentioned in a comment, we eventually want t=
o
> > > permit up to the 4k maximum of the NBD standard, which is too large
> > > for stack allocation; so switch everything in the server to use heap
> > > allocation.  For now, there is no change in actually supported name
> > > length.
> >=20
> > I am just curios, why is this so?
> > I know that kernel uses 8K stacks due to historical limitation
> > of 1:1 physical memory mapping which creates fragmentation,
> > but in the userspace stacks shouldn't really be limited and grow on dem=
and.
>=20
> Actually, 4k rather than 8k stack overflow guard pages are typical on=20
> some OS. =20
I was talking about the kernel stacks. These are limited to 8K with
no growing and it is a pain point there. Userspace stacks on the
other hand should be able to grow to an reasonable size.


> The problem with stack-allocating anything larger than the=20
> guard page size is that you can end up overshooting the guard page, and=
=20
> then the OS is unable to catch stack overflow in the normal manner of=20
> sending SIGSEGV.  Also, when using coroutines, it is very common to have=
=20
> limited stack size in the first place, where large stack allocations can=
=20
> run into issues.  So in general, it's a good rule of thumb to never=20
> stack-allocate something if it can be larger than 4k.

Doh! I know how the guard pages work, but never thought
about them in this way. I guess I don't after all.
Thanks for the explanation!


>=20
> > Some gcc security option limits this?
>=20
> Not by default, but you can compile with -Wframe-larger-than=3D4096 (or=
=20
> even smaller) to catch instances where stack allocation is likely to run=
=20
> into trouble.
>=20
>=20
> > > @@ -427,7 +431,7 @@ static void nbd_check_meta_export(NBDClient *clie=
nt)
> > >   static int nbd_negotiate_handle_export_name(NBDClient *client, bool=
 no_zeroes,
> > >                                               Error **errp)
> > >   {
> > > -    char name[NBD_MAX_NAME_SIZE + 1];
> > > +    g_autofree char *name;
> >=20
> > That is what patchew complained about I think.
>=20
> Yes, and I've already fixed the missing initializer.
>=20
> >=20
> > Isn't it wonderful how g_autofree fixes one issue
> > and introduces another. I mean 'name' isn't really
> > used here prior to allocation according to plain C,
> > but due to g_autofree, it can be now on any error
> > path. Nothing against g_autofree though, just noting this.
>=20
> Yes, and our documentation for g_auto* reminds that all such variables=20
> with automatic cleanup must have an initializer or be set prior to any=20
> exit path.  I think I see why I didn't catch it beforehand - I'm=20
> compiling with --enable-debug, which passes CFLAGS=3D-g, while the=20
> compiler warning occurs when -O2 is in effect; but it is rather annoying=
=20
> that gcc doesn't catch the bug when not optimizing.
>=20
> >=20
> > Looks correct, but I might have missed something.
> >=20
> > Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> >=20
>=20
> Thanks, and assuming that's with my initializer fix squashed in.
Of course.

Best regards,
=09Maxim Levitsky



