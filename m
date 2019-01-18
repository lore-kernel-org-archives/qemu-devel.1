Received: from eggs.gnu.org ([209.51.188.92]:53926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gkRYN-0002jS-Fk
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:39:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gkRYM-0005Gq-Md
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:39:11 -0500
Date: Fri, 18 Jan 2019 11:38:55 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190118113855.020dc3c0.cohuck@redhat.com>
In-Reply-To: <20190117185628.21862-7-crosa@redhat.com>
References: <20190117185628.21862-1-crosa@redhat.com>
	<20190117185628.21862-7-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 06/18] Acceptance tests: use "arch:" tag to
 filter target specific tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>, qemu-s390x@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <fam@euphon.net>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>

On Thu, 17 Jan 2019 13:56:16 -0500
Cleber Rosa <crosa@redhat.com> wrote:

> Currently, the only test that contains some target architecture
> information is "boot_linux_console.py" which test contains a "x86_64"
> tag.  But that tag is not respected in the default execution, that is,
> "make check-acceptance" doesn't do anything with it.
> 
> That said, even the target architecture handling currently present in
> the "avocado_qemu.Test" class, class is pretty limited.  For instance,
> by default, it chooses a target based on the host architecture.
> 
> Because the original implementation of the tags feature in Avocado did
> not include any time of namespace or "key:val" mechanism, no tag has
> relation to another tag.  The new implementation of the tags feature
> from version 67.0 onwards, allows "key:val" tags, and because of that,
> a test can be classified with a tag in a given key.  For instance, the
> new proposed version of the "boot_linux_console.py" test, which
> downloads and attempts to run a x86_64 kernel, is now tagged as:
> 
>   :avocado: tags=arch:x86_64
> 
> This means that it can be filtered (out) when no x86_64 target is
> available.  At the same time, tests that don't have a "arch:" tag,
> will not be filtered out.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  tests/Makefile.include                 | 3 +++
>  tests/acceptance/boot_linux_console.py | 2 +-
>  tests/requirements.txt                 | 2 +-
>  3 files changed, 5 insertions(+), 2 deletions(-)
> 

> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
> index 98324f7591..46b20bdfe2 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -19,7 +19,7 @@ class BootLinuxConsole(Test):
>      and the kernel command line is properly passed from QEMU to the kernel
>  
>      :avocado: enable
> -    :avocado: tags=x86_64
> +    :avocado: tags=arch:x86_64
>      """
>  
>      timeout = 60

You probably want to do the same change in virtio_version.py;
otherwise, if I run the acceptance tests on s390x, it will run into
timeouts (it looks like that test is intended to be run with x86
machines anyway.)
