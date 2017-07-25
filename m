Received: from eggs.gnu.org ([2001:4830:134:3::10]:46521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1da7D0-0003QH-OD
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 17:17:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1da7Cz-0005Ia-R2
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 17:17:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1da7Cz-0005IC-IA
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 17:17:37 -0400
Date: Tue, 25 Jul 2017 18:17:29 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170725211729.GX2757@localhost.localdomain>
References: <20170725171014.25193-1-apahim@redhat.com>
	<20170725171014.25193-7-apahim@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170725171014.25193-7-apahim@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 6/6] qemu.py: include qemu command line
 and output on launch error
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

On Tue, Jul 25, 2017 at 07:10:14PM +0200, Amador Pahim wrote:
> When launching a VM, if an exception happens and the VM is not
> initiated, it is useful to see the qemu command line that was executed
> and the output of that command.
> 
> Signed-off-by: Amador Pahim <apahim@redhat.com>
> ---
>  scripts/qemu.py | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index e18e8ec657..abfa3eebe9 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -131,7 +131,8 @@ class QEMUMachine(object):
>  
>      def launch(self):
>          '''
> -        Try to launch the VM and make sure we cleanup on exception.
> +        Try to launch the VM and make sure we cleanup and expose the
> +        command line/output in case of exception.
>          '''
>          if self.is_running():
>              return
> @@ -142,18 +143,24 @@ class QEMUMachine(object):
>              self.shutdown()
>  
>          try:
> -            self._launch()
> +            args = None
> +            args = self._wrapper + [self._binary] + self._base_args() + self._args
> +            self._launch(args)

I think it would be easier to set a self._full_qemu_args
attribute instead of passing data around through local variables
and method arguments.

>              self._shutdown_pending = True
>          except:
>              self.shutdown()
> +            sys.stderr.write('Error launching VM.\n%s%s' %
> +                             ('Command:\n%s\n' %
> +                              ' '.join(args) if args else '',
> +                              'Output:\n%s\n' %
> +                              ''.join(self._iolog) if self._iolog else ''))

I suggest making this conditional on self._debug.

We could also introduce a QEMULaunchError exception class
containing this info, but I'm unsure if we should raise it on
every exception, or raise more specific custom exceptions on
specific cases (e.g. one exception for QMP timeout, another for
QEMU binary not found, another for QEMU killed by a signal, etc).


>              raise
>  
> -    def _launch(self):
> +    def _launch(self, args):
>          '''Launch the VM and establish a QMP connection.'''
>          devnull = open('/dev/null', 'rb')
>          qemulog = open(self._qemu_log_path, 'wb')
>          self._pre_launch()
> -        args = self._wrapper + [self._binary] + self._base_args() + self._args
>          self._popen = subprocess.Popen(args, stdin=devnull, stdout=qemulog,
>                                         stderr=subprocess.STDOUT, shell=False)
>          self._post_launch()
> -- 
> 2.13.3
> 

-- 
Eduardo
