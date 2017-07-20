Received: from eggs.gnu.org ([2001:4830:134:3::10]:56828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dY85k-0004Jx-Mh
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:49:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dY85g-0005r1-Ph
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:49:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dY85g-0005qc-Jv
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:49:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4D76B336F04
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 09:49:51 +0000 (UTC)
Date: Thu, 20 Jul 2017 17:49:47 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170720094947.GD23385@pxdev.xzpeter.org>
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
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com, berrange@redhat.com

On Mon, Jul 17, 2017 at 03:42:32PM +0200, Juan Quintela wrote:

[...]

>  static int multifd_send_page(uint8_t *address)
>  {
> -    int i;
> +    int i, j;
>      MultiFDSendParams *p = NULL; /* make happy gcc */
> +    static multifd_pages_t pages;
> +    static bool once;
> +
> +    if (!once) {
> +        multifd_init_group(&pages);
> +        once = true;

Would it be good to put the "pages" into multifd_send_state? One is to
stick globals together; another benefit is that we can remove the
"once" here: we can then init the "pages" when init multifd_send_state
struct (but maybe with a better name?...).

(there are similar static variables in multifd_recv_page() as well, if
 this one applies, then we can possibly use multifd_recv_state for
 that one)

> +    }
> +
> +    pages.iov[pages.num].iov_base = address;
> +    pages.iov[pages.num].iov_len = TARGET_PAGE_SIZE;
> +    pages.num++;
> +
> +    if (pages.num < (pages.size - 1)) {
> +        return UINT16_MAX;

Nit: shall we define something for readability?  Like:

#define  MULTIFD_FD_INVALID  UINT16_MAX

> +    }
>  
>      qemu_sem_wait(&multifd_send_state->sem);
>      qemu_mutex_lock(&multifd_send_state->mutex);
> @@ -530,7 +559,12 @@ static int multifd_send_page(uint8_t *address)
>      }
>      qemu_mutex_unlock(&multifd_send_state->mutex);
>      qemu_mutex_lock(&p->mutex);
> -    p->address = address;
> +    p->pages.num = pages.num;
> +    for (j = 0; j < pages.size; j++) {
> +        p->pages.iov[j].iov_base = pages.iov[j].iov_base;
> +        p->pages.iov[j].iov_len = pages.iov[j].iov_len;
> +    }
> +    pages.num = 0;
>      qemu_mutex_unlock(&p->mutex);
>      qemu_sem_post(&p->sem);
>  
> -- 
> 2.9.4
> 

-- 
Peter Xu
