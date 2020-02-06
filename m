Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B40C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 14:52:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79DEF20838
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 14:52:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79DEF20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iziWH-000738-J9
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 09:52:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37117)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iziS9-0004ja-TB
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:48:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iziS7-00069j-Bf
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:48:25 -0500
Received: from relay64.bu.edu ([128.197.228.104]:44554)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iziS7-00068L-7f
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:48:23 -0500
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 016Elviu009298
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 6 Feb 2020 09:48:00 -0500
Date: Thu, 6 Feb 2020 09:47:57 -0500
From: Alexander Bulekov <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Subject: Re: [PATCH v8 18/21] fuzz: add i440fx fuzz targets
Message-ID: <20200206144756.o6qhesj5k6laqn3j@mozz.bu.edu>
References: <20200129053357.27454-1-alxndr@bu.edu>
 <20200129053357.27454-19-alxndr@bu.edu>
 <20200205132650.yajwli5c5a6b7aur@starbug-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205132650.yajwli5c5a6b7aur@starbug-mbp>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.6.x
X-Received-From: 128.197.228.104
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200205 1326, Darren Kenny wrote:
> On Wed, Jan 29, 2020 at 05:34:26AM +0000, Bulekov, Alexander wrote:
> > These three targets should simply fuzz reads/writes to a couple ioports,
> > but they mostly serve as examples of different ways to write targets.
> > They demonstrate using qtest and qos for fuzzing, as well as using
> > rebooting and forking to reset state, or not resetting it at all.
> > 
> > Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> 
> Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
> 
> A couple of nit below w.r.t. commenting on how the fuzzed data is
> being processed.
> 
> > ---
> > tests/qtest/fuzz/Makefile.include |   3 +
> > tests/qtest/fuzz/i440fx_fuzz.c    | 178 ++++++++++++++++++++++++++++++
> > 2 files changed, 181 insertions(+)
> > create mode 100644 tests/qtest/fuzz/i440fx_fuzz.c
> > 
> > diff --git a/tests/qtest/fuzz/Makefile.include b/tests/qtest/fuzz/Makefile.include
> > index e3bdd33ff4..38b8cdd9f1 100644
> > --- a/tests/qtest/fuzz/Makefile.include
> > +++ b/tests/qtest/fuzz/Makefile.include
> > @@ -6,6 +6,9 @@ fuzz-obj-y += tests/qtest/fuzz/fuzz.o # Fuzzer skeleton
> > fuzz-obj-y += tests/qtest/fuzz/fork_fuzz.o
> > fuzz-obj-y += tests/qtest/fuzz/qos_fuzz.o
> > 
> > +# Targets
> > +fuzz-obj-y += tests/qtest/fuzz/i440fx_fuzz.o
> > +
> > FUZZ_CFLAGS += -I$(SRC_PATH)/tests -I$(SRC_PATH)/tests/qtest
> > 
> > # Linker Script to force coverage-counters into known regions which we can mark
> > diff --git a/tests/qtest/fuzz/i440fx_fuzz.c b/tests/qtest/fuzz/i440fx_fuzz.c
> > new file mode 100644
> > index 0000000000..c7791182b8
> > --- /dev/null
> > +++ b/tests/qtest/fuzz/i440fx_fuzz.c
> > @@ -0,0 +1,178 @@
> > +/*
> > + * I440FX Fuzzing Target
> > + *
> > + * Copyright Red Hat Inc., 2019
> > + *
> > + * Authors:
> > + *  Alexander Bulekov   <alxndr@bu.edu>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> > + * See the COPYING file in the top-level directory.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +
> > +#include "qemu/main-loop.h"
> > +#include "tests/qtest/libqtest.h"
> > +#include "tests/qtest/libqos/pci.h"
> > +#include "tests/qtest/libqos/pci-pc.h"
> > +#include "fuzz.h"
> > +#include "fuzz/qos_fuzz.h"
> > +#include "fuzz/fork_fuzz.h"
> > +
> > +
> > +#define I440FX_PCI_HOST_BRIDGE_CFG 0xcf8
> > +#define I440FX_PCI_HOST_BRIDGE_DATA 0xcfc
> > +
> > +enum action_id {
> > +    WRITEB,
> > +    WRITEW,
> > +    WRITEL,
> > +    READB,
> > +    READW,
> > +    READL,
> > +    ACTION_MAX
> > +};
> > +
> 
> While it eventually becomes clear what is happening in these
> functions, it does take several attempts at reading it to understand
> what is going on.
> 
> For that reason, it might be worth a couple of comments for future
> maintainers as to what is going on.
Yes - I haven't touched this target in a while. It could definitely
use some comments. Since the port-io input space isn't enormous, maybe
it makes sends to fuzz all of port-io, instead of just the I440FX
addresses.
-Alex

> Thanks,
> 
> Darren.
> 
> > +static void i440fx_fuzz_qtest(QTestState *s,
> > +        const unsigned char *Data, size_t Size) {
> > +    typedef struct QTestFuzzAction {
> > +        uint32_t value;
> > +        uint8_t id;
> > +        uint8_t addr;
> > +    } QTestFuzzAction;
> > +    QTestFuzzAction a;
> > +
> > +    while (Size >= sizeof(a)) {
> > +        memcpy(&a, Data, sizeof(a));
> > +        uint16_t addr = a.addr % 2 ? I440FX_PCI_HOST_BRIDGE_CFG :
> > +                                      I440FX_PCI_HOST_BRIDGE_DATA;
> > +        switch (a.id % ACTION_MAX) {
> > +        case WRITEB:
> > +            qtest_outb(s, addr, (uint8_t)a.value);
> > +            break;
> > +        case WRITEW:
> > +            qtest_outw(s, addr, (uint16_t)a.value);
> > +            break;
> > +        case WRITEL:
> > +            qtest_outl(s, addr, (uint32_t)a.value);
> > +            break;
> > +        case READB:
> > +            qtest_inb(s, addr);
> > +            break;
> > +        case READW:
> > +            qtest_inw(s, addr);
> > +            break;
> > +        case READL:
> > +            qtest_inl(s, addr);
> > +            break;
> > +        }
> > +        Size -= sizeof(a);
> > +        Data += sizeof(a);
> > +    }
> > +    flush_events(s);
> > +}
> > +
> > +static void i440fx_fuzz_qos(QTestState *s,
> > +        const unsigned char *Data, size_t Size) {
> > +
> > +    typedef struct QOSFuzzAction {
> > +        uint32_t value;
> > +        int devfn;
> > +        uint8_t offset;
> > +        uint8_t id;
> > +    } QOSFuzzAction;
> > +
> > +    static QPCIBus *bus;
> > +    if (!bus) {
> > +        bus = qpci_new_pc(s, fuzz_qos_alloc);
> > +    }
> > +
> > +    QOSFuzzAction a;
> > +    while (Size >= sizeof(a)) {
> > +        memcpy(&a, Data, sizeof(a));
> > +        switch (a.id % ACTION_MAX) {
> > +        case WRITEB:
> > +            bus->config_writeb(bus, a.devfn, a.offset, (uint8_t)a.value);
> > +            break;
> > +        case WRITEW:
> > +            bus->config_writew(bus, a.devfn, a.offset, (uint16_t)a.value);
> > +            break;
> > +        case WRITEL:
> > +            bus->config_writel(bus, a.devfn, a.offset, (uint32_t)a.value);
> > +            break;
> > +        case READB:
> > +            bus->config_readb(bus, a.devfn, a.offset);
> > +            break;
> > +        case READW:
> > +            bus->config_readw(bus, a.devfn, a.offset);
> > +            break;
> > +        case READL:
> > +            bus->config_readl(bus, a.devfn, a.offset);
> > +            break;
> > +        }
> > +        Size -= sizeof(a);
> > +        Data += sizeof(a);
> > +    }
> > +    flush_events(s);
> > +}
> > +
> > +static void i440fx_fuzz_qos_fork(QTestState *s,
> > +        const unsigned char *Data, size_t Size) {
> > +    if (fork() == 0) {
> > +        i440fx_fuzz_qos(s, Data, Size);
> > +        _Exit(0);
> > +    } else {
> > +        wait(NULL);
> > +    }
> > +}
> > +
> > +static const char *i440fx_qtest_argv = TARGET_NAME " -machine accel=qtest"
> > +                                       "-m 0 -display none";
> > +static const char *i440fx_argv(FuzzTarget *t)
> > +{
> > +    return i440fx_qtest_argv;
> > +}
> > +
> > +static void fork_init(void)
> > +{
> > +    counter_shm_init();
> > +}
> > +
> > +static void register_pci_fuzz_targets(void)
> > +{
> > +    /* Uses simple qtest commands and reboots to reset state */
> > +    fuzz_add_target(&(FuzzTarget){
> > +                .name = "i440fx-qtest-reboot-fuzz",
> > +                .description = "Fuzz the i440fx using raw qtest commands and"
> > +                               "rebooting after each run",
> > +                .get_init_cmdline = i440fx_argv,
> > +                .fuzz = i440fx_fuzz_qtest});
> > +
> > +    /* Uses libqos and forks to prevent state leakage */
> > +    fuzz_add_qos_target(&(FuzzTarget){
> > +                .name = "i440fx-qos-fork-fuzz",
> > +                .description = "Fuzz the i440fx using raw qtest commands and"
> > +                               "rebooting after each run",
> > +                .pre_vm_init = &fork_init,
> > +                .fuzz = i440fx_fuzz_qos_fork,},
> > +                "i440FX-pcihost",
> > +                &(QOSGraphTestOptions){}
> > +                );
> > +
> > +    /*
> > +     * Uses libqos. Doesn't do anything to reset state. Note that if we were to
> > +     * reboot after each run, we would also have to redo the qos-related
> > +     * initialization (qos_init_path)
> > +     */
> > +    fuzz_add_qos_target(&(FuzzTarget){
> > +                .name = "i440fx-qos-noreset-fuzz",
> > +                .description = "Fuzz the i440fx using raw qtest commands and"
> > +                               "rebooting after each run",
> > +                .fuzz = i440fx_fuzz_qos,},
> > +                "i440FX-pcihost",
> > +                &(QOSGraphTestOptions){}
> > +                );
> > +}
> > +
> > +fuzz_target_init(register_pci_fuzz_targets);
> > -- 
> > 2.23.0
> > 
> > 

