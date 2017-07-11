Received: from eggs.gnu.org ([2001:4830:134:3::10]:40637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dUrGJ-0006Te-0W
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:15:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dUrGF-00018D-2N
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:15:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dUrGE-000186-Pt
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:15:14 -0400
Date: Tue, 11 Jul 2017 10:15:06 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170711091506.GC7116@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1499773645-120137-1-git-send-email-peng.hao2@zte.com.cn>
	<d97e3209-e1d0-1c00-ae8b-7bb22eb198e2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d97e3209-e1d0-1c00-ae8b-7bb22eb198e2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V2] chardev: fix parallel device can't be
 reconnect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peng Hao <peng.hao2@zte.com.cn>, marcandre.lureau@redhat.com, qemu-devel@nongnu.org, wang.yechao255@zte.com.cn

On Tue, Jul 11, 2017 at 10:30:14AM +0200, Paolo Bonzini wrote:
> On 11/07/2017 13:47, Peng Hao wrote:
> > Parallel device don't register be->chr_can_read function, but remote
> > disconnect event is handled in chr_read.So connected parallel device
> > can not detect remote disconnect event. The chardevs with chr_can_read=NULL
> > has the same problem.
> > 
> > Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> > Reviewed-by: Wang Yechao <wang.yechao255@zte.com.cn>
> > ---
> >  chardev/char-socket.c  | 11 +++++++++++
> >  chardev/char.c         | 10 ++++++++++
> >  include/chardev/char.h |  9 +++++++++
> >  3 files changed, 30 insertions(+)
> > 
> > diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> > index ccc499c..aa44f8f 100644
> > --- a/chardev/char-socket.c
> > +++ b/chardev/char-socket.c
> > @@ -139,6 +139,9 @@ static int tcp_chr_read_poll(void *opaque)
> >          return 0;
> >      }
> >      s->max_size = qemu_chr_be_can_write(chr);
> > +    if (qemu_chr_null_be_can_read(chr)) {
> > +        return 1;
> > +    }
> >      return s->max_size;
> >  }
> >  
> > @@ -422,6 +425,14 @@ static gboolean tcp_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
> >      uint8_t buf[CHR_READ_BUF_LEN];
> >      int len, size;
> >  
> > +    if (qemu_chr_null_be_can_read(chr)) {
> > +        size = tcp_chr_recv(chr, (void *)buf, CHR_READ_BUF_LEN);
> 
> It would be better not to destroy data in the channel, because the
> device could set handlers later.
> 
> Daniel, maybe QIOChannel could have a function to check for hung-up
> channels and return a bool?  For file descriptors it would poll the file
> descriptor and check for POLLHUP, while other channels would have a more
> or less obvious implementation.

IMHO the chardev code all needs to switch over to using even driven I/O
using the  qio_channel_add_watch() function. This is needed to properly
handle non-blocking I/O, to replace the workaround done in

  commit 6ab3fc32ea640026726bc5f9f4db622d0954fb8a
  Author: Daniel P. Berrange <berrange@redhat.com>
  Date:   Tue Sep 6 14:56:04 2016 +0100

    hw: replace most use of qemu_chr_fe_write with qemu_chr_fe_write_all

Some places in the chardev code in fact alreadying use watches for a few
actions, but then use sync i/o for other stuff. So using events will give
a consistent model. Once you're doing proper event driven I/O, then
detecting hangup is also trivial. 

IOW, I don't think we need add anything to QIOChannel - just continue to
cleanup the chardev backends to better use the functionality that already
exists.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
