Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78785C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 16:27:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4521E2072E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 16:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JRxv7baw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4521E2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isUSl-0005pd-Av
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 11:27:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45352)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1isUS0-0005GY-UO
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 11:26:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1isURw-0005KW-4N
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 11:26:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59174
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1isURw-0005JO-00
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 11:26:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579278378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o1SCoHGlwxSj2pWHzUDgSzNc0S7n42hRqUof4YgbeH8=;
 b=JRxv7baw9TUkvBLcoOyQnYjbe1iXJEpOABLK/taH6coFknKNH5qn5KOnBlof4pLSi4Y5RA
 6PnPWzXrO8A7/+1WFHk3Rm0S7DtQRfZgibJyJeDVA3AuiZ1H23PGbdOfKwkCbFO3VVVtFD
 oaS714oCeNqxKyK9f+bT2dXB3ToUzqY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-CMyulCCvObi7XEME9zswrg-1; Fri, 17 Jan 2020 11:26:17 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 794F1107ACCC
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 16:26:16 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 33A5281207;
 Fri, 17 Jan 2020 16:26:15 +0000 (UTC)
Date: Fri, 17 Jan 2020 16:26:12 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v3 2/5] migration: Create MigrationState active field
Message-ID: <20200117162612.GN3209@work-vm>
References: <20200116154616.11569-1-quintela@redhat.com>
 <20200116154616.11569-3-quintela@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200116154616.11569-3-quintela@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: CMyulCCvObi7XEME9zswrg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Juan Quintela (quintela@redhat.com) wrote:
> Right now, there is no easy way to dectect if we have already
> cancelled/finished/failed a migration.  This field is setup to true
> when we start a migration, and it is set to false as soon as we stop
> it.
>=20
> It fixes a real bug, in ram_save_iterate() we call functions that
> wrote to the channel even if we know that migration has stopped for
> any reason.  This gives problems with multifd because we need to
> synchronize various semoaphores that we don't want to take.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Why can't you use migration_is_active() in the ram.c case?
My preference would be just to stick with something derived
from the state rather than tacking another state bit on.

> ---
>  migration/migration.c | 5 +++++
>  migration/migration.h | 5 +++++
>  migration/ram.c       | 2 +-
>  migration/savevm.c    | 2 ++
>  4 files changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/migration/migration.c b/migration/migration.c
> index 990bff00c0..60bc8710b6 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1583,6 +1583,8 @@ static void migrate_fd_cancel(MigrationState *s)
>      QEMUFile *f =3D migrate_get_current()->to_dst_file;
>      trace_migrate_fd_cancel();
> =20
> +    s->active =3D false;
> +
>      if (s->rp_state.from_dst_file) {
>          /* shutdown the rp socket, so causing the rp thread to shutdown =
*/
>          qemu_file_shutdown(s->rp_state.from_dst_file);
> @@ -2834,6 +2836,7 @@ static void migration_completion(MigrationState *s)
>      }
> =20
>      if (!migrate_colo_enabled()) {
> +        s->active =3D false;
>          migrate_set_state(&s->state, current_active_state,
>                            MIGRATION_STATUS_COMPLETED);

You've not always got these two the same way around - i.e. do you change
the state first or do you set the active state first?  I think it needs
to be consistent.

>      }
> @@ -2859,6 +2862,7 @@ fail_invalidate:
>      }
> =20
>  fail:
> +    s->active =3D false;
>      migrate_set_state(&s->state, current_active_state,
>                        MIGRATION_STATUS_FAILED);
>  }
> @@ -3289,6 +3293,7 @@ static void *migration_thread(void *opaque)
>      }
> =20
>      qemu_savevm_state_setup(s->to_dst_file);
> +    s->active =3D true;
> =20
>      if (qemu_savevm_nr_failover_devices()) {
>          migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
> diff --git a/migration/migration.h b/migration/migration.h
> index aa9ff6f27b..e0386efe95 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -169,6 +169,11 @@ struct MigrationState
> =20
>      int state;
> =20
> +    /* Is the migration channel still open.  When migration finish,
> +     * gets an error or is cancelled this becomes false.
> +     */
> +
> +    bool active;
>      /* State related to return path */
>      struct {
>          QEMUFile     *from_dst_file;
> diff --git a/migration/ram.c b/migration/ram.c
> index 8f9f3bba5b..44ca56e1ea 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3521,7 +3521,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaq=
ue)
>      ram_control_after_iterate(f, RAM_CONTROL_ROUND);
> =20
>  out:
> -    if (ret >=3D 0) {
> +    if (ret >=3D 0 && migrate_get_current()->active) {
>          multifd_send_sync_main(rs);
>          qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
>          qemu_fflush(f);
> diff --git a/migration/savevm.c b/migration/savevm.c
> index adfdca26ac..3efde5b3dd 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1550,6 +1550,7 @@ static int qemu_savevm_state(QEMUFile *f, Error **e=
rrp)
>      qemu_mutex_unlock_iothread();
>      qemu_savevm_state_header(f);
>      qemu_savevm_state_setup(f);
> +    ms->active =3D true;
>      qemu_mutex_lock_iothread();
> =20
>      while (qemu_file_get_error(f) =3D=3D 0) {
> @@ -1574,6 +1575,7 @@ static int qemu_savevm_state(QEMUFile *f, Error **e=
rrp)
>          status =3D MIGRATION_STATUS_COMPLETED;
>      }
>      migrate_set_state(&ms->state, MIGRATION_STATUS_SETUP, status);
> +    ms->active =3D false;
> =20
>      /* f is outer parameter, it should not stay in global migration stat=
e after
>       * this function finished */
> --=20
> 2.24.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


