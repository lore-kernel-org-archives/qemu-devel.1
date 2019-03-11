Received: from eggs.gnu.org ([209.51.188.92]:47604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jandryuk@gmail.com>) id 1h3PGT-0002fh-Kz
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 14:03:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jandryuk@gmail.com>) id 1h3PGS-00021N-T0
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 14:03:05 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:44750)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jandryuk@gmail.com>) id 1h3PGS-000200-OW
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 14:03:04 -0400
Received: by mail-qk1-x742.google.com with SMTP id u22so3268795qkj.11
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 11:03:04 -0700 (PDT)
From: Jason Andryuk <jandryuk@gmail.com>
Date: Mon, 11 Mar 2019 14:02:10 -0400
Message-Id: <20190311180216.18811-1-jandryuk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/6] Xen stubdom support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, marmarek@invisiblethingslab.com, Jason Andryuk <jandryuk@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul.durrant@citrix.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

Xen supports running QEMU in a dedicated service vm - a stub domain or
stubdom.  QEMU is then isolated outside of the privileged Domain-0.

When running in a stubdom, there are a few changes needed for QEMU.  On
older Xen versions, the default ioreq server needs to have the stubdom's
domid specified.  The stubdom doesn't run PV backends, so that
initialization code can be skipped.  Stubdom's don't support MSI-X, so
that PCI capability must be hidden from passed through devices.

Stubdom mode is enabled by the new -xen-stubdom flag.

Jason Andryuk (5):
  xen: Introduce -xen-stubdom option
  xen: Move xenstore initialization to common location
  xen: Skip backend initialization for stubdom
  xen: Set HVM_PARAM_DM_DOMAIN for stubdom on older Xen
  xen-pt: Hide MSI-X from xen stubdoms

Simon Gaiser (1):
  xen-pt: Round pci regions sizes to XEN_PAGE_SIZE

 hw/i386/xen/xen-hvm.c       | 22 ++++++++++++++++------
 hw/xen/xen-legacy-backend.c |  8 --------
 hw/xen/xen_pt.c             | 10 +++++++---
 hw/xen/xen_pt_config_init.c |  3 +++
 include/hw/xen/xen.h        |  6 ++++++
 include/hw/xen/xen_common.h |  5 +++++
 qemu-options.hx             |  7 +++++++
 vl.c                        |  8 ++++++++
 8 files changed, 52 insertions(+), 17 deletions(-)

-- 
2.20.1
