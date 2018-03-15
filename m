Received: from eggs.gnu.org ([2001:4830:134:3::10]:45436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ewRHs-0008MW-C6
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 07:43:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ewRHr-0005Tz-3b
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 07:43:12 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1521100145-15304-1-git-send-email-thuth@redhat.com>
	<1521100145-15304-4-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <dcb8eab2-ab81-91d5-5a4e-6d666eb8e98c@amsat.org>
Date: Thu, 15 Mar 2018 12:42:53 +0100
MIME-Version: 1.0
In-Reply-To: <1521100145-15304-4-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/3] tests/cdrom-test: Test that -cdrom
 parameter is working
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Victor Kaplansky <victork@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-s390x@nongnu.org, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>

Hi Thomas,

On 03/15/2018 08:49 AM, Thomas Huth wrote:
> Commit 1454509726719e0933c800 recently broke the "-cdrom" parameter
> on a couple of boards without that we noticed it immediately. Thus
> add a test which checks that "-cdrom" can at least be used to start
> QEMU with certain machine types.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/Makefile.include |  7 +++++-
>  tests/cdrom-test.c     | 63 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 68 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index a104222..b744fea 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -321,8 +321,9 @@ check-qtest-microblaze-y = tests/boot-serial-test$(EXESUF)
>  check-qtest-mips-y = tests/endianness-test$(EXESUF)
>  
>  check-qtest-mips64-y = tests/endianness-test$(EXESUF)
> +check-qtest-mips64-y += tests/cdrom-test$(EXESUF)
>  
> -check-qtest-mips64el-y = tests/endianness-test$(EXESUF)
> +check-qtest-mips64el-y = $(check-qtest-mips64-y)
>  
>  check-qtest-moxie-y = tests/boot-serial-test$(EXESUF)
>  
> @@ -356,6 +357,7 @@ check-qtest-ppc64-y += tests/display-vga-test$(EXESUF)
>  check-qtest-ppc64-y += tests/numa-test$(EXESUF)
>  check-qtest-ppc64-$(CONFIG_IVSHMEM) += tests/ivshmem-test$(EXESUF)
>  check-qtest-ppc64-y += tests/cpu-plug-test$(EXESUF)
> +check-qtest-ppc64-y += tests/cdrom-test$(EXESUF)
>  
>  check-qtest-sh4-y = tests/endianness-test$(EXESUF)
>  
> @@ -365,10 +367,12 @@ check-qtest-sparc-y = tests/prom-env-test$(EXESUF)
>  check-qtest-sparc-y += tests/m48t59-test$(EXESUF)
>  gcov-files-sparc-y = hw/timer/m48t59.c
>  check-qtest-sparc-y += tests/boot-serial-test$(EXESUF)
> +check-qtest-sparc-y += tests/cdrom-test$(EXESUF)
>  
>  check-qtest-sparc64-y = tests/endianness-test$(EXESUF)
>  check-qtest-sparc64-y += tests/prom-env-test$(EXESUF)
>  check-qtest-sparc64-y += tests/boot-serial-test$(EXESUF)
> +check-qtest-sparc64-y += tests/cdrom-test$(EXESUF)
>  
>  check-qtest-arm-y = tests/tmp105-test$(EXESUF)
>  check-qtest-arm-y += tests/ds1338-test$(EXESUF)
> @@ -384,6 +388,7 @@ check-qtest-arm-y += tests/sdhci-test$(EXESUF)
>  check-qtest-aarch64-y = tests/numa-test$(EXESUF)
>  check-qtest-aarch64-y += tests/sdhci-test$(EXESUF)
>  check-qtest-aarch64-y += tests/boot-serial-test$(EXESUF)
> +check-qtest-aarch64-y += tests/cdrom-test$(EXESUF)

Since you use g_str_equal(arch,), maybe this test can be added
regardless the arch in check-qtest-generic.

>  
>  check-qtest-microblazeel-y = $(check-qtest-microblaze-y)
>  
> diff --git a/tests/cdrom-test.c b/tests/cdrom-test.c
> index 1fc5230..5e516dd 100644
> --- a/tests/cdrom-test.c
> +++ b/tests/cdrom-test.c
> @@ -13,6 +13,7 @@
>  #include "qemu/osdep.h"
>  #include "libqtest.h"
>  #include "boot-sector.h"
> +#include "qapi/qmp/qdict.h"
>  
>  static char isoimage[] = "cdrom-boot-iso-XXXXXX";
>  
> @@ -62,7 +63,13 @@ static int prepare_image(const char *arch, char *isoimage)
>              goto cleanup;
>          }
>      } else {
> -        g_assert_not_reached();
> +        /* Just create a dummy file */
> +        char txt[] = "empty disc";
> +        codefile = g_strdup_printf("%s/readme.txt", srcdir);
> +        if (!g_file_set_contents(codefile, txt, sizeof(txt) - 1, NULL)) {
> +            fprintf(stderr, "Failed to create '%s'\n", codefile);
> +            goto cleanup;
> +        }
>      }
>  
>      ret = gen_iso("-quiet -l -no-emul-boot -b %s -o %s %s",
> @@ -81,6 +88,32 @@ cleanup:
>      return ret;
>  }
>  
> +/**
> + * Check that at least the -cdrom parameter is basically working, i.e. we can
> + * see the filename of the ISO image in the output of "info block" afterwards
> + */
> +static void test_cdrom_param(gconstpointer data)
> +{
> +    QTestState *qts;
> +    char *resp;
> +
> +    qts = qtest_startf("-M %s -cdrom %s", (const char *)data, isoimage);
> +    resp = qtest_hmp(qts, "info block");
> +    g_assert(strstr(resp, isoimage) != 0);
> +    g_free(resp);
> +    qtest_quit(qts);
> +}
> +
> +static void add_cdrom_param_tests(const char **machines)
> +{
> +    while (*machines) {
> +        char *testname = g_strdup_printf("cdrom/param/%s", *machines);
> +        qtest_add_data_func(testname, *machines, test_cdrom_param);
> +        g_free(testname);
> +        machines++;
> +    }
> +}
> +
>  static void test_cdboot(gconstpointer data)
>  {
>      QTestState *qts;
> @@ -145,6 +178,34 @@ int main(int argc, char **argv)
>          add_x86_tests();
>      } else if (g_str_equal(arch, "s390x")) {
>          add_s390x_tests();
> +    } else if (g_str_equal(arch, "ppc64")) {
> +        const char *ppcmachines[] = {
> +            "pseries", "mac99", "g3beige", "40p", "prep", NULL
> +        };
> +        add_cdrom_param_tests(ppcmachines);
> +    } else if (g_str_equal(arch, "sparc")) {
> +        const char *sparcmachines[] = {
> +            "LX", "SPARCClassic", "SPARCbook", "SS-10", "SS-20", "SS-4",
> +            "SS-5", "SS-600MP", "Voyager", "leon3_generic", NULL
> +        };
> +        add_cdrom_param_tests(sparcmachines);
> +    } else if (g_str_equal(arch, "sparc64")) {
> +        const char *sparc64machines[] = {
> +            "niagara", "sun4u", "sun4v", NULL
> +        };
> +        add_cdrom_param_tests(sparc64machines);
> +    } else if (!strncmp(arch, "mips64", 6)) {
> +        const char *mips64machines[] = {
> +            "magnum", "malta", "mips", "mipssim", "pica61", NULL
> +        };
> +        add_cdrom_param_tests(mips64machines);
> +    } else if (g_str_equal(arch, "aarch64")) {
> +        const char *aarch64machines[] = {
> +            "realview-eb", "realview-eb-mpcore", "realview-pb-a8",
> +            "realview-pbx-a9", "versatileab", "versatilepb", "vexpress-a15",
> +            "vexpress-a9", "virt", NULL
> +        };
> +        add_cdrom_param_tests(aarch64machines);
>      }
>  
>      ret = g_test_run();
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
