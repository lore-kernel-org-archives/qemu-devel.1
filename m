Received: from eggs.gnu.org ([2001:4830:134:3::10]:49047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1eJPpM-0000Zj-QH
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 15:16:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1eJPpI-0004A0-Q1
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 15:16:28 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:39379)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcd@tribudubois.net>) id 1eJPpI-00049Q-IY
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 15:16:24 -0500
From: Jean-Christophe DUBOIS <jcd@tribudubois.net>
Message-ID: <2a8cfe41-bddb-7812-1e1a-950dc43ebddf@tribudubois.net>
Date: Mon, 27 Nov 2017 21:16:21 +0100
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [SPARC] Accessing devices through MMU mapped memory
 region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

Hi,

I am using Qemu to emulate a Leon3 based board.

In the software I am running on top of Qemu, I am mapping devices to a 
virtual address using MMU table.

Now I am experimenting some issues when I am trying to access some 
device (here the UART port at 0x80000100) through the MMU mapping (with 
NOCACHE attribute for this page).

in my (user space) software I am doing something like:

    #define MY_VIRTUAL_ADDRESS 0x40808100 /* mapped to 0x80000100
    physical address through MMU */

    #define UART_CTRL_REG_OFFSET 0x8

    #define UART_CTRL_TE 0x00000002

    *(volatile uint32_t *)(MY_VIRTUAL_ADDRESS + UART_CTRL_REG_OFFSET) =
    UART_CTRL_TE;

But when the write is propagated by Qemu to the serial device, I am 
getting 4 x 8bits (1 byte) write access (0x8, 0x9, 0xa, 0xb) instead of 
a single 32 bits (4 bytes) access.

The Qemu driver emulator for the serial device is unhappy about this as 
it would not handle byte access for addresses 0x9, 0xa, 0xb which are 
then tagged as unsupported access.

I am wondering if I am missing something and if there is a reason for my 
single 32 bits access to be transformed by Qemu in 4 single byte access.

I believe it is expected to be able to get single atomic 32 bits 
read/write to the device.

Would you have any hint/advice for me?

JC
