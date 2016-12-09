Received: from eggs.gnu.org ([2001:4830:134:3::10]:41779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cFJgN-0007Gn-Ni
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 06:49:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cFJgH-0007nR-Tw
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 06:49:43 -0500
Received: from mail-wj0-f176.google.com ([209.85.210.176]:34633)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cFJgH-0007nG-M1
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 06:49:37 -0500
Received: by mail-wj0-f176.google.com with SMTP id tg4so12584988wjb.1
	for <qemu-devel@nongnu.org>; Fri, 09 Dec 2016 03:49:37 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  9 Dec 2016 11:48:20 +0000
Message-Id: <20161209114830.9158-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH v3 00/10] Record/payback patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, joserz@linux.vnet.ibm.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

I did a bunch of tweaking to see if I could abstract the hackage for
record/replay a bit more. With a little bit of light re-factoring of
the send and recv functions I can move all the specific send/recv
logic into the main risu.c file and avoid having copy and pasted
functions for each architecture.

I've also introduced a header which makes tracking where you are in
the recorded stream a little easier when debugging.

It should be noted the functions:

  int send_register_info(write_fn write_fn, void *uc);
  int recv_and_compare_register_info(read_fn read_fn, respond_fn respond, void *uc);

are pretty identical for each arch. I did consider folding even more
of the logic into the common code but I wasn't sure if that would
loose flexibility in the future for other architectures so I left it
as is.

I've make the same changes to ppc64 although I've been compiling and
testing under a qemu linux-user environment which might explain why
I'm seeing crashes when I try and run it. I would appreciate the PPC
guys trying it on real hardware and debugging if needed.

For reference I'm using a linux-user powered docker image (built with
the debian-bootstrap recipe in the qemu.git tree) for cross compiling:

  docker run --rm -it -v /home/alex/lsrc/qemu/risu.git:/src --user=alex:alex -w /src debian:ppc64el make

There have been some minor clean-ups to the helper scripts mainly to
aid testing by allowing the override of the RISU binary (I have
risu-arm, risu-arm64 and risu-ppc64 in my development directory).
Notes in the --- comments on each patch.

Alex Bennée (10):
  risu: a bit more verbosity when running
  aarch64: add hand-coded risu skeleton for directed testing
  risu: paramterise send/receive functions
  risu: add simple trace and replay support
  risu: add support compressed tracefiles
  risu_aarch64: it's -> it is
  risugen: remove grocer's apostrophe from REs
  new: generate_all.sh script
  new: record_traces.sh helper script
  new: run_risu.sh script

 Makefile                      |  10 +-
 aarch64_simd_handcoded.risu.S | 208 ++++++++++++++++++++++++++++++++++++++++++
 configure                     |  55 +++++++++++
 generate_all.sh               |  55 +++++++++++
 record_traces.sh              |  20 ++++
 risu.c                        | 139 ++++++++++++++++++++++++----
 risu.h                        |  14 ++-
 risu_aarch64.c                | 119 +++++++++++++++---------
 risu_arm.c                    | 148 +++++++++++++++++++-----------
 risu_ppc64le.c                | 127 ++++++++++++++++----------
 risu_reginfo_aarch64.h        |   7 ++
 risu_reginfo_arm.h            |   6 ++
 risu_reginfo_ppc64le.h        |   6 ++
 risugen                       |   2 +-
 run_risu.sh                   |  53 +++++++++++
 15 files changed, 805 insertions(+), 164 deletions(-)
 create mode 100644 aarch64_simd_handcoded.risu.S
 create mode 100755 generate_all.sh
 create mode 100755 record_traces.sh
 create mode 100755 run_risu.sh

-- 
2.11.0
