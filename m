Received: from eggs.gnu.org ([2001:4830:134:3::10]:34690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eC5SD-0005nF-2J
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:06:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eC5S8-0008S3-QZ
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:06:17 -0500
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:55894)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eC5S8-0008QD-Ir
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:06:12 -0500
Received: by mail-wr0-x230.google.com with SMTP id l8so12104016wre.12
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 07:06:12 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  7 Nov 2017 15:05:48 +0000
Message-Id: <20171107150558.22131-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH 00/10] Initial support for SVE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: Dave.Martin@arm.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

These patches apply on-top of the last clean-up series:

  Subject: [RISU PATCH 0/7] Add @Group support and some aarch64.risu cleanups
  Date: Tue, 31 Oct 2017 14:54:37 +0000
  Message-Id: <20171031145444.13766-1-alex.bennee@linaro.org>

This series adds support for SVE to RISU. Most of the initial patches
are plumbing changes to better support arch specific option flags
(cleaning up a TODO in the process). I also needed to ensure configure
actually honoured CPPFLAGS so it could be passed yet to be released
headers.

The actual guts of the SVE support is in 3 patches. One to risugen so
it can generate random values for the vector registers. If this isn't
done you get inconsistent runs because of left over junk in the
registers. The remaining two patches add support for copying the SVE
vectors from the signal context and dumping any differences found.

To test this I ran on the Foundation model with:

  ${RTSM_MODEL} --no-secure-memory --gicv3 --data=${BL1_FIRMWARE}@0x0 --data=${FIP_FIRMWARE}@0x8000000 \
                --semihost --network nat --network-nat-ports=8022=22 --block-device ${DISK_IMAGE}

With my hacked up copy of secure firmware to ensure SVE is enabled.
You also need a kernel with SVE support:

  Subject: [PATCH v5 00/30] ARM Scalable Vector Extension (SVE)
  Date: Tue, 31 Oct 2017 15:50:52 +0000
  Message-Id: <1509465082-30427-1-git-send-email-Dave.Martin@arm.com>

My testing so far has been to ensure that each run on the foundation
model is deterministic (same m5sum on each trace) and that differences
are printed out when the user-space vector length is tweaked
(/proc/sys/abi/sve_default_vector_length).


Alex Bennée (10):
  build-all-arches: drop -t (for tty) from docker invocation
  risu.c: split out setting up options
  risu.c: add missing --trace longopt
  risu: move optional args to each architecture
  configure: allow repeated invocation of configure in build dir
  configure: support CPPFLAGS
  risugen: add --sve support
  aarch64.risu: initial SVE instruction
  risu_reginfo_aarch64: add reginfo_copy_sve
  risu_reginfo_aarch64: add SVE support to reginfo_dump_mismatch

 README                 |   6 +++
 aarch64.risu           |  24 ++++++++++
 build-all-archs        |   2 +-
 configure              |   5 +-
 risu.c                 |  57 +++++++++++++++++-----
 risu.h                 |   6 ++-
 risu_reginfo_aarch64.c | 126 +++++++++++++++++++++++++++++++++++++++++++++++++
 risu_reginfo_aarch64.h |   8 ++++
 risu_reginfo_arm.c     |  11 +++++
 risu_reginfo_m68k.c    |   3 ++
 risu_reginfo_ppc64.c   |   3 ++
 risugen                |   3 ++
 risugen_arm.pm         |  57 +++++++++++++++++++---
 13 files changed, 286 insertions(+), 25 deletions(-)

-- 
2.14.2
