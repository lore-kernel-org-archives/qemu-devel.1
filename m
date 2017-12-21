Received: from eggs.gnu.org ([2001:4830:134:3::10]:49255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eS3mQ-0006dN-6q
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 11:33:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eS3mN-0005m8-Jr
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 11:33:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33702)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1eS3mN-0005l4-Ec
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 11:33:07 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4F65F285D0
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 16:33:06 +0000 (UTC)
Date: Thu, 21 Dec 2017 17:33:02 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171221173302.0e3b863a.cohuck@redhat.com>
In-Reply-To: <20171221161904.GJ30327@redhat.com>
References: <20171221105433.32307-1-berrange@redhat.com>
	<20171221165235.45b3439a.cohuck@redhat.com>
	<20171221161904.GJ30327@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] char: don't silently skip tn3270 protocol
 init when TLS is enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

On Thu, 21 Dec 2017 16:19:04 +0000
"Daniel P. Berrange" <berrange@redhat.com> wrote:

> On Thu, Dec 21, 2017 at 04:52:35PM +0100, Cornelia Huck wrote:
> > On Thu, 21 Dec 2017 10:54:33 +0000
> > "Daniel P. Berrange" <berrange@redhat.com> wrote:
> >   
> > > Even if common tn3270 implementations do not support TLS, it is trivial to
> > > have them proxied over a proxy like stunnel which adds TLS at the sockets
> > > layer. We should thus not silently skip tn3270 protocol initialization
> > > when TLS is enabled.
> > > 
> > > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > > ---
> > >  chardev/char-socket.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> > > index 53eda8ef00..6013972f72 100644
> > > --- a/chardev/char-socket.c
> > > +++ b/chardev/char-socket.c
> > > @@ -623,8 +623,7 @@ static void tcp_chr_tls_handshake(QIOTask *task,
> > >      if (qio_task_propagate_error(task, NULL)) {
> > >          tcp_chr_disconnect(chr);
> > >      } else {
> > > -        /* tn3270 does not support TLS yet */
> > > -        if (s->do_telnetopt && !s->is_tn3270) {
> > > +        if (s->do_telnetopt) {
> > >              tcp_chr_telnet_init(chr);
> > >          } else {
> > >              tcp_chr_connect(chr);  
> > 
> > With this patch applied, attaching an additional 3270 tty still works
> > for me as before.
> > 
> > I have no idea how to try this out with TLS, though. Would you be able
> > to run a sanity check? (The instructions in
> > https://wiki.qemu.org/Features/3270 work fine with a tcg s390x guest.)  
> 
> NB, the x3270 emulator that's described in that page would not do TLS
> in the manner than it's provided by QEMU. x3270 wants to start in plain
> text mode, and then use STARTTLS command to negotiate use of TLS afterwards.
> 
> The QEMU chardev code doesn't work that way - it immediately activates
> TLS when started, with no optional negotiation.

Ah, OK. IIRC, z/VM usually uses STARTTLS.

> 
> We could potentially add support for STARTTLS telent/tn3270 negotiation,
> but that would be a separate mode from the TLS support we currently have
> in QEMU chardevs.
> 
> I'm guessing the original author who added this check I'm removing was
> mixing these two modes of operating, and hence mistakenly added this
> check to stop 3270 init.

Maybe add a sentence regarding STARTTLS vs. QEMU TLS support in the
patch description?

In any case, this does not seem to do any harm, so feel free to add my

Acked-by: Cornelia Huck <cohuck@redhat.com>
