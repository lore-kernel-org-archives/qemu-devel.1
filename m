Received: from eggs.gnu.org ([2001:4830:134:3::10]:59215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ewP4r-0007jh-C1
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 05:21:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ewP4p-0005NC-TV
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 05:21:37 -0400
Date: Thu, 15 Mar 2018 09:21:10 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180315092110.GD3146@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1521100145-15304-1-git-send-email-thuth@redhat.com>
	<1521100145-15304-3-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1521100145-15304-3-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] tests/cdboot: Test booting from CD-ROM
 ISO image file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Victor Kaplansky <victork@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-s390x@nongnu.org, =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>

On Thu, Mar 15, 2018 at 08:49:04AM +0100, Thomas Huth wrote:
> We already have the code for a boot file in tests/boot-sector.c,
> so if the genisoimage program is available, we can easily create
> a bootable CD ISO image that we can use for testing whether our
> CD-ROM emulation and the BIOS CD-ROM boot works correctly.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/Makefile.include |   3 +
>  tests/cdrom-test.c     | 155 +++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 158 insertions(+)
>  create mode 100644 tests/cdrom-test.c
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index ef9b88c..a104222 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -304,6 +304,7 @@ check-qtest-i386-$(CONFIG_POSIX) += tests/test-filter-redirector$(EXESUF)
>  check-qtest-i386-y += tests/migration-test$(EXESUF)
>  check-qtest-i386-y += tests/test-x86-cpuid-compat$(EXESUF)
>  check-qtest-i386-y += tests/numa-test$(EXESUF)
> +check-qtest-i386-y += tests/cdrom-test$(EXESUF)
>  check-qtest-x86_64-y += $(check-qtest-i386-y)
>  check-qtest-x86_64-y += tests/sdhci-test$(EXESUF)
>  gcov-files-i386-y += i386-softmmu/hw/timer/mc146818rtc.c
> @@ -398,6 +399,7 @@ check-qtest-s390x-y += tests/virtio-balloon-test$(EXESUF)
>  check-qtest-s390x-y += tests/virtio-console-test$(EXESUF)
>  check-qtest-s390x-y += tests/virtio-serial-test$(EXESUF)
>  check-qtest-s390x-y += tests/cpu-plug-test$(EXESUF)
> +check-qtest-s390x-y += tests/cdrom-test$(EXESUF)
>  
>  check-qtest-generic-y += tests/qom-test$(EXESUF)
>  check-qtest-generic-y += tests/test-hmp$(EXESUF)
> @@ -829,6 +831,7 @@ tests/test-qapi-util$(EXESUF): tests/test-qapi-util.o $(test-util-obj-y)
>  tests/numa-test$(EXESUF): tests/numa-test.o
>  tests/vmgenid-test$(EXESUF): tests/vmgenid-test.o tests/boot-sector.o tests/acpi-utils.o
>  tests/sdhci-test$(EXESUF): tests/sdhci-test.o $(libqos-pc-obj-y)
> +tests/cdrom-test$(EXESUF): tests/cdrom-test.o tests/boot-sector.o $(libqos-obj-y)
>  
>  tests/migration/stress$(EXESUF): tests/migration/stress.o
>  	$(call quiet-command, $(LINKPROG) -static -O3 $(PTHREAD_LIB) -o $@ $< ,"LINK","$(TARGET_DIR)$@")
> diff --git a/tests/cdrom-test.c b/tests/cdrom-test.c
> new file mode 100644
> index 0000000..1fc5230
> --- /dev/null
> +++ b/tests/cdrom-test.c
> @@ -0,0 +1,155 @@
> +/*
> + * Various tests for emulated CD-ROM drives.
> + *
> + * Copyright (c) 2018 Red Hat Inc.
> + *
> + * Author:
> + *    Thomas Huth <thuth@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2
> + * or later. See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest.h"
> +#include "boot-sector.h"
> +
> +static char isoimage[] = "cdrom-boot-iso-XXXXXX";
> +
> +static int gen_iso(const char *fmt, ...)
> +{
> +    char *params, *command;
> +    va_list args;
> +    pid_t pid;
> +    int status;
> +
> +    pid = fork();
> +    if (pid == 0) {
> +        va_start(args, fmt);
> +        params = g_strdup_vprintf(fmt, args);
> +        va_end(args);
> +        command = g_strdup_printf("exec genisoimage %s", params);
> +        g_free(params);
> +        execlp("/bin/sh", "sh", "-c", command, NULL);
> +        exit(1);
> +    }
> +    wait(&status);

IMHO this should just use g_spawn_sync(), also the use of
shell seems rather unneccessary - why not just run genisoimage
directly ?

  https://developer.gnome.org/glib/stable/glib-Spawning-Processes.html#g-spawn-sync

> +
> +    return WEXITSTATUS(status);
> +}
> +
> +static int prepare_image(const char *arch, char *isoimage)
> +{
> +    char srcdir[] = "cdrom-test-dir-XXXXXX";
> +    char *codefile = NULL;
> +    int ifh, ret = -1;
> +
> +    ifh = mkstemp(isoimage);
> +    if (ifh < 0) {
> +        perror("Error creating temporary iso image file");
> +        return -1;
> +    }
> +    if (!mkdtemp(srcdir)) {
> +        perror("Error creating temporary directory");
> +        goto cleanup;
> +    }
> +
> +    if (g_str_equal(arch, "i386") || g_str_equal(arch, "x86_64") ||
> +        g_str_equal(arch, "s390x")) {
> +        codefile = g_strdup_printf("%s/bootcode-XXXXXX", srcdir);
> +        ret = boot_sector_init(codefile);
> +        if (ret) {
> +            goto cleanup;
> +        }
> +    } else {
> +        g_assert_not_reached();
> +    }
> +
> +    ret = gen_iso("-quiet -l -no-emul-boot -b %s -o %s %s",
> +                  strrchr(codefile, '/') + 1, isoimage, srcdir);

It would be easy to just declare the args as an array here

  char *genisoargv[] = {
    "genisoimage", "-quiet", "-l", "-no-emul-boot", "-b",
    strrchr(codefile, "/") + 1, "-o", isoimage, srcdir,
    NULL,
  };

to then pass to g_spawn_sync

> +    if (ret) {
> +        fprintf(stderr, "genisoimage failed: %i\n", ret);
> +    }
> +
> +    unlink(codefile);
> +
> +cleanup:
> +    g_free(codefile);
> +    rmdir(srcdir);
> +    close(ifh);
> +
> +    return ret;
> +}

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
