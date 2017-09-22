Received: from eggs.gnu.org ([2001:4830:134:3::10]:56310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1dvN8O-0000T3-Lr
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:32:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1dvN8L-0005mO-Gb
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:32:44 -0400
Received: from mga14.intel.com ([192.55.52.115]:12358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarnath.valluri@intel.com>)
	id 1dvN8K-0005lf-Sd
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:32:41 -0400
From: Amarnath Valluri <amarnath.valluri@intel.com>
Date: Fri, 22 Sep 2017 15:33:36 +0300
Message-Id: <1506083624-20621-1-git-send-email-amarnath.valluri@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 0/8] Provide support for the software TPM
 emulator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Amarnath Valluri <amarnath.valluri@intel.com>

Briefly, Theses set of patches introduces:
- new TPM backend driver to support software TPM emulators(swtpm(1)).
- and few supported fixes/enhancements/cleanup to existing tpm backend code.

The similar idea was initiated earliar(2) by Stefan Berger(CCed) with slightly
different approach, using CUSE. As swtpm has excellent support for unix domain
sockets, hence this implementation uses unix domain sockets to communicate with
swtpm.

When Qemu is configured with 'emulator' tpm backend, it spawns 'swtpm' and
communicates its via Unix domain sockets.

1) https://github.com/stefanberger/swtpm
2) https://lists.nongnu.org/archive/html/qemu-devel/2016-01/msg00089.html

** Changes in V2:
- Made spawnning swtpm optional
- used QIOChannel instead of plain unix sockets
- incorporated other fixes pointed in v1 review

** Changes in v3:
- Addressed review comments made by Stefan Berger and Deniel
P Berrange

** Changes in v4:
- Moved realloc_buffer() to TIS model
- Made TpmInfo related change backwards compatible.

** Changes in v5:
- updated Reviewed-By: tag to git commits
- added migration blocker to TPM emulator backend

** Changes in v6:
- rebased agianst latest master
- Address review comments maded by Stefan Berger

** Changes in v7:
- rebased agianst latest master
- Rewritten emulater backend using chardev backend

Amarnath Valluri (8):
  tpm-backend: Remove unneeded member variable from backend class
  tpm-backend: Move thread handling inside TPMBackend
  tpm-backend: Initialize and free data members in it's own methods
  tpm-backend: Made few interface methods optional
  tmp backend: Add new api to read backend TpmInfo
  tpm-backend: Move realloc_buffer() implementation to tpm-tis model
  tpm-passthrough: move reusable code to utils
  tpm: Added support for TPM emulator

 backends/tpm.c                   | 114 ++++---
 configure                        |  15 +-
 hmp.c                            |  12 +-
 hw/tpm/Makefile.objs             |   1 +
 hw/tpm/tpm_emulator.c            | 649 +++++++++++++++++++++++++++++++++++++++
 hw/tpm/tpm_ioctl.h               | 246 +++++++++++++++
 hw/tpm/tpm_passthrough.c         | 236 ++++----------
 hw/tpm/tpm_tis.c                 |  14 +-
 hw/tpm/tpm_util.c                |  25 ++
 hw/tpm/tpm_util.h                |   4 +
 include/sysemu/tpm_backend.h     |  87 +++---
 include/sysemu/tpm_backend_int.h |  41 ---
 qapi/tpm.json                    |  21 +-
 qemu-options.hx                  |  22 +-
 tpm.c                            |  36 +--
 15 files changed, 1173 insertions(+), 350 deletions(-)
 create mode 100644 hw/tpm/tpm_emulator.c
 create mode 100644 hw/tpm/tpm_ioctl.h
 delete mode 100644 include/sysemu/tpm_backend_int.h

-- 
2.7.4
