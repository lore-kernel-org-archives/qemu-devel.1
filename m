Received: from eggs.gnu.org ([2001:4830:134:3::10]:43285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1fvsz1-000127-K2
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 19:37:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1fvsyy-0003J9-Cr
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 19:37:43 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:35090)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <groeck7@gmail.com>) id 1fvsyy-0003Ih-5F
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 19:37:40 -0400
Received: by mail-pl1-x643.google.com with SMTP id d9-v6so6120724plr.2
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 16:37:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 31 Aug 2018 16:37:36 -0700
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <20180831233736.GA10164@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
To: Calvin Lee <cyrus296@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

Hi,

On Fri, May 11, 2018 at 06:05:44PM -0600, Calvin Lee wrote:
> This fixes several problems I found in the UART serial implementation.
> Now all divisor values are allowed, while before divisor values of zero
> and below the base baud rate were rejected. All changes are in reference
> to http://www.sci.muni.cz/docs/pc/serport.txt
> 

This patch is causing tracebacks in all Linux kernels running the PXA serial
driver. Here is an example:

[    1.907584] ------------[ cut here ]------------
[    1.907805] WARNING: CPU: 0 PID: 1 at drivers/tty/serial/pxa.c:544 serial_pxa_set_termios+0x254/0x268
[    1.907865] Modules linked in:
[    1.908130] CPU: 0 PID: 1 Comm: swapper Not tainted 4.9.125-rc1-00067-g7236e21 #1
[    1.908155] Hardware name: Zipit Z2
[    1.908783] [<c0011f54>] (unwind_backtrace) from [<c000e9ac>] (show_stack+0x20/0x24)
[    1.908846] [<c000e9ac>] (show_stack) from [<c029aa80>] (dump_stack+0x20/0x28)
[    1.908877] [<c029aa80>] (dump_stack) from [<c002befc>] (__warn+0xec/0x114)
[    1.908905] [<c002befc>] (__warn) from [<c002bff4>] (warn_slowpath_null+0x30/0x38)
[    1.908931] [<c002bff4>] (warn_slowpath_null) from [<c033eeb4>] (serial_pxa_set_termios+0x254/0x268)
[    1.908958] [<c033eeb4>] (serial_pxa_set_termios) from [<c0339b00>] (uart_set_options+0xc8/0xf0)
[    1.908987] [<c0339b00>] (uart_set_options) from [<c0712200>] (serial_pxa_console_setup+0xb4/0xc4)
...

The patch results in an unexpected DLL register value. Here is the
surrounding code from drivers/tty/serial/pxa.c:

	serial_out(up, UART_DLL, quot & 0xff);		/* LS of divisor */

	/*
	 * work around Errata #75 according to Intel(R) PXA27x
	 * Processor Family Specification Update (Nov 2005)
	 */
	dll = serial_in(up, UART_DLL);
	WARN_ON(dll != (quot & 0xff));	// <-- warning

Reverting the patch fixes the problem.

Guenter
