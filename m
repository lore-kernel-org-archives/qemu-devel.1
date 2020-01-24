Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7C3C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 12:58:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28E9220708
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 12:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CuMXCGi5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28E9220708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuyXW-0002sR-Cl
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 07:58:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56974)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iuyWr-0002QU-7k
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 07:57:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iuyWp-0003nf-QJ
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 07:57:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50665
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iuyWp-0003l6-Mq
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 07:57:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579870658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=prOvG680QPzrIKKsuAjYsODoesz0amq/TPx8r1Qv3sQ=;
 b=CuMXCGi5gurRjyIBn6sR+G+bQHh+CC8XQ0PTEbafvP4m4qeO2Cn3ud2+73G6HkR1GBva36
 qMx3hqyWaHM29OAE8kvS8FmEhh7nS4AvXHqatf35TaWAODRoO/as1IQ6UsXtnk0b6cMoWi
 6TNJg4EHvrXjJ9UOE6Re5wXzgN6QxxQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-tW6tBEwpMn6HgWN7F5D0jg-1; Fri, 24 Jan 2020 07:57:36 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76BEB18543AF
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 12:57:35 +0000 (UTC)
Received: from work-vm (ovpn-117-253.ams2.redhat.com [10.36.117.253])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 800D45C545;
 Fri, 24 Jan 2020 12:57:33 +0000 (UTC)
Date: Fri, 24 Jan 2020 12:57:30 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v3 07/21] migration: Make multifd_save_setup() get an
 Error parameter
Message-ID: <20200124125730.GQ2970@work-vm>
References: <20200123115831.36842-1-quintela@redhat.com>
 <20200123115831.36842-8-quintela@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200123115831.36842-8-quintela@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: tW6tBEwpMn6HgWN7F5D0jg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Juan Quintela (quintela@redhat.com) wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
>=20

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>=20
> We can't trust that error_in is not NULL.  Create a local_error.
> ---
>  migration/migration.c | 4 +++-
>  migration/ram.c       | 2 +-
>  migration/ram.h       | 2 +-
>  3 files changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/migration/migration.c b/migration/migration.c
> index 1fb0aab44d..7140d1e040 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -3367,6 +3367,7 @@ static void *migration_thread(void *opaque)
> =20
>  void migrate_fd_connect(MigrationState *s, Error *error_in)
>  {
> +    Error *local_err =3D NULL;
>      int64_t rate_limit;
>      bool resume =3D s->state =3D=3D MIGRATION_STATUS_POSTCOPY_PAUSED;
> =20
> @@ -3415,7 +3416,8 @@ void migrate_fd_connect(MigrationState *s, Error *e=
rror_in)
>          return;
>      }
> =20
> -    if (multifd_save_setup() !=3D 0) {
> +    if (multifd_save_setup(&local_err) !=3D 0) {
> +        error_report_err(local_err);
>          migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
>                            MIGRATION_STATUS_FAILED);
>          migrate_fd_cleanup(s);
> diff --git a/migration/ram.c b/migration/ram.c
> index 3fd7fdffcf..d537264ba5 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1243,7 +1243,7 @@ static void multifd_new_send_channel_async(QIOTask =
*task, gpointer opaque)
>      }
>  }
> =20
> -int multifd_save_setup(void)
> +int multifd_save_setup(Error **errp)
>  {
>      int thread_count;
>      uint32_t page_count =3D MULTIFD_PACKET_SIZE / qemu_target_page_size(=
);
> diff --git a/migration/ram.h b/migration/ram.h
> index bd0eee79b6..da22a417ea 100644
> --- a/migration/ram.h
> +++ b/migration/ram.h
> @@ -41,7 +41,7 @@ int xbzrle_cache_resize(int64_t new_size, Error **errp)=
;
>  uint64_t ram_bytes_remaining(void);
>  uint64_t ram_bytes_total(void);
> =20
> -int multifd_save_setup(void);
> +int multifd_save_setup(Error **errp);
>  void multifd_save_cleanup(void);
>  int multifd_load_setup(void);
>  int multifd_load_cleanup(Error **errp);
> --=20
> 2.24.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


