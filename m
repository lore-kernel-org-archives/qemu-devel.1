Received: from eggs.gnu.org ([2001:4830:134:3::10]:45500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1d2mAB-0000ra-5F
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 18:08:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1d2mA7-00084V-PF
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 18:08:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42169
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1d2mA7-00082e-DS
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 18:08:51 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3OM3rVe091826
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 18:08:49 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2a1jqjkqb9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 18:08:49 -0400
Received: from localhost
	by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Mon, 24 Apr 2017 19:08:47 -0300
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Mon, 24 Apr 2017 19:08:24 -0300
Message-Id: <20170424220828.1472-1-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 0/4 v6] migration/ppc: migrating DRC,
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
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

Hi,

This is the version 6 of the pseries patches that was last sent in the mailing list
more than 6 months ago. The original v5 patchset was authored by Jianjun Duan (see link
below):

http://lists.nongnu.org/archive/html/qemu-devel/2016-10/msg00270.html

The specific pseries patches were stripped out in the original v6 patchset
and it was later pushed upstream in the v17 in the 'extend VMStateInfo' and
'migrate QTAILQ' contributions.

The changelog as far as the pseries patches are concerned:


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



Daniel Henrique Barboza (1):
  hw/ppc: migrating the DRC state of hotplugged devices

Jianjun Duan (3):
  migration: alternative way to set instance_id in SaveStateEntry
  migration: spapr: migrate ccs_list in spapr state
  migration: spapr: migrate pending_events of spapr state

 hw/ppc/spapr.c         | 65 ++++++++++++++++++++++++++++++++++++++++++++++++
 hw/ppc/spapr_drc.c     | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/ppc/spapr_events.c  | 24 +++++++++---------
 hw/ppc/spapr_pci.c     | 22 +++++++++++++++++
 include/hw/ppc/spapr.h |  3 ++-
 include/hw/qdev-core.h |  6 +++++
 migration/savevm.c     |  6 +++++
 7 files changed, 181 insertions(+), 12 deletions(-)

-- 
2.9.3
