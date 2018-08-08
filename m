Received: from eggs.gnu.org ([2001:4830:134:3::10]:35414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fnNka-0004Vt-Ag
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:39:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fnNkX-0006qr-5c
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:39:40 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:34496)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fnNkW-0006os-LN
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:39:37 -0400
Received: by mail-wm0-x234.google.com with SMTP id l2-v6so539191wme.1
	for <qemu-devel@nongnu.org>; Wed, 08 Aug 2018 05:39:36 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed,  8 Aug 2018 13:39:30 +0100
Message-Id: <20180808123934.17450-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 0/4] add hand-rolled fallback when capstone
 fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, richard.henderson@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

While capstone is actively maintained it hasn't managed to keep up to
date with newer instructions as they have been added. While these
should eventually be supported we need something in the meantime.

This proof-of-concept series takes advantage of the fact we already
have a parser for SVE instructions. By tweaking the output of
decodetree.py a little we can generate something we can plug into the
assembly dump when capstone fails. Currently it is just the
instruction name (as encoded in sve.decode) but extending it to
include the parameters shouldn't be too hard.

The plumbing into disas is a little ugly and perhaps that can be
solved later with some re-factoring.

So what do you think? Worth pursing or adding to the pile of cute but
not ultimately mergable hacks?

Alex Bennée (4):
  scripts/decodetree.py: add a disassembly generator (HACK!)
  target/arm: move decoder helpers into header
  target/arm: add a fallback disassemble function
  disas: allow capstone to defer to a fallback function on failure

 disas.c                    | 30 +++++++++++++++++++++-
 include/disas/bfd.h        | 11 +++++++-
 scripts/decodetree.py      | 52 +++++++++++++++++++++++++++++++++-----
 target/arm/Makefile.objs   |  8 ++++++
 target/arm/cpu.c           |  4 +++
 target/arm/decoder.h       | 50 ++++++++++++++++++++++++++++++++++++
 target/arm/disassemble.c   | 22 ++++++++++++++++
 target/arm/internals.h     |  2 ++
 target/arm/translate-sve.c | 50 +-----------------------------------
 9 files changed, 172 insertions(+), 57 deletions(-)
 create mode 100644 target/arm/decoder.h
 create mode 100644 target/arm/disassemble.c

-- 
2.17.1
