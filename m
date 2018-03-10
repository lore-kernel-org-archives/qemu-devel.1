Received: from eggs.gnu.org ([2001:4830:134:3::10]:39796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eulMk-0002Sn-Pc
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 15:45:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eulMh-00065d-NK
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 15:45:18 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:42324)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eulMh-00064r-Fm
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 15:45:15 -0500
Received: by mail-wr0-x242.google.com with SMTP id k9so12055358wre.9
	for <qemu-devel@nongnu.org>; Sat, 10 Mar 2018 12:45:15 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1520568765-58189-1-git-send-email-mjc@sifive.com>
	<1520568765-58189-11-git-send-email-mjc@sifive.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ccaa04b7-f230-2453-738d-a331a9a51598@amsat.org>
Date: Sat, 10 Mar 2018 21:45:12 +0100
MIME-Version: 1.0
In-Reply-To: <1520568765-58189-11-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 10/23] RISC-V: Hold rcu_read_lock when
 accessing memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Stefan O'Rear <sorear2@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>

Hi Michael,

On 03/09/2018 05:12 AM, Michael Clark wrote:
> From reading other code that accesses memory regions directly,
> it appears that the rcu_read_lock needs to be held. Note: the
> original code for accessing RAM directly was added because
> there is no other way to use atomic_cmpxchg on guest physical
> address space.
> 
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> CC: Stefan O'Rear <sorear2@gmail.com>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> ---
>  target/riscv/helper.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/target/riscv/helper.c b/target/riscv/helper.c
> index 02cbcea..228933c 100644
> --- a/target/riscv/helper.c
> +++ b/target/riscv/helper.c
> @@ -209,6 +209,7 @@ restart:
>                     as the PTE is no longer valid */
>                  MemoryRegion *mr;
>                  hwaddr l = sizeof(target_ulong), addr1;
> +                rcu_read_lock();
>                  mr = address_space_translate(cs->as, pte_addr,
>                      &addr1, &l, false);
>                  if (memory_access_is_direct(mr, true)) {
> @@ -222,16 +223,19 @@ restart:
>                      target_ulong old_pte =
>                          atomic_cmpxchg(pte_pa, pte, updated_pte);
>                      if (old_pte != pte) {
> +                        rcu_read_unlock();
>                          goto restart;
>                      } else {
>                          pte = updated_pte;
>                      }
>  #endif
>                  } else {
> +                    rcu_read_unlock();
>                      /* misconfigured PTE in ROM (AD bits are not preset) or
>                       * PTE is in IO space and can't be updated atomically */
>                      return TRANSLATE_FAIL;
>                  }
> +                rcu_read_unlock();

Can you refactor to have a unique pair of lock/unlock?
This would be less bug-prone.

Thanks,

Phil.

>              }
>  
>              /* for superpage mappings, make a fake leaf PTE for the TLB's
> 
