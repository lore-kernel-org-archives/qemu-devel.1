Received: from eggs.gnu.org ([2001:4830:134:3::10]:48855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gCC8R-0006G9-G5
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 19:18:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gCC8Q-0005uF-64
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 19:18:51 -0400
References: <20181015141453.32632-1-mreitz@redhat.com>
	<20181015141453.32632-7-mreitz@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <4c35f899-8586-4b57-7c9d-699aac223752@redhat.com>
Date: Mon, 15 Oct 2018 19:18:41 -0400
MIME-Version: 1.0
In-Reply-To: <20181015141453.32632-7-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>



On 10/15/18 10:14 AM, Max Reitz wrote:
> Python 3.2 introduced the inheritable attribute for FDs.  At the same
> time, it changed the default so that all FDs are not inheritable by
> default, that only inheritable FDs are inherited to subprocesses, and
> only if close_fds is explicitly set to False.
> 

It's actually a change that was introduced in 3.4:

https://docs.python.org/3/library/os.html#inheritance-of-file-descriptors

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

Version should be 3.4 here as well.

> +            os.set_inheritable(fd, True)
> +        except AttributeError:
> +            pass
> +

Doing hasattr(os, "set_inheritable") is cheaper.

- Cleber.

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
>          result = self.vm.send_fd_scm(str(sockfd.fileno()))
>          self.assertEqual(result, 0, 'Failed to send socket FD')
>  
> 
