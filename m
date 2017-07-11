Received: from eggs.gnu.org ([2001:4830:134:3::10]:58642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dUza2-0008Qq-SL
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 14:08:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dUzZz-00037x-MB
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 14:08:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49948)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1dUzZz-000374-DA
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 14:08:11 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6BI3dcw049792
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 14:08:09 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bn0my90q3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 14:08:08 -0400
Received: from localhost
	by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Tue, 11 Jul 2017 15:08:06 -0300
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Tue, 11 Jul 2017 15:07:54 -0300
Message-Id: <20170711180755.21017-1-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v15] migration: spapr: migrate pending_events
 of spapr state
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

v15:
- changed default endianess of sPAPREventLogEntry to native
- write the header fields and the extended_log directly in the guest memory

v14:
- several changes made in spapr_events.c to allow for a minimal VMSD to be
migrated. Please check the commit message of the patch for more information.


This is the next version of the v13 that was sent a month ago. You can
check out the v13 discussions here:

https://lists.nongnu.org/archive/html/qemu-devel/2017-05/msg04992.html

Previous changes:

v13:
- rebased with dgibson/ppc-for-2.10
- patch 1 removed from the series (already applied at ppc-for-2.10)
- data_size is now being calculated by using the extended_length field inside
rtas_event_log_queue

v12:
- patch 2: added a switch statement to get the proper data_size based on
the log_type

v11:
- patch 1 (new): cleanup of spapr_events.c:
    * removed the 'exception' boolean from the sPAPREventLogEntry
    * simplified the 'event_scan' function
- patch 2:
    * data_size is now calculated inside rtas_event_log_queue()
    * using VBUFFER instead of VARRAY to avoid casts
    * log_type changed to int32_t

v10: detached from DRC patch set

v9: no changes

v8: no changes

v7: no changes

v6: - Rebased with QEMU master after 6+ months.
class and minor improvements.
    - Added clarifications from the previous v5 discussions in the commit 
messages.

v5: - Rebased on David's ppc-for-2.8.

v4: - Rebased on David's ppc-for-2.7. 

v3: - Simplify overall design followng discussion with Paolo. No longer need
      metadata to migrate QTAILQ.
    - Extend VMStateInfo instead of adding similar fields to VMStateField.

v2: - Put the newly added migrating fields in subsections so that backward 
      migration is not broken.  
(link: https://lists.nongnu.org/archive/html/qemu-devel/2016-05/msg04188.html)

v1: - Inital version.
(link: https://lists.nongnu.org/archive/html/qemu-devel/2016-04/msg02601.html)

Daniel Henrique Barboza (1):
  migration: spapr: migrate pending_events of spapr state

 hw/ppc/spapr.c         |  32 +++++++++++++++
 hw/ppc/spapr_events.c  | 103 +++++++++++++++++++++++++++----------------------
 include/hw/ppc/spapr.h |   9 ++++-
 3 files changed, 96 insertions(+), 48 deletions(-)

-- 
2.9.4
