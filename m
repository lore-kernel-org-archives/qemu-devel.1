Received: from eggs.gnu.org ([2001:4830:134:3::10]:37319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1ezIWe-0001zO-Bn
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 04:58:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1ezIWa-0005Rk-CV
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 04:58:16 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:47244)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1ezIWa-0005QK-26
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 04:58:12 -0400
References: <1521794165-31678-1-git-send-email-thuth@redhat.com>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <9a327463-152d-bb4a-17a8-3e44bab9e2e9@mail.uni-paderborn.de>
Date: Fri, 23 Mar 2018 09:58:06 +0100
MIME-Version: 1.0
In-Reply-To: <1521794165-31678-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12] hw/riscv: Fix crashes with
 "-nodefaults"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On 03/23/2018 09:36 AM, Thomas Huth wrote:
> Most of the RISC-V boards currently crash when they are started with
> "-nodefaults", e.g.:
> 
> $ gdb --args riscv32-softmmu/qemu-system-riscv32 -nodefaults -M sifive_e
> [...]
> (gdb) r
> Program received signal SIGSEGV, Segmentation fault.
> qemu_chr_fe_init ([...], s=s@entry=0x0, [...])
>     at chardev/char-fe.c:210
> 210	    } else if (s->be) {
> (gdb) bt
>  0  0x00005555558695f8 in qemu_chr_fe_init ([...], s=s@entry=0x0, [...])
>     at chardev/char-fe.c:210
>  1  0x00005555556fb425 in sifive_uart_create ([...], chr=0x0, [...])
>     at hw/riscv/sifive_uart.c:169
>  2  0x00005555556f8cc4 in riscv_sifive_e_init (machine=[...])
>     at hw/riscv/sifive_e.c:164
>     [...]
> 
> With "-nodefaults" there are no entries in serial_hds[], so qemu_chr_fe_init()
> finally tries to dereference a NULL pointer. Let's fix this problem by
> creating a "null" chardev in this case instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  For other boards / targets, see also:
>  https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg05073.html
> 
>  hw/riscv/riscv_htif.c  | 5 +++++
>  hw/riscv/sifive_uart.c | 5 +++++
>  2 files changed, 10 insertions(+)
> 

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Cheers,
Bastian
