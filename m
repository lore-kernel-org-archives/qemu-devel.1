Received: from eggs.gnu.org ([2001:4830:134:3::10]:42204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBHmu-0005Zr-Ol
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 07:08:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBHmp-000619-R4
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 07:08:52 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51931)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBHmp-00060r-Jj
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 07:08:47 -0400
Received: by mail-wm1-x344.google.com with SMTP id 143-v6so14438455wmf.1
	for <qemu-devel@nongnu.org>; Sat, 13 Oct 2018 04:08:47 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20181009232607.15521-1-crosa@redhat.com>
	<20181009232607.15521-8-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f64fd819-8977-bcc0-97db-84ef4c83a046@amsat.org>
Date: Sat, 13 Oct 2018 13:08:42 +0200
MIME-Version: 1.0
In-Reply-To: <20181009232607.15521-8-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 7/7] Acceptance Tests: change the
 handling of tests for specific archs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Laszlo Ersek <lersek@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <pmathieu@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

Hi Cleber,

On 10/10/18 1:26 AM, Cleber Rosa wrote:
> With the introduction of a variants file that can run the same
> tests on various architectures, it makes sense to make most tests
> to be reusable on those environments.  The exception should be
> when a test is really testing a specific architecture feature.
> 
> With the change proposed here, on a command line such as:
> 
>   $ avocado run \
>      --json-variants-load=tests/acceptance/variants/arch.json \
>      -- tests/acceptance/
> 
> The boot_linux_console.py tests will appear as "CANCELED: Currently
> specific to the x86_64 arch", which is as a good thing when compared
> to being ignored by tags because:
> 
>  * The architecture specific parts can be addressed
>  * It will be run on the matching architecture (as opposed to always
>    being filtered out by the tags mechanism)
>  * CANCELED tests do no influence negatively the overall job results,
>    they're not considered an error or failure
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  tests/acceptance/boot_linux_console.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
> index 58032f971c..ba3ac036da 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -19,12 +19,13 @@ class BootLinuxConsole(Test):
>      and the kernel command line is properly passed from QEMU to the kernel
>  
>      :avocado: enable
> -    :avocado: tags=x86_64

Can we keep a such tag (in format 'arch:x86_64') ...

>      """
>  
>      timeout = 60
>  
>      def test(self):
> +        if self.arch != 'x86_64':
> +            self.cancel('Currently specific to the x86_64 target arch')

... and have this check generic? (Eventually via a QemuTest(Test) parent
class).

>          kernel_url = ('https://mirrors.kernel.org/fedora/releases/28/'
>                        'Everything/x86_64/os/images/pxeboot/vmlinuz')
>          kernel_hash = '238e083e114c48200f80d889f7e32eeb2793e02a'
> 
