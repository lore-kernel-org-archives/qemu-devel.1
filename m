Received: from eggs.gnu.org ([2001:4830:134:3::10]:59505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1fOioU-00046w-1L
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:05:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1fOioP-0001sD-U4
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:05:46 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52689)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <slp@redhat.com>) id 1fOioP-0001qc-Mv
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:05:41 -0400
Received: by mail-wm0-f68.google.com with SMTP id 18-v6so2595361wml.2
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 05:05:40 -0700 (PDT)
Date: Fri, 1 Jun 2018 14:05:38 +0200
From: Sergio Lopez <slp@redhat.com>
Message-ID: <20180601120538.guwfrzojgabnpofb@dritchie>
References: <20180531074601.10647-1-slp@redhat.com>
	<20180531074601.10647-4-slp@redhat.com>
	<CAJ+F1CKfpATgpFpHa85Esvv9k_T3FG_pY4rsz_C5a20CWfUgiQ@mail.gmail.com>
	<20180601115212.GU3458@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180601115212.GU3458@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] hw/char/serial: Don't retry on
 serial_xmit if errno == EPIPE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>

On Fri, Jun 01, 2018 at 12:52:12PM +0100, Daniel P. Berrangé wrote:
> On Thu, May 31, 2018 at 11:52:01AM +0200, Marc-André Lureau wrote:
> > Hi
> > 
> > On Thu, May 31, 2018 at 9:46 AM, Sergio Lopez <slp@redhat.com> wrote:
> > > If writing to the frontend channel failed with EPIPE, don't set up a
> > > retry. EPIPE is not a recoverable error, so trying again is a waste of CPU
> > > cycles.
> > >
> > > If the vCPU writing to the serial device and emulator thread are pinned
> > > to the same pCPU, it can also compromise the stability of the Guest OS,
> > > as both threads will be competing for pCPU's time, with the vCPU
> > > actively polling the serial device and barely giving time to the
> > > emulator thread to make actual progress.
> > > ---
> > >  hw/char/serial.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/hw/char/serial.c b/hw/char/serial.c
> > > index 2c080c9..f26e86b 100644
> > > --- a/hw/char/serial.c
> > > +++ b/hw/char/serial.c
> > > @@ -262,6 +262,7 @@ static void serial_xmit(SerialState *s)
> > >              /* in loopback mode, say that we just received a char */
> > >              serial_receive1(s, &s->tsr, 1);
> > >          } else if (qemu_chr_fe_write(&s->chr, &s->tsr, 1) != 1 &&
> > > +                   errno != EPIPE &&
> > >                     s->tsr_retry < MAX_XMIT_RETRY) {
> > 
> > Instead of adding explicit handling of EPIPE, shouldn't the code be
> > rewritten to treat -1 return && errno != EAGAIN as fatal?
> 
> Yes, exactly this code is already broken for every single errno
> value, not simply EPIPE. It needs fixing to treat '-1' return code
> correctly instead of retrying everything.

Given that EAGAIN is already taken care of in
chardev/char.c:qemu_chr_write_buffer, in which cases should we retry? Or
should we just drop all the tsr_retry logic?

Sergio.
