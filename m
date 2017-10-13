Received: from eggs.gnu.org ([2001:4830:134:3::10]:58270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e2vRB-0004w4-Ah
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:35:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e2vR6-0003IO-5g
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:35:21 -0400
Received: from 14.mo5.mail-out.ovh.net ([188.165.51.82]:42092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1e2vR5-0003HE-Vz
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:35:16 -0400
Received: from player773.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 6235B13FC72
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 10:35:14 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 13 Oct 2017 10:35:06 +0200
Message-ID: <150788370618.25736.8030708425923435364.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 0/2] monitor: increase the refcount of the
 current CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>, Cornelia Huck <cohuck@redhat.com>

If a CPU selected with the "cpu" command is hot-unplugged then "info cpus"
causes QEMU to exit:
    
(qemu) device_del cpu1
(qemu) info cpus
qemu:qemu_cpu_kick_thread: No such process

I could verify that this happens with x86 and ppc, but I guess s390x is
also impacted.

This series tries to fix the issue by using object_ref() and object_unref()
in the monitor code. For this to work on ppc, some preliminary work is
needed to let QOM handle the CPU object lifecycle.

Please comment.

--
Greg

---

Greg Kurz (2):
      spapr_cpu_core: instantiate CPUs separately
      monitor: add proper reference counting of the current CPU


 hw/ppc/spapr.c                  |   10 +++-------
 hw/ppc/spapr_cpu_core.c         |   29 +++++++++--------------------
 include/hw/ppc/spapr_cpu_core.h |    2 +-
 monitor.c                       |   12 ++++++++++++
 4 files changed, 25 insertions(+), 28 deletions(-)
