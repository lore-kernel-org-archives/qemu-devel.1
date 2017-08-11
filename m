Received: from eggs.gnu.org ([2001:4830:134:3::10]:54454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dgBsy-000828-KF
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 11:30:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dgBst-0001L1-4E
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 11:30:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dgBss-0001KU-S3
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 11:29:59 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BF372C047B90
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 15:29:56 +0000 (UTC)
Date: Fri, 11 Aug 2017 16:29:49 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170811152949.GU2554@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170808162629.32493-1-quintela@redhat.com>
	<20170808162629.32493-16-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170808162629.32493-16-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 15/19] migration: Create thread
 infrastructure for multifd recv side
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On Tue, Aug 08, 2017 at 06:26:25PM +0200, Juan Quintela wrote:
> We make the locking and the transfer of information specific, even if we
> are still receiving things through the main thread.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> 
> --
> 
> We split when we create the main channel and where we start the main
> migration thread, so we wait for the creation of the other threads.
> 
> Use multifd_clear_group().
> ---
>  migration/migration.c |  7 ++++---
>  migration/migration.h |  1 +
>  migration/ram.c       | 55 +++++++++++++++++++++++++++++++++++++++++++++++----
>  migration/socket.c    |  2 +-
>  4 files changed, 57 insertions(+), 8 deletions(-)


> diff --git a/migration/socket.c b/migration/socket.c
> index 5dd6f42..3af9f7c 100644
> --- a/migration/socket.c
> +++ b/migration/socket.c
> @@ -183,12 +183,12 @@ static gboolean socket_accept_incoming_migration(QIOChannel *ioc,
>  
>      qio_channel_set_name(QIO_CHANNEL(sioc), "migration-socket-incoming");
>      migration_channel_process_incoming(QIO_CHANNEL(sioc));
> -    object_unref(OBJECT(sioc));

AFAICT, migration_channel_process_incoming() acquires its own reference
on 'sioc', so removing this object_unref means the code is now leaking a
reference

>  
>  out:
>      if (migration_has_all_channels()) {
>          /* Close listening socket as its no longer needed */
>          qio_channel_close(ioc, NULL);
> +        migration_incoming_process();
>          return G_SOURCE_REMOVE;
>      } else {
>          return G_SOURCE_CONTINUE;
> -- 
> 2.9.4
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
