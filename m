Received: from eggs.gnu.org ([2001:4830:134:3::10]:49231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dg6jp-00034a-JN
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 06:00:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dg6jo-00063v-Kk
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 06:00:17 -0400
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:38373
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1dg6jo-00063Q-Dq
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 06:00:16 -0400
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <3710e9b8-4b16-1bcc-da17-80fb2cc2c644@adacore.com>
Date: Fri, 11 Aug 2017 11:59:45 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] big endian arm.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, crosthwaite.peter@gmail.com
Cc: QEMU Developers <qemu-devel@nongnu.org>

Hi Peters,

I got some strange results since this commit:

commit 9776f636455b6f0d9c14dce112242ed653f954b4
Author: Peter Crosthwaite <crosthwaitepeter@gmail.com>
Date:   Fri Mar 4 11:30:21 2016 +0000

     arm: boot: Support big-endian elfs

     Support ARM big-endian ELF files in system-mode emulation. 
When loading
     an elf, determine the endianness mode expected by the elf, 
and set the
     relevant CPU state accordingly.

     With this, big-endian modes are now fully supported via 
system-mode LE,
     so there is no need to restrict the elf loading to the TARGET
     endianness so the ifdeffery on TARGET_WORDS_BIGENDIAN goes away.

     Signed-off-by: Peter Crosthwaite <crosthwaite.peter@gmail.com>
     Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
     [PMM: fix typo in comments]
     Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

It seems that when I try to load a big endian image on a
Cortex-R5 it gets confused:
  * the instructions are fine it executes some code.
  * GDB address / insns are wrong endianness.
  * in monitor x command is good endianness.
  * the data order seems to be wrong endianness:
    Here is my Hello World: lleHlroW

We used to add a armeb-softmmu/qemu-system-armeb target for the
big endian cpu but it doesn't work anymore as it's double
reversed by the elf endianness (data_swab <= 2).

And I'm surprised we don't set the CPSR_E and SCTLR_EE bits
accordingly?

Thanks,
Fred
