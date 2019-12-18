Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A2DC2D0BF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 23:27:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6792A21582
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 23:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ExBuGlHN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6792A21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihiid-0000cl-4n
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 18:27:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34937)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1ihih1-0007CY-Ko
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 18:25:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1ihigx-0003Yv-Cu
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 18:25:21 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46953
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1ihigw-0003Y7-U2
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 18:25:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576711517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7d6qEeWamUDL9dRd1cdlzbEYfcodtQ5+3ZfZnn0KQ/k=;
 b=ExBuGlHNNk8mXkxzpX14Sf+p1NgIQxhoOIe9JsPqCzncLXzgJ7tVecGts3LtcKQDb3wcnT
 jGOv7DR0HObYMjOl/2QicmTYd9I/UvKdRXxm0uxEsQe4WKTnPcSgtyLvPwV2xlMP4iWsLr
 myXzr+C0yZIOr0qQ3dWqV93/hTF8+xM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-NulKj13fNrCTI1q5kPS_tQ-1; Wed, 18 Dec 2019 18:25:13 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86D20DB6B;
 Wed, 18 Dec 2019 23:25:12 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-116-25.gru2.redhat.com
 [10.97.116.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D1C36100164D;
 Wed, 18 Dec 2019 23:25:03 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 0/4] Acceptance test: Add "boot_linux" acceptance test
Date: Wed, 18 Dec 2019 18:24:56 -0500
Message-Id: <20191218232500.23530-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: NulKj13fNrCTI1q5kPS_tQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This acceptance test, validates that a full blown Linux guest can
successfully boot in QEMU.  In this specific case, the guest chosen is
Fedora version 31.

 * x86_64, pc and q35 machine types, with and without kvm as an
   accellerator

 * aarch64 and virt machine type, with and without kvm as an
   accellerator

 * ppc64 and pseries machine type

 * s390x and s390-ccw-virtio machine type

This has been tested on x86_64 and ppc64le hosts and has been running
reliably (in my experience) on Travis CI.

On s390x hosts, it needs a pycdlib fix that has been merged on the
upstream project, but it's still pending being part of a release.

Git:
  - URI: https://github.com/clebergnu/qemu/tree/test_boot_linux_v8
  - Remote: https://github.com/clebergnu/qemu
  - Branch: test_boot_linux_v8

Travis CI:
  - Build: https://travis-ci.org/clebergnu/qemu/builds/626935191

Previous version:
  - v7: https://lists.gnu.org/archive/html/qemu-devel/2019-11/msg00220.html
  - v6: https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg01202.html
  - v5: https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg04652.html
  - v4: https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg02032.html
  - v3: https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg01677.html
  - v2: https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg04318.html
  - v1: http://lists.nongnu.org/archive/html/qemu-devel/2018-09/msg02530.ht=
ml

Changes from v7:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

This version drops a number of commits that had been already reviewed
and have been merged:

 * Dropped commit "Acceptance tests: use relative location for tests",
   already present in the latest master.

 * Dropped commit "Acceptance tests: use avocado tags for machine type",
   already present in the latest master.

 * Dropped commit: "Acceptance tests: introduce utility method for tags
   unique vals", already present in the latest master.

With regards to the handling of the build directory, and the usage of
a qemu-img binary from the build tree, the following changed:

 * Dropped commit "Acceptance tests: add the build directory to the
   system PATH", because the qemu-img binary to be used is now
   explicitly defined, instead of relying on the modification of the
   PATH environment variable.

 * Dropped commit "Acceptance tests: depend on qemu-img", replaced by
   explicitly setting the qemu-img binary to be used for snapshot
   generation.  Also, the newly added "--enable-tools" configure line
   on Travis CI makes sure that a matching qemu-img binary is
   available on CI.

 * Dropped commit "Acceptance tests: keep a stable reference to the
   QEMU build dir", replaced by a different approach that introduces
   variables tracking the build dir, source dir and link (from build
   to source) dir.

 * New commit "Acceptance tests: introduce BLD_DIR, SRC_DIR and
   LNK_DIR".

 * New commit "Acceptance tests: add make targets to download images",
   that downloads the cloud images, aka vmimages, before the test
   execution itself.

 * New commit "[TO BE REMOVED] Use Avocado master branch + vmimage fix"
   to facilitate the review/test of this version.

Additionally:

  * The check for the availability of kvm now makes use of the
    strengthened qemu.accel.kvm_available() and passes the QEMU binary
    as an argument to make sure KVM support is compiled into that
    binary.

 * The timeout was increased to 900 seconds.  This is just one extra
   step to avoid false negatives on very slow systems.  As a
   comparison, on Travis CI, on a x86_64 host, the slowest test takes
   around 250 seconds (boot_linux.py:BootLinuxAarch64.test_virt).  On
   x86_64 systems with KVM enabled, my experience is that a test will
   take around 15 seconds.

Changes from v6:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

 * Bumped Fedora to most recently released version (31).

 * Included new architectures (ppc64 and s390x), consolidating all
   tests into the same commit.

 * New commit: "Acceptance tests: use avocado tags for machine type"

 * New commit: "Acceptance tests: introduce utility method for tags
   unique vals"

 * New commit: "Acceptance test x86_cpu_model_versions: use default
   vm", needed to normalize the use of the machine type tags

 * Added a lot of leniency to the test setup (and reliability to the
   test/job), canceling the test if there are any failures while
   downloading/preparing the boot images.

 * Made use of Avocado's data drainer a regular feature (dropped the
   commit with RFC) and squashed it.

 * Bumped pycdlib version to 1.8.0

 * Dropped explicit "--enable-slirp=3Dgit" (added on v5) to Travis CI
   configure line, as the default configuration on Travis CI now
   results in user networking capabilities.

Changes from v5:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

 * Added explicit "--enable-slirp=3Dgit" to Travis CI configure line, as
   these tests depend on "-netdev user" like networking.

 * Bumped Fedora to most recently released version (30).

 * Changed "checksum" parameter to 'sha256' and use the same hashes as
   provided by the Fedora project (instead of using Avocado's default
   sha1 and compute and use a different hash value).

 * New commit: Add "boot_linux" test for aarch64 and virt machine type

 * New commit: [RFC]: use Avocado data drainer for console logging

Changes from v4:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

 * New commit "Acceptance tests: use relative location for tests"

 * New commit "Acceptance tests: keep a stable reference to the QEMU build =
dir"

 * Pinned the Fedora 29 image by adding a checksum.  The goal is to
   never allow more than one component to change at a time (the one
   allowed to change is QEMU itself).  Updates to the image should be
   manual. (Based on comments from Cornelia)

 * Moved the downloading of the Fedora 29 cloud image to the test
   setUp() method, canceling the test if the image can not be
   downloaded.

 * Removed the ":avocado: enable" tag, given that Avocado versions
   68.0 and later operate on a "recursive by default" manner, that
   is able to correctly identify this as an Avocado test.

Changes from v3:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

 * New patch "Acceptance tests: depend on qemu-img"

Known Issues on v3 (no longer applicable):
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

 * A recent TCG performance regression[1] affects this test in a
   number of ways:
   - The test execution may timeout by itself
   - The generation of SSH host keys in the guest's first boot is also
     affected (possibly also a timeout)
   - The cloud-init "phone home" feature attempts to read the host keys
     and fails, causing the test to timeout and fail

   These are not observed anymore once the fix[2] is applied.

[1] - https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg00338.html
[2] - https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg01129.html

Changes from v2:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

 * Updated the tag to include the "arch:" key, in a similar fashion as to
   the tests in the "Acceptance Tests: target architecture support":
   - https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg00369.html

 * Renamed the test method name to test_x86_64_pc, again, similarly to the
   boot_linux_console.py tests in the series mentioned before.

 * Set the machine type explicitly, again similarly to the
   boot_linux_console.py tests in the series mentioned before.

 * Added messages after the launch of the VM, to let test runners know
   the test know waits for a boot confirmation from the the guest (Eduardo)=
.

 * Updated commit message to reflect the fact that this version does
   not allow for parameterization of the guest OS, version, etc.

 * Dropped the RFC prefix on patch "RFC: Acceptance tests: add the
   build directory to the system PATH"

 * Changed the comments on "RFC: Acceptance tests: add the build
   directory to the system PATH" to make it clear the addition of a
   the build directory to the PATH may influence other utility code.

Changes from v1:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

 * The commit message was adjusted, removing the reference to the
   avocado.utils.vmimage encoding issue on previous Avocado versions
   (<=3D 64.0) and the fix that would (and was) included in Avocado
   version 65.0.

 * Effectively added pycdlib=3D=3D1.6.0 to the requirements.txt file,
   added on a56931eef3, and adjusted the commit message was also
   to reflect that.

 * Updated the default version of the guest OS, from Fedora 28 to 29.
   Besides possible improvements in the (virtual) hardware coverage,
   it brings a performance improvement in the order of 20% to the
   test.

 * Removed all direct parameters usage.  Because some parameters and
   its default values implemented in the test would prevent it from
   running on some environments.  Example: the "accel" parameter had a
   default value of "kvm", which would prevent this test, that boots a
   x86_64 OS, from running on a host arch different than x86_64.  I
   recognize that it's desirable to make tests reusable and
   parameterized (that was the reason for the first version doing so),
   but the mechanism to be used to define the architectures that a
   given test should support is still an open issue, and has been
   discussed in other threads.  I'll follow up those discussions with
   a proposal, and until then, removing those aspects from this test
   implementation seemed to be the best option.  A caveat: this test
   currently adds the same tag (x86_64) and follows other assumptions
   made on "boot_linux_console.py", that is, that a x86_64 target
   binary will be used to run it.  If a user is in an environment that
   does not have a x86_64 target binary, it could filter those tests
   out with: "avocado run --filter-by-tags=3D'-x86_64' tests/acceptance".

 * Removed most arguments to the QEMU command line for pretty much the
   same reasons described above, and by following the general
   perception that I could grasp from other discussions that QEMU
   defaults should preferrably be used.  This test, as well as others,
   can and should be extended later to allow for different test
   scenarios by passing well documented parameter values.  That is,
   they should respect well-known parameters such as "accel" mentioned
   above, so that the same test can run with KVM or TCG.

 * Changed the value of the memory argument to 1024, which based on
   my experimentations and observations is the minimum amount of RAM
   for the Fedora 29 cloud image to sucessfully boot on QEMU.  I know
   there's no such thing as a "one size fits all", specially for QEMU,
   but this makes me wonder wether a x86_64 machine type shouldn't
   have its default_ram_size bumped to a number practical enough to
   run modern operating systems.

 * Added a new patch "RFC: Acceptance tests: add the build directory
   to the system PATH", which is supposed to gather feedback on how to
   enable the use of built binaries, such as qemu-img, to code used by
   the test code.  The specific situation here is that the vmimage,
   part of the avocado.utils libraries, makes use of qemu-img to create
   snapshot files.  Even though we could require qemu-img to be installed
   as a dependency of tests, system wide, it actually goes against the
   goal of testing all QEMU things from the source/build tree.  This
   became aparent with tests running on environments such as Travis CI,
   which don't necessarily have qemu-img available elsewhere.

Cleber Rosa (4):
  Acceptance tests: introduce BLD_DIR, SRC_DIR and LNK_DIR
  Acceptance test: add "boot_linux" tests
  Acceptance tests: add make targets to download images
  [TO BE REMOVED] Use Avocado master branch + vmimage fix

 .travis.yml                               |   2 +-
 tests/Makefile.include                    |  17 +-
 tests/acceptance/avocado_qemu/__init__.py |  27 +++-
 tests/acceptance/boot_linux.py            | 180 ++++++++++++++++++++++
 tests/requirements.txt                    |   3 +-
 5 files changed, 219 insertions(+), 10 deletions(-)
 create mode 100644 tests/acceptance/boot_linux.py

--=20
2.21.0


