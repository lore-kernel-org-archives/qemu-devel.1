Received: from eggs.gnu.org ([2001:4830:134:3::10]:33875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1e2chr-000860-NZ
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 08:35:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1e2chn-0002mc-SS
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 08:35:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1e2chn-0002mD-MA
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 08:35:15 -0400
Date: Thu, 12 Oct 2017 13:35:08 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171012123508.GE5957@stefanha-x1.localdomain>
References: <20170929033844.26935-1-peterx@redhat.com>
	<20170929033844.26935-11-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170929033844.26935-11-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 10/22] monitor: allow to use IO thread for
 parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Fri, Sep 29, 2017 at 11:38:32AM +0800, Peter Xu wrote:
> For each Monitor, add one field "use_io_thr" to show whether it will be
> using the dedicated monitor IO thread to handle input/output.  When set,
> monitor IO parsing work will be offloaded to dedicated monitor IO
> thread, rather than the original main loop thread.

Why make use_io_thr optional?  We'd have to maintain and test both code
paths.

> @@ -4135,19 +4139,37 @@ void monitor_init(Chardev *chr, int flags)
>          monitor_read_command(mon, 0);
>      }
>  
> +    if (mon->use_io_thr) {
> +        /*
> +         * When use_io_thr is set, we use the global shared dedicated
> +         * IO thread for this monitor to handle input/output.
> +         */
> +        context = monitor_io_context_get();
> +        /* We should have inited globals before reaching here. */
> +        assert(context);
> +    } else {
> +        /* The default main loop, which is the main thread */
> +        context = NULL;
> +    }
> +
> +    /*
> +     * Hang the monitor before running it (which is triggered by

s/Hang/Add/

"Hang" isn't used as a verb for adding items to collections.  People
would probably think about deadlocking the thread instead :-).

> +     * qemu_chr_fe_set_handlers).  Otherwise one monitor may run while
> +     * find itself not on the mon_list.
> +     */
> +    qemu_mutex_lock(&monitor_lock);
> +    QTAILQ_INSERT_HEAD(&mon_list, mon, entry);
> +    qemu_mutex_unlock(&monitor_lock);
