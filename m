Received: from eggs.gnu.org ([2001:4830:134:3::10]:38228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ds644-00028p-31
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:42:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ds640-000729-1a
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:42:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:14904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ds63z-00071B-Sf
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:42:39 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C036F81E14
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 11:42:38 +0000 (UTC)
Date: Wed, 13 Sep 2017 12:42:31 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170913114231.GD3067@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170913105953.13760-1-quintela@redhat.com>
	<20170913105953.13760-17-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170913105953.13760-17-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 16/20] migration: Create thread
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

On Wed, Sep 13, 2017 at 12:59:49PM +0200, Juan Quintela wrote:
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
> Use multifd_clear_pages().
> Don't remove object_unref()
> ---
>  migration/migration.c |  7 ++++---
>  migration/migration.h |  1 +
>  migration/ram.c       | 55 +++++++++++++++++++++++++++++++++++++++++++++++----
>  migration/socket.c    |  2 +-
>  4 files changed, 57 insertions(+), 8 deletions(-)
> 

> diff --git a/migration/socket.c b/migration/socket.c
> index 22fb05edc8..63dedb22e8 100644
> --- a/migration/socket.c
> +++ b/migration/socket.c
> @@ -180,12 +180,12 @@ static gboolean socket_accept_incoming_migration(QIOChannel *ioc,
>  
>      qio_channel_set_name(QIO_CHANNEL(sioc), "migration-socket-incoming");
>      migration_channel_process_incoming(QIO_CHANNEL(sioc));
> -    object_unref(OBJECT(sioc));

As before - this creates a reference leak.  migration_channel_process_incoming
will acquire its own reference on 'sioc', so we must drop the reference that
this function owns.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
