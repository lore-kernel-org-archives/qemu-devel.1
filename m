Received: from eggs.gnu.org ([2001:4830:134:3::10]:38385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecaXf-0004fF-AW
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 12:33:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecaXc-0004DO-3z
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 12:33:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ecaXb-0004D5-U6
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 12:33:24 -0500
Date: Fri, 19 Jan 2018 15:33:15 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180119173315.GE15832@localhost.localdomain>
References: <20171114102246.22221-1-apahim@redhat.com>
	<20171114102246.22221-5-apahim@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171114102246.22221-5-apahim@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v11 4/8] qemu.py: always cleanup on
 shutdown()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amador Pahim <apahim@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, armbru@redhat.com, crosa@redhat.com, muriloo@linux.vnet.ibm.com

On Tue, Nov 14, 2017 at 11:22:42AM +0100, Amador Pahim wrote:
> Currently we only cleanup on shutdown() if the VM is running.
> 
> To make sure we will always cleanup, this patch makes the
> self._load_io_log() and the self._post_shutdown() to
> always be called on shutdown(), regardless the VM running state.
> 
> Reviewed-by: Fam Zheng <famz@redhat.com>
> Signed-off-by: Amador Pahim <apahim@redhat.com>
> ---
>  scripts/qemu.py | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index 28aa3712c7..7bd10b1a1d 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -162,8 +162,9 @@ class QEMUMachine(object):
>          return self._popen.pid
>  
>      def _load_io_log(self):
> -        with open(self._qemu_log_path, "r") as iolog:
> -            self._iolog = iolog.read()
> +        if self._qemu_log_path is not None:
> +            with open(self._qemu_log_path, "r") as iolog:
> +                self._iolog = iolog.read()
>  
>      def _base_args(self):
>          if isinstance(self._monitor_address, tuple):
> @@ -254,8 +255,8 @@ class QEMUMachine(object):
>                  self._popen.kill()
>              self._popen.wait()
>  
> -            self._load_io_log()
> -            self._post_shutdown()
> +        self._load_io_log()

_load_io_log() is now safe to call at any time thanks to the hunk
above.

> +        self._post_shutdown()

_post_shutdown() is safe to call at any time thanks to patch 2/8.

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

>  
>          exitcode = self.exitcode()
>          if exitcode is not None and exitcode < 0:
> -- 
> 2.13.6
> 
> 

-- 
Eduardo
