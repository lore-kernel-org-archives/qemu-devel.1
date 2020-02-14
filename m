Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URG_BIZ autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70575C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 17:30:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4509724650
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 17:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W9PcKpnN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4509724650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2enD-0004eG-Db
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 12:30:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51526)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j2emb-0004Bx-Jt
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:29:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j2emZ-0003iF-J1
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:29:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22648
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j2emZ-0003gu-Dj
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:29:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581701378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aN4h5JLKCfKN9JLsSIUgDXn5LPGOPeQzN7KTNBDMOsk=;
 b=W9PcKpnNqWEONvBiXf4Ib7VJFEsD4KTYiwlCDCtiXfhWI5SNJc06woPZq57MpYQQeANEgP
 RakIkthW81M+gky87ODnWhtcSV64sqofQuKTqDaE6PM2TPHtMgCHZLEF88lx3Sh94SFaGy
 gDI9HkJ+9acInvzasNvsTrJcM8DT4Is=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-IFfgsdK3Pp-QmyA4WBsQ_w-1; Fri, 14 Feb 2020 12:29:36 -0500
Received: by mail-qv1-f72.google.com with SMTP id j15so6109564qvp.21
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 09:29:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3DPJFBCYtRfE9mfIPy/nbIAgUKgse/+ck7PL7Xl3UyI=;
 b=uNk6Q4NV79c4vLZ4lnRxshVrcTvWpJLj9WBAc5DaO2zPQdVGTeXEPj8oBsfGil8Xzc
 FII5ayfkiAH3oJXCinR75BW1PUEGaSTWoSZSb742a6Y8wfheewsaz9skJF6DkbVCKnEU
 TFtxlpoBoG3icsnbfogJJYRmiPe0qKuoZI4H2q/O5ow35LWnU2/mZIFCZ+m/2mweuf6c
 e4BmuCm1Xy+0nNM2Touqn0CsXinqFv/GALkPKpyAsuUxicGyqZYLAHzqv+8+R4otCoLE
 wKKXfUGkfIP9EIrs2fRbKqXphMKBBdNf3dxgzTVHLfEYxrawsvI/QbUMF1dXhKcEAxjq
 qukg==
X-Gm-Message-State: APjAAAW7Vb5i93CTkQ2oM1OZWqnG05JT3OAZtY9gV+sUz99D6MxHqBmU
 Jqt2Gdm5BgJGh4t9KD5HsHgrXmf1dVnR4bopUNzjOagEyor9f6P/0Eqk0JU2xHGD2aU+edBsssv
 gE53EUNgP/OrO24I=
X-Received: by 2002:ad4:52eb:: with SMTP id p11mr2926627qvu.211.1581701375581; 
 Fri, 14 Feb 2020 09:29:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqw8S96ZP4CPhp9q2vZBBcRpomHx3D4L9TFriE+STImS9tOw85mhCnoNGCObcp7ycw2aCOjrrA==
X-Received: by 2002:ad4:52eb:: with SMTP id p11mr2926606qvu.211.1581701375264; 
 Fri, 14 Feb 2020 09:29:35 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id p18sm3638096qkp.47.2020.02.14.09.29.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 09:29:34 -0800 (PST)
Date: Fri, 14 Feb 2020 12:29:33 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC] memory: Don't allow to resize RAM while migrating
Message-ID: <20200214172933.GC1163818@xz-x1>
References: <20200213172016.196609-1-david@redhat.com>
 <20200214102514.GB3283@work-vm>
 <30a66b1d-184e-a684-d0d2-c3921366b478@redhat.com>
 <20200214104230.GC3283@work-vm>
 <cd295e35-72ca-e335-35be-f38bb9026e48@redhat.com>
 <20200214110226.GD3283@work-vm>
 <9a15fd0e-77d1-b3a0-4824-665f85f79c71@redhat.com>
 <bb33b209-2b15-4bbd-7fe9-3aa813e4c194@redhat.com>
MIME-Version: 1.0
In-Reply-To: <bb33b209-2b15-4bbd-7fe9-3aa813e4c194@redhat.com>
X-MC-Unique: IFfgsdK3Pp-QmyA4WBsQ_w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Shannon Zhao <shannon.zhao@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 14, 2020 at 01:02:46PM +0100, David Hildenbrand wrote:
> From c0049ac2e95d6756037db918852c507fb88297d9 Mon Sep 17 00:00:00 2001
> From: David Hildenbrand <david@redhat.com>
> Date: Fri, 14 Feb 2020 13:01:03 +0100
> Subject: [PATCH v1] tmp
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  migration/migration.c |  9 +++++++--
>  migration/migration.h |  1 +
>  migration/ram.c       | 42 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 50 insertions(+), 2 deletions(-)
>=20
> diff --git a/migration/migration.c b/migration/migration.c
> index 3a21a4686c..0e7efe2920 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -175,13 +175,18 @@ void migration_object_init(void)
>      }
>  }
> =20
> +void migration_cancel(void)
> +{
> +    migrate_fd_cancel(current_migration);
> +}
> +
>  void migration_shutdown(void)
>  {
>      /*
>       * Cancel the current migration - that will (eventually)
>       * stop the migration using this structure
>       */
> -    migrate_fd_cancel(current_migration);
> +    migration_cancel();
>      object_unref(OBJECT(current_migration));
>  }
> =20
> @@ -2019,7 +2024,7 @@ void qmp_migrate(const char *uri, bool has_blk, boo=
l blk,
> =20
>  void qmp_migrate_cancel(Error **errp)
>  {
> -    migrate_fd_cancel(migrate_get_current());
> +    migration_cancel();
>  }
> =20
>  void qmp_migrate_continue(MigrationStatus state, Error **errp)
> diff --git a/migration/migration.h b/migration/migration.h
> index 8473ddfc88..79fd74afa5 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -343,5 +343,6 @@ int foreach_not_ignored_block(RAMBlockIterFunc func, =
void *opaque);
>  void migration_make_urgent_request(void);
>  void migration_consume_urgent_request(void);
>  bool migration_rate_limit(void);
> +void migration_cancel(void);
> =20
>  #endif
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

I feel like migration_is_idle() check is enough.  Firstly, I feel like
we allow migration even with VM stopped.  At the meantime, if VM is
not running, I see no reason that this resizing will happen after all? :)

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

Now I'm rethinking the postcopy case....

ram_dirty_bitmap_reload() should only happen during the postcopy
recovery, and when that happens the VM should be stopped on both
sides.  Which means, ram resizing should not trigger there...

Thanks,

> +    }
> +}
> +
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
> --=20
> 2.24.1
>=20
>=20
> Thoughts?
>=20
> --=20
> Thanks,
>=20
> David / dhildenb
>=20
>=20

--=20
Peter Xu


