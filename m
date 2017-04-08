Received: from eggs.gnu.org ([2001:4830:134:3::10]:55191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cwhIA-0001Gb-9D
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 23:44:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cwhI9-0004wq-Ke
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 23:44:02 -0400
Date: Sat, 8 Apr 2017 11:43:51 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170408034351.GC6548@lemon>
References: <20170407065414.9143-1-famz@redhat.com>
	<20170407065414.9143-5-famz@redhat.com>
	<20170407125051.GB16146@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170407125051.GB16146@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v2 4/6] block: Quiesce old aio context
 during bdrv_set_aio_context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Ed Swierk <eswierk@skyportsystems.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

On Fri, 04/07 13:50, Stefan Hajnoczi wrote:
> On Fri, Apr 07, 2017 at 02:54:12PM +0800, Fam Zheng wrote:
> > @@ -4413,6 +4416,10 @@ void bdrv_set_aio_context(BlockDriverState *bs, AioContext *new_context)
> >      aio_context_acquire(new_context);
> >      bdrv_attach_aio_context(bs, new_context);
> >      aio_context_release(new_context);
> > +    if (bs->job) {
> > +        block_job_resume(bs->job);
> > +    }
> 
> Should this be called before aio_context_release(new_context)?

Yes, and I'm going to replace it with bdrv_parent_drained_begin() as Kevin
suggested.

Fam
