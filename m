Received: from eggs.gnu.org ([2001:4830:134:3::10]:39534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dfM6y-0001YS-6N
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 04:13:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dfM6t-0007IH-78
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 04:13:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dfM6t-0007HB-0y
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 04:12:59 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7784161469
	for <qemu-devel@nongnu.org>; Wed,  9 Aug 2017 08:12:57 +0000 (UTC)
Date: Wed, 9 Aug 2017 16:12:53 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170809081253.GL13486@pxdev.xzpeter.org>
References: <20170717134238.1966-1-quintela@redhat.com>
	<20170717134238.1966-12-quintela@redhat.com>
	<20170720094947.GD23385@pxdev.xzpeter.org>
	<878tiu82oj.fsf@secure.mitica>
	<20170809074844.GJ13486@pxdev.xzpeter.org>
	<87valx6u9s.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87valx6u9s.fsf@secure.mitica>
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

On Wed, Aug 09, 2017 at 10:05:19AM +0200, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
> > On Tue, Aug 08, 2017 at 06:06:04PM +0200, Juan Quintela wrote:
> >> Peter Xu <peterx@redhat.com> wrote:
> >> > On Mon, Jul 17, 2017 at 03:42:32PM +0200, Juan Quintela wrote:
> >> >
> >> > [...]
> >> >
> >> >>  static int multifd_send_page(uint8_t *address)
> >> >>  {
> >> >> -    int i;
> >> >> +    int i, j;
> >> >>      MultiFDSendParams *p = NULL; /* make happy gcc */
> >> >> +    static multifd_pages_t pages;
> >> >> +    static bool once;
> >> >> +
> >> >> +    if (!once) {
> >> >> +        multifd_init_group(&pages);
> >> >> +        once = true;
> >> >
> >> > Would it be good to put the "pages" into multifd_send_state? One is to
> >> > stick globals together; another benefit is that we can remove the
> >> > "once" here: we can then init the "pages" when init multifd_send_state
> >> > struct (but maybe with a better name?...).
> >> 
> >> I did to be able to free it.
> >
> > Free it? But they a static variables, then how can we free them?
> >
> > (I thought the only way to free it is putting it into
> >  multifd_send_state...)
> >
> > Something I must have missed here. :(
> 
> I did the change that you suggested in response to a comment from Dave
> that asked where I freed it.   I see that my sentence was ambigous.

Oh! Then it's clear now. Thanks!

(Sorry I may have missed some of the emails in the threads)

-- 
Peter Xu
