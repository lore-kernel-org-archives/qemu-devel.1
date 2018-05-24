Received: from eggs.gnu.org ([2001:4830:134:3::10]:35869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLumJ-0007kM-7y
	for qemu-devel@nongnu.org; Thu, 24 May 2018 14:15:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLumF-0004hw-1A
	for qemu-devel@nongnu.org; Thu, 24 May 2018 14:15:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57950 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fLumE-0004hY-R2
	for qemu-devel@nongnu.org; Thu, 24 May 2018 14:15:50 -0400
Date: Thu, 24 May 2018 21:15:49 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180524205847-mutt-send-email-mst@kernel.org>
References: <1527178151-181781-1-git-send-email-mst@redhat.com>
	<bf33951f-d205-ec9c-4ceb-7703deea97f7@redhat.com>
	<20180524203055-mutt-send-email-mst@kernel.org>
	<02e22133-8358-99c6-784e-52ac39b7b273@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02e22133-8358-99c6-784e-52ac39b7b273@redhat.com>
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

On Thu, May 24, 2018 at 07:58:06PM +0200, Thomas Huth wrote:
> On 24.05.2018 19:33, Michael S. Tsirkin wrote:
> > On Thu, May 24, 2018 at 07:26:16PM +0200, Thomas Huth wrote:
> >> On 24.05.2018 18:11, Michael S. Tsirkin wrote:
> >>> Add more checks on how did QEMU exit.
> >>>
> >>> Legal ways to exit right now:
> >>> - exit(0) or return from main
> >>> - kill(SIGTERM) - sent by testing infrastructure
> >>>
> >>> Anything else is illegal.
> >> [...]
> >>> -        if (pid == s->qemu_pid && WIFSIGNALED(wstatus)) {
> >>> +        /* waitpid returns child PID on success */
> >>> +        assert(pid == s->qemu_pid);
> >>> +
> >>> +        /* If exited on signal - check the reason: core dump is never OK */
> >>> +        if (WIFSIGNALED(wstatus)) {
> >>>              assert(!WCOREDUMP(wstatus));
> >>>          }
> >>> +        /* If exited normally - check exit status */
> >>> +        if (WIFEXITED(wstatus)) {
> >>> +            assert(!WEXITSTATUS(wstatus));
> >>> +        }
> >>> +        /* Valid ways to exit: right now only return from main or exit */
> >>> +        assert(WIFEXITED(wstatus));
> >>>      }
> >>>  }
> >>
> >> It's strange that you always get WIFEXITED(wstatus) == true here, even
> >> if QEMU has been terminated by SIGTERM? I assume that's due to the fact
> >> that QEMU intercepts SIGTERM and terminates via exit() instead?
> > 
> > Right now, yes. This can of course change, so it's not
> > a good idea hard-coding this assumption to deep
> > in the code, imho.
> > 
> >> So I
> >> think you could simply replace the last three asserts with:
> >>
> >> 	assert(WIFEXITED(wstatus) && !WEXITSTATUS(wstatus));
> >>
> >>  Thomas
> > 
> > I could but they would be harder to debug.
> > 
> > If I see
> > 	"assertion failed: !WCOREDUMP(wstatus)"
> > then that is very readable.
> > 
> > If I just see
> > 	"assertion failed: WIFEXITED(wstatus) && !WEXITSTATUS(wstatus)"
> > then I just know something went wrong.
> 
> Then simply use:
> 
> 	assert(WIFEXITED(wstatus));
> 	assert(!WEXITSTATUS(wstatus));
> 
> If QEMU exited due to a signal, you'll see the first assert, and if it
> returned a non-zero exit code, you'll see the second assert. That's all
> you really need to know here, I think.
> 
> I don't think that you gain anything by checking WCOREDUMP() here.
> And
> according to the man-page of waitpid:
> 
>  This macro is not specified in POSIX.1-2001 and is not
>  available on some UNIX implementations (e.g., AIX, SunOS).
>  Only use this enclosed in #ifdef WCOREDUMP ... #endif.
> 
> So if you insist on using that macro, you might need to add some #ifdef
> code around it, I think.
> 
>  Thomas

I think we are better off defining it if it's not defined.
Will post an osdep patch.

-- 
MST
