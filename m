Received: from eggs.gnu.org ([2001:4830:134:3::10]:39815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fpf4d-0007uT-IU
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 15:34:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fpf4N-0007NX-Og
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 15:33:46 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:57751)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fpf4N-0007MP-4h
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 15:33:31 -0400
References: <20180809175553.18479-1-alex.bennee@linaro.org>
	<20180809175553.18479-4-alex.bennee@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <b6621977-6ca8-e4d4-ff9c-238df764f135@vivier.eu>
Date: Tue, 14 Aug 2018 21:32:50 +0200
MIME-Version: 1.0
In-Reply-To: <20180809175553.18479-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 3/3] linux-user: add -dfilter progtext
 shortcut
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>

Le 09/08/2018 à 19:55, Alex Bennée a écrit :
> When debugging you often don't care about the libraries but just the
> code in the testcase. Rather than make the user build this by hand
> offer a shortcut.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  linux-user/main.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/main.c b/linux-user/main.c
> index ea00dd9057..8d4427727e 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -28,6 +28,7 @@
>  #include "qemu/config-file.h"
>  #include "qemu/cutils.h"
>  #include "qemu/help_option.h"
> +#include "qemu/range.h"
>  #include "cpu.h"
>  #include "exec/exec-all.h"
>  #include "tcg.h"
> @@ -51,6 +52,8 @@ unsigned long mmap_min_addr;
>  unsigned long guest_base;
>  int have_guest_base;
>  
> +static bool dfilter_progtext;
> +
>  /*
>   * When running 32-on-64 we should make sure we can fit all of the possible
>   * guest address space into a contiguous chunk of virtual host memory.
> @@ -222,6 +225,11 @@ static void handle_arg_log(const char *arg)
>  
>  static void handle_arg_dfilter(const char *arg)
>  {
> +    if (strcmp(arg, "progtext") == 0) {
> +        dfilter_progtext = true;
> +        return;
> +    }
> +
>      qemu_set_dfilter_ranges(arg, NULL);
>  }
>  
> @@ -423,7 +431,7 @@ static const struct qemu_argument arg_table[] = {
>       "item[,...]", "enable logging of specified items "
>       "(use '-d help' for a list of items)"},
>      {"dfilter",    "QEMU_DFILTER",     true,  handle_arg_dfilter,
> -     "range[,...]","filter logging based on address range"},
> +     "range|progtext[,...]", "filter logging based on address range"},
>      {"D",          "QEMU_LOG_FILENAME", true, handle_arg_log_filename,
>       "logfile",     "write logs to 'logfile' (default stderr)"},
>      {"p",          "QEMU_PAGESIZE",    true,  handle_arg_pagesize,
> @@ -796,6 +804,12 @@ int main(int argc, char **argv, char **envp)
>          qemu_log("auxv_start  0x" TARGET_ABI_FMT_lx "\n", info->saved_auxv);
>      }
>  
> +    if (dfilter_progtext) {
> +        Range r;
> +        range_set_bounds(&r, info->start_code, info->end_code);
> +        qemu_append_dfilter_range(r, NULL);
> +    }
> +
>      target_set_brk(info->brk);
>      syscall_init();
>      signal_init();
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
