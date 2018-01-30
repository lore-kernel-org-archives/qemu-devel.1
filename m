Received: from eggs.gnu.org ([2001:4830:134:3::10]:34743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1egKk7-0005FW-Lh
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 20:29:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1egKk2-0006cZ-Qh
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 20:29:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1egKk2-0006cG-LA
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 20:29:42 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1A38E49036
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 01:29:41 +0000 (UTC)
Date: Tue, 30 Jan 2018 09:29:36 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180130012936.GA7690@xz-mi>
References: <20180129161708.13616-1-quintela@redhat.com>
	<667d7110-dd21-9bed-3cbe-8202ab00f3fe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <667d7110-dd21-9bed-3cbe-8202ab00f3fe@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] char-pty: fix glib assert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, dgilbert@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

On Mon, Jan 29, 2018 at 05:40:11PM +0100, Laurent Vivier wrote:
> On 29/01/2018 17:17, Juan Quintela wrote:
> > I am having this assert over and over:
> > 
> > (process:30804): GLib-CRITICAL **: g_source_unref: assertion 'source != NULL' failed
> > 
> > gdb points to the line changed on this patch, and my reading of
> > commit:
> > 
> > 2c716ba1506769c9be2caa02f0f6d6e7c00f4304
> > 
> > is that it should be timer_src what is unrefered there.
> > 
> > But I don't claim to fully understand this code, so ....
> > 
> > Any comment?
> > 
> > Thanks, Juan.
> > 
> > Signed-off-by: Juan Quintela <quintela@redhat.com>
> > CC: Peter Xu <peterx@redhat.com>
> > CC: Paolo Bonzini <pbonzini@redhat.com>
> > 
> > 
> > ---
> >  chardev/char-pty.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/chardev/char-pty.c b/chardev/char-pty.c
> > index 89315e6807..c26e02bce8 100644
> > --- a/chardev/char-pty.c
> > +++ b/chardev/char-pty.c
> > @@ -57,8 +57,8 @@ static gboolean pty_chr_timer(gpointer opaque)
> >      PtyChardev *s = PTY_CHARDEV(opaque);
> >  
> >      qemu_mutex_lock(&chr->chr_write_lock);
> > +    g_source_unref(s->timer_src);
> >      s->timer_src = NULL;
> > -    g_source_unref(s->open_source);
> >      s->open_source = NULL;
> >      if (!s->connected) {
> >          /* Next poll ... */
> > 
> 
> If I read correctly the doc, we also need a
> g_source_destroy(s->timer_src). Perhaps we can directly call
> pty_chr_timer_cancel() here?

Yes.  Another fix is already queued by Paolo here:

  http://patchwork.ozlabs.org/patch/862763/

Sorry for that!

-- 
Peter Xu
