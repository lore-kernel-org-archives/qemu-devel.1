Received: from eggs.gnu.org ([2001:4830:134:3::10]:58680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g0T9s-0001BB-WC
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 11:03:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g0T9n-0005YK-4K
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 11:03:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1g0T9m-0005Wz-Bi
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 11:03:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E7EF861463
	for <qemu-devel@nongnu.org>; Thu, 13 Sep 2018 15:03:43 +0000 (UTC)
References: <20180913125343.10912-1-quintela@redhat.com>
	<20180913125343.10912-13-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <fb0a524f-81d0-cfdf-81d2-887c89272805@redhat.com>
Date: Thu, 13 Sep 2018 17:03:37 +0200
MIME-Version: 1.0
In-Reply-To: <20180913125343.10912-13-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 12/12] tests/migration: Enable the migration
 test on s390x, too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On 2018-09-13 14:53, Juan Quintela wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> We can re-use the s390-ccw bios code to implement a small firmware
> for a s390x guest which prints out the "A" and "B" characters and
> modifies the memory, as required for the migration test.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <1535027120-26187-1-git-send-email-thuth@redhat.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Acked-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> 
> ---
> 
> - Updated to new cross compiler Makefile
> - Rename s390x-a-b-elf to s390x-elf.  This way it is consistent with
>   than aarch64
> - Change generated comment
> ---
>  tests/Makefile.include           |   1 +
>  tests/migration-test.c           |  26 ++
>  tests/migration/Makefile         |   2 +-
>  tests/migration/migration-test.h |   4 +
>  tests/migration/s390x/Makefile   |  22 ++
>  tests/migration/s390x/a-b-bios.c |  35 +++
>  tests/migration/s390x/a-b-bios.h | 427 +++++++++++++++++++++++++++++++
>  7 files changed, 516 insertions(+), 1 deletion(-)
>  create mode 100644 tests/migration/s390x/Makefile
>  create mode 100644 tests/migration/s390x/a-b-bios.c
>  create mode 100644 tests/migration/s390x/a-b-bios.h
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index fab8fb9c27..bd38d14692 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -404,6 +404,7 @@ check-qtest-s390x-$(CONFIG_POSIX) += tests/test-filter-redirector$(EXESUF)
>  check-qtest-s390x-y += tests/drive_del-test$(EXESUF)
>  check-qtest-s390x-y += tests/virtio-ccw-test$(EXESUF)
>  check-qtest-s390x-y += tests/cpu-plug-test$(EXESUF)
> +check-qtest-s390x-y += tests/migration-test$(EXESUF)
>  
>  check-qtest-generic-y += tests/machine-none-test$(EXESUF)
>  check-qtest-generic-y += tests/qom-test$(EXESUF)
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index ecfae0be82..ab5b6af3f0 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -96,6 +96,18 @@ static void init_bootfile(const char *bootpath, void *content)
>      fclose(bootfile);
>  }
>  
> +#include "tests/migration/s390x/a-b-bios.h"
> +
> +static void init_bootfile_s390x(const char *bootpath)
> +{
> +    FILE *bootfile = fopen(bootpath, "wb");
> +    size_t len = sizeof(s390x_elf);
> +
> +    g_assert_cmpint(fwrite(s390x_elf, len, 1, bootfile), ==, 1);
> +    fclose(bootfile);
> +}
> +
> +
>  /*
>   * Wait for some output in the serial output file,
>   * we get an 'A' followed by an endless string of 'B's
> @@ -478,6 +490,20 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>          end_address = ARM_TEST_MEM_END;
>  
>          g_assert(sizeof(aarch64_kernel) <= ARM_TEST_MAX_KERNEL_SIZE);
> +    } else if (g_str_equal(arch, "s390x")) {
> +        init_bootfile_s390x(bootpath);
> +        cmd_src = g_strdup_printf("-machine accel=%s -m 128M"
> +                                  " -name source,debug-threads=on"
> +                                  " -serial file:%s/src_serial -bios %s",
> +                                  accel, tmpfs, bootpath);
> +        cmd_dst = g_strdup_printf("-machine accel=%s -m 128M"
> +                                  " -name target,debug-threads=on"
> +                                  " -serial file:%s/dest_serial -bios %s"
> +                                  " -incoming %s",
> +                                  accel, tmpfs, bootpath, uri);
> +
> +        start_address = S390_TEST_MEM_START;
> +        end_address = S390_TEST_MEM_END;
>      } else {
>          g_assert_not_reached();
>      }
> diff --git a/tests/migration/Makefile b/tests/migration/Makefile
> index 91237a84d9..ff726ed7dd 100644
> --- a/tests/migration/Makefile
> +++ b/tests/migration/Makefile
> @@ -5,7 +5,7 @@
>  # See the COPYING file in the top-level directory.
>  #
>  
> -TARGET_LIST = i386 aarch64
> +TARGET_LIST = i386 aarch64 s390x
>  
>  SRC_PATH = ../..
>  
> diff --git a/tests/migration/migration-test.h b/tests/migration/migration-test.h
> index 6939a134c2..e6f7636567 100644
> --- a/tests/migration/migration-test.h
> +++ b/tests/migration/migration-test.h
> @@ -27,4 +27,8 @@
>   */
>  #define ARM_TEST_MAX_KERNEL_SIZE (512 * 1024)
>  
> +/* S390 */
> +#define S390_TEST_MEM_START (1 * 1024 * 1024)
> +#define S390_TEST_MEM_END   (100 * 1024 * 1024)
> +
>  #endif /* _TEST_MIGRATION_H_ */
> diff --git a/tests/migration/s390x/Makefile b/tests/migration/s390x/Makefile
> new file mode 100644
> index 0000000000..f83ece21ff
> --- /dev/null
> +++ b/tests/migration/s390x/Makefile
> @@ -0,0 +1,22 @@
> +# To specify cross compiler prefix, use CROSS_PREFIX=
> +#   $ make CROSS_PREFIX=s390x-linux-gnu-
> +
> +.PHONY: all clean
> +all: a-b-bios.h
> +fwdir=../../../pc-bios/s390-ccw
> +
> +CFLAGS+=-ffreestanding -fno-delete-null-pointer-checks -fPIE -Os \
> +        -msoft-float -march=z900 -fno-asynchronous-unwind-tables -Wl,-pie \
> +        -Wl,--build-id=none -nostdlib
> +
> +a-b-bios.h: s390x.elf
> +	echo "$$__note" > header.tmp
> +	xxd -i $< | sed -e 's/.*int.*//' >> header.tmp
> +	mv header.tmp $@
> +
> +s390x.elf: a-b-bios.c
> +	$(CROSS_PREFIX)gcc $(CFLAGS) -I$(fwdir) $(fwdir)/start.S \
> +            $(fwdir)/sclp.c -o $@ $<

Your modifications look basically fine to me, but please also strip the
binary after compiling it, so that the header will be quite a bit smaller.

 Thanks,
  Thomas
