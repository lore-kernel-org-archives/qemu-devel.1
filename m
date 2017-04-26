Received: from eggs.gnu.org ([2001:4830:134:3::10]:46957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1d3UPI-0006zH-Fq
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 17:23:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1d3UPD-0000DX-IB
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 17:23:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45073)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1d3UPD-0000D8-9l
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 17:23:23 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3QLJV2c123081
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 17:23:21 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a32j39wwv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 17:23:20 -0400
Received: from localhost
	by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Wed, 26 Apr 2017 18:23:18 -0300
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
	by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v3QLNGiD31457454
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 18:23:16 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
	by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v3QLNFbh011665
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 18:23:15 -0300
Received: from localhost.localdomain ([9.85.186.39])
	by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
	v3QLNDte011638
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 18:23:15 -0300
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Wed, 26 Apr 2017 18:22:59 -0300
Message-Id: <20170426212303.27961-1-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 0/4 v7] migration/ppc: migrating DRC,
 ccs_list and pending_events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
guest migration, ccs_list and pending_events of spapr state need be 
transmitted in migration. This patch set also takes care of it.




Daniel Henrique Barboza (2):
  hw/ppc: setting spapr_drc_detach_cb in spapr_dr_connector_new
  hw/ppc: migrating the DRC state of hotplugged devices

Jianjun Duan (2):
  migration: spapr: migrate ccs_list in spapr state
  migration: spapr: migrate pending_events of spapr state

 hw/ppc/spapr.c             | 136 +++++++++++++++++++++++++++++++++------------
 hw/ppc/spapr_drc.c         |  78 +++++++++++++++++++++++---
 hw/ppc/spapr_events.c      |  24 ++++----
 hw/ppc/spapr_pci.c         |   5 +-
 include/hw/ppc/spapr.h     |   3 +-
 include/hw/ppc/spapr_drc.h |   4 +-
 6 files changed, 190 insertions(+), 60 deletions(-)

-- 
2.9.3
