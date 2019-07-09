Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED2BC004EF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 11:43:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16AC5214AF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 11:43:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16AC5214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkoXG-0000J7-09
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 07:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46351)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hkoRH-0004YG-3I
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 07:37:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hkoRF-0007EN-7C
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 07:37:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44892)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hkoR6-00078Z-NK; Tue, 09 Jul 2019 07:37:30 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EADE77FDCC;
 Tue,  9 Jul 2019 11:37:26 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-166.brq.redhat.com [10.40.204.166])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D977392AEC;
 Tue,  9 Jul 2019 11:37:24 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 13:37:14 +0200
Message-Id: <20190709113715.7761-3-philmd@redhat.com>
In-Reply-To: <20190709113715.7761-1-philmd@redhat.com>
References: <20190709113715.7761-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 09 Jul 2019 11:37:27 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH-for-4.1 2/3] hw/ssi/mss-spi: Avoid crash when
 reading empty RX FIFO
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

Reading the RX_DATA register when the RX_FIFO is empty triggers
an abort. This can be easily reproduced:

  $ qemu-system-arm -M emcraft-sf2 -monitor stdio -S
  QEMU 4.0.50 monitor - type 'help' for more information
  (qemu) x 0x40001010
  Aborted (core dumped)

  (gdb) bt
  #1  0x00007f035874f895 in abort () at /lib64/libc.so.6
  #2  0x00005628686591ff in fifo8_pop (fifo=3D0x56286a9a4c68) at util/fif=
o8.c:66
  #3  0x00005628683e0b8e in fifo32_pop (fifo=3D0x56286a9a4c68) at include=
/qemu/fifo32.h:137
  #4  0x00005628683e0efb in spi_read (opaque=3D0x56286a9a4850, addr=3D4, =
size=3D4) at hw/ssi/mss-spi.c:168
  #5  0x0000562867f96801 in memory_region_read_accessor (mr=3D0x56286a9a4=
b60, addr=3D16, value=3D0x7ffeecb0c5c8, size=3D4, shift=3D0, mask=3D42949=
67295, attrs=3D...) at memory.c:439
  #6  0x0000562867f96cdb in access_with_adjusted_size (addr=3D16, value=3D=
0x7ffeecb0c5c8, size=3D4, access_size_min=3D1, access_size_max=3D4, acces=
s_fn=3D0x562867f967c3 <memory_region_read_accessor>, mr=3D0x56286a9a4b60,=
 attrs=3D...) at memory.c:569
  #7  0x0000562867f99940 in memory_region_dispatch_read1 (mr=3D0x56286a9a=
4b60, addr=3D16, pval=3D0x7ffeecb0c5c8, size=3D4, attrs=3D...) at memory.=
c:1420
  #8  0x0000562867f99a08 in memory_region_dispatch_read (mr=3D0x56286a9a4=
b60, addr=3D16, pval=3D0x7ffeecb0c5c8, size=3D4, attrs=3D...) at memory.c=
:1447
  #9  0x0000562867f38721 in flatview_read_continue (fv=3D0x56286aec6360, =
addr=3D1073745936, attrs=3D..., buf=3D0x7ffeecb0c7c0 "\340=C7=B0\354\376\=
177", len=3D4, addr1=3D16, l=3D4, mr=3D0x56286a9a4b60) at exec.c:3385
  #10 0x0000562867f38874 in flatview_read (fv=3D0x56286aec6360, addr=3D10=
73745936, attrs=3D..., buf=3D0x7ffeecb0c7c0 "\340=C7=B0\354\376\177", len=
=3D4) at exec.c:3423
  #11 0x0000562867f388ea in address_space_read_full (as=3D0x56286aa3e890,=
 addr=3D1073745936, attrs=3D..., buf=3D0x7ffeecb0c7c0 "\340=C7=B0\354\376=
\177", len=3D4) at exec.c:3436
  #12 0x0000562867f389c5 in address_space_rw (as=3D0x56286aa3e890, addr=3D=
1073745936, attrs=3D..., buf=3D0x7ffeecb0c7c0 "\340=C7=B0\354\376\177", l=
en=3D4, is_write=3Dfalse) at exec.c:3466
  #13 0x0000562867f3bdd7 in cpu_memory_rw_debug (cpu=3D0x56286aa19d00, ad=
dr=3D1073745936, buf=3D0x7ffeecb0c7c0 "\340=C7=B0\354\376\177", len=3D4, =
is_write=3D0) at exec.c:3976
  #14 0x000056286811ed51 in memory_dump (mon=3D0x56286a8c32d0, count=3D1,=
 format=3D120, wsize=3D4, addr=3D1073745936, is_physical=3D0) at monitor/=
misc.c:730
  #15 0x000056286811eff1 in hmp_memory_dump (mon=3D0x56286a8c32d0, qdict=3D=
0x56286b15c400) at monitor/misc.c:785
  #16 0x00005628684740ee in handle_hmp_command (mon=3D0x56286a8c32d0, cmd=
line=3D0x56286a8caeb2 "0x40001010") at monitor/hmp.c:1082

From the datasheet "Actel SmartFusion Microcontroller Subsystem
User's Guide" Rev.1, Table 13-3 "SPI Register Summary", this
register has a reset value of 0.

Check the FIFO is not empty before accessing it, else log an
error message.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/ssi/mss-spi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/ssi/mss-spi.c b/hw/ssi/mss-spi.c
index 4878279482..3201a577a1 100644
--- a/hw/ssi/mss-spi.c
+++ b/hw/ssi/mss-spi.c
@@ -155,7 +155,13 @@ spi_read(void *opaque, hwaddr addr, unsigned int siz=
e)
     case R_SPI_RX:
         s->regs[R_SPI_STATUS] &=3D ~S_RXFIFOFUL;
         s->regs[R_SPI_STATUS] &=3D ~S_RXCHOVRF;
-        ret =3D fifo32_pop(&s->rx_fifo);
+        if (fifo32_is_empty(&s->rx_fifo)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Reading empty RX_FIFO\n",
+                          __func__);
+        } else {
+            ret =3D fifo32_pop(&s->rx_fifo);
+        }
         if (fifo32_is_empty(&s->rx_fifo)) {
             s->regs[R_SPI_STATUS] |=3D S_RXFIFOEMP;
         }
--=20
2.20.1


