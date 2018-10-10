Received: from eggs.gnu.org ([2001:4830:134:3::10]:52044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gACHb-0002RK-1U
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 07:04:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gACHV-0001Sl-LH
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 07:04:01 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40924)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gACHV-0001RM-BL
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 07:03:57 -0400
Received: by mail-wm1-f66.google.com with SMTP id z204-v6so5280117wmc.5
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 04:03:55 -0700 (PDT)
References: <20181009232607.15521-1-crosa@redhat.com>
	<20181009232607.15521-3-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7e594429-bced-f160-144f-56dacd3dc79e@redhat.com>
Date: Wed, 10 Oct 2018 13:03:53 +0200
MIME-Version: 1.0
In-Reply-To: <20181009232607.15521-3-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 2/7] Acceptance Tests: introduce arch
 parameter and attribute
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <pmathieu@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Laszlo Ersek <lersek@redhat.com>

On 10/10/2018 01:26, Cleber Rosa wrote:
> On a number of different scenarios, such as when choosing a QEMU
> binary to be used on tests (or a image to use to boot a test VM), it's
> useful to define the architecture that should be used.
> 
> This introduces both a test parameter and a test instance attribute,
> that will contain such a value.
> 
> The selection of the default QEMU binary, if one is not given
> explicitly, has also been changed to look at the arch attribute.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  docs/devel/testing.rst                    | 18 ++++++++++++++++++
>  tests/acceptance/avocado_qemu/__init__.py | 13 ++++++++++---
>  2 files changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> index 727c4019b5..4178ae5022 100644
> --- a/docs/devel/testing.rst
> +++ b/docs/devel/testing.rst
> @@ -659,6 +659,17 @@ vm
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
> +
>  qemu_bin
>  ~~~~~~~~
>  
> @@ -681,6 +692,13 @@ like the following:
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
> index d8d5b48dac..b8d934382d 100644
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
> +        self.arch = self.params.get('arch', default=os.uname()[4])
>          self.qemu_bin = self.params.get('qemu_bin',
> -                                        default=pick_default_qemu_bin())
> +                                        default=pick_default_qemu_bin(self.arch))
>          if self.qemu_bin is None:
>              self.cancel("No QEMU binary defined or found in the source tree")
>          self.vm = QEMUMachine(self.qemu_bin)
> 
