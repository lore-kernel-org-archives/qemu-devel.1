Received: from eggs.gnu.org ([2001:4830:134:3::10]:40317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1e7pqd-0002oK-PE
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 17:37:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1e7pqY-0003BU-RX
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 17:37:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:47602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1e7pqY-0003Ai-IR
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 17:37:50 -0400
Date: Thu, 26 Oct 2017 14:37:48 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <1508506702-17704-3-git-send-email-ian.jackson@eu.citrix.com>
Message-ID: <alpine.DEB.2.10.1710261436380.3086@sstabellini-ThinkPad-X260>
References: <23017.64539.31230.43449@mariner.uk.xensource.com>
	<1508506702-17704-1-git-send-email-ian.jackson@eu.citrix.com>
	<1508506702-17704-3-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v5.1 3/8] xen: defer call to xen_restrict
 until just before os_setup_post
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian Jackson <ian.jackson@eu.citrix.com>
Cc: qemu-devel@nongnu.org, Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org, mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com

This patch affects non-Xen components. CC'ing the relevant maintainers.

On Fri, 20 Oct 2017, Ian Jackson wrote:
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
> xen_setup_post, just before os_setup_post.  Also provide the
> appropriate stub for when Xen compilation is disabled.
> 
> We do the restriction before rather than after os_setup_post, because
> xen_restrict may need to open /dev/null, and os_setup_post might have
> called chroot.
> 
> Currently this does not work with migration, because when running as
> the Xen device model qemu needs to signal to the toolstack that it is
> ready.  It currently does this using xenstore, and for incoming
> migration (but not for ordinary startup) that happens after
> os_setup_post.
> 
> It is correct that this happens late: we want the incoming migration
> stream to be processed by a restricted qemu.  The fix for this will be
> to do the startup notification a different way, without using
> xenstore.  (QMP is probably a reasonable choice.)
> 
> So for now this restriction feature cannot be used in conjunction with
> migration.  (Note that this is not a regression in this patch, because
> previously the -xen-restrict-domid call was, in fact, simply
> ineffective!)  We will revisit this in the Xen 4.11 release cycle.
> 
> Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
> Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
> ---
> v5: Discuss problems with migration startup notification
>     in the commit message.
> v3: Do xen_setup_post just before, not just after, os_setup_post,
>     to improve interaction with chroot.  Thanks to Ross Lagerwall.
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
> +
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
> index fb1f05b..ca06553 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4792,6 +4792,7 @@ int main(int argc, char **argv, char **envp)
>          vm_start();
>      }
>  
> +    xen_setup_post();
>      os_setup_post();
>  
>      main_loop();
> -- 
> 2.1.4
> 
