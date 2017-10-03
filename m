Received: from eggs.gnu.org ([2001:4830:134:3::10]:44855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dzMFA-0006fW-6E
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 08:24:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dzMF6-0005Km-UK
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 08:24:12 -0400
Received: from mail-vk0-f46.google.com ([209.85.213.46]:44380)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1dzMF6-0005KR-Pm
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 08:24:08 -0400
Received: by mail-vk0-f46.google.com with SMTP id d12so4450344vkf.1
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 05:24:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <150642396922.3900.13282234011521338171.stgit@Misha-PC.lan02.inno>
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
	<150642396922.3900.13282234011521338171.stgit@Misha-PC.lan02.inno>
From: Ladi Prosek <lprosek@redhat.com>
Date: Tue, 3 Oct 2017 14:24:07 +0200
Message-ID: <CABdb734_z26ezvygKL0jJC5RaggbBLCmT=anEAViTTBT9JQAzA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 22/43] windbg: implemented
 kd_api_read_virtual_memory and kd_api_read_virtual_memory
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

nit: The subject line has "kd_api_read_virtual_memory" twice in it.
Was probably meant to be

[PATCH 22/43] windbg: implemented kd_api_read_virtual_memory and
kd_api_write_virtual_memory


On Tue, Sep 26, 2017 at 1:06 PM, Mihail Abakumov
<mikhail.abakumov@ispras.ru> wrote:
> Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
> Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
> Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
> ---
>  include/exec/windbgstub-utils.h |    2 ++
>  windbgstub-utils.c              |   47 +++++++++++++++++++++++++++++++++++++++
>  windbgstub.c                    |    8 +++++++
>  3 files changed, 57 insertions(+)
>
> diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
> index ca21af7c91..c1ff1cec57 100755
> --- a/include/exec/windbgstub-utils.h
> +++ b/include/exec/windbgstub-utils.h
> @@ -102,6 +102,8 @@ typedef struct SizedBuf {
>      buf.size = 0;           \
>  } while (false)
>
> +void kd_api_read_virtual_memory(CPUState *cpu, PacketData *pd);
> +void kd_api_write_virtual_memory(CPUState *cpu, PacketData *pd);
>  void kd_api_unsupported(CPUState *cpu, PacketData *pd);
>
>  SizedBuf kd_gen_exception_sc(CPUState *cpu);
> diff --git a/windbgstub-utils.c b/windbgstub-utils.c
> index e7b381f829..1bde60a1e9 100755
> --- a/windbgstub-utils.c
> +++ b/windbgstub-utils.c
> @@ -30,6 +30,53 @@ typedef struct KDData {
>
>  static KDData *kd;
>
> +void kd_api_read_virtual_memory(CPUState *cpu, PacketData *pd)
> +{
> +    DBGKD_READ_MEMORY64 *mem = &pd->m64.u.ReadMemory;
> +    uint32_t len;
> +    target_ulong addr;
> +    int err;
> +
> +    len = MIN(ldl_p(&mem->TransferCount), PACKET_MAX_SIZE - M64_SIZE);
> +    addr = ldtul_p(&mem->TargetBaseAddress);
> +    err = cpu_memory_rw_debug(cpu, addr, pd->extra, len, 0);
> +
> +    if (!err) {
> +        pd->extra_size = len;
> +        mem->ActualBytesRead = ldl_p(&len);
> +    } else {
> +        pd->extra_size = 0;
> +        mem->ActualBytesRead = 0;
> +        pd->m64.ReturnStatus = STATUS_UNSUCCESSFUL;
> +
> +        WINDBG_DEBUG("read_virtual_memory: No physical page mapped: " FMT_ADDR,
> +                     (target_ulong) mem->TargetBaseAddress);
> +    }
> +}
> +
> +void kd_api_write_virtual_memory(CPUState *cpu, PacketData *pd)
> +{
> +    DBGKD_WRITE_MEMORY64 *mem = &pd->m64.u.WriteMemory;
> +    uint32_t len;
> +    target_ulong addr;
> +    int err;
> +
> +    len = MIN(ldl_p(&mem->TransferCount), pd->extra_size);
> +    addr = ldtul_p(&mem->TargetBaseAddress);
> +    err = cpu_memory_rw_debug(cpu, addr, pd->extra, len, 1);
> +
> +    pd->extra_size = 0;
> +    if (!err) {
> +        mem->ActualBytesWritten = ldl_p(&len);
> +    } else {
> +        mem->ActualBytesWritten = 0;
> +        pd->m64.ReturnStatus = STATUS_UNSUCCESSFUL;
> +
> +        WINDBG_DEBUG("read_write_memory: No physical page mapped: " FMT_ADDR,
> +                     (target_ulong) mem->TargetBaseAddress);
> +    }
> +}
> +
>  void kd_api_unsupported(CPUState *cpu, PacketData *pd)
>  {
>      WINDBG_ERROR("Catched unimplemented api %s",
> diff --git a/windbgstub.c b/windbgstub.c
> index 50b4ef0dea..327fe83f70 100755
> --- a/windbgstub.c
> +++ b/windbgstub.c
> @@ -133,6 +133,14 @@ static void windbg_process_manipulate_packet(ParsingContext *ctx)
>
>      switch (ctx->data.m64.ApiNumber) {
>
> +    case DbgKdReadVirtualMemoryApi:
> +        kd_api_read_virtual_memory(cpu, &ctx->data);
> +        break;
> +
> +    case DbgKdWriteVirtualMemoryApi:
> +        kd_api_write_virtual_memory(cpu, &ctx->data);
> +        break;
> +
>      default:
>          kd_api_unsupported(cpu, &ctx->data);
>          break;
>
