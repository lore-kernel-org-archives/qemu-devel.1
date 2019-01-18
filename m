Received: from eggs.gnu.org ([209.51.188.92]:35598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ccarrara@redhat.com>) id 1gkV8W-0005QF-9u
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:28:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ccarrara@redhat.com>) id 1gkV8V-0003Ak-DD
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:28:44 -0500
Date: Fri, 18 Jan 2019 12:28:30 -0200
From: Caio Carrara <ccarrara@redhat.com>
Message-ID: <20190118142830.GB24013@localhost.localdomain>
References: <20190117185628.21862-1-crosa@redhat.com>
	<20190117185628.21862-6-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117185628.21862-6-crosa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/18] Acceptance tests: introduce arch
 parameter and attribute
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Cornelia Huck <cohuck@redhat.com>, Fam Zheng <fam@euphon.net>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>

Hi, Cleber.

On Thu, Jan 17, 2019 at 01:56:15PM -0500, Cleber Rosa wrote:
> It's useful to define the architecture that should be used in
> situations such as:
>  * the intended target of the QEMU binary to be used on tests
>  * the architecture of code to be run within the QEMU binary, such
>    as a kernel image or a full blown guest OS image
> 
> This commit introduces both a test parameter and a test instance
> attribute, that will contain such a value.
> 
> Now, when the "arch" test parameter is given, it will influence the
> selection of the default QEMU binary, if one is not given explicitly
> by means of the "qemu_img" parameter.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  docs/devel/testing.rst                    | 18 ++++++++++++++++++
>  tests/acceptance/avocado_qemu/__init__.py | 13 ++++++++++---
>  2 files changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> index 44c9b3ae74..60a16c5834 100644
> --- a/docs/devel/testing.rst
> +++ b/docs/devel/testing.rst
> @@ -689,6 +689,17 @@ vm
>  A QEMUMachine instance, initially configured according to the given
>  ``qemu_bin`` parameter.
>  
> +arch
> +~~~~
> +
> +The architecture that will be used on a number of different
> +scenarios.  For instance, when a QEMU binary is not explicitly given,
> +the one selected will depend on this attribute.
> +
> +The ``arch`` attribute will be set to the test parameter of the same
> +name, and if one is not given explicitly, it will default to the
> +system architecture (as given by ``uname``).

Would you think it's important to make explicit that it's the *host*
system architecture? Just like you did in the docstrings of
pick_default_qemu_bin().

> +
>  qemu_bin
>  ~~~~~~~~
>  
> @@ -711,6 +722,13 @@ like the following:
>  
>    PARAMS (key=qemu_bin, path=*, default=x86_64-softmmu/qemu-system-x86_64) => 'x86_64-softmmu/qemu-system-x86_64
>  
> +arch
> +~~~~
> +
> +The architecture that will be used on a number of different scenarios.
> +This parameter has a direct relation with the ``arch`` attribute.  If
> +not given, it will default to None.
> +
>  qemu_bin
>  ~~~~~~~~
>  
> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/avocado_qemu/__init__.py
> index d8d5b48dac..7a38851753 100644
> --- a/tests/acceptance/avocado_qemu/__init__.py
> +++ b/tests/acceptance/avocado_qemu/__init__.py
> @@ -23,16 +23,22 @@ def is_readable_executable_file(path):
>      return os.path.isfile(path) and os.access(path, os.R_OK | os.X_OK)
>  
>  
> -def pick_default_qemu_bin():
> +def pick_default_qemu_bin(arch=None):
>      """
>      Picks the path of a QEMU binary, starting either in the current working
>      directory or in the source tree root directory.
>  
> +    :param arch: the arch to use when looking for a QEMU binary (the target
> +                 will match the arch given).  If None (the default) arch
> +                 will be the current host system arch (as given by
> +                 :func:`os.uname`).
> +    :type arch: str
>      :returns: the path to the default QEMU binary or None if one could not
>                be found
>      :rtype: str or None
>      """
> -    arch = os.uname()[4]
> +    if arch is None:
> +        arch = os.uname()[4]
>      qemu_bin_relative_path = os.path.join("%s-softmmu" % arch,
>                                            "qemu-system-%s" % arch)
>      if is_readable_executable_file(qemu_bin_relative_path):
> @@ -47,8 +53,9 @@ def pick_default_qemu_bin():
>  class Test(avocado.Test):
>      def setUp(self):
>          self.vm = None
> +        self.arch = self.params.get('arch')
>          self.qemu_bin = self.params.get('qemu_bin',
> -                                        default=pick_default_qemu_bin())
> +                                        default=pick_default_qemu_bin(self.arch))

Since it was used the named argument in function declaration I think
it's more consistent also use the argument name here in the function
call: `pick_default_qemu_bin(arch=self.arch)`

>          if self.qemu_bin is None:
>              self.cancel("No QEMU binary defined or found in the source tree")
>          self.vm = QEMUMachine(self.qemu_bin)
> -- 
> 2.20.1
> 

Thanks,
-- 
Caio Carrara
Software Engineer, Virt Team - Red Hat
ccarrara@redhat.com
