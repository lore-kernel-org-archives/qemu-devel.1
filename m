Received: from eggs.gnu.org ([2001:4830:134:3::10]:36987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dS0V1-0002t6-3W
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 08:30:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dS0Ux-0005YR-OJ
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 08:30:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dS0Uo-000554-Ox
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 08:30:39 -0400
References: <1499076743-15477-1-git-send-email-yang.zhong@intel.com>
	<1499076743-15477-3-git-send-email-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e7eee323-ac28-cc26-e430-143df4e92426@redhat.com>
Date: Mon, 3 Jul 2017 14:30:26 +0200
MIME-Version: 1.0
In-Reply-To: <1499076743-15477-3-git-send-email-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 02/15] vl: add tcg_enabled() for tcg
 related code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, pbonzini@redhat.com, rth@twiddle.net
Cc: anthony.xu@intel.com, qemu-devel@nongnu.org, a.rigo@virtualopensystems.com

On 03.07.2017 12:12, Yang Zhong wrote:
> Need to disable the tcg related code in the vl.c if the
> disable-tcg option is added into ./configure command.
> 
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>  accel/tcg/tcg-all.c    |  2 +-
>  include/sysemu/accel.h |  2 +-
>  vl.c                   | 15 +++++++++++----
>  3 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
> index dba9931..b86c896 100644
> --- a/accel/tcg/tcg-all.c
> +++ b/accel/tcg/tcg-all.c
> @@ -28,7 +28,7 @@
>  #include "sysemu/sysemu.h"
>  #include "qom/object.h"
>  
> -int tcg_tb_size;
> +long tcg_tb_size;

This looks like a non-related change. I think you should either put it
into a separate patch, or drop it.

>  static bool tcg_allowed = true;
>  
>  static int tcg_init(MachineState *ms)
> diff --git a/include/sysemu/accel.h b/include/sysemu/accel.h
> index ecc5c84..7b905b7 100644
> --- a/include/sysemu/accel.h
> +++ b/include/sysemu/accel.h
> @@ -63,7 +63,7 @@ typedef struct AccelClass {
>  #define ACCEL_GET_CLASS(obj) \
>      OBJECT_GET_CLASS(AccelClass, (obj), TYPE_ACCEL)
>  
> -extern int tcg_tb_size;
> +extern long tcg_tb_size;
>  
>  void configure_accelerator(MachineState *ms);
>  /* Register accelerator specific global properties */
> diff --git a/vl.c b/vl.c
> index 36ff3f4..f28c1ac 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3933,9 +3933,14 @@ int main(int argc, char **argv, char **envp)
>                  configure_rtc(opts);
>                  break;
>              case QEMU_OPTION_tb_size:
> -                tcg_tb_size = strtol(optarg, NULL, 0);
> -                if (tcg_tb_size < 0) {
> -                    tcg_tb_size = 0;
> +                if (tcg_enabled()) {
> +                    qemu_strtol(optarg, NULL, 0, &tcg_tb_size);
> +                    if (tcg_tb_size < 0) {
> +                        tcg_tb_size = 0;
> +                    }
> +                } else {
> +                    error_report("TCG is disabled");
> +                    exit(1);
>                  }


You could do this without an else-part, leaving the tcg_tb_size code
unmodified:

+                  if (!tcg_enabled()) {
+                      error_report("TCG is disabled");
+                      exit(1);
+                  }
                   tcg_tb_size = strtol(optarg, NULL, 0);
                   if (tcg_tb_size < 0) {
                       tcg_tb_size = 0;

>                  break;
>              case QEMU_OPTION_icount:
> @@ -4481,7 +4486,9 @@ int main(int argc, char **argv, char **envp)
>          qemu_opts_del(icount_opts);
>      }
>  
> -    qemu_tcg_configure(accel_opts, &error_fatal);
> +    if (tcg_enabled()) {
> +        qemu_tcg_configure(accel_opts, &error_fatal);
> +    }
>  
>      if (default_net) {
>          QemuOptsList *net = qemu_find_opts("net");
> 

 Thomas
