Received: from eggs.gnu.org ([2001:4830:134:3::10]:58937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dXuEf-0005yt-98
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 15:02:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dXuEc-0008Mq-4S
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 15:02:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dXuEb-0008Md-S5
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 15:02:10 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C00D97CE12
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 19:02:08 +0000 (UTC)
Date: Wed, 19 Jul 2017 16:02:03 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170719190203.GA16400@localhost.localdomain>
References: <20170719163108.26943-1-apahim@redhat.com>
	<20170719163108.26943-2-apahim@redhat.com>
	<20170719183447.GJ2757@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170719183447.GJ2757@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] qemu.py: fix is_running()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amador Pahim <apahim@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, mreitz@redhat.com, kwolf@redhat.com, armbru@redhat.com, crosa@redhat.com, ldoktor@redhat.com

On Wed, Jul 19, 2017 at 03:34:47PM -0300, Eduardo Habkost wrote:
> On Wed, Jul 19, 2017 at 06:31:06PM +0200, Amador Pahim wrote:
> > Current implementation is broken. It does not really test if the child
> > process is running.
> > 
> > The Popen.returncode will only be set after by a poll(), wait() or
> > communicate(). If the Popen fails to launch a VM, the Popen.returncode
> > will not turn to None by itself.
> > 
> > Instead of using Popen.returncode, let's use Popen.poll(), which
> > actually checks if child process has terminated.
> > 
> > Signed-off-by: Amador Pahim <apahim@redhat.com>
> 
> I vaguely remember I had a version of that code using poll() and
> it broke scripts for some reason.  I will try to find out why, so
> we can either fix the script or document the reason why poll()
> isn't a good choice here.

Thanks to git reflog, I found the original "fix" I had in my WIP
tree:

251fc73 work/device-crash-script@{71}: commit: fixup! qemu.py: Don't set _popen=None on error/shutdown
diff --git a/scripts/qemu.py b/scripts/qemu.py
index 4dae811..cbc9e2a 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -86,7 +86,7 @@ class QEMUMachine(object):
             raise

     def is_running(self):
-        return self._popen and (self._popen.poll() is None)
+        return self._popen and (self._popen.returncode is None)

     def exitcode(self):
         if self._popen:
@@ -137,6 +137,7 @@ class QEMUMachine(object):
         except:
             if self.is_running():
                 self._popen.kill()
+                self._popen.wait()
             self._load_io_log()
             self._post_shutdown()
             raise

The original bug was like this: if QEMU process took a little
longer to be actually terminated after self._popen.kill() was
called, it triggering post-shutdown code inside shutdown()
(because is_running() was still True), causing the following
exception:

Traceback (most recent call last):
  File "./scripts/device-crash-test.py", line 528, in <module>
    sys.exit(main())
  File "./scripts/device-crash-test.py", line 487, in main
    f = checkOneCase(args, t)
  File "./scripts/device-crash-test.py", line 320, in checkOneCase
    vm.shutdown()
  File "/home/ehabkost/rh/proj/virt/qemu/scripts/qemu.py", line 156, in shutdown
    self._load_io_log()
  File "/home/ehabkost/rh/proj/virt/qemu/scripts/qemu.py", line 101, in _load_io_log
    with open(self._qemu_log_path, "r") as fh:
IOError: [Errno 2] No such file or directory: '/var/tmp/qemu-23568.log'


My fix was incorrect: the actual bug was the missing
self._popen.wait() call after self._popen.kill(), not the
self._popen.poll() call.  Your fix looks good and
device-crash-test is not crashing.

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

> 
> > ---
> >  scripts/qemu.py | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/scripts/qemu.py b/scripts/qemu.py
> > index 880e3e8219..f0fade32bd 100644
> > --- a/scripts/qemu.py
> > +++ b/scripts/qemu.py
> > @@ -86,7 +86,7 @@ class QEMUMachine(object):
> >              raise
> >  
> >      def is_running(self):
> > -        return self._popen and (self._popen.returncode is None)
> > +        return self._popen and (self._popen.poll() is None)
> >  
> >      def exitcode(self):
> >          if self._popen is None:
> > -- 
> > 2.13.3
> > 
> 
> -- 
> Eduardo

-- 
Eduardo
