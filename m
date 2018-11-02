Received: from eggs.gnu.org ([2001:4830:134:3::10]:58020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gIdPE-0002K4-CO
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 13:38:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gIdPA-0001DN-HE
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 13:38:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34128)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gIdP9-00014x-T8
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 13:38:44 -0400
Received: by mail-wr1-f66.google.com with SMTP id j26-v6so2808975wre.1
	for <qemu-devel@nongnu.org>; Fri, 02 Nov 2018 10:38:34 -0700 (PDT)
References: <20181102115239.22485-1-peter.maydell@linaro.org>
	<20181102115239.22485-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <734a4792-df43-7715-822f-9670de47da19@redhat.com>
Date: Fri, 2 Nov 2018 18:38:31 +0100
MIME-Version: 1.0
In-Reply-To: <20181102115239.22485-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 for-3.1 1/4] tests: Move
 tests/acpi-test-data/ to tests/data/acpi/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, patches@linaro.org

Hi Peter,

On 2/11/18 12:52, Peter Maydell wrote:
> Currently tests/acpi-test-data contains data files used by the
> bios-tables-test, and configure individually symlinks those
> data files into the build directory using a wildcard.
> 
> Using a wildcard like this is a bad idea, because if a new
> data file is added, nothing causes configure to be rerun,
> and so no symlink is added for the new file. This can cause
> tests to spuriously fail when they can't find their data.
> Instead, it's better to symlink an entire directory of
> data files. We already have such a directory: tests/data.
> 
> Move the data files from tests/acpi-test-data/ to
> tests/data/acpi/, and remove the unnecessary symlinking.
> 
> We can remove entirely the note in rebuild-expected-aml.sh
> about copying any new data files, because now they will
> be in the source directory, not the build directory, and
> no copying is required.

This doesn't seem true for out-of-tree builds.

> 
> (We can't just change the existing tests/acpi-test-data/
> to being a symlinked directory, because if we did that and
> a developer switched git branches from one after that change
> to one before it then configure would end up trashing all
> the test files by making them symlinks to themselves.
> Changing their path avoids this annoyance.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   configure                                           |   4 ----
>   tests/bios-tables-test.c                            |   2 +-
>   tests/{acpi-test-data => data/acpi}/pc/APIC         | Bin
>   tests/{acpi-test-data => data/acpi}/pc/APIC.cphp    | Bin
>   tests/{acpi-test-data => data/acpi}/pc/APIC.dimmpxm | Bin
>   tests/{acpi-test-data => data/acpi}/pc/DSDT         | Bin
>   tests/{acpi-test-data => data/acpi}/pc/DSDT.bridge  | Bin
>   tests/{acpi-test-data => data/acpi}/pc/DSDT.cphp    | Bin
>   tests/{acpi-test-data => data/acpi}/pc/DSDT.dimmpxm | Bin
>   tests/{acpi-test-data => data/acpi}/pc/DSDT.ipmikcs | Bin
>   tests/{acpi-test-data => data/acpi}/pc/DSDT.memhp   | Bin
>   tests/{acpi-test-data => data/acpi}/pc/DSDT.numamem | Bin
>   tests/{acpi-test-data => data/acpi}/pc/FACP         | Bin
>   tests/{acpi-test-data => data/acpi}/pc/FACS         | Bin
>   tests/{acpi-test-data => data/acpi}/pc/HPET         | Bin
>   tests/{acpi-test-data => data/acpi}/pc/NFIT.dimmpxm | Bin
>   tests/{acpi-test-data => data/acpi}/pc/SLIT.cphp    | Bin
>   tests/{acpi-test-data => data/acpi}/pc/SLIT.memhp   | Bin
>   tests/{acpi-test-data => data/acpi}/pc/SRAT.cphp    | Bin
>   tests/{acpi-test-data => data/acpi}/pc/SRAT.dimmpxm | Bin
>   tests/{acpi-test-data => data/acpi}/pc/SRAT.memhp   | Bin
>   tests/{acpi-test-data => data/acpi}/pc/SRAT.numamem | Bin
>   tests/{acpi-test-data => data/acpi}/pc/SSDT.dimmpxm | Bin
>   tests/{acpi-test-data => data/acpi}/q35/APIC        | Bin
>   tests/{acpi-test-data => data/acpi}/q35/APIC.cphp   | Bin
>   .../{acpi-test-data => data/acpi}/q35/APIC.dimmpxm  | Bin
>   tests/{acpi-test-data => data/acpi}/q35/DSDT        | Bin
>   tests/{acpi-test-data => data/acpi}/q35/DSDT.bridge | Bin
>   tests/{acpi-test-data => data/acpi}/q35/DSDT.cphp   | Bin
>   .../{acpi-test-data => data/acpi}/q35/DSDT.dimmpxm  | Bin
>   tests/{acpi-test-data => data/acpi}/q35/DSDT.ipmibt | Bin
>   tests/{acpi-test-data => data/acpi}/q35/DSDT.memhp  | Bin
>   .../{acpi-test-data => data/acpi}/q35/DSDT.numamem  | Bin
>   tests/{acpi-test-data => data/acpi}/q35/FACP        | Bin
>   tests/{acpi-test-data => data/acpi}/q35/FACS        | Bin
>   tests/{acpi-test-data => data/acpi}/q35/HPET        | Bin
>   tests/{acpi-test-data => data/acpi}/q35/MCFG        | Bin
>   .../{acpi-test-data => data/acpi}/q35/NFIT.dimmpxm  | Bin
>   tests/{acpi-test-data => data/acpi}/q35/SLIT.cphp   | Bin
>   tests/{acpi-test-data => data/acpi}/q35/SLIT.memhp  | Bin
>   tests/{acpi-test-data => data/acpi}/q35/SRAT.cphp   | Bin
>   .../{acpi-test-data => data/acpi}/q35/SRAT.dimmpxm  | Bin
>   tests/{acpi-test-data => data/acpi}/q35/SRAT.memhp  | Bin
>   .../{acpi-test-data => data/acpi}/q35/SRAT.numamem  | Bin
>   .../{acpi-test-data => data/acpi}/q35/SSDT.dimmpxm  | Bin
>   .../acpi}/rebuild-expected-aml.sh                   |   2 --
>   46 files changed, 1 insertion(+), 7 deletions(-)
>   rename tests/{acpi-test-data => data/acpi}/pc/APIC (100%)
>   rename tests/{acpi-test-data => data/acpi}/pc/APIC.cphp (100%)
>   rename tests/{acpi-test-data => data/acpi}/pc/APIC.dimmpxm (100%)
>   rename tests/{acpi-test-data => data/acpi}/pc/DSDT (100%)
>   rename tests/{acpi-test-data => data/acpi}/pc/DSDT.bridge (100%)
>   rename tests/{acpi-test-data => data/acpi}/pc/DSDT.cphp (100%)
>   rename tests/{acpi-test-data => data/acpi}/pc/DSDT.dimmpxm (100%)
>   rename tests/{acpi-test-data => data/acpi}/pc/DSDT.ipmikcs (100%)
>   rename tests/{acpi-test-data => data/acpi}/pc/DSDT.memhp (100%)
>   rename tests/{acpi-test-data => data/acpi}/pc/DSDT.numamem (100%)
>   rename tests/{acpi-test-data => data/acpi}/pc/FACP (100%)
>   rename tests/{acpi-test-data => data/acpi}/pc/FACS (100%)
>   rename tests/{acpi-test-data => data/acpi}/pc/HPET (100%)
>   rename tests/{acpi-test-data => data/acpi}/pc/NFIT.dimmpxm (100%)
>   rename tests/{acpi-test-data => data/acpi}/pc/SLIT.cphp (100%)
>   rename tests/{acpi-test-data => data/acpi}/pc/SLIT.memhp (100%)
>   rename tests/{acpi-test-data => data/acpi}/pc/SRAT.cphp (100%)
>   rename tests/{acpi-test-data => data/acpi}/pc/SRAT.dimmpxm (100%)
>   rename tests/{acpi-test-data => data/acpi}/pc/SRAT.memhp (100%)
>   rename tests/{acpi-test-data => data/acpi}/pc/SRAT.numamem (100%)
>   rename tests/{acpi-test-data => data/acpi}/pc/SSDT.dimmpxm (100%)
>   rename tests/{acpi-test-data => data/acpi}/q35/APIC (100%)
>   rename tests/{acpi-test-data => data/acpi}/q35/APIC.cphp (100%)
>   rename tests/{acpi-test-data => data/acpi}/q35/APIC.dimmpxm (100%)
>   rename tests/{acpi-test-data => data/acpi}/q35/DSDT (100%)
>   rename tests/{acpi-test-data => data/acpi}/q35/DSDT.bridge (100%)
>   rename tests/{acpi-test-data => data/acpi}/q35/DSDT.cphp (100%)
>   rename tests/{acpi-test-data => data/acpi}/q35/DSDT.dimmpxm (100%)
>   rename tests/{acpi-test-data => data/acpi}/q35/DSDT.ipmibt (100%)
>   rename tests/{acpi-test-data => data/acpi}/q35/DSDT.memhp (100%)
>   rename tests/{acpi-test-data => data/acpi}/q35/DSDT.numamem (100%)
>   rename tests/{acpi-test-data => data/acpi}/q35/FACP (100%)
>   rename tests/{acpi-test-data => data/acpi}/q35/FACS (100%)
>   rename tests/{acpi-test-data => data/acpi}/q35/HPET (100%)
>   rename tests/{acpi-test-data => data/acpi}/q35/MCFG (100%)
>   rename tests/{acpi-test-data => data/acpi}/q35/NFIT.dimmpxm (100%)
>   rename tests/{acpi-test-data => data/acpi}/q35/SLIT.cphp (100%)
>   rename tests/{acpi-test-data => data/acpi}/q35/SLIT.memhp (100%)
>   rename tests/{acpi-test-data => data/acpi}/q35/SRAT.cphp (100%)
>   rename tests/{acpi-test-data => data/acpi}/q35/SRAT.dimmpxm (100%)
>   rename tests/{acpi-test-data => data/acpi}/q35/SRAT.memhp (100%)
>   rename tests/{acpi-test-data => data/acpi}/q35/SRAT.numamem (100%)
>   rename tests/{acpi-test-data => data/acpi}/q35/SSDT.dimmpxm (100%)
>   rename tests/{acpi-test-data => data/acpi}/rebuild-expected-aml.sh (86%)
> 
> diff --git a/configure b/configure
> index 46ae1e8c767..895b7483b8a 100755
> --- a/configure
> +++ b/configure
> @@ -7421,10 +7421,6 @@ for bios_file in \
>   do
>       FILES="$FILES pc-bios/$(basename $bios_file)"
>   done
> -for test_file in $(find $source_path/tests/acpi-test-data -type f)
> -do
> -    FILES="$FILES tests/acpi-test-data$(echo $test_file | sed -e 's/.*acpi-test-data//')"
> -done
>   for test_file in $(find $source_path/tests/hex-loader-check-data -type f)
>   do
>       FILES="$FILES tests/hex-loader-check-data$(echo $test_file | sed -e 's/.*hex-loader-check-data//')"
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index 02e77ec811b..b14c8eaa171 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -42,7 +42,7 @@ typedef struct {
>   } test_data;
>   
>   static char disk[] = "tests/acpi-test-disk-XXXXXX";
> -static const char *data_dir = "tests/acpi-test-data";
> +static const char *data_dir = "tests/data/acpi";
>   #ifdef CONFIG_IASL
>   static const char *iasl = stringify(CONFIG_IASL);
>   #else
> diff --git a/tests/acpi-test-data/pc/APIC b/tests/data/acpi/pc/APIC
> similarity index 100%
> rename from tests/acpi-test-data/pc/APIC
> rename to tests/data/acpi/pc/APIC
> diff --git a/tests/acpi-test-data/pc/APIC.cphp b/tests/data/acpi/pc/APIC.cphp
> similarity index 100%
> rename from tests/acpi-test-data/pc/APIC.cphp
> rename to tests/data/acpi/pc/APIC.cphp
> diff --git a/tests/acpi-test-data/pc/APIC.dimmpxm b/tests/data/acpi/pc/APIC.dimmpxm
> similarity index 100%
> rename from tests/acpi-test-data/pc/APIC.dimmpxm
> rename to tests/data/acpi/pc/APIC.dimmpxm
> diff --git a/tests/acpi-test-data/pc/DSDT b/tests/data/acpi/pc/DSDT
> similarity index 100%
> rename from tests/acpi-test-data/pc/DSDT
> rename to tests/data/acpi/pc/DSDT
> diff --git a/tests/acpi-test-data/pc/DSDT.bridge b/tests/data/acpi/pc/DSDT.bridge
> similarity index 100%
> rename from tests/acpi-test-data/pc/DSDT.bridge
> rename to tests/data/acpi/pc/DSDT.bridge
> diff --git a/tests/acpi-test-data/pc/DSDT.cphp b/tests/data/acpi/pc/DSDT.cphp
> similarity index 100%
> rename from tests/acpi-test-data/pc/DSDT.cphp
> rename to tests/data/acpi/pc/DSDT.cphp
> diff --git a/tests/acpi-test-data/pc/DSDT.dimmpxm b/tests/data/acpi/pc/DSDT.dimmpxm
> similarity index 100%
> rename from tests/acpi-test-data/pc/DSDT.dimmpxm
> rename to tests/data/acpi/pc/DSDT.dimmpxm
> diff --git a/tests/acpi-test-data/pc/DSDT.ipmikcs b/tests/data/acpi/pc/DSDT.ipmikcs
> similarity index 100%
> rename from tests/acpi-test-data/pc/DSDT.ipmikcs
> rename to tests/data/acpi/pc/DSDT.ipmikcs
> diff --git a/tests/acpi-test-data/pc/DSDT.memhp b/tests/data/acpi/pc/DSDT.memhp
> similarity index 100%
> rename from tests/acpi-test-data/pc/DSDT.memhp
> rename to tests/data/acpi/pc/DSDT.memhp
> diff --git a/tests/acpi-test-data/pc/DSDT.numamem b/tests/data/acpi/pc/DSDT.numamem
> similarity index 100%
> rename from tests/acpi-test-data/pc/DSDT.numamem
> rename to tests/data/acpi/pc/DSDT.numamem
> diff --git a/tests/acpi-test-data/pc/FACP b/tests/data/acpi/pc/FACP
> similarity index 100%
> rename from tests/acpi-test-data/pc/FACP
> rename to tests/data/acpi/pc/FACP
> diff --git a/tests/acpi-test-data/pc/FACS b/tests/data/acpi/pc/FACS
> similarity index 100%
> rename from tests/acpi-test-data/pc/FACS
> rename to tests/data/acpi/pc/FACS
> diff --git a/tests/acpi-test-data/pc/HPET b/tests/data/acpi/pc/HPET
> similarity index 100%
> rename from tests/acpi-test-data/pc/HPET
> rename to tests/data/acpi/pc/HPET
> diff --git a/tests/acpi-test-data/pc/NFIT.dimmpxm b/tests/data/acpi/pc/NFIT.dimmpxm
> similarity index 100%
> rename from tests/acpi-test-data/pc/NFIT.dimmpxm
> rename to tests/data/acpi/pc/NFIT.dimmpxm
> diff --git a/tests/acpi-test-data/pc/SLIT.cphp b/tests/data/acpi/pc/SLIT.cphp
> similarity index 100%
> rename from tests/acpi-test-data/pc/SLIT.cphp
> rename to tests/data/acpi/pc/SLIT.cphp
> diff --git a/tests/acpi-test-data/pc/SLIT.memhp b/tests/data/acpi/pc/SLIT.memhp
> similarity index 100%
> rename from tests/acpi-test-data/pc/SLIT.memhp
> rename to tests/data/acpi/pc/SLIT.memhp
> diff --git a/tests/acpi-test-data/pc/SRAT.cphp b/tests/data/acpi/pc/SRAT.cphp
> similarity index 100%
> rename from tests/acpi-test-data/pc/SRAT.cphp
> rename to tests/data/acpi/pc/SRAT.cphp
> diff --git a/tests/acpi-test-data/pc/SRAT.dimmpxm b/tests/data/acpi/pc/SRAT.dimmpxm
> similarity index 100%
> rename from tests/acpi-test-data/pc/SRAT.dimmpxm
> rename to tests/data/acpi/pc/SRAT.dimmpxm
> diff --git a/tests/acpi-test-data/pc/SRAT.memhp b/tests/data/acpi/pc/SRAT.memhp
> similarity index 100%
> rename from tests/acpi-test-data/pc/SRAT.memhp
> rename to tests/data/acpi/pc/SRAT.memhp
> diff --git a/tests/acpi-test-data/pc/SRAT.numamem b/tests/data/acpi/pc/SRAT.numamem
> similarity index 100%
> rename from tests/acpi-test-data/pc/SRAT.numamem
> rename to tests/data/acpi/pc/SRAT.numamem
> diff --git a/tests/acpi-test-data/pc/SSDT.dimmpxm b/tests/data/acpi/pc/SSDT.dimmpxm
> similarity index 100%
> rename from tests/acpi-test-data/pc/SSDT.dimmpxm
> rename to tests/data/acpi/pc/SSDT.dimmpxm
> diff --git a/tests/acpi-test-data/q35/APIC b/tests/data/acpi/q35/APIC
> similarity index 100%
> rename from tests/acpi-test-data/q35/APIC
> rename to tests/data/acpi/q35/APIC
> diff --git a/tests/acpi-test-data/q35/APIC.cphp b/tests/data/acpi/q35/APIC.cphp
> similarity index 100%
> rename from tests/acpi-test-data/q35/APIC.cphp
> rename to tests/data/acpi/q35/APIC.cphp
> diff --git a/tests/acpi-test-data/q35/APIC.dimmpxm b/tests/data/acpi/q35/APIC.dimmpxm
> similarity index 100%
> rename from tests/acpi-test-data/q35/APIC.dimmpxm
> rename to tests/data/acpi/q35/APIC.dimmpxm
> diff --git a/tests/acpi-test-data/q35/DSDT b/tests/data/acpi/q35/DSDT
> similarity index 100%
> rename from tests/acpi-test-data/q35/DSDT
> rename to tests/data/acpi/q35/DSDT
> diff --git a/tests/acpi-test-data/q35/DSDT.bridge b/tests/data/acpi/q35/DSDT.bridge
> similarity index 100%
> rename from tests/acpi-test-data/q35/DSDT.bridge
> rename to tests/data/acpi/q35/DSDT.bridge
> diff --git a/tests/acpi-test-data/q35/DSDT.cphp b/tests/data/acpi/q35/DSDT.cphp
> similarity index 100%
> rename from tests/acpi-test-data/q35/DSDT.cphp
> rename to tests/data/acpi/q35/DSDT.cphp
> diff --git a/tests/acpi-test-data/q35/DSDT.dimmpxm b/tests/data/acpi/q35/DSDT.dimmpxm
> similarity index 100%
> rename from tests/acpi-test-data/q35/DSDT.dimmpxm
> rename to tests/data/acpi/q35/DSDT.dimmpxm
> diff --git a/tests/acpi-test-data/q35/DSDT.ipmibt b/tests/data/acpi/q35/DSDT.ipmibt
> similarity index 100%
> rename from tests/acpi-test-data/q35/DSDT.ipmibt
> rename to tests/data/acpi/q35/DSDT.ipmibt
> diff --git a/tests/acpi-test-data/q35/DSDT.memhp b/tests/data/acpi/q35/DSDT.memhp
> similarity index 100%
> rename from tests/acpi-test-data/q35/DSDT.memhp
> rename to tests/data/acpi/q35/DSDT.memhp
> diff --git a/tests/acpi-test-data/q35/DSDT.numamem b/tests/data/acpi/q35/DSDT.numamem
> similarity index 100%
> rename from tests/acpi-test-data/q35/DSDT.numamem
> rename to tests/data/acpi/q35/DSDT.numamem
> diff --git a/tests/acpi-test-data/q35/FACP b/tests/data/acpi/q35/FACP
> similarity index 100%
> rename from tests/acpi-test-data/q35/FACP
> rename to tests/data/acpi/q35/FACP
> diff --git a/tests/acpi-test-data/q35/FACS b/tests/data/acpi/q35/FACS
> similarity index 100%
> rename from tests/acpi-test-data/q35/FACS
> rename to tests/data/acpi/q35/FACS
> diff --git a/tests/acpi-test-data/q35/HPET b/tests/data/acpi/q35/HPET
> similarity index 100%
> rename from tests/acpi-test-data/q35/HPET
> rename to tests/data/acpi/q35/HPET
> diff --git a/tests/acpi-test-data/q35/MCFG b/tests/data/acpi/q35/MCFG
> similarity index 100%
> rename from tests/acpi-test-data/q35/MCFG
> rename to tests/data/acpi/q35/MCFG
> diff --git a/tests/acpi-test-data/q35/NFIT.dimmpxm b/tests/data/acpi/q35/NFIT.dimmpxm
> similarity index 100%
> rename from tests/acpi-test-data/q35/NFIT.dimmpxm
> rename to tests/data/acpi/q35/NFIT.dimmpxm
> diff --git a/tests/acpi-test-data/q35/SLIT.cphp b/tests/data/acpi/q35/SLIT.cphp
> similarity index 100%
> rename from tests/acpi-test-data/q35/SLIT.cphp
> rename to tests/data/acpi/q35/SLIT.cphp
> diff --git a/tests/acpi-test-data/q35/SLIT.memhp b/tests/data/acpi/q35/SLIT.memhp
> similarity index 100%
> rename from tests/acpi-test-data/q35/SLIT.memhp
> rename to tests/data/acpi/q35/SLIT.memhp
> diff --git a/tests/acpi-test-data/q35/SRAT.cphp b/tests/data/acpi/q35/SRAT.cphp
> similarity index 100%
> rename from tests/acpi-test-data/q35/SRAT.cphp
> rename to tests/data/acpi/q35/SRAT.cphp
> diff --git a/tests/acpi-test-data/q35/SRAT.dimmpxm b/tests/data/acpi/q35/SRAT.dimmpxm
> similarity index 100%
> rename from tests/acpi-test-data/q35/SRAT.dimmpxm
> rename to tests/data/acpi/q35/SRAT.dimmpxm
> diff --git a/tests/acpi-test-data/q35/SRAT.memhp b/tests/data/acpi/q35/SRAT.memhp
> similarity index 100%
> rename from tests/acpi-test-data/q35/SRAT.memhp
> rename to tests/data/acpi/q35/SRAT.memhp
> diff --git a/tests/acpi-test-data/q35/SRAT.numamem b/tests/data/acpi/q35/SRAT.numamem
> similarity index 100%
> rename from tests/acpi-test-data/q35/SRAT.numamem
> rename to tests/data/acpi/q35/SRAT.numamem
> diff --git a/tests/acpi-test-data/q35/SSDT.dimmpxm b/tests/data/acpi/q35/SSDT.dimmpxm
> similarity index 100%
> rename from tests/acpi-test-data/q35/SSDT.dimmpxm
> rename to tests/data/acpi/q35/SSDT.dimmpxm
> diff --git a/tests/acpi-test-data/rebuild-expected-aml.sh b/tests/data/acpi/rebuild-expected-aml.sh
> similarity index 86%
> rename from tests/acpi-test-data/rebuild-expected-aml.sh
> rename to tests/data/acpi/rebuild-expected-aml.sh
> index 11bf7439142..bf9ba242add 100755
> --- a/tests/acpi-test-data/rebuild-expected-aml.sh
> +++ b/tests/data/acpi/rebuild-expected-aml.sh
> @@ -32,5 +32,3 @@ fi
>   TEST_ACPI_REBUILD_AML=y QTEST_QEMU_BINARY=$qemu tests/bios-tables-test
>   
>   echo "The files were rebuilt and can be added to git."
> -echo "However, if new files were created, please copy them manually" \
> -     "to tests/acpi-test-data/pc/ or tests/acpi-test-data/q35/ ."
>
