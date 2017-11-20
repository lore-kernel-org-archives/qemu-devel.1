Received: from eggs.gnu.org ([2001:4830:134:3::10]:51366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eGmOH-0002nB-KW
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 08:45:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eGmOG-00065J-Nh
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 08:45:37 -0500
Date: Mon, 20 Nov 2017 08:45:21 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20171120134521.GB32161@localhost.localdomain>
References: <cover.1511145863.git.jcody@redhat.com>
	<0c039d00e03331d863ee249810d9778313670803.1511145863.git.jcody@redhat.com>
	<20171120114334.GD4516@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171120114334.GD4516@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 3/5] coroutines: abort if we
 try to enter a still-sleeping coroutine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com

On Mon, Nov 20, 2017 at 11:43:34AM +0000, Stefan Hajnoczi wrote:
> On Sun, Nov 19, 2017 at 09:46:44PM -0500, Jeff Cody wrote:
> > diff --git a/include/qemu/coroutine_int.h b/include/qemu/coroutine_int.h
> > index 931cdc9..b071217 100644
> > --- a/include/qemu/coroutine_int.h
> > +++ b/include/qemu/coroutine_int.h
> > @@ -56,6 +56,8 @@ struct Coroutine {
> >  
> >      int scheduled;
> >  
> > +    int sleeping;
> 
> s/int/bool/
> 

OK.

> BTW an alternative to adding individual bools is to implement a finite
> state machine for the entire coroutine lifecycle.  A single function can
> validate all state transitions:
> 
>   void check_state_transition(CoState old, CoState new,
>                               const char *action)
>   {
>       const char *errmsg = fsm[old][new];
>       if (!errmsg) {
>           return; /* valid transition! */
>       }
> 
>       fprintf(stderr, "Cannot %s coroutine from %s state\n",
>               action, state_name[old]);
>       abort();
>   }
> 
> Specifying fsm[][] forces us to think through all possible state
> transitions.  This approach is proactive whereas adding bool flags is
> reactive since it only covers a subset of states that were encountered
> after crashes.  I'm not sure if it's worth it though :).

Interesting idea; maybe more for 2.12 instead of 2.11, though?

Jeff
