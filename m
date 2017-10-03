Received: from eggs.gnu.org ([2001:4830:134:3::10]:44682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dzNky-0003Qw-Ln
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 10:01:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dzNkp-0005uR-8h
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 10:01:08 -0400
Received: from mail-vk0-f41.google.com ([209.85.213.41]:52220)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1dzNkp-0005to-4K
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 10:00:59 -0400
Received: by mail-vk0-f41.google.com with SMTP id 137so2094862vkk.8
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 07:00:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <150642408350.3900.16985989168069353852.stgit@Misha-PC.lan02.inno>
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
	<150642408350.3900.16985989168069353852.stgit@Misha-PC.lan02.inno>
From: Ladi Prosek <lprosek@redhat.com>
Date: Tue, 3 Oct 2017 16:00:56 +0200
Message-ID: <CABdb737SO1x-1B_mAXTgm4ND3QCd2vQw+568Y1WNryO38Uq4oQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 42/43] windbg: implemented
 kd_api_fill_memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>, sw@weilnetz.de, Pavel Dovgalyuk <dovgaluk@ispras.ru>, Roman Kagan <rkagan@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>

On Tue, Sep 26, 2017 at 1:08 PM, Mihail Abakumov
<mikhail.abakumov@ispras.ru> wrote:
> Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
> Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
> Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
> ---
>  include/exec/windbgstub-utils.h |    1 +
>  windbgstub-utils.c              |   36 ++++++++++++++++++++++++++++++++++++
>  windbgstub.c                    |    4 ++++
>  3 files changed, 41 insertions(+)
>
> diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
> index ba001ddb42..d1a10c862e 100755
> --- a/include/exec/windbgstub-utils.h
> +++ b/include/exec/windbgstub-utils.h
> @@ -119,6 +119,7 @@ void kd_api_get_version(CPUState *cpu, PacketData *pd);
>  void kd_api_read_msr(CPUState *cpu, PacketData *pd);
>  void kd_api_write_msr(CPUState *cpu, PacketData *pd);
>  void kd_api_search_memory(CPUState *cpu, PacketData *pd);
> +void kd_api_fill_memory(CPUState *cpu, PacketData *pd);
>  void kd_api_unsupported(CPUState *cpu, PacketData *pd);
>
>  SizedBuf kd_gen_exception_sc(CPUState *cpu);
> diff --git a/windbgstub-utils.c b/windbgstub-utils.c
> index 2d3fbcc41c..3832e0b116 100755
> --- a/windbgstub-utils.c
> +++ b/windbgstub-utils.c
> @@ -1570,6 +1570,42 @@ void kd_api_search_memory(CPUState *cpu, PacketData *pd)
>      pd->extra_size = 0;
>  }
>
> +void kd_api_fill_memory(CPUState *cpu, PacketData *pd)
> +{
> +    DBGKD_FILL_MEMORY *m64c = &pd->m64.u.FillMemory;
> +
> +    uint32_t len = ldl_p(&m64c->Length);
> +    target_ulong addr = ldq_p(&m64c->Address);
> +    uint16_t pattern = ldl_p(&m64c->PatternLength);
> +    uint16_t flags = ldl_p(&m64c->Flags);
> +
> +    uint8_t mem[len];

Same as patch 41, break len into, say, page-sized regions and call
cpu_memory_rw_debug in a loop.

> +    int i, err;
> +    for (i = 0; i < len; ++i) {
> +        mem[i] = pd->extra[i % pattern];
> +    }
> +
> +    switch (flags) {
> +    case DBGKD_FILL_MEMORY_VIRTUAL:
> +        err = cpu_memory_rw_debug(cpu, addr, mem, len, 1);
> +        if (err) {
> +            pd->m64.ReturnStatus = STATUS_UNSUCCESSFUL;
> +            WINDBG_DEBUG("fill_memory: No physical page mapped: " FMT_ADDR,
> +                        addr);
> +        }
> +        break;
> +
> +    case DBGKD_FILL_MEMORY_PHYSICAL:
> +        cpu_physical_memory_rw(addr, mem, len, 1);
> +        break;
> +
> +    default:
> +        break;
> +    }
> +
> +    pd->extra_size = 0;
> +}
> +
>  void kd_api_unsupported(CPUState *cpu, PacketData *pd)
>  {
>      WINDBG_ERROR("Catched unimplemented api %s",
> diff --git a/windbgstub.c b/windbgstub.c
> index 7cff6bc514..b01ddcf009 100755
> --- a/windbgstub.c
> +++ b/windbgstub.c
> @@ -209,6 +209,10 @@ static void windbg_process_manipulate_packet(ParsingContext *ctx)
>          kd_api_search_memory(cpu, &ctx->data);
>          break;
>
> +    case DbgKdFillMemoryApi:
> +        kd_api_fill_memory(cpu, &ctx->data);
> +        break;
> +
>      default:
>          kd_api_unsupported(cpu, &ctx->data);
>          break;
>
