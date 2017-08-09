Received: from eggs.gnu.org ([2001:4830:134:3::10]:56315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dfJwU-0005v0-Nl
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 01:54:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dfJwR-00052K-L6
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 01:54:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dfJwR-00051w-EN
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 01:54:03 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2398FC047B61
	for <qemu-devel@nongnu.org>; Wed,  9 Aug 2017 05:54:02 +0000 (UTC)
Date: Wed, 9 Aug 2017 13:53:58 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170809055358.GH13486@pxdev.xzpeter.org>
References: <20170717134238.1966-1-quintela@redhat.com>
	<20170717134238.1966-14-quintela@redhat.com>
	<20170720102244.GF23385@pxdev.xzpeter.org>
	<8760dy9tie.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8760dy9tie.fsf@secure.mitica>
Subject: Re: [Qemu-devel] [PATCH v5 13/17] migration: Create thread
 infrastructure for multifd recv side
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

On Tue, Aug 08, 2017 at 01:41:13PM +0200, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
> > On Mon, Jul 17, 2017 at 03:42:34PM +0200, Juan Quintela wrote:
> 
> >> +static void multifd_recv_page(uint8_t *address, uint16_t fd_num)
> >> +{
> >> +    int thread_count;
> >> +    MultiFDRecvParams *p;
> >> +    static multifd_pages_t pages;
> >> +    static bool once;
> >> +
> >> +    if (!once) {
> >> +        multifd_init_group(&pages);
> >> +        once = true;
> >> +    }
> >> +
> >> +    pages.iov[pages.num].iov_base = address;
> >> +    pages.iov[pages.num].iov_len = TARGET_PAGE_SIZE;
> >> +    pages.num++;
> >> +
> >> +    if (fd_num == UINT16_MAX) {
> >
> > (so this check is slightly mistery as well if we don't define
> >  something... O:-)
> 
> It means that we continue sending pages on the same "group".  Will add a
> comment.
> 
> >
> >> +        return;
> >> +    }
> >> +
> >> +    thread_count = migrate_multifd_threads();
> >> +    assert(fd_num < thread_count);
> >> +    p = multifd_recv_state->params[fd_num];
> >> +
> >> +    qemu_sem_wait(&p->ready);
> >
> > Shall we check for p->pages.num == 0 before wait? What if the
> > corresponding thread is already finished its old work and ready?
> 
> this is a semaphore, not a condition variable.  We only use it with
> values 0 and 1.  We only wait if the other thread hasn't done the post,
> if it has done the post, the wait don't have to wait. (no, I didn't
> invented the semaphore names).

Yeah I think you are right. :)  Thanks,

-- 
Peter Xu
