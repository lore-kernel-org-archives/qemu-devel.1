Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D066BC11D2B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 04:25:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88C5B2465D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 04:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bpQtcjbB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88C5B2465D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4zsR-0004Z3-Mw
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 23:25:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48116)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gshan@redhat.com>) id 1j4zrW-00042R-R7
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 23:24:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gshan@redhat.com>) id 1j4zrU-0007RX-Ay
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 23:24:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38101
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gshan@redhat.com>) id 1j4zrU-0007PG-4W
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 23:24:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582259063;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ha8HUzSfdDW7EZpUY09Z06RbzzpC9F7Eebh6jMS4CJ4=;
 b=bpQtcjbBlqHC/vLIH40QvK4CSUviq+dtMbcPExUl11X22zNYN9gKqM2LpGL1hEMhKnfprh
 rer5KLYx4mmrg8LjEzkfyb7e0WNkMp1wTesTAl+odtcuav+gMHqymdYYvuz2BXa6NkFTK2
 cO1TfuqMFQaqysSfaZv9eK70fBM0ucU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-H1P04UmTMeqiDDpGt73fcg-1; Thu, 20 Feb 2020 23:24:17 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70BF113F6;
 Fri, 21 Feb 2020 04:24:16 +0000 (UTC)
Received: from localhost.localdomain (vpn2-54-80.bne.redhat.com [10.64.54.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 788505D9C5;
 Fri, 21 Feb 2020 04:24:14 +0000 (UTC)
Subject: Re: [PATCH] hw/char/pl011: Output characters using best-effort mode
To: Peter Maydell <peter.maydell@linaro.org>, Marc Zyngier <maz@kernel.org>
References: <20200220060108.143668-1-gshan@redhat.com>
 <f3c8adba729d050ba2144cc9c834fe82@kernel.org>
 <CAFEAcA8inLO75XOcCO3bUiiJQyZT+nqmp1be+z6ZtQx2a=68+g@mail.gmail.com>
From: Gavin Shan <gshan@redhat.com>
Message-ID: <fda602ae-43d5-728c-a5bb-f607f0acd3df@redhat.com>
Date: Fri, 21 Feb 2020 15:24:11 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8inLO75XOcCO3bUiiJQyZT+nqmp1be+z6ZtQx2a=68+g@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: H1P04UmTMeqiDDpGt73fcg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed; boundary="------------6EF41B11D44FC8C5AC0DCE6D"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Reply-To: Gavin Shan <gshan@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Shan Gavin <shan.gavin@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------6EF41B11D44FC8C5AC0DCE6D
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Peter and Marc,

On 2/20/20 9:10 PM, Peter Maydell wrote:
> On Thu, 20 Feb 2020 at 09:10, Marc Zyngier <maz@kernel.org> wrote:
>> On 2020-02-20 06:01, Gavin Shan wrote:
>>> This fixes the issue by using newly added API
>>> qemu_chr_fe_try_write_all(),
>>> which provides another type of service (best-effort). It's different
>>> from
>>> qemu_chr_fe_write_all() as the data will be dropped if the backend has
>>> been running into so-called broken state or 50 attempts of
>>> transmissions.
>>> The broken state is cleared if the data is transmitted at once.
>>
>> I don't think dropping the serial port output is an acceptable outcome.
> 
> Agreed. The correct fix for this is the one cryptically described
> in the XXX comment this patch deletes:
> 
> -        /* XXX this blocks entire thread. Rewrite to use
> -         * qemu_chr_fe_write and background I/O callbacks */
> 
> The idea is that essentially we end up emulating the real
> hardware's transmit FIFO:
>   * as data arrives from the guest we put it in the FIFO
>   * we try to send the data with qemu_chr_fe_write(), which does
>     not block
>   * if qemu_chr_fe_write() tells us it did not send all the data,
>     we use qemu_chr_fe_add_watch() to set up an I/O callback
>     which will get called when the output chardev has drained
>     enough that we can try again
>   * we make sure all the guest visible registers and mechanisms
>     for tracking tx fifo level (status bits, interrupts, etc) are
>     correctly wired up
> 
> Then we don't lose data or block QEMU if the guest sends
> faster than the chardev backend can handle, assuming the
> guest is well-behaved -- just as with a real hardware slow
> serial port, the guest will fill the tx fifo and then either poll
> or wait for an interrupt telling it that the fifo has drained
> before it tries to send more data.
> 
> There is an example of this in hw/char/cadence_uart.c
> (and an example of how it works for a UART with no tx
> fifo in hw/char-cmsdk-apb-uart.c, which is basically the
> same except the 'fifo' is just one byte.)
> 
> You will also find an awful lot of XXX comments like the
> above one in various UART models in hw/char, because
> converting an old-style simple blocking UART implementation
> to a non-blocking one is a bit fiddly and needs knowledge
> of the specifics of the UART behaviour.
> 
> The other approach here would be that we could add
> options to relevant chardev backends so the user
> could say "if you couldn't connect to the tcp server I
> specified, throw away data rather than waiting", where
> we don't have suitable options already. If the user specifically
> tells us they're ok to throw away the serial data, then it's
> fine to throw away the serial data :-)
> 

I was intended to convince Marc that it's fine to lose data if the
serial connection is broken with an example. Now, I'm taking the
example trying to convince both of you: Lets assume we have a ARM
board and the UART (RS232) cable is unplugged and plugged in the middle of
system booting. I think we would get some output lost. We're emulating
pl011 and I think it would have same behavior. However, I'm not sure
if it makes sense :)

Peter, I don't think qemu_chr_fe_add_watch() can help on the issue of
blocking system from booting. I had the code to use qemu_chr_fe_add_watch()
in pl011 driver as the attachment shows. The attached patch will be posted
for review shortly as I think it's valuable to support 16-character-in-depth
TxFIFO. The linux guest can't boot successfully if I had some code to strike
the early console. The serial is built on tcp connection (127.0.0.1:50900)
and the server side don't receive the incoming messages, as before. The root
cause is guest kernel is hold until the TxFIFO has available space. On the
other hand, the QEMU can't send the characters in TxFIFO to the backend
successfully, which means the TxFIFO is always full.

For the guest kernel, linux/drivers/tty/serial/amba-pl011.c::pl011_putc() is
used to write outgoing characters to TxFIFO. The transmission can't be finished
if there is no space in TxFIFO, indicated by UART01x_FR_TXFF.

    static void pl011_putc(struct uart_port *port, int c)
    {
            while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
                    cpu_relax();
            if (port->iotype == UPIO_MEM32)
                    writel(c, port->membase + UART01x_DR);
            else
                    writeb(c, port->membase + UART01x_DR);
            while (readl(port->membase + UART01x_FR) & UART01x_FR_BUSY)
                    cpu_relax();
    }

If above analysis is correct and the first approach doesn't work out. We have to
consider the 2nd approach - adding option to backend to allow losing data. I'm
going to add "allow-data-lost" option for TYPE_CHARDEV_SOCKET. With the option,
a back-off algorithm in tcp_chr_write(): The channel is consider as broken if
it fails to transmit data in last continuous 5 times. The transmission is still
issued when the channel is in broken state and recovered to normal state if
transmission succeeds for once.

Thanks,
Gavin





--------------6EF41B11D44FC8C5AC0DCE6D
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-hw-char-pl011-Support-TxFIFO-and-async-transmission.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-hw-char-pl011-Support-TxFIFO-and-async-transmission.pat";
 filename*1="ch"

From 7bd4a1b35b6351bc358c539e49b3a1600a124c8d Mon Sep 17 00:00:00 2001
From: Gavin Shan <gshan@redhat.com>
Date: Fri, 21 Feb 2020 14:26:10 +1100
Subject: [PATCH] hw/char/pl011: Support TxFIFO and async transmission

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 hw/char/pl011.c         | 70 +++++++++++++++++++++++++++++++++++++----
 include/hw/char/pl011.h |  2 ++
 2 files changed, 66 insertions(+), 6 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 13e784f9d9..30d5aeb90a 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -169,6 +169,66 @@ static void pl011_set_read_trigger(PL011State *s)
         s->read_trigger = 1;
 }
 
+static gboolean pl011_xmit(GIOChannel *chan, GIOCondition cond, void *opaque)
+{
+    PL011State *s = (PL011State *)opaque;
+    int ret;
+
+    /* instant drain the fifo when there's no back-end */
+    if (!qemu_chr_fe_backend_connected(&s->chr)) {
+        s->write_count = 0;
+        return FALSE;
+    }
+
+    if (!s->write_count) {
+        return FALSE;
+    }
+
+    ret = qemu_chr_fe_write(&s->chr, s->write_fifo, s->write_count);
+    if (ret > 0) {
+        s->write_count -= ret;
+        memmove(s->write_fifo, s->write_fifo + ret, s->write_count);
+        s->flags &= ~PL011_FLAG_TXFF;
+        if (!s->write_count) {
+            s->flags |= PL011_FLAG_TXFE;
+        }
+    }
+
+    if (s->write_count) {
+        guint r = qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP,
+                                        pl011_xmit, s);
+        if (!r) {
+            s->write_count = 0;
+            s->flags &= ~PL011_FLAG_TXFF;
+            s->flags |= PL011_FLAG_TXFE;
+            return FALSE;
+        }
+    }
+
+    s->int_level |= PL011_INT_TX;
+    pl011_update(s);
+    return FALSE;
+}
+
+static void pl011_write_fifo(void *opaque, const unsigned char *buf, int size)
+{
+    PL011State *s = (PL011State *)opaque;
+    int depth = (s->lcr & 0x10) ? 16 : 1;
+
+    if (size >= (depth - s->write_count)) {
+        size = depth - s->write_count;
+        s->flags |= PL011_FLAG_TXFF;
+    }
+
+    if (size > 0) {
+        memcpy(s->write_fifo + s->write_count, buf, size);
+	s->write_count += size;
+	s->flags &= ~PL011_FLAG_TXFE;
+    }
+
+    pl011_xmit(NULL, G_IO_OUT, s);
+}
+
 static void pl011_write(void *opaque, hwaddr offset,
                         uint64_t value, unsigned size)
 {
@@ -179,13 +239,8 @@ static void pl011_write(void *opaque, hwaddr offset,
 
     switch (offset >> 2) {
     case 0: /* UARTDR */
-        /* ??? Check if transmitter is enabled.  */
         ch = value;
-        /* XXX this blocks entire thread. Rewrite to use
-         * qemu_chr_fe_write and background I/O callbacks */
-        qemu_chr_fe_write_all(&s->chr, &ch, 1);
-        s->int_level |= PL011_INT_TX;
-        pl011_update(s);
+        pl011_write_fifo(opaque, &ch, 1);
         break;
     case 1: /* UARTRSR/UARTECR */
         s->rsr = 0;
@@ -207,6 +262,7 @@ static void pl011_write(void *opaque, hwaddr offset,
         if ((s->lcr ^ value) & 0x10) {
             s->read_count = 0;
             s->read_pos = 0;
+            s->write_count = 0;
         }
         s->lcr = value;
         pl011_set_read_trigger(s);
@@ -306,6 +362,7 @@ static const VMStateDescription vmstate_pl011 = {
         VMSTATE_UINT32(int_enabled, PL011State),
         VMSTATE_UINT32(int_level, PL011State),
         VMSTATE_UINT32_ARRAY(read_fifo, PL011State, 16),
+        VMSTATE_UINT8_ARRAY(write_fifo, PL011State, 16),
         VMSTATE_UINT32(ilpr, PL011State),
         VMSTATE_UINT32(ibrd, PL011State),
         VMSTATE_UINT32(fbrd, PL011State),
@@ -313,6 +370,7 @@ static const VMStateDescription vmstate_pl011 = {
         VMSTATE_INT32(read_pos, PL011State),
         VMSTATE_INT32(read_count, PL011State),
         VMSTATE_INT32(read_trigger, PL011State),
+        VMSTATE_INT32(write_count, PL011State),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/include/hw/char/pl011.h b/include/hw/char/pl011.h
index 14187165c6..aeaf332eca 100644
--- a/include/hw/char/pl011.h
+++ b/include/hw/char/pl011.h
@@ -38,6 +38,7 @@ typedef struct PL011State {
     uint32_t int_enabled;
     uint32_t int_level;
     uint32_t read_fifo[16];
+    uint8_t  write_fifo[16];
     uint32_t ilpr;
     uint32_t ibrd;
     uint32_t fbrd;
@@ -45,6 +46,7 @@ typedef struct PL011State {
     int read_pos;
     int read_count;
     int read_trigger;
+    int write_count;
     CharBackend chr;
     qemu_irq irq[6];
     const unsigned char *id;
-- 
2.23.0


--------------6EF41B11D44FC8C5AC0DCE6D--


