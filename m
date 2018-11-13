Received: from eggs.gnu.org ([2001:4830:134:3::10]:38774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gMdiD-0000VY-BT
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 13:46:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gMdiC-0000PY-HZ
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 13:46:57 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52562)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gMdiC-0000GQ-9E
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 13:46:56 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Nov 2018 18:46:39 +0000
Message-Id: <20181113184641.4492-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/2] Automation for running Coverity Scan builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>

This patchset is an attempt to automate the process of
running a Coverity Scan build and uploading it to the website.
(I had a go at this last year; the scripts here are based
on my older attempt, with some changes.)

Patch 1 is a script which will do a build-and-upload. It
requires that you have a Fedora 28 host with all the relevant
-devel packages installed, and that you run it in a clean directory.

Patch 2 improves on that by using Docker to set up the
build environment, so you can run it on any host and get
the same results, and it doesn't trash your source tree with
an in-place build.

Patch 1 I'm generally pretty happy with. Paolo, if you could
check the configure options against what you use at the moment
for uploads that would be very helpful. These are the set that
you gave me last time I asked, but I think that was long enough
ago that they may be a little out of date.

Patch 2 is a bit more RFC-ish -- it does work and you can do a
complete build-and-upload with it, but I was thrashing about
trying to get Docker to do what I wanted and I'm pretty sure
there are better ways to do it. In particular I was expecting
that once the script has run once and done the "set up F28,
download the coverity tools and unpack them", that a second
run would reuse a cached copy of that image, but the docker
build seems to repeat the download-and-unpack part.
NB that you need the bleeding-edge Docker 18.09 for the --secret
option which lets us pass the coverity magic token into the
build stage safely. Review from people who know Docker welcomed.


I would eventually like to set up Travis so it does the
build-and-upload automatically, but I think getting to a
point where coverity uploads are done with a process that
can be repeated reliably by anybody with maintainer rights
is useful in itself even if we don't want to do it via Travis.

thanks
-- PMM


Peter Maydell (2):
  scripts/run-coverity-scan: Script to run Coverity Scan build
  scripts/coverity-scan: Add Docker support

 MAINTAINERS                                |   5 +
 scripts/coverity-scan/coverity-scan.docker | 120 +++++++
 scripts/coverity-scan/run-coverity-scan    | 350 +++++++++++++++++++++
 3 files changed, 475 insertions(+)
 create mode 100644 scripts/coverity-scan/coverity-scan.docker
 create mode 100755 scripts/coverity-scan/run-coverity-scan

-- 
2.19.1
