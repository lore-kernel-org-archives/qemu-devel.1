Received: from eggs.gnu.org ([2001:4830:134:3::10]:60585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1e2ccD-0006Bt-M1
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 08:29:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1e2ccA-0007vE-IS
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 08:29:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1e2ccA-0007ut-Ct
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 08:29:26 -0400
Date: Thu, 12 Oct 2017 13:29:11 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171012122911.GD5957@stefanha-x1.localdomain>
References: <20170929033844.26935-1-peterx@redhat.com>
	<20170929033844.26935-10-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170929033844.26935-10-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 09/22] monitor: create monitor dedicate
 iothread
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

On Fri, Sep 29, 2017 at 11:38:31AM +0800, Peter Xu wrote:
> @@ -4126,10 +4150,23 @@ void monitor_init(Chardev *chr, int flags)
>      qemu_mutex_unlock(&monitor_lock);
>  }
>  
> +static void monitor_io_thread_destroy(void)
> +{
> +    iothread_destroy(mon_global.mon_io_thread);
> +    mon_global.mon_io_thread = NULL;
> +}
> +
>  void monitor_cleanup(void)
>  {
>      Monitor *mon, *next;
>  
> +    /*
> +     * We need to explicitly stop the iothread (but not destroy it),
> +     * cleanup the monitor resources, then destroy the iothread.  See
> +     * again on the glib bug mentioned in 2b316774f6 for a reason.
> +     */
> +    iothread_stop(mon_global.mon_io_thread);
> +
>      qemu_mutex_lock(&monitor_lock);
>      QLIST_FOREACH_SAFE(mon, &mon_list, entry, next) {
>          QLIST_REMOVE(mon, entry);
> @@ -4137,6 +4174,8 @@ void monitor_cleanup(void)
>          g_free(mon);
>      }
>      qemu_mutex_unlock(&monitor_lock);
> +
> +    monitor_io_thread_destroy();
>  }

Minor style comment, I would inline monitor_io_thread_destroy() into
monitor_cleanup() instead of making it a function.

monitor_io_thread_destroy() relies on iothread_stop() being called
first.  Defining a function with no doc comment creates a risk that
someone else will call it in the future without first calling
iothread_stop().  It's safer to inline the code where it cannot be
misused by accident.

Also, please name things "iothread" instead of "io_thread" for
consistency.

Stefan
