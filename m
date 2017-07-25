Received: from eggs.gnu.org ([2001:4830:134:3::10]:56065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1da5yi-0004j7-A6
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 15:58:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1da5yf-0008Fs-68
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 15:58:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1da5ye-0008FU-WB
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 15:58:45 -0400
Date: Tue, 25 Jul 2017 16:58:35 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170725195835.GU2757@localhost.localdomain>
References: <20170725171014.25193-1-apahim@redhat.com>
	<20170725171014.25193-6-apahim@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170725171014.25193-6-apahim@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 5/6] qemu.py: make sure shutdown() is
 called before launching again
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

On Tue, Jul 25, 2017 at 07:10:13PM +0200, Amador Pahim wrote:
> If launch() is called twice or if the VM is terminated not using
> shutdown(), the new call to launch() will fail due to the dirty
> environment, with files from the previous instance laying around.
> 
> This patch add to launch() the ability to check whether shutdown() was
> called after a previous launch(), calling it when applies.
> 
> Signed-off-by: Amador Pahim <apahim@redhat.com>
> ---
>  scripts/qemu.py | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index 45a63e8e9d..e18e8ec657 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -39,6 +39,7 @@ class QEMUMachine(object):
>          self._iolog = None
>          self._socket_scm_helper = socket_scm_helper
>          self._debug = debug
> +        self._shutdown_pending = False
>  
>      # This can be used to add an unused monitor instance.
>      def add_monitor_telnet(self, ip, port):
> @@ -135,8 +136,14 @@ class QEMUMachine(object):
>          if self.is_running():
>              return
>  
> +        if self._shutdown_pending:
> +            sys.stderr.write('shutdown() was not called after previous '
> +                             'launch(). Calling now.\n')
> +            self.shutdown()
> +

This looks like obviously invalid API usage.  Why not raise an
Exception?

>          try:
>              self._launch()
> +            self._shutdown_pending = True
>          except:
>              self.shutdown()
>              raise
> @@ -166,6 +173,7 @@ class QEMUMachine(object):
>  
>          self._load_io_log()
>          self._post_shutdown()
> +        self._shutdown_pending = False
>  
>      underscore_to_dash = string.maketrans('_', '-')
>      def qmp(self, cmd, conv_keys=True, **args):
> -- 
> 2.13.3
> 

-- 
Eduardo
