Received: from eggs.gnu.org ([2001:4830:134:3::10]:38604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eJxLd-0003PR-2l
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 03:04:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eJxLY-0001ez-5n
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 03:04:01 -0500
Received: from mail-ua0-f196.google.com ([209.85.217.196]:46821)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1eJxLY-0001eO-1Q
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 03:03:56 -0500
Received: by mail-ua0-f196.google.com with SMTP id t24so2799013uaa.13
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 00:03:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <151127347991.6888.8008733504996106931.stgit@Misha-PC.lan02.inno>
References: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
	<151127347991.6888.8008733504996106931.stgit@Misha-PC.lan02.inno>
From: Ladi Prosek <lprosek@redhat.com>
Date: Wed, 29 Nov 2017 09:03:54 +0100
Message-ID: <CABdb735Bhbm=YHHYM53LOY4U2mA5L27q-nSUeDx3q55AXyTHOw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 43/45] windbg: implemented
 kd_api_query_memory
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
>  windbgstub-utils.c              |   12 ++++++++++++
>  windbgstub.c                    |    4 ++++
>  3 files changed, 17 insertions(+)
>
> diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
> index e144294b51..fa1ebbb6d2 100755
> --- a/include/exec/windbgstub-utils.h
> +++ b/include/exec/windbgstub-utils.h
> @@ -105,6 +105,7 @@ void kd_api_write_msr(CPUState *cpu, PacketData *pd);
>  void kd_api_search_memory(CPUState *cpu, PacketData *pd);
>  void kd_api_fill_memory(CPUState *cpu, PacketData *pd);
>  void kd_api_unsupported(CPUState *cpu, PacketData *pd);
> +void kd_api_query_memory(CPUState *cpu, PacketData *pd);
>
>  SizedBuf kd_gen_exception_sc(CPUState *cpu);
>  SizedBuf kd_gen_load_symbols_sc(CPUState *cpu);
> diff --git a/windbgstub-utils.c b/windbgstub-utils.c
> index fb2c378460..edd23c1971 100755
> --- a/windbgstub-utils.c
> +++ b/windbgstub-utils.c
> @@ -333,6 +333,18 @@ void kd_api_fill_memory(CPUState *cpu, PacketData *pd)
>      }
>  }
>
> +void kd_api_query_memory(CPUState *cpu, PacketData *pd)
> +{
> +    DBGKD_QUERY_MEMORY *mem = &pd->m64.u.QueryMemory;
> +
> +    mem->AddressSpace = DBGKD_QUERY_MEMORY_PROCESS;
> +    mem->Flags = DBGKD_QUERY_MEMORY_READ |
> +                 DBGKD_QUERY_MEMORY_WRITE |
> +                 DBGKD_QUERY_MEMORY_EXECUTE;
> +    mem->AddressSpace = ldl_p(&mem->AddressSpace);
> +    mem->Flags = ldl_p(&mem->Flags);

This should be:

void kd_api_query_memory(CPUState *cpu, PacketData *pd)
{
    DBGKD_QUERY_MEMORY *mem = &pd->m64.u.QueryMemory;

    stl_p(&mem->AddressSpace, DBGKD_QUERY_MEMORY_PROCESS);
    stl_p(&mem->Flags, DBGKD_QUERY_MEMORY_READ |
                 DBGKD_QUERY_MEMORY_WRITE |
                 DBGKD_QUERY_MEMORY_EXECUTE);

> +}
> +
>  void kd_api_unsupported(CPUState *cpu, PacketData *pd)
>  {
>      WINDBG_ERROR("Caught unimplemented api %s",
> diff --git a/windbgstub.c b/windbgstub.c
> index b348028dfd..36372c0ea5 100755
> --- a/windbgstub.c
> +++ b/windbgstub.c
> @@ -220,6 +220,10 @@ static void windbg_process_manipulate_packet(ParsingContext *ctx)
>          kd_api_fill_memory(cpu, &ctx->data);
>          break;
>
> +    case DbgKdQueryMemoryApi:
> +        kd_api_query_memory(cpu, &ctx->data);
> +        break;
> +
>      default:
>          kd_api_unsupported(cpu, &ctx->data);
>          break;
>
