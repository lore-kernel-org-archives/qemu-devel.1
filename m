Received: from eggs.gnu.org ([209.51.188.92]:46976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEWKZ-0000S5-Ip
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:49:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEWKY-0003wf-HM
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:49:15 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56308)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hEWKY-0003rr-4B
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:49:14 -0400
Received: by mail-wm1-f66.google.com with SMTP id o25so5861822wmf.5
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 02:49:14 -0700 (PDT)
References: <20190315032629.21234-1-richard.henderson@linaro.org>
	<20190315032629.21234-13-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6ea1d95e-f5c7-7b14-04c7-07699e9d564a@redhat.com>
Date: Thu, 11 Apr 2019 11:49:11 +0200
MIME-Version: 1.0
In-Reply-To: <20190315032629.21234-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 12/23] linux-user: Call qcrypto_init if
 not using -seed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>

Hi Richard,

On 3/15/19 4:26 AM, Richard Henderson wrote:
> Cc: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/main.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-user/main.c b/linux-user/main.c
> index cf7095bdaf..8478306eef 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -38,6 +38,7 @@
>  #include "trace/control.h"
>  #include "target_elf.h"
>  #include "cpu_loop-common.h"
> +#include "crypto/init.h"
>  
>  char *exec_path;
>  
> @@ -686,8 +687,18 @@ int main(int argc, char **argv, char **envp)
>      if (seed_optarg == NULL) {
>          seed_optarg = getenv("QEMU_RAND_SEED");
>      }
> -    if (seed_optarg != NULL) {
> -        qemu_guest_random_seed_main(seed_optarg, &error_fatal);
> +    {

Since 7be41675f7c we use gnu99 C, so this extra block indentation can be
removed.

> +        Error *err = NULL;
> +        if (seed_optarg != NULL) {
> +            qemu_guest_random_seed_main(seed_optarg, &err);
> +        } else {
> +            /* ??? Assumes qcrypto is only used by qemu_guest_getrandom.  */
> +            qcrypto_init(&err);
> +        }
> +        if (err) {
> +            error_reportf_err(err, "cannot initialize crypto: ");
> +            exit(1);
> +        }
>      }
>  
>      target_environ = envlist_to_environ(envlist, NULL);
> 
