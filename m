Received: from eggs.gnu.org ([2001:4830:134:3::10]:38927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g8RGH-0006Zx-Kr
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 10:39:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g8RGC-0006pH-Fj
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 10:39:25 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37928)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g8RGA-0006cw-Es
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 10:39:20 -0400
Received: by mail-wm1-f66.google.com with SMTP id 193-v6so2160393wme.3
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 07:39:14 -0700 (PDT)
References: <1538748792-19444-1-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b4afdb29-40d2-73dd-7537-9de59ce52a5b@redhat.com>
Date: Fri, 5 Oct 2018 16:39:11 +0200
MIME-Version: 1.0
In-Reply-To: <1538748792-19444-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] accel: Improve selection of the default
 accelerator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On 05/10/2018 16:13, Thomas Huth wrote:
> When compiling with "--disable-tcg", we currently still use "tcg"
> as default accelerator. "kvm" should be used in this case instead.
> Also, some downstream distros provide QEMU binaries which have "kvm"
> in their names (e.g. "qemu-kvm" on RHEL or "kvm" on Ubuntu) that use
> KVM by default - and some users might want to do something similar
> with upstream binaries, too. Accomodate them by using "kvm:tcg" as
> default when we detect such a binary name.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  accel/accel.c          | 18 +++++++++++++++---
>  include/sysemu/accel.h |  2 +-
>  vl.c                   |  2 +-
>  3 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/accel/accel.c b/accel/accel.c
> index 966b2d8..9be195c 100644
> --- a/accel/accel.c
> +++ b/accel/accel.c
> @@ -68,7 +68,7 @@ static int accel_init_machine(AccelClass *acc, MachineState *ms)
>      return ret;
>  }
>  
> -void configure_accelerator(MachineState *ms)
> +void configure_accelerator(MachineState *ms, const char *progname)
>  {
>      const char *accel;
>      char **accel_list, **tmp;
> @@ -79,8 +79,20 @@ void configure_accelerator(MachineState *ms)
>  
>      accel = qemu_opt_get(qemu_get_machine_opts(), "accel");
>      if (accel == NULL) {
> -        /* Use the default "accelerator", tcg */
> -        accel = "tcg";
> +        /* Select the default accelerator */
> +        int pnlen = strlen(progname);
> +        if (pnlen >= 3 && g_str_equal(&progname[pnlen - 3], "kvm")) {
> +            /* If the program name ends with "kvm", we prefer KVM */
> +            accel = "kvm:tcg";
> +        } else {
> +#if defined(CONFIG_TCG)
> +            accel = "tcg";

OK until here.

> +#elif defined(CONFIG_KVM)
> +            accel = "kvm";

I'm not sure "kvm" here is necessary.

> +#else
> +#error "No default accelerator available"
> +#endif
> +        }
>      }
>  
>      accel_list = g_strsplit(accel, ":", 0);
> diff --git a/include/sysemu/accel.h b/include/sysemu/accel.h
> index 637358f..285899e 100644
> --- a/include/sysemu/accel.h
> +++ b/include/sysemu/accel.h
> @@ -66,7 +66,7 @@ typedef struct AccelClass {
>  
>  extern unsigned long tcg_tb_size;
>  
> -void configure_accelerator(MachineState *ms);
> +void configure_accelerator(MachineState *ms, const char *progname);
>  /* Register accelerator specific global properties */
>  void accel_register_compat_props(AccelState *accel);
>  /* Called just before os_setup_post (ie just before drop OS privs) */
> diff --git a/vl.c b/vl.c
> index 0388852..757246a 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4220,7 +4220,7 @@ int main(int argc, char **argv, char **envp)
>          exit(1);
>      }
>  
> -    configure_accelerator(current_machine);
> +    configure_accelerator(current_machine, argv[0]);
>  
>      if (!qtest_enabled() && machine_class->deprecation_reason) {
>          error_report("Machine type '%s' is deprecated: %s",
> 
