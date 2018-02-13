Received: from eggs.gnu.org ([2001:4830:134:3::10]:60008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@de.ibm.com>) id 1eleEQ-0006Bp-RP
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:19:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@de.ibm.com>) id 1eleEK-0000Se-Mh
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:19:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56078
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@de.ibm.com>) id 1eleEK-0000SA-GX
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:18:56 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1DHG7jY031598
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 12:18:55 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2g42gjwax1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 12:18:54 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@de.ibm.com>;
	Tue, 13 Feb 2018 17:18:53 -0000
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Tue, 13 Feb 2018 18:18:45 +0100
Message-Id: <1518542328-25741-1-git-send-email-mihajlov@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCHv2 0/3] add query-cpu-fast and related s390
 changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: agraf@suse.de, ehabkost@redhat.com, armbru@redhat.com, cohuck@redhat.com, david@redhat.com, dgilbert@redhat.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, eblake@redhat.com

This series consolidates patches around a performance issue
caused by the usage of QMP query-cpus.

A performance issue was found in an OpenStack environment, where
ceilometer was collecting domain statistics with libvirt. The domain
statistics reported by libvirt include the vCPU halted state, which 
in turn is retrieved with QMP query-cpus.

This causes two issues:
1. Performance: on most architectures query-cpus needs to issue a KVM ioctl
   to find out whether a vCPU was halted. This is not the case for s390
   but query-cpus is always causing the vCPU to exit the VM.

2. Semantics: on x86 and other architectures, halted is a highly transient
   state, which is likely to have already changed shortly after the state
   information has been retrieved. This is not the case for s390, where
   halted is an indication that the vCPU is stopped, meaning its not
   available to the guest operating system until it has been restarted.

The following patches help to alleviate the issues:

Patch 1/3:
  Adds architecture specific data to the QMP CpuInfo type, exposing
  the existing s390 cpu-state in QMP. The cpu-state is a representation
  more adequate than the ambiguous 'halted' condition.

Patch 2/3:
  Adds a new QMP function query-cpus-fast, which will only retrieve
  vCPU information that can be obtained without interrupting the
  vCPUs of a running VM. It introduces a new return type CpuInfoFast
  with the subset of fields meeting this condition. Specifically, the
  halted state is not part of CpuInfoFast. QMP clients like libvirt
  are encouraged to switch to the new API for vCPU information.

Patch 3/3:
  Adds the s390-specific cpu state to CpuInfoFast, allowing management
  apps to find out whether a vCPU is in the stopped state. This extension
  leads to a partial duplication of field definitions from CpuInfo
  to CpuInfoFast. This should be tolerable if CpuInfo is deprecated and
  eventually removed.

Series v1 -> v2:
Patch 2/3:
  o Changed formatting of hmp info cpus_fast to match that of
    info cpus. This makes it easier for clients to switch to
    the fast call.

Patch 3/3:
  o Same formatting change for info cpus_fast as in 2/3, only
    for s390-specific cpu state.

Luiz Capitulino (1):
  qmp: add query-cpus-fast

Viktor Mihajlovski (2):
  qmp: expose s390-specific CPU info
  qmp: add architecture specific cpu data for query-cpus-fast

 cpus.c                     |  54 ++++++++++++++++++++
 hmp-commands-info.hx       |  14 ++++++
 hmp.c                      |  28 +++++++++++
 hmp.h                      |   1 +
 hw/intc/s390_flic.c        |   4 +-
 hw/s390x/s390-virtio-ccw.c |   2 +-
 qapi-schema.json           | 121 ++++++++++++++++++++++++++++++++++++++++++++-
 target/s390x/cpu.c         |  24 ++++-----
 target/s390x/cpu.h         |   7 +--
 target/s390x/kvm.c         |   8 +--
 target/s390x/sigp.c        |  38 +++++++-------
 11 files changed, 257 insertions(+), 44 deletions(-)

-- 
1.9.1
