Received: from eggs.gnu.org ([2001:4830:134:3::10]:58473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g85lW-0003fR-5Q
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:42:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g85lQ-0002Gm-L0
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:42:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35863)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g85lQ-0002GS-Do
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:42:08 -0400
Received: by mail-wr1-f67.google.com with SMTP id y16so10456093wrw.3
	for <qemu-devel@nongnu.org>; Thu, 04 Oct 2018 08:42:08 -0700 (PDT)
References: <20181004151429.7232-1-crosa@redhat.com>
	<20181004151429.7232-8-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <17e96f1b-c07d-0966-49ae-1cd48c0e7afc@redhat.com>
Date: Thu, 4 Oct 2018 17:42:05 +0200
MIME-Version: 1.0
In-Reply-To: <20181004151429.7232-8-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 7/7] Acceptance Tests: change the handling
 of tests for specific archs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Caio Carrara <ccarrara@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <pmathieu@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

On 04/10/2018 17:14, Cleber Rosa wrote:
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
> index 58032f971c..2fb5da63cb 100644
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
> +            self.cancel('Currently specific to the x86_64 arch')

Watch out the difference between the HOST arch and the TARGET arch.

This test is specific to the x86_64 TARGET arch (the one emulated),
_but_ it can be run on any HOST arch with TCG enabled:

$ uname -m
aarch64

$ avocado \
      --show=console \
    run \
      -p qemu_bin=x86_64-softmmu/qemu-system-x86_64 \
   tests/acceptance/boot_linux_console.py
JOB ID     : f6e023ac4ee0f999ab01bfb1b196f43fde8538b9

JOB LOG    :
/home/phil/avocado/job-results/job-2018-10-04T15.41-f6e023a/job.log
 (1/1) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test: /
console: [    0.000000] Linux version 4.16.3-301.fc28.x86_64
(mockbuild@bkernel02.phx2.fedoraproject.org) (gcc version 8.0.1 20180324
(Red Hat 8.0.1-0.20) (GCC)) #1 SMP Mon Apr 23 21:59:58 8
console: [    0.000000] Command line: console=ttyS0
console: [    0.000000] x86/fpu: x87 FPU will use FXSAVE
...
console: [    0.000000] NX (Execute Disable) protection: active
console: [    0.000000] random: fast init done
console: [    0.000000] SMBIOS 2.8 present.

console: [    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.11.2-0-gf9626ccb91-prebuilt.qemu-project.org 04/01/2014
...
console: [    0.000000] Booting paravirtualized kernel on bare hardware
...
console: [    0.000000] Kernel command line: console=ttyS0
PASS (12.89 s)
RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 |
CANCEL 0
JOB TIME   : 13.12 s

>          kernel_url = ('https://mirrors.kernel.org/fedora/releases/28/'
>                        'Everything/x86_64/os/images/pxeboot/vmlinuz')
>          kernel_hash = '238e083e114c48200f80d889f7e32eeb2793e02a'
> 
