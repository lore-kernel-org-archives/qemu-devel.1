Received: from eggs.gnu.org ([2001:4830:134:3::10]:42840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f9cD4-0008Ha-O8
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 16:00:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f9cD1-0007ia-L0
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 16:00:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f9cD1-0007hy-CP
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 16:00:39 -0400
Date: Fri, 20 Apr 2018 16:59:33 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180420195933.GG29865@localhost.localdomain>
References: <20180420181951.7252-1-ehabkost@redhat.com>
	<20180420181951.7252-3-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420181951.7252-3-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [RFC 02/24] Introduce the basic framework to run
 Avocado tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Amador Pahim <apahim@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, Alistair Francis <alistair23@gmail.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <famz@redhat.com>

On Fri, Apr 20, 2018 at 03:19:29PM -0300, Eduardo Habkost wrote:
> From: Amador Pahim <apahim@redhat.com>
> 
> Avocado Testing Framework can help with functional tests in
> qemu development process. This patch creates the basic infrastructure
> to use with Avocado tests. It contains:
> 
> - A README file with the initial documentation.
> - The test module which inherits from avocado.Test and adds a VM object,
>   created from scripts/qemu.py module. The QemuTest class is the test
>   API for the actual Qemu tests to inherit from.
> - A parameters yaml file with the supported keys.
> - A variants yaml file with the Qemu supported architectures.
> 
> After this commit, you can expect a series of real-world tests, written
> using this new framework.
> 
> Signed-off-by: Amador Pahim <apahim@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  scripts/qemu.py                        |  12 +-
>  tests/avocado/README.rst               | 111 ++++++++++
>  tests/avocado/avocado_qemu/__init__.py |   0
>  tests/avocado/avocado_qemu/test.py     | 365 +++++++++++++++++++++++++++++++++
>  tests/avocado/parameters.yaml          |  28 +++
>  tests/avocado/variants.yaml            |  62 ++++++
>  tests/qemu-iotests/iotests.py          |  28 +--
>  7 files changed, 586 insertions(+), 20 deletions(-)
>  create mode 100644 tests/avocado/README.rst
>  create mode 100644 tests/avocado/avocado_qemu/__init__.py
>  create mode 100644 tests/avocado/avocado_qemu/test.py
>  create mode 100644 tests/avocado/parameters.yaml
>  create mode 100644 tests/avocado/variants.yaml
> 
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index 9e9d502543..bd66620f45 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -81,7 +81,7 @@ class QEMUMachine(object):
>          self._qemu_log_file = None
>          self._popen = None
>          self._binary = binary
> -        self._args = list(args)     # Force copy args in case we modify them
> +        self.args = list(args)     # Force copy args in case we modify them

This should go to a separate patch.

Also, I would prefer a self.add_args(...) interface, instead of
exposing self.args to the outside directly.  I remember some past
discussions about this, but I don't remember what was the
conclusion.

I will review tests/avocado/* later.

>          self._wrapper = wrapper
>          self._events = []
>          self._iolog = None
> @@ -109,8 +109,8 @@ class QEMUMachine(object):
>      # This can be used to add an unused monitor instance.
>      def add_monitor_telnet(self, ip, port):
>          args = 'tcp:%s:%d,server,nowait,telnet' % (ip, port)
> -        self._args.append('-monitor')
> -        self._args.append(args)
> +        self.args.append('-monitor')
> +        self.args.append(args)
>  
>      def add_fd(self, fd, fdset, opaque, opts=''):
>          '''Pass a file descriptor to the VM'''
> @@ -120,8 +120,8 @@ class QEMUMachine(object):
>          if opts:
>              options.append(opts)
>  
> -        self._args.append('-add-fd')
> -        self._args.append(','.join(options))
> +        self.args.append('-add-fd')
> +        self.args.append(','.join(options))
>          return self
>  
>      def send_fd_scm(self, fd_file_path):
> @@ -184,7 +184,7 @@ class QEMUMachine(object):
>                  '-display', 'none', '-vga', 'none']
>  
>      def _create_console(self, console_address):
> -        for item in self._args:
> +        for item in self.args:
>              for option in ['isa-serial', 'spapr-vty', 'sclpconsole']:
>                  if option in item:
>                      return []
[...]

-- 
Eduardo
