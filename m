Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A2FC18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 14:18:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9C692051A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 14:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P6Cped1/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9C692051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jED32-00032v-3v
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 10:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55967)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1jED1t-0001KF-6F
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:17:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1jED1q-0007mY-GG
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:17:13 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:43461)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1jED1q-0007jE-Aa
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:17:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584454630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=E8G3Ait7H1WemEL0ci1p+tu+Cmbn6w0pd5O2kdCCjrY=;
 b=P6Cped1/0Goch+OWsf+JSbpAW+MvjUA5SMRF1sGMH1+rK+YWyUxoN/MKc2YazG7LFgB5Et
 6vSLJicyuiryQ37QMRUSEh1bK0O+oUqSQnsSFO++R5ZURPkT9LhRkErWhLmwKdJ2k45Rfz
 o1i7p+iMRG84NGPG9XSyFQNlWmqh+b8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-rEt4ur4FNZuwHpnlRRFi1w-1; Tue, 17 Mar 2020 10:17:01 -0400
X-MC-Unique: rEt4ur4FNZuwHpnlRRFi1w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C96B418A6EC6;
 Tue, 17 Mar 2020 14:17:00 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-2.rdu2.redhat.com
 [10.10.117.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 80C5C73873;
 Tue, 17 Mar 2020 14:16:56 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 0/3] Acceptance test: Add "boot_linux" acceptance test
Date: Tue, 17 Mar 2020 10:16:51 -0400
Message-Id: <20200317141654.29355-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Fam Zheng <fam@euphon.net>, Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This acceptance test, validates that a full blown Linux guest can
successfully boot in QEMU.  In this specific case, the guest chosen is
Fedora version 31.  It covers the following architectures and
machine types:

 * x86_64, pc-i440fx and pc-q35 machine types, with TCG and KVM as
   accelerators

 * aarch64 and virt machine type, with TCG and KVM as accelerators

 * ppc64 and pseries machine type with TCG as accelerator

 * s390x and s390-ccw-virtio machine type with TCG as accelerator

This has been tested on x86_64, ppc64le and aarch64 hosts and has been
running reliably (in my experience) on Travis CI.

Git:
  - URI: https://github.com/clebergnu/qemu/tree/test_boot_linux_v10
  - Remote: https://github.com/clebergnu/qemu
  - Branch: test_boot_linux_v10

Travis CI:
  - Build: https://travis-ci.org/github/clebergnu/qemu/builds/663511065

Previous version:
  - v9: https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg05393.html
  - v8: https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg04095.html
  - v7: https://lists.gnu.org/archive/html/qemu-devel/2019-11/msg00220.html
  - v6: https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg01202.html
  - v5: https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg04652.html
  - v4: https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg02032.html
  - v3: https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg01677.html
  - v2: https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg04318.html
  - v1: https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg02530.html

Changes from v9:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

* Reverted the "Added additional tags for 'pc' alias, that is,
  'pc-i440fx'" change added in v8, because the current logic for
  automatically setting machine types depends on a unique tag
  being set.

* Replaced aarch64 CPU model from cortex-a53 (after the one
  set in boot_linux_console.py:BootLinuxConsole.test_aarch64_virt)
  to "max", as suggested by Andrew Jones.

* Added "gic-version=3D2" to aarch64 machine type, as suggested by
  Andrew Jones.

* Fixed small typo (missing whitespace) in prepare_boot() debug
  message

* Explicitly check for qemu-img in the system (in addition to looking
  for it in the build tree), canceling the test if it's not found

* Moved the "self.boot.path" attribute access, which triggers the
  creation of the snapshot image itself, to within a try/except block,
  also canceling the test if that fails for any reason

Changes from v8:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

* Renamed "BLD_DIR" to "BUILD_DIR", "SRC_DIR" to "SOURCE_DIR" and dropped
  "LNK_DIR" variables on tests/acceptance/avocado_qemu/__init__.py

* Changed memory allocation to 1024 MB, so that it puts less pressure on
  the host memory, and should be compatible with 32bit hosts (I've found
  no significant effects to the test times)

* Explicitly enabled TCG and skip tests if it's not available

* Added tags for when accel is TCG ("accel:tcg")

* Added additional tags for "pc" alias, that is, "pc-i440fx"

* Renamed tests to make the machine type and accellerator more explicit:
  - BootLinuxX8664.test_pc =3D> BootLinuxX8664.test_pc_i440fx_tcg
  - BootLinuxX8664.test_pc_kvm =3D> BootLinuxX8664.test_pc_i440fx_kvm
  - BootLinuxX8664.test_q35 =3D> BootLinuxX8664.test_pc_q35_tcg
  - BootLinuxX8664.test_kvm_q35 =3D> BootLinuxX8664.test_pc_q35_kvm
  - BootLinuxAarch64.test_virt =3D> BootLinuxAarch64.test_virt_tcg
  - BootLinuxAarch64.test_kvm_virt =3D> BootLinuxAarch64.test_virt_kvm
  - BootLinuxPPC64.test_pseries =3D> BootLinuxPPC64.test_pseries_tcg
  - BootLinuxS390X.test_s390_ccw_virtio =3D> BootLinuxS390X.test_s390_ccw_v=
irtio_tcg

* Renamed target "get-vmimage" to "get-vm-images", and added a help
  entry under "check-help".

* Bumped pycdlib version to 1.9.0, which contains an endianess bug that
  was seen on s390x hosts.

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

Cleber Rosa (3):
  Acceptance tests: introduce BUILD_DIR and SOURCE_DIR
  Acceptance test: add "boot_linux" tests
  Acceptance tests: add make targets to download images

 .travis.yml                               |   2 +-
 tests/Makefile.include                    |  19 +-
 tests/acceptance/avocado_qemu/__init__.py |  25 ++-
 tests/acceptance/boot_linux.py            | 222 ++++++++++++++++++++++
 tests/requirements.txt                    |   1 +
 5 files changed, 260 insertions(+), 9 deletions(-)
 create mode 100644 tests/acceptance/boot_linux.py

--=20
2.25.1


