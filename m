Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56421C35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:58:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DF642082E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NzZkx6aD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DF642082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izLCO-0000ad-30
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 08:58:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57609)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <darren.kenny@oracle.com>) id 1izLBh-0008Mx-Dk
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:57:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <darren.kenny@oracle.com>) id 1izLBf-0003qg-HC
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:57:52 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:59010)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
 id 1izLBf-0003nW-3Q
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:57:51 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015DmAPQ114368;
 Wed, 5 Feb 2020 13:57:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=C1bRGOAmb7DgCdzKEGg4B6wmnlI+0HhCTUiq2/2o7as=;
 b=NzZkx6aD6Rv7M3pkc3msbFOT9B1UWSgiyXKz75G+KObAhEXhqBDTzRIyPYd/yB5k7tRO
 w+ITKii7dkibu3HwvgedCrcZZh3hRo8Kjmu3nPu9WNZ3963mpRO/aVc9A5MGA9liehoM
 YuH6l4BGzWGX7sey65EhfgsS5J7UXz0e8sKwWjUBC1uAoi/EObzaI352yhivNqHVSC5X
 Y+Js+2pfQ4geIo5Yub6B0oomXI6aecZjC/UyV0/yc5EgLE8Vrbyt0i5+UfYwlNS74SJU
 LrMJvoTLbcYNij0iph73zEquIocRLd0NUkrCHWnFL5oyG6Vx91rGnDhRFDXUAXGPX+m3 Ww== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 2xykbpb4c3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2020 13:57:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015DiMDi017867;
 Wed, 5 Feb 2020 13:57:47 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 2xykbrwu0p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2020 13:57:47 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 015Dvjw8014337;
 Wed, 5 Feb 2020 13:57:46 GMT
Received: from starbug-mbp.localdomain (/10.169.111.17)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 05 Feb 2020 05:57:45 -0800
Received: from starbug-mbp (localhost [127.0.0.1])
 by starbug-mbp.localdomain (Postfix) with SMTP id 110E157DC554;
 Wed,  5 Feb 2020 13:57:40 +0000 (GMT)
Date: Wed, 5 Feb 2020 13:57:40 +0000
From: Darren Kenny <darren.kenny@oracle.com>
To: "Bulekov, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v8 19/21] fuzz: add virtio-net fuzz target
Message-ID: <20200205135740.f6o22uy5ss7bzoj2@starbug-mbp>
Mail-Followup-To: "Bulekov, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
References: <20200129053357.27454-1-alxndr@bu.edu>
 <20200129053357.27454-20-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200129053357.27454-20-alxndr@bu.edu>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002050110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002050110
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "bsd@redhat.com" <bsd@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 29, 2020 at 05:34:27AM +0000, Bulekov, Alexander wrote:
>The virtio-net fuzz target feeds inputs to all three virtio-net
>virtqueues, and uses forking to avoid leaking state between fuzz runs.
>
>Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
>---
> tests/qtest/fuzz/Makefile.include  |   1 +
> tests/qtest/fuzz/virtio_net_fuzz.c | 195 +++++++++++++++++++++++++++++
> 2 files changed, 196 insertions(+)
> create mode 100644 tests/qtest/fuzz/virtio_net_fuzz.c
>
>diff --git a/tests/qtest/fuzz/Makefile.include b/tests/qtest/fuzz/Makefile.include
>index 38b8cdd9f1..77385777ef 100644
>--- a/tests/qtest/fuzz/Makefile.include
>+++ b/tests/qtest/fuzz/Makefile.include
>@@ -8,6 +8,7 @@ fuzz-obj-y += tests/qtest/fuzz/qos_fuzz.o
>
> # Targets
> fuzz-obj-y += tests/qtest/fuzz/i440fx_fuzz.o
>+fuzz-obj-y += tests/qtest/fuzz/virtio_net_fuzz.o
>
> FUZZ_CFLAGS += -I$(SRC_PATH)/tests -I$(SRC_PATH)/tests/qtest
>
>diff --git a/tests/qtest/fuzz/virtio_net_fuzz.c b/tests/qtest/fuzz/virtio_net_fuzz.c
>new file mode 100644
>index 0000000000..e4e3e50865
>--- /dev/null
>+++ b/tests/qtest/fuzz/virtio_net_fuzz.c
>@@ -0,0 +1,195 @@
>+/*
>+ * virtio-net Fuzzing Target
>+ *
>+ * Copyright Red Hat Inc., 2019
>+ *
>+ * Authors:
>+ *  Alexander Bulekov   <alxndr@bu.edu>
>+ *
>+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
>+ * See the COPYING file in the top-level directory.
>+ */
>+
>+#include "qemu/osdep.h"
>+
>+#include "standard-headers/linux/virtio_config.h"
>+#include "tests/qtest/libqtest.h"
>+#include "tests/qtest/libqos/virtio-net.h"
>+#include "fuzz.h"
>+#include "fork_fuzz.h"
>+#include "qos_fuzz.h"
>+
>+
>+#define QVIRTIO_NET_TIMEOUT_US (30 * 1000 * 1000)
>+#define QVIRTIO_RX_VQ 0
>+#define QVIRTIO_TX_VQ 1
>+#define QVIRTIO_CTRL_VQ 2
>+
>+static int sockfds[2];
>+static bool sockfds_initialized;
>+
>+static void virtio_net_fuzz_multi(QTestState *s,
>+        const unsigned char *Data, size_t Size, bool check_used)
>+{
>+    typedef struct vq_action {
>+        uint8_t queue;
>+        uint8_t length;
>+        uint8_t write;
>+        uint8_t next;
>+        uint8_t rx;
>+    } vq_action;
>+
>+    uint32_t free_head = 0;
>+
>+    QGuestAllocator *t_alloc = fuzz_qos_alloc;
>+
>+    QVirtioNet *net_if = fuzz_qos_obj;
>+    QVirtioDevice *dev = net_if->vdev;
>+    QVirtQueue *q;
>+    vq_action vqa;
>+    while (Size >= sizeof(vqa)) {
>+        memcpy(&vqa, Data, sizeof(vqa));
>+        Data += sizeof(vqa);
>+        Size -= sizeof(vqa);
>+
>+        q = net_if->queues[vqa.queue % 3];
>+
>+        vqa.length = vqa.length >= Size ? Size :  vqa.length;
>+
>+        /*
>+         * Only attempt to write incoming packets, when using the socket
>+         * backend. Otherwise, always place the input on a virtqueue.
>+         */
>+        if (vqa.rx && sockfds_initialized) {
>+            write(sockfds[0], Data, vqa.length);
>+        } else {
>+            vqa.rx = 0;
>+            uint64_t req_addr = guest_alloc(t_alloc, vqa.length);
>+            /*
>+             * If checking used ring, ensure that the fuzzer doesn't trigger
>+             * trivial asserion failure on zero-zied buffer
>+             */
>+            qtest_memwrite(s, req_addr, Data, vqa.length);
>+
>+
>+            free_head = qvirtqueue_add(s, q, req_addr, vqa.length,
>+                    vqa.write, vqa.next);
>+            qvirtqueue_add(s, q, req_addr, vqa.length, vqa.write , vqa.next);
>+            qvirtqueue_kick(s, dev, q, free_head);
>+        }
>+
>+        /*
>+         * normally, we could just use qvirtio_wait_used_elem, but since we
>+         * must manually run the main-loop for all the bhs to run, we use
>+         * this hack with flush_events(), to run the main_loop
>+         */
>+        gint64 start_time = g_get_monotonic_time();

NIT: It's a little unclear using a for(;;) when in reality, for most
use-cases, other than virtio_net_fork_fuzz_check_used() it will
never really loop around.

Maybe it would be clearer if the parts that never repeat were
outside the loop? e.g.

    /* Run the main loop */
    qtest_clock_step(s, 100);
    flush_events(s);

    /* Poll the used vring only if we added to the TX or CTRL vq */
    while (check_used && !vqa.rx && q != net_if->queues[QVIRTIO_RX_VQ]) {
        uint32_t got_desc_idx;
        /* Input led to a virtio_error */
        if (dev->bus->get_status(dev) & VIRTIO_CONFIG_S_NEEDS_RESET) {
            break;
        }
        if (dev->bus->get_queue_isr_status(dev, q) &&
                qvirtqueue_get_buf(s, q, &got_desc_idx, NULL)) {
            g_assert_cmpint(got_desc_idx, ==, free_head);
            break;
        }
        g_assert(g_get_monotonic_time() - start_time
                 <= QVIRTIO_NET_TIMEOUT_US);

        /* Run the main loop */
        qtest_clock_step(s, 100);
        flush_events(s);
    }

Unless I'm reading it incorrectly that should do the same thing.

Thanks,

Darren.

>+        for (;;) {
>+            /* Run the main loop */
>+            qtest_clock_step(s, 100);
>+            flush_events(s);
>+            /* Poll the used vring only if we added to the TX or CTRL vq */
>+            if (check_used && !vqa.rx && q != net_if->queues[QVIRTIO_RX_VQ]) {
>+                uint32_t got_desc_idx;
>+                /* Input led to a virtio_error */
>+                if (dev->bus->get_status(dev) & VIRTIO_CONFIG_S_NEEDS_RESET) {
>+                    break;
>+                }
>+                if (dev->bus->get_queue_isr_status(dev, q) &&
>+                        qvirtqueue_get_buf(s, q, &got_desc_idx, NULL)) {
>+                    g_assert_cmpint(got_desc_idx, ==, free_head);
>+                    break;
>+                }
>+                g_assert(g_get_monotonic_time() - start_time
>+                         <= QVIRTIO_NET_TIMEOUT_US);
>+            } else {
>+                break;
>+            }
>+        }
>+        Data += vqa.length;
>+        Size -= vqa.length;
>+    }
>+}
>+
>+static void virtio_net_fork_fuzz(QTestState *s,
>+        const unsigned char *Data, size_t Size)
>+{
>+    if (fork() == 0) {
>+        virtio_net_fuzz_multi(s, Data, Size, false);
>+        flush_events(s);
>+        _Exit(0);
>+    } else {
>+        wait(NULL);
>+    }
>+}
>+
>+static void virtio_net_fork_fuzz_check_used(QTestState *s,
>+        const unsigned char *Data, size_t Size)
>+{
>+    if (fork() == 0) {
>+        virtio_net_fuzz_multi(s, Data, Size, true);
>+        flush_events(s);
>+        _Exit(0);
>+    } else {
>+        wait(NULL);
>+    }
>+}
>+
>+static void virtio_net_pre_fuzz(QTestState *s)
>+{
>+    qos_init_path(s);
>+    counter_shm_init();
>+}
>+
>+static void *virtio_net_test_setup_socket(GString *cmd_line, void *arg)
>+{
>+    int ret = socketpair(PF_UNIX, SOCK_STREAM, 0, sockfds);
>+    g_assert_cmpint(ret, !=, -1);
>+    fcntl(sockfds[0], F_SETFL, O_NONBLOCK);
>+    sockfds_initialized = true;
>+    g_string_append_printf(cmd_line, " -netdev socket,fd=%d,id=hs0 ",
>+                           sockfds[1]);
>+    return arg;
>+}
>+
>+static void *virtio_net_test_setup_user(GString *cmd_line, void *arg)
>+{
>+    g_string_append_printf(cmd_line, " -netdev user,id=hs0 ");
>+    return arg;
>+}
>+
>+static void register_virtio_net_fuzz_targets(void)
>+{
>+    fuzz_add_qos_target(&(FuzzTarget){
>+            .name = "virtio-net-socket",
>+            .description = "Fuzz the virtio-net virtual queues. Fuzz incoming "
>+            "traffic using the socket backend",
>+            .pre_fuzz = &virtio_net_pre_fuzz,
>+            .fuzz = virtio_net_fork_fuzz,},
>+            "virtio-net",
>+            &(QOSGraphTestOptions){.before = virtio_net_test_setup_socket}
>+            );
>+
>+    fuzz_add_qos_target(&(FuzzTarget){
>+            .name = "virtio-net-socket-check-used",
>+            .description = "Fuzz the virtio-net virtual queues. Wait for the "
>+            "descriptors to be used. Timeout may indicate improperly handled "
>+            "input",
>+            .pre_fuzz = &virtio_net_pre_fuzz,
>+            .fuzz = virtio_net_fork_fuzz_check_used,},
>+            "virtio-net",
>+            &(QOSGraphTestOptions){.before = virtio_net_test_setup_socket}
>+            );
>+    fuzz_add_qos_target(&(FuzzTarget){
>+            .name = "virtio-net-slirp",
>+            .description = "Fuzz the virtio-net virtual queues with the slirp "
>+            " backend. Warning: May result in network traffic emitted from the "
>+            " process. Run in an isolated network environment.",

NIT: s/" /"/    (fix double-spaces)

>+            .pre_fuzz = &virtio_net_pre_fuzz,
>+            .fuzz = virtio_net_fork_fuzz,},
>+            "virtio-net",
>+            &(QOSGraphTestOptions){.before = virtio_net_test_setup_user}
>+            );
>+}
>+
>+fuzz_target_init(register_virtio_net_fuzz_targets);
>-- 
>2.23.0
>
>

