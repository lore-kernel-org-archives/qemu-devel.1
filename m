Received: from eggs.gnu.org ([209.51.188.92]:38774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpa9X-0008Jk-9A
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 09:50:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpa9V-000444-OJ
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 09:50:47 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38936)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpa9V-000416-Gb
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 09:50:45 -0500
Received: by mail-wr1-x441.google.com with SMTP id t27so7384682wra.6
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 06:50:40 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  1 Feb 2019 14:50:24 +0000
Message-Id: <20190201145035.22739-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 00/11] Enable build and install of our rST docs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

This patchset enables building and installing the various rST
docs we have started to accumulate in our docs/ directory.
It does this using Sphinx (which is the docs tooling that the
Linux kernel uses). The series is not trying to take us in one
giant leap to a brave new Sphinx-powered world -- it is simply
setting up a framework so that we are at least building and
shipping these documents and can gradually migrate other parts
of our documentation to it.

The approach I've used here is that we will have multiple "manuals",
as proposed by Paolo here:
  https://wiki.qemu.org/Features/Documentation
For the moment I've only created 'interop' and 'devel' as we don't
yet have any rST files for 'user', 'system' or 'specs'.

One slightly awkward mismatch between how Sphinx naturally wants
to work and our requirements is that when Sphinx generates a
documentation set all in one go it creates hyperlinks between
all the docs, they all appear in a single top level table of
contents, and so on. But for QEMU's docs we don't want to
ship the "devel" manual to end-users. I've taken an approach
suggested to me on sphinx-users
(https://www.mail-archive.com/sphinx-users@googlegroups.com/msg03224.html)
where we run Sphinx once per manual, and treat them as
entirely separate documents. The config/tooling in this patchset
also supports building everything in a single run, for compatibility
with third-party docs sites like readthedocs.org.

To see the results:

What you get in the docs/ subdir of your build directory
when you do a local build:
 http://people.linaro.org/~peter.maydell/build-dir-docs/
(follow the links to 'devel' and 'interop' for the two manuals)

What we'll ship in 'make install' in /usr/local/share/doc/qemu/
http://people.linaro.org/~peter.maydell/installed-docs/
(should be same as the build dir except we don't ship 'devel')

What you get with a standalone single-run docs build:
 http://people.linaro.org/~peter.maydell/standalone-docs/index.html

These use the default 'alabaster' theme from Sphinx. I
also experimented with the 'read_the_docs' theme, which I
do think looks nicer. Unfortunately it also requires the
docs we install to include about 3MB of TrueType font files
per manual, which is awkward licensing-wise as the TTFs are
under the Open Font License and it's not completely clear to
me that it's OK to ship those to use with a doc file that is
GPLed. Alabaster doesn't ship fonts, which sidesteps both
those problems.

Other notes:
 * this does not build the two .rst files that are directly
   in docs/ (cpu-hotplug.rst and pr-manager.rst) -- we should
   move these to whichever of the five manuals is the best place
 * I do have some prototype patches which integrate the kernel's
   kerneldoc Sphinx extension to parse doc comments in source
   code. I haven't included them here because I think the 'devel'
   manual is the lowest priority of the five. They might be
   useful if we want to try things like building documentation
   of supported machine models from in-code comments/etc, though.
 * as noted in a previous email thread, the configure changes
   now mean that building docs depends on build-sphinx being
   available, so this is a new build-dep for --enable-docs.

thanks
-- PMM

Peter Maydell (11):
  docs/cpu-hotplug.rst: Fix rST markup issues
  docs: Convert memory.txt to rst format
  docs: Commit initial files from sphinx-quickstart
  docs/conf.py: Disable unused _static directory
  docs/conf.py: Configure the 'alabaster' theme
  docs/conf.py: Don't include rST sources in HTML build
  docs/conf.py: Disable option warnings
  Separate conf.py for each manual we want
  Makefile, configure: Support building rST documentation
  Makefile: Abstract out "identify the pkgversion" code
  docs/conf.py: Don't hard-code QEMU version

 configure                             |   4 +-
 Makefile                              |  78 +++++++---
 docs/conf.py                          | 215 ++++++++++++++++++++++++++
 docs/cpu-hotplug.rst                  |   2 +-
 docs/devel/conf.py                    |  15 ++
 docs/devel/index.rst                  |  21 +++
 docs/devel/{memory.txt => memory.rst} | 128 ++++++++-------
 docs/index.rst                        |  15 ++
 docs/interop/conf.py                  |  15 ++
 docs/interop/index.rst                |  18 +++
 10 files changed, 430 insertions(+), 81 deletions(-)
 create mode 100644 docs/conf.py
 create mode 100644 docs/devel/conf.py
 create mode 100644 docs/devel/index.rst
 rename docs/devel/{memory.txt => memory.rst} (85%)
 create mode 100644 docs/index.rst
 create mode 100644 docs/interop/conf.py
 create mode 100644 docs/interop/index.rst

-- 
2.20.1
