Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD51C388F2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 09:13:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEAFC222E9
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 09:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ekxH+ME/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEAFC222E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVWfR-0002y1-I1
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 05:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kVWek-0002Ue-51
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 05:13:11 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:58220)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kVWef-0006ID-8s
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 05:13:09 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09M952mo011565;
 Thu, 22 Oct 2020 09:13:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=3ix9jMCq/xC+JgLRCB8leKDAX1Sc0BEKonbfAko26fo=;
 b=ekxH+ME/9IHgMHQS3sdzYj8volcxF1w8/yc2JHsPwiI64vSCsSIEWmsuyh2lXJ7gNmid
 u0GEEcNYNsBq+0MPLjdctW953cXUhuTIXW7Nuy9zODIBEN5lfX70oNGv4FOvf9BvuRtR
 LB2A/CETdr7mUXdh2c6hH3Jq7niq7KrOUjum2KKgImiDnMU9WJ+8LkhpIBhkyXkn4Mw/
 nWC9M78Z5Kxflgt2Heg2SPoBN+JNumdkhd8uS/JrWiy4qXIrYLsbZM8g+66jX9G0G8m3
 22Fv8vfvCEgChXTRgKn/LFxlKHIHwv5FBYoxLyFfIBFCBOvyFTDqt9XqwbGsPCb1rV2z Mg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2130.oracle.com with ESMTP id 347p4b4yxh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 22 Oct 2020 09:13:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09M969BF034026;
 Thu, 22 Oct 2020 09:13:00 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 348a6qckxb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Oct 2020 09:13:00 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09M9Cweq003473;
 Thu, 22 Oct 2020 09:12:58 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 22 Oct 2020 02:12:58 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id B810E1D6D954; Thu, 22 Oct 2020 10:12:53 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
Subject: Re: [PATCH v6 02/16] fuzz: Add generic virtual-device fuzzer
In-Reply-To: <20201021210922.572955-3-alxndr@bu.edu>
References: <20201021210922.572955-1-alxndr@bu.edu>
 <20201021210922.572955-3-alxndr@bu.edu>
Date: Thu, 22 Oct 2020 10:12:53 +0100
Message-ID: <m2zh4e7hey.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9781
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 bulkscore=0 spamscore=0 adultscore=0 suspectscore=2 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010220061
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9781
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010220061
Received-SPF: pass client-ip=141.146.126.79;
 envelope-from=darren.kenny@oracle.com; helo=aserp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 04:25:28
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 f4bug@amsat.org, Alexander Bulekov <alxndr@bu.edu>, bsd@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, dimastep@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alex,

On Wednesday, 2020-10-21 at 17:09:08 -04, Alexander Bulekov wrote:
> This is a generic fuzzer designed to fuzz a virtual device's
> MemoryRegions, as long as they exist within the Memory or Port IO (if it
> exists) AddressSpaces. The fuzzer's input is interpreted into a sequence
> of qtest commands (outb, readw, etc). The interpreted commands are
> separated by a magic seaparator, which should be easy for the fuzzer to
> guess. Without ASan, the separator can be specified as a "dictionary
> value" using the -dict argument (see libFuzzer documentation).
>
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>

Just a couple of very minor nits below (spacing between functions),
which are not vital, so otherwise:

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

> ---
>  tests/qtest/fuzz/generic_fuzz.c | 512 ++++++++++++++++++++++++++++++++
>  tests/qtest/fuzz/meson.build    |   1 +
>  2 files changed, 513 insertions(+)
>  create mode 100644 tests/qtest/fuzz/generic_fuzz.c
>
> diff --git a/tests/qtest/fuzz/generic_fuzz.c b/tests/qtest/fuzz/generic_fuzz.c
> new file mode 100644
> index 0000000000..f69e9583ce
> --- /dev/null
> +++ b/tests/qtest/fuzz/generic_fuzz.c
> @@ -0,0 +1,512 @@
> +/*
> + * Generic Virtual-Device Fuzzing Target
> + *
> + * Copyright Red Hat Inc., 2020
> + *
> + * Authors:
> + *  Alexander Bulekov   <alxndr@bu.edu>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include <wordexp.h>
> +
> +#include "hw/core/cpu.h"
> +#include "tests/qtest/libqos/libqtest.h"
> +#include "fuzz.h"
> +#include "fork_fuzz.h"
> +#include "exec/address-spaces.h"
> +#include "string.h"
> +#include "exec/memory.h"
> +#include "exec/ramblock.h"
> +#include "exec/address-spaces.h"
> +#include "hw/qdev-core.h"
> +
> +/*
> + * SEPARATOR is used to separate "operations" in the fuzz input
> + */
> +#define SEPARATOR "FUZZ"
> +
> +enum cmds {
> +    OP_IN,
> +    OP_OUT,
> +    OP_READ,
> +    OP_WRITE,
> +    OP_CLOCK_STEP,
> +};
> +
> +#define DEFAULT_TIMEOUT_US 100000
> +#define USEC_IN_SEC 1000000000
> +
> +typedef struct {
> +    ram_addr_t addr;
> +    ram_addr_t size; /* The number of bytes until the end of the I/O region */
> +} address_range;
> +
> +static useconds_t timeout = DEFAULT_TIMEOUT_US;
> +
> +static bool qtest_log_enabled;
> +
> +/*
> + * List of memory regions that are children of QOM objects specified by the
> + * user for fuzzing.
> + */
> +static GHashTable *fuzzable_memoryregions;
> +
> +struct get_io_cb_info {
> +    int index;
> +    int found;
> +    address_range result;
> +};
> +
> +static int get_io_address_cb(Int128 start, Int128 size,
> +                          const MemoryRegion *mr, void *opaque) {
> +    struct get_io_cb_info *info = opaque;
> +    if (g_hash_table_lookup(fuzzable_memoryregions, mr)) {
> +        if (info->index == 0) {
> +            info->result.addr = (ram_addr_t)start;
> +            info->result.size = (ram_addr_t)size;
> +            info->found = 1;
> +            return 1;
> +        }
> +        info->index--;
> +    }
> +    return 0;
> +}
> +
> +/*
> + * Here we want to convert a fuzzer-provided [io-region-index, offset] to
> + * a physical address. To do this, we iterate over all of the matched
> + * MemoryRegions. Check whether each region exists within the particular io
> + * space. Return the absolute address of the offset within the index'th region
> + * that is a subregion of the io_space and the distance until the end of the
> + * memory region.
> + */
> +static bool get_io_address(address_range *result, AddressSpace *as,
> +                            uint8_t index,
> +                            uint32_t offset) {
> +    FlatView *view;
> +    view = as->current_map;
> +    g_assert(view);
> +    struct get_io_cb_info cb_info = {};
> +
> +    cb_info.index = index;
> +
> +    /*
> +     * Loop around the FlatView until we match "index" number of
> +     * fuzzable_memoryregions, or until we know that there are no matching
> +     * memory_regions.
> +     */
> +    do {
> +        flatview_for_each_range(view, get_io_address_cb , &cb_info);
> +    } while (cb_info.index != index && !cb_info.found);
> +
> +    *result = cb_info.result;
> +    return cb_info.found;
> +}

NIT: Add blank line here.

> +static bool get_pio_address(address_range *result,
> +                            uint8_t index, uint16_t offset)
> +{
> +    /*
> +     * PIO BARs can be set past the maximum port address (0xFFFF). Thus, result
> +     * can contain an addr that extends past the PIO space. When we pass this
> +     * address to qtest_in/qtest_out, it is cast to a uint16_t, so we might end
> +     * up fuzzing a completely different MemoryRegion/Device. Therefore, check
> +     * that the address here is within the PIO space limits.
> +     */
> +    bool found = get_io_address(result, &address_space_io, index, offset);
> +    return result->addr <= 0xFFFF ? found : false;
> +}

NIT: Add blank line here.

> +static bool get_mmio_address(address_range *result,
> +                             uint8_t index, uint32_t offset)

...

> +
> +static void op_write(QTestState *s, const unsigned char * data, size_t len)
> +{
> +    enum Sizes {Byte, Word, Long, Quad, end_sizes};
> +    struct {
> +        uint8_t size;
> +        uint8_t base;
> +        uint32_t offset;
> +        uint64_t value;
> +    } a;
> +    address_range abs;
> +
> +    if (len < sizeof(a)) {
> +        return;
> +    }
> +    memcpy(&a, data, sizeof(a));
> +
> +    if (get_mmio_address(&abs, a.base, a.offset) == 0) {
> +        return;
> +    }
> +
> +    switch (a.size %= end_sizes) {
> +    case Byte:
> +            qtest_writeb(s, abs.addr, a.value & 0xFF);
> +        break;
> +    case Word:
> +        if (abs.size >= 2) {
> +            qtest_writew(s, abs.addr, a.value & 0xFFFF);
> +        }
> +        break;
> +    case Long:
> +        if (abs.size >= 4) {
> +            qtest_writel(s, abs.addr, a.value & 0xFFFFFFFF);
> +        }
> +        break;
> +    case Quad:
> +        if (abs.size >= 8) {
> +            qtest_writeq(s, abs.addr, a.value);
> +        }
> +        break;
> +    }
> +}

NIT: Add blank line here.

> +static void op_clock_step(QTestState *s, const unsigned char *data, size_t len)
> +{
> +    qtest_clock_step_next(s);
> +}
> +
> +static void handle_timeout(int sig)
> +{
> +    if (qtest_log_enabled) {
> +        fprintf(stderr, "[Timeout]\n");
> +        fflush(stderr);
> +    }
> +    _Exit(0);
> +}
> +
> +/*
> + * Here, we interpret random bytes from the fuzzer, as a sequence of commands.
> + * Some commands can be variable-width, so we use a separator, SEPARATOR, to
> + * specify the boundaries between commands. SEPARATOR is used to separate
> + * "operations" in the fuzz input. Why use a separator, instead of just using
> + * the operations' length to identify operation boundaries?
> + *   1. This is a simple way to support variable-length operations
> + *   2. This adds "stability" to the input.
> + *      For example take the input "AbBcgDefg", where there is no separator and
> + *      Opcodes are capitalized.
> + *      Simply, by removing the first byte, we end up with a very different
> + *      sequence:
> + *      BbcGdefg...
> + *      By adding a separator, we avoid this problem:
> + *      Ab SEP Bcg SEP Defg -> B SEP Bcg SEP Defg
> + *      Since B uses two additional bytes as operands, the first "B" will be
> + *      ignored. The fuzzer actively tries to reduce inputs, so such unused
> + *      bytes are likely to be pruned, eventually.
> + *
> + *  SEPARATOR is trivial for the fuzzer to discover when using ASan. Optionally,
> + *  SEPARATOR can be manually specified as a dictionary value (see libfuzzer's
> + *  -dict), though this should not be necessary.
> + *
> + * As a result, the stream of bytes is converted into a sequence of commands.
> + * In a simplified example where SEPARATOR is 0xFF:
> + * 00 01 02 FF 03 04 05 06 FF 01 FF ...
> + * becomes this sequence of commands:
> + * 00 01 02    -> op00 (0102)   -> in (0102, 2)
> + * 03 04 05 06 -> op03 (040506) -> write (040506, 3)
> + * 01          -> op01 (-,0)    -> out (-,0)
> + * ...
> + *
> + * Note here that it is the job of the individual opcode functions to check
> + * that enough data was provided. I.e. in the last command out (,0), out needs
> + * to check that there is not enough data provided to select an address/value
> + * for the operation.
> + */
> +static void generic_fuzz(QTestState *s, const unsigned char *Data, size_t Size)
> +{
> +    void (*ops[]) (QTestState *s, const unsigned char* , size_t) = {
> +        [OP_IN]                 = op_in,
> +        [OP_OUT]                = op_out,
> +        [OP_READ]               = op_read,
> +        [OP_WRITE]              = op_write,
> +        [OP_CLOCK_STEP]         = op_clock_step,
> +    };
> +    const unsigned char *cmd = Data;
> +    const unsigned char *nextcmd;
> +    size_t cmd_len;
> +    uint8_t op;
> +
> +    if (fork() == 0) {
> +        /*
> +         * Sometimes the fuzzer will find inputs that take quite a long time to
> +         * process. Often times, these inputs do not result in new coverage.
> +         * Even if these inputs might be interesting, they can slow down the
> +         * fuzzer, overall. Set a timeout to avoid hurting performance, too much
> +         */
> +        if (timeout) {
> +            struct sigaction sact;
> +            struct itimerval timer;
> +
> +            sigemptyset(&sact.sa_mask);
> +            sact.sa_flags   = SA_NODEFER;
> +            sact.sa_handler = handle_timeout;
> +            sigaction(SIGALRM, &sact, NULL);
> +
> +            memset(&timer, 0, sizeof(timer));
> +            timer.it_value.tv_sec = timeout / USEC_IN_SEC;
> +            timer.it_value.tv_usec = timeout % USEC_IN_SEC;
> +            setitimer(ITIMER_VIRTUAL, &timer, NULL);
> +        }
> +
> +        while (cmd && Size) {
> +            /* Get the length until the next command or end of input */
> +            nextcmd = memmem(cmd, Size, SEPARATOR, strlen(SEPARATOR));
> +            cmd_len = nextcmd ? nextcmd - cmd : Size;
> +
> +            if (cmd_len > 0) {
> +                /* Interpret the first byte of the command as an opcode */
> +                op = *cmd % (sizeof(ops) / sizeof((ops)[0]));
> +                ops[op](s, cmd + 1, cmd_len - 1);
> +
> +                /* Run the main loop */
> +                flush_events(s);
> +            }
> +            /* Advance to the next command */
> +            cmd = nextcmd ? nextcmd + sizeof(SEPARATOR) - 1 : nextcmd;
> +            Size = Size - (cmd_len + sizeof(SEPARATOR) - 1);
> +        }
> +        _Exit(0);
> +    } else {
> +        flush_events(s);
> +        wait(0);
> +    }
> +}
> +
> +static void usage(void)
> +{
> +    printf("Please specify the following environment variables:\n");
> +    printf("QEMU_FUZZ_ARGS= the command line arguments passed to qemu\n");
> +    printf("QEMU_FUZZ_OBJECTS= "
> +            "a space separated list of QOM type names for objects to fuzz\n");
> +    printf("Optionally: QEMU_FUZZ_TIMEOUT= Specify a custom timeout (us). "
> +            "0 to disable. %d by default\n", timeout);
> +    exit(0);
> +}
> +
> +static int locate_fuzz_memory_regions(Object *child, void *opaque)
> +{
> +    const char *name;
> +    MemoryRegion *mr;
> +    if (object_dynamic_cast(child, TYPE_MEMORY_REGION)) {
> +        mr = MEMORY_REGION(child);
> +        if ((memory_region_is_ram(mr) ||
> +            memory_region_is_ram_device(mr) ||
> +            memory_region_is_rom(mr)) == false) {
> +            name = object_get_canonical_path_component(child);
> +            /*
> +             * We don't want duplicate pointers to the same MemoryRegion, so
> +             * try to remove copies of the pointer, before adding it.
> +             */
> +            g_hash_table_insert(fuzzable_memoryregions, mr, (gpointer)true);
> +        }
> +    }
> +    return 0;
> +}

NIT: Add blank line here.

Thanks,

Darren.

