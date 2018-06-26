Received: from eggs.gnu.org ([2001:4830:134:3::10]:54809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXwPZ-0007bd-3t
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 18:26:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXwPV-0002Iz-Vo
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 18:26:09 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:33647)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fXwPV-0002IJ-NZ
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 18:26:05 -0400
Received: by mail-pf0-x241.google.com with SMTP id b17-v6so18984pfi.0
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 15:26:05 -0700 (PDT)
References: <20180618184046.6270-1-richard.henderson@linaro.org>
	<20180618184046.6270-14-richard.henderson@linaro.org>
	<CAAfxs74pe4BnScaFdmUBbX=-kD5qp2pQN-JgnFy4QGfGXNe9oQ@mail.gmail.com>
	<CAAfxs77w97-8iNRf_XfqDewrgm61SroT-WcCedM9hvg8E+kMYQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d80aae07-404e-ada2-9a9b-4d1d96c9e63b@linaro.org>
Date: Tue, 26 Jun 2018 15:26:01 -0700
MIME-Version: 1.0
In-Reply-To: <CAAfxs77w97-8iNRf_XfqDewrgm61SroT-WcCedM9hvg8E+kMYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 13/22] target/openrisc: Fix cpu_mmu_index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stafford Horne <shorne@gmail.com>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>

On 06/26/2018 03:07 PM, Stafford Horne wrote:
> Hello,
> 
> I think I found out something.
> 
> in: target/openrisc/sys_helper.c:92
> 
> When we write to `env->tlb.dtlb[idx].tr`  in helper_mtspr():
>   93          case TO_SPR(1, 640) ... TO_SPR(1, 640 + TLB_SIZE - 1):
> /* DTLBW0TR 0-127 */
>   94              idx = spr - TO_SPR(1, 640);
>   95              env->tlb.dtlb[idx].tr = rb;
> 
> 
> Somehow we are overlapping with `cpu->tb_jmp_cache`,  these are both
> pointing to the same spot in memory.
> 
> (gdb) p &cs->tb_jmp_cache[3014]
> $9 = (struct TranslationBlock **) 0x55555608b300
> (gdb) p &env->tlb.dtlb[idx].tr
> $10 = (uint32_t *) 0x55555608b304

That is definitely weird.  How about

(gdb) p openrisc_env_get_cpu(env)
$1 = xxxx
(gdb) p &$1->parent_obj
(gdb) p &$1->env
(gdb) p cs->env_ptr

There should be 4096 entries in tb_jmp_cache, so there should
be no way that overlaps.  I can only imagine either CS or ENV
is incorrect somehow.  How that would be, I don't know...


r~
