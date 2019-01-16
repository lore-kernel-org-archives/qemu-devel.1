Received: from eggs.gnu.org ([209.51.188.92]:47476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gjoft-0006CY-Dg
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 12:08:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gjofs-0004hL-KH
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 12:08:21 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:47003)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gjofs-0004gl-9p
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 12:08:20 -0500
Received: by mail-wr1-f66.google.com with SMTP id l9so7729692wrt.13
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 09:08:20 -0800 (PST)
References: <1547566866-129386-1-git-send-email-imammedo@redhat.com>
	<1547566866-129386-15-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5f191a7d-74fd-db22-2e71-c8de1cc1c312@redhat.com>
Date: Wed, 16 Jan 2019 18:08:17 +0100
MIME-Version: 1.0
In-Reply-To: <1547566866-129386-15-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 14/14] tests: acpi: refactor
 rebuild-expected-aml.sh to dump ACPI tables for a specified list of targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Gonglei <arei.gonglei@huawei.com>, Laszlo Ersek <lersek@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, Andrew Jones <drjones@redhat.com>

On 1/15/19 4:41 PM, Igor Mammedov wrote:
> Make initial list contain aarch64 and x86_64 targets.

Maybe worth adding a line "remove i386"?

> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  tests/data/acpi/rebuild-expected-aml.sh | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/tests/data/acpi/rebuild-expected-aml.sh b/tests/data/acpi/rebuild-expected-aml.sh
> index bf9ba24..6287aa6 100755
> --- a/tests/data/acpi/rebuild-expected-aml.sh
> +++ b/tests/data/acpi/rebuild-expected-aml.sh
> @@ -7,21 +7,12 @@
>  #
>  # Authors:
>  #  Marcel Apfelbaum <marcel.a@redhat.com>
> +#  Igor Mammedov <imammedo@redhat.com>
>  #
>  # This work is licensed under the terms of the GNU GPLv2.
>  # See the COPYING.LIB file in the top-level directory.
>  
> -qemu=
> -
> -if [ -e x86_64-softmmu/qemu-system-x86_64 ]; then
> -    qemu="x86_64-softmmu/qemu-system-x86_64"
> -elif [ -e i386-softmmu/qemu-system-i386 ]; then
> -    qemu="i386-softmmu/qemu-system-i386"
> -else
> -    echo "Run 'make' to build the qemu exectutable!"
> -    echo "Run this script from the build directory."
> -    exit 1;
> -fi
> +qemu_bins="aarch64-softmmu/qemu-system-aarch64 x86_64-softmmu/qemu-system-x86_64"
>  
>  if [ ! -e "tests/bios-tables-test" ]; then
>      echo "Test: bios-tables-test is required! Run make check before this script."
> @@ -29,6 +20,14 @@ if [ ! -e "tests/bios-tables-test" ]; then
>      exit 1;
>  fi
>  
> -TEST_ACPI_REBUILD_AML=y QTEST_QEMU_BINARY=$qemu tests/bios-tables-test
> +for qemu in $qemu_bins; do
> +    if [ ! -e $qemu ]; then
> +        echo "Run 'make' to build following the qemu exectutables: $qemu_bins"

"to build the following QEMU executables: ..."

> +        echo "Run this script from the build directory."

Maybe "Also, run ..."

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +        exit 1;
> +    fi
> +    TEST_ACPI_REBUILD_AML=y QTEST_QEMU_BINARY=$qemu tests/bios-tables-test
> +done
> +
>  
>  echo "The files were rebuilt and can be added to git."
> 
