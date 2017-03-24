Received: from eggs.gnu.org ([2001:4830:134:3::10]:57272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jgross@suse.com>) id 1crKZg-0001Sd-0v
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 04:27:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jgross@suse.com>) id 1crKZc-0000dZ-TE
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 04:27:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:56972)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jgross@suse.com>) id 1crKZc-0000dR-Nd
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 04:27:52 -0400
References: <20170323212848.8492-1-ehabkost@redhat.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <3eb52532-25f4-2761-de73-3cf82d00e6c4@suse.com>
Date: Fri, 24 Mar 2017 09:27:50 +0100
MIME-Version: 1.0
In-Reply-To: <20170323212848.8492-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 0/4] Replace has_dynamic_sysbus with device
 type whitelist
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, sstabellini@kernel.org, Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

On 23/03/17 22:28, Eduardo Habkost wrote:
> Summary
> -------
> 
> This series replaces the existing has_dynamic_sysbus flag (that
> makes the machine accept every single sysbus device type on the
> command-line) with a short whitelist.
> 
> This will be helpful when implementing the new query-device-slots
> command, because each machine type will include only the sysbus
> devices it really supports, instead of including a catch-all
> TYPE_SYS_BUS_DEVICE "slot".
> 
> Most of the machines already have an internal whitelist
> implemented using foreach_dynamic_sysbus_device(), so we just
> encode the existing behavior inside the new MachineClass field.
> 
> Caveat: q35
> -----------
> 
> The only problematic case is q35, that accepts all sysbus device
> types. In this case, instead of adding TYPE_SYS_BUS_DEVICE to the
> whitelist, I'm adding the existing list of existing sysbus device
> types to keep compatibility. After that, we can gradually and
> carefully remove unnecessary entries from the q35 whitelist.
> 
> Issue: xen_set_dynamic_sysbus() hack
> ------------------------------------
> 
> We still have an obstacle to get around: the callers of
> qdev_set_id() outside qdev_device_add() are breaking
> foreach_dynamic_sysbus_device(), and xen_set_dynamic_sysbus() is
> a workaround for that bug. We now need to fix that bug to be able
> to remove the xen_set_dynamic_sysbus() hack. This means the first
> patch of this series will probably break Xen, until we fix that
> bug.
> 
> Eduardo Habkost (4):
>   [UNTESTED] xen: Don't force has_dynamic_sysbus on machine class
>   machine: Replace has_dynamic_sysbus with a whitelist
>   q35: Remove ioapic devices from sysbus whitelist
>   q35: Remove fw_cfg* from sysbus whitelist
> 
>  include/hw/arm/sysbus-fdt.h |  7 +++++++
>  include/hw/boards.h         |  3 ++-
>  hw/arm/sysbus-fdt.c         | 10 ++++++++++
>  hw/arm/virt.c               |  4 +++-
>  hw/core/machine.c           | 43 +++++++++++++++++++++++++++++--------------
>  hw/i386/pc_q35.c            | 25 ++++++++++++++++++++++++-
>  hw/ppc/e500plat.c           |  4 +++-
>  hw/ppc/spapr.c              |  2 +-
>  hw/xen/xen_backend.c        | 11 -----------
>  9 files changed, 79 insertions(+), 30 deletions(-)
> 

This seems to break Xen. I got:

qemu-system-i386: Option '-device xen-backend' cannot be handled by this
machine

when using qemu as Xen backend driver.


Juergen
