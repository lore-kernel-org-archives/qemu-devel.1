Received: from eggs.gnu.org ([2001:4830:134:3::10]:43208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eBxbt-0003ej-7R
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 01:43:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eBxbq-0000jf-23
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 01:43:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eBxbp-0000iS-Ru
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 01:43:41 -0500
Date: Tue, 7 Nov 2017 14:43:28 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171107064328.GE16355@lemon>
References: <20171106094643.14881-1-peterx@redhat.com>
	<20171106094643.14881-2-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171106094643.14881-2-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v3 01/27] char-io: fix possible race on
 IOWatchPoll
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, marcandre.lureau@redhat.com, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Mon, 11/06 17:46, Peter Xu wrote:
> This is not a problem if we are only having one single loop thread like
> before.  However, after per-monitor thread is introduced, this is not
> true any more, and the race can happen.
> 
> The race can be triggered with "make check -j8" sometimes:
> 
>   qemu-system-x86_64: /root/git/qemu/chardev/char-io.c:91:
>   io_watch_poll_finalize: Assertion `iwp->src == NULL' failed.
> 
> This patch keeps the reference for the watch object when creating in
> io_add_watch_poll(), so that the object will never be released in the
> context main loop, especially when the context loop is running in
> another standalone thread.  Meanwhile, when we want to remove the watch
> object, we always first detach the watch object from its owner context,
> then we continue with the cleanup.
> 
> Without this patch, calling io_remove_watch_poll() in main loop thread
> is not thread-safe, since the other per-monitor thread may be modifying
> the watch object at the same time.

Looks sane,

Reviewed-by: Fam Zheng <famz@redhat.com>
