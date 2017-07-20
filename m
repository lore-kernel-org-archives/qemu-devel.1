Received: from eggs.gnu.org ([2001:4830:134:3::10]:37282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dYFZc-0005zc-4q
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 13:49:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dYFZZ-0004h8-Hv
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 13:49:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dYFZZ-0004f6-8N
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 13:49:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C4554624DD
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 17:49:11 +0000 (UTC)
Date: Thu, 20 Jul 2017 14:49:05 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170720174905.GQ2757@localhost.localdomain>
References: <20170720091902.22476-1-apahim@redhat.com>
	<20170720091902.22476-2-apahim@redhat.com>
	<87inin1g78.fsf@dusky.pond.sub.org>
	<CALAZnb1uWT__Pnd-zeP3_L+t+JDtK42+KHV9qo_r6qXWs4P64w@mail.gmail.com>
	<87vamnuovc.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87vamnuovc.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v3 1/3] qemu.py: fix is_running()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Amador Pahim <apahim@redhat.com>, kwolf@redhat.com, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, mreitz@redhat.com, Cleber Rosa <crosa@redhat.com>

On Thu, Jul 20, 2017 at 05:09:11PM +0200, Markus Armbruster wrote:
> Amador Pahim <apahim@redhat.com> writes:
> 
> > On Thu, Jul 20, 2017 at 1:49 PM, Markus Armbruster <armbru@redhat.com> wrote:
> >> Amador Pahim <apahim@redhat.com> writes:
> >>
> >>> Current implementation is broken. It does not really test if the child
> >>> process is running.
> >>
> >> What usage exactly is broken by this?  Got a reproducer for me?
> >
> > Problem is that 'returncode' is not set without a calling
> > poll()/wait()/communicate(), so it's only useful to test if the
> > process is running after such calls. But if we use 'poll()' instead,
> > it will, according to the docs, "Check if child process has
> > terminated. Set and return returncode attribute."
> >
> > Reproducer is:
> >
> >  >>> import subprocess
> >  >>> devnull = open('/dev/null', 'rb')
> >  >>> p = subprocess.Popen(['qemu-system-x86_64', '-broken'],
> > stdin=devnull, stdout=devnull, stderr=devnull, shell=False)
> >  >>> print p.returncode
> >  None
> >  >>> print p.poll()
> >  1
> >  >>> print p.returncode
> >  1
> >
> >>> The Popen.returncode will only be set after by a poll(), wait() or
> >>> communicate(). If the Popen fails to launch a VM, the Popen.returncode
> >>> will not turn to None by itself.
> >>
> >> Hmm.  What is the value of .returncode then?
> >
> > returncode starts with None and becomes the process exit code when the
> > process is over and one of that three methods is called (poll(),
> > wait() or communicate()).
> >
> > There's an error in my description though. The correct would be: "The
> > Popen.returncode will only be set after a call to poll(), wait() or
> > communicate(). If the Popen fails to launch a VM, the Popen.returncode
> > will not turn from None to the actual return code by itself."
> 
> Suggest to add ", and is_running() continues to report True".
> 
> >>> Instead of using Popen.returncode, let's use Popen.poll(), which
> >>> actually checks if child process has terminated.
> >>>
> >>> Signed-off-by: Amador Pahim <apahim@redhat.com>
> >>> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> >>> Reviewed-by: Fam Zheng <famz@redhat.com>
> >>> ---
> >>>  scripts/qemu.py | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/scripts/qemu.py b/scripts/qemu.py
> >>> index 880e3e8219..f0fade32bd 100644
> >>> --- a/scripts/qemu.py
> >>> +++ b/scripts/qemu.py
> >>> @@ -86,7 +86,7 @@ class QEMUMachine(object):
> >>>              raise
> >>>
> >>>      def is_running(self):
> >>> -        return self._popen and (self._popen.returncode is None)
> >>> +        return self._popen and (self._popen.poll() is None)
> >>>

After re-reading shutdown(), I think this is _not_ OK: if
is_running() return False before we call .wait(), we will never
load the log file or run _post_shutdown() if QEMU exits between
the launch() and shutdown() calls.

Yes, it's fragile.

The root problem on both launch() and shutdown() seems to be
coupling the external "is QEMU running?" state with the internal
"did we load the log file and ran _post_shutdown() already?"
state.

I see two possible approaches for this:

1) Benefit from the fact that the internal Popen state will not
   change under our feet unless we explicitly call
   poll()/wait()/etc, and keep the existing code.  (Not my
   favorite option)

2) Rewrite the code so that we don't depend on the subtle Popen
   internal state rules, and track our own internal state in
   a QEMUMachine attribute.  e.g.:

    def _handle_shutdown(self):
        '''Load log file and call _post_shutdown() hook if necessary'''
        # Must be called only after QEMU actually exited.
        assert not self.is_running()
        if self._shutdown_pending:
            if self.exitcode() < 0:
                sys.stderr.write('qemu received signal %i: %s\n' % (-exitcode, ' '.join(self._args)))
            self._load_io_log()
            self._post_shutdown()
            self._shutdown_pending = False

    def _terminate(self):
        '''Terminate QEMU if it's still running'''
        if self.is_running():
            try:
                self._qmp.cmd('quit')
                self._qmp.close()
            except:
                self._popen.kill()
                self._popen.wait()

    def _launch(self):
        '''Launch the VM and establish a QMP connection'''
        devnull = open('/dev/null', 'rb')
        qemulog = open(self._qemu_log_path, 'wb')
        self._shutdown_pending = True
        self._pre_launch()
        args = self._wrapper + [self._binary] + self._base_args() + self._args
        self._popen = subprocess.Popen(args, stdin=devnull, stdout=qemulog,
                                       stderr=subprocess.STDOUT, shell=False)
        self._post_launch()

    def launch(self):
        try:
            self._launch()
        except:
            self._terminate()
            self._handle_shutdown()
            raise

    def shutdown(self):
        '''Terminate the VM and clean up'''
        self._terminate()
        self._handle_shutdown()


Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

> >>>      def exitcode(self):
> >>>          if self._popen is None:
> >>                return None
> >>            return self._popen.returncode
> >>
> >> Why is this one safe?
> >
> > Here it's used just to retrieve the value from the Popen.returncode.
> > It's not being used to check whether the process is running or not.
> 
> If self._popen is not None, we return self._popen.returncode.  It's None
> if .poll() etc. haven't been called.  Can this happen?  If not, why not?
> If yes, why is returning None then okay?

It can't happen because the only caller of exitcode()
(device-crash-test) calls it immediately after shutdown().  But
it would be nice to make exitcode() behavior consistent with
is_running().

-- 
Eduardo
