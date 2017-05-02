Received: from eggs.gnu.org ([2001:4830:134:3::10]:49593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d5XO8-0000Ts-DU
	for qemu-devel@nongnu.org; Tue, 02 May 2017 08:58:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d5XO4-0003j0-Et
	for qemu-devel@nongnu.org; Tue, 02 May 2017 08:58:44 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:34202)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1d5XO4-0003iU-4x
	for qemu-devel@nongnu.org; Tue, 02 May 2017 08:58:40 -0400
Received: by mail-wm0-x244.google.com with SMTP id z129so4302076wmb.1
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 05:58:39 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1493718721-29774-1-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <22796dd6-15ce-36c8-e7ad-3403fcc70089@redhat.com>
Date: Tue, 2 May 2017 14:58:35 +0200
MIME-Version: 1.0
In-Reply-To: <1493718721-29774-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] Fix the -accel parameter and the
 documentation for 'hax'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Vincent Palatin <vpalatin@chromium.org>, Eduardo Habkost <ehabkost@redhat.com>



On 02/05/2017 11:52, Thomas Huth wrote:
> Since 'hax' is a possible accelerator nowadays, too, the '-accel'
> option should support it and we should mention it in the documentation,
> too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  qemu-options.hx |  8 ++++----
>  vl.c            | 24 ++++++++++--------------
>  2 files changed, 14 insertions(+), 18 deletions(-)
> 
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 787b9c3..c7b1d2d 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -31,7 +31,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
>      "-machine [type=]name[,prop[=value][,...]]\n"
>      "                selects emulated machine ('-machine help' for list)\n"
>      "                property accel=accel1[:accel2[:...]] selects accelerator\n"
> -    "                supported accelerators are kvm, xen, tcg (default: tcg)\n"
> +    "                supported accelerators are kvm, xen, hax or tcg (default: tcg)\n"
>      "                kernel_irqchip=on|off|split controls accelerated irqchip support (default=off)\n"
>      "                vmport=on|off|auto controls emulation of vmport (default: auto)\n"
>      "                kvm_shadow_mem=size of KVM shadow MMU in bytes\n"
> @@ -52,9 +52,9 @@ available machines. Supported machine properties are:
>  @table @option
>  @item accel=@var{accels1}[:@var{accels2}[:...]]
>  This is used to enable an accelerator. Depending on the target architecture,
> -kvm, xen, or tcg can be available. By default, tcg is used. If there is more
> -than one accelerator specified, the next one is used if the previous one fails
> -to initialize.
> +kvm, xen, hax or tcg can be available. By default, tcg is used. If there is
> +more than one accelerator specified, the next one is used if the previous one
> +fails to initialize.
>  @item kernel_irqchip=on|off
>  Controls in-kernel irqchip support for the chosen accelerator when available.
>  @item gfx_passthru=on|off
> diff --git a/vl.c b/vl.c
> index f46e070..d5e88fb 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3725,26 +3725,22 @@ int main(int argc, char **argv, char **envp)
>                  qdev_prop_register_global(&kvm_pit_lost_tick_policy);
>                  break;
>              }
> -            case QEMU_OPTION_accel:
> +            case QEMU_OPTION_accel: {
> +                char *mstr;
> +
>                  accel_opts = qemu_opts_parse_noisily(qemu_find_opts("accel"),
>                                                       optarg, true);
>                  optarg = qemu_opt_get(accel_opts, "accel");
> -
> -                olist = qemu_find_opts("machine");
> -                if (strcmp("kvm", optarg) == 0) {
> -                    qemu_opts_parse_noisily(olist, "accel=kvm", false);
> -                } else if (strcmp("xen", optarg) == 0) {
> -                    qemu_opts_parse_noisily(olist, "accel=xen", false);
> -                } else if (strcmp("tcg", optarg) == 0) {
> -                    qemu_opts_parse_noisily(olist, "accel=tcg", false);
> -                } else {
> -                    if (!is_help_option(optarg)) {
> -                        error_printf("Unknown accelerator: %s", optarg);
> -                    }
> -                    error_printf("Supported accelerators: kvm, xen, tcg\n");
> +                if (is_help_option(optarg)) {
> +                    error_printf("Possible accelerators: kvm, xen, hax, tcg\n");
>                      exit(1);
>                  }
> +                mstr = g_strdup_printf("accel=%s", optarg);
> +                olist = qemu_find_opts("machine");
> +                qemu_opts_parse_noisily(olist, mstr, false);

Thanks for the report.  I think this has bad side effects when one
specifies an invalid accelerator such as -accel tcg,,usb=on.  Eduardo
has more plans for -accel, I think.

Paolo

> +                g_free(mstr);
>                  break;
> +            }
>              case QEMU_OPTION_usb:
>                  olist = qemu_find_opts("machine");
>                  qemu_opts_parse_noisily(olist, "usb=on", false);
> 
