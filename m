Received: from eggs.gnu.org ([2001:4830:134:3::10]:57578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fDS5b-0003ZS-W8
	for qemu-devel@nongnu.org; Tue, 01 May 2018 06:00:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fDS5X-0006Yj-0E
	for qemu-devel@nongnu.org; Tue, 01 May 2018 06:00:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38196 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fDS5W-0006Y5-Rh
	for qemu-devel@nongnu.org; Tue, 01 May 2018 06:00:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0B9C940858EE
	for <qemu-devel@nongnu.org>; Tue,  1 May 2018 10:00:43 +0000 (UTC)
Date: Tue, 1 May 2018 11:00:35 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180501100035.GJ5708@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180430185943.35714-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180430185943.35714-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Migration+TLS: Fix crash due to double
 cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, pkrempa@redhat.com, quintela@redhat.com, peterx@redhat.com

On Mon, Apr 30, 2018 at 07:59:43PM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> During a TLS connect we see:
>   migration_channel_connect calls
>   migration_tls_channel_connect
>   (calls after TLS setup)
>   migration_channel_connect
> 
> My previous error handling fix made migration_channel_connect
> call migrate_fd_connect in all cases; unfortunately the above
> means it gets called twice and crashes doing double cleanup.
> 
> Fixes: 688a3dcba98

This fixes the crash, but we're still seeing error messages duplicated

(qemu) migrate_set_parameter tls-creds tls0
(qemu) migrate tcp:localhost:9000
qemu-system-x86_64: Certificate does not match the hostname localhost
qemu-system-x86_64: Certificate does not match the hostname localhost

git bisect points to 688a3dcba98 as the cause of these double
errors still.

> 
> Reported-by: Peter Krempa <pkrempa@redhat.com>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  migration/channel.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/migration/channel.c b/migration/channel.c
> index c5eaf0fa0e..7a32b5aca4 100644
> --- a/migration/channel.c
> +++ b/migration/channel.c
> @@ -71,6 +71,15 @@ void migration_channel_connect(MigrationState *s,
>              !object_dynamic_cast(OBJECT(ioc),
>                                   TYPE_QIO_CHANNEL_TLS)) {
>              migration_tls_channel_connect(s, ioc, hostname, &error);
> +
> +            if (!error) {
> +                /* tls_channel_connect will call back to this
> +                 * function after the TLS handshake,
> +                 * so we mustn't call migrate_fd_connect until then
> +                 */
> +
> +                return;
> +            }
>          } else {
>              QEMUFile *f = qemu_fopen_channel_output(ioc);
>  
> -- 
> 2.17.0
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
