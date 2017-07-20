Received: from eggs.gnu.org ([2001:4830:134:3::10]:60557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dYA6P-0006rW-TA
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 07:58:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dYA6L-0006Ly-Vv
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 07:58:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dYA6L-0006Ln-N9
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 07:58:41 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B917313A60
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 11:58:39 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170720091902.22476-1-apahim@redhat.com>
	<20170720091902.22476-3-apahim@redhat.com>
Date: Thu, 20 Jul 2017 13:58:33 +0200
In-Reply-To: <20170720091902.22476-3-apahim@redhat.com> (Amador Pahim's
	message of "Thu, 20 Jul 2017 11:19:01 +0200")
Message-ID: <87d18v1frq.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 2/3] qemu.py: include debug information
 on launch error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amador Pahim <apahim@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, ldoktor@redhat.com, ehabkost@redhat.com, mreitz@redhat.com, crosa@redhat.com, famz@redhat.com

Amador Pahim <apahim@redhat.com> writes:

> When launching a VM, if an exception happens and the VM is not
> initiated, it is useful to see the qemu command line that was executed
> and the output of that command.
>
> Before the patch:
>
>     >>> VM = qemu.QEMUMachine('../aarch64-softmmu/qemu-system-aarch64')
>     >>> VM.launch()
>     Traceback (most recent call last):
>       File "<stdin>", line 1, in <module>
>       File "qemu.py", line 137, in launch
>         self._post_launch()
>       File "qemu.py", line 121, in _post_launch
>         self._qmp.accept()
>       File "qmp/qmp.py", line 145, in accept
>         self.__sock, _ = self.__sock.accept()
>       File "/usr/lib64/python2.7/socket.py", line 206, in accept
>         sock, addr = self._sock.accept()
>     socket.timeout: timed out
>
> After the patch:
>
>     >>> VM = qemu.QEMUMachine('../aarch64-softmmu/qemu-system-aarch64')
>     >>> VM.launch()
>     Traceback (most recent call last):
>       File "<stdin>", line 1, in <module>
>       File "qemu.py", line 156, in launch
>         raise RuntimeError(msg)
>     RuntimeError: Error launching VM.
>     Original Exception:
>     Traceback (most recent call last):
>       File "qemu.py", line 138, in launch
>         self._post_launch()
>       File "qemu.py", line 122, in _post_launch
>         self._qmp.accept()
>       File "qmp/qmp.py", line 145, in accept
>         self.__sock, _ = self.__sock.accept()
>       File "/usr/lib64/python2.7/socket.py", line 206, in accept
>         sock, addr = self._sock.accept()
>     timeout: timed out
>     Command:
>     /usr/bin/qemu-system-aarch64 -chardev socket,id=mon,
>     path=/var/tmp/qemu-23958-monitor.sock -mon chardev=mon,mode=control
>     -display none -vga none
>     Output:
>     qemu-system-aarch64: No machine specified, and there is no default
>     Use -machine help to list supported machines
>
> Also, if the launch() faces an exception, the 'except' now will use args
> to fill the debug information. So this patch assigns 'args' earlier,
> assuring it will be available for the 'except'.
>
> Signed-off-by: Amador Pahim <apahim@redhat.com>
> Reviewed-by: Fam Zheng <famz@redhat.com>
> ---
>  scripts/qemu.py | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index f0fade32bd..2707ae7f75 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -18,6 +18,7 @@ import os
>  import sys
>  import subprocess
>  import qmp.qmp
> +import traceback
>  
>  
>  class QEMUMachine(object):
> @@ -129,17 +130,30 @@ class QEMUMachine(object):
>          '''Launch the VM and establish a QMP connection'''
>          devnull = open('/dev/null', 'rb')
>          qemulog = open(self._qemu_log_path, 'wb')
> +        args = self._wrapper + [self._binary] + self._base_args() + self.args
>          try:
>              self._pre_launch()
> -            args = self._wrapper + [self._binary] + self._base_args() + self._args
>              self._popen = subprocess.Popen(args, stdin=devnull, stdout=qemulog,
>                                             stderr=subprocess.STDOUT, shell=False)
>              self._post_launch()

Lifting the assignment out of the try makes sense, because exceptions
there are programming errors.

Why are ._pre_launch() and ._post_launch() inside the try?

>          except:

Why do we catch all exceptions, and not just
subprocess.CalledProcessError?

> +            self._load_io_log()
>              if self.is_running():

I suspect we can't get here only for "odd" exceptions, not for
subprocess.CalledProcessError.

>                  self._popen.kill()
>                  self._popen.wait()
> -            self._load_io_log()
> +            else:
> +                exc_type, exc_value, exc_traceback = sys.exc_info()
> +                msg = ('Error launching VM.\n'
> +                       'Original Exception: \n%s'
> +                       'Command:\n%s\n'
> +                       'Output:\n%s\n' %
> +                       (''.join(traceback.format_exception(exc_type,
> +                                                           exc_value,
> +                                                           exc_traceback)),
> +                        ' '.join(args),
> +                        self._iolog))
> +                self._post_shutdown()
> +                raise RuntimeError(msg)
>              self._post_shutdown()
>              raise

Why do we print a traceback when subprocess.CalledProcessError?
