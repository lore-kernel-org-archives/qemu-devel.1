Received: from eggs.gnu.org ([2001:4830:134:3::10]:53886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ccarrara@redhat.com>) id 1gRGT9-0002b2-SL
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 07:58:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ccarrara@redhat.com>) id 1gRGT6-0003xA-Ju
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 07:58:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ccarrara@redhat.com>) id 1gRGT4-0003uE-IP
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 07:58:28 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7A6C9305FCB2
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 12:58:23 +0000 (UTC)
Date: Mon, 26 Nov 2018 10:58:08 -0200
From: Caio Carrara <ccarrara@redhat.com>
Message-ID: <20181126125807.GA14485@localhost.localdomain>
References: <20181121183900.10364-1-wainersm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121183900.10364-1-wainersm@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] scripts/qemu.py: allow to launch the VM
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
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, crosa@redhat.com, philmd@redhat.com

On Wed, Nov 21, 2018 at 01:39:00PM -0500, Wainer dos Santos Moschetta wrote:
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
> So this patch adds the set_qmp_monitor() that allow to
> launch the VM without creating the monitor machinery. The
> method can be used to re-enable the monitor eventually.
> 
> Tested this change with the following Avocado test:
> 
> from avocado_qemu import Test
> 
> class DisableQmp(Test):

I think it would be fine to have this test added as a real test instead
of just let this here on commit message. Or at least we should have a
real use case that uses this new feature.

>     """
>     :avocado: enable
>     """
>     def test(self):
>         self.vm.add_args('--foobar')
>         self.vm.set_qmp_monitor(disabled=True)
>         self.vm.launch()
>         self.vm.wait()
>         self.assertEqual(self.vm.exitcode(), 1)
>         self.vm.shutdown()
> 
>         self.vm.set_qmp_monitor(disabled=False)
>         self.vm._args.remove('--foobar') # Hack
>         self.vm.launch()
>         res = self.vm.command('human-monitor-command',
>                               command_line='info version')
>         self.assertRegexpMatches(res, r'^(\d+\.\d+\.\d)')
> 
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> Reviewed-by: Caio Carrara <ccarrara@redhat.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Changes in v2:
>   * Major refactor: replaced disable_qmp() with set_qmp_monitor()
>     that allow to disable the qmp monitor likewise, but also one can
>     re-enable it (set_qmp_monitor(disabled=False)).
>   * The logic to enabled/disable the monitor is back to
>     _base_args(). [ccarrara, ehabkost]
> ---
>  scripts/qemu.py | 72 ++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 48 insertions(+), 24 deletions(-)
> 
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index 6e3b0e6771..54fe0e65d2 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -115,6 +115,7 @@ class QEMUMachine(object):
>          self._events = []
>          self._iolog = None
>          self._socket_scm_helper = socket_scm_helper
> +        self._with_qmp = True   # Enable QMP monitor by default.
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
> @@ -247,23 +240,33 @@ class QEMUMachine(object):
>                         self._console_address)
>              device = '%s,chardev=console' % self._console_device_type
>              args.extend(['-chardev', chardev, '-device', device])
> +        if self._with_qmp:
> +            if isinstance(self._monitor_address, tuple):
> +                moncdev = "socket,id=mon,host=%s,port=%s" % (
> +                    self._monitor_address[0],
> +                    self._monitor_address[1])
> +            else:
> +                moncdev = 'socket,id=mon,path=%s' % self._vm_monitor
> +            args.extend(['-chardev', moncdev, '-mon', 'chardev=mon,mode=control'])
> +
>          return args
>  
>      def _pre_launch(self):
>          self._temp_dir = tempfile.mkdtemp(dir=self._test_dir)
> -        if self._monitor_address is not None:
> -            self._vm_monitor = self._monitor_address
> -        else:
> -            self._vm_monitor = os.path.join(self._temp_dir,
> -                                            self._name + "-monitor.sock")
>          self._qemu_log_path = os.path.join(self._temp_dir, self._name + ".log")
>          self._qemu_log_file = open(self._qemu_log_path, 'wb')
>  
> -        self._qmp = qmp.qmp.QEMUMonitorProtocol(self._vm_monitor,
> -                                                server=True)
> -
> +        if self._with_qmp:
> +            if self._monitor_address is not None:
> +                self._vm_monitor = self._monitor_address
> +            else:
> +                self._vm_monitor = os.path.join(self._temp_dir,
> +                                            self._name + "-monitor.sock")
> +            self._qmp = qmp.qmp.QEMUMonitorProtocol(self._vm_monitor,
> +                                                    server=True)
>      def _post_launch(self):
> -        self._qmp.accept()
> +        if self._qmp:
> +            self._qmp.accept()
>  
>      def _post_shutdown(self):
>          if self._qemu_log_file is not None:
> @@ -325,7 +328,8 @@ class QEMUMachine(object):
>          Wait for the VM to power off
>          """
>          self._popen.wait()
> -        self._qmp.close()
> +        if self._qmp:

Isn't the self._with_qmp attribute that should be used here? I think
it's important to standardize the checks for qmp availability in
`with_qmp` attribute and use the `qmp` only for qmp access itself. There
are other places that uses qmp to this kind of check too.

> +            self._qmp.close()
>          self._load_io_log()
>          self._post_shutdown()
>  
> @@ -334,11 +338,14 @@ class QEMUMachine(object):
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
> @@ -355,6 +362,23 @@ class QEMUMachine(object):
>  
>          self._launched = False
>  
> +    def set_qmp_monitor(self, disabled=False, monitor_address=None):

Where is this new method being used?

> +        """
> +        Set the QMP monitor.
> +
> +        @param disabled: if True, qmp monitor options will be removed from the
> +                         base arguments of the resulting QEMU command line.
> +        @param monitor_address: address for the QMP monitor.
> +        @note: call this function before launch().
> +        """
> +        if disabled:
> +            self._with_qmp = False
> +            self._qmp = None
> +        else:
> +            self._with_qmp = True
> +            if monitor_address:
> +                self._monitor_address = monitor_address
> +
>      def qmp(self, cmd, conv_keys=True, **args):
>          """
>          Invoke a QMP command and return the response dict
> -- 
> 2.19.1
> 

It would be nice see less scattered checks for qmp availability along
the code. 

Thanks.
-- 
Caio Carrara
Software Engineer, Virt Team - Red Hat
ccarrara@redhat.com
