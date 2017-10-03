Received: from eggs.gnu.org ([2001:4830:134:3::10]:44159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dzNig-0002cm-QS
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:58:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dzNic-0003w2-QC
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:58:46 -0400
Received: from mail-ua0-f177.google.com ([209.85.217.177]:49818)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1dzNic-0003vk-LI
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:58:42 -0400
Received: by mail-ua0-f177.google.com with SMTP id 97so5237074uai.6
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 06:58:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <150642407781.3900.3667954520393080307.stgit@Misha-PC.lan02.inno>
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
	<150642407781.3900.3667954520393080307.stgit@Misha-PC.lan02.inno>
From: Ladi Prosek <lprosek@redhat.com>
Date: Tue, 3 Oct 2017 15:58:41 +0200
Message-ID: <CABdb736jggKYaECMnY7rORADeGexOfH3fEeCd87ZzaaMVSfC8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 41/43] windbg: implemented
 kd_api_search_memory
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

On Tue, Sep 26, 2017 at 1:07 PM, Mihail Abakumov
<mikhail.abakumov@ispras.ru> wrote:
> Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
> Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
> Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
> ---
>  include/exec/windbgstub-utils.h |    1 +
>  windbgstub-utils.c              |   30 ++++++++++++++++++++++++++++++
>  windbgstub.c                    |    4 ++++
>  3 files changed, 35 insertions(+)
>
> diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
> index 23cafb1a89..ba001ddb42 100755
> --- a/include/exec/windbgstub-utils.h
> +++ b/include/exec/windbgstub-utils.h
> @@ -118,6 +118,7 @@ void kd_api_write_physical_memory(CPUState *cpu, PacketData *pd);
>  void kd_api_get_version(CPUState *cpu, PacketData *pd);
>  void kd_api_read_msr(CPUState *cpu, PacketData *pd);
>  void kd_api_write_msr(CPUState *cpu, PacketData *pd);
> +void kd_api_search_memory(CPUState *cpu, PacketData *pd);
>  void kd_api_unsupported(CPUState *cpu, PacketData *pd);
>
>  SizedBuf kd_gen_exception_sc(CPUState *cpu);
> diff --git a/windbgstub-utils.c b/windbgstub-utils.c
> index 26bdb1f6ea..2d3fbcc41c 100755
> --- a/windbgstub-utils.c
> +++ b/windbgstub-utils.c
> @@ -1540,6 +1540,36 @@ void kd_api_write_msr(CPUState *cpu, PacketData *pd)
>      pd->m64.ReturnStatus = STATUS_SUCCESS;
>  }
>
> +void kd_api_search_memory(CPUState *cpu, PacketData *pd)
> +{
> +    DBGKD_SEARCH_MEMORY *m64c = &pd->m64.u.SearchMemory;
> +    int s_len = MAX(1, ldq_p(&m64c->SearchLength));
> +    int p_len = MIN(ldl_p(&m64c->PatternLength), pd->extra_size);
> +    target_ulong addr = ldq_p(&m64c->SearchAddress);
> +
> +    uint8_t mem[s_len - 1 + p_len];

s_len could be very large, people do things like

0:000> s -d 0x80000000 L?0x7fffffff <pattern>

You should not allocate this buffer on the stack and preferably break
large searches down to smaller ranges, i.e. don't allocate and read
~s_len bytes all at once.

> +    int err = cpu_memory_rw_debug(cpu, addr, mem, sizeof(mem), 0);
> +    if (!err) {
> +        int i;
> +        pd->m64.ReturnStatus = STATUS_NO_MORE_ENTRIES;
> +        for (i = 0; i < s_len; ++i) {
> +            if (memcmp(mem + i, pd->extra, p_len) == 0) {
> +                m64c->FoundAddress = addr + i;
> +                m64c->FoundAddress = ldq_p(&m64c->FoundAddress);
> +                pd->m64.ReturnStatus = STATUS_SUCCESS;
> +                break;
> +            }
> +        }

Use memmem instead?

> +    } else {
> +        pd->m64.ReturnStatus = STATUS_UNSUCCESSFUL;
> +        WINDBG_DEBUG("search_memory: No physical page mapped: " FMT_ADDR,
> +                     addr);
> +    }
> +
> +    pd->extra_size = 0;
> +}
> +
>  void kd_api_unsupported(CPUState *cpu, PacketData *pd)
>  {
>      WINDBG_ERROR("Catched unimplemented api %s",
> diff --git a/windbgstub.c b/windbgstub.c
> index 1ec4932ddc..7cff6bc514 100755
> --- a/windbgstub.c
> +++ b/windbgstub.c
> @@ -205,6 +205,10 @@ static void windbg_process_manipulate_packet(ParsingContext *ctx)
>      case DbgKdClearAllInternalBreakpointsApi:
>          return;
>
> +    case DbgKdSearchMemoryApi:
> +        kd_api_search_memory(cpu, &ctx->data);
> +        break;
> +
>      default:
>          kd_api_unsupported(cpu, &ctx->data);
>          break;
>
