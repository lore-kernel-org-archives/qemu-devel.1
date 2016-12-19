Received: from eggs.gnu.org ([2001:4830:134:3::10]:42328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <leif.lindholm@linaro.org>) id 1cJ3gm-0000Dm-El
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 14:33:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <leif.lindholm@linaro.org>) id 1cJ3gl-0001IU-Dj
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 14:33:36 -0500
Received: from mail-wj0-x231.google.com ([2a00:1450:400c:c01::231]:33973)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <leif.lindholm@linaro.org>)
	id 1cJ3gk-0001H6-V6
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 14:33:35 -0500
Received: by mail-wj0-x231.google.com with SMTP id tg4so159605241wjb.1
	for <qemu-devel@nongnu.org>; Mon, 19 Dec 2016 11:33:33 -0800 (PST)
Date: Mon, 19 Dec 2016 19:33:29 +0000
From: Leif Lindholm <leif.lindholm@linaro.org>
Message-ID: <20161219193329.GR17590@bivouac.eciton.net>
References: <20161216152319.12494-1-leif.lindholm@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161216152319.12494-1-leif.lindholm@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] smbios: stop ignoring command line options
 for TARGET_ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

So, in addition to the style issue I was automatically notified of, I
also neglected to CC the appropriate people - adding them here.

As for the style issue - is it more important to adhere to
checkpatch.pl or to surrounding definitions?

Regards,

Leif

On Fri, Dec 16, 2016 at 03:23:19PM +0000, Leif Lindholm wrote:
> Commit c30e1565 ("smbios: implement smbios support for mach-virt")
> enabled automatic generation of SMBIOS tables for TARGET_ARM, and
> actually provides data for the "virt" machine.
> 
> However, do_smbios_option() still had an #ifdef TARGET_I386, preventing
> any -smbios command line options from being parsed for any non-x86
> targets.
> Change this to use a status variable instead of compile-time filtering.
> 
> Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
> ---
> 
> Verified on ARM mach-virt with UEFI shell "smbiosview" command and QEMU
> command line parameter -smbios type=0,version=foobar.
> 
>  arch_init.c                | 6 +++---
>  include/hw/smbios/smbios.h | 2 ++
>  vl.c                       | 2 ++
>  3 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/arch_init.c b/arch_init.c
> index 5cc58b2..d4e28c0 100644
> --- a/arch_init.c
> +++ b/arch_init.c
> @@ -250,9 +250,9 @@ void do_acpitable_option(const QemuOpts *opts)
>  
>  void do_smbios_option(QemuOpts *opts)
>  {
> -#ifdef TARGET_I386
> -    smbios_entry_add(opts);
> -#endif
> +    if (smbios_override) {
> +        smbios_entry_add(opts);
> +    }
>  }
>  
>  int kvm_available(void)
> diff --git a/include/hw/smbios/smbios.h b/include/hw/smbios/smbios.h
> index 1cd53cc..2a3dca2 100644
> --- a/include/hw/smbios/smbios.h
> +++ b/include/hw/smbios/smbios.h
> @@ -267,4 +267,6 @@ void smbios_get_tables(const struct smbios_phys_mem_area *mem_array,
>                         const unsigned int mem_array_size,
>                         uint8_t **tables, size_t *tables_len,
>                         uint8_t **anchor, size_t *anchor_len);
> +
> +extern int smbios_override;
>  #endif /* QEMU_SMBIOS_H */
> diff --git a/vl.c b/vl.c
> index d77dd86..8e71b06 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -159,6 +159,7 @@ int smp_cpus = 1;
>  int max_cpus = 1;
>  int smp_cores = 1;
>  int smp_threads = 1;
> +int smbios_override = 0;
>  int acpi_enabled = 1;
>  int no_hpet = 0;
>  int fd_bootchk = 1;
> @@ -3711,6 +3712,7 @@ int main(int argc, char **argv, char **envp)
>                  if (!opts) {
>                      exit(1);
>                  }
> +                smbios_override = 1;
>                  do_smbios_option(opts);
>                  break;
>              case QEMU_OPTION_fwcfg:
> -- 
> 2.10.2
> 
