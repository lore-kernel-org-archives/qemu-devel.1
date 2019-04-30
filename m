Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA72C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 06:22:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 098FE20835
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 06:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 098FE20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39773 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLMAB-00030M-76
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 02:22:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1hLM9N-0002jH-5k
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 02:21:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1hLM9M-0006tT-0w
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 02:21:57 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2206 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <longpeng2@huawei.com>)
	id 1hLM9L-0006sn-Mo
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 02:21:55 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
	by Forcepoint Email with ESMTP id 2CDEFAF21C196068A508;
	Tue, 30 Apr 2019 14:21:51 +0800 (CST)
Received: from localhost (10.177.246.209) by DGGEMS407-HUB.china.huawei.com
	(10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Tue, 30 Apr 2019
	14:21:44 +0800
From: "Longpeng(Mike)" <longpeng2@huawei.com>
To: <kraxel@redhat.com>
Date: Tue, 30 Apr 2019 14:21:41 +0800
Message-ID: <1556605301-44112-1-git-send-email-longpeng2@huawei.com>
X-Mailer: git-send-email 1.8.4.msysgit.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [10.177.246.209]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.190
Subject: [Qemu-devel] [PATCH v2] usb/xchi: avoid trigger assertion if guest
 write wrong epid
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Longpeng <longpeng2@huawei.com>, Gonglei <arei.gonglei@huawei.com>,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430062141.tMXMdLyR0sTkPWlCr7VW87b0Ls7PqZF5-28SfGZB4RQ@z>

From: Longpeng <longpeng2@huawei.com>

we found the following core in our environment:
0  0x00007fc6b06c2237 in raise ()
1  0x00007fc6b06c3928 in abort ()
2  0x00007fc6b06bb056 in __assert_fail_base ()
3  0x00007fc6b06bb102 in __assert_fail ()
4  0x0000000000702e36 in xhci_kick_ep (...)
5  0x000000000047897a in memory_region_write_accessor (...)
6  0x000000000047767f in access_with_adjusted_size (...)
7  0x000000000047944d in memory_region_dispatch_write (...)
(mr=3Dmr@entry=3D0x7fc6a0138df0, addr=3Daddr@entry=3D156, data=3D16488924=
16,
size=3Dsize@entry=3D4, attrs=3Dattrs@entry=3D...)
8  0x000000000042df17 in address_space_write_continue (...)
10 0x000000000043084d in address_space_rw (...)
11 0x000000000047451b in kvm_cpu_exec (cpu=3Dcpu@entry=3D0x1ab11b0)
12 0x000000000045dcf5 in qemu_kvm_cpu_thread_fn (arg=3D0x1ab11b0)
13 0x0000000000870631 in qemu_thread_start (args=3Dargs@entry=3D0x1acfb50=
)
14 0x00000000008959a7 in thread_entry_for_hotfix (pthread_cb=3D<optimized=
 out>)
15 0x00007fc6b0a60dd5 in start_thread ()
16 0x00007fc6b078a59d in clone ()

(gdb) f 5
5  0x000000000047897a in memory_region_write_accessor (...)
529	    mr->ops->write(mr->opaque, addr, tmp, size);
(gdb) p /x tmp
$9 =3D 0x62481a00 <-- last byte 0x00 is @epid

xhci_doorbell_write() already check the upper bound of @slotid an @epid,
it also need to check the lower bound.

Cc: Gonglei <arei.gonglei@huawei.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Longpeng <longpeng2@huawei.com>
---
v1 -> v2:
  1) update the description, include the full backtrace
  2) remove unnecessary check: 'reg =3D=3D 0'

---
 hw/usb/hcd-xhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index ec28bee..d8472b4 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -3137,7 +3137,7 @@ static void xhci_doorbell_write(void *ptr, hwaddr r=
eg,
         streamid =3D (val >> 16) & 0xffff;
         if (reg > xhci->numslots) {
             DPRINTF("xhci: bad doorbell %d\n", (int)reg);
-        } else if (epid > 31) {
+        } else if (epid =3D=3D 0 || epid > 31) {
             DPRINTF("xhci: bad doorbell %d write: 0x%x\n",
                     (int)reg, (uint32_t)val);
         } else {
--=20
1.8.3.1



