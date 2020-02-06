Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0092CC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 14:53:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE57020838
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 14:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE57020838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iziX0-00084t-1a
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 09:53:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40146)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iziWG-0007CB-0U
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:52:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iziWE-00086k-3r
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:52:39 -0500
Received: from relay64.bu.edu ([128.197.228.104]:44607)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iziWD-00084c-Vg
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:52:38 -0500
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 016EpMjN011931
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 6 Feb 2020 09:51:23 -0500
Date: Thu, 6 Feb 2020 09:51:22 -0500
From: Alexander Bulekov <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Subject: Re: [PATCH v8 19/21] fuzz: add virtio-net fuzz target
Message-ID: <20200206145122.faidwk4vkvtifask@mozz.bu.edu>
References: <20200129053357.27454-1-alxndr@bu.edu>
 <20200129053357.27454-20-alxndr@bu.edu>
 <20200205135740.f6o22uy5ss7bzoj2@starbug-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205135740.f6o22uy5ss7bzoj2@starbug-mbp>
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

On 200205 1357, Darren Kenny wrote:
> On Wed, Jan 29, 2020 at 05:34:27AM +0000, Bulekov, Alexander wrote:
> > The virtio-net fuzz target feeds inputs to all three virtio-net
> > virtqueues, and uses forking to avoid leaking state between fuzz runs.
> > 
> > Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> > ---
> > tests/qtest/fuzz/Makefile.include  |   1 +
> > tests/qtest/fuzz/virtio_net_fuzz.c | 195 +++++++++++++++++++++++++++++
> > 2 files changed, 196 insertions(+)
> > create mode 100644 tests/qtest/fuzz/virtio_net_fuzz.c
> > 
> > diff --git a/tests/qtest/fuzz/Makefile.include b/tests/qtest/fuzz/Makefile.include
> > index 38b8cdd9f1..77385777ef 100644
> > --- a/tests/qtest/fuzz/Makefile.include
> > +++ b/tests/qtest/fuzz/Makefile.include
> > @@ -8,6 +8,7 @@ fuzz-obj-y += tests/qtest/fuzz/qos_fuzz.o
> > 
> > # Targets
> > fuzz-obj-y += tests/qtest/fuzz/i440fx_fuzz.o
> > +fuzz-obj-y += tests/qtest/fuzz/virtio_net_fuzz.o
> > 
> > FUZZ_CFLAGS += -I$(SRC_PATH)/tests -I$(SRC_PATH)/tests/qtest
> > 
> > diff --git a/tests/qtest/fuzz/virtio_net_fuzz.c b/tests/qtest/fuzz/virtio_net_fuzz.c
> > new file mode 100644
> > index 0000000000..e4e3e50865
> > --- /dev/null
> > +++ b/tests/qtest/fuzz/virtio_net_fuzz.c
> > @@ -0,0 +1,195 @@
> > +/*
> > + * virtio-net Fuzzing Target
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
> > +#include "standard-headers/linux/virtio_config.h"
> > +#include "tests/qtest/libqtest.h"
> > +#include "tests/qtest/libqos/virtio-net.h"
> > +#include "fuzz.h"
> > +#include "fork_fuzz.h"
> > +#include "qos_fuzz.h"
> > +
> > +
> > +#define QVIRTIO_NET_TIMEOUT_US (30 * 1000 * 1000)
> > +#define QVIRTIO_RX_VQ 0
> > +#define QVIRTIO_TX_VQ 1
> > +#define QVIRTIO_CTRL_VQ 2
> > +
> > +static int sockfds[2];
> > +static bool sockfds_initialized;
> > +
> > +static void virtio_net_fuzz_multi(QTestState *s,
> > +        const unsigned char *Data, size_t Size, bool check_used)
> > +{
> > +    typedef struct vq_action {
> > +        uint8_t queue;
> > +        uint8_t length;
> > +        uint8_t write;
> > +        uint8_t next;
> > +        uint8_t rx;
> > +    } vq_action;
> > +
> > +    uint32_t free_head = 0;
> > +
> > +    QGuestAllocator *t_alloc = fuzz_qos_alloc;
> > +
> > +    QVirtioNet *net_if = fuzz_qos_obj;
> > +    QVirtioDevice *dev = net_if->vdev;
> > +    QVirtQueue *q;
> > +    vq_action vqa;
> > +    while (Size >= sizeof(vqa)) {
> > +        memcpy(&vqa, Data, sizeof(vqa));
> > +        Data += sizeof(vqa);
> > +        Size -= sizeof(vqa);
> > +
> > +        q = net_if->queues[vqa.queue % 3];
> > +
> > +        vqa.length = vqa.length >= Size ? Size :  vqa.length;
> > +
> > +        /*
> > +         * Only attempt to write incoming packets, when using the socket
> > +         * backend. Otherwise, always place the input on a virtqueue.
> > +         */
> > +        if (vqa.rx && sockfds_initialized) {
> > +            write(sockfds[0], Data, vqa.length);
> > +        } else {
> > +            vqa.rx = 0;
> > +            uint64_t req_addr = guest_alloc(t_alloc, vqa.length);
> > +            /*
> > +             * If checking used ring, ensure that the fuzzer doesn't trigger
> > +             * trivial asserion failure on zero-zied buffer
> > +             */
> > +            qtest_memwrite(s, req_addr, Data, vqa.length);
> > +
> > +
> > +            free_head = qvirtqueue_add(s, q, req_addr, vqa.length,
> > +                    vqa.write, vqa.next);
> > +            qvirtqueue_add(s, q, req_addr, vqa.length, vqa.write , vqa.next);
> > +            qvirtqueue_kick(s, dev, q, free_head);
> > +        }
> > +
> > +        /*
> > +         * normally, we could just use qvirtio_wait_used_elem, but since we
> > +         * must manually run the main-loop for all the bhs to run, we use
> > +         * this hack with flush_events(), to run the main_loop
> > +         */
> > +        gint64 start_time = g_get_monotonic_time();
> 
> NIT: It's a little unclear using a for(;;) when in reality, for most
> use-cases, other than virtio_net_fork_fuzz_check_used() it will
> never really loop around.
> 
> Maybe it would be clearer if the parts that never repeat were
> outside the loop? e.g.
> 
>    /* Run the main loop */
>    qtest_clock_step(s, 100);
>    flush_events(s);
> 
>    /* Poll the used vring only if we added to the TX or CTRL vq */
>    while (check_used && !vqa.rx && q != net_if->queues[QVIRTIO_RX_VQ]) {
>        uint32_t got_desc_idx;
>        /* Input led to a virtio_error */
>        if (dev->bus->get_status(dev) & VIRTIO_CONFIG_S_NEEDS_RESET) {
>            break;
>        }
>        if (dev->bus->get_queue_isr_status(dev, q) &&
>                qvirtqueue_get_buf(s, q, &got_desc_idx, NULL)) {
>            g_assert_cmpint(got_desc_idx, ==, free_head);
>            break;
>        }
>        g_assert(g_get_monotonic_time() - start_time
>                 <= QVIRTIO_NET_TIMEOUT_US);
> 
>        /* Run the main loop */
>        qtest_clock_step(s, 100);
>        flush_events(s);
>    }
> 
> Unless I'm reading it incorrectly that should do the same thing.
This is more readable and should do the same thing. I'll change it.
-Alex
> Thanks,
> 
> Darren.
> 
> > +        for (;;) {
> > +            /* Run the main loop */
> > +            qtest_clock_step(s, 100);
> > +            flush_events(s);
> > +            /* Poll the used vring only if we added to the TX or CTRL vq */
> > +            if (check_used && !vqa.rx && q != net_if->queues[QVIRTIO_RX_VQ]) {
> > +                uint32_t got_desc_idx;
> > +                /* Input led to a virtio_error */
> > +                if (dev->bus->get_status(dev) & VIRTIO_CONFIG_S_NEEDS_RESET) {
> > +                    break;
> > +                }
> > +                if (dev->bus->get_queue_isr_status(dev, q) &&
> > +                        qvirtqueue_get_buf(s, q, &got_desc_idx, NULL)) {
> > +                    g_assert_cmpint(got_desc_idx, ==, free_head);
> > +                    break;
> > +                }
> > +                g_assert(g_get_monotonic_time() - start_time
> > +                         <= QVIRTIO_NET_TIMEOUT_US);
> > +            } else {
> > +                break;
> > +            }
> > +        }
> > +        Data += vqa.length;
> > +        Size -= vqa.length;
> > +    }
> > +}
> > +
> > +static void virtio_net_fork_fuzz(QTestState *s,
> > +        const unsigned char *Data, size_t Size)
> > +{
> > +    if (fork() == 0) {
> > +        virtio_net_fuzz_multi(s, Data, Size, false);
> > +        flush_events(s);
> > +        _Exit(0);
> > +    } else {
> > +        wait(NULL);
> > +    }
> > +}
> > +
> > +static void virtio_net_fork_fuzz_check_used(QTestState *s,
> > +        const unsigned char *Data, size_t Size)
> > +{
> > +    if (fork() == 0) {
> > +        virtio_net_fuzz_multi(s, Data, Size, true);
> > +        flush_events(s);
> > +        _Exit(0);
> > +    } else {
> > +        wait(NULL);
> > +    }
> > +}
> > +
> > +static void virtio_net_pre_fuzz(QTestState *s)
> > +{
> > +    qos_init_path(s);
> > +    counter_shm_init();
> > +}
> > +
> > +static void *virtio_net_test_setup_socket(GString *cmd_line, void *arg)
> > +{
> > +    int ret = socketpair(PF_UNIX, SOCK_STREAM, 0, sockfds);
> > +    g_assert_cmpint(ret, !=, -1);
> > +    fcntl(sockfds[0], F_SETFL, O_NONBLOCK);
> > +    sockfds_initialized = true;
> > +    g_string_append_printf(cmd_line, " -netdev socket,fd=%d,id=hs0 ",
> > +                           sockfds[1]);
> > +    return arg;
> > +}
> > +
> > +static void *virtio_net_test_setup_user(GString *cmd_line, void *arg)
> > +{
> > +    g_string_append_printf(cmd_line, " -netdev user,id=hs0 ");
> > +    return arg;
> > +}
> > +
> > +static void register_virtio_net_fuzz_targets(void)
> > +{
> > +    fuzz_add_qos_target(&(FuzzTarget){
> > +            .name = "virtio-net-socket",
> > +            .description = "Fuzz the virtio-net virtual queues. Fuzz incoming "
> > +            "traffic using the socket backend",
> > +            .pre_fuzz = &virtio_net_pre_fuzz,
> > +            .fuzz = virtio_net_fork_fuzz,},
> > +            "virtio-net",
> > +            &(QOSGraphTestOptions){.before = virtio_net_test_setup_socket}
> > +            );
> > +
> > +    fuzz_add_qos_target(&(FuzzTarget){
> > +            .name = "virtio-net-socket-check-used",
> > +            .description = "Fuzz the virtio-net virtual queues. Wait for the "
> > +            "descriptors to be used. Timeout may indicate improperly handled "
> > +            "input",
> > +            .pre_fuzz = &virtio_net_pre_fuzz,
> > +            .fuzz = virtio_net_fork_fuzz_check_used,},
> > +            "virtio-net",
> > +            &(QOSGraphTestOptions){.before = virtio_net_test_setup_socket}
> > +            );
> > +    fuzz_add_qos_target(&(FuzzTarget){
> > +            .name = "virtio-net-slirp",
> > +            .description = "Fuzz the virtio-net virtual queues with the slirp "
> > +            " backend. Warning: May result in network traffic emitted from the "
> > +            " process. Run in an isolated network environment.",
> 
> NIT: s/" /"/    (fix double-spaces)
> 
> > +            .pre_fuzz = &virtio_net_pre_fuzz,
> > +            .fuzz = virtio_net_fork_fuzz,},
> > +            "virtio-net",
> > +            &(QOSGraphTestOptions){.before = virtio_net_test_setup_user}
> > +            );
> > +}
> > +
> > +fuzz_target_init(register_virtio_net_fuzz_targets);
> > -- 
> > 2.23.0
> > 
> > 

