Received: from eggs.gnu.org ([2001:4830:134:3::10]:45532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dLuiG-0007SQ-B2
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:07:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dLuiD-00020O-78
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:07:12 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:35740)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dLuiC-00020A-Vk
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:07:09 -0400
Received: by mail-wm0-x22d.google.com with SMTP id x70so31327114wme.0
	for <qemu-devel@nongnu.org>; Fri, 16 Jun 2017 10:07:08 -0700 (PDT)
References: <1497625153-19812-1-git-send-email-thuth@redhat.com>
	<1497625153-19812-6-git-send-email-thuth@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1497625153-19812-6-git-send-email-thuth@redhat.com>
Date: Fri, 16 Jun 2017 18:07:44 +0100
Message-ID: <87h8zfc13z.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 5/7] cpu: Introduce a wrapper for
 tlb_flush() that can be used in common code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>


Thomas Huth <thuth@redhat.com> writes:

> Commit 1f5c00cfdb8114c ("qom/cpu: move tlb_flush to cpu_common_reset")
> moved the call to tlb_flush() from the target-specific reset handlers
> into the common code qom/cpu.c file, and protected the call with
> "#ifdef CONFIG_SOFTMMU" to avoid that it is called for linux-user
> only targets. But since qom/cpu.c is common code, CONFIG_SOFTMMU is
> *never* defined here, so the tlb_flush() was simply never executed
> anymore. Fix it by introducing a wrapper for tlb_flush() in a file
> that is re-compiled for each target, i.e. in translate-all.c.
>
> Fixes: 1f5c00cfdb8114c1e3a13426588ceb64f82c9ddb
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  include/exec/cpu-common.h | 2 ++
>  qom/cpu.c                 | 5 ++---
>  translate-all.c           | 8 ++++++++
>  3 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index 4d45a72..74341b1 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -28,6 +28,8 @@ void qemu_init_cpu_list(void);
>  void cpu_list_lock(void);
>  void cpu_list_unlock(void);
>
> +void tcg_flush_softmmu_tlb(CPUState *cs);
> +
>  #if !defined(CONFIG_USER_ONLY)
>
>  enum device_endian {
> diff --git a/qom/cpu.c b/qom/cpu.c
> index 5069876..303eb42 100644
> --- a/qom/cpu.c
> +++ b/qom/cpu.c
> @@ -26,6 +26,7 @@
>  #include "qemu/notify.h"
>  #include "qemu/log.h"
>  #include "exec/log.h"
> +#include "exec/cpu-common.h"
>  #include "qemu/error-report.h"
>  #include "sysemu/sysemu.h"
>  #include "hw/qdev-properties.h"
> @@ -296,9 +297,7 @@ static void cpu_common_reset(CPUState *cpu)
>              atomic_set(&cpu->tb_jmp_cache[i], NULL);
>          }
>
> -#ifdef CONFIG_SOFTMMU
> -        tlb_flush(cpu, 0);
> -#endif
> +        tcg_flush_softmmu_tlb(cpu);
>      }
>  }
>
> diff --git a/translate-all.c b/translate-all.c
> index b3ee876..a45480f 100644
> --- a/translate-all.c
> +++ b/translate-all.c
> @@ -2219,3 +2219,11 @@ int page_unprotect(target_ulong address, uintptr_t pc)
>      return 0;
>  }
>  #endif /* CONFIG_USER_ONLY */
> +
> +/* This is a wrapper for common code that can not use CONFIG_SOFTMMU */
> +void tcg_flush_softmmu_tlb(CPUState *cs)
> +{
> +#ifdef CONFIG_SOFTMMU
> +    tlb_flush(cs);
> +#endif
> +}

Don't you usually have a empty inline for the stub in the headers so the
non-SoftMMU build can optimize away rather than link to an empty function?

--
Alex Bennée
