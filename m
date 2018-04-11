Received: from eggs.gnu.org ([2001:4830:134:3::10]:50739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f66m7-0000w1-5M
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 23:50:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f66m2-0004Ex-7z
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 23:50:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52256 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f66m1-0004DM-Pc
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 23:50:18 -0400
Date: Wed, 11 Apr 2018 11:49:54 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180411034954.GC13887@xz-mi>
References: <20180410124913.10832-1-peterx@redhat.com>
	<20180410124913.10832-3-peterx@redhat.com>
	<20180411014532.GB28698@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180411014532.GB28698@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH 2/2] qemu-thread: let cur_mon be per-thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Eric Blake <eblake@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Apr 11, 2018 at 09:45:32AM +0800, Stefan Hajnoczi wrote:
> On Tue, Apr 10, 2018 at 08:49:13PM +0800, Peter Xu wrote:
> > cur_mon was only used in main loop so we don't really need that to be
> > per-thread variable.  Now it's possible that we have more than one
> > thread to operate on it.  Let's start to let it be per-thread variable.
> 
> Trying to understand the reason for this patch:
> 
> Are there any users of per-thread cur_mon?

Currently no.  But if considering future OOB-capable commands, they
will modify cur_mon in monitor IOThread at least.

> 
> or
> 
> Does this patch fix a bug?

No; currently we have no bug.  But we have encounter the bug when we
start to add more OOB commands.

Here is the problem (Marc-Andre reported this, and I'll try to
summarize): after we have valid OOB commands,
monitor_qmp_dispatch_one() can be run not only in main thread, but
also in monitor iothread.  When that happens, both of them (main
thread, and monitor iothread) can be modifying the cur_mon variable at
the same time. [1]

Considering that cur_mon is only used "just like" a stack variable, it
should be perfectly fine we just make it as a per thread variable,
hence this patch.

> 
> > In case we'll create threads within a valid cur_mon setup, we'd better
> > let the child threads to inherit the cur_mon from parent thread too.  Do
> > that for both posix and win32 threads.
> 
> Without actual users I don't like this.  It sounds like "let's make it
> global just in case something needs it some day".
> 
> It's ugly for QEMU's thread API to know about the monitor - that's a
> layering violation.

Yes, I'm sorry about it.  Actually I don't like it too.  But that
seems to be an efficient and simple solution to me now.  The ideal
solution should be totally removing cur_mon, which is non-trivial.

And for sure we can try to avoid layer violation.  For example, we can
have something like qemu_thread_register_variable(pthread_key_t), then
monitor code can register the cur_mon pthread_key to the qemu thread
module.  That'll somehow achieve isolation between modules but I'm not
sure whether that would be necessary for now, hence I chose the simple.

> 
> If there's a legitimate need I think this patch might be necessary, but
> I don't see enough justification to do this yet.

The problem was described at [1].  Thanks,

-- 
Peter Xu
