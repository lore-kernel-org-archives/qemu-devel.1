Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A13C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 15:15:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C53A02465D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 15:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cHhYHvjy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C53A02465D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2ch2-0005ob-U7
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 10:15:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45937)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j2cgM-0005Kl-0H
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:15:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j2cgK-00036j-NY
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:15:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35035
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j2cgK-00035D-JP
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:15:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581693303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aS1PTaXFbNpyQStsTenstqpl8hqHDWaeVDu9BEVRlac=;
 b=cHhYHvjyV2jxqU4yq57CyxnnNwOaUx4zhl4iKT9RcgYk8k4fEiLaBRC1SKkPhK0B8JXjXO
 Dt/lZ6kOXOGrAJW8YhcN1r8zCFP3M4TvtaTLXVFHttPPMHCddJvmxnUQKNUKys2q4pu36J
 TXceqGxUylsMlcCizVGdYQMw2uDHuMc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-C-zw-bI8PKSRuOWHSJe7JQ-1; Fri, 14 Feb 2020 10:15:01 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D87F7800D4E;
 Fri, 14 Feb 2020 15:14:59 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.141])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 09D6217DC8;
 Fri, 14 Feb 2020 15:14:52 +0000 (UTC)
Date: Fri, 14 Feb 2020 15:14:50 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC] memory: Don't allow to resize RAM while migrating
Message-ID: <20200214151450.GI3283@work-vm>
References: <20200213172016.196609-1-david@redhat.com>
 <20200214102514.GB3283@work-vm>
 <30a66b1d-184e-a684-d0d2-c3921366b478@redhat.com>
 <20200214104230.GC3283@work-vm>
 <cd295e35-72ca-e335-35be-f38bb9026e48@redhat.com>
 <20200214110226.GD3283@work-vm>
 <9a15fd0e-77d1-b3a0-4824-665f85f79c71@redhat.com>
 <bb33b209-2b15-4bbd-7fe9-3aa813e4c194@redhat.com>
 <87k14pgwud.fsf@secure.laptop>
 <60ddcc66-2744-c131-f876-5a7e27a04ba8@redhat.com>
MIME-Version: 1.0
In-Reply-To: <60ddcc66-2744-c131-f876-5a7e27a04ba8@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: C-zw-bI8PKSRuOWHSJe7JQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, quintela@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Shannon Zhao <shannon.zhao@linaro.org>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* David Hildenbrand (david@redhat.com) wrote:
>=20
> >> diff --git a/migration/ram.c b/migration/ram.c
> >> index ed23ed1c7c..f86f32b453 100644
> >> --- a/migration/ram.c
> >> +++ b/migration/ram.c
> >> @@ -52,6 +52,7 @@
> >>  #include "migration/colo.h"
> >>  #include "block.h"
> >>  #include "sysemu/sysemu.h"
> >> +#include "sysemu/runstate.h"
> >>  #include "savevm.h"
> >>  #include "qemu/iov.h"
> >>  #include "multifd.h"
> >> @@ -3710,8 +3711,49 @@ static SaveVMHandlers savevm_ram_handlers =3D {
> >>      .resume_prepare =3D ram_resume_prepare,
> >>  };
> >> =20
> >> +static void ram_mig_ram_block_resized(RAMBlockNotifier *n, void *host=
,
> >> +                                      size_t old_size, size_t new_siz=
e)
> >> +{
> >> +    /*
> >> +     * We don't care about resizes triggered on incoming migration (w=
hen
> >> +     * syncing ram blocks), or of course, when no migration is going =
on.
> >> +     */
> >> +    if (migration_is_idle() || !runstate_is_running()) {
> >> +        return;
> >> +    }
> >> +
> >> +    if (!postcopy_is_running()) {
> >> +        Error *err =3D NULL;
> >> +
> >> +        /*
> >> +         * Precopy code cannot deal with the size of ram blocks chang=
ing at
> >> +         * random points in time. We're still running on the source, =
abort
> >> +         * the migration and continue running here. Make sure to wait=
 until
> >> +         * migration was canceled.
> >> +         */
> >> +        error_setg(&err, "RAM resized during precopy.");
> >> +        migrate_set_error(migrate_get_current(), err);
> >> +        error_free(err);
> >> +        migration_cancel();
> >=20
> > If we can't do anything else, this is reasonable.
> >=20
> > But as discussed before, it is still not fully clear to me _why_ are
> > ramblocks changing if we have disabled add/remove memory during migrati=
on.
>=20
>=20
> Ramblock add/remove is ties to device add/remove, which we block.
>=20
> Resize, however, it not. Here, the resize happens while the guest is
> booting up. The content/size of the ram block depends also on previous
> guest action AFAIK. There is no way from stopping the guest from doing
> that. It's required for the guest to continue booting (with ACPI).
>=20
> I'm currently working on a project which reuses resizable ram blocks in
> different context. There, I can simply defer/avoid resizing when
> migration is active. In the ACPI case, however, we cannot avoid it.
>=20
> Hope that answers your question
>=20
> >=20
> >> +    } else {
> >> +        /*
> >> +         * Postcopy code cannot deal with the size of ram blocks chan=
ging at
> >> +         * random points in time. We're running on the target. Fail h=
ard.
> >> +         *
> >> +         * TODO: How to handle this in a better way?
> >> +         */
> >> +        error_report("RAM resized during postcopy.");
> >> +        exit(-1);
> >=20
> > Idea is good, but we also need to exit destination, not only source, no=
?
>=20
> @Dave, any idea what could be the right thing to do here?

I think that's OK; postcopy_is_running() will return true on the
destination (e.g. see it's use in ram_load()) and should work.

I'd really appreciate if you could print hte RAMBlock or something at
this point - when we hit this error we're going to want to try and
figure out why.

Dave

> >=20
> >> +    }
> >> +}
> >=20
> >=20
> >=20
> >> +static RAMBlockNotifier ram_mig_ram_notifier =3D {
> >> +    .ram_block_resized =3D ram_mig_ram_block_resized,
> >> +};
> >> +
> >>  void ram_mig_init(void)
> >>  {
> >>      qemu_mutex_init(&XBZRLE.lock);
> >>      register_savevm_live("ram", 0, 4, &savevm_ram_handlers, &ram_stat=
e);
> >> +    ram_block_notifier_add(&ram_mig_ram_notifier);
> >>  }
> >=20
> > Shouldn't we remove the notifier when we finish the migration.
>=20
> It's called from main() unconditionally (so not when migration starts),
> so the notifier remains active the whole QEMU lifetime (which should be
> fine AFAIKT).
>=20
> --=20
> Thanks,
>=20
> David / dhildenb
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


