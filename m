Received: from eggs.gnu.org ([2001:4830:134:3::10]:33928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e48Ab-0004UD-Jl
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 12:23:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e48AY-0006qg-Dn
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 12:23:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1e48AY-0006py-5o
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 12:23:10 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon, 16 Oct 2017 18:22:50 +0200
Message-Id: <1508170976-96869-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [RFC 0/6] enable numa configuration before
 machine_init() from HMP/QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, ehabkost@redhat.com, pkrempa@redhat.com, david@gibson.dropbear.id.au, peter.maydell@linaro.org, pbonzini@redhat.com, cohuck@redhat.com

Series allows to configure NUMA mapping at runtime using QMP/HMP
interface. For that to happen it introduces a new '-paused' CLI option
which allows to pause QEMU before machine_init() is run and
adds new set-numa-node HMP/QMP commands which in conjuction with
info hotpluggable-cpus/query-hotpluggable-cpus allow to configure
NUMA mapping for cpus.

HMP configuration session for CLI '-smp 1,maxcpus=2' would look like:

(qemu) info hotpluggable-cpus 
Hotpluggable CPUs:
  type: "qemu64-x86_64-cpu"
  vcpus_count: "1"
  CPUInstance Properties:
    socket-id: "1"
    core-id: "0"
    thread-id: "0"
  type: "qemu64-x86_64-cpu"
  vcpus_count: "1"
  qom_path: "/machine/unattached/device[0]"
  CPUInstance Properties:
    socket-id: "0"
    core-id: "0"
    thread-id: "0"
(qemu) set-numa-node node,nodeid=0
(qemu) set-numa-node node,nodeid=1
(qemu) set-numa-node cpu,socket-id=0,node-id=0
(qemu) set-numa-node cpu,socket-id=1,node-id=1
(qemu) info hotpluggable-cpus 
Hotpluggable CPUs:
  type: "qemu64-x86_64-cpu"
  vcpus_count: "1"
  CPUInstance Properties:
    node-id: "1"
    socket-id: "1"
    core-id: "0"
    thread-id: "0"
  type: "qemu64-x86_64-cpu"
  vcpus_count: "1"
  CPUInstance Properties:
    node-id: "0"
    socket-id: "0"
    core-id: "0"
    thread-id: "0"
(qemu) cont

git tree for testing:
  https://github.com/imammedo/qemu qmp_preconfig_rfc


CC: eblake@redhat.com
CC: armbru@redhat.com
CC: ehabkost@redhat.com
CC: pkrempa@redhat.com
CC: david@gibson.dropbear.id.au
CC: peter.maydell@linaro.org
CC: pbonzini@redhat.com
CC: cohuck@redhat.com

Igor Mammedov (6):
  numa: postpone options post-processing till machine_run_board_init()
  numa: split out NumaOptions parsing into parse_NumaOptions()
  possible_cpus: add CPUArchId::type field
  CLI: add -paused option
  HMP: add set-numa-node command
  QMP: add set-numa-node command

 hmp.h                      |  1 +
 include/hw/boards.h        |  2 ++
 include/sysemu/numa.h      |  2 ++
 include/sysemu/sysemu.h    |  1 +
 hmp-commands.hx            | 13 ++++++++
 hmp.c                      | 23 ++++++++++++++
 hw/arm/virt.c              |  3 +-
 hw/core/machine.c          | 18 ++++++-----
 hw/i386/pc.c               |  4 ++-
 hw/ppc/spapr.c             | 13 +++++---
 hw/s390x/s390-virtio-ccw.c |  1 +
 numa.c                     | 79 ++++++++++++++++++++++++++++++++++------------
 qapi-schema.json           | 13 ++++++++
 qemu-options.hx            | 15 +++++++++
 qmp.c                      |  5 +++
 vl.c                       | 54 ++++++++++++++++++++++++++++++-
 16 files changed, 210 insertions(+), 37 deletions(-)

-- 
2.7.4
