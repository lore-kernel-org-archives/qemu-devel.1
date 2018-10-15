Received: from eggs.gnu.org ([2001:4830:134:3::10]:52144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gC9WP-0005BS-F1
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 16:31:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gC9WK-0004Wx-Hi
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 16:31:23 -0400
Date: Mon, 15 Oct 2018 17:30:36 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181015203036.GE31060@habkost.net>
References: <20181015141453.32632-1-mreitz@redhat.com>
	<20181015141453.32632-7-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015141453.32632-7-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 6/9] iotests: Explicitly inherit FDs in
 Python
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>

On Mon, Oct 15, 2018 at 04:14:50PM +0200, Max Reitz wrote:
> Python 3.2 introduced the inheritable attribute for FDs.  At the same
> time, it changed the default so that all FDs are not inheritable by
> default, that only inheritable FDs are inherited to subprocesses, and
> only if close_fds is explicitly set to False.
> 
> Adhere to this by setting close_fds to False when working with
> subprocesses that may want to inherit FDs, and by trying to
> set_inheritable() on FDs that we do want to bequeath to them.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  scripts/qemu.py        | 13 +++++++++++--
>  scripts/qmp/qmp.py     |  7 +++++++
>  tests/qemu-iotests/147 |  7 +++++++
>  3 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index f099ce7278..28366c4a67 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -142,10 +142,18 @@ class QEMUMachine(object):
>          if opts:
>              options.append(opts)
>  
> +        # This did not exist before 3.2, but since then it is
> +        # mandatory for our purpose
> +        try:
> +            os.set_inheritable(fd, True)
> +        except AttributeError:
> +            pass
> +

This is add_fd(), so calling set_inheritable() automatically here
makes sense.

>          self._args.append('-add-fd')
>          self._args.append(','.join(options))
>          return self
>  
> +    # The caller needs to make sure the FD is inheritable
>      def send_fd_scm(self, fd_file_path):
>          # In iotest.py, the qmp should always use unix socket.
>          assert self._qmp.is_scm_available()
> @@ -159,7 +167,7 @@ class QEMUMachine(object):
>                      "%s" % fd_file_path]
>          devnull = open(os.path.devnull, 'rb')
>          proc = subprocess.Popen(fd_param, stdin=devnull, stdout=subprocess.PIPE,
> -                                stderr=subprocess.STDOUT)
> +                                stderr=subprocess.STDOUT, close_fds=False)
>          output = proc.communicate()[0]
>          if output:
>              LOG.debug(output)
> @@ -280,7 +288,8 @@ class QEMUMachine(object):
>                                         stdin=devnull,
>                                         stdout=self._qemu_log_file,
>                                         stderr=subprocess.STDOUT,
> -                                       shell=False)
> +                                       shell=False,
> +                                       close_fds=False)
>          self._post_launch()
>  
>      def wait(self):
> diff --git a/scripts/qmp/qmp.py b/scripts/qmp/qmp.py
> index 5c8cf6a056..009be8345b 100644
> --- a/scripts/qmp/qmp.py
> +++ b/scripts/qmp/qmp.py
> @@ -10,6 +10,7 @@
>  
>  import json
>  import errno
> +import os
>  import socket
>  import logging
>  
> @@ -253,4 +254,10 @@ class QEMUMonitorProtocol(object):
>          return self.__sock.fileno()
>  
>      def is_scm_available(self):
> +        # This did not exist before 3.2, but since then it is
> +        # mandatory for our purpose
> +        try:
> +            os.set_inheritable(self.get_sock_fd(), True)
> +        except AttributeError:
> +            pass

Why did you decide to place this code inside is_scm_available()?

For reference, this is the only caller of is_scm_available():

    def send_fd_scm(self, fd_file_path):
        # In iotest.py, the qmp should always use unix socket.
        assert self._qmp.is_scm_available()
        ...

In addition to making a method called is_*() have an unexpected
side-effect, the method won't be called at all if running with
debugging disabled.

I suggest simply placing the os.set_inheritable() call inside
send_fd_scm(), as close as possible to the subprocess.Popen()
call.


>          return self.__sock.family == socket.AF_UNIX
> diff --git a/tests/qemu-iotests/147 b/tests/qemu-iotests/147
> index d2081df84b..b58455645b 100755
> --- a/tests/qemu-iotests/147
> +++ b/tests/qemu-iotests/147
> @@ -229,6 +229,13 @@ class BuiltinNBD(NBDBlockdevAddBase):
>          sockfd = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
>          sockfd.connect(unix_socket)
>  
> +        # This did not exist before 3.2, but since then it is
> +        # mandatory for our purpose
> +        try:
> +            os.set_inheritable(sockfd.fileno(), True)
> +        except AttributeError:
> +            pass
> +

Why not make send_fd_scm() responsible for calling
os.set_inheritable(), making this hunk unnecessary?


>          result = self.vm.send_fd_scm(str(sockfd.fileno()))
>          self.assertEqual(result, 0, 'Failed to send socket FD')
>  
> -- 
> 2.17.1
> 

-- 
Eduardo
