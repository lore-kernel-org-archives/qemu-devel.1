Received: from eggs.gnu.org ([209.51.188.92]:50368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDqFj-0007n8-3z
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 08:53:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDqFi-0005J2-2m
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 08:53:27 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:40056)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hDqFh-0005HL-N3
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 08:53:26 -0400
Received: by mail-oi1-x244.google.com with SMTP id 3so13422441oir.7
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 05:53:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190325174706.6741-1-quintela@redhat.com>
	<20190325174706.6741-6-quintela@redhat.com>
	<CAFEAcA8J2cKVf+v+pkK-QFy3b4uPoS9ZaA43ATQyBjtPC9WyoQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8J2cKVf+v+pkK-QFy3b4uPoS9ZaA43ATQyBjtPC9WyoQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2019 13:53:13 +0100
Message-ID: <CAFEAcA_r9dhtdnr0ZK9vy=ucbJ3jfJ1ofDt7WiAdqD6Udkoskg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 05/15] multifd: Be flexible about packet size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>

On Tue, 26 Mar 2019 at 12:26, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Mon, 25 Mar 2019 at 18:13, Juan Quintela <quintela@redhat.com> wrote:
> >
> > This way we can change the packet size in the future and everything
> > will work.  We choose an arbitrary big number (100 times configured
> > size) as a limit about how big we will reallocate.
> >
> > Signed-off-by: Juan Quintela <quintela@redhat.com>
> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Signed-off-by: Juan Quintela <quintela@redhat.com>
> > --
>
> Hi; Coverity reports a use-after-free in this code
> (CID 1400442):

Ping? Have we got a fix for this yet ?

thanks
-- PMM

>
> > @@ -832,12 +832,24 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
> >      p->flags = be32_to_cpu(packet->flags);
> >
> >      packet->pages_alloc = be32_to_cpu(packet->pages_alloc);
> > -    if (packet->pages_alloc > page_count) {
> > +    /*
> > +     * If we recevied a packet that is 100 times bigger than expected
> > +     * just stop migration.  It is a magic number.
> > +     */
> > +    if (packet->pages_alloc > pages_max * 100) {
> >          error_setg(errp, "multifd: received packet "
> > -                   "with size %d and expected maximum size %d",
> > -                   packet->pages_alloc, page_count) ;
> > +                   "with size %d and expected a maximum size of %d",
> > +                   packet->pages_alloc, pages_max * 100) ;
> >          return -1;
> >      }
> > +    /*
> > +     * We received a packet that is bigger than expected but inside
> > +     * reasonable limits (see previous comment).  Just reallocate.
> > +     */
> > +    if (packet->pages_alloc > p->pages->allocated) {
> > +        multifd_pages_clear(p->pages);
>
> multifd_pages_clear() calls g_free() on the pointer it is passed...
>
> > +        multifd_pages_init(packet->pages_alloc);
> > +    }
> >
> >      p->pages->used = be32_to_cpu(packet->pages_used);
>
> ...but here we fall through and dereference p->pages, which
> we might have just freed.
>
> >      if (p->pages->used > packet->pages_alloc) {
> > --
> > 2.20.1
>
> thanks
> -- PMM
