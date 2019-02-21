Received: from eggs.gnu.org ([209.51.188.92]:37021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gwsOJ-0002gK-VI
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 12:44:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gwsOJ-0001y7-7x
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 12:44:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gwsOH-0001rZ-6X
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 12:44:09 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B0BB330821A0
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 17:43:59 +0000 (UTC)
Date: Thu, 21 Feb 2019 17:43:55 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190221174355.GL2605@work-vm>
References: <20190220115611.3192-1-quintela@redhat.com>
	<20190220115611.3192-2-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220115611.3192-2-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/8] multifd: Only send pages when
 packet are not empty
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>

* Juan Quintela (quintela@redhat.com) wrote:
> We send packages without pages sometimes for sysnchronizanion.  The
> iov functions do the right thing, but we will be changing this code in
> future patches.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/ram.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 59191c1ed2..8b5fd67d66 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1025,9 +1025,12 @@ static void *multifd_send_thread(void *opaque)
>                  break;
>              }
>  
> -            ret = qio_channel_writev_all(p->c, p->pages->iov, used, &local_err);
> -            if (ret != 0) {
> -                break;
> +            if (used) {
> +                ret = qio_channel_writev_all(p->c, p->pages->iov,
> +                                             used, &local_err);
> +                if (ret != 0) {
> +                    break;
> +                }
>              }
>  
>              qemu_mutex_lock(&p->mutex);
> @@ -1254,9 +1257,12 @@ static void *multifd_recv_thread(void *opaque)
>          p->num_pages += used;
>          qemu_mutex_unlock(&p->mutex);
>  
> -        ret = qio_channel_readv_all(p->c, p->pages->iov, used, &local_err);
> -        if (ret != 0) {
> -            break;
> +        if (used) {
> +            ret = qio_channel_readv_all(p->c, p->pages->iov,
> +                                        used, &local_err);
> +            if (ret != 0) {
> +                break;
> +            }
>          }
>  
>          if (flags & MULTIFD_FLAG_SYNC) {
> -- 
> 2.20.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
