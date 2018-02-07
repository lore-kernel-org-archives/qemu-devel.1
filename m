Received: from eggs.gnu.org ([2001:4830:134:3::10]:53171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lcapitulino@redhat.com>) id 1ejTrf-00055C-UM
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 12:50:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lcapitulino@redhat.com>) id 1ejTrf-0002lQ-6X
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 12:50:35 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38096 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lcapitulino@redhat.com>)
	id 1ejTrf-0002lA-0r
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 12:50:35 -0500
From: Luiz Capitulino <lcapitulino@redhat.com>
Date: Wed,  7 Feb 2018 12:50:12 -0500
Message-Id: <20180207175014.11157-1-lcapitulino@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] qmp: add query-cpus-fast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, eblake@redhat.com, ehabkost@redhat.com, berrange@redhat.com, mihajlov@linux.vnet.ibm.com


We've recently debugged a huge performance degradation we were getting
on a latency sensitive workload down to the fact that libvirt is
issuing query-cpus. As it turns out, query-cpus always interrupts all
vCPU threads so that they can run ioctl to collect a number of register
information, most of which are not even used by query-cpus at all.

This series adds a new command called query-cpus-fast, which returns
the most relevant information returned by query-cpus without having
to interrupt vCPU threads. This series also updates query-cpus
documentation to advise against its use in production.

More details in individual patches.

Luiz Capitulino (2):
  qmp: add query-cpus-fast
  qmp: document query-cpus performance issue

 cpus.c               | 44 ++++++++++++++++++++++++++++++
 hmp-commands-info.hx | 14 ++++++++++
 hmp.c                | 24 +++++++++++++++++
 hmp.h                |  1 +
 qapi-schema.json     | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 158 insertions(+)

-- 
2.14.3
