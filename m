Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA53C2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 16:48:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8977F2085B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 16:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EvsZxFE1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8977F2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inQ7l-0002sx-Ky
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 11:48:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45006)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1inQ67-00020Y-RD
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 11:46:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1inQ66-0007IQ-NY
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 11:46:51 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24475
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1inQ66-0007FY-GS
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 11:46:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578070010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gmY+vPdr9fnVNNfAQSSdAjUQOV4bYdxs6a6SwHGB8kE=;
 b=EvsZxFE1uzTobg1VbJikFOm7STHEor7VPoTRzVtzm+fL5ofaTJdCRdEnx9FYJOLLdQ2jok
 BskLoefg6KCMtjPYpclRsaPlL8OK+4e0Es8S948pbpOX7Oaz18fzRstpMC/z9RojI7AFm4
 n6qhuZ0yC9sRCFx2AX5L881+Hh99lX8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-t0vmnHxGNViuNZobrjxSlQ-1; Fri, 03 Jan 2020 11:46:49 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0EA6B18B642C
 for <qemu-devel@nongnu.org>; Fri,  3 Jan 2020 16:46:48 +0000 (UTC)
Received: from work-vm (ovpn-117-78.ams2.redhat.com [10.36.117.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F8665C28C;
 Fri,  3 Jan 2020 16:46:45 +0000 (UTC)
Date: Fri, 3 Jan 2020 16:46:43 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v2 04/10] migration: Make multifd_save_setup() get an
 Error parameter
Message-ID: <20200103164643.GL3804@work-vm>
References: <20191218020119.3776-1-quintela@redhat.com>
 <20191218020119.3776-5-quintela@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191218020119.3776-5-quintela@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: t0vmnHxGNViuNZobrjxSlQ-1
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
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/migration.c | 2 +-
>  migration/ram.c       | 2 +-
>  migration/ram.h       | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/migration/migration.c b/migration/migration.c
> index e7f707e033..5a56bd0c91 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -3400,7 +3400,7 @@ void migrate_fd_connect(MigrationState *s, Error *e=
rror_in)
>          return;
>      }
> =20
> -    if (multifd_save_setup() !=3D 0) {
> +    if (multifd_save_setup(&error_in) !=3D 0) {

I'm not sure that's right.  I think the *error passed into
migration_channel_connect, and then onto migrate_fd_connect is an
indication that an error has happened, not a place you can put
an error pointer.   Note how migration_channel_connect
frees it after the migrate_fd_connect call, it doesn't report it.

Dave

>          migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
>                            MIGRATION_STATUS_FAILED);
>          migrate_fd_cleanup(s);
> diff --git a/migration/ram.c b/migration/ram.c
> index 38070f1bb2..1f364cc23d 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1208,7 +1208,7 @@ static void multifd_new_send_channel_async(QIOTask =
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
> 2.23.0
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


