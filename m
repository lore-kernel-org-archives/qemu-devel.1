Received: from eggs.gnu.org ([2001:4830:134:3::10]:44737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dBS9Y-0002VE-Lw
	for qemu-devel@nongnu.org; Thu, 18 May 2017 16:36:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dBS9U-0005rv-7L
	for qemu-devel@nongnu.org; Thu, 18 May 2017 16:36:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56111
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1dBS9T-0005rY-RK
	for qemu-devel@nongnu.org; Thu, 18 May 2017 16:36:04 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4IKY6d3153779
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 16:36:01 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ahc10c6gu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 16:36:01 -0400
Received: from localhost
	by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Thu, 18 May 2017 17:35:59 -0300
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Thu, 18 May 2017 17:35:43 -0300
Message-Id: <20170518203548.14207-1-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v10 0/5] migration/ppc: migrating DRC and
 ccs_list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, mdroth@linux.vnet.ibm.com

v10:
- removed 'migrating pending_events' patch this series
- patch 1:
    * removed extra line between definitions;
    * removed spapr_pending_dimms functions definitons from spapr.h
    * turned spapr_pending_dimms functions into static
- patch 2:
    * fixed the switch() statement - PHB and VIO cases goes to default,
default now executes assert()
- patch 3:
    * minor style changes/fixes
    * changed switch to return after rc is calculated, default executes
assert()
- patch 4 (*new*):
    * this new patch implements a new function to recover the pending DIMM
unplug LMB state inside the spapr_lmb_release callback

v9:
- patch 1 (*new*): added a qtail in sPAPRMachineState called pending_dimm_unplugs
that stores the DIMM LMB state during the unplug process.
- patch 2 (*new*): merged v8-patch1 and v8-patch2: removing detach_cb and
detach_cb_opaque.
- patch 3:
    * removed dk->vmsd entry. We're using vmstate_register instead
    * added 'awaiting_allocation' flag in the DRC migration
- patch 4 (*new*): migrating spapr->pending_dimm_unplugs qtailq to allow
for an ongoing PCDIMM unplug to continue after a migration.

v8:
- new patch added: 'removing spapr_drc_detach_cb opaques'. This new patch removes
the need for the detach_cb_opaques inside the removal callback functions. See
the commit message of the patch for more info.

v7:
- removed the first patch. DRC registration is now done by vmstate_register
in patch 2.
- added a new patch that changes spapr_dr_connector_new to receive as argument
the detach_cb.
- removed the callback logic of patch 2 since there is no need to restore the
detach_cb on post-load due to the detach_cb on spapr_dr_connector_new change.
- added word separators in the VMSD names of patch 3 and 4.

v6: - Rebased with QEMU master after 6+ months.
    - Simplified the logic in patch 1.
    - Reworked patch 2: added CPU DRC migration, removed a function pointer from DRC
class and minor improvements.
    - Added clarifications from the previous v5 discussions in the commit messages.

v5: - Rebased to David's ppc-for-2.8.

v4: - Introduce a way to set customized instance_id in SaveStateEntry. Use it
      to set instance_id for DRC using its unique index to address David 
      Gibson's concern.
    - Rename VMS_CSTM to VMS_LINKED based on Paolo Bonzini's suggestions.
    - Clean up qjson stuff in put_qtailq. 
    - Add trace for put_qtailq and get_qtailq based on David Gilbert's 
      suggestion.

    - Based on David's ppc-for-2.7. 

v3: - Simplify overall design followng discussion with Paolo. No longer need
      metadata to migrate QTAILQ.
    - Extend VMStateInfo instead of adding similar fields to VMStateField.
    - Clean up macros in qemu/queue.h.
(link: https://lists.nongnu.org/archive/html/qemu-devel/2016-05/msg05695.html)

v2: - Introduce a general approach to migrate QTAILQ in qemu/queue.h.
    - Migrate signalled field in the DRC state.
    - Put the newly added migrating fields in subsections so that backward 
      migration is not broken.  
    - Set detach_cb field right after migration so that a migrated hot-unplug
      event could finish its course.
(link: https://lists.nongnu.org/archive/html/qemu-devel/2016-05/msg04188.html)

v1: - Inital version.
(link: https://lists.nongnu.org/archive/html/qemu-devel/2016-04/msg02601.html)


To make guest devices (PCI, CPU and memory) hotplug work together 
with guest migration, spapr drc state needs be transmitted in
migration. This patch defines the VMStateDescription struct for
spapr drc state to enable it.

To fix the potential racing between hotplug events on guest and 
guest migration and ccs_list of spapr state need be transmitted in
migration. This patch set also takes care of it.


Daniel Henrique Barboza (4):
  hw/ppc/spapr.c: adding pending_dimm_unplugs to sPAPRMachineState
  hw/ppc: removing drc->detach_cb and drc->detach_cb_opaque
  hw/ppc: migrating the DRC state of hotplugged devices
  hw/ppc/spapr.c: recover pending LMB unplug info in spapr_lmb_release

Jianjun Duan (1):
  migration: spapr: migrate ccs_list in spapr state

 hw/ppc/spapr.c              | 138 ++++++++++++++++++++++++++++++++++++++++----
 hw/ppc/spapr_drc.c          |  89 +++++++++++++++++++++++-----
 hw/ppc/spapr_pci.c          |   5 +-
 include/hw/pci-host/spapr.h |   3 +
 include/hw/ppc/spapr.h      |   8 +++
 include/hw/ppc/spapr_drc.h  |   8 +--
 6 files changed, 216 insertions(+), 35 deletions(-)

-- 
2.9.4
