Received: from eggs.gnu.org ([209.51.188.92]:36880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gtTUu-0003gj-IT
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 03:32:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gtTTx-0003jB-Qu
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 03:31:58 -0500
References: <20190212074840.13542-1-richard.henderson@linaro.org>
	<20190212074840.13542-2-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <dc08d748-eb29-ccb1-ae1b-62b7ad0d6ffd@vivier.eu>
Date: Tue, 12 Feb 2019 09:31:20 +0100
MIME-Version: 1.0
In-Reply-To: <20190212074840.13542-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] linux-user: Add ELF_PLATFORM for arm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org

On 12/02/2019 08:48, Richard Henderson wrote:
> The 32-bit kernel has strings for v4, v5, v6, v7, v7m.
> The 64-bit kernel, in compat mode, has strings for v8.
> 
> Fixes: https://bugs.launchpad.net/bugs/1813034
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v2: Include v8.
> ---
>  linux-user/elfload.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 775a36ccdd..d796d51ec6 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -500,6 +500,37 @@ static uint32_t get_elf_hwcap2(void)
>  #undef GET_FEATURE
>  #undef GET_FEATURE_ID
>  
> +#define ELF_PLATFORM get_elf_platform()
> +
> +static const char *get_elf_platform(void)
> +{
> +    CPUARMState *env = thread_cpu->env_ptr;
> +
> +#ifdef TARGET_WORDS_BIGENDIAN
> +# define END  "b"
> +#else
> +# define END  "l"
> +#endif
> +
> +    if (arm_feature(env, ARM_FEATURE_V8)) {
> +        return "v8" END;
> +    } else if (arm_feature(env, ARM_FEATURE_V7)) {
> +        if (arm_feature(env, ARM_FEATURE_M)) {
> +            return "v7m" END;
> +        } else {
> +            return "v7" END;
> +        }
> +    } else if (arm_feature(env, ARM_FEATURE_V6)) {
> +        return "v6" END;
> +    } else if (arm_feature(env, ARM_FEATURE_V5)) {
> +        return "v5" END;
> +    } else {
> +        return "v4" END;
> +    }

I know nothing about ARM, but in kernel we have also a "v5t"
(cpu_elf_name) and in QEMU we have a ARM_FEATURE_V4T which is set with
ARM_FEATURE_V5. Is it related?

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Thanks,
Laurent
