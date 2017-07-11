Received: from eggs.gnu.org ([2001:4830:134:3::10]:51390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dV0Wn-0001Ic-Fg
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 15:08:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dV0Wi-0008FK-Jw
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 15:08:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36748)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dV0Wi-0008F0-Ao
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 15:08:52 -0400
Date: Tue, 11 Jul 2017 20:08:47 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170711190846.GA3138@work-vm>
References: <20170709175422.30185-1-peter.maydell@linaro.org>
	<20170711162943.GF2223@work-vm>
	<CAFEAcA-JXT3B0uXbxbh9oex4gngsz350Sq+P4QK=aqAS9q1dcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-JXT3B0uXbxbh9oex4gngsz350Sq+P4QK=aqAS9q1dcA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] slirp: fork_exec(): Don't close() a
 negative number in fork_exec()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, Eric Blake <eblake@redhat.com>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> [cc'd Eric as the sort of person
> 
> On 11 July 2017 at 17:29, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> > * Peter Maydell (peter.maydell@linaro.org) wrote:
> >> In a fork_exec() error path we try to closesocket(s) when s might
> >> be a negative number because the thing that failed was the
> >> qemu_socket() call. Add a guard so we don't do this.
> >>
> >> (Spotted by Coverity: CID 1005727 issue 1 of 2.)
> >>
> >> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> >> ---
> >> Issue 2 of 2 in CID 1005727 is trickier -- we need to move as
> >> much as possible of the client-end connect/accept out of the
> >> child process and into the parent as possible. I'm not sure
> >> if it's safe to do it all in the parent without deadlocking...
> >
> > or just bail earlier?
> 
> The problem is you can only bail while you're in the parent
> before forking. Once you've started the child there's no
> mechanism for dealing with failure.

Well, you can always exit the child before anything worse can happen.

> >   The bit that worries me there
> > is the dup2(s, [012]); which is called unchecked, if that fails
> > then your telnetd or whatever probably ends up connected to whatever
> > your 0..2 were originally.
> 
> dup2() in a child is actually pretty safe -- the only ways
> it can fail are:
>  * fd2 isn't actually an open file descriptor (can't happen)
>  * fd1 is negative or bigger than OPEN_MAX (can't happen)
>  * EINTR (just retry, I guess)

True, I'd missed that fd1 was probably always a valid fd;
so probably the rest of this is pretty academic.

> The awkward part is POSIX says that dup2() may fail with EIO if
> the close() of newfd failed, in which case I dunno what the
> child is supposed to do about it -- do a manual close(), ignore
> the error from close() and then dup2() again??

I wouldn't like to bet on it being legal to call close() on an
error, what state is the fd you wanted to close in?

> Linux specifically says it doesn't do this, and BSD/OSX don't
> document EIO as possible so I assume they have sane behaviour.
> 
> In any case, ignoring the possibility that dup2(s, [012]) in a child
> process could fail is AFAIK very very widespread standard
> behaviour for unix daemons. (We have another example in
> os_setup_post() in os-posix.c, for instance.)
> 
> Random extra: Linux dup2() manpage has a mysterious remark about
> EBUSY -- does anybody know what that's all about? It's not
> sanctioned by POSIX...
> 
> What I would like to do and think should be safe is:
> 
>     s = qemu_socket(...);
>     bind(s);
>     listen(s, 1);
>     cs = qemu_socket(...);
>     connect(cs, ...);
>     switch (fork ()) {
>         child:
>            dup2
>            close fds
>            execvp(...);
>         parent:
>            break;
>     }
>     close(cs);
>     ss = accept(s, ...);
>     close(s);
>     etc;
> 
> ie push the bind/listen/create client socket/connect up into
> before the fork(), to give the behaviour of "like socketpair()
> but for AF_INET".
> 
> (I believe this will work and not deadlock because connect()
> doesn't block until accept(), it only needs the tcp handshake.)

OK, I don't know the details of the blocking htere.

Dave

> >>  slirp/misc.c | 4 +++-
> >>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/slirp/misc.c b/slirp/misc.c
> >> index 88e9d94197..260187b6b6 100644
> >> --- a/slirp/misc.c
> >> +++ b/slirp/misc.c
> >> @@ -112,7 +112,9 @@ fork_exec(struct socket *so, const char *ex, int do_pty)
> >>                   bind(s, (struct sockaddr *)&addr, addrlen) < 0 ||
> >>                   listen(s, 1) < 0) {
> >>                       error_report("Error: inet socket: %s", strerror(errno));
> >> -                     closesocket(s);
> >> +                     if (s >= 0) {
> >> +                         closesocket(s);
> >> +                     }
> >
> >
> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >
> > (I'm not convinced this would ever do anything bad, at least on a *nix
> > system, the -ve value is always going to be an invalid fd so the close
> > will just fail).
> 
> Indeed. But it keeps Coverity happy.
> 
> thanks
> -- PMM
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
