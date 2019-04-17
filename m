Received: from eggs.gnu.org ([209.51.188.92]:58046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hGanf-0002k4-Ir
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 22:59:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hGane-0007hh-N0
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 22:59:51 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 16 Apr 2019 23:59:39 -0300
Message-Id: <20190417025944.16154-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 0/5] Remove qdev_get_machine() call from
 ppc_cpu_parse_featurestr()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Eduardo Habkost <ehabkost@redhat.com>, Like Xu <like.xu@linux.intel.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

My initial goal was simple: removing the qdev_get_machine() call
from ppc_cpu_parse_featurestr() because I want to make
qdev_get_machine() available only to softmmu code.

Before doing this, I had to make *-user not call
CPUClass::parse_features() anymore (it was pointless to call it,
anyway).

While doing this, I decided to rename parse_cpu_model() to
something clearer (parse_cpu_option()).

As a nice side effect, now the dependency between machine object
creation and parse_cpu_option() is not hidden anymore.

Eduardo Habkost (5):
  cpu: Rename parse_cpu_model() to parse_cpu_option()
  cpu: Extract CPU class lookup from parse_cpu_option()
  linux-user: Use lookup_cpu_class()
  bsd-user: Use lookup_cpu_class()
  cpu: Add MachineState parameter to parse_features()

 include/qom/cpu.h               | 18 ++++++++++++++----
 target/ppc/cpu-qom.h            |  3 ++-
 bsd-user/main.c                 |  4 +++-
 exec.c                          | 28 +++++++++++++++-------------
 linux-user/main.c               |  4 +++-
 qom/cpu.c                       |  3 ++-
 target/i386/cpu.c               |  3 ++-
 target/ppc/translate_init.inc.c |  7 ++++---
 target/sparc/cpu.c              |  3 ++-
 vl.c                            | 19 ++++++++++---------
 10 files changed, 57 insertions(+), 35 deletions(-)

-- 
2.18.0.rc1.1.g3f1ff2140
