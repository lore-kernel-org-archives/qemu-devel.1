Received: from eggs.gnu.org ([2001:4830:134:3::10]:35669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eJxDj-0000s5-S4
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 02:55:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eJxDf-0005rH-24
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 02:55:51 -0500
Received: from mail-ua0-f194.google.com ([209.85.217.194]:35207)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1eJxDe-0005r3-U6
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 02:55:46 -0500
Received: by mail-ua0-f194.google.com with SMTP id l2so2807486uak.2
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 23:55:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <151127346810.6888.6227202235013087727.stgit@Misha-PC.lan02.inno>
References: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
	<151127346810.6888.6227202235013087727.stgit@Misha-PC.lan02.inno>
From: Ladi Prosek <lprosek@redhat.com>
Date: Wed, 29 Nov 2017 08:55:45 +0100
Message-ID: <CABdb736bZVPBfJH2+rghbWKTNyUy7EZTJ6HiWhRKTP6cUhYFvQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 41/45] windbg: implemented
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

On Tue, Nov 21, 2017 at 3:11 PM, Mihail Abakumov
<mikhail.abakumov@ispras.ru> wrote:
> Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
> Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
> Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
> ---
>  include/exec/windbgstub-utils.h |    1 +
>  windbgstub-utils.c              |   33 +++++++++++++++++++++++++++++++++
>  windbgstub.c                    |    4 ++++
>  3 files changed, 38 insertions(+)
>
> diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
> index 73d49b774d..c2eb8a75a7 100755
> --- a/include/exec/windbgstub-utils.h
> +++ b/include/exec/windbgstub-utils.h
> @@ -102,6 +102,7 @@ void kd_api_write_physical_memory(CPUState *cpu, PacketData *pd);
>  void kd_api_get_version(CPUState *cpu, PacketData *pd);
>  void kd_api_read_msr(CPUState *cpu, PacketData *pd);
>  void kd_api_write_msr(CPUState *cpu, PacketData *pd);
> +void kd_api_search_memory(CPUState *cpu, PacketData *pd);
>  void kd_api_unsupported(CPUState *cpu, PacketData *pd);
>
>  SizedBuf kd_gen_exception_sc(CPUState *cpu);
> diff --git a/windbgstub-utils.c b/windbgstub-utils.c
> index 7ef301bac7..1f4590f338 100755
> --- a/windbgstub-utils.c
> +++ b/windbgstub-utils.c
> @@ -261,6 +261,39 @@ void kd_api_get_version(CPUState *cpu, PacketData *pd)
>      }
>  }
>
> +void kd_api_search_memory(CPUState *cpu, PacketData *pd)
> +{
> +    DBGKD_SEARCH_MEMORY *m64c = &pd->m64.u.SearchMemory;
> +    int s_len = MAX(ldq_p(&m64c->SearchLength), 1);
> +    int p_len = MIN(ldl_p(&m64c->PatternLength), pd->extra_size);
> +    target_ulong addr = ldq_p(&m64c->SearchAddress);
> +    int size = MIN(s_len, 10);
> +    uint8_t mem[size + p_len];

Is this allocation bounded by a reasonably small number? What's the
maximum PatternLength?

> +    int i, err;
> +
> +    pd->extra_size = 0;
> +    pd->m64.ReturnStatus = STATUS_NO_MORE_ENTRIES;
> +
> +    while (s_len) {
> +        err = cpu_memory_rw_debug(cpu, addr, mem, size + p_len, 0);
> +        if (!err) {
> +            for (i = 0; i < size; ++i) {
> +                if (memcmp(mem + i, pd->extra, p_len) == 0) {
> +                    stl_p(&m64c->FoundAddress, addr + i);
> +                    pd->m64.ReturnStatus = STATUS_SUCCESS;
> +                    return;
> +                }
> +            }
> +        } else {
> +            WINDBG_DEBUG("search_memory: No physical page mapped: " FMT_ADDR,
> +                         addr);
> +        }
> +        s_len -= size;
> +        addr += size;
> +        size = MIN(s_len, 10);
> +    }
> +}
> +

Too bad that you can't use memmem(). This implementation screams
O(N^2) to me. One of the things that can be improved later I guess.

I would at least up the step from 10 to 1024 so we don't call
cpu_memory_rw_debug() that often.

>  void kd_api_unsupported(CPUState *cpu, PacketData *pd)
>  {
>      WINDBG_ERROR("Caught unimplemented api %s",
> diff --git a/windbgstub.c b/windbgstub.c
> index 0268d0818e..d35ff6ba96 100755
> --- a/windbgstub.c
> +++ b/windbgstub.c
> @@ -212,6 +212,10 @@ static void windbg_process_manipulate_packet(ParsingContext *ctx)
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
