Received: from eggs.gnu.org ([209.51.188.92]:48336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h3PJh-0005IS-EQ
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 14:06:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h3PJg-0005iq-Ag
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 14:06:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39593)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1h3PJf-0005hL-Ti
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 14:06:24 -0400
References: <20190311180216.18811-1-jandryuk@gmail.com>
	<20190311180216.18811-2-jandryuk@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d7fb0cfd-9573-028c-5631-be9df4102fcc@redhat.com>
Date: Mon, 11 Mar 2019 19:06:17 +0100
MIME-Version: 1.0
In-Reply-To: <20190311180216.18811-2-jandryuk@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/6] xen: Introduce -xen-stubdom option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Andryuk <jandryuk@gmail.com>, qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, marmarek@invisiblethingslab.com, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul.durrant@citrix.com>

On 11/03/19 19:02, Jason Andryuk wrote:
> With Xen, QEMU can run isolated in a dedicated service VM - a stubdom.
> There are a few differences when running in a stubdom compared to dom0.
> Add the -xen-stubdom option to select this mode at runtime.  The default
> is off.

This should be "-accel xen,stubdom=on".  You should find examples for
tcg that explain how to add a suboption to -accel.

Paolo

> Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
> ---
>  include/hw/xen/xen.h | 6 ++++++
>  qemu-options.hx      | 7 +++++++
>  vl.c                 | 8 ++++++++
>  3 files changed, 21 insertions(+)
> 
> diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
> index ba039c146d..fed3611623 100644
> --- a/include/hw/xen/xen.h
> +++ b/include/hw/xen/xen.h
> @@ -21,6 +21,7 @@ enum xen_mode {
>  extern uint32_t xen_domid;
>  extern enum xen_mode xen_mode;
>  extern bool xen_domid_restrict;
> +extern bool xen_stubdom;
>  
>  extern bool xen_allowed;
>  
> @@ -29,6 +30,11 @@ static inline bool xen_enabled(void)
>      return xen_allowed;
>  }
>  
> +static inline bool xen_stubdom_enabled(void)
> +{
> +    return xen_stubdom;
> +}
> +
>  int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num);
>  void xen_piix3_set_irq(void *opaque, int irq_num, int level);
>  void xen_piix_pci_write_config_client(uint32_t address, uint32_t val, int len);
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 1cf9aac1fe..ba56c3dd9a 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3386,6 +3386,10 @@ DEF("xen-domid-restrict", 0, QEMU_OPTION_xen_domid_restrict,
>      "                        to specified domain id. (Does not affect\n"
>      "                        xenpv machine type).\n",
>      QEMU_ARCH_ALL)
> +DEF("xen-stubdom", 0, QEMU_OPTION_xen_stubdom,
> +    "-xen-stubdom    specify QEMU is running in a stubdom, so certain\n"
> +    "                behavior changes. (Does not affect xenpv machine type).\n",
> +    QEMU_ARCH_ALL)
>  STEXI
>  @item -xen-domid @var{id}
>  @findex -xen-domid
> @@ -3396,6 +3400,9 @@ Attach to existing xen domain.
>  libxl will use this when starting QEMU (XEN only).
>  @findex -xen-domid-restrict
>  Restrict set of available xen operations to specified domain id (XEN only).
> +@findex -xen-stubdom
> +@item -xen-stubdom
> +Run qemu in stubdom-mode (XEN only).
>  ETEXI
>  
>  DEF("no-reboot", 0, QEMU_OPTION_no_reboot, \
> diff --git a/vl.c b/vl.c
> index 4a350de5cd..0d04319d9b 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -206,6 +206,7 @@ bool xen_allowed;
>  uint32_t xen_domid;
>  enum xen_mode xen_mode = XEN_EMULATE;
>  bool xen_domid_restrict;
> +bool xen_stubdom;
>  
>  static int has_defaults = 1;
>  static int default_serial = 1;
> @@ -3796,6 +3797,13 @@ int main(int argc, char **argv, char **envp)
>                  }
>                  xen_domid_restrict = true;
>                  break;
> +            case QEMU_OPTION_xen_stubdom:
> +                if (!(xen_available())) {
> +                    error_report("Option not supported for this target");
> +                    exit(1);
> +                }
> +                xen_stubdom = true;
> +                break;
>              case QEMU_OPTION_trace:
>                  g_free(trace_file);
>                  trace_file = trace_opt_parse(optarg);
> 
