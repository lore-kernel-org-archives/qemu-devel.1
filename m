Received: from eggs.gnu.org ([2001:4830:134:3::10]:48642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAC4h-0006Q4-RE
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 06:50:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAC4d-00086F-Qi
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 06:50:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33049)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gAC4d-00085f-Gl
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 06:50:39 -0400
Received: by mail-wr1-f65.google.com with SMTP id e4-v6so5201726wrs.0
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 03:50:39 -0700 (PDT)
References: <20181009232607.15521-1-crosa@redhat.com>
	<20181009232607.15521-8-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a633eba5-3b96-2e36-db9d-25b8718c6bbb@redhat.com>
Date: Wed, 10 Oct 2018 12:50:36 +0200
MIME-Version: 1.0
In-Reply-To: <20181009232607.15521-8-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <pmathieu@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Laszlo Ersek <lersek@redhat.com>

On 10/10/2018 01:26, Cleber Rosa wrote:
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
>      """
>  
>      timeout = 60
>  
>      def test(self):
> +        if self.arch != 'x86_64':
> +            self.cancel('Currently specific to the x86_64 target arch')
>          kernel_url = ('https://mirrors.kernel.org/fedora/releases/28/'
>                        'Everything/x86_64/os/images/pxeboot/vmlinuz')
>          kernel_hash = '238e083e114c48200f80d889f7e32eeb2793e02a'
> 

For some reason this test run quicker on a aarch64 host than my x86 laptop:

ThunderX 88XX (aarch64 Little Endian):

 (05/30)
tests/acceptance/boot_linux_console.py:BootLinuxConsole.test;x86_64:
PASS (12.88 s)

Intel(R) Core(TM) i7-8650U CPU @ 1.90GHz:

 (05/30)
tests/acceptance/boot_linux_console.py:BootLinuxConsole.test;x86_64:
PASS (31.13 s)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
