Received: from eggs.gnu.org ([2001:4830:134:3::10]:56877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1d8syx-0007BR-UU
	for qemu-devel@nongnu.org; Thu, 11 May 2017 14:38:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1d8syu-0000jO-0t
	for qemu-devel@nongnu.org; Thu, 11 May 2017 14:38:36 -0400
References: <20170505204746.14116-1-danielhb@linux.vnet.ibm.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <f1b6a40d-3094-2896-6e50-699243813526@redhat.com>
Date: Thu, 11 May 2017 20:38:27 +0200
MIME-Version: 1.0
In-Reply-To: <20170505204746.14116-1-danielhb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 0/6] migration/ppc: migrating DRC,
 ccs_list and pending_events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, david@gibson.dropbear.id.au

Hi Daniel,

I'd like to test your patch series: is there a way to generate easily
the problem your series wants to fix?

Thanks,
Laurent

On 05/05/2017 22:47, Daniel Henrique Barboza wrote:
> v9:
> - patch 1 (*new*): added a qtail in sPAPRMachineState called pending_dimm_unplugs
> that stores the DIMM LMB state during the unplug process.
> - patch 2 (*new*): merged v8-patch1 and v8-patch2: removing detach_cb and
> detach_cb_opaque.
> - patch 3:
>     * removed dk->vmsd entry. We're using vmstate_register instead
>     * added 'awaiting_allocation' flag in the DRC migration
> - patch 4 (*new*): migrating spapr->pending_dimm_unplugs qtailq to allow
> for an ongoing PCDIMM unplug to continue after a migration.
> 
> v8:
> - new patch added: 'removing spapr_drc_detach_cb opaques'. This new patch removes
> the need for the detach_cb_opaques inside the removal callback functions. See
> the commit message of the patch for more info.
> 
> v7:
> - removed the first patch. DRC registration is now done by vmstate_register
> in patch 2.
> - added a new patch that changes spapr_dr_connector_new to receive as argument
> the detach_cb.
> - removed the callback logic of patch 2 since there is no need to restore the
> detach_cb on post-load due to the detach_cb on spapr_dr_connector_new change.
> - added word separators in the VMSD names of patch 3 and 4.
> 
> v6: - Rebased with QEMU master after 6+ months.
>     - Simplified the logic in patch 1.
>     - Reworked patch 2: added CPU DRC migration, removed a function pointer from DRC
> class and minor improvements.
>     - Added clarifications from the previous v5 discussions in the commit messages.
> 
> v5: - Rebased to David's ppc-for-2.8.
> 
> v4: - Introduce a way to set customized instance_id in SaveStateEntry. Use it
>       to set instance_id for DRC using its unique index to address David 
>       Gibson's concern.
>     - Rename VMS_CSTM to VMS_LINKED based on Paolo Bonzini's suggestions.
>     - Clean up qjson stuff in put_qtailq. 
>     - Add trace for put_qtailq and get_qtailq based on David Gilbert's 
>       suggestion.
> 
>     - Based on David's ppc-for-2.7. 
> 
> v3: - Simplify overall design followng discussion with Paolo. No longer need
>       metadata to migrate QTAILQ.
>     - Extend VMStateInfo instead of adding similar fields to VMStateField.
>     - Clean up macros in qemu/queue.h.
> (link: https://lists.nongnu.org/archive/html/qemu-devel/2016-05/msg05695.html)
> 
> v2: - Introduce a general approach to migrate QTAILQ in qemu/queue.h.
>     - Migrate signalled field in the DRC state.
>     - Put the newly added migrating fields in subsections so that backward 
>       migration is not broken.  
>     - Set detach_cb field right after migration so that a migrated hot-unplug
>       event could finish its course.
> (link: https://lists.nongnu.org/archive/html/qemu-devel/2016-05/msg04188.html)
> 
> v1: - Inital version.
> (link: https://lists.nongnu.org/archive/html/qemu-devel/2016-04/msg02601.html)
> 
> 
> To make guest devices (PCI, CPU and memory) hotplug work together 
> with guest migration, spapr drc state needs be transmitted in
> migration. This patch defines the VMStateDescription struct for
> spapr drc state to enable it.
> 
> To fix the potential racing between hotplug events on guest and 
> guest migration, ccs_list and pending_events of spapr state need be 
> transmitted in migration. This patch set also takes care of it.
> 
> 
> 
> Daniel Henrique Barboza (4):
>   hw/ppc/spapr.c: adding pending_dimm_unplugs to sPAPRMachineState
>   hw/ppc: removing drc->detach_cb and drc->detach_cb_opaque
>   hw/ppc: migrating the DRC state of hotplugged devices
>   hw/ppc/spapr.c: migrate pending_dimm_unplugs of spapr state
> 
> Jianjun Duan (2):
>   migration: spapr: migrate ccs_list in spapr state
>   migration: spapr: migrate pending_events of spapr state
> 
>  hw/ppc/spapr.c              | 158 +++++++++++++++++++++++++++++++++++++++++---
>  hw/ppc/spapr_drc.c          |  97 ++++++++++++++++++++++-----
>  hw/ppc/spapr_events.c       |  24 ++++---
>  hw/ppc/spapr_pci.c          |   5 +-
>  include/hw/pci-host/spapr.h |   3 +
>  include/hw/ppc/spapr.h      |  24 ++++++-
>  include/hw/ppc/spapr_drc.h  |   8 +--
>  7 files changed, 273 insertions(+), 46 deletions(-)
> 
