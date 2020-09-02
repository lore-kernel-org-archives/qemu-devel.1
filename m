Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3872AC433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 11:02:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00642207D3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 11:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OKA3BTe0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00642207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDQXa-0006kM-6l
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 07:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kDQWu-0006JL-NV
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 07:02:16 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44638)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kDQWs-0000Mf-Ci
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 07:02:16 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 082AwsoQ005563;
 Wed, 2 Sep 2020 11:02:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=W/Nb2nfmGsr/c75ZSG0/oJGyQlEkJO5WZDI78BC1Q8M=;
 b=OKA3BTe0S7GjuOxCxzkFWLj4oE4gJ+fPT185zxkQzM6CNmjsuPPrWSDfk0DmEwCWRq1u
 qoVSWLHugvUduUkUHtLM9I9+KVjIiriAhwc63PNHlge2+oHO9tn7FyPg/AllWZkMz1hM
 /KuOQfa+qOmVhwlqdczeIUkifb7nB1/bEjSoDKl6FOCfIXVFPk2QAvZjEYcFhPtqi5v7
 nhRACRIlSpYGEZjOWHD13dt/+zZ8kKgMwXHY2jvOlcIczu17OvD878o4D0ybIOyEy9YM
 15DA6MSFqo0YtN0oHRYe1adCeu+RVaZ8OYbsphKtsaTf0j6OWJDCYOj7sC5UH0COhVSL 3w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 337eer1vr1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 02 Sep 2020 11:02:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 082B0dWG094009;
 Wed, 2 Sep 2020 11:02:08 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 3380x6axvs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Sep 2020 11:02:08 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 082B24IX012582;
 Wed, 2 Sep 2020 11:02:05 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 02 Sep 2020 04:02:04 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id 3295A1333926; Wed,  2 Sep 2020 12:01:59 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 03/15] fuzz: Add PCI features to the general fuzzer
In-Reply-To: <20200819061110.1320568-4-alxndr@bu.edu>
References: <20200819061110.1320568-1-alxndr@bu.edu>
 <20200819061110.1320568-4-alxndr@bu.edu>
Date: Wed, 02 Sep 2020 12:01:59 +0100
Message-ID: <m24kogtpaw.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9731
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=1 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009020104
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9731
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009020104
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

On Wednesday, 2020-08-19 at 02:10:58 -04, Alexander Bulekov wrote:
> This patch compares TYPE_PCI_DEVICE objects against the user-provided
> matching pattern. If there is a match, we use some hacks and leverage
> QOS to map each possible BAR for that device. Now fuzzed inputs might be
> converted to pci_read/write commands which target specific. This means
> that we can fuzz a particular device's PCI configuration space,
>
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

Thanks,

Darren.

> ---
>  tests/qtest/fuzz/general_fuzz.c | 83 +++++++++++++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
>
> diff --git a/tests/qtest/fuzz/general_fuzz.c b/tests/qtest/fuzz/general_fuzz.c
> index 01bcb029b1..17b572a439 100644
> --- a/tests/qtest/fuzz/general_fuzz.c
> +++ b/tests/qtest/fuzz/general_fuzz.c
> @@ -24,6 +24,7 @@
>  #include "exec/ramblock.h"
>  #include "exec/address-spaces.h"
>  #include "hw/qdev-core.h"
> +#include "hw/pci/pci.h"
>  
>  /*
>   * SEPARATOR is used to separate "operations" in the fuzz input
> @@ -35,12 +36,17 @@ enum cmds{
>      OP_OUT,
>      OP_READ,
>      OP_WRITE,
> +    OP_PCI_READ,
> +    OP_PCI_WRITE,
>      OP_CLOCK_STEP,
>  };
>  
>  #define DEFAULT_TIMEOUT_US 100000
>  #define USEC_IN_SEC 100000000
>  
> +#define PCI_HOST_BRIDGE_CFG 0xcf8
> +#define PCI_HOST_BRIDGE_DATA 0xcfc
> +
>  typedef struct {
>      size_t addr;
>      size_t len; /* The number of bytes until the end of the I/O region */
> @@ -52,6 +58,8 @@ static useconds_t timeout = 100000;
>   * user for fuzzing.
>   */
>  static GPtrArray *fuzzable_memoryregions;
> +static GPtrArray *fuzzable_pci_devices;
> +
>  /*
>   * Here we want to convert a fuzzer-provided [io-region-index, offset] to
>   * a physical address. To do this, we iterate over all of the matched
> @@ -283,6 +291,65 @@ static void op_write(QTestState *s, const unsigned char * data, size_t len)
>          break;
>      }
>  }
> +static void op_pci_read(QTestState *s, const unsigned char * data, size_t len)
> +{
> +    enum Sizes {Byte, Word, Long, end_sizes};
> +    struct {
> +        uint8_t size;
> +        uint8_t base;
> +        uint8_t offset;
> +    } a;
> +    if (len < sizeof(a) || fuzzable_pci_devices->len == 0) {
> +        return;
> +    }
> +    memcpy(&a, data, sizeof(a));
> +    PCIDevice *dev = g_ptr_array_index(fuzzable_pci_devices,
> +                                  a.base % fuzzable_pci_devices->len);
> +    int devfn = dev->devfn;
> +    qtest_outl(s, PCI_HOST_BRIDGE_CFG, (1U << 31) | (devfn << 8) | a.offset);
> +    switch (a.size %= end_sizes) {
> +    case Byte:
> +        qtest_inb(s, PCI_HOST_BRIDGE_DATA);
> +        break;
> +    case Word:
> +        qtest_inw(s, PCI_HOST_BRIDGE_DATA);
> +        break;
> +    case Long:
> +        qtest_inl(s, PCI_HOST_BRIDGE_DATA);
> +        break;
> +    }
> +}
> +
> +static void op_pci_write(QTestState *s, const unsigned char * data, size_t len)
> +{
> +    enum Sizes {Byte, Word, Long, end_sizes};
> +    struct {
> +        uint8_t size;
> +        uint8_t base;
> +        uint8_t offset;
> +        uint32_t value;
> +    } a;
> +    if (len < sizeof(a) || fuzzable_pci_devices->len == 0) {
> +        return;
> +    }
> +    memcpy(&a, data, sizeof(a));
> +    PCIDevice *dev = g_ptr_array_index(fuzzable_pci_devices,
> +                                  a.base % fuzzable_pci_devices->len);
> +    int devfn = dev->devfn;
> +    qtest_outl(s, PCI_HOST_BRIDGE_CFG, (1U << 31) | (devfn << 8) | a.offset);
> +    switch (a.size %= end_sizes) {
> +    case Byte:
> +        qtest_outb(s, PCI_HOST_BRIDGE_DATA, a.value & 0xFF);
> +        break;
> +    case Word:
> +        qtest_outw(s, PCI_HOST_BRIDGE_DATA, a.value & 0xFFFF);
> +        break;
> +    case Long:
> +        qtest_outl(s, PCI_HOST_BRIDGE_DATA, a.value & 0xFFFFFFFF);
> +        break;
> +    }
> +}
> +
>  static void op_clock_step(QTestState *s, const unsigned char *data, size_t len)
>  {
>      qtest_clock_step_next(s);
> @@ -327,6 +394,8 @@ static void general_fuzz(QTestState *s, const unsigned char *Data, size_t Size)
>          [OP_OUT]                = op_out,
>          [OP_READ]               = op_read,
>          [OP_WRITE]              = op_write,
> +        [OP_PCI_READ]           = op_pci_read,
> +        [OP_PCI_WRITE]          = op_pci_write,
>          [OP_CLOCK_STEP]         = op_clock_step,
>      };
>      const unsigned char *cmd = Data;
> @@ -418,6 +487,19 @@ static int locate_fuzz_objects(Object *child, void *opaque)
>      if (g_pattern_match_simple(pattern, object_get_typename(child))) {
>          /* Find and save ptrs to any child MemoryRegions */
>          object_child_foreach_recursive(child, locate_fuzz_memory_regions, NULL);
> +
> +        /*
> +         * We matched an object. If its a PCI device, store a pointer to it so
> +         * we can map BARs and fuzz its config space.
> +         */
> +        if (object_dynamic_cast(OBJECT(child), TYPE_PCI_DEVICE)) {
> +            /*
> +             * Don't want duplicate pointers to the same PCIDevice, so remove
> +             * copies of the pointer, before adding it.
> +             */
> +            g_ptr_array_remove_fast(fuzzable_pci_devices, PCI_DEVICE(child));
> +            g_ptr_array_add(fuzzable_pci_devices, PCI_DEVICE(child));
> +        }
>      } else if (object_dynamic_cast(OBJECT(child), TYPE_MEMORY_REGION)) {
>          if (g_pattern_match_simple(pattern,
>              object_get_canonical_path_component(child))) {
> @@ -445,6 +527,7 @@ static void general_pre_fuzz(QTestState *s)
>      }
>  
>      fuzzable_memoryregions = g_ptr_array_new();
> +    fuzzable_pci_devices   = g_ptr_array_new();
>      char **result = g_strsplit (getenv("QEMU_FUZZ_OBJECTS"), " ", -1);
>      for (int i = 0; result[i] != NULL; i++) {
>          printf("Matching objects by name %s\n", result[i]);
> -- 
> 2.27.0

