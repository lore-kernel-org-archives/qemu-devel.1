Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87B2C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:44:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67B3B2065E
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CzyvegGf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67B3B2065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDkqp-0004kh-IR
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 04:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kDkqE-0004KT-Q4
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 04:43:34 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58054)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kDkqC-00036t-9n
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 04:43:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0838drSZ089048;
 Thu, 3 Sep 2020 08:43:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=ugTDz64X2qEM9+UHP54YDXzQplqenEgtUfpkPIybvKw=;
 b=CzyvegGfxF1FmSXZRofd6ueysl+aRzcYdfJE2wD7D2GJuD8z1JjGYb+nhwhyAU5khfkz
 gTISXGIrBByfH6ieewksPh1HRKDHURE44wA0ffZ2xs1Q7snRBJECIntfly49th/XVYfv
 ydgHsSkxqjYmbPS6fL1mWJ+Pz0s8rnoPYfqZcIN5wX7k0JPdzDDIEGc+1qXgO2/sbvFC
 UJMbc/QYbh7QineTFLWGkUYzrYK4gscg7J8zlfUHFqojClNveK5uGXxNGQGc/gvmQDLq
 XviGdA8YriYKccxrR3XKKzuaPgh/J8BWXF8/4b4rvXHy739QuBt+W0Ei86/JemFbujum 2A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 339dmn5uad-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 03 Sep 2020 08:43:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0838fHCF105224;
 Thu, 3 Sep 2020 08:43:15 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 3380krd564-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 03 Sep 2020 08:43:15 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0838hCqQ023639;
 Thu, 3 Sep 2020 08:43:12 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 03 Sep 2020 01:43:12 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id 748F1134EF94; Thu,  3 Sep 2020 09:43:09 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 04/15] fuzz: Add DMA support to the generic-fuzzer
In-Reply-To: <20200819061110.1320568-5-alxndr@bu.edu>
References: <20200819061110.1320568-1-alxndr@bu.edu>
 <20200819061110.1320568-5-alxndr@bu.edu>
Date: Thu, 03 Sep 2020 09:43:09 +0100
Message-ID: <m21rjjtfmq.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0
 mlxscore=0 suspectscore=7 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009030079
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=7
 spamscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009030079
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=darren.kenny@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:43:20
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

On Wednesday, 2020-08-19 at 02:10:59 -04, Alexander Bulekov wrote:
> When a virtual-device tries to access some buffer in memory over DMA, we
> add call-backs into the fuzzer(next commit). The fuzzer checks verifies
> that the DMA request maps to a physical RAM address and fills the memory
> with fuzzer-provided data. The patterns that we use to fill this memory
> are specified using add_dma_pattern and clear_dma_patterns operations.
>
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>  tests/qtest/fuzz/general_fuzz.c | 178 ++++++++++++++++++++++++++++++++
>  1 file changed, 178 insertions(+)
>
> diff --git a/tests/qtest/fuzz/general_fuzz.c b/tests/qtest/fuzz/general_fuzz.c
> index 17b572a439..36d41acea0 100644
> --- a/tests/qtest/fuzz/general_fuzz.c
> +++ b/tests/qtest/fuzz/general_fuzz.c
> @@ -25,6 +25,8 @@
>  #include "exec/address-spaces.h"
>  #include "hw/qdev-core.h"
>  #include "hw/pci/pci.h"
> +#include "hw/boards.h"
> +#include "exec/memory-internal.h"
>  
>  /*
>   * SEPARATOR is used to separate "operations" in the fuzz input
> @@ -38,12 +40,16 @@ enum cmds{
>      OP_WRITE,
>      OP_PCI_READ,
>      OP_PCI_WRITE,
> +    OP_ADD_DMA_PATTERN,
> +    OP_CLEAR_DMA_PATTERNS,
>      OP_CLOCK_STEP,
>  };
>  
>  #define DEFAULT_TIMEOUT_US 100000
>  #define USEC_IN_SEC 100000000
>  
> +#define MAX_DMA_FILL_SIZE 0x10000
> +
>  #define PCI_HOST_BRIDGE_CFG 0xcf8
>  #define PCI_HOST_BRIDGE_DATA 0xcfc
>  
> @@ -53,6 +59,24 @@ typedef struct {
>  } address_range;
>  
>  static useconds_t timeout = 100000;
> +/*
> + * A pattern used to populate a DMA region or perform a memwrite. This is
> + * useful for e.g. populating tables of unique addresses.
> + * Example {.index = 1; .stride = 2; .len = 3; .data = "\x00\x01\x02"}
> + * Renders as: 00 01 02   00 03 03   00 05 03   00 07 03 ...

TYPO: I think this wrong, and that the last digit should be 02 not 03 in
      each group.

> + */
> +typedef struct {
> +    uint8_t index;      /* Index of a byte to increment by stride */
> +    uint8_t stride;     /* Increment each index'th byte by this amount */
> +    size_t len;
> +    const uint8_t *data;
> +} pattern;
> +
> +/* Avoid filling the same DMA region between MMIO/PIO commands ? */
> +static bool avoid_double_fetches;
> +
> +static QTestState *qts_global; /* Need a global for the DMA callback */
> +
>  /*
>   * List of memory regions that are children of QOM objects specified by the
>   * user for fuzzing.
> @@ -60,6 +84,116 @@ static useconds_t timeout = 100000;
>  static GPtrArray *fuzzable_memoryregions;
>  static GPtrArray *fuzzable_pci_devices;
>  
> +/*
> + * List of dma regions populated since the last fuzzing command. Used to ensure
> + * that we only write to each DMA address once, to avoid race conditions when
> + * building reproducers.
> + */
> +static GArray *dma_regions;
> +
> +static GArray *dma_patterns;
> +static int dma_pattern_index;
> +
> +void fuzz_dma_read_cb(size_t addr, size_t len, MemoryRegion *mr, bool is_write);
> +
> +/*
> + * Allocate a block of memory and populate it with a pattern.
> + */
> +static void *pattern_alloc(pattern p, size_t len)
> +{
> +    int i;
> +    uint8_t *buf = g_malloc(len);
> +    uint8_t sum = 0;
> +
> +    for (i = 0; i < len; ++i) {
> +        buf[i] = p.data[i % p.len];
> +        if ((i % p.len) == p.index) {
> +            buf[i] += sum;
> +            sum += p.stride;
> +        }
> +    }
> +    return buf;
> +}
> +
> +/*
> + * Call-back for functions that perform DMA reads from guest memory. Confirm
> + * that the region has not already been populated since the last loop in
> + * general_fuzz(), avoiding potential race-conditions, which we don't have
> + * a good way for reproducing right now.
> + */
> +void fuzz_dma_read_cb(size_t addr, size_t len, MemoryRegion *mr, bool is_write)
> +{
> +    /* Are we in the general-fuzzer or are we using another fuzz-target? */
> +    if (!qts_global) {
> +        return;
> +    }
> +
> +    /*
> +     * Return immediately if:
> +     * - We have no DMA patterns defined
> +     * - The length of the DMA read request is zero
> +     * - The DMA read is hitting an MR other than the machine's main RAM
> +     * - The DMA request is not a read (what happens for a address_space_map
> +     *   with is_write=True? Can the device use the same pointer to do reads?)
> +     * - The DMA request hits past the bounds of our RAM
> +     */
> +    if (dma_patterns->len == 0
> +        || len == 0
> +        || (mr != MACHINE(qdev_get_machine())->ram && !(mr->ops == &unassigned_mem_ops))
> +        || is_write
> +        || addr > current_machine->ram_size) {
> +        return;
> +    }
> +
> +    /*
> +     * If we overlap with any existing dma_regions, split the range and only
> +     * populate the non-overlapping parts.
> +     */
> +    for (int i = 0; i < dma_regions->len && avoid_double_fetches; ++i) {
> +        address_range region = g_array_index(dma_regions, address_range, i);

NIT: Can be slightly more expensive to declare a variable on each
iteration, but also tends to be cleaner not to do this.

> +        if (addr < region.addr + region.len && addr + len > region.addr) {
> +            if (addr < region.addr) {
> +                fuzz_dma_read_cb(addr, region.addr - addr, mr, is_write);
> +            }
> +            if (addr + len > region.addr + region.len) {
> +                fuzz_dma_read_cb(region.addr + region.len,
> +                        addr + len - (region.addr + region.len), mr, is_write);
> +            }
> +            return;
> +        }
> +    }
> +
> +    /* Cap the length of the DMA access to something reasonable */
> +    len = MIN(len, MAX_DMA_FILL_SIZE);
> +
> +    address_range ar = {addr, len};
> +    g_array_append_val(dma_regions, ar);
> +    pattern p = g_array_index(dma_patterns, pattern, dma_pattern_index);
> +    void *buf = pattern_alloc(p, ar.len);
> +    if (getenv("QTEST_LOG")) {

NIT: It might be cleaner to put any testing of env vars in to
the code in general_fuzz() where most others are being tested, and
instead set a static global boolean which can be used here instead.
Depending on how many times this is called, it may also be slightly
faster since getenv() has to search an array of strings, etc. to get the
value.

> +        /*
> +         * With QTEST_LOG, use a normal, slow QTest memwrite. Prefix the log
> +         * that will be written by qtest.c with a DMA tag, so we can reorder
> +         * the resulting QTest trace so the DMA fills precede the last PIO/MMIO
> +         * command.
> +         */
> +        fprintf(stderr, "[DMA] ");
> +        fflush(stderr);
> +        qtest_memwrite(qts_global, ar.addr, buf, ar.len);
> +    } else {
> +       /*
> +        * Populate the region using address_space_write_rom to avoid writing to
> +        * any IO MemoryRegions
> +        */
> +        address_space_write_rom(first_cpu->as, ar.addr, MEMTXATTRS_UNSPECIFIED,
> +                buf, ar.len);
> +    }
> +    free(buf);

NIT: For consistency, this probably should be a g_free(), since the memory
was allocated using g_malloc().

> +
> +    /* Increment the index of the pattern for the next DMA access */
> +    dma_pattern_index = (dma_pattern_index + 1) % dma_patterns->len;
> +}
> +
>  /*
>   * Here we want to convert a fuzzer-provided [io-region-index, offset] to
>   * a physical address. To do this, we iterate over all of the matched
> @@ -350,6 +484,35 @@ static void op_pci_write(QTestState *s, const unsigned char * data, size_t len)
>      }
>  }
>  
> +static void op_add_dma_pattern(QTestState *s,
> +                               const unsigned char *data, size_t len)
> +{
> +    struct {
> +        /*
> +         * index and stride can be used to increment the index-th byte of the
> +         * pattern by the value stride, for each loop of the pattern.
> +         */
> +        uint8_t index;
> +        uint8_t stride;
> +    } a;
> +
> +    if (len < sizeof(a) + 1) {
> +        return;
> +    }
> +    memcpy(&a, data, sizeof(a));
> +    pattern p = {a.index, a.stride, len - sizeof(a), data + sizeof(a)};
> +    p.index = a.index % p.len;
> +    g_array_append_val(dma_patterns, p);
> +    return;
> +}
> +
> +static void op_clear_dma_patterns(QTestState *s,
> +                                  const unsigned char *data, size_t len)
> +{
> +    g_array_set_size(dma_patterns, 0);
> +    dma_pattern_index = 0;
> +}
> +
>  static void op_clock_step(QTestState *s, const unsigned char *data, size_t len)
>  {
>      qtest_clock_step_next(s);
> @@ -396,6 +559,8 @@ static void general_fuzz(QTestState *s, const unsigned char *Data, size_t Size)
>          [OP_WRITE]              = op_write,
>          [OP_PCI_READ]           = op_pci_read,
>          [OP_PCI_WRITE]          = op_pci_write,
> +        [OP_ADD_DMA_PATTERN]    = op_add_dma_pattern,
> +        [OP_CLEAR_DMA_PATTERNS] = op_clear_dma_patterns,
>          [OP_CLOCK_STEP]         = op_clock_step,
>      };
>      const unsigned char *cmd = Data;
> @@ -425,6 +590,8 @@ static void general_fuzz(QTestState *s, const unsigned char *Data, size_t Size)
>              setitimer(ITIMER_VIRTUAL, &timer, NULL);
>          }
>  
> +        op_clear_dma_patterns(s, NULL, 0);
> +
>          while (cmd && Size) {
>              /* Get the length until the next command or end of input */
>              nextcmd = memmem(cmd, Size, SEPARATOR, strlen(SEPARATOR));
> @@ -441,6 +608,7 @@ static void general_fuzz(QTestState *s, const unsigned char *Data, size_t Size)
>              /* Advance to the next command */
>              cmd = nextcmd ? nextcmd + sizeof(SEPARATOR) - 1 : nextcmd;
>              Size = Size - (cmd_len + sizeof(SEPARATOR) - 1);
> +            g_array_set_size(dma_regions, 0);
>          }
>          _Exit(0);
>      } else {
> @@ -455,6 +623,9 @@ static void usage(void)
>      printf("QEMU_FUZZ_ARGS= the command line arguments passed to qemu\n");
>      printf("QEMU_FUZZ_OBJECTS= "
>              "a space separated list of QOM type names for objects to fuzz\n");
> +    printf("Optionally: QEMU_AVOID_DOUBLE_FETCH= "
> +            "Try to avoid racy DMA double fetch bugs? %d by default\n",
> +            avoid_double_fetches);
>      printf("Optionally: QEMU_FUZZ_TIMEOUT= Specify a custom timeout (us). "
>              "0 to disable. %d by default\n", timeout);
>      exit(0);
> @@ -522,9 +693,16 @@ static void general_pre_fuzz(QTestState *s)
>      if (!getenv("QEMU_FUZZ_OBJECTS")) {
>          usage();
>      }
> +    if (getenv("QEMU_AVOID_DOUBLE_FETCH")) {
> +        avoid_double_fetches = 1;
> +    }
>      if (getenv("QEMU_FUZZ_TIMEOUT")) {
>          timeout = g_ascii_strtoll(getenv("QEMU_FUZZ_TIMEOUT"), NULL, 0);
>      }
> +    qts_global = s;
> +
> +    dma_regions = g_array_new(false, false, sizeof(address_range));
> +    dma_patterns = g_array_new(false, false, sizeof(pattern));
>  
>      fuzzable_memoryregions = g_ptr_array_new();
>      fuzzable_pci_devices   = g_ptr_array_new();

Since mostly nits and typos:

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

Thanks,

Darren.

