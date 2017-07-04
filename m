Received: from eggs.gnu.org ([2001:4830:134:3::10]:35641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dSP7h-0008Db-QD
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:48:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dSP7d-000147-TL
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:48:17 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:35174)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dSP7d-00012M-Jx
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:48:13 -0400
Received: by mail-wm0-x22e.google.com with SMTP id w126so198099858wme.0
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 07:48:11 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  4 Jul 2017 15:48:48 +0100
Message-Id: <20170704144859.17644-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH 00/11] Misc fixes,
 documentation and patterns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi Peter,

A bit of a mixed set of patches here for you to pick from as you
will. The first 2 are additional tracing fixes including a fix for
segfaulting when generating a trace.

The next two are documentation patches as requested.

Then two minor tweaks, one to risu.el and a indent failure of risugen.

While I've been working through the half-precision stuff I've been
finding the --pattern approach a bit inflexible as you basically end
up eyeballing the risu file to build up the regexs. I've added a
little syntactic suger to the risu file to enable grouping. This makes
slicing a subset a lot easier, e.g.:

  ./risugen --group AdvSIMDAcrossVector --not-pattern ".*_RES" aarch64.risu

You can specify multiple groups in the risu file as the matching is
string based, e.g.:

  @Integer,Logic,Immediate

And then:

  ./risugen --group Logic aarch64.risu foo.bin

What do you think?

Alex Bennée (11):
  risu: make match status take tracing into account
  reginfo.c: always return 1 on OP_TESTEND
  README: document --static builds
  README: document record/replay support
  risu.el: derive from text-mode
  risugen: fix bad indent
  risugen: support @GroupName in risu files
  aarch64.risu: document naming conventions
  aarch64.risu: remove duplicate AdvSIMD Scalar 3 same block
  aarch64.risu: remove duplicate AdvSIMD scalar 2 reg misc block
  aarch64.risu: update AdvancedSIMD across lanes

 README         |  40 ++++++++--
 aarch64.risu   | 241 ++++++++++++++++++++++++---------------------------------
 reginfo.c      |  19 +++--
 risu.c         |   4 +-
 risu.el        |   2 +-
 risu.h         |   2 +-
 risugen        |  17 +++-
 risugen_arm.pm |   7 ++
 8 files changed, 175 insertions(+), 157 deletions(-)

-- 
2.13.0
