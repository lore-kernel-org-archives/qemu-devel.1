Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202C8C2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 17:23:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCB48206E6
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 17:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fz9g6sts"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCB48206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inQfP-00011v-1a
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 12:23:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34312)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1inQeg-0008WK-HR
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 12:22:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1inQee-0002Gb-4L
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 12:22:33 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31857
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1inQec-0002CU-SM
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 12:22:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578072149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H0L3B1G6gYctbrayjZXJ7FcUEyUdHRCMuAW7XAromQM=;
 b=fz9g6stswRs6UzcS3VQ9N3sNaNcmXzwEvcnaiprFn0t0Gda6G3NDzow9vf0X75whdwOTte
 uyJvzkPjiCXtazlCvJ1gVmdarjc2100/gXYor3gwNTqjJwjx9kPC5jaK3TWp65E43om3g+
 iJhjik3LSejsGwGCQLPrL/TNAJXXLyw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-Ha3lpzkTNkC3Z4SZgU6jUg-1; Fri, 03 Jan 2020 12:22:28 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2ECF01005510
 for <qemu-devel@nongnu.org>; Fri,  3 Jan 2020 17:22:27 +0000 (UTC)
Received: from work-vm (ovpn-117-78.ams2.redhat.com [10.36.117.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5784860C81;
 Fri,  3 Jan 2020 17:22:25 +0000 (UTC)
Date: Fri, 3 Jan 2020 17:22:22 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v2 05/10] migration: Make multifd_load_setup() get an
 Error parameter
Message-ID: <20200103172222.GP3804@work-vm>
References: <20191218020119.3776-1-quintela@redhat.com>
 <20191218020119.3776-6-quintela@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191218020119.3776-6-quintela@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Ha3lpzkTNkC3Z4SZgU6jUg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
> We need to change the full chain to pass the Error parameter.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/migration.c | 10 +++++-----
>  migration/migration.h |  2 +-
>  migration/ram.c       |  2 +-
>  migration/ram.h       |  2 +-
>  migration/rdma.c      |  2 +-
>  5 files changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/migration/migration.c b/migration/migration.c
> index 5a56bd0c91..cf6cec5fb6 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -518,11 +518,11 @@ fail:
>      exit(EXIT_FAILURE);
>  }
> =20
> -static void migration_incoming_setup(QEMUFile *f)
> +static void migration_incoming_setup(QEMUFile *f, Error **errp)
>  {
>      MigrationIncomingState *mis =3D migration_incoming_get_current();
> =20
> -    if (multifd_load_setup() !=3D 0) {
> +    if (multifd_load_setup(errp) !=3D 0) {
>          /* We haven't been able to create multifd threads
>             nothing better to do */

But if you're taking an errp and the load fails, don't you want to
report the error before you exit? (with an error_get_pretty or
something?)

>          exit(EXIT_FAILURE);
> @@ -572,13 +572,13 @@ static bool postcopy_try_recover(QEMUFile *f)
>      return false;
>  }
> =20
> -void migration_fd_process_incoming(QEMUFile *f)
> +void migration_fd_process_incoming(QEMUFile *f, Error **errp)
>  {
>      if (postcopy_try_recover(f)) {
>          return;
>      }
> =20
> -    migration_incoming_setup(f);
> +    migration_incoming_setup(f, errp);
>      migration_incoming_process();

and if you're making incoming_setup able to fail, don't you need
to.... hmm, skip the incoming_process?

>  }
> =20
> @@ -596,7 +596,7 @@ void migration_ioc_process_incoming(QIOChannel *ioc, =
Error **errp)
>              return;
>          }
> =20
> -        migration_incoming_setup(f);
> +        migration_incoming_setup(f, errp);

Don't you need to make that use a local_err and propagate, like in the
other half of the if/else?

>          /*
>           * Common migration only needs one channel, so we can start
> diff --git a/migration/migration.h b/migration/migration.h
> index 79b3dda146..545f283ae7 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -265,7 +265,7 @@ struct MigrationState
> =20
>  void migrate_set_state(int *state, int old_state, int new_state);
> =20
> -void migration_fd_process_incoming(QEMUFile *f);
> +void migration_fd_process_incoming(QEMUFile *f, Error **errp);
>  void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp);
>  void migration_incoming_process(void);
> =20
> diff --git a/migration/ram.c b/migration/ram.c
> index 1f364cc23d..fcf50e648a 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1421,7 +1421,7 @@ static void *multifd_recv_thread(void *opaque)
>      return NULL;
>  }
> =20
> -int multifd_load_setup(void)
> +int multifd_load_setup(Error **errp)
>  {
>      int thread_count;
>      uint32_t page_count =3D MULTIFD_PACKET_SIZE / qemu_target_page_size(=
);
> diff --git a/migration/ram.h b/migration/ram.h
> index da22a417ea..42be471d52 100644
> --- a/migration/ram.h
> +++ b/migration/ram.h
> @@ -43,7 +43,7 @@ uint64_t ram_bytes_total(void);
> =20
>  int multifd_save_setup(Error **errp);
>  void multifd_save_cleanup(void);
> -int multifd_load_setup(void);
> +int multifd_load_setup(Error **errp);
>  int multifd_load_cleanup(Error **errp);
>  bool multifd_recv_all_channels_created(void);
>  bool multifd_recv_new_channel(QIOChannel *ioc, Error **errp);
> diff --git a/migration/rdma.c b/migration/rdma.c
> index e241dcb992..2379b8345b 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -4004,7 +4004,7 @@ static void rdma_accept_incoming_migration(void *op=
aque)
>      }
> =20
>      rdma->migration_started_on_destination =3D 1;
> -    migration_fd_process_incoming(f);
> +    migration_fd_process_incoming(f, errp);

Heck, the errp handling in rdma_accept_incoming_migration is very very
broken; I don't see how the errp ever gets reported or freed.
(But that's an existing problem)

>  }
> =20
>  void rdma_start_incoming_migration(const char *host_port, Error **errp)
> --=20
> 2.23.0
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


