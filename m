Received: from eggs.gnu.org ([209.51.188.92]:52086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzN6v-0004fM-Qp
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 09:56:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzN6u-0007cD-F3
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 09:56:33 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33072)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gzN6u-0007at-5m
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 09:56:32 -0500
Received: by mail-wm1-x344.google.com with SMTP id c13so6796036wmb.0
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 06:56:31 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Feb 2019 14:56:13 +0000
Message-Id: <20190228145624.24885-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 00/11] Enable build and install of our rST
 docs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

This patchset enables building and installing the various rST
docs we have started to accumulate in our docs/ directory.
It does this using Sphinx (which is the docs tooling that the
Linux kernel uses). The series is not trying to take us in one
giant leap to a brave new Sphinx-powered world -- it is simply
setting up a framework so that we are at least building and
shipping these documents and can gradually migrate other parts
of our documentation to it.

Changes v1->v2:
 * Added a few missing Signed-off-by lines
 * Provided a proper commit message for patch 8
 * patch 9: only add 'sphinxdocs' target to 'all' if BUILD_DOCS
   is defined (fixes building on systems without sphinx-build,
   which will now just not build the docs rather than barfing)

All patches except 9 have been reviewed.

Feedback to v1 seemed to be positive, so I propose that (assuming
no further issues found in code review) we commit this series
before softfreeze for the 4.1 release.


All the text below here is from the v1 cover letter, for context.


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
  docs: Provide separate conf.py for each manual we want
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
