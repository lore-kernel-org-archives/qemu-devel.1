Received: from eggs.gnu.org ([2001:4830:134:3::10]:40662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dMuCQ-0007KU-7d
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:46:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dMuCL-0004oU-Jy
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:46:26 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:36432)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dMuCL-0004nL-CN
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:46:21 -0400
Received: by mail-wm0-x230.google.com with SMTP id m125so75833733wmm.1
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 03:46:20 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 19 Jun 2017 11:46:42 +0100
Message-Id: <20170619104655.31104-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH v5 00/13] RISU record/replay patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

Here is v5 of the RISU record/replay patches. The big changes are:

  - new patch to sync coding standards
  - handle stdin/out as a trace input/destination
  - remove fprintf's from signal handlers
  - swapped the static build flag with docker

I've left the "build with docker" patches in but they can be easily
dropped if you want as the --static build patch goes in first. I still
think it is a handy solution if the users host cross-arch setup is
broken.

The alternative is to use the stdin/out pipeline and pass trace data
through a (potentially native) compression binary.

Details in the commits.

Alex Bennée (13):
  .gitignore: ignore build directories
  README: document the coding style used for risu
  all: fix up code consitency
  build-all-archs: support --static flag
  build-all-archs: support cross building via docker
  risu: a bit more verbosity when starting
  risu: paramterise send/receive functions
  risu: add header to trace stream
  risu: add simple trace and replay support
  risu: handle trace through stdin/stdout
  risu: add support compressed tracefiles
  new: record_traces.sh helper script
  new: run_risu.sh script

 .dir-locals.el         |   2 +
 .gitignore             |   1 +
 Makefile               |   4 +-
 README                 |   9 +
 build-all-archs        |  76 +++++++-
 comms.c                | 325 ++++++++++++++++------------------
 configure              |  55 +++++-
 record_traces.sh       |  32 ++++
 reginfo.c              | 189 +++++++++++---------
 risu.c                 | 465 ++++++++++++++++++++++++++++++++-----------------
 risu.h                 |  27 ++-
 risu_aarch64.c         |   5 +
 risu_arm.c             |  63 +++----
 risu_i386.c            | 150 ++++++++--------
 risu_m68k.c            |   7 +-
 risu_ppc64.c           |   7 +-
 risu_reginfo_aarch64.c |  60 ++++---
 risu_reginfo_aarch64.h |   3 +-
 risu_reginfo_arm.c     | 290 +++++++++++++++---------------
 risu_reginfo_arm.h     |   3 +-
 risu_reginfo_m68k.c    |  20 +--
 risu_reginfo_m68k.h    |   3 +-
 risu_reginfo_ppc64.c   |  29 ++-
 risu_reginfo_ppc64.h   |   3 +-
 run_risu.sh            |  66 +++++++
 25 files changed, 1150 insertions(+), 744 deletions(-)
 create mode 100644 .dir-locals.el
 create mode 100755 record_traces.sh
 create mode 100755 run_risu.sh

-- 
2.13.0
