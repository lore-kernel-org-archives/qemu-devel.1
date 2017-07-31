Received: from eggs.gnu.org ([2001:4830:134:3::10]:38697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dcC1a-0003BE-K8
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 10:50:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dcC1X-0003BO-FV
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 10:50:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dcC1X-0003AP-6a
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 10:50:23 -0400
Date: Mon, 31 Jul 2017 11:50:14 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170731145014.GA20793@localhost.localdomain>
References: <20170731085110.1050-1-apahim@redhat.com>
	<20170731085110.1050-4-apahim@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170731085110.1050-4-apahim@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 3/7] qemu.py: use python logging system
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

On Mon, Jul 31, 2017 at 10:51:06AM +0200, Amador Pahim wrote:
> Let's provide extra control and flexibility by using python logging
> system instead of print and/or sys.std*.write().
> 
> Signed-off-by: Amador Pahim <apahim@redhat.com>
> ---
>  scripts/qemu.py | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index 77565eb092..e3ea534ec4 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -13,6 +13,7 @@
>  #
>  
>  import errno
> +import logging
>  import string
>  import os
>  import sys
> @@ -20,11 +21,19 @@ import subprocess
>  import qmp.qmp
>  
>  
> +logging.basicConfig()

Please don't call logging.basicConfig() from a module, as this
will break scripts that already use logging.basicConfig().

This breaks the following:

  $ ./scripts/device-crash-test --debug /usr/bin/qemu-system-x86_64


> +LOG = logging.getLogger(__name__)
> +
> +
>  class QEMUMachine(object):
>      '''A QEMU VM'''
>  
>      def __init__(self, binary, args=[], wrapper=[], name=None, test_dir="/var/tmp",
>                   monitor_address=None, socket_scm_helper=None, debug=False):
> +        if debug:
> +            LOG.setLevel(logging.DEBUG)
> +        else:
> +            LOG.setLevel(logging.INFO)

This makes the debug argument for one QEMUMachine object affect
other QEMUMachine objects.

What about:
    self.logger = LOG.getChild(name)
    self.logger.setLevel(...)

But do we really need to support per-QEMUMachine verbosity
levels?  We could simply eliminate the 'debug' argument and let
scripts configure logging.

>          if name is None:
>              name = "qemu-%d" % os.getpid()
>          if monitor_address is None:
> @@ -62,10 +71,10 @@ class QEMUMachine(object):
>          # In iotest.py, the qmp should always use unix socket.
>          assert self._qmp.is_scm_available()
>          if self._socket_scm_helper is None:
> -            print >>sys.stderr, "No path to socket_scm_helper set"
> +            LOG.error("No path to socket_scm_helper set")
>              return -1
>          if os.path.exists(self._socket_scm_helper) == False:
> -            print >>sys.stderr, "%s does not exist" % self._socket_scm_helper
> +            LOG.error("%s does not exist", self._socket_scm_helper)
>              return -1
>          fd_param = ["%s" % self._socket_scm_helper,
>                      "%d" % self._qmp.get_sock_fd(),
> @@ -154,7 +163,8 @@ class QEMUMachine(object):
>  
>              exitcode = self._popen.wait()
>              if exitcode < 0:
> -                sys.stderr.write('qemu received signal %i: %s\n' % (-exitcode, ' '.join(self._args)))
> +                LOG.error('qemu received signal %i: %s', -exitcode,
> +                          ' '.join(self._args))
>              self._load_io_log()
>              self._post_shutdown()
>  
> -- 
> 2.13.3
> 

-- 
Eduardo
