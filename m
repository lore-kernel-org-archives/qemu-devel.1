Received: from eggs.gnu.org ([2001:4830:134:3::10]:52915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fpQmF-0000Te-Ue
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 00:17:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fpQmE-0000VL-MA
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 00:17:51 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180813184624.12071-1-stefanha@redhat.com>
	<20180813184624.12071-7-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <012316fe-edc8-689a-b328-d84e2268a7e4@amsat.org>
Date: Tue, 14 Aug 2018 01:17:33 -0300
MIME-Version: 1.0
In-Reply-To: <20180813184624.12071-7-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v5 6/6] Add QTest testcase for
 the Intel Hexadecimal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, jim@groklearning.com, mail@steffen-goertz.de, Su Hang <suhang16@mails.ucas.ac.cn>, ilg@livius.net, Alistair Francis <alistair@alistair23.me>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Steffen Gortz <qemu.ml@steffen-goertz.de>, qemu-arm@nongnu.org, joel@jms.id.au, jusual@mail.ru

Hi Su, Stefan,

On 08/13/2018 03:46 PM, Stefan Hajnoczi wrote:
> From: Su Hang <suhang16@mails.ucas.ac.cn>
> 
> 'test.hex' file is a memory test pattern stored in Hexadecimal Object
> Format.  It loads at 0x10000 in RAM and contains values from 0 through
> 255.

Please add this comment in the source file.

> 
> The test case verifies that the expected memory test pattern was loaded.
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Suggested-by: Steffen Gortz <qemu.ml@steffen-goertz.de>
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Su Hang <suhang16@mails.ucas.ac.cn>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  MAINTAINERS                          |  6 ++++
>  configure                            |  4 +++
>  tests/Makefile.include               |  2 ++
>  tests/hexloader-test.c               | 41 ++++++++++++++++++++++++++++
>  tests/hex-loader-check-data/test.hex | 18 ++++++++++++
>  5 files changed, 71 insertions(+)
>  create mode 100644 tests/hexloader-test.c
>  create mode 100644 tests/hex-loader-check-data/test.hex
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 666e936812..c48d9271cf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1323,6 +1323,12 @@ F: hw/core/generic-loader.c
>  F: include/hw/core/generic-loader.h
>  F: docs/generic-loader.txt
>  
> +Intel Hexadecimal Object File Loader
> +M: Su Hang <suhang16@mails.ucas.ac.cn>
> +S: Maintained
> +F: tests/hexloader-test.c
> +F: tests/hex-loader-check-data/test.hex
> +
>  CHRP NVRAM
>  M: Thomas Huth <thuth@redhat.com>
>  S: Maintained
> diff --git a/configure b/configure
> index 2a7796ea80..db97930314 100755
> --- a/configure
> +++ b/configure
> @@ -7382,6 +7382,10 @@ for test_file in $(find $source_path/tests/acpi-test-data -type f)
>  do
>      FILES="$FILES tests/acpi-test-data$(echo $test_file | sed -e 's/.*acpi-test-data//')"
>  done
> +for test_file in $(find $source_path/tests/hex-loader-check-data -type f)
> +do
> +    FILES="$FILES tests/hex-loader-check-data$(echo $test_file | sed -e 's/.*hex-loader-check-data//')"
> +done
>  mkdir -p $DIRS
>  for f in $FILES ; do
>      if [ -e "$source_path/$f" ] && [ "$pwd_is_source_path" != "y" ]; then
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index a49282704e..760a0f18b6 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -386,6 +386,7 @@ check-qtest-arm-y += tests/test-arm-mptimer$(EXESUF)
>  gcov-files-arm-y += hw/timer/arm_mptimer.c
>  check-qtest-arm-y += tests/boot-serial-test$(EXESUF)
>  check-qtest-arm-y += tests/sdhci-test$(EXESUF)
> +check-qtest-arm-y += tests/hexloader-test$(EXESUF)
>  
>  check-qtest-aarch64-y = tests/numa-test$(EXESUF)
>  check-qtest-aarch64-y += tests/sdhci-test$(EXESUF)
> @@ -773,6 +774,7 @@ tests/qmp-test$(EXESUF): tests/qmp-test.o
>  tests/device-introspect-test$(EXESUF): tests/device-introspect-test.o
>  tests/rtc-test$(EXESUF): tests/rtc-test.o
>  tests/m48t59-test$(EXESUF): tests/m48t59-test.o
> +tests/hexloader-test$(EXESUF): tests/hexloader-test.o
>  tests/endianness-test$(EXESUF): tests/endianness-test.o
>  tests/spapr-phb-test$(EXESUF): tests/spapr-phb-test.o $(libqos-obj-y)
>  tests/prom-env-test$(EXESUF): tests/prom-env-test.o $(libqos-obj-y)
> diff --git a/tests/hexloader-test.c b/tests/hexloader-test.c
> new file mode 100644
> index 0000000000..90e470e9db
> --- /dev/null
> +++ b/tests/hexloader-test.c
> @@ -0,0 +1,41 @@
> +/*
> + * QTest testcase for the Intel Hexadecimal Object File Loader
> + *
> + * Authors:
> + *  Su Hang <suhang16@mails.ucas.ac.cn> 2018
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest.h"
> +
> +/* success if no crash or abort */

 ... 'test.hex' file is a memory test pattern stored in Hexadecimal
Object Format.  It loads at 0x10000 in RAM and contains values from 0
through 255.

Funny =)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +static void hex_loader_test(void)
> +{
> +    unsigned int i;
> +    const unsigned int base_addr = 0x00010000;
> +
> +    QTestState *s = qtest_startf(
> +        "-M vexpress-a9 -nographic -device loader,file=tests/hex-loader-check-data/test.hex");
> +
> +    for (i = 0; i < 256; ++i) {
> +        uint8_t val = qtest_readb(s, base_addr + i);
> +        g_assert_cmpuint(i, ==, val);
> +    }
> +    qtest_quit(s);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    int ret;
> +
> +    g_test_init(&argc, &argv, NULL);
> +
> +    qtest_add_func("/tmp/hex_loader", hex_loader_test);
> +    ret = g_test_run();
> +
> +    return ret;
> +}
> diff --git a/tests/hex-loader-check-data/test.hex b/tests/hex-loader-check-data/test.hex
> new file mode 100644
> index 0000000000..008a90bd4d
> --- /dev/null
> +++ b/tests/hex-loader-check-data/test.hex
> @@ -0,0 +1,18 @@
> +:020000040001F9
> +:10000000000102030405060708090a0b0c0d0e0f78
> +:10001000101112131415161718191a1b1c1d1e1f68
> +:10002000202122232425262728292a2b2c2d2e2f58
> +:10003000303132333435363738393a3b3c3d3e3f48
> +:10004000404142434445464748494a4b4c4d4e4f38
> +:10005000505152535455565758595a5b5c5d5e5f28
> +:10006000606162636465666768696a6b6c6d6e6f18
> +:10007000707172737475767778797a7b7c7d7e7f08
> +:10008000808182838485868788898a8b8c8d8e8ff8
> +:10009000909192939495969798999a9b9c9d9e9fe8
> +:1000a000a0a1a2a3a4a5a6a7a8a9aaabacadaeafd8
> +:1000b000b0b1b2b3b4b5b6b7b8b9babbbcbdbebfc8
> +:1000c000c0c1c2c3c4c5c6c7c8c9cacbcccdcecfb8
> +:1000d000d0d1d2d3d4d5d6d7d8d9dadbdcdddedfa8
> +:1000e000e0e1e2e3e4e5e6e7e8e9eaebecedeeef98
> +:1000f000f0f1f2f3f4f5f6f7f8f9fafbfcfdfeff88
> +:00000001FF
> 
