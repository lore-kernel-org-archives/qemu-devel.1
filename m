Received: from eggs.gnu.org ([2001:4830:134:3::10]:44053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eWvKE-0007mC-Si
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 21:32:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eWvKB-0006WN-P1
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 21:32:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56784)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eWvKB-0006UM-FK
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 21:32:07 -0500
Date: Thu, 4 Jan 2018 10:31:58 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180104023158.GQ2557@xz-mi>
References: <20180103021456.22526-4-peterx@redhat.com>
	<20180103022418.23165-1-peterx@redhat.com>
	<20180103174152.GC21894@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180103174152.GC21894@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v2.1 3/3] chardev: introduce
 qemu_chr_timeout_add() and use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, stefanha@redhat.com, marcandre.lureau@redhat.com

On Wed, Jan 03, 2018 at 05:41:53PM +0000, Stefan Hajnoczi wrote:
> On Wed, Jan 03, 2018 at 10:24:18AM +0800, Peter Xu wrote:
> > It's a replacement of g_timeout_add[_seconds]() for chardevs.  Chardevs
> > now can have dedicated gcontext, we should always bind chardev tasks
> > onto those gcontext rather than the default main context.  Since there
> > are quite a few of g_timeout_add[_seconds]() callers, a new function
> > qemu_chr_timeout_add() is introduced.
> > 
> > One thing to mention is that, terminal3270 is still always running on
> > main gcontext.  However let's convert that as well since it's still part
> > of chardev codes and in case one day we'll miss that when we move it out
> > of main gcontext too.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> > 
> > v2 -> v2.1: Sorry I forgot to do the move in char.h.  Did it in this
> > minor version.
> > 
> >  chardev/char-pty.c     |  9 ++-------
> >  chardev/char-socket.c  |  4 ++--
> >  chardev/char.c         | 20 ++++++++++++++++++++
> >  hw/char/terminal3270.c |  7 ++++---
> >  include/chardev/char.h |  3 +++
> >  5 files changed, 31 insertions(+), 12 deletions(-)
> > 
> > diff --git a/chardev/char-pty.c b/chardev/char-pty.c
> > index dd17b1b823..cbd8ac5eb7 100644
> > --- a/chardev/char-pty.c
> > +++ b/chardev/char-pty.c
> > @@ -78,13 +78,8 @@ static void pty_chr_rearm_timer(Chardev *chr, int ms)
> >          s->timer_tag = 0;
> >      }
> >  
> > -    if (ms == 1000) {
> > -        name = g_strdup_printf("pty-timer-secs-%s", chr->label);
> > -        s->timer_tag = g_timeout_add_seconds(1, pty_chr_timer, chr);
> > -    } else {
> > -        name = g_strdup_printf("pty-timer-ms-%s", chr->label);
> > -        s->timer_tag = g_timeout_add(ms, pty_chr_timer, chr);
> > -    }
> > +    name = g_strdup_printf("pty-timer-ms-%s", chr->label);
> > +    s->timer_tag = qemu_chr_timeout_add(chr, ms, pty_chr_timer, chr);
> 
> The label is user-visible.  Why did you remove the seconds label format?

It's used for g_source_set_name_by_id() below, and that's not
user-visible AFAICT?

I removed it because I thought it was not user visible and actually I
didn't see a point on doing that.  Please let me know if I made a
mistake.

> 
> Please either include justification in the commit description or avoid
> spurious changes like this so reviewers don't need to worry about code
> changes that are not essential.

Yes. I can add this into commit message after confirmed with you on above.

> 
> >      g_source_set_name_by_id(s->timer_tag, name);
> >      g_free(name);
> >  }
> > diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> > index 630a7f2995..5cca32f963 100644
> > --- a/chardev/char-socket.c
> > +++ b/chardev/char-socket.c
> > @@ -73,8 +73,8 @@ static void qemu_chr_socket_restart_timer(Chardev *chr)
> >      char *name;
> >  
> >      assert(s->connected == 0);
> > -    s->reconnect_timer = g_timeout_add_seconds(s->reconnect_time,
> > -                                               socket_reconnect_timeout, chr);
> 
> Here it was clear that reconnect_time is in seconds...
> 
> > +    s->reconnect_timer = qemu_chr_timeout_add(chr, s->reconnect_time * 1000,
> > +                                              socket_reconnect_timeout, chr);
> 
> ...now I can't tell what the unit is.
> 
> Please rename qemu_chr_timeout_add() to include the units:
> 
>   s->reconnect_timer = qemu_chr_timeout_add_ms(chr, s->reconnect_time * 1000,

Sure.

> 
> >      name = g_strdup_printf("chardev-socket-reconnect-%s", chr->label);
> >      g_source_set_name_by_id(s->reconnect_timer, name);
> >      g_free(name);
> > diff --git a/chardev/char.c b/chardev/char.c
> > index 8c3765ee99..a1de662fec 100644
> > --- a/chardev/char.c
> > +++ b/chardev/char.c
> > @@ -1084,6 +1084,26 @@ void qmp_chardev_send_break(const char *id, Error **errp)
> >      qemu_chr_be_event(chr, CHR_EVENT_BREAK);
> >  }
> >  
> > +/*
> > + * Add a timeout callback for the chardev (in milliseconds). Please
> > + * use this to add timeout hook for chardev instead of g_timeout_add()
> > + * and g_timeout_add_seconds(), to make sure the gcontext that the
> > + * task bound to is correct.
> > + */
> 
> What is the return value?

Basically I mean it's a wrapper of the other two functions so the
return value would be the same.  But sure I'll note that out.  Thanks,

-- 
Peter Xu
