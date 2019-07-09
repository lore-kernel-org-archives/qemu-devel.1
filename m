Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F796C004EF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 11:39:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B88A214AF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 11:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B88A214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkoSu-0005mk-6p
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 07:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46383)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hkoRI-0004Yz-VF
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 07:37:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hkoRH-0007GK-9N
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 07:37:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38084)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hkoR8-0007AL-M9; Tue, 09 Jul 2019 07:37:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7EAC888311;
 Tue,  9 Jul 2019 11:37:29 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-166.brq.redhat.com [10.40.204.166])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DFE992AEC;
 Tue,  9 Jul 2019 11:37:27 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 13:37:15 +0200
Message-Id: <20190709113715.7761-4-philmd@redhat.com>
In-Reply-To: <20190709113715.7761-1-philmd@redhat.com>
References: <20190709113715.7761-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Tue, 09 Jul 2019 11:37:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH-for-4.1 3/3] hw/display/xlnx_dp: Avoid crash
 when reading empty RX FIFO
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-arm@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In the previous commit we fixed a crash when the guest read a
register that pop from an empty FIFO.
By auditing the repository, we found another similar use with
an easy way to reproduce:

  $ qemu-system-aarch64 -M xlnx-zcu102 -monitor stdio -S
  QEMU 4.0.50 monitor - type 'help' for more information
  (qemu) xp/b 0xfd4a0134
  Aborted (core dumped)

  (gdb) bt
  #0  0x00007f6936dea57f in raise () at /lib64/libc.so.6
  #1  0x00007f6936dd4895 in abort () at /lib64/libc.so.6
  #2  0x0000561ad32975ec in xlnx_dp_aux_pop_rx_fifo (s=3D0x7f692babee70) =
at hw/display/xlnx_dp.c:431
  #3  0x0000561ad3297dc0 in xlnx_dp_read (opaque=3D0x7f692babee70, offset=
=3D77, size=3D4) at hw/display/xlnx_dp.c:667
  #4  0x0000561ad321b896 in memory_region_read_accessor (mr=3D0x7f692babf=
620, addr=3D308, value=3D0x7ffe05c1db88, size=3D4, shift=3D0, mask=3D4294=
967295, attrs=3D...) at memory.c:439
  #5  0x0000561ad321bd70 in access_with_adjusted_size (addr=3D308, value=3D=
0x7ffe05c1db88, size=3D1, access_size_min=3D4, access_size_max=3D4, acces=
s_fn=3D0x561ad321b858 <memory_region_read_accessor>, mr=3D0x7f692babf620,=
 attrs=3D...) at memory.c:569
  #6  0x0000561ad321e9d5 in memory_region_dispatch_read1 (mr=3D0x7f692bab=
f620, addr=3D308, pval=3D0x7ffe05c1db88, size=3D1, attrs=3D...) at memory=
.c:1420
  #7  0x0000561ad321ea9d in memory_region_dispatch_read (mr=3D0x7f692babf=
620, addr=3D308, pval=3D0x7ffe05c1db88, size=3D1, attrs=3D...) at memory.=
c:1447
  #8  0x0000561ad31bd742 in flatview_read_continue (fv=3D0x561ad69c04f0, =
addr=3D4249485620, attrs=3D..., buf=3D0x7ffe05c1dcf0 "\020\335\301\005\37=
6\177", len=3D1, addr1=3D308, l=3D1, mr=3D0x7f692babf620) at exec.c:3385
  #9  0x0000561ad31bd895 in flatview_read (fv=3D0x561ad69c04f0, addr=3D42=
49485620, attrs=3D..., buf=3D0x7ffe05c1dcf0 "\020\335\301\005\376\177", l=
en=3D1) at exec.c:3423
  #10 0x0000561ad31bd90b in address_space_read_full (as=3D0x561ad5bb3020,=
 addr=3D4249485620, attrs=3D..., buf=3D0x7ffe05c1dcf0 "\020\335\301\005\3=
76\177", len=3D1) at exec.c:3436
  #11 0x0000561ad33b1c42 in address_space_read (len=3D1, buf=3D0x7ffe05c1=
dcf0 "\020\335\301\005\376\177", attrs=3D..., addr=3D4249485620, as=3D0x5=
61ad5bb3020) at include/exec/memory.h:2131
  #12 0x0000561ad33b1c42 in memory_dump (mon=3D0x561ad59c4530, count=3D1,=
 format=3D120, wsize=3D1, addr=3D4249485620, is_physical=3D1) at monitor/=
misc.c:723
  #13 0x0000561ad33b1fc1 in hmp_physical_memory_dump (mon=3D0x561ad59c453=
0, qdict=3D0x561ad6c6fd00) at monitor/misc.c:795
  #14 0x0000561ad37b4a9f in handle_hmp_command (mon=3D0x561ad59c4530, cmd=
line=3D0x561ad59d0f22 "/b 0x00000000fd4a0134") at monitor/hmp.c:1082

Fix by checking the FIFO is not empty before popping from it.

The datasheet is not clear about the reset value of this register,
we choose to return '0'.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/display/xlnx_dp.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index cfd4c700b7..cc5b650df0 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -427,11 +427,18 @@ static uint8_t xlnx_dp_aux_pop_rx_fifo(XlnxDPState =
*s)
     uint8_t ret;
=20
     if (fifo8_is_empty(&s->rx_fifo)) {
-        DPRINTF("rx_fifo underflow..\n");
-        abort();
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Reading empty RX_FIFO\n",
+                      __func__);
+        /*
+         * The datasheet is not clear about the reset value, it seems
+         * to be unspecified. We choose to return '0'.
+         */
+        ret =3D 0;
+    } else {
+        ret =3D fifo8_pop(&s->rx_fifo);
+        DPRINTF("pop 0x%" PRIX8 " from rx_fifo.\n", ret);
     }
-    ret =3D fifo8_pop(&s->rx_fifo);
-    DPRINTF("pop 0x%" PRIX8 " from rx_fifo.\n", ret);
     return ret;
 }
=20
--=20
2.20.1


