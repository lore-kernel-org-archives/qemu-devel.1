Received: from eggs.gnu.org ([2001:4830:134:3::10]:54353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dzMm9-0000k2-4L
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 08:58:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dzMm4-0001Bv-9r
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 08:58:17 -0400
Received: from mail-vk0-f52.google.com ([209.85.213.52]:52412)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1dzMm4-0001B3-5a
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 08:58:12 -0400
Received: by mail-vk0-f52.google.com with SMTP id 126so4490527vkj.9
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 05:58:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <150642403148.3900.7920017116044093005.stgit@Misha-PC.lan02.inno>
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
	<150642403148.3900.7920017116044093005.stgit@Misha-PC.lan02.inno>
From: Ladi Prosek <lprosek@redhat.com>
Date: Tue, 3 Oct 2017 14:58:10 +0200
Message-ID: <CABdb734VfemLf6BuASDYEBbHuErEubmcFZ_pN5NCuG76xwjOmQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 33/43] windbg: implemented
 windbg_hw_breakpoint_insert and windbg_hw_breakpoint_remove
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
>  windbgstub-utils.c |   60 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>
> diff --git a/windbgstub-utils.c b/windbgstub-utils.c
> index e33789725e..05caf98c0c 100755
> --- a/windbgstub-utils.c
> +++ b/windbgstub-utils.c
> @@ -294,11 +294,71 @@ static KDData *kd;
>
>  static int windbg_hw_breakpoint_insert(CPUState *cpu, int index)
>  {
> +    CPUArchState *env = cpu->env_ptr;
> +
> +    if (!IS_BP_ENABLED(env->dr[7], index)) {

nit: This is already checked by both callers.

> +        return 0;
> +    }
> +
> +    target_ulong addr = env->dr[index];
> +    int type = BP_TYPE(env->dr[7], index);
> +    int len = BP_LEN(env->dr[7], index);
> +    int err = 0;
> +
> +    switch (type) {
> +    case DR7_TYPE_DATA_WR:
> +        err = cpu_watchpoint_insert(cpu, addr, len, BP_MEM_WRITE | BP_GDB,
> +                                    &env->cpu_watchpoint[index]);
> +        break;
> +    case DR7_TYPE_DATA_RW:
> +        err = cpu_watchpoint_insert(cpu, addr, len, BP_MEM_ACCESS | BP_GDB,
> +                                    &env->cpu_watchpoint[index]);
> +        break;
> +    case DR7_TYPE_BP_INST:
> +        err = cpu_breakpoint_insert(cpu, addr, BP_GDB,
> +                                    &env->cpu_breakpoint[index]);
> +        break;
> +    case DR7_TYPE_IO_RW:
> +        return HF_IOBPT_MASK;
> +    default:
> +        return 0;
> +    }
> +
> +    if (!err) {
> +        WINDBG_DEBUG("hw_breakpoint_insert: index(%d), " FMT_ADDR,
> +                     index, addr);
> +    } else {
> +        env->cpu_breakpoint[index] = NULL;
> +        WINDBG_ERROR("hw_breakpoint_insert: index(%d), " FMT_ADDR ", " FMT_ERR,
> +                     index, addr, err);
> +    }
>      return 0;
>  }
>
>  static int windbg_hw_breakpoint_remove(CPUState *cpu, int index)
>  {
> +    CPUArchState *env = cpu->env_ptr;
> +    int type = BP_TYPE(env->dr[7], index);
> +
> +    switch (type) {
> +    case DR7_TYPE_BP_INST:
> +        if (env->cpu_breakpoint[index]) {
> +            cpu_breakpoint_remove_by_ref(cpu, env->cpu_breakpoint[index]);
> +        }
> +        break;
> +    case DR7_TYPE_DATA_WR:
> +    case DR7_TYPE_DATA_RW:
> +        if (env->cpu_watchpoint[index]) {
> +            cpu_watchpoint_remove_by_ref(cpu, env->cpu_watchpoint[index]);
> +        }
> +        break;
> +    default:
> +        return 0;
> +    }
> +
> +    env->cpu_breakpoint[index] = NULL;
> +    WINDBG_DEBUG("hw_breakpoint_remove: index(%d), " FMT_ADDR,
> +                 index, env->dr[index]);
>      return 0;
>  }
>
>
