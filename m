Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7883BC34021
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 16:57:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44535214D8
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 16:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XV3RtWPo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44535214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3jiO-0005A2-Fm
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 11:57:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60004)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j3jhn-0004YU-BA
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 11:57:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j3jhl-00022O-Gy
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 11:57:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38130
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j3jhl-00022G-Cp
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 11:57:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581958628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6c5B+ZTCMgj/dhFRB8oi4b3XVM3a2A/1i/dWTcn/t44=;
 b=XV3RtWPoB9Othj3kikjaeE70Dwh++uA/nCTs9BzdWq+4bUfoLKQqbS8mXpQHWeSVgJel+t
 jf51Oax6TYrwLQm7jL5uZ65pkOdzTXoV3BVQso8UfPahec3GjKuuqPsgTbZkpC6naVxOQ4
 Of+ULXqThcp3CUfly7QHHABnYT+WVNg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-QEP7u5xTN7C9bjNA7Cbf7w-1; Mon, 17 Feb 2020 11:57:04 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC32A800D5A;
 Mon, 17 Feb 2020 16:57:03 +0000 (UTC)
Received: from work-vm (ovpn-116-78.ams2.redhat.com [10.36.116.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BB7CD5C219;
 Mon, 17 Feb 2020 16:57:02 +0000 (UTC)
Date: Mon, 17 Feb 2020 16:57:00 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v2 11/22] migration/savevm: don't worry if bitmap
 migration postcopy failed
Message-ID: <20200217165700.GO3434@work-vm>
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
 <20200217150246.29180-12-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200217150246.29180-12-vsementsov@virtuozzo.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: QEP7u5xTN7C9bjNA7Cbf7w-1
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
Cc: andrey.shinkevich@virtuozzo.com, qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
> First, if only bitmaps postcopy enabled (not ram postcopy)
> postcopy_pause_incoming crashes on assertion assert(mis->to_src_file).
>=20
> And anyway, bitmaps postcopy is not prepared to be somehow recovered.
> The original idea instead is that if bitmaps postcopy failed, we just
> loss some bitmaps, which is not critical. So, on failure we just need
> to remove unfinished bitmaps and guest should continue execution on
> destination.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/savevm.c | 37 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 32 insertions(+), 5 deletions(-)
>=20
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 1d4220ece8..7e9dd58ccb 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1812,6 +1812,9 @@ static void *postcopy_ram_listen_thread(void *opaqu=
e)
>      MigrationIncomingState *mis =3D migration_incoming_get_current();
>      QEMUFile *f =3D mis->from_src_file;
>      int load_res;
> +    MigrationState *migr =3D migrate_get_current();
> +
> +    object_ref(OBJECT(migr));
> =20
>      migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
>                                     MIGRATION_STATUS_POSTCOPY_ACTIVE);
> @@ -1838,11 +1841,24 @@ static void *postcopy_ram_listen_thread(void *opa=
que)
> =20
>      trace_postcopy_ram_listen_thread_exit();
>      if (load_res < 0) {
> -        error_report("%s: loadvm failed: %d", __func__, load_res);
>          qemu_file_set_error(f, load_res);
> -        migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
> -                                       MIGRATION_STATUS_FAILED);
> -    } else {
> +        dirty_bitmap_mig_cancel_incoming();
> +        if (postcopy_state_get() =3D=3D POSTCOPY_INCOMING_RUNNING &&
> +            !migrate_postcopy_ram() && migrate_dirty_bitmaps())
> +        {
> +            error_report("%s: loadvm failed during postcopy: %d. All sta=
te is "
> +                         "migrated except for dirty bitmaps. Some dirty =
"
> +                         "bitmaps may be lost, and present migrated dirt=
y "
> +                         "bitmaps are correctly migrated and valid.",
> +                         __func__, load_res);
> +            load_res =3D 0; /* prevent further exit() */
> +        } else {
> +            error_report("%s: loadvm failed: %d", __func__, load_res);
> +            migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACT=
IVE,
> +                                           MIGRATION_STATUS_FAILED);
> +        }
> +    }
> +    if (load_res >=3D 0) {
>          /*
>           * This looks good, but it's possible that the device loading in=
 the
>           * main thread hasn't finished yet, and so we might not be in 'R=
UN'
> @@ -1878,6 +1894,8 @@ static void *postcopy_ram_listen_thread(void *opaqu=
e)
>      mis->have_listen_thread =3D false;
>      postcopy_state_set(POSTCOPY_INCOMING_END);
> =20
> +    object_unref(OBJECT(migr));
> +
>      return NULL;
>  }
> =20
> @@ -2429,6 +2447,8 @@ static bool postcopy_pause_incoming(MigrationIncomi=
ngState *mis)
>  {
>      trace_postcopy_pause_incoming();
> =20
> +    assert(migrate_postcopy_ram());
> +
>      /* Clear the triggered bit to allow one recovery */
>      mis->postcopy_recover_triggered =3D false;
> =20
> @@ -2513,15 +2533,22 @@ out:
>      if (ret < 0) {
>          qemu_file_set_error(f, ret);
> =20
> +        /* Cancel bitmaps incoming regardless of recovery */
> +        dirty_bitmap_mig_cancel_incoming();
> +
>          /*
>           * If we are during an active postcopy, then we pause instead
>           * of bail out to at least keep the VM's dirty data.  Note
>           * that POSTCOPY_INCOMING_LISTENING stage is still not enough,
>           * during which we're still receiving device states and we
>           * still haven't yet started the VM on destination.
> +         *
> +         * Only RAM postcopy supports recovery. Still, if RAM postcopy i=
s
> +         * enabled, canceled bitmaps postcopy will not affect RAM postco=
py
> +         * recovering.
>           */
>          if (postcopy_state_get() =3D=3D POSTCOPY_INCOMING_RUNNING &&
> -            postcopy_pause_incoming(mis)) {
> +            migrate_postcopy_ram() && postcopy_pause_incoming(mis)) {
>              /* Reset f to point to the newly created channel */
>              f =3D mis->from_src_file;
>              goto retry;
> --=20
> 2.21.0
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


