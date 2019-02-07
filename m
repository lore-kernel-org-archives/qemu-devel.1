Received: from eggs.gnu.org ([209.51.188.92]:53769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1grhwL-0001wm-GL
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:33:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1grhw9-0004bH-C7
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:33:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1grhvy-0004VO-BM
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:33:36 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B5B4880511
	for <qemu-devel@nongnu.org>; Thu,  7 Feb 2019 11:33:18 +0000 (UTC)
Date: Thu, 7 Feb 2019 11:33:12 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190207113312.GD19438@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190206132331.1694-1-quintela@redhat.com>
	<20190206132331.1694-2-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190206132331.1694-2-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/4] multifd: Change page count default to
 128
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, Feb 06, 2019 at 02:23:28PM +0100, Juan Quintela wrote:
> I haven't seend any problem about using 64 or 128.  And it make much
> less contention on the locks.  Just change it.

Isn't there a issue with having a fixed page count given the
very different default page sizes across architectures ?

x86 is 4kb pages, while ppc64 uses 64kb pages IIUC.

This would mean current value of 64 pages, would correspond
to 1/4 MB on x86, and 4 MB on ppc64.  The new value would
be 1/2 MB on x86 and 8 MB on ppc64.

Should we instead be measuring this tunable in units that
are independant of page size ? eg meansure in KB, with a
requirement that the value is a multiple of the page size.
Then set the default to 512 KB ?

> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/migration.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index ef1d53cde2..f673486679 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -81,7 +81,7 @@
>  /* The delay time (in ms) between two COLO checkpoints */
>  #define DEFAULT_MIGRATE_X_CHECKPOINT_DELAY (200 * 100)
>  #define DEFAULT_MIGRATE_MULTIFD_CHANNELS 2
> -#define DEFAULT_MIGRATE_MULTIFD_PAGE_COUNT 16
> +#define DEFAULT_MIGRATE_MULTIFD_PAGE_COUNT 128
>  
>  /* Background transfer rate for postcopy, 0 means unlimited, note
>   * that page requests can still exceed this limit.
> -- 
> 2.20.1
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
