Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90B6C32771
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 09:39:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93BCA20838
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 09:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bbSvSjp/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93BCA20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuvR8-0003N6-Qz
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 04:39:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33736)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iuvQN-0002cL-Tg
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 04:38:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iuvQM-0005RZ-NZ
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 04:38:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50458
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iuvQM-0005R5-Jo
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 04:38:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579858726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p5xtIw1/Nwl4sB5Bb6PPHPzzrjsVDpTh75h5z4JrcMU=;
 b=bbSvSjp/LrkR0HDknmavLnpRVYM9BjZXa7D/c9S853z8pqN3m0txIYE+g9vZ2rbmbGcPw2
 SfldY5lWGu9bDm01KmkXyh8fVrzKaTITKfFFJ3tS0Bl29ZL7geKkZC0+friz72F/p5OJiw
 KwOlZd7Cac/SVmt6WOC3Bj7f9q5tMtU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-B_CFLA0kOBqwGSeNRFQlDQ-1; Fri, 24 Jan 2020 04:38:43 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2062618C8C01
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 09:38:43 +0000 (UTC)
Received: from work-vm (ovpn-117-253.ams2.redhat.com [10.36.117.253])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A6245C28D;
 Fri, 24 Jan 2020 09:38:38 +0000 (UTC)
Date: Fri, 24 Jan 2020 09:38:36 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v3 05/21] migration: Create migration_is_running()
Message-ID: <20200124093836.GC2970@work-vm>
References: <20200123115831.36842-1-quintela@redhat.com>
 <20200123115831.36842-6-quintela@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200123115831.36842-6-quintela@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: B_CFLA0kOBqwGSeNRFQlDQ-1
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Juan Quintela (quintela@redhat.com) wrote:
> This function returns if we are in the middle of a migration.
> It is like migration_is_setup_or_active() with CANCELLING and COLO.
> Adapt all calers that are needed.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Yes; the inclusion of cancelling is interesting because it's a state
where you don't want to be running but it still is.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/migration.c | 29 ++++++++++++++++++++++++-----
>  migration/migration.h |  1 +
>  migration/savevm.c    |  4 +---
>  3 files changed, 26 insertions(+), 8 deletions(-)
>=20
> diff --git a/migration/migration.c b/migration/migration.c
> index 990bff00c0..1fb0aab44d 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -829,6 +829,27 @@ bool migration_is_setup_or_active(int state)
>      }
>  }
> =20
> +bool migration_is_running(int state)
> +{
> +    switch (state) {
> +    case MIGRATION_STATUS_ACTIVE:
> +    case MIGRATION_STATUS_POSTCOPY_ACTIVE:
> +    case MIGRATION_STATUS_POSTCOPY_PAUSED:
> +    case MIGRATION_STATUS_POSTCOPY_RECOVER:
> +    case MIGRATION_STATUS_SETUP:
> +    case MIGRATION_STATUS_PRE_SWITCHOVER:
> +    case MIGRATION_STATUS_DEVICE:
> +    case MIGRATION_STATUS_WAIT_UNPLUG:
> +    case MIGRATION_STATUS_CANCELLING:
> +    case MIGRATION_STATUS_COLO:
> +        return true;
> +
> +    default:
> +        return false;
> +
> +    }
> +}
> +
>  static void populate_time_info(MigrationInfo *info, MigrationState *s)
>  {
>      info->has_status =3D true;
> @@ -1077,7 +1098,7 @@ void qmp_migrate_set_capabilities(MigrationCapabili=
tyStatusList *params,
>      MigrationCapabilityStatusList *cap;
>      bool cap_list[MIGRATION_CAPABILITY__MAX];
> =20
> -    if (migration_is_setup_or_active(s->state)) {
> +    if (migration_is_running(s->state)) {
>          error_setg(errp, QERR_MIGRATION_ACTIVE);
>          return;
>      }
> @@ -1590,7 +1611,7 @@ static void migrate_fd_cancel(MigrationState *s)
> =20
>      do {
>          old_state =3D s->state;
> -        if (!migration_is_setup_or_active(old_state)) {
> +        if (!migration_is_running(old_state)) {
>              break;
>          }
>          /* If the migration is paused, kick it out of the pause */
> @@ -1888,9 +1909,7 @@ static bool migrate_prepare(MigrationState *s, bool=
 blk, bool blk_inc,
>          return true;
>      }
> =20
> -    if (migration_is_setup_or_active(s->state) ||
> -        s->state =3D=3D MIGRATION_STATUS_CANCELLING ||
> -        s->state =3D=3D MIGRATION_STATUS_COLO) {
> +    if (migration_is_running(s->state)) {
>          error_setg(errp, QERR_MIGRATION_ACTIVE);
>          return false;
>      }
> diff --git a/migration/migration.h b/migration/migration.h
> index aa9ff6f27b..44b1d56929 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -279,6 +279,7 @@ void migrate_fd_error(MigrationState *s, const Error =
*error);
>  void migrate_fd_connect(MigrationState *s, Error *error_in);
> =20
>  bool migration_is_setup_or_active(int state);
> +bool migration_is_running(int state);
> =20
>  void migrate_init(MigrationState *s);
>  bool migration_is_blocked(Error **errp);
> diff --git a/migration/savevm.c b/migration/savevm.c
> index adfdca26ac..f19cb9ec7a 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1531,9 +1531,7 @@ static int qemu_savevm_state(QEMUFile *f, Error **e=
rrp)
>      MigrationState *ms =3D migrate_get_current();
>      MigrationStatus status;
> =20
> -    if (migration_is_setup_or_active(ms->state) ||
> -        ms->state =3D=3D MIGRATION_STATUS_CANCELLING ||
> -        ms->state =3D=3D MIGRATION_STATUS_COLO) {
> +    if (migration_is_running(ms->state)) {
>          error_setg(errp, QERR_MIGRATION_ACTIVE);
>          return -EINVAL;
>      }
> --=20
> 2.24.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


