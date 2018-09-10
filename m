Received: from eggs.gnu.org ([2001:4830:134:3::10]:55767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fzDML-0005LW-2M
	for qemu-devel@nongnu.org; Sun, 09 Sep 2018 23:59:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fzDMI-0005tZ-3c
	for qemu-devel@nongnu.org; Sun, 09 Sep 2018 23:59:31 -0400
Date: Mon, 10 Sep 2018 11:59:14 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180910035914.GA21370@lemon.usersys.redhat.com>
References: <20180809132259.18402-1-famz@redhat.com>
	<20180809132259.18402-3-famz@redhat.com>
	<20180907155101.GA31915@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907155101.GA31915@localhost.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 2/2] aio: Do
 aio_notify_accept only during blocking aio_poll
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>, qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, pbonzini@redhat.com, lersek@redhat.com, slp@redhat.com

On Fri, 09/07 17:51, Kevin Wolf wrote:
> Am 09.08.2018 um 15:22 hat Fam Zheng geschrieben:
> > Furthermore, blocking aio_poll is only allowed on home thread
> > (in_aio_context_home_thread), because otherwise two blocking
> > aio_poll()'s can steal each other's ctx->notifier event and cause
> > hanging just like described above.
> 
> It's good to have this assertion now at least, but after digging into
> some bugs, I think in fact that any aio_poll() (even non-blocking) is
> only allowed in the home thread: At least one reason is that if you run
> it from a different thread, qemu_get_current_aio_context() returns the
> wrong AioContext in any callbacks called by aio_poll(). Anything else
> using TLS can have similar problems.
> 
> One instance where this matters is fixed/worked around by Sergio's
> "util/async: use qemu_aio_coroutine_enter in co_schedule_bh_cb". We
> wouldn't even need that patch if we could make sure that aio_poll() is
> never called from the wrong thread. This would feel more robust.
> 
> I'll fix the aio_poll() calls in drain (the AIO_WAIT_WHILE() ones are
> already fine, the rest by removing them). After that,
> bdrv_set_aio_context() is still problematic, but the rest should be
> okay. Hopefully we can use the tighter assertion then.

Fully agree with you.

Fam
