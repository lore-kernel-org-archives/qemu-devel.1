Received: from eggs.gnu.org ([2001:4830:134:3::10]:44895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gPsTt-0007do-L8
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 12:09:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gPsTn-0004lY-Rm
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 12:09:33 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53041)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gPsTn-0004jQ-9k
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 12:09:27 -0500
Received: by mail-wm1-x343.google.com with SMTP id r11-v6so9628494wmb.2
	for <qemu-devel@nongnu.org>; Thu, 22 Nov 2018 09:09:25 -0800 (PST)
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-11-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025172057.20414-11-cota@braap.org>
Date: Thu, 22 Nov 2018 17:09:22 +0000
Message-ID: <874lc9hwe5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 10/48] exec: export do_tb_flush
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?utf-8?Q?Llu=C3=ADs?= Vilanova <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>


Emilio G. Cota <cota@braap.org> writes:

> This will be used by plugin code to flush the code cache as well
> as doing other bookkeeping in a safe work environment.

This seems a little excessive given the plugin code could just call
tb_flush() directly. Wouldn't calling tb_flush after scheduling the
plugin_destroy be enough?

If there is a race condition here maybe we could build some sort of
awareness into tb_flush as to the current run state. But having two
entry points to this rather fundamental action seems likely to either be
misused or misunderstood.

>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  include/exec/exec-all.h   | 1 +
>  accel/tcg/translate-all.c | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index 815e5b1e83..232e2f8966 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -427,6 +427,7 @@ void tb_invalidate_phys_range(target_ulong start, tar=
get_ulong end);
>  void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr, MemTxAttrs a=
ttrs);
>  #endif
>  void tb_flush(CPUState *cpu);
> +void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count);
>  void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr);
>  TranslationBlock *tb_htable_lookup(CPUState *cpu, target_ulong pc,
>                                     target_ulong cs_base, uint32_t flags,
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index c8b3e0a491..db2d28f8d3 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1230,7 +1230,7 @@ static gboolean tb_host_size_iter(gpointer key, gpo=
inter value, gpointer data)
>  }
>
>  /* flush all the translation blocks */
> -static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
> +void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
>  {
>      mmap_lock();
>      /* If it is already been done on request of another CPU,


--
Alex Benn=C3=A9e
