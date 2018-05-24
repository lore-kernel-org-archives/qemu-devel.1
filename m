Received: from eggs.gnu.org ([2001:4830:134:3::10]:56951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLsg4-0005Fa-2x
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:01:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLsfy-0004az-LU
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:01:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55542 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fLsfy-0004ar-Ge
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:01:14 -0400
Date: Thu, 24 May 2018 19:01:13 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180524190037-mutt-send-email-mst@kernel.org>
References: <1527176250-178968-1-git-send-email-mst@redhat.com>
	<872e6cdb-9cff-cb4d-e667-a664f2daa633@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <872e6cdb-9cff-cb4d-e667-a664f2daa633@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/1] libqtest: add more exit status
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

On Thu, May 24, 2018 at 05:54:37PM +0200, Thomas Huth wrote:
> On 24.05.2018 17:38, Michael S. Tsirkin wrote:
> > Add more checks on how did QEMU exit.
> > 
> > Legal ways to exit right now:
> > - exit(0) or return from main
> > - kill(SIGTERM) - sent by testing infrastructure
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > 
> > Changes from v1:
> > - drop SIGTERM as suggested by Eric
> > 
> >  tests/libqtest.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/tests/libqtest.c b/tests/libqtest.c
> > index f869854..0576874 100644
> > --- a/tests/libqtest.c
> > +++ b/tests/libqtest.c
> > @@ -110,7 +110,12 @@ static void kill_qemu(QTestState *s)
> >          pid = waitpid(s->qemu_pid, &wstatus, 0);
> >  
> >          if (pid == s->qemu_pid && WIFSIGNALED(wstatus)) {
> 
> Since we're only waiting for one pid ... wouldn't it be better to do
> 
>  assert(pid == s->qemu_pid)
> 
> instead?
> 
> > +            /* Core dump is never OK */
> >              assert(!WCOREDUMP(wstatus));
> > +            /* Must exit normally */
> > +            assert(WIFEXITED(wstatus));
> 
> So you asserted that WIFEXITED(wstatus) != 0 here ...
> 
> > +            /* If exited normally - check exit status */
> > +            assert(!WIFEXITED(wstatus) || !WEXITSTATUS(wstatus));
> 
> So "!WIFEXITED(wstatus)" is always 0 here? That's confusing...?
> 
>  Thomas

It will allow adding more conditions if we ever need to though.
