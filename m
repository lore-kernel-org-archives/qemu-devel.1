Received: from eggs.gnu.org ([2001:4830:134:3::10]:53268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f5nqG-0004Us-6d
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 03:37:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f5nqC-0007iP-5l
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 03:37:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54378 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f5nqC-0007iD-0s
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 03:37:20 -0400
References: <20180409091320.12504.35329.stgit@pasha-VirtualBox>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3c1eeffa-6fbb-1edf-296a-6bc7fabab26d@redhat.com>
Date: Tue, 10 Apr 2018 09:35:41 +0200
MIME-Version: 1.0
In-Reply-To: <20180409091320.12504.35329.stgit@pasha-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] icount: fix cpu_restore_state_from_tb for
 non-tb-exit cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, crosthwaite.peter@gmail.com, kbastian@mail.uni-paderborn.de, green@moxielogic.com, laurent@vivier.eu, jcmvbkbc@gmail.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, edgar.iglesias@gmail.com, shorne@gmail.com, yongbok.kim@mips.com, aurelien@aurel32.net, rth@twiddle.net

On 09/04/2018 11:13, Pavel Dovgalyuk wrote:
> @@ -29,6 +29,7 @@ void cpu_loop_exit_noexc(CPUState *cpu)
>  {
>      /* XXX: restore cpu registers saved in host registers */
>  
> +    cpu->can_do_io = !use_icount;
>      cpu->exception_index = -1;
>      siglongjmp(cpu->jmp_env, 1);
>  }
> @@ -65,14 +66,16 @@ void cpu_reloading_memory_map(void)
>  
>  void cpu_loop_exit(CPUState *cpu)
>  {
> +    cpu->can_do_io = !use_icount;
>      siglongjmp(cpu->jmp_env, 1);
>  }
>  
>  void cpu_loop_exit_restore(CPUState *cpu, uintptr_t pc)
>  {
>      if (pc) {
> -        cpu_restore_state(cpu, pc);
> +        cpu_restore_state(cpu, pc, true);
>      }
> +    cpu->can_do_io = !use_icount;
>      siglongjmp(cpu->jmp_env, 1);
>  }

This is incorrect, "cpu->can_do_io" is 1 when not in tcg_qemu_tb_exec.
In fact, in cpu_exec we have "cpu->can_do_io = 1;" immediately after
siglongjmp, so I propose adding the same "cpu->can_do_io = 1;"
assignment to cpu_exec_step_atomic.

In any case, please change the two siglongjmp of
cpu_loop_exit_{noexc,restore} to cpu_loop_exit, instead of duplicating
that cpu->can_do_io assignment.

Thanks,

Paolo
