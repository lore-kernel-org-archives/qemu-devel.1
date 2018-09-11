Received: from eggs.gnu.org ([2001:4830:134:3::10]:47863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fzirG-0001pb-1f
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 09:37:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fzibr-0006Lr-Qi
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 09:21:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58452 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fzibr-0006LP-G1
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 09:21:39 -0400
References: <20180831233736.GA10164@roeck-us.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e0b4bcce-6513-5614-88b1-5ee445d1bcc8@redhat.com>
Date: Tue, 11 Sep 2018 15:21:34 +0200
MIME-Version: 1.0
In-Reply-To: <20180831233736.GA10164@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] PC Chipset: Improve serial divisor
 calculation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Guenter Roeck <linux@roeck-us.net>, Calvin Lee <cyrus296@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org

On 01/09/2018 01:37, Guenter Roeck wrote:
> The patch results in an unexpected DLL register value. Here is the
> surrounding code from drivers/tty/serial/pxa.c:
> 
> 	serial_out(up, UART_DLL, quot & 0xff);		/* LS of divisor */
> 
> 	/*
> 	 * work around Errata #75 according to Intel(R) PXA27x
> 	 * Processor Family Specification Update (Nov 2005)
> 	 */
> 	dll = serial_in(up, UART_DLL);
> 	WARN_ON(dll != (quot & 0xff));	// <-- warning
> 
> Reverting the patch fixes the problem.

I think it's a typo.  Can you try this:

diff --git a/hw/char/serial.c b/hw/char/serial.c
index 251f40fdac..02463e3388 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -345,9 +345,9 @@ static void serial_ioport_write(void *opaque, hwaddr addr, uint64_t val,
     default:
     case 0:
         if (s->lcr & UART_LCR_DLAB) {
-            if (size == 2) {
+            if (size == 1) {
                 s->divider = (s->divider & 0xff00) | val;
-            } else if (size == 4) {
+            } else {
                 s->divider = val;
             }
             serial_update_parameters(s);

Thanks,

Paolo
