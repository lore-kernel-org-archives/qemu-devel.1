Received: from eggs.gnu.org ([2001:4830:134:3::10]:55741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8PIg-0006L7-DA
	for qemu-devel@nongnu.org; Wed, 10 May 2017 06:56:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8PId-0007LT-9r
	for qemu-devel@nongnu.org; Wed, 10 May 2017 06:56:58 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:36318)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8PId-0007LJ-5d
	for qemu-devel@nongnu.org; Wed, 10 May 2017 06:56:55 -0400
Received: by mail-qk0-x242.google.com with SMTP id y128so4057096qka.3
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 03:56:55 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170509082800.10756-1-aurelien@aurel32.net>
	<20170509082800.10756-2-aurelien@aurel32.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <36475121-d5c9-4814-7762-cb5778848cb2@amsat.org>
Date: Wed, 10 May 2017 07:56:50 -0300
MIME-Version: 1.0
In-Reply-To: <20170509082800.10756-2-aurelien@aurel32.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/3] target/s390x: mask the SIGP order_code
 using SIGP_ORDER_MASK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

On 05/09/2017 05:27 AM, Aurelien Jarno wrote:
> For that move the definition from kvm.c to cpu.h
>
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/s390x/cpu.h         | 3 +++
>  target/s390x/kvm.c         | 2 --
>  target/s390x/misc_helper.c | 3 +--
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index df823280a5..2471db920d 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -1081,6 +1081,9 @@ struct sysib_322 {
>  #define SIGP_MODE_Z_ARCH_TRANS_ALL_PSW 1
>  #define SIGP_MODE_Z_ARCH_TRANS_CUR_PSW 2
>
> +/* SIGP order code mask corresponding to bit positions 56-63 */
> +#define SIGP_ORDER_MASK 0x000000ff
> +
>  void load_psw(CPUS390XState *env, uint64_t mask, uint64_t addr);
>  int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, uint64_t asc,
>                    target_ulong *raddr, int *flags, bool exc);
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 1a249d8359..fb105429be 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -1764,8 +1764,6 @@ static int sigp_set_architecture(S390CPU *cpu, uint32_t param,
>      return SIGP_CC_ORDER_CODE_ACCEPTED;
>  }
>
> -#define SIGP_ORDER_MASK 0x000000ff
> -
>  static int handle_sigp(S390CPU *cpu, struct kvm_run *run, uint8_t ipa1)
>  {
>      CPUS390XState *env = &cpu->env;
> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
> index 53cb3b8ac6..395f38dea5 100644
> --- a/target/s390x/misc_helper.c
> +++ b/target/s390x/misc_helper.c
> @@ -521,8 +521,7 @@ uint32_t HELPER(sigp)(CPUS390XState *env, uint64_t order_code, uint32_t r1,
>
>      qemu_mutex_lock_iothread();
>
> -    /* sigp contains the order code in bit positions 56-63, mask it here. */
> -    switch (order_code & 0xff) {
> +    switch (order_code & SIGP_ORDER_MASK) {
>      case SIGP_SET_ARCH:
>          cc = SIGP_CC_ORDER_CODE_ACCEPTED;
>          /* switch arch */
>
