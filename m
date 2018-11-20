Received: from eggs.gnu.org ([2001:4830:134:3::10]:43486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gPBId-0004ID-5p
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 14:03:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gPBIZ-00085b-1M
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 14:03:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:28175)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gPBIW-00082t-SZ
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 14:02:58 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BDFAD308213D
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 19:02:49 +0000 (UTC)
Date: Tue, 20 Nov 2018 17:02:38 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181120190238.GR4755@habkost.net>
References: <20181120165300.18993-1-wainersm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120165300.18993-1-wainersm@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] scripts/qemu.py: allow to launch the VM
 without a monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
Cc: qemu-devel@nongnu.org, crosa@redhat.com, ccarrara@redhat.com, philmd@redhat.com

On Tue, Nov 20, 2018 at 11:53:00AM -0500, Wainer dos Santos Moschetta wrote:
> QEMUMachine launches the VM with a monitor enabled, afterwards
> a qmp connection is attempted on _post_launch(). In case
> the QEMU process exits with an error, qmp.accept() reaches
> timeout and raises an exception.
> 
> But sometimes you don't need that monitor. As an example,
> when a test launches the VM expects its immediate crash,
> and only intend to check the process's return code. In this
> case the fact that launch() tries to establish the qmp
> connection (ending up in an exception) is troublesome.
> 
> So this patch adds the disable_qmp() that allow to
> launch the VM without creating the monitor machinery.
> 
> Tested this change with the following Avocado test:
> 
> from avocado_qemu import Test
> class DisableQmp(Test):
>     """
>     :avocado: enable
>     """
>     def test(self):
>         self.vm.add_args('--foobar')
>         self.vm.disable_qmp()
>         self.vm.launch()
>         self.vm.wait()
>         self.assertEqual(self.vm.exitcode(), 1)
> 
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
[...]
> ---
>  scripts/qemu.py | 58 ++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 38 insertions(+), 20 deletions(-)
> 
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index 6e3b0e6771..bbe80ac601 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -115,6 +115,7 @@ class QEMUMachine(object):
>          self._events = []
>          self._iolog = None
>          self._socket_scm_helper = socket_scm_helper
> +        self._with_qmp = True   # Enable QMP by default.
>          self._qmp = None
>          self._qemu_full_args = None
>          self._test_dir = test_dir
> @@ -229,15 +230,7 @@ class QEMUMachine(object):
>                  self._iolog = iolog.read()
>  
>      def _base_args(self):
> -        if isinstance(self._monitor_address, tuple):
> -            moncdev = "socket,id=mon,host=%s,port=%s" % (
> -                self._monitor_address[0],
> -                self._monitor_address[1])
> -        else:
> -            moncdev = 'socket,id=mon,path=%s' % self._vm_monitor
> -        args = ['-chardev', moncdev,
> -                '-mon', 'chardev=mon,mode=control',
> -                '-display', 'none', '-vga', 'none']
> +        args = ['-display', 'none', '-vga', 'none']
>          if self._machine is not None:
>              args.extend(['-machine', self._machine])
>          if self._console_device_type is not None:
> @@ -249,21 +242,35 @@ class QEMUMachine(object):
>              args.extend(['-chardev', chardev, '-device', device])
>          return args
>  
> -    def _pre_launch(self):
> -        self._temp_dir = tempfile.mkdtemp(dir=self._test_dir)
> +    def _setup_qmp(self):
> +
>          if self._monitor_address is not None:
>              self._vm_monitor = self._monitor_address
>          else:
>              self._vm_monitor = os.path.join(self._temp_dir,
>                                              self._name + "-monitor.sock")
> -        self._qemu_log_path = os.path.join(self._temp_dir, self._name + ".log")
> -        self._qemu_log_file = open(self._qemu_log_path, 'wb')
>  
> +        if isinstance(self._monitor_address, tuple):
> +            moncdev = "socket,id=mon,host=%s,port=%s" % (
> +                self._monitor_address[0],
> +                self._monitor_address[1])
> +        else:
> +            moncdev = 'socket,id=mon,path=%s' % self._vm_monitor
> +
> +        self._args.extend(['-chardev', moncdev, '-mon', 'chardev=mon,mode=control'])

This will extend self._args multiple times if making a
.shutdown()/.launch() cycle:

  $ cat scripts/test.py
  import qemu
  import logging, sys
  logging.basicConfig(stream=sys.stderr, level=logging.DEBUG)
  vm = qemu.QEMUMachine('./x86_64-softmmu/qemu-system-x86_64')
  vm.launch()
  vm.shutdown()
  vm.launch()
  vm.shutdown()
  $ python3 scripts/test.py
  DEBUG:QMP:>>> {'execute': 'qmp_capabilities'}
  DEBUG:QMP:<<< {'return': {}}
  DEBUG:QMP:>>> {'execute': 'quit'}
  DEBUG:QMP:<<< {'return': {}}
  ^CDEBUG:qemu:Error launching VM
  DEBUG:qemu:Command: './x86_64-softmmu/qemu-system-x86_64 -display none -vga none -chardev socket,id=mon,path=/var/tmp/tmpzny4hpy5/qemu-13737-monitor.sock -mon chardev=mon,mode=control -chardev socket,id=mon,path=/var/tmp/tmpkrlv1d9w/qemu-13737-monitor.sock -mon chardev=mon,mode=control'
  DEBUG:qemu:Output: "qemu-system-x86_64: -chardev socket,id=mon,path=/var/tmp/tmpkrlv1d9w/qemu-13737-monitor.sock: Duplicate ID 'mon' for chardev\n"
  Traceback (most recent call last):
    File "scripts/test.py", line 7, in <module>
      vm.launch()
    File "/home/ehabkost/rh/proj/virt/qemu/scripts/qemu.py", line 302, in launch
      self._launch()
    File "/home/ehabkost/rh/proj/virt/qemu/scripts/qemu.py", line 328, in _launch
      self._post_launch()
    File "/home/ehabkost/rh/proj/virt/qemu/scripts/qemu.py", line 273, in _post_launch
      self._qmp.accept()
    File "/home/ehabkost/rh/proj/virt/qemu/scripts/qmp/qmp.py", line 155, in accept
      self.__sock, _ = self.__sock.accept()
    File "/usr/lib64/python3.6/socket.py", line 205, in accept
      fd, addr = self._accept()
  KeyboardInterrupt

Why did you move this code outside _base_args(), where it already
worked without relying on method side-effects and required no
extra state to be kept inside self._args?



>          self._qmp = qmp.qmp.QEMUMonitorProtocol(self._vm_monitor,
>                                                  server=True)
>  
> +    def _pre_launch(self):
> +        self._temp_dir = tempfile.mkdtemp(dir=self._test_dir)
> +        if self._with_qmp:
> +            self._setup_qmp()
> +        self._qemu_log_path = os.path.join(self._temp_dir, self._name + ".log")
> +        self._qemu_log_file = open(self._qemu_log_path, 'wb')
> +
>      def _post_launch(self):
> -        self._qmp.accept()
> +        if self._qmp:
> +            self._qmp.accept()
>  
>      def _post_shutdown(self):
>          if self._qemu_log_file is not None:
> @@ -325,7 +332,8 @@ class QEMUMachine(object):
>          Wait for the VM to power off
>          """
>          self._popen.wait()
> -        self._qmp.close()
> +        if self._qmp:
> +            self._qmp.close()
>          self._load_io_log()
>          self._post_shutdown()
>  
> @@ -334,11 +342,14 @@ class QEMUMachine(object):
>          Terminate the VM and clean up
>          """
>          if self.is_running():
> -            try:
> -                self._qmp.cmd('quit')
> -                self._qmp.close()
> -            except:
> -                self._popen.kill()
> +            if self._qmp:
> +                try:
> +                    self._qmp.cmd('quit')
> +                    self._qmp.close()
> +                except:
> +                    self._popen.kill()
> +            else:
> +                self._popen.terminate()
>              self._popen.wait()
>  
>          self._load_io_log()
> @@ -355,6 +366,13 @@ class QEMUMachine(object):
>  
>          self._launched = False
>  
> +    def disable_qmp(self):
> +        """
> +        Disable the QMP monitor.
> +        @note: call this function before launch().
> +        """
> +        self._with_qmp = False
> +
>      def qmp(self, cmd, conv_keys=True, **args):
>          """
>          Invoke a QMP command and return the response dict
> -- 
> 2.19.1
> 

-- 
Eduardo
