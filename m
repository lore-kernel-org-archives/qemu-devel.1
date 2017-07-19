Received: from eggs.gnu.org ([2001:4830:134:3::10]:48411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXpUZ-0000n7-6l
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:58:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXpUV-0004Qu-9q
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:58:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dXpUV-0004Qk-3g
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:58:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D6B026B222
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 13:58:13 +0000 (UTC)
Date: Wed, 19 Jul 2017 14:58:02 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170719135802.GJ30084@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170717134238.1966-1-quintela@redhat.com>
	<20170717134238.1966-12-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170717134238.1966-12-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 11/17] migration: Really use multiple
 pages at a time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

On Mon, Jul 17, 2017 at 03:42:32PM +0200, Juan Quintela wrote:
> We now send several pages at a time each time that we wakeup a thread.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> 
> --
> 
> Use iovec's insead of creating the equivalent.
> ---
>  migration/ram.c | 46 ++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 40 insertions(+), 6 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 2bf3fa7..90e1bcb 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c

> +static void multifd_init_group(multifd_pages_t *pages)
> +{
> +    pages->num = 0;
> +    pages->size = migrate_multifd_group();
> +    pages->iov = g_malloc0(pages->size * sizeof(struct iovec));

Use g_new() so that it checks for overflow in the size calculation.

> +}
> +

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
