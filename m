Received: from eggs.gnu.org ([2001:4830:134:3::10]:41723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fMBdE-0005ol-AY
	for qemu-devel@nongnu.org; Fri, 25 May 2018 08:15:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fMBdB-0005ZN-4Z
	for qemu-devel@nongnu.org; Fri, 25 May 2018 08:15:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37882 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fMBdA-0005Z6-Vi
	for qemu-devel@nongnu.org; Fri, 25 May 2018 08:15:37 -0400
Date: Fri, 25 May 2018 15:15:35 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180525151148-mutt-send-email-mst@kernel.org>
References: <1527186303-192100-1-git-send-email-mst@redhat.com>
	<1527186303-192100-3-git-send-email-mst@redhat.com>
	<ac1f972f-2769-9945-868d-e80a01842f4f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac1f972f-2769-9945-868d-e80a01842f4f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 2/3] libqtest: fail if child coredumps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>

On Fri, May 25, 2018 at 08:10:48AM +0200, Thomas Huth wrote:
> On 24.05.2018 20:25, Michael S. Tsirkin wrote:
> > Right now tests report OK status if QEMU crashes during cleanup.
> > Let's catch that case and fail the test.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  tests/libqtest.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tests/libqtest.c b/tests/libqtest.c
> > index 43fb97e..f869854 100644
> > --- a/tests/libqtest.c
> > +++ b/tests/libqtest.c
> > @@ -103,8 +103,15 @@ static int socket_accept(int sock)
> >  static void kill_qemu(QTestState *s)
> >  {
> >      if (s->qemu_pid != -1) {
> > +        int wstatus = 0;
> > +        pid_t pid;
> > +
> >          kill(s->qemu_pid, SIGTERM);
> > -        waitpid(s->qemu_pid, NULL, 0);
> > +        pid = waitpid(s->qemu_pid, &wstatus, 0);
> > +
> > +        if (pid == s->qemu_pid && WIFSIGNALED(wstatus)) {
> > +            assert(!WCOREDUMP(wstatus));
> 
> Another ugliness that I just discovered: kill_qemu is also called from
> the SIGABRT handler. So if a qtest assert() triggers an abort(), the
> abort handler runs kill_qemu which now could trigger another assert()
> and thus abort().

But only the first one will cause a coredump.

> It's likely not a real problem since the abort handler
> has been installed with SA_RESETHAND, but it's still quite confusing code.
> 
> Please let's clean up this ugliness properly: I think kill_qemu should
> *only* be used by the abort handler, and then kill QEMU with SIGKILL for
> good, to make sure that there are no stuck QEMU processes hanging around
> anymore.
> 
> qtest_quit() should simply try to quit QEMU via QMP instead, and then
> check for WIFEXITED(wstatus) && !WEXITSTATUS(wstatus) instead of using
> the kill_qemu() function.
> 
>  Thomas

I think I'll drop the second patch for now. failing test on coredump
is clearly correct. The rest can wait until someone has the energy
to look into all the intricacies of signal handling.

-- 
MST
