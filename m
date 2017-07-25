Received: from eggs.gnu.org ([2001:4830:134:3::10]:38691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1da6fF-0003MU-Jm
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 16:42:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1da6fC-0003I6-Ch
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 16:42:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1da6fC-0003Fs-2X
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 16:42:42 -0400
Date: Tue, 25 Jul 2017 17:42:33 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170725204233.GV2757@localhost.localdomain>
References: <20170725171014.25193-1-apahim@redhat.com>
	<20170725171014.25193-5-apahim@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170725171014.25193-5-apahim@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 4/6] qemu.py: cleanup launch()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amador Pahim <apahim@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@gmail.com, famz@redhat.com, berrange@redhat.com, mreitz@redhat.com, kwolf@redhat.com, armbru@redhat.com, crosa@redhat.com, ldoktor@redhat.com

On Tue, Jul 25, 2017 at 07:10:12PM +0200, Amador Pahim wrote:
> launch() is currently taking care of a number of flows, each one if its
> own exception treatment, depending on the VM state and the files
> creation state.
> 
> This patch makes launch() more resilient, off-loading the core calls to
> the new _launch() and calling shutdown() if any exception is raised by
> _launch(), making sure VM will be terminated and cleaned up.
> 
> Signed-off-by: Amador Pahim <apahim@redhat.com>
> ---
>  scripts/qemu.py | 42 +++++++++++++++++++++++++-----------------
>  1 file changed, 25 insertions(+), 17 deletions(-)
> 
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index 56142ed59b..45a63e8e9d 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -99,8 +99,11 @@ class QEMUMachine(object):
>          return self._popen.pid
>  
>      def _load_io_log(self):
> -        with open(self._qemu_log_path, "r") as fh:
> -            self._iolog = fh.read()
> +        try:
> +            with open(self._qemu_log_path, "r") as fh:
> +                self._iolog = fh.read()
> +        except IOError:
> +            pass

I don't like the idea of ignoring errors unconditionally.  It's
OK to ignore the file if we are recovering from a crash and
didn't even create it, but it's not OK if we ran QEMU
successfully and we really want to load the log file.

Maybe an optional ignore_errors argument to shutdown() and its
helpers, to tell the shutdown functions that it is really OK to
ignore errors?

>  
>      def _base_args(self):
>          if isinstance(self._monitor_address, tuple):
> @@ -126,23 +129,28 @@ class QEMUMachine(object):
>          self._remove_if_exists(self._qemu_log_path)
>  
>      def launch(self):
> -        '''Launch the VM and establish a QMP connection'''
> -        devnull = open('/dev/null', 'rb')
> -        qemulog = open(self._qemu_log_path, 'wb')

This was moved inside the try block.

This means we may try to read the log file even if we failed to
create it.  This will have funny side-effects if the log file
already existed and we didn't have permissions to write to it.

For example:

  ("/var/tmp/myvm.log" was created by another user)

  >>> m = qemu.QEMUMachine(binary='/usr/bin/qemu-system-x86_64', name='myvm')
  >>> m.launch()
  Traceback (most recent call last):
    File "<stdin>", line 1, in <module>
    File "qemu.py", line 151, in launch
      self.shutdown()
    File "qemu.py", line 182, in shutdown
      self._post_shutdown()
    File "qemu.py", line 130, in _post_shutdown
      self._remove_if_exists(self._qemu_log_path)
    File "qemu.py", line 83, in _remove_if_exists
      os.remove(path)
  OSError: [Errno 1] Operation not permitted: '/var/tmp/myvm.log'
  >>> m.get_log()
  'old log file\n'
  >>> 


> +        '''
> +        Try to launch the VM and make sure we cleanup on exception.
> +        '''
> +        if self.is_running():
> +            return

Why exactly is this necessary?

Calling launch() twice is likely to be a mistake (e.g. what if
self.args was changed?).  I would raise an Exception instead.


> +
>          try:
> -            self._pre_launch()
> -            args = self._wrapper + [self._binary] + self._base_args() + self.args
> -            self._popen = subprocess.Popen(args, stdin=devnull, stdout=qemulog,
> -                                           stderr=subprocess.STDOUT, shell=False)
> -            self._post_launch()
> +            self._launch()
>          except:
> -            if self.is_running():
> -                self._popen.kill()
> -                self._popen.wait()
> -            self._load_io_log()
> -            self._post_shutdown()

> +            self.shutdown()
>              raise
>  
> +    def _launch(self):
> +        '''Launch the VM and establish a QMP connection.'''
> +        devnull = open('/dev/null', 'rb')
> +        qemulog = open(self._qemu_log_path, 'wb')
> +        self._pre_launch()
> +        args = self._wrapper + [self._binary] + self._base_args() + self._args

This looks broken:

  >>> m.launch()
  Error launching VM.
  Traceback (most recent call last):
    File "<stdin>", line 1, in <module>
    File "qemu.py", line 147, in launch
      args = self._wrapper + [self._binary] + self._base_args() + self._args
  AttributeError: 'QEMUMachine' object has no attribute '_args'


> +        self._popen = subprocess.Popen(args, stdin=devnull, stdout=qemulog,
> +                                       stderr=subprocess.STDOUT, shell=False)
> +        self._post_launch()
> +
>      def shutdown(self):
>          '''Terminate the VM and clean up'''
>          if self.is_running():
> @@ -156,8 +164,8 @@ class QEMUMachine(object):
>              if exitcode < 0:
>                  sys.stderr.write('qemu received signal %i\n' % -exitcode)
>  
> -            self._load_io_log()
> -            self._post_shutdown()

It looks like the existing code isn't safe, and can call
_post_shutdown() before _post_launch() was called.

What if QEMUQtestMachine._pre_launch() failed because the qtest
socket is already in use by another process?  We shouldn't delete
a socket that doesn't even belong to us.

I suggest setting self._qemu_log_path, self._monitor_address,
self._qtest_path only after the files were really created, and
make _post_shutdown() delete the files only if those attributes
are not None (meaning we will only delete files that we created).


> +        self._load_io_log()
> +        self._post_shutdown()
>  
>      underscore_to_dash = string.maketrans('_', '-')
>      def qmp(self, cmd, conv_keys=True, **args):
> -- 
> 2.13.3
> 

-- 
Eduardo
