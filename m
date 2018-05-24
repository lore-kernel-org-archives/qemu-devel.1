Received: from eggs.gnu.org ([2001:4830:134:3::10]:53452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLu7Y-0006YD-Aw
	for qemu-devel@nongnu.org; Thu, 24 May 2018 13:33:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLu7U-0005VE-EZ
	for qemu-devel@nongnu.org; Thu, 24 May 2018 13:33:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35964 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fLu7U-0005V0-9t
	for qemu-devel@nongnu.org; Thu, 24 May 2018 13:33:44 -0400
Date: Thu, 24 May 2018 20:33:43 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180524203055-mutt-send-email-mst@kernel.org>
References: <1527178151-181781-1-git-send-email-mst@redhat.com>
	<bf33951f-d205-ec9c-4ceb-7703deea97f7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf33951f-d205-ec9c-4ceb-7703deea97f7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/1] libqtest: add more exit status
 checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>

On Thu, May 24, 2018 at 07:26:16PM +0200, Thomas Huth wrote:
> On 24.05.2018 18:11, Michael S. Tsirkin wrote:
> > Add more checks on how did QEMU exit.
> > 
> > Legal ways to exit right now:
> > - exit(0) or return from main
> > - kill(SIGTERM) - sent by testing infrastructure
> > 
> > Anything else is illegal.
> [...]
> > -        if (pid == s->qemu_pid && WIFSIGNALED(wstatus)) {
> > +        /* waitpid returns child PID on success */
> > +        assert(pid == s->qemu_pid);
> > +
> > +        /* If exited on signal - check the reason: core dump is never OK */
> > +        if (WIFSIGNALED(wstatus)) {
> >              assert(!WCOREDUMP(wstatus));
> >          }
> > +        /* If exited normally - check exit status */
> > +        if (WIFEXITED(wstatus)) {
> > +            assert(!WEXITSTATUS(wstatus));
> > +        }
> > +        /* Valid ways to exit: right now only return from main or exit */
> > +        assert(WIFEXITED(wstatus));
> >      }
> >  }
> 
> It's strange that you always get WIFEXITED(wstatus) == true here, even
> if QEMU has been terminated by SIGTERM? I assume that's due to the fact
> that QEMU intercepts SIGTERM and terminates via exit() instead?

Right now, yes. This can of course change, so it's not
a good idea hard-coding this assumption to deep
in the code, imho.

> So I
> think you could simply replace the last three asserts with:
> 
> 	assert(WIFEXITED(wstatus) && !WEXITSTATUS(wstatus));
> 
>  Thomas

I could but they would be harder to debug.

If I see
	"assertion failed: !WCOREDUMP(wstatus)"
then that is very readable.

If I just see
	"assertion failed: WIFEXITED(wstatus) && !WEXITSTATUS(wstatus)"
then I just know something went wrong.

-- 
MST
