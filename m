Received: from eggs.gnu.org ([2001:4830:134:3::10]:58575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f52eu-0001tr-Sw
	for qemu-devel@nongnu.org; Sun, 08 Apr 2018 01:14:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f52er-0006ih-Nj
	for qemu-devel@nongnu.org; Sun, 08 Apr 2018 01:14:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33524 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f52er-0006ht-Ip
	for qemu-devel@nongnu.org; Sun, 08 Apr 2018 01:14:29 -0400
Date: Sun, 8 Apr 2018 13:14:23 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180408051423.GH10540@xz-mi>
References: <20180403050115.6037-1-peterx@redhat.com>
	<20180404142220.GT4467@stefanha-x1.localdomain>
	<3d6c0d02-60ab-3501-611e-cd5f881d59e3@redhat.com>
	<20180405123431.GI32222@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180405123431.GI32222@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH for-2.12] monitor: bind dispatch bh to
 iohandler context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Thu, Apr 05, 2018 at 01:34:31PM +0100, Stefan Hajnoczi wrote:
> On Wed, Apr 04, 2018 at 10:07:34AM -0500, Eric Blake wrote:
> > On 04/04/2018 09:22 AM, Stefan Hajnoczi wrote:
> > > On Tue, Apr 03, 2018 at 01:01:15PM +0800, Peter Xu wrote:
> > >> Eric Auger reported the problem days ago that OOB broke ARM when running
> > >> with libvirt:
> > >>
> > >> http://lists.gnu.org/archive/html/qemu-devel/2018-03/msg06231.html
> > >>
> > >> This patch fixes the problem.
> > >>
> > >> It's not really needed now since we have turned OOB off now, but it's
> > >> still a bug fix, and it'll start to work when we turn OOB on for ARM.
> > >>
> > >> The problem was that the monitor dispatcher bottom half was bound to
> > >> qemu_aio_context, but that context seems to be for block only.
> > > 
> > > No, it is not block-only.  iohandler_ctx is for the legacy
> > > qemu_set_fd_handler() API only and modern code should use
> > > qemu_aio_context.
> > > 
> > > The difference between qemu_aio_context and iohandler_ctx is that
> > > aio_poll(qemu_aio_context) does not process iohandler_ctx (since it's a
> > > difference context).  That is the legacy behavior that
> > > qemu_set_fd_handler() expects and it's implemented by keeping a separate
> > > iohandler_ctx.
> > 
> > Do I need to put a hold on my pull request while we come to a better
> > understanding of root cause, or is this patch still okay to include?
> 
> The cover letter says this patch is not critical for 2.12:
> 
> "It's not really needed now since we have turned OOB off now, but it's
> still a bug fix, and it'll start to work when we turn OOB on for ARM."
> 
> Please hold off until the nature of the bug is understood.

But frankly speaking I would still prefer the fix be ready for 2.12
since that's still a bugfix and after all we have x-oob=on parameter
to enable that (that's why I mentioned for-2.12 in subject).  The fix
can be something better than this patch, but still it'll be good 2.12
has that.

Let's first discuss which's the best way to fix this up, then we'll
see whether this can be fixed for 2.12, or later.

Thanks,

-- 
Peter Xu
