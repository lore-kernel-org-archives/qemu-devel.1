Received: from eggs.gnu.org ([2001:4830:134:3::10]:59515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dfLjZ-00042n-TV
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 03:48:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dfLjW-0001ea-NE
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 03:48:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:23081)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dfLjW-0001e7-G7
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 03:48:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 10662356C0
	for <qemu-devel@nongnu.org>; Wed,  9 Aug 2017 07:48:49 +0000 (UTC)
Date: Wed, 9 Aug 2017 15:48:44 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170809074844.GJ13486@pxdev.xzpeter.org>
References: <20170717134238.1966-1-quintela@redhat.com>
	<20170717134238.1966-12-quintela@redhat.com>
	<20170720094947.GD23385@pxdev.xzpeter.org>
	<878tiu82oj.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878tiu82oj.fsf@secure.mitica>
Subject: Re: [Qemu-devel] [PATCH v5 11/17] migration: Really use multiple
 pages at a time
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

On Tue, Aug 08, 2017 at 06:06:04PM +0200, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
> > On Mon, Jul 17, 2017 at 03:42:32PM +0200, Juan Quintela wrote:
> >
> > [...]
> >
> >>  static int multifd_send_page(uint8_t *address)
> >>  {
> >> -    int i;
> >> +    int i, j;
> >>      MultiFDSendParams *p = NULL; /* make happy gcc */
> >> +    static multifd_pages_t pages;
> >> +    static bool once;
> >> +
> >> +    if (!once) {
> >> +        multifd_init_group(&pages);
> >> +        once = true;
> >
> > Would it be good to put the "pages" into multifd_send_state? One is to
> > stick globals together; another benefit is that we can remove the
> > "once" here: we can then init the "pages" when init multifd_send_state
> > struct (but maybe with a better name?...).
> 
> I did to be able to free it.

Free it? But they a static variables, then how can we free them?

(I thought the only way to free it is putting it into
 multifd_send_state...)

Something I must have missed here. :(

> 
> > (there are similar static variables in multifd_recv_page() as well, if
> >  this one applies, then we can possibly use multifd_recv_state for
> >  that one)
> 
> Also there.
> 
> >> +    }
> >> +
> >> +    pages.iov[pages.num].iov_base = address;
> >> +    pages.iov[pages.num].iov_len = TARGET_PAGE_SIZE;
> >> +    pages.num++;
> >> +
> >> +    if (pages.num < (pages.size - 1)) {
> >> +        return UINT16_MAX;
> >
> > Nit: shall we define something for readability?  Like:
> >
> > #define  MULTIFD_FD_INVALID  UINT16_MAX
> 
> Also done.
> 
> MULTIFD_CONTINUE
> 
> But I am open to changes.

It's clear enough at least to me. Thanks!

-- 
Peter Xu
