Received: from eggs.gnu.org ([2001:4830:134:3::10]:50517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dhXUD-00046S-Gg
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:46:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dhXUC-0007DT-5U
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:46:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dhXUB-0007Cb-SS
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:46:04 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170731085110.1050-1-apahim@redhat.com>
	<20170731085110.1050-7-apahim@redhat.com>
Date: Tue, 15 Aug 2017 10:45:57 +0200
In-Reply-To: <20170731085110.1050-7-apahim@redhat.com> (Amador Pahim's message
	of "Mon, 31 Jul 2017 10:51:09 +0200")
Message-ID: <87inhprzga.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 6/7] qemu.py: cleanup and improve
 launch()/shutdown()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amador Pahim <apahim@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, ldoktor@redhat.com, famz@redhat.com, ehabkost@redhat.com, stefanha@gmail.com, mreitz@redhat.com, crosa@redhat.com

Amador Pahim <apahim@redhat.com> writes:

> launch() is currently taking care of a number of flows, each one if its
> own exception treatment, depending on the VM state and the files
> creation state.
>
> This patch makes launch() more resilient, off-loading the core calls to
> the new _launch() and calling shutdown() if any exception is raised by
> _launch(), making sure VM will be terminated and cleaned up.
>
> Also, the pre_launch() was changed to make sure the files that will

Imperative mood, please: "change pre_launch() to make sure..."

"Also, ..." in a commit message is often a sign that the commit should
be split.  I'm not sure in this case, because I'm not yet sure I get
what it does.  Could also be a sign that it should be split :)

> be created are not present in the system before creating them and the
> post_shutdown() will now only remove files that were created by this
> instance.
>
> Signed-off-by: Amador Pahim <apahim@redhat.com>
> ---
>  scripts/qemu.py | 84 ++++++++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 59 insertions(+), 25 deletions(-)
>
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index d313c6d4db..e9a3a96d13 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -25,6 +25,10 @@ logging.basicConfig()
>  LOG = logging.getLogger(__name__)
>  
>  
> +class QEMULaunchError(Exception):
> +    pass
> +
> +
>  class QEMUMachine(object):
>      '''A QEMU VM'''
>  
> @@ -40,6 +44,7 @@ class QEMUMachine(object):
>              monitor_address = os.path.join(test_dir, name + "-monitor.sock")
>          self._monitor_address = monitor_address
>          self._qemu_log_path = os.path.join(test_dir, name + ".log")
> +        self._qemu_log_fd = None
>          self._popen = None
>          self._binary = binary
>          self._args = list(args) # Force copy args in case we modify them
> @@ -49,6 +54,8 @@ class QEMUMachine(object):
>          self._socket_scm_helper = socket_scm_helper
>          self._debug = debug
>          self._qemu_full_args = None
> +        self._created_files = []
> +        self._pending_shutdown = False
>  
>      # This can be used to add an unused monitor instance.
>      def add_monitor_telnet(self, ip, port):
> @@ -109,8 +116,9 @@ class QEMUMachine(object):
>          return self._popen.pid
>  
>      def _load_io_log(self):
> -        with open(self._qemu_log_path, "r") as fh:
> -            self._iolog = fh.read()
> +        if os.path.exists(self._qemu_log_path):
> +            with open(self._qemu_log_path, "r") as fh:
> +                self._iolog = fh.read()

The new conditional predicts whether open() will fail with ENOENT.
Trying to predict failure is generally a bad idea.  What if some other
process removes ._qemu_log_path between .exists() and open()?  You're
better off catching the exception from open().

>  
>      def _base_args(self):
>          if isinstance(self._monitor_address, tuple):
> @@ -124,40 +132,62 @@ class QEMUMachine(object):
>                  '-display', 'none', '-vga', 'none']
>  
>      def _pre_launch(self):
> -        self._qmp = qmp.qmp.QEMUMonitorProtocol(self._monitor_address, server=True,
> +        if (not isinstance(self._monitor_address, tuple) and
> +                os.path.exists(self._monitor_address)):
> +            raise QEMULaunchError('File %s exists. Please remove it.' %
> +                                  self._monitor_address)

What if some other process creates ._monitor_address between .exists()
and the bind() in QEMUMonitorProtocol.__init__()?

See, .exists() is almost always wrong.

> +
> +        self._qmp = qmp.qmp.QEMUMonitorProtocol(self._monitor_address,
> +                                                server=True,
>                                                  debug=self._debug)
> +        if not isinstance(self._monitor_address, tuple):
> +            self._created_files.append(self._monitor_address)
> +
> +        if os.path.exists(self._qemu_log_path):
> +            raise QEMULaunchError('File %s exists. Please remove it.' %
> +                                  self._qemu_log_path)

Likewise.

> +
> +        self._qemu_log_fd = open(self._qemu_log_path, 'wb')
> +        self._created_files.append(self._qemu_log_path)
>  
>      def _post_launch(self):
>          self._qmp.accept()
>  
>      def _post_shutdown(self):
> -        if not isinstance(self._monitor_address, tuple):
> -            self._remove_if_exists(self._monitor_address)
> -        self._remove_if_exists(self._qemu_log_path)
> +        while self._created_files:
> +            self._remove_if_exists(self._created_files.pop())
>  
>      def launch(self):
>          '''Launch the VM and establish a QMP connection'''
> -        devnull = open(os.path.devnull, 'rb')
> -        qemulog = open(self._qemu_log_path, 'wb')
> +
> +        if self.is_running():
> +            raise QEMULaunchError('VM already running.')

Drop the period, please.

> +
> +        if self._pending_shutdown:
> +            raise QEMULaunchError('Shutdown after the previous launch '
> +                                  'is pending. Please call shutdown() '
> +                                  'before launching again.')

Single phrase describing the error, please.

> +
>          try:
> -            self._pre_launch()
>              self._qemu_full_args = None
>              self._qemu_full_args = (self._wrapper + [self._binary] +
>                                      self._base_args() + self._args)
> -            self._popen = subprocess.Popen(self._qemu_full_args,
> -                                           stdin=devnull,
> -                                           stdout=qemulog,
> -                                           stderr=subprocess.STDOUT,
> -                                           shell=False)
> -            self._post_launch()
> +            self._launch()
> +            self._pending_shutdown = True
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
> +        self._pre_launch()
> +        devnull = open(os.path.devnull, 'rb')
> +        self._popen = subprocess.Popen(self._qemu_full_args,
> +                                       stdin=devnull,
> +                                       stdout=self._qemu_log_fd,
> +                                       stderr=subprocess.STDOUT,
> +                                       shell=False)
> +        self._post_launch()
> +
>      def shutdown(self):
>          '''Terminate the VM and clean up'''
>          if self.is_running():
> @@ -166,14 +196,18 @@ class QEMUMachine(object):
>                  self._qmp.close()
>              except:
>                  self._popen.kill()
> +            self._popen.wait()
>  
> -            exitcode = self._popen.wait()
> -            if exitcode < 0:
> -                LOG.error('qemu received signal %i:%s', -exitcode,
> +        if self._pending_shutdown:
> +            exit_code = self.exitcode()
> +            if exit_code is not None and exit_code < 0:
> +                LOG.error('qemu received signal %i: %s', -exit_code,
>                            ' Command: %r.' % ' '.join(self._qemu_full_args)
>                            if self._qemu_full_args else '')
> -            self._load_io_log()
> -            self._post_shutdown()
> +
> +        self._load_io_log()
> +        self._post_shutdown()
> +        self._pending_shutdown = False
>  
>      underscore_to_dash = string.maketrans('_', '-')
>      def qmp(self, cmd, conv_keys=True, **args):
