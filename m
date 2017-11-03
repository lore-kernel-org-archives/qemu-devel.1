Received: from eggs.gnu.org ([2001:4830:134:3::10]:39515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eAYtJ-0005Zz-L1
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 06:08:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eAYtF-0007py-LH
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 06:07:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:25784)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eAYtF-0007pi-FW
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 06:07:53 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8FB06AC2C8
	for <qemu-devel@nongnu.org>; Fri,  3 Nov 2017 10:07:52 +0000 (UTC)
Date: Fri, 3 Nov 2017 10:07:46 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171103100746.GC20155@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171030112112.6952-1-quintela@redhat.com>
	<20171030112112.6952-6-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171030112112.6952-6-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/6] migration: Now set the migration uri
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

On Mon, Oct 30, 2017 at 12:21:11PM +0100, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/migration.c | 25 ++++++++++++++++++-------
>  migration/migration.h |  2 ++
>  migration/socket.c    |  7 +++++++
>  3 files changed, 27 insertions(+), 7 deletions(-)


> diff --git a/migration/socket.c b/migration/socket.c
> index 3a8232dd2d..c3ab81d1fb 100644
> --- a/migration/socket.c
> +++ b/migration/socket.c
> @@ -187,7 +187,14 @@ void tcp_start_incoming_migration(const char *host_port, Error **errp)
>      Error *err = NULL;
>      SocketAddress *saddr = tcp_build_address(host_port, &err);
>      if (!err) {
> +        char *new_uri;
>          socket_start_incoming_migration(saddr, &err);
> +        if (!err) {
> +            new_uri = g_strdup_printf("tcp:%s:%s", saddr->u.inet.host,
> +                                      saddr->u.inet.port);

This is bad as it is throwing away data that the original URI had. In particular
you loose the 'ipv4=on|off' and 'ipv6=on|off' flags. If you need to keep the
original URI for later, then why not just keep the 'host_port' parameter that
was passed into this function instead of trying to reverse engineeer the URI ?


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
