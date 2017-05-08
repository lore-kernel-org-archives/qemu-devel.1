Received: from eggs.gnu.org ([2001:4830:134:3::10]:36374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d7oxy-0005LA-Qi
	for qemu-devel@nongnu.org; Mon, 08 May 2017 16:09:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d7oxx-0000jz-PV
	for qemu-devel@nongnu.org; Mon, 08 May 2017 16:09:10 -0400
Received: from hera.aquilenet.fr ([2a01:474::1]:49708)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d7oxx-0000jr-Im
	for qemu-devel@nongnu.org; Mon, 08 May 2017 16:09:09 -0400
Date: Mon, 8 May 2017 22:09:07 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170508200907.ll5gms6krkk7kdct@var.youpi.perso.aquilenet.fr>
References: <20170505224833.17769-1-laurent@vivier.eu>
	<20170505224833.17769-2-laurent@vivier.eu>
	<20170505232738.targ5w5jm2vb73fe@var.youpi.perso.aquilenet.fr>
	<7f643a77-0dd7-cf43-b51a-337da34f8f87@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f643a77-0dd7-cf43-b51a-337da34f8f87@vivier.eu>
Subject: Re: [Qemu-devel] [PATCH v4 1/1] slirp: add SOCKS5 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Hello,

Laurent Vivier, on sam. 06 mai 2017 15:19:44 +0200, wrote:
> > Laurent Vivier, on sam. 06 mai 2017 00:48:33 +0200, wrote:
> >> @@ -617,6 +622,10 @@ void slirp_pollfds_poll(GArray *pollfds, int select_error)
> >>                   * Check sockets for reading
> >>                   */
> >>                  else if (revents & (G_IO_IN | G_IO_HUP | G_IO_ERR)) {
> >> +                    if (so->so_state & SS_ISFCONNECTING) {
> >> +                        socks5_recv(so->s, &so->so_proxy_state);
> >> +                        continue;
> >> +                    }
> > 
> > Again, I don't see how this can work with both socks5 case and
> > non-socks5 case.  Don't we need to somehow check for the type of socket
> > before calling socks5_recv?
> 
> The check is done previously by:
> 
> @@ -442,6 +443,10 @@ void slirp_pollfds_fill(GArray *pollfds, uint32_t
> *timeout)
>                      .fd = so->s,
>                      .events = G_IO_OUT | G_IO_ERR,
>                  };
> +                if (so->so_proxy_state &&
> +                    so->so_proxy_state != SOCKS5_STATE_ERROR) {
> +                    pfd.events |= G_IO_IN;
> +                }
> 
> We can enter in socks5_recv() only if so->so_proxy_state is in a valid
> state because G_IO_IN triggers that.

I don't understand: the socks5_recv gets called not only when pfd.events
contains G_IO_IN, but also when it contains G_IO_HUP or G_IO_ERR.  Also,
so_proxy_state being non-nul is not the only way to have G_IO_IN set in
pfd.events, so_state & SS_FACCEPTCONN and CONN_CANFRCV(so) also trigger
that.

> >> @@ -645,11 +654,19 @@ void slirp_pollfds_poll(GArray *pollfds, int select_error)
> >>                      /*
> >>                       * Check for non-blocking, still-connecting sockets
> >>                       */
> >> -                    if (so->so_state & SS_ISFCONNECTING) {
> >> -                        /* Connected */
> >> -                        so->so_state &= ~SS_ISFCONNECTING;
> >>  
> >> -                        ret = send(so->s, (const void *) &ret, 0, 0);
> >> +                    if (so->so_state & SS_ISFCONNECTING) {
> >> +                        ret = socks5_send(so->s, slirp->proxy_user,
> > 
> > Ditto.
> 
> if so_proxy_state is 0 the function does nothing

Well, that's quite weak reason to me, and will confuse readers, because
they'll think that the code is for the socks5 case only.

> >> +++ b/slirp/socks5.c
> >> @@ -0,0 +1,371 @@
> > 
> > In v2 of the patch, this was said to have "some parts from nmap/ncat
> > GPLv2".  Is that really not true any more?  If any part of the file is
> > not original, it *has* to wear proper copyright notices, otherwise it's
> > copyright infrigement.
> 
> No, I've re-written entirely this part from RFC.

Ok.

> for ncat.h

Which code comes from ncat.h?

Again, we can't copy/paste code like that, that is copyright
infrigement.

> license is 281 lines long (with clarifications and
> extensions) for 60 lines copied...

That is really no reason.  Copyright thingies are considered as soon
as dozen-ish lines of non-trivial code.  The size of the terms of the
licence itself really doesn't matter.  If we don't respect others'
copyright, we can't expect others (e.g. companies) to respect our GPL
code.

Samuel
