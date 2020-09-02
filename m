Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD014C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 10:04:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 575F120829
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 10:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VgGTOXoc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 575F120829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDPcw-0007Xb-Gx
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 06:04:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kDPcC-0006eM-Ev
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 06:03:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60082)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kDPc9-0000RC-5f
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 06:03:39 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0829wvHm103955;
 Wed, 2 Sep 2020 10:03:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=a9Mj1sxxqC1qwcUuF+QD3EhNj5x3AqxqalxhBUWXrxc=;
 b=VgGTOXocgr5fnsOZXv8nodm3ann4mDk7hdwQdsYJpeSH7F7YbKIXq1gGFRDZdq6yikQp
 vhcUeQaEuXlxFlrFkiroLtVl4a9Dq7J8xhI2wFZ9x4N132cVBALCoF2O63zgjeXMoQG+
 v2Q4u3tITL9QcP/vz/AEgiLzDd6tUCbSY18vDnQ2zvKHwd3paPcWEe4XbTPyl+ckPJVF
 uR+BM8oRVkUeeAtUcOqtaS7GiAlPretb0Cilt8QW0qf9w59sDQdkasOa9pHR+MqhNyyC
 Yq0hX3zyKebcjzn+vE/iZYOmXdkc6jWc9dDMmG1rb/wYubfgf7zhlkyx5X47js83uCV1 +g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 337eer1n28-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 02 Sep 2020 10:03:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0829tj9T000801;
 Wed, 2 Sep 2020 10:03:33 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 3380xybruj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Sep 2020 10:03:33 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 082A3UjL031386;
 Wed, 2 Sep 2020 10:03:30 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 02 Sep 2020 03:03:30 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id 3561C132FE28; Wed,  2 Sep 2020 11:03:20 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 02/15] fuzz: Add general virtual-device fuzzer
In-Reply-To: <20200819061110.1320568-3-alxndr@bu.edu>
References: <20200819061110.1320568-1-alxndr@bu.edu>
 <20200819061110.1320568-3-alxndr@bu.edu>
Date: Wed, 02 Sep 2020 11:03:20 +0100
Message-ID: <m2a6y8ts0n.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9731
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009020093
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9731
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011
 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009020093
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=darren.kenny@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 06:03:35
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
 stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Hi Alex,

Apologies for not taking so long to get to this.

On Wednesday, 2020-08-19 at 02:10:57 -04, Alexander Bulekov wrote:
> This is a generic fuzzer designed to fuzz a virtual device's
> MemoryRegions, as long as they exist within the Memory or Port IO (if it
> exists) AddressSpaces. The fuzzer's input is interpreted into a sequence
> of qtest commands (outb, readw, etc). The interpreted commands are
> separated by a magic seaparator, which should be easy for the fuzzer to
> guess. Without ASan, the separator can be specified as a "dictionary
> value" using the -dict argument (see libFuzzer documentation).
>
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>  tests/qtest/fuzz/Makefile.include |   1 +
>  tests/qtest/fuzz/general_fuzz.c   | 494 ++++++++++++++++++++++++++++++
>  2 files changed, 495 insertions(+)
>  create mode 100644 tests/qtest/fuzz/general_fuzz.c
>
> diff --git a/tests/qtest/fuzz/Makefile.include b/tests/qtest/fuzz/Makefile.include
> index 5bde793bf2..854322efb6 100644
> --- a/tests/qtest/fuzz/Makefile.include
> +++ b/tests/qtest/fuzz/Makefile.include
> @@ -11,6 +11,7 @@ fuzz-obj-y += tests/qtest/fuzz/qtest_wrappers.o
>  fuzz-obj-$(CONFIG_PCI_I440FX) += tests/qtest/fuzz/i440fx_fuzz.o
>  fuzz-obj-$(CONFIG_VIRTIO_NET) += tests/qtest/fuzz/virtio_net_fuzz.o
>  fuzz-obj-$(CONFIG_SCSI) += tests/qtest/fuzz/virtio_scsi_fuzz.o
> +fuzz-obj-y += tests/qtest/fuzz/general_fuzz.o
>  
>  FUZZ_CFLAGS += -I$(SRC_PATH)/tests -I$(SRC_PATH)/tests/qtest
>  
> diff --git a/tests/qtest/fuzz/general_fuzz.c b/tests/qtest/fuzz/general_fuzz.c
> new file mode 100644
> index 0000000000..01bcb029b1
> --- /dev/null
> +++ b/tests/qtest/fuzz/general_fuzz.c
> @@ -0,0 +1,494 @@
> +/*
> + * General Virtual-Device Fuzzing Target
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
> +#include "cpu.h"
> +#include "tests/qtest/libqtest.h"
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
> +enum cmds{
> +    OP_IN,
> +    OP_OUT,
> +    OP_READ,
> +    OP_WRITE,
> +    OP_CLOCK_STEP,
> +};
> +
> +#define DEFAULT_TIMEOUT_US 100000
> +#define USEC_IN_SEC 100000000
> +
> +typedef struct {
> +    size_t addr;
> +    size_t len; /* The number of bytes until the end of the I/O region */
> +} address_range;
> +
> +static useconds_t timeout = 100000;
> +/*
> + * List of memory regions that are children of QOM objects specified by the
> + * user for fuzzing.
> + */
> +static GPtrArray *fuzzable_memoryregions;
> +/*
> + * Here we want to convert a fuzzer-provided [io-region-index, offset] to
> + * a physical address. To do this, we iterate over all of the matched
> + * MemoryRegions. Check whether each region exists within the particular io
> + * space. Return the absolute address of the offset within the index'th region
> + * that is a subregion of the io_space and the distance until the end of the
> + * memory region.
> + */
> +static bool get_io_address(address_range *result,
> +                                    MemoryRegion *io_space,
> +                                    uint8_t index,
> +                                    uint32_t offset) {
> +    MemoryRegion *mr, *root;
> +    index = index % fuzzable_memoryregions->len;
> +    int candidate_regions = 0;
> +    int i = 0;
> +    int ind = index;
> +    size_t abs_addr;
> +    AddressSpace *as = (io_space == get_system_memory()) ? &address_space_memory : &address_space_io;
> +
> +    while (ind >= 0 && fuzzable_memoryregions->len) {
> +        *result = (address_range){0, 0};
> +        mr = g_ptr_array_index(fuzzable_memoryregions, i);
> +        if (mr->enabled) {
> +            abs_addr = mr->addr;
> +            for (root = mr; root->container; ) {
> +                root = root->container;
> +                abs_addr += root->addr;
> +            }
> +            /*
> +             * Only consider the region if it is rooted at the io_space we want
> +             */
> +            if (root == io_space) {
> +                hwaddr xlat, len;
> +                if(address_space_translate(as, abs_addr, &xlat, &len, true, MEMTXATTRS_UNSPECIFIED) == mr){
> +                    ind--;

I'm wondering what is the purpose of ind, we never really do anything
with it except possibly decrement it here and test in the while
condition.

With candidate_regions also only being incremented here, we could just
as easily compare that against index.

> +                    candidate_regions++;
> +                    result->addr = abs_addr;
> +                    if(mr->size){
> +                        result->addr += (offset % mr->size);
> +                    }
> +                    result->len = mr->size-(result->addr-abs_addr);

Should we have a break here? If we don't break the look now, *result
will be cleared again at the start of this while block, making this work
here pointless other than counting candidate_regions and decrementing
ind.

> +                }
> +            }
> +        }
> +        ++i;
> +        /* Loop around */
> +        if (i == fuzzable_memoryregions->len) {
> +            /* No enabled regions in our io_space? */
> +            if (candidate_regions == 0) {
> +                break;
> +            }
> +            i = 0;

I'm not really clear on what this block does - it resets i, only breaks
if we've not found any candidates after reaching the end of the
fuzzable_memoryregions array.

Overall, this while loop seems to lack a clear exit strategy, it looks
like where it is doing today is to lopp through  all the
fuzzable_memoryregions multiple times until ind < 0 or we simply don't
find any candidate_regions on our first pass.

Maybe I'm missing something?

> +        }
> +    }
> +    return candidate_regions != 0;
> +}
> +static bool get_pio_address(address_range *result,
> +                                     uint8_t index, uint16_t offset)
> +{
> +    /*
> +     * PIO BARs can be set past the maximum port address (0xFFFF). Thus, result
> +     * can contain an addr that extends past the PIO space. When we pass this
> +     * address to qtest_in/qtest_out, it is cast to a uint16_t, so we might end
> +     * up fuzzing a completely different MemoryRegion/Device. Therefore, check
> +     * that the address here is within the PIO space limits.
> +     */
> +
> +    bool success = get_io_address(result, get_system_io(), index, offset);
> +    return success && result->addr <= 0xFFFF;
> +}
> +static bool get_mmio_address(address_range *result,
> +                                      uint8_t index, uint32_t offset)
> +{
> +    return get_io_address(result, get_system_memory(), index, offset);
> +}
> +
> +static void op_in(QTestState *s, const unsigned char * data, size_t len)
> +{
> +    enum Sizes {Byte, Word, Long, end_sizes};
> +    struct {
> +        uint8_t size;
> +        uint8_t base;
> +        uint16_t offset;
> +    } a;
> +    address_range abs;
> +
> +    if (len < sizeof(a)) {
> +        return;
> +    }
> +    memcpy(&a, data, sizeof(a));
> +    if (get_pio_address(&abs, a.base, a.offset) == 0) {
> +        return;
> +    }
> +
> +    switch (a.size %= end_sizes) {
> +    case Byte:
> +        qtest_inb(s, abs.addr);
> +        break;
> +    case Word:
> +        if (abs.len >= 2) {
> +            qtest_inw(s, abs.addr);
> +        }
> +        break;
> +    case Long:
> +        if (abs.len >= 4) {
> +            qtest_inl(s, abs.addr);
> +        }
> +        break;
> +    }
> +}
> +
> +static void op_out(QTestState *s, const unsigned char * data, size_t len)
> +{
> +    enum Sizes {Byte, Word, Long, end_sizes};
> +    struct {
> +        uint8_t size;
> +        uint8_t base;
> +        uint16_t offset;
> +        uint32_t value;
> +    } a;
> +    address_range abs;
> +
> +    if (len < sizeof(a)) {
> +        return;
> +    }
> +    memcpy(&a, data, sizeof(a));
> +
> +    if (get_pio_address(&abs, a.base, a.offset) == 0) {
> +        return;
> +    }
> +
> +    switch (a.size %= end_sizes) {
> +    case Byte:
> +        qtest_outb(s, abs.addr, a.value & 0xFF);
> +        break;
> +    case Word:
> +        if (abs.len >= 2) {
> +            qtest_outw(s, abs.addr, a.value & 0xFFFF);
> +        }
> +        break;
> +    case Long:
> +        if (abs.len >= 4) {
> +            qtest_outl(s, abs.addr, a.value);
> +        }
> +        break;
> +    }
> +}
> +
> +static void op_read(QTestState *s, const unsigned char * data, size_t len)
> +{
> +    enum Sizes {Byte, Word, Long, Quad, end_sizes};
> +    struct {
> +        uint8_t size;
> +        uint8_t base;
> +        uint32_t offset;
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
> +        qtest_readb(s, abs.addr);
> +        break;
> +    case Word:
> +        if (abs.len >= 2) {
> +            qtest_readw(s, abs.addr);
> +        }
> +        break;
> +    case Long:
> +        if (abs.len >= 4) {
> +            qtest_readl(s, abs.addr);
> +        }
> +        break;
> +    case Quad:
> +        if (abs.len >= 8) {
> +            qtest_readq(s, abs.addr);
> +        }
> +        break;
> +    }
> +}
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
> +        if (abs.len >= 2) {
> +            qtest_writew(s, abs.addr, a.value & 0xFFFF);
> +        }
> +        break;
> +    case Long:
> +        if (abs.len >= 4) {
> +            qtest_writel(s, abs.addr, a.value & 0xFFFFFFFF);
> +        }
> +        break;
> +    case Quad:
> +        if (abs.len >= 8) {
> +            qtest_writeq(s, abs.addr, a.value);
> +        }
> +        break;
> +    }
> +}
> +static void op_clock_step(QTestState *s, const unsigned char *data, size_t len)
> +{
> +    qtest_clock_step_next(s);
> +}
> +
> +static void handle_timeout(int sig)
> +{
> +    if (getenv("QTEST_LOG")) {
> +        fprintf(stderr, "[Timeout]\n");
> +        fflush(stderr);
> +    }
> +    _Exit(0);
> +}
> +
> +/*
> + * Here, we interpret random bytes from the fuzzer, as a sequence of commands.
> + * Our commands are variable-width, so we use a separator, SEPARATOR, to specify
> + * the boundaries between commands. This is just a random 32-bit value, which
> + * is easily identified by libfuzzer+AddressSanitizer, as long as we use
> + * memmem. It can also be included in the fuzzer's dictionary. More details
> + * here:
> + * https://github.com/google/fuzzing/blob/master/docs/split-inputs.md
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

Out if curiosity, do any of our corpus actually make use of the FUZZ string, or are we
just falling back to always using the full size of the provided input?

> +static void general_fuzz(QTestState *s, const unsigned char *Data, size_t Size)
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
> +            memory_region_is_rom(mr) ||
> +            memory_region_is_romd(mr)) == false) {
> +            name = object_get_canonical_path_component(child);
> +            /*
> +             * We don't want duplicate pointers to the same MemoryRegion, so
> +             * try to remove copies of the pointer, before adding it.
> +             */
> +            g_ptr_array_remove_fast(fuzzable_memoryregions, mr);
> +            g_ptr_array_add(fuzzable_memoryregions, mr);
> +        }
> +    }
> +    return 0;
> +}
> +static int locate_fuzz_objects(Object *child, void *opaque)
> +{
> +    char *pattern = opaque;
> +    if (g_pattern_match_simple(pattern, object_get_typename(child))) {
> +        /* Find and save ptrs to any child MemoryRegions */
> +        object_child_foreach_recursive(child, locate_fuzz_memory_regions, NULL);
> +    } else if (object_dynamic_cast(OBJECT(child), TYPE_MEMORY_REGION)) {
> +        if (g_pattern_match_simple(pattern,
> +            object_get_canonical_path_component(child))) {
> +            MemoryRegion *mr;
> +            mr = MEMORY_REGION(child);
> +            if ((memory_region_is_ram(mr) ||
> +                 memory_region_is_ram_device(mr) ||
> +                 memory_region_is_rom(mr) ||
> +                 memory_region_is_romd(mr)) == false) {
> +                g_ptr_array_remove_fast(fuzzable_memoryregions, mr);
> +                g_ptr_array_add(fuzzable_memoryregions, mr);
> +            }
> +        }
> +    }
> +    return 0;
> +}
> +
> +static void general_pre_fuzz(QTestState *s)
> +{
> +    if (!getenv("QEMU_FUZZ_OBJECTS")) {
> +        usage();
> +    }
> +    if (getenv("QEMU_FUZZ_TIMEOUT")) {
> +        timeout = g_ascii_strtoll(getenv("QEMU_FUZZ_TIMEOUT"), NULL, 0);
> +    }
> +
> +    fuzzable_memoryregions = g_ptr_array_new();
> +    char **result = g_strsplit (getenv("QEMU_FUZZ_OBJECTS"), " ", -1);
> +    for (int i = 0; result[i] != NULL; i++) {
> +        printf("Matching objects by name %s\n", result[i]);
> +        object_child_foreach_recursive(qdev_get_machine(),
> +                                    locate_fuzz_objects,
> +                                    result[i]);
> +    }
> +    g_strfreev(result);
> +    printf("This process will try to fuzz the following MemoryRegions:\n");
> +    for (int i = 0; i < fuzzable_memoryregions->len; i++) {
> +        MemoryRegion *mr;
> +        mr = g_ptr_array_index(fuzzable_memoryregions, i);
> +        printf("  * %s (size %lx)\n",
> +               object_get_canonical_path_component(&(mr->parent_obj)),
> +               mr->addr);
> +    }
> +
> +    if(!fuzzable_memoryregions->len){
> +        printf("No fuzzable memory regions found...\n");
> +        exit(0);

Possibly this should exit with a non-zero value since it probably is an
error case?

Thanks,

Darren.

