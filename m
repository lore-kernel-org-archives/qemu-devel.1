Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1762C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 12:48:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B071E20675
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 12:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H9J+ul66"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B071E20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2aOJ-0001cn-Qb
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 07:48:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40943)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1j2aNB-0000fz-9F
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 07:47:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1j2aNA-0004a4-5p
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 07:47:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28579
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1j2aN6-0004Wj-07
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 07:47:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581684423;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4TfMrPePqNvoCGuPhIpUPflu2smHXR/ny6ngYnohO3k=;
 b=H9J+ul66wt34fbVMAGfmWFLdiYGxPlN1pvTm71KQ84WrMTyjro0BAphmPRgpACtljejMpu
 gjBjRB9oS+llLKd53CK6zpgOivPkj+IFe+T+ooR7DUm8MvY5RDQixp1Aa+FaWW4QWakj7w
 86OIAjFOn+e/6DU8lIeUtKD+ONg9lOs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-IgZ312EOOgSfQR2ZdOrMuw-1; Fri, 14 Feb 2020 07:47:01 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47E16107ACCA;
 Fri, 14 Feb 2020 12:47:00 +0000 (UTC)
Received: from redhat.com (ovpn-116-40.ams2.redhat.com [10.36.116.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 38F815C12E;
 Fri, 14 Feb 2020 12:46:54 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC] memory: Don't allow to resize RAM while migrating
In-Reply-To: <bb33b209-2b15-4bbd-7fe9-3aa813e4c194@redhat.com> (David
 Hildenbrand's message of "Fri, 14 Feb 2020 13:02:46 +0100")
References: <20200213172016.196609-1-david@redhat.com>
 <20200214102514.GB3283@work-vm>
 <30a66b1d-184e-a684-d0d2-c3921366b478@redhat.com>
 <20200214104230.GC3283@work-vm>
 <cd295e35-72ca-e335-35be-f38bb9026e48@redhat.com>
 <20200214110226.GD3283@work-vm>
 <9a15fd0e-77d1-b3a0-4824-665f85f79c71@redhat.com>
 <bb33b209-2b15-4bbd-7fe9-3aa813e4c194@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Fri, 14 Feb 2020 13:46:50 +0100
Message-ID: <87k14pgwud.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: IgZ312EOOgSfQR2ZdOrMuw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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
Reply-To: quintela@redhat.com
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 qemu-devel@nongnu.org, Shannon Zhao <shannon.zhao@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

David Hildenbrand <david@redhat.com> wrote:

I agree with the removed bits.


> diff --git a/migration/ram.c b/migration/ram.c
> index ed23ed1c7c..f86f32b453 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -52,6 +52,7 @@
>  #include "migration/colo.h"
>  #include "block.h"
>  #include "sysemu/sysemu.h"
> +#include "sysemu/runstate.h"
>  #include "savevm.h"
>  #include "qemu/iov.h"
>  #include "multifd.h"
> @@ -3710,8 +3711,49 @@ static SaveVMHandlers savevm_ram_handlers =3D {
>      .resume_prepare =3D ram_resume_prepare,
>  };
> =20
> +static void ram_mig_ram_block_resized(RAMBlockNotifier *n, void *host,
> +                                      size_t old_size, size_t new_size)
> +{
> +    /*
> +     * We don't care about resizes triggered on incoming migration (when
> +     * syncing ram blocks), or of course, when no migration is going on.
> +     */
> +    if (migration_is_idle() || !runstate_is_running()) {
> +        return;
> +    }
> +
> +    if (!postcopy_is_running()) {
> +        Error *err =3D NULL;
> +
> +        /*
> +         * Precopy code cannot deal with the size of ram blocks changing=
 at
> +         * random points in time. We're still running on the source, abo=
rt
> +         * the migration and continue running here. Make sure to wait un=
til
> +         * migration was canceled.
> +         */
> +        error_setg(&err, "RAM resized during precopy.");
> +        migrate_set_error(migrate_get_current(), err);
> +        error_free(err);
> +        migration_cancel();

If we can't do anything else, this is reasonable.

But as discussed before, it is still not fully clear to me _why_ are
ramblocks changing if we have disabled add/remove memory during migration.

> +    } else {
> +        /*
> +         * Postcopy code cannot deal with the size of ram blocks changin=
g at
> +         * random points in time. We're running on the target. Fail hard=
.
> +         *
> +         * TODO: How to handle this in a better way?
> +         */
> +        error_report("RAM resized during postcopy.");
> +        exit(-1);

Idea is good, but we also need to exit destination, not only source, no?

> +    }
> +}



> +static RAMBlockNotifier ram_mig_ram_notifier =3D {
> +    .ram_block_resized =3D ram_mig_ram_block_resized,
> +};
> +
>  void ram_mig_init(void)
>  {
>      qemu_mutex_init(&XBZRLE.lock);
>      register_savevm_live("ram", 0, 4, &savevm_ram_handlers, &ram_state);
> +    ram_block_notifier_add(&ram_mig_ram_notifier);
>  }

Shouldn't we remove the notifier when we finish the migration.

Later, Juan.


