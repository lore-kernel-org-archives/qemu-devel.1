Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URG_BIZ autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49805C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:12:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1448B22314
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KnC3YZ6g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1448B22314
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2fSD-00021B-6D
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 13:12:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59965)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j2fRb-0001Zx-BQ
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:12:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j2fRZ-0005TI-Dk
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:12:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43708
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j2fRZ-0005SY-9M
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:12:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581703920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cCDyWW+YXuXaTwfieaGljmIX92OmsSPpwtoelgx030E=;
 b=KnC3YZ6gqfADhkUnAYlLVQ8sgGUkfCqL6pqQjnspnVT44xCpdJsoVMmwGr6MduJ93p92em
 dV+oAd0oEof8Ofl+HOazNeKTIsoSSQo7upanHOs4Hf+DyhVIx8TFE3Mc4cZV5cmFKKWANt
 uG1Qp3ng49jXgRZJ2VVnmz3ojcqHeoI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-y9P6ROZUP-CdJ43IajP3hA-1; Fri, 14 Feb 2020 13:11:58 -0500
Received: by mail-qv1-f72.google.com with SMTP id z39so6230962qve.5
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 10:11:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=aaLjfa80pqB2gzJieIfmy4toBGFs0CCwU8xIfF7/g2g=;
 b=RhKwtNkK275YEkMO+OPGw1xxNfkg1+7lMVimU0Uz+zbvLfnHxHEUe+gLW50Tyt19zL
 bjSqUfkirwk/Rk00Ke8OAlZ1I18D2lHwXkQRQUjrMlOuSYOWccsMH4mnNM1vM/KAtCo3
 0Cr39315jCbMrOAZdLfSFRB9j4AK2Bpv9TgVCKrV1qk5zLNMuUufG1E9kstfgtr5rJsE
 bGfzCOkSH5zvSIFbCc5DqfbVibGkpSAl2gFu8tfx1JMuKj2LRitLAh4tu1DbFQymTHMv
 QJw0CC6gHxECNFuEV3YQDn3TwYFxq2s3xwMWX31YDamiF5oa3gPrettmY9NbW72w1nYm
 51kw==
X-Gm-Message-State: APjAAAWrHHlH9u8a1B8GvpHS9IVyaE26jGQwUZOGPyIYWXz32HwEYaOH
 CAIjxHb/J9EIojZUP20lK0jtg3ICj4nR95C6pXAj7shH7HMcwbmvC2u+mSNBpYAOijoVNvTqxdW
 Y85JOL58UTv5Rrtw=
X-Received: by 2002:ac8:7258:: with SMTP id l24mr3576757qtp.154.1581703917937; 
 Fri, 14 Feb 2020 10:11:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqzHXYs7TGpi86VQexOC/QYpApNEXvlDoiKDuhVap9TsPDzOQXfGWYKKe+y/4bmtngvc6IRblQ==
X-Received: by 2002:ac8:7258:: with SMTP id l24mr3576734qtp.154.1581703917649; 
 Fri, 14 Feb 2020 10:11:57 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id a13sm3778138qkh.123.2020.02.14.10.11.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 10:11:47 -0800 (PST)
Date: Fri, 14 Feb 2020 13:11:46 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC] memory: Don't allow to resize RAM while migrating
Message-ID: <20200214181146.GE1163818@xz-x1>
References: <20200213172016.196609-1-david@redhat.com>
 <20200214102514.GB3283@work-vm>
 <30a66b1d-184e-a684-d0d2-c3921366b478@redhat.com>
 <20200214104230.GC3283@work-vm>
 <cd295e35-72ca-e335-35be-f38bb9026e48@redhat.com>
 <20200214110226.GD3283@work-vm>
 <9a15fd0e-77d1-b3a0-4824-665f85f79c71@redhat.com>
 <bb33b209-2b15-4bbd-7fe9-3aa813e4c194@redhat.com>
 <20200214172933.GC1163818@xz-x1>
 <9597c9a9-05d2-d99d-e153-8ffc112910bc@redhat.com>
MIME-Version: 1.0
In-Reply-To: <9597c9a9-05d2-d99d-e153-8ffc112910bc@redhat.com>
X-MC-Unique: y9P6ROZUP-CdJ43IajP3hA-1
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

On Fri, Feb 14, 2020 at 06:32:35PM +0100, David Hildenbrand wrote:
> On 14.02.20 18:29, Peter Xu wrote:
> > On Fri, Feb 14, 2020 at 01:02:46PM +0100, David Hildenbrand wrote:
> >> From c0049ac2e95d6756037db918852c507fb88297d9 Mon Sep 17 00:00:00 2001
> >> From: David Hildenbrand <david@redhat.com>
> >> Date: Fri, 14 Feb 2020 13:01:03 +0100
> >> Subject: [PATCH v1] tmp
> >>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>  migration/migration.c |  9 +++++++--
> >>  migration/migration.h |  1 +
> >>  migration/ram.c       | 42 ++++++++++++++++++++++++++++++++++++++++++
> >>  3 files changed, 50 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/migration/migration.c b/migration/migration.c
> >> index 3a21a4686c..0e7efe2920 100644
> >> --- a/migration/migration.c
> >> +++ b/migration/migration.c
> >> @@ -175,13 +175,18 @@ void migration_object_init(void)
> >>      }
> >>  }
> >> =20
> >> +void migration_cancel(void)
> >> +{
> >> +    migrate_fd_cancel(current_migration);
> >> +}
> >> +
> >>  void migration_shutdown(void)
> >>  {
> >>      /*
> >>       * Cancel the current migration - that will (eventually)
> >>       * stop the migration using this structure
> >>       */
> >> -    migrate_fd_cancel(current_migration);
> >> +    migration_cancel();
> >>      object_unref(OBJECT(current_migration));
> >>  }
> >> =20
> >> @@ -2019,7 +2024,7 @@ void qmp_migrate(const char *uri, bool has_blk, =
bool blk,
> >> =20
> >>  void qmp_migrate_cancel(Error **errp)
> >>  {
> >> -    migrate_fd_cancel(migrate_get_current());
> >> +    migration_cancel();
> >>  }
> >> =20
> >>  void qmp_migrate_continue(MigrationStatus state, Error **errp)
> >> diff --git a/migration/migration.h b/migration/migration.h
> >> index 8473ddfc88..79fd74afa5 100644
> >> --- a/migration/migration.h
> >> +++ b/migration/migration.h
> >> @@ -343,5 +343,6 @@ int foreach_not_ignored_block(RAMBlockIterFunc fun=
c, void *opaque);
> >>  void migration_make_urgent_request(void);
> >>  void migration_consume_urgent_request(void);
> >>  bool migration_rate_limit(void);
> >> +void migration_cancel(void);
> >> =20
> >>  #endif
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
> >=20
> > I feel like migration_is_idle() check is enough.  Firstly, I feel like
> > we allow migration even with VM stopped.  At the meantime, if VM is
> > not running, I see no reason that this resizing will happen after all? =
:)
>=20
> Migration code resizes ram blocks when synchronizing the ram state. See
> qemu_ram_resize() in ram_load_precopy()
>=20
> That happens on incoming migration while the vm is stopped.

Ah so your comment is for that which I misread.  I'm surprised even
the incoming migration will set MigrationState and migration_is_idle()
will return false for it, since we've got MigrationIncomingState after
all.  But yeh that seems to be correct.

Then it seems fine.  It's just a bit unclear even with the comment.
Another alternative is we only register this resize() hook when
migration starts, and unregister it when stopped.  Then we can even
drop the migration_is_idle().

>=20
> >=20
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
> > Now I'm rethinking the postcopy case....
> >=20
> > ram_dirty_bitmap_reload() should only happen during the postcopy
> > recovery, and when that happens the VM should be stopped on both
> > sides.  Which means, ram resizing should not trigger there...
>=20
> But that guest got the chance to run for a bit and eventually reboot
> AFAIK. Also, there are other data races possible when used_length
> suddenly changes, this is just the most obvious one where things will;
> get screwed up.

Right, the major one could be in ram_load_postcopy() where we call
host_from_ram_block_offset().  However if FW extension is the major
use case then it seems to still work (still better than crashing,
isn't it? :).  Or could you let me know where else did I overlook?

Thanks,

--=20
Peter Xu


