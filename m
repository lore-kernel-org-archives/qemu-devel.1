Received: from eggs.gnu.org ([2001:4830:134:3::10]:41223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1erbev-0000Xb-R8
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 22:47:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1erbeq-0000os-ND
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 22:47:01 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53934 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1erbeq-0000oS-Is
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 22:46:56 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1A8904075168
	for <qemu-devel@nongnu.org>; Fri,  2 Mar 2018 03:46:56 +0000 (UTC)
Date: Fri, 2 Mar 2018 11:46:45 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180302034645.GU27381@xz-mi>
References: <20180301084438.13594-1-peterx@redhat.com>
	<20180301084438.13594-2-peterx@redhat.com>
	<4fc6fbe7-5b7e-fa04-7f99-9740e00a928a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4fc6fbe7-5b7e-fa04-7f99-9740e00a928a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 01/15] chardev: fix leak in
 tcp_chr_telnet_init_io()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Mar 01, 2018 at 06:39:34PM +0100, Paolo Bonzini wrote:
> On 01/03/2018 09:44, Peter Xu wrote:
> > Need to free TCPChardevTelnetInit when session established.
> > 
> > Since at it, switch to use G_SOURCE_* macros.
> > 
> > Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  chardev/char-socket.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> > index bdd6cff5f6..43a2cc2c1c 100644
> > --- a/chardev/char-socket.c
> > +++ b/chardev/char-socket.c
> > @@ -591,19 +591,23 @@ static gboolean tcp_chr_telnet_init_io(QIOChannel *ioc,
> >              ret = 0;
> >          } else {
> >              tcp_chr_disconnect(init->chr);
> > -            return FALSE;
> > +            goto end;
> >          }
> >      }
> >      init->buflen -= ret;
> >  
> >      if (init->buflen == 0) {
> >          tcp_chr_connect(init->chr);
> > -        return FALSE;
> > +        goto end;
> >      }
> >  
> >      memmove(init->buf, init->buf + ret, init->buflen);
> >  
> > -    return TRUE;
> > +    return G_SOURCE_CONTINUE;
> > +
> > +end:
> > +    g_free(init);
> > +    return G_SOURCE_REMOVE;
> >  }
> >  
> >  static void tcp_chr_telnet_init(Chardev *chr)
> > 
> 
> Queued, thanks (but it's okay if you post it again in v3, because I'm
> not sure I'll be able to send a pull request tomorrow).

Sure, thanks.

I believe this is an equivalent "r-b" if I repost. :)

-- 
Peter Xu
