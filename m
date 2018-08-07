Received: from eggs.gnu.org ([2001:4830:134:3::10]:47940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fmxzc-0001dl-PG
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 05:09:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fmxzb-0003P8-Qv
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 05:09:28 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:38743)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fmxzb-0003Om-JP
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 05:09:27 -0400
Received: by mail-oi0-x244.google.com with SMTP id v8-v6so27177079oie.5
	for <qemu-devel@nongnu.org>; Tue, 07 Aug 2018 02:09:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1532005320-17794-1-git-send-email-thuth@redhat.com>
References: <1532005320-17794-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Aug 2018 10:09:06 +0100
Message-ID: <CAFEAcA-sP3mABockFiMDO2FGkW4=LHZQVm8jzVMgmZ2HePZjcA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/xtensa/cpu: Set owner of memory
 region in xtensa_cpu_initfn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Max Filippov <jcmvbkbc@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

On 19 July 2018 at 14:02, Thomas Huth <thuth@redhat.com> wrote:
> The instance_init function of the xtensa CPUs creates a memory region,
> but does not set an owner, so the memory region is not destroyed
> correctly when the CPU object is removed. This can happen when
> introspecting the CPU devices, so introspecting the CPU device will
> leave a dangling memory region object in the QOM tree. Make sure to
> set the right owner here to fix this issue.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  target/xtensa/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
> index b50c840..590813d 100644
> --- a/target/xtensa/cpu.c
> +++ b/target/xtensa/cpu.c
> @@ -149,7 +149,7 @@ static void xtensa_cpu_initfn(Object *obj)
>  #ifndef CONFIG_USER_ONLY
>      env->address_space_er = g_malloc(sizeof(*env->address_space_er));
>      env->system_er = g_malloc(sizeof(*env->system_er));
> -    memory_region_init_io(env->system_er, NULL, NULL, env, "er",
> +    memory_region_init_io(env->system_er, obj, NULL, env, "er",
>                            UINT64_C(0x100000000));
>      address_space_init(env->address_space_er, env->system_er, "ER");
>  #endif
> --

Applied to master for rc4, thanks.

-- PMM
