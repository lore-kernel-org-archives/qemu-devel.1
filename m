Received: from eggs.gnu.org ([2001:4830:134:3::10]:49890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=44841c655=anthony.perard@citrix.com>)
	id 1e1aLe-0005zb-1z
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:52:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=44841c655=anthony.perard@citrix.com>)
	id 1e1aLY-00050L-2A
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:52:06 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:46831)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=44841c655=anthony.perard@citrix.com>)
	id 1e1aLX-0004zQ-TG
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:52:00 -0400
Date: Mon, 9 Oct 2017 16:50:44 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20171009155044.GC1771@perard.uk.xensource.com>
References: <1507133891-26013-1-git-send-email-ian.jackson@eu.citrix.com>
	<1507133891-26013-4-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1507133891-26013-4-git-send-email-ian.jackson@eu.citrix.com>
Subject: Re: [Qemu-devel] [PATCH 3/8] xen: defer call to xen_restrict until
 after os_setup_post
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian Jackson <ian.jackson@eu.citrix.com>
Cc: qemu-devel@nongnu.org, Ross Lagerwall <ross.lagerwall@citrix.com>, xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@nongnu.org

On Wed, Oct 04, 2017 at 05:18:06PM +0100, Ian Jackson wrote:
> We need to restrict *all* the control fds that qemu opens.  Looking in
> /proc/PID/fd shows there are many; their allocation seems scattered
> throughout Xen support code in qemu.
> 
> We must postpone the restrict call until roughly the same time as qemu
> changes its uid, chroots (if applicable), and so on.
> 
> There doesn't seem to be an appropriate hook already.  The RunState
> change hook fires at different times depending on exactly what mode
> qemu is operating in.
> 
> And it appears that no-one but the Xen code wants a hook at this phase
> of execution.  So, introduce a bare call to a new function
> xen_setup_post, just after os_setup_post.  Also provide the
> appropriate stub for when Xen compilation is disabled.
> 
> Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
> ---
>  hw/i386/xen/xen-hvm.c   |  8 --------
>  hw/xen/xen-common.c     | 13 +++++++++++++
>  include/sysemu/sysemu.h |  2 ++
>  stubs/xen-hvm.c         |  5 +++++
>  vl.c                    |  1 +
>  5 files changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
> index d9ccd5d..7b60ec6 100644
> --- a/hw/i386/xen/xen-hvm.c
> +++ b/hw/i386/xen/xen-hvm.c
> @@ -1254,14 +1254,6 @@ void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory)
>          goto err;
>      }
>  
> -    if (xen_domid_restrict) {
> -        rc = xen_restrict(xen_domid);
> -        if (rc < 0) {
> -            error_report("failed to restrict: error %d", errno);
> -            goto err;
> -        }
> -    }
> -
>      xen_create_ioreq_server(xen_domid, &state->ioservid);
>  
>      state->exit.notify = xen_exit_notifier;
> diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
> index 632a938..4056420 100644
> --- a/hw/xen/xen-common.c
> +++ b/hw/xen/xen-common.c
> @@ -117,6 +117,19 @@ static void xen_change_state_handler(void *opaque, int running,
>      }
>  }
>  
> +void xen_setup_post(void)
> +{
> +    int rc;

We probably want to check here if Xen is enable (via xen_enabled()).
xen_domid_restrict could be true when Xen is not used, even if it does
not make sense to use -xen-domid-restrict in that case.

> +    if (xen_domid_restrict) {
> +        rc = xen_restrict(xen_domid);
> +        if (rc < 0) {
> +            perror("xen: failed to restrict");
> +            exit(1);
> +        }
> +    }
> +}
> +
>  static int xen_init(MachineState *ms)
>  {
>      xen_xc = xc_interface_open(0, 0, 0);
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index b213696..b064a55 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -93,6 +93,8 @@ void qemu_remove_machine_init_done_notifier(Notifier *notify);
>  
>  void qemu_announce_self(void);
>  
> +void xen_setup_post(void);
> +
>  extern int autostart;
>  
>  typedef enum {
> diff --git a/stubs/xen-hvm.c b/stubs/xen-hvm.c
> index 3ca6c51..9701feb 100644
> --- a/stubs/xen-hvm.c
> +++ b/stubs/xen-hvm.c
> @@ -13,6 +13,7 @@
>  #include "hw/xen/xen.h"
>  #include "exec/memory.h"
>  #include "qmp-commands.h"
> +#include "sysemu/sysemu.h"
>  
>  int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num)
>  {
> @@ -61,3 +62,7 @@ void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory)
>  void qmp_xen_set_global_dirty_log(bool enable, Error **errp)
>  {
>  }
> +
> +void xen_setup_post(void)
> +{
> +}
> diff --git a/vl.c b/vl.c
> index fb1f05b..9e7d541 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4793,6 +4793,7 @@ int main(int argc, char **argv, char **envp)
>      }
>  
>      os_setup_post();
> +    xen_setup_post();
>  
>      main_loop();
>      replay_disable_events();
> -- 
> 2.1.4
> 

-- 
Anthony PERARD
