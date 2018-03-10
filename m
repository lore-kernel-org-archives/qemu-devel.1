Received: from eggs.gnu.org ([2001:4830:134:3::10]:36286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eunm3-00013G-0m
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 18:19:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eunlz-00087N-Ry
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 18:19:34 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55746 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eunlz-00087B-Nv
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 18:19:31 -0500
References: <20180309090006.10018-1-peterx@redhat.com>
	<20180309090006.10018-10-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8dc180a7-b60a-2124-b212-cb24991ff343@redhat.com>
Date: Sat, 10 Mar 2018 17:19:15 -0600
MIME-Version: 1.0
In-Reply-To: <20180309090006.10018-10-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 09/23] monitor: allow using IO thread
 for parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 03/09/2018 02:59 AM, Peter Xu wrote:
> For each Monitor, add one field "use_io_thr" to show whether it will be
> using the dedicated monitor IO thread to handle input/output.  When set,
> monitor IO parsing work will be offloaded to the dedicated monitor IO
> thread, rather than the original main loop thread.
> 
> This only works for QMP.  HMP will always be run on the main loop
> thread.
> 
> Currently we're still keeping use_io_thr off always.  Will turn it on
> later at some point.
> 
> One thing to mention is that we cannot set use_io_thr for every QMP
> monitor.  The problem is that MUXed typed chardevs may not work well
> with it now. When MUX is used, frontend of chardev can be the monitor
> plus something else.  The only thing we know would be safe to be run
> outside main thread so far is the monitor frontend. All the rest of the
> frontends should still be run in main thread only.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   monitor.c | 98 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++------
>   1 file changed, 90 insertions(+), 8 deletions(-)
> 

> @@ -210,6 +213,11 @@ struct Monitor {
>       QTAILQ_ENTRY(Monitor) entry;
>   };
>   
> +/* Let's add monitor global variables to this struct. */
> +static struct {
> +    IOThread *mon_iothread;
> +} mon_global;

Anonymous struct type, but not the first time someone has done this, so 
it's okay.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
