Received: from eggs.gnu.org ([2001:4830:134:3::10]:60035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dzisF-0000zO-U7
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 08:34:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dzisD-0005GO-TS
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 08:34:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54980)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dzisD-0005EU-LQ
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 08:34:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 86D3C7F40F
	for <qemu-devel@nongnu.org>; Wed,  4 Oct 2017 12:34:00 +0000 (UTC)
References: <20171004103933.7898-1-quintela@redhat.com>
	<20171004103933.7898-2-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <18ba5f7e-0d7e-fc5e-6cff-36ede10233f0@redhat.com>
Date: Wed, 4 Oct 2017 14:33:55 +0200
MIME-Version: 1.0
In-Reply-To: <20171004103933.7898-2-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/6] tests: Add basic migration precopy test
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

On 04.10.2017 12:39, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  tests/Makefile.include |   3 +
>  tests/migration-test.c | 497 +++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 500 insertions(+)
>  create mode 100644 tests/migration-test.c
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index abc6707ef2..d23ca1ed1c 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -287,6 +287,7 @@ endif
>  check-qtest-i386-$(CONFIG_SLIRP) += tests/test-netfilter$(EXESUF)
>  check-qtest-i386-$(CONFIG_POSIX) += tests/test-filter-mirror$(EXESUF)
>  check-qtest-i386-$(CONFIG_POSIX) += tests/test-filter-redirector$(EXESUF)
> +check-qtest-i386-y += tests/migration-test$(EXESUF)
>  check-qtest-i386-y += tests/postcopy-test$(EXESUF)
>  check-qtest-i386-y += tests/test-x86-cpuid-compat$(EXESUF)
>  check-qtest-i386-y += tests/numa-test$(EXESUF)
> @@ -316,6 +317,7 @@ check-qtest-ppc64-y += tests/prom-env-test$(EXESUF)
>  check-qtest-ppc64-y += tests/pnv-xscom-test$(EXESUF)
>  check-qtest-ppc64-y += tests/drive_del-test$(EXESUF)
>  check-qtest-ppc64-y += tests/postcopy-test$(EXESUF)
> +check-qtest-ppc64-y += tests/migration-test$(EXESUF)
>  check-qtest-ppc64-y += tests/boot-serial-test$(EXESUF)
>  check-qtest-ppc64-y += tests/rtas-test$(EXESUF)
>  check-qtest-ppc64-$(CONFIG_SLIRP) += tests/pxe-test$(EXESUF)
> @@ -782,6 +784,7 @@ tests/usb-hcd-ehci-test$(EXESUF): tests/usb-hcd-ehci-test.o $(libqos-usb-obj-y)
>  tests/usb-hcd-xhci-test$(EXESUF): tests/usb-hcd-xhci-test.o $(libqos-usb-obj-y)
>  tests/pc-cpu-test$(EXESUF): tests/pc-cpu-test.o
>  tests/postcopy-test$(EXESUF): tests/postcopy-test.o
> +tests/migration-test$(EXESUF): tests/migration-test.o
>  tests/vhost-user-test$(EXESUF): tests/vhost-user-test.o $(test-util-obj-y) \
>  	$(qtest-obj-y) $(test-io-obj-y) $(libqos-virtio-obj-y) $(libqos-pc-obj-y) \
>  	$(chardev-obj-y)
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> new file mode 100644
> index 0000000000..cd954caee4
> --- /dev/null
> +++ b/tests/migration-test.c
> @@ -0,0 +1,497 @@
> +/*
> + * QTest testcases for migration
> + *
> + * Copyright (c) 2017 Red Hat, Inc. and/or its affiliates
> + *   based on the postcopy-test.c which is based
> + *   based on the vhost-user-test.c that is:
> + *      Copyright (c) 2014 Virtual Open Systems Sarl.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "libqtest.h"
> +#include "qemu/option.h"
> +#include "qemu/range.h"
> +#include "qemu/sockets.h"
> +#include "chardev/char.h"
> +#include "sysemu/sysemu.h"
> +#include "hw/nvram/chrp_nvram.h"
> +
> +#define MIN_NVRAM_SIZE 8192 /* from spapr_nvram.c */
> +
> +const unsigned start_address = 1024 * 1024;
> +const unsigned end_address = 100 * 1024 * 1024;
> +bool got_stop;
> +
> +#if defined(__linux__)
> +#include <sys/syscall.h>
> +#include <sys/vfs.h>
> +#endif
> +
> +static const char *tmpfs;
> +
> +/* A simple PC boot sector that modifies memory (1-100MB) quickly
> + * outputing a 'B' every so often if it's still running.
> + */
> +unsigned char bootsect[] = {
> +  0xfa, 0x0f, 0x01, 0x16, 0x74, 0x7c, 0x66, 0xb8, 0x01, 0x00, 0x00, 0x00,
> +  0x0f, 0x22, 0xc0, 0x66, 0xea, 0x20, 0x7c, 0x00, 0x00, 0x08, 0x00, 0x00,
> +  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xe4, 0x92, 0x0c, 0x02,
> +  0xe6, 0x92, 0xb8, 0x10, 0x00, 0x00, 0x00, 0x8e, 0xd8, 0x66, 0xb8, 0x41,
> +  0x00, 0x66, 0xba, 0xf8, 0x03, 0xee, 0xb3, 0x00, 0xb8, 0x00, 0x00, 0x10,
> +  0x00, 0xfe, 0x00, 0x05, 0x00, 0x10, 0x00, 0x00, 0x3d, 0x00, 0x00, 0x40,
> +  0x06, 0x7c, 0xf2, 0xfe, 0xc3, 0x75, 0xe9, 0x66, 0xb8, 0x42, 0x00, 0x66,
> +  0xba, 0xf8, 0x03, 0xee, 0xeb, 0xde, 0x66, 0x90, 0x00, 0x00, 0x00, 0x00,
> +  0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0x00, 0x00, 0x00, 0x9a, 0xcf, 0x00,
> +  0xff, 0xff, 0x00, 0x00, 0x00, 0x92, 0xcf, 0x00, 0x27, 0x00, 0x5c, 0x7c,
> +  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0xaa
> +};
> +
> +static void init_bootfile_x86(const char *bootpath)
> +{
> +    FILE *bootfile = fopen(bootpath, "wb");
> +
> +    g_assert_cmpint(fwrite(bootsect, 512, 1, bootfile), ==, 1);
> +    fclose(bootfile);
> +}
> +
> +static void init_bootfile_ppc(const char *bootpath)
> +{
> +    FILE *bootfile;
> +    char buf[MIN_NVRAM_SIZE];
> +    ChrpNvramPartHdr *header = (ChrpNvramPartHdr *)buf;
> +
> +    memset(buf, 0, MIN_NVRAM_SIZE);
> +
> +    /* Create a "common" partition in nvram to store boot-command property */
> +
> +    header->signature = CHRP_NVPART_SYSTEM;
> +    memcpy(header->name, "common", 6);
> +    chrp_nvram_finish_partition(header, MIN_NVRAM_SIZE);
> +
> +    /* FW_MAX_SIZE is 4MB, but slof.bin is only 900KB,
> +     * so let's modify memory between 1MB and 100MB
> +     * to do like PC bootsector
> +     */
> +
> +    sprintf(buf + 16,
> +            "boot-command=hex .\" _\" begin %x %x do i c@ 1 + i c! 1000 +loop "
> +            ".\" B\" 0 until", end_address, start_address);
> +
> +    /* Write partition to the NVRAM file */
> +
> +    bootfile = fopen(bootpath, "wb");
> +    g_assert_cmpint(fwrite(buf, MIN_NVRAM_SIZE, 1, bootfile), ==, 1);
> +    fclose(bootfile);
> +}
> +
> +/*
> + * Wait for some output in the serial output file,
> + * we get an 'A' followed by an endless string of 'B's
> + * but on the destination we won't have the A.
> + */
> +static void wait_for_serial(const char *side)
> +{
> +    char *serialpath = g_strdup_printf("%s/%s", tmpfs, side);
> +    FILE *serialfile = fopen(serialpath, "r");
> +    const char *arch = qtest_get_arch();
> +    int started = (strcmp(side, "src_serial") == 0 &&
> +                   strcmp(arch, "ppc64") == 0) ? 0 : 1;
> +
> +    g_free(serialpath);
> +    do {
> +        int readvalue = fgetc(serialfile);
> +
> +        if (!started) {
> +            /* SLOF prints its banner before starting test,
> +             * to ignore it, mark the start of the test with '_',
> +             * ignore all characters until this marker
> +             */
> +            switch (readvalue) {
> +            case '_':
> +                started = 1;
> +                break;
> +            case EOF:
> +                fseek(serialfile, 0, SEEK_SET);
> +                usleep(1000);
> +                break;
> +            }
> +            continue;
> +        }
> +        switch (readvalue) {
> +        case 'A':
> +            /* Fine */
> +            break;
> +
> +        case 'B':
> +            /* It's alive! */
> +            fclose(serialfile);
> +            return;
> +
> +        case EOF:
> +            started = (strcmp(side, "src_serial") == 0 &&
> +                       strcmp(arch, "ppc64") == 0) ? 0 : 1;
> +            fseek(serialfile, 0, SEEK_SET);
> +            usleep(1000);
> +            break;
> +
> +        default:
> +            fprintf(stderr, "Unexpected %d on %s serial\n", readvalue, side);
> +            g_assert_not_reached();
> +        }
> +    } while (true);
> +}
> +
> +/*
> + * Events can get in the way of responses we are actually waiting for.
> + */
> +static QDict *return_or_event(QDict *response, QTestState *who)
> +{
> +    const char *event_string;
> +    if (!qdict_haskey(response, "event")) {
> +        return response;
> +    }
> +
> +    /* OK, it was an event */
> +    event_string = qdict_get_str(response, "event");
> +    if (!strcmp(event_string, "STOP")) {
> +        got_stop = true;
> +    }
> +    QDECREF(response);
> +    return return_or_event(qtest_qmp_receive(who), who);
> +}
> +
> +
> +/*
> + * It's tricky to use qemu's migration event capability with qtest,
> + * events suddenly appearing confuse the qmp()/hmp() responses.
> + * so wait for a couple of passes to have happened before
> + * going postcopy.
> + */
> +
> +static uint64_t get_migration_pass(QTestState *who)
> +{
> +    QDict *rsp, *rsp_return, *rsp_ram;
> +    uint64_t result;
> +
> +    rsp = return_or_event(qmp("{ 'execute': 'query-migrate' }"), who);
> +    rsp_return = qdict_get_qdict(rsp, "return");
> +    if (!qdict_haskey(rsp_return, "ram")) {
> +        /* Still in setup */
> +        result = 0;
> +    } else {
> +        rsp_ram = qdict_get_qdict(rsp_return, "ram");
> +        result = qdict_get_try_int(rsp_ram, "dirty-sync-count", 0);
> +    }
> +    QDECREF(rsp);
> +    return result;
> +}
> +
> +static void wait_for_migration_complete(QTestState *who)
> +{
> +    bool completed;
> +
> +    do {
> +        QDict *rsp, *rsp_return;
> +        const char *status;
> +
> +        rsp = return_or_event(qmp("{ 'execute': 'query-migrate' }"), who);
> +        rsp_return = qdict_get_qdict(rsp, "return");
> +        status = qdict_get_str(rsp_return, "status");
> +        completed = strcmp(status, "completed") == 0;
> +        g_assert_cmpstr(status, !=,  "failed");
> +        QDECREF(rsp);
> +        usleep(1000 * 100);
> +    } while (!completed);
> +}
> +
> +static void wait_for_migration_pass(QTestState *who)
> +{
> +    uint64_t initial_pass = get_migration_pass(who);
> +    uint64_t pass;
> +
> +    /* Wait for the 1st sync */
> +    do {
> +        initial_pass = get_migration_pass(who);
> +        if (got_stop || initial_pass) {
> +            break;
> +        }
> +        usleep(1000 * 100);
> +    } while (true);
> +
> +    do {
> +        usleep(1000 * 100);
> +        pass = get_migration_pass(who);
> +    } while (pass == initial_pass && !got_stop);
> +}
> +
> +static void check_guests_ram(QTestState *who)
> +{
> +    /* Our ASM test will have been incrementing one byte from each page from
> +     * 1MB to <100MB in order.
> +     * This gives us a constraint that any page's byte should be equal or less
> +     * than the previous pages byte (mod 256); and they should all be equal
> +     * except for one transition at the point where we meet the incrementer.
> +     * (We're running this with the guest stopped).
> +     */
> +    unsigned address;
> +    uint8_t first_byte;
> +    uint8_t last_byte;
> +    bool hit_edge = false;
> +    bool bad = false;
> +
> +    qtest_memread(who, start_address, &first_byte, 1);
> +    last_byte = first_byte;
> +
> +    for (address = start_address + 4096; address < end_address; address += 4096)
> +    {
> +        uint8_t b;
> +        qtest_memread(who, address, &b, 1);
> +        if (b != last_byte) {
> +            if (((b + 1) % 256) == last_byte && !hit_edge) {
> +                /* This is OK, the guest stopped at the point of
> +                 * incrementing the previous page but didn't get
> +                 * to us yet.
> +                 */
> +                hit_edge = true;
> +            } else {
> +                fprintf(stderr, "Memory content inconsistency at %x"
> +                                " first_byte = %x last_byte = %x current = %x"
> +                                " hit_edge = %x\n",
> +                                address, first_byte, last_byte, b, hit_edge);
> +                bad = true;
> +            }
> +        }
> +        last_byte = b;
> +    }
> +    g_assert_false(bad);
> +}
> +
> +static void cleanup(const char *filename)
> +{
> +    char *path = g_strdup_printf("%s/%s", tmpfs, filename);
> +
> +    unlink(path);
> +    g_free(path);
> +}

Looks like a lot of this code is the same or very similar to the code in
postcopy-test.c ... would it make sense to factor-out that code there
into a separate file that could be used by both tests, so that we do not
have to maintain the code twice?

 Thomas
