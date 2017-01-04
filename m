Received: from eggs.gnu.org ([2001:4830:134:3::10]:50184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cOlYA-0008BO-U3
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:24:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cOlY7-0005Ax-R3
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:24:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cOlY7-0005Al-LD
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:24:15 -0500
Date: Wed, 4 Jan 2017 15:24:12 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170104152329-mutt-send-email-mst@kernel.org>
References: <586cb5ab.f31d9d0a.38ac3.acf2@mx.google.com>
	<7a63340c-2fd8-f5ec-c39c-8958b9582752@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a63340c-2fd8-f5ec-c39c-8958b9582752@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] serial: fix memory leak in serial exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Li Qiang <liq3ea@gmail.com>, qemu-devel@nongnu.org, Li Qiang <liqiang6-s@360.cn>

On Wed, Jan 04, 2017 at 12:43:35PM +0100, Paolo Bonzini wrote:
> 
> 
> On 04/01/2017 09:43, Li Qiang wrote:
> > From: Li Qiang <liqiang6-s@360.cn>
> > 
> > The serial_exit_core function doesn't free some resources.
> > This can lead memory leak when hotplug and unplug. This
> > patch avoid this.
> > 
> > Signed-off-by: Li Qiang <liqiang6-s@360.cn>
> > ---
> >  hw/char/serial.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/hw/char/serial.c b/hw/char/serial.c
> > index ffbacd8..67b18ed 100644
> > --- a/hw/char/serial.c
> > +++ b/hw/char/serial.c
> > @@ -906,6 +906,16 @@ void serial_realize_core(SerialState *s, Error **errp)
> >  void serial_exit_core(SerialState *s)
> >  {
> >      qemu_chr_fe_deinit(&s->chr);
> > +
> > +    timer_del(s->modem_status_poll);
> > +    timer_free(s->modem_status_poll);
> > +
> > +    timer_del(s->fifo_timeout_timer);
> > +    timer_free(s->fifo_timeout_timer);
> > +
> > +    fifo8_destroy(&s->recv_fifo);
> > +    fifo8_destroy(&s->xmit_fifo);
> > +
> >      qemu_unregister_reset(serial_reset, s);
> >  }
> >  
> > 
> 
> Thanks, looks good.
> 
> Paolo


Paolo, so are you merging this?

Acked-by: Michael S. Tsirkin <mst@redhat.com>
-- 
MST
