Received: from eggs.gnu.org ([2001:4830:134:3::10]:38423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnAGJ-0008Ny-NP
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 17:11:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnAGI-0000sM-KT
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 17:10:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dnAGI-0000rl-BM
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 17:10:58 -0400
Date: Wed, 30 Aug 2017 18:10:52 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170830211052.GD7570@localhost.localdomain>
References: <20170818170526.13496-1-apahim@redhat.com>
	<20170818170526.13496-5-apahim@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170818170526.13496-5-apahim@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 04/11] qemu.py: use poll() instead of
 'returncode'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amador Pahim <apahim@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, ldoktor@redhat.com, famz@redhat.com, stefanha@gmail.com, armbru@redhat.com, mreitz@redhat.com, crosa@redhat.com

On Fri, Aug 18, 2017 at 07:05:19PM +0200, Amador Pahim wrote:
> The 'returncode' Popen attribute is not guaranteed to be updated. It
> actually depends on a call to either poll(), wait() or communicate().
> 
> On the other hand, poll() will: "Check if child process has terminated.
> Set and return returncode attribute."
> 
> Let's use the poll() to check whether the process is running and also
> to get the updated process exit code, when the process is finished.
> 
> As consequence, the shutdown() calls to self._load_io_log()
> self._post_shutdown() are now always executed to make sure we cleanup
> even if VM is not running when the shutdown() is called.

I suggest moving the shutdown() changes to a separate patch.

> 
> Signed-off-by: Amador Pahim <apahim@redhat.com>
> ---
>  scripts/qemu.py | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index 51545f7f97..774f971f69 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -98,12 +98,12 @@ class QEMUMachine(object):
>              raise
>  
>      def is_running(self):
> -        return self._popen is not None and self._popen.returncode is None
> +        return self._popen is not None and self._popen.poll() is None
>  
>      def exitcode(self):
>          if self._popen is None:
>              return None
> -        return self._popen.returncode
> +        return self._popen.poll()
>  
>      def get_pid(self):
>          if not self.is_running():
> @@ -111,8 +111,15 @@ class QEMUMachine(object):
>          return self._popen.pid
>  
>      def _load_io_log(self):
> -        with open(self._qemu_log_path, "r") as fh:
> -            self._iolog = fh.read()
> +        '''
> +        Load the Qemu log file content (if available) into the proper
> +        instance variable
> +        '''
> +        try:
> +            with open(self._qemu_log_path, "r") as fh:
> +                self._iolog = fh.read()
> +        except IOError:
> +            pass

Is this really supposed to be included in this patch?  This
change in the _load_io_log() behavior is the most dangerous part
of this patch, and not described in the commit message at all.

I don't think it's a good idea to remove errors unconditionally
here.  The launch() code controls of the creation of the log file
completely, we don't even need to try to load the file if we know
it was not created yet.


>  
>      def _base_args(self):
>          if isinstance(self._monitor_address, tuple):
> @@ -168,8 +175,8 @@ class QEMUMachine(object):
>              if exitcode < 0:
>                  LOG.debug('qemu received signal %i: %s', -exitcode,
>                            ' '.join(self._args))
> -            self._load_io_log()
> -            self._post_shutdown()
> +        self._load_io_log()
> +        self._post_shutdown()
>  
>      underscore_to_dash = string.maketrans('_', '-')
>      def qmp(self, cmd, conv_keys=True, **args):
> -- 
> 2.13.5
> 
> 

-- 
Eduardo
