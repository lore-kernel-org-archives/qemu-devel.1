Received: from eggs.gnu.org ([2001:4830:134:3::10]:42948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUxgP-0004i7-20
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:06:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUxgO-0003LN-3d
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:06:41 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170711025703.24194-1-f4bug@amsat.org>
	<20170711025703.24194-2-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <446cc0e3-dd49-e088-85f1-0caf1d42fbf8@amsat.org>
Date: Tue, 11 Jul 2017 13:06:28 -0300
MIME-Version: 1.0
In-Reply-To: <20170711025703.24194-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 1/3] configure: disable Xen PCI
 Passthrough on !x86 archs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, qemu-arm@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Anthony Perard <anthony.perard@citrix.com>, Marcelo Tosatti <mtosatti@redhat.com>, xen-arm@lists.xen.org, Anoob Soman <anoob.soman@citrix.com>, Juergen Gross <jgross@suse.com>, Anthony Xu <anthony.xu@intel.com>, Paul Durrant <paul.durrant@citrix.com>

It seems our minds crossed at the same time since Alex/Pablo fixed it 
and got merged in master as b5ed2e11ef39 "build: disable Xen on ARM" so 
this patch is no more necessary.

Alex/Pablo, any thought on patch 2 regarding xen-mapcache.h?

Phil.

On 07/10/2017 11:57 PM, Philippe Mathieu-Daudé wrote:
> linking on Linux debian/stretch/arm64 with libxen-4.8:
> 
>      hw/xen/xen_pt.o: In function `xen_pt_pci_read_config':
>      qemu/hw/xen/xen_pt.c:206: undefined reference to `xen_shutdown_fatal_error'
>      hw/xen/xen_pt.o: In function `xen_igd_passthrough_isa_bridge_create':
>      qemu/hw/xen/xen_pt.c:698: undefined reference to `igd_passthrough_isa_bridge_create'
>      hw/xen/xen_pt.o: In function `xen_pt_pci_write_config':
>      qemu/hw/xen/xen_pt.c:355: undefined reference to `xen_shutdown_fatal_error'
>      hw/xen/xen_pt_config_init.o: In function `xen_pt_status_reg_init':
>      qemu/hw/xen/xen_pt_config_init.c:281: undefined reference to `xen_shutdown_fatal_error'
>      qemu/hw/xen/xen_pt_config_init.c:275: undefined reference to `xen_shutdown_fatal_error'
>      hw/xen/xen_pt_graphics.o: In function `get_vgabios':
>      qemu/hw/xen/xen_pt_graphics.c:135: undefined reference to `pci_assign_dev_load_option_rom'
>      collect2: error: ld returned 1 exit status
>      Makefile:197: recipe for target 'qemu-system-aarch64' failed
>      make[1]: *** [qemu-system-aarch64] Error 1
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>   configure | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/configure b/configure
> index 806658c98b..e4b173405a 100755
> --- a/configure
> +++ b/configure
> @@ -2344,8 +2344,15 @@ EOF
>   fi
>   
>   if test "$xen_pci_passthrough" != "no"; then
> -  if test "$xen" = "yes" && test "$linux" = "yes"; then
> -    xen_pci_passthrough=yes
> +  if test "$xen" = "yes"; then
> +    case "$cpu" in
> +    i386|x32|x86_64)
> +        if test "$linux" = "yes"; then
> +            xen_pci_passthrough=yes
> +        fi ;;
> +    *)  echo "Disabling Xen PCI Passthrough (not implemented on $cpu)"
> +        xen_pci_passthrough=no ;;
> +    esac
>     else
>       if test "$xen_pci_passthrough" = "yes"; then
>         error_exit "User requested feature Xen PCI Passthrough" \
> 
