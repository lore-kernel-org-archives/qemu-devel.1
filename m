Received: from eggs.gnu.org ([2001:4830:134:3::10]:57735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1clJCJ-0006Cb-Ax
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 12:46:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1clJCG-0002p9-5Y
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 12:46:55 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:35693)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1clJCG-0002p3-0O
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 12:46:52 -0500
Received: by mail-qk0-x242.google.com with SMTP id o135so2948852qke.2
	for <qemu-devel@nongnu.org>; Tue, 07 Mar 2017 09:46:51 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170307155054.5833-1-alex.bennee@linaro.org>
	<20170307155054.5833-6-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b8326233-2274-431a-0c4c-e4c7d77aa951@amsat.org>
Date: Tue, 7 Mar 2017 14:46:46 -0300
MIME-Version: 1.0
In-Reply-To: <20170307155054.5833-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 05/11] s390x/misc_helper.c: wrap IO
 instructions in BQL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, rth@twiddle.net, pbonzini@redhat.com
Cc: mttcg@listserver.greensocs.com, Alexander Graf <agraf@suse.de>, nikunj@linux.vnet.ibm.com, a.rigo@virtualopensystems.com, qemu-devel@nongnu.org, cota@braap.org, bobby.prani@gmail.com, fred.konrad@greensocs.com

On 03/07/2017 12:50 PM, Alex Bennée wrote:
> Helpers that can trigger IO events (including interrupts) need to be
> protected by the BQL. I've updated all the helpers that call into an
> ioinst_handle_* functions.
>
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/s390x/misc_helper.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
> index 3cb942e8bb..93b0e61366 100644
> --- a/target/s390x/misc_helper.c
> +++ b/target/s390x/misc_helper.c
> @@ -19,6 +19,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qemu/main-loop.h"
>  #include "cpu.h"
>  #include "exec/memory.h"
>  #include "qemu/host-utils.h"
> @@ -551,61 +552,81 @@ uint32_t HELPER(sigp)(CPUS390XState *env, uint64_t order_code, uint32_t r1,
>  void HELPER(xsch)(CPUS390XState *env, uint64_t r1)
>  {
>      S390CPU *cpu = s390_env_get_cpu(env);
> +    qemu_mutex_lock_iothread();
>      ioinst_handle_xsch(cpu, r1);
> +    qemu_mutex_unlock_iothread();
>  }
>
>  void HELPER(csch)(CPUS390XState *env, uint64_t r1)
>  {
>      S390CPU *cpu = s390_env_get_cpu(env);
> +    qemu_mutex_lock_iothread();
>      ioinst_handle_csch(cpu, r1);
> +    qemu_mutex_unlock_iothread();
>  }
>
>  void HELPER(hsch)(CPUS390XState *env, uint64_t r1)
>  {
>      S390CPU *cpu = s390_env_get_cpu(env);
> +    qemu_mutex_lock_iothread();
>      ioinst_handle_hsch(cpu, r1);
> +    qemu_mutex_unlock_iothread();
>  }
>
>  void HELPER(msch)(CPUS390XState *env, uint64_t r1, uint64_t inst)
>  {
>      S390CPU *cpu = s390_env_get_cpu(env);
> +    qemu_mutex_lock_iothread();
>      ioinst_handle_msch(cpu, r1, inst >> 16);
> +    qemu_mutex_unlock_iothread();
>  }
>
>  void HELPER(rchp)(CPUS390XState *env, uint64_t r1)
>  {
>      S390CPU *cpu = s390_env_get_cpu(env);
> +    qemu_mutex_lock_iothread();
>      ioinst_handle_rchp(cpu, r1);
> +    qemu_mutex_unlock_iothread();
>  }
>
>  void HELPER(rsch)(CPUS390XState *env, uint64_t r1)
>  {
>      S390CPU *cpu = s390_env_get_cpu(env);
> +    qemu_mutex_lock_iothread();
>      ioinst_handle_rsch(cpu, r1);
> +    qemu_mutex_unlock_iothread();
>  }
>
>  void HELPER(ssch)(CPUS390XState *env, uint64_t r1, uint64_t inst)
>  {
>      S390CPU *cpu = s390_env_get_cpu(env);
> +    qemu_mutex_lock_iothread();
>      ioinst_handle_ssch(cpu, r1, inst >> 16);
> +    qemu_mutex_unlock_iothread();
>  }
>
>  void HELPER(stsch)(CPUS390XState *env, uint64_t r1, uint64_t inst)
>  {
>      S390CPU *cpu = s390_env_get_cpu(env);
> +    qemu_mutex_lock_iothread();
>      ioinst_handle_stsch(cpu, r1, inst >> 16);
> +    qemu_mutex_unlock_iothread();
>  }
>
>  void HELPER(tsch)(CPUS390XState *env, uint64_t r1, uint64_t inst)
>  {
>      S390CPU *cpu = s390_env_get_cpu(env);
> +    qemu_mutex_lock_iothread();
>      ioinst_handle_tsch(cpu, r1, inst >> 16);
> +    qemu_mutex_unlock_iothread();
>  }
>
>  void HELPER(chsc)(CPUS390XState *env, uint64_t inst)
>  {
>      S390CPU *cpu = s390_env_get_cpu(env);
> +    qemu_mutex_lock_iothread();
>      ioinst_handle_chsc(cpu, inst >> 16);
> +    qemu_mutex_unlock_iothread();
>  }
>  #endif
>
>
