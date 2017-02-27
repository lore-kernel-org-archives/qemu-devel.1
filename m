Received: from eggs.gnu.org ([2001:4830:134:3::10]:45653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ciOFP-00077m-4c
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:34:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ciOFK-0008DC-5b
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:34:03 -0500
Date: Mon, 27 Feb 2017 17:33:12 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170227163312.jzszc2ajn3tslrdf@var.youpi.perso.aquilenet.fr>
References: <20170227004545.hzpr266jzturlxdh@var.youpi.perso.aquilenet.fr>
	<4bbc4d50-3c87-bd83-b74d-6aa8b020f2c1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4bbc4d50-3c87-bd83-b74d-6aa8b020f2c1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] blk: Add discard=sparse mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

Hello,

Max Reitz, on lun. 27 févr. 2017 17:12:47 +0100, wrote:
> >  #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
> > -    if (s->has_discard && s->has_fallocate) {
> > +    if (s->has_discard && (s->has_fallocate || open_flags & BDRV_O_SPARSE)) {
> 
> s->has_fallocate has a meaning. I wouldn't try to call do_fallocate() if
> s->has_fallocate is false.

Ah, sorry, I didn't realize that that test wasn't only to check that
we'll be able to call fallocate(0) further down.

> Therefore, I consider this to effectively be a no-op.

Yes.

> > @@ -1098,7 +1102,8 @@ static ssize_t handle_aiocb_write_zeroes(RawPosixAIOData *aiocb)
> >  #endif
> >  
> >  #ifdef CONFIG_FALLOCATE
> > -    if (s->has_fallocate && aiocb->aio_offset >= bdrv_getlength(aiocb->bs)) {
> > +    if (s->has_fallocate && !(open_flags & BDRV_O_SPARSE)
> > +            && aiocb->aio_offset >= bdrv_getlength(aiocb->bs)) {
> 
> First, this part is only invoked if everything before it has failed.

I misread the code indeed.

> Unless I'm mistaken, unmap/trim requests from the guest should result in
> a discard request in the block layer. This should always trigger
> handle_aiocb_discard() here and that should do what you want it to.

Mmm, indeed.  I guess I got lost in the hairy block code.

> Could you maybe give me the configuration that results in the issue
> you're describing in the commit message?

Actually I can't reproduce the issue any more.  I'm now wondering how I
ended up there.

Anyway, I'm really sorry for the noise, and thanks for the good work :)

Samuel
