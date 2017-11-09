Received: from eggs.gnu.org ([2001:4830:134:3::10]:56636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1eCecp-0002xS-CG
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 23:39:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1eCecm-0004h5-9M
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 23:39:35 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:53139)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eswierk@skyportsystems.com>)
	id 1eCecm-0004go-2u
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 23:39:32 -0500
Received: by mail-pg0-x242.google.com with SMTP id a192so3758616pge.9
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 20:39:31 -0800 (PST)
From: Ed Swierk <eswierk@skyportsystems.com>
Date: Wed,  8 Nov 2017 20:39:15 -0800
Message-Id: <1510202357-124052-1-git-send-email-eswierk@skyportsystems.com>
In-Reply-To: <1509072544-89012-1-git-send-email-eswierk@skyportsystems.com>
References: <1509072544-89012-1-git-send-email-eswierk@skyportsystems.com>
Subject: [Qemu-devel] [PATCH v2 0/2] e1000e: Reimplement e1000 as a variant
 of e1000e
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, Dmitry Fleytman <dmitry@daynix.com>, Leonid Bloch <leonid.bloch@ravellosystems.com>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Ed Swierk <eswierk@skyportsystems.com>

>From a hardware functionality and register perspective, the Intel
8254x Gigabit Ethernet Controller[1] is roughly a subset of the Intel
82574[2], making it practical to implement e1000 device emulation as
an extension of e1000e.

That would be a step towards eliminating the existing e1000
implementation--a bunch of semi-redundant code with its own bugs (like
the faulty tx checksum offload I reported recently[3]).

[1] https://www.intel.com/content/dam/doc/manual/pci-pci-x-family-gbe-controllers-software-dev-manual.pdf
[2] https://www.intel.com/content/dam/doc/datasheet/82574l-gbe-controller-datasheet.pdf
[3] https://lists.nongnu.org/archive/html/qemu-devel/2017-10/msg03008.html

This patch series adds a new e1000-ng device but leaves the existing
e1000 device alone. Linux 4.1 and Windows 10 e1000 guest drivers
recognize the e1000-ng device and successfully pass traffic on a Linux
host.

Preliminary performance measurements are encouraging: with e1000-ng,
single-threaded TCP iperf shows about a 2x speedup in tx and rx
throughput vs e1000, and CPU usage is slighly lower.

A ton of work is needed before e1000-ng will be ready to supplant
e1000: testing with every random guest OS, fixing bugs, figuring out
migration and other missing functionality. There's no way I can do
this myself.

I'd like to propose a more modest and achievable short-term goal: find
and fix any regressions that might affect users of e1000e and e1000,
so that the patches can be applied and folks can easily start trying
out e1000-ng with their favorite guest OS. That means accepting (for
now) known deficiencies in the new e1000-ng devices, which can be
addressed by myself and (hopefully) others in follow-up patches. Does
that sound reasonable?

v2:
- added new eecd_state fields to e1000e_vmstate and e1000_vmstate
- got savevm/loadvm working with e1000-ng
- leave MSI enabled for e1000-ng (though guest drivers seem to ignore it)

Ed Swierk (2):
  e1000e: Infrastructure for e1000-ng
  e1000e: Add e1000-ng devices

 hw/net/e1000e.c      | 277 +++++++++++++++++++++++++++++++++++++++++++--------
 hw/net/e1000e_core.c | 249 +++++++++++++++++++++++++++++++++------------
 hw/net/e1000e_core.h |  25 ++++-
 3 files changed, 437 insertions(+), 114 deletions(-)

-- 
1.9.1
