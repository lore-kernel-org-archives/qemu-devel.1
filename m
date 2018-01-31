Received: from eggs.gnu.org ([2001:4830:134:3::10]:55748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1egwxF-00065g-BR
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 13:17:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1egwxC-0002S5-5R
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 13:17:53 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 31 Jan 2018 19:17:40 +0100
Message-Id: <20180131181742.2037-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/2] s390x: support zpci in tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: rth@twiddle.net, agraf@suse.de, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

<blurb from last cover letter>
This patch set (available at git://github.com/cohuck/qemu pci-tcg)
wires up zpci under tcg. A guest started with

qemu-system-s390x -M s390-ccw-virtio,accel=tcg -cpu qemu,zpci=on -device virtio-net-pci (...)

and a 4.15 kernel in the guest (needed because the requirement for ais
was dropped with

commit 48070c73058be6de9c0d754d441ed7092dfc8f12
Author: Christian Borntraeger <borntraeger@de.ibm.com>
Date:   Mon Oct 30 14:38:58 2017 +0100

    s390/pci: do not require AIS facility

and we don't have a working ais with tcg yet), I get sensible output
out of lspci.
</blurb>

Looks much nicer now after implementing feedback from David (thanks!)

Changes RFC->v2:
- no need to check for the zpci feature in the helpers
- SIC does not set a condition code
- SIC also should not depend on zpci
- use tcg magic to improve the code in translate.c
- clear zpci feature from supported set for !CONFIG_PCI

Cornelia Huck (2):
  s390x/tcg: wire up pci instructions
  s390x/cpumodel: allow zpci features in qemu model

 target/s390x/cpu_models.c   |   6 +++
 target/s390x/gen-features.c |   3 ++
 target/s390x/helper.h       |   9 ++++
 target/s390x/insn-data.def  |  15 ++++++
 target/s390x/misc_helper.c  | 109 ++++++++++++++++++++++++++++++++++++++++++++
 target/s390x/translate.c    | 101 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 243 insertions(+)

-- 
2.13.6
