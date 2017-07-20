Received: from eggs.gnu.org ([2001:4830:134:3::10]:53756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dY7rO-0005Vp-Or
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:35:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dY7rJ-00045m-SM
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:35:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39748)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dY7rJ-000459-Lq
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:35:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 62455C04D2A4
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 09:35:00 +0000 (UTC)
Date: Thu, 20 Jul 2017 17:34:55 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170720093455.GC23385@pxdev.xzpeter.org>
References: <20170717134238.1966-1-quintela@redhat.com>
	<20170717134238.1966-10-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170717134238.1966-10-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 09/17] migration: Start of multiple fd
 work
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

On Mon, Jul 17, 2017 at 03:42:30PM +0200, Juan Quintela wrote:

[...]

>  int multifd_load_setup(void)
>  {
>      int thread_count;
> -    uint8_t i;
>  
>      if (!migrate_use_multifd()) {
>          return 0;
>      }
>      thread_count = migrate_multifd_threads();
>      multifd_recv_state = g_malloc0(sizeof(*multifd_recv_state));
> -    multifd_recv_state->params = g_new0(MultiFDRecvParams, thread_count);
> +    multifd_recv_state->params = g_new0(MultiFDRecvParams *, thread_count);
>      multifd_recv_state->count = 0;
> -    for (i = 0; i < thread_count; i++) {
> -        char thread_name[16];
> -        MultiFDRecvParams *p = &multifd_recv_state->params[i];
> -
> -        qemu_mutex_init(&p->mutex);
> -        qemu_sem_init(&p->sem, 0);
> -        p->quit = false;
> -        p->id = i;
> -        snprintf(thread_name, sizeof(thread_name), "multifdrecv_%d", i);
> -        qemu_thread_create(&p->thread, thread_name, multifd_recv_thread, p,
> -                           QEMU_THREAD_JOINABLE);
> -        multifd_recv_state->count++;
> -    }

Could I ask why we explicitly switched from MultiFDRecvParams[] array
into a pointer array? Can we still use the old array?  Thanks,

-- 
Peter Xu
