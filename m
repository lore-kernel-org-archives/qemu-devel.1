Received: from eggs.gnu.org ([209.51.188.92]:57204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ccarrara@redhat.com>) id 1glg8e-0005MC-5u
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 15:25:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ccarrara@redhat.com>) id 1glg8d-0003ql-AF
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 15:25:44 -0500
Date: Mon, 21 Jan 2019 18:25:31 -0200
From: Caio Carrara <ccarrara@redhat.com>
Message-ID: <20190121202530.GF17671@localhost.localdomain>
References: <20190117185628.21862-1-crosa@redhat.com>
	<20190117185628.21862-8-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117185628.21862-8-crosa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 07/18] Acceptance tests: look for target
 architecture in test tags first
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

On Thu, Jan 17, 2019 at 01:56:17PM -0500, Cleber Rosa wrote:
> A test can, optionally, be tagged for one or many architectures.  If a
> test has been tagged for a single architecture, there's a high chance
> that the test won't run on other architectures.  This changes the
> default order of choosing a default target architecture to use based
> on the 'arch' tag value first.
> 
> The precedence order is for choosing a QEMU binary to use for a test
> is now:
> 
>  * qemu_bin parameter
>  * arch parameter
>  * arch tag value (for example, x86_64 if ":avocado: tags=arch:x86_64
>    is used)
> 
> This means that if one runs:
> 
>  $ avocado run -p qemu_bin=/usr/bin/qemu-system-x86_64 test.py
> 
> No arch parameter or tag will influence the selection of the QEMU
> target binary.  If one runs:
> 
>  $ avocado run -p arch=ppc64 test.py
> 
> The target binary selection mechanism will attempt to find a binary
> such as "ppc64-softmmu/qemu-system-ppc64".  And finally, if one runs
> a test that is tagged (in its docstring) with "arch:aarch64":
> 
>  $ avocado run aarch64.py
> 
> The target binary selection mechanism will attempt to find a binary
> such as "aarch64-softmmu/qemu-system-aarch64".
> 
> At this time, no provision is made to cancel the execution of tests if
> the arch parameter given (manually) does not match the test "arch"
> tag, but it may be a useful default behavior to be added in the
> future.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>

Reviewed-by: Caio Carrara <ccarrara@redhat.com>

> ---
>  tests/acceptance/avocado_qemu/__init__.py | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/avocado_qemu/__init__.py
> index 7a38851753..ddbdb7b926 100644
> --- a/tests/acceptance/avocado_qemu/__init__.py
> +++ b/tests/acceptance/avocado_qemu/__init__.py
> @@ -53,7 +53,12 @@ def pick_default_qemu_bin(arch=None):
>  class Test(avocado.Test):
>      def setUp(self):
>          self.vm = None
> -        self.arch = self.params.get('arch')
> +        arches = self.tags.get('arch', [])
> +        if len(arches) == 1:
> +            arch = arches.pop()
> +        else:
> +            arch = None
> +        self.arch = self.params.get('arch', default=arch)
>          self.qemu_bin = self.params.get('qemu_bin',
>                                          default=pick_default_qemu_bin(self.arch))
>          if self.qemu_bin is None:
> -- 
> 2.20.1
> 

-- 
Caio Carrara
Software Engineer, Virt Team - Red Hat
ccarrara@redhat.com
