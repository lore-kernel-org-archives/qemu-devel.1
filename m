Received: from eggs.gnu.org ([2001:4830:134:3::10]:33066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dp4S9-0002By-CY
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 23:23:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dp4S4-0003wJ-K5
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 23:23:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56504)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dp4S4-0003vo-E7
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 23:23:00 -0400
Date: Tue, 5 Sep 2017 11:22:55 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170905032255.GQ22515@lemon.lan>
References: <20170901112829.2571-1-apahim@redhat.com>
	<20170901112829.2571-14-apahim@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170901112829.2571-14-apahim@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 13/13] qemu.py: don't launch again
 before shutdown()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amador Pahim <apahim@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, ldoktor@redhat.com, ehabkost@redhat.com, stefanha@gmail.com, armbru@redhat.com, mreitz@redhat.com, crosa@redhat.com

On Fri, 09/01 13:28, Amador Pahim wrote:
> If a VM is launched, files are created and a cleanup is required before
> a new launch. This cleanup is executed by shutdown(), so shutdown() must
> be called even if the VM is manually terminated (i.e. using kill).
> 
> This patch creates a control to make sure launch() will not be executed
> again if shutdown() is not called after the previous launch().
> 
> Signed-off-by: Amador Pahim <apahim@redhat.com>
> ---
>  scripts/qemu.py | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index 363f649a7e..05fca4d268 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -52,6 +52,7 @@ class QEMUMachine(object):
>          self._debug = debug
>          self._qemu_full_args = None
>          self._created_files = []
> +        self._pending_shutdown = False

The name is very poor, it can be confused as "user requested a shutdown but the
action is pending for some reason". Maybe "self._launched"?

Fam

>  
>      # This can be used to add an unused monitor instance.
>      def add_monitor_telnet(self, ip, port):
> @@ -168,10 +169,14 @@ class QEMUMachine(object):
>          if self.is_running():
>              raise QEMUMachineError('VM already running')
>  
> +        if self._pending_shutdown:
> +            raise QEMUMachineError('Shutdown pending after previous launch')
> +
>          self._iolog = None
>          self._qemu_full_args = None
>          try:
>              self._launch()
> +            self._pending_shutdown = True
>          except:
>              self.shutdown()
>  
> @@ -217,6 +222,8 @@ class QEMUMachine(object):
>                  command = ''
>              LOG.warn(msg, exitcode, command)
>  
> +        self._pending_shutdown = False
> +
>      underscore_to_dash = string.maketrans('_', '-')
>      def qmp(self, cmd, conv_keys=True, **args):
>          '''Invoke a QMP command and return the result dict'''
> -- 
> 2.13.5
> 
> 
