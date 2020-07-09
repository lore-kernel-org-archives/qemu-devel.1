Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5836C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 02:48:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F7F72065D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 02:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SJf9EvQV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F7F72065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtMbd-0007Gc-Th
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 22:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jtMat-0006Ox-6w
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 22:47:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25497
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jtMaq-0008Ae-8y
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 22:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594262843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hMBtrOyvA3VT3JWsbnqsz1M64pH81tse/Zqk5d1Wx8M=;
 b=SJf9EvQVK+6P4RmcgHhAwaYKSVHzZM2b2p+eYPfbPaNRUvZ5VSJAH2k4dxf6uNa2oqBVW5
 RkphJvm83AZw0tXkf3CV7P5048EyuVHc697yRr7/QVktQfDzRzrJTnuBh+oODPf9yGC1rv
 rCmywp07AY0eAeuswely9FnSV0DTXYA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-SvhA3axPM92O7qDOt71xGw-1; Wed, 08 Jul 2020 22:47:07 -0400
X-MC-Unique: SvhA3axPM92O7qDOt71xGw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 480671005510;
 Thu,  9 Jul 2020 02:47:06 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-247.rdu2.redhat.com
 [10.10.112.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E79261981;
 Thu,  9 Jul 2020 02:47:04 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 2/2] GitLab Gating CI: initial set of jobs,
 documentation and scripts
Date: Wed,  8 Jul 2020 22:46:57 -0400
Message-Id: <20200709024657.2500558-3-crosa@redhat.com>
In-Reply-To: <20200709024657.2500558-1-crosa@redhat.com>
References: <20200709024657.2500558-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=crosa@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a mapping of Peter's "remake-merge-builds" and
"pull-buildtest" scripts, gone through some updates, adding some build
option and removing others.

The jobs currently cover the machines that the QEMU project owns, and that
are setup and ready to run jobs:

 - Ubuntu 18.04 on S390x
 - Ubuntu 20.04 on aarch64

During the development of this set of jobs, the GitLab CI was tested
with many other architectures, including ppc64, s390x and aarch64,
along with the other OSs (not included here):

 - Fedora 30
 - FreeBSD 12.1

More information can be found in the documentation itself.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 .gitlab-ci.d/gating.yml                | 146 +++++++++++++++++
 .gitlab-ci.yml                         |   1 +
 docs/devel/testing.rst                 | 147 +++++++++++++++++
 scripts/ci/setup/build-environment.yml | 217 +++++++++++++++++++++++++
 scripts/ci/setup/gitlab-runner.yml     |  72 ++++++++
 scripts/ci/setup/inventory             |   2 +
 scripts/ci/setup/vars.yml              |  13 ++
 7 files changed, 598 insertions(+)
 create mode 100644 .gitlab-ci.d/gating.yml
 create mode 100644 scripts/ci/setup/build-environment.yml
 create mode 100644 scripts/ci/setup/gitlab-runner.yml
 create mode 100644 scripts/ci/setup/inventory
 create mode 100644 scripts/ci/setup/vars.yml

diff --git a/.gitlab-ci.d/gating.yml b/.gitlab-ci.d/gating.yml
new file mode 100644
index 0000000000..5562df5708
--- /dev/null
+++ b/.gitlab-ci.d/gating.yml
@@ -0,0 +1,146 @@
+variables:
+  GIT_SUBMODULE_STRATEGY: recursive
+
+# All ubuntu-18.04 jobs should run successfully in an environment
+# setup by the scripts/ci/setup/build-environment.yml task
+# "Install basic packages to build QEMU on Ubuntu 18.04/20.04"
+ubuntu-18.04-s390x-all-linux-static:
+ tags:
+ - ubuntu_18.04
+ - s390x
+ rules:
+ - if: '$CI_COMMIT_REF_NAME == "staging"'
+ script:
+ # --disable-libssh is needed because of https://bugs.launchpad.net/qemu/+bug/1838763
+ # --disable-glusterfs is needed because there's no static version of those libs in distro supplied packages
+ - ./configure --enable-debug --static --disable-system --disable-glusterfs --disable-libssh
+ - make --output-sync -j`nproc`
+ - make --output-sync -j`nproc` check V=1
+ - make --output-sync -j`nproc` check-tcg V=1
+
+ubuntu-18.04-s390x-all:
+ tags:
+ - ubuntu_18.04
+ - s390x
+ rules:
+ - if: '$CI_COMMIT_REF_NAME == "staging"'
+ script:
+ - ./configure --disable-libssh
+ - make --output-sync -j`nproc`
+ - make --output-sync -j`nproc` check V=1
+
+ubuntu-18.04-s390x-alldbg:
+ tags:
+ - ubuntu_18.04
+ - s390x
+ rules:
+ - if: '$CI_COMMIT_REF_NAME == "staging"'
+ script:
+ - ./configure --enable-debug --disable-libssh
+ - make clean
+ - make --output-sync -j`nproc`
+ - make --output-sync -j`nproc` check V=1
+
+ubuntu-18.04-s390x-clang:
+ tags:
+ - ubuntu_18.04
+ - s390x
+ rules:
+ - if: '$CI_COMMIT_REF_NAME == "staging"'
+ script:
+ - ./configure --disable-libssh --cc=clang --cxx=clang++ --enable-sanitizers
+ - make --output-sync -j`nproc`
+ - make --output-sync -j`nproc` check V=1
+
+ubuntu-18.04-s390x-tci:
+ tags:
+ - ubuntu_18.04
+ - s390x
+ rules:
+ - if: '$CI_COMMIT_REF_NAME == "staging"'
+ script:
+ - ./configure --disable-libssh --enable-tcg-interpreter
+ - make --output-sync -j`nproc`
+
+ubuntu-18.04-s390x-notcg:
+ tags:
+ - ubuntu_18.04
+ - s390x
+ rules:
+ - if: '$CI_COMMIT_REF_NAME == "staging"'
+ script:
+ - ./configure --disable-libssh --disable-tcg
+ - make --output-sync -j`nproc`
+ - make --output-sync -j`nproc` check V=1
+
+# All ubuntu-20.04 jobs should run successfully in an environment
+# setup by the scripts/ci/setup/qemu/build-environment.yml task
+# "Install basic packages to build QEMU on Ubuntu 18.04/20.04"
+ubuntu-20.04-aarch64-all-linux-static:
+ tags:
+ - ubuntu_20.04
+ - aarch64
+ rules:
+ - if: '$CI_COMMIT_REF_NAME == "staging"'
+ script:
+ # --disable-libssh is needed because of https://bugs.launchpad.net/qemu/+bug/1838763
+ # --disable-glusterfs is needed because there's no static version of those libs in distro supplied packages
+ - ./configure --enable-debug --static --disable-system --disable-glusterfs --disable-libssh
+ - make --output-sync -j`nproc`
+ - make --output-sync -j`nproc` check V=1
+ - make --output-sync -j`nproc` check-tcg V=1
+
+ubuntu-20.04-aarch64-all:
+ tags:
+ - ubuntu_20.04
+ - aarch64
+ rules:
+ - if: '$CI_COMMIT_REF_NAME == "staging"'
+ script:
+ - ./configure --disable-libssh
+ - make --output-sync -j`nproc`
+ - make --output-sync -j`nproc` check V=1
+
+ubuntu-20.04-aarch64-alldbg:
+ tags:
+ - ubuntu_20.04
+ - aarch64
+ rules:
+ - if: '$CI_COMMIT_REF_NAME == "staging"'
+ script:
+ - ./configure --enable-debug --disable-libssh
+ - make clean
+ - make --output-sync -j`nproc`
+ - make --output-sync -j`nproc` check V=1
+
+ubuntu-20.04-aarch64-clang:
+ tags:
+ - ubuntu_20.04
+ - aarch64
+ rules:
+ - if: '$CI_COMMIT_REF_NAME == "staging"'
+ script:
+ - ./configure --disable-libssh --cc=clang --cxx=clang++ --enable-sanitizers
+ - make --output-sync -j`nproc`
+ - make --output-sync -j`nproc` check V=1
+
+ubuntu-20.04-aarch64-tci:
+ tags:
+ - ubuntu_20.04
+ - aarch64
+ rules:
+ - if: '$CI_COMMIT_REF_NAME == "staging"'
+ script:
+ - ./configure --disable-libssh --enable-tcg-interpreter
+ - make --output-sync -j`nproc`
+
+ubuntu-20.04-aarch64-notcg:
+ tags:
+ - ubuntu_20.04
+ - aarch64
+ rules:
+ - if: '$CI_COMMIT_REF_NAME == "staging"'
+ script:
+ - ./configure --disable-libssh --disable-tcg
+ - make --output-sync -j`nproc`
+ - make --output-sync -j`nproc` check V=1
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 349c77aa58..49efe38529 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -1,6 +1,7 @@
 include:
   - local: '/.gitlab-ci.d/edk2.yml'
   - local: '/.gitlab-ci.d/opensbi.yml'
+  - local: '/.gitlab-ci.d/gating.yml'
 
 .update_apt_template: &before_script_apt
  before_script:
diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index c1ff24370b..f8dab788ea 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -1003,3 +1003,150 @@ exercise as many corner cases as possible. It is a useful test suite
 to run to exercise QEMU's linux-user code::
 
   https://linux-test-project.github.io/
+
+CI
+==
+
+QEMU has configurations enabled for a number of different CI services.
+The most update information about them and their status can be found
+at::
+
+   https://wiki.qemu.org/Testing/CI
+
+Gating CI
+----------
+
+A Pull Requests will only to be merged if they successfully go through
+a different set of CI jobs.  GitLab's CI is the service/framework used
+for executing the gating jobs.
+
+The architecture of GitLab's CI service allows different machines to be
+setup with GitLab's "agent", called gitlab-runner, which will take care
+of running jobs created by events such as a push to a branch.
+
+Even though gitlab-runner can execute jobs on environments such as
+containers, this initial implementation assumes the shell executor is
+used, effectively running jobs on the same machine (be them physical
+or virtual) the gitlab-runner agent is running.  This means those
+machines must be setup in advance, with the requirements matching the
+jobs expected to be executed there.
+
+Machine configuration for gating jobs
+-------------------------------------
+
+The GitLab's CI architecture allows different parties to provide
+different machines that will run different jobs.  At this point, QEMU
+will deploy a limited set of machines and jobs.  Documentation and/or
+scripts to setup those machines is located under::
+
+  scripts/ci/setup
+
+Ansible playbooks have been provided to perform two different tasks
+related to setting gitlab-runner and the build environment.
+
+Other organizations involved in QEMU development may, in the near
+future, contribute their own setup documentation/scripts under
+``scripts/ci/orgs/$ORG_NAME`` directory.
+
+The GitLab CI jobs definition for the gating jobs are located under::
+
+  .gitlab-ci.d/gating.yml
+
+Once the gating CI has proved mature with this set of initial jobs,
+other members in the community may provide their own machine
+configuration documentation/scripts, and accompanying job definitions.
+Those contributed jobs should run as non-gating, until their
+reliability is verified.
+
+Machine Setup Howto
+-------------------
+
+For all Linux based systems, the setup can be mostly automated by the
+execution of two Ansible playbooks.  Start by adding your machines to
+the ``inventory`` file under ``scripts/ci/setup``, such as this::
+
+  [local]
+  fully.qualified.domain
+  other.machine.hostname
+
+You may need to set some variables in the inventory file itself.  One
+very common need is to tell Ansible to use a Python 3 interpreter on
+those hosts.  This would look like::
+
+  [local]
+  fully.qualified.domain ansible_python_interpreter=/usr/bin/python3
+  other.machine.hostname ansible_python_interpreter=/usr/bin/python3
+
+Build environment
+~~~~~~~~~~~~~~~~~
+
+The ``scripts/ci/setup/build-environment.yml`` Ansible playbook
+will setup machines with the environment needed to perform builds of
+QEMU and runs of the tests defined in the current gating jobs.  It
+covers a number of different Linux distributions and FreeBSD.
+
+To run the playbook, execute::
+
+  cd scripts/ci/setup
+  ansible-playbook -i inventory build-environment.yml
+
+gitlab-runner setup and registration
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The gitlab-runner agent needs to be installed on each machine that
+will run jobs.  The association between a machine and a GitLab project
+happens with a registration token.  To find the registration token for
+your repository/project, navigate on GitLab's web UI to:
+
+ * Settings (the gears like icon), then
+ * CI/CD, then
+ * Runners, and click on the "Expand" button, then
+ * Under "Set up a specific Runner manually", look for the value under
+   "Use the following registration token during setup"
+
+Edit the ``scripts/ci/setup/vars.yml`` file, setting the
+``gitlab_runner_registration_token`` variable to the value obtained
+earlier.
+
+.. note:: gitlab-runner is not available from the standard location
+          for all OS and architectures combinations.  For some systems,
+          a custom build may be necessary.  Some builds are avaiable
+          at https://cleber.fedorapeople.org/gitlab-runner/ and this
+          URI may be used as a value on ``vars.yml``
+
+To run the playbook, execute::
+
+  cd scripts/ci/setup
+  ansible-playbook -i inventory gitlab-runner.yml
+
+.. note:: there are currently limitations to gitlab-runner itself when
+          setting up a service under FreeBSD systems.  You will need to
+          perform steps 4 to 10 manually, as described at
+          https://docs.gitlab.com/runner/install/freebsd.html
+
+Following the registration, it's necessary to configure the runner tags,
+and optionally other configurations on the GitLab UI.  Navigate to:
+
+ * Settings (the gears like icon), then
+ * CI/CD, then
+ * Runners, and click on the "Expand" button, then
+ * "Runners activated for this project", then
+ * Click on the "Edit" icon (next to the "Lock" Icon)
+
+Under tags, add values matching the jobs a runner should run.  For a
+FreeBSD 12.1 x86_64 system, the tags should be set as::
+
+  freebsd12.1,x86_64
+
+Because the job definition at ``.gitlab-ci.d/gating.yml`` would contain::
+
+  freebsd-12.1-x86_64-all:
+   tags:
+   - freebsd_12.1
+   - x86_64
+
+It's also recommended to:
+
+ * increase the "Maximum job timeout" to something like ``2h``
+ * uncheck the "Run untagged jobs" check box
+ * give it a better Description
diff --git a/scripts/ci/setup/build-environment.yml b/scripts/ci/setup/build-environment.yml
new file mode 100644
index 0000000000..89b35386c7
--- /dev/null
+++ b/scripts/ci/setup/build-environment.yml
@@ -0,0 +1,217 @@
+---
+- name: Installation of basic packages to build QEMU
+  hosts: all
+  vars_files:
+    - vars.yml
+  tasks:
+    - name: Install basic packages to build QEMU on Ubuntu 18.04/20.04
+      apt:
+        update_cache: yes
+        # This matches the packages on tests/docker/Dockerfiles/ubuntu1804.docker
+        pkg:
+          - flex
+          - bison
+          - ccache
+          - clang
+          - gcc
+          - gettext
+          - git
+          - glusterfs-common
+          - libaio-dev
+          - libattr1-dev
+          - libbrlapi-dev
+          - libbz2-dev
+          - libcacard-dev
+          - libcap-ng-dev
+          - libcurl4-gnutls-dev
+          - libdrm-dev
+          - libepoxy-dev
+          - libfdt-dev
+          - libgbm-dev
+          - libgtk-3-dev
+          - libibverbs-dev
+          - libiscsi-dev
+          - libjemalloc-dev
+          - libjpeg-turbo8-dev
+          - liblzo2-dev
+          - libncurses5-dev
+          - libncursesw5-dev
+          - libnfs-dev
+          - libnss3-dev
+          - libnuma-dev
+          - libpixman-1-dev
+          - librados-dev
+          - librbd-dev
+          - librdmacm-dev
+          - libsasl2-dev
+          - libsdl2-dev
+          - libseccomp-dev
+          - libsnappy-dev
+          - libspice-protocol-dev
+          - libssh-dev
+          - libusb-1.0-0-dev
+          - libusbredirhost-dev
+          - libvdeplug-dev
+          - libvte-2.91-dev
+          - libzstd-dev
+          - make
+          - python3-yaml
+          - python3-sphinx
+          - sparse
+          - texinfo
+          - xfslibs-dev
+        state: present
+      when: "ansible_facts['distribution'] == 'Ubuntu'"
+
+    - name: Install packages to build QEMU on Ubuntu 18.04/20.04 on non-s390x
+      apt:
+        update_cache: yes
+        pkg:
+         - libspice-server-dev
+         - libxen-dev
+        state: present
+      when:
+        - "ansible_facts['distribution'] == 'Ubuntu'"
+        - "ansible_facts['architecture'] != 's390x'"
+
+    - name: Install basic packages to build QEMU on FreeBSD 12.x
+      pkgng:
+        # This matches the packages on .cirrus.yml under the freebsd_12_task
+        name: bash,bison,curl,cyrus-sasl,git,glib,gmake,gnutls,gsed,nettle,perl5,pixman,pkgconf,png,usbredir
+        state: present
+      when: "ansible_facts['os_family'] == 'FreeBSD'"
+
+    - name: Install basic packages to build QEMU on Fedora 30
+      dnf:
+        # This matches the packages on tests/docker/Dockerfiles/fedora.docker
+        name:
+          - bc
+          - bison
+          - brlapi-devel
+          - bzip2
+          - bzip2-devel
+          - ccache
+          - clang
+          - cyrus-sasl-devel
+          - dbus-daemon
+          - device-mapper-multipath-devel
+          - findutils
+          - flex
+          - gcc
+          - gcc-c++
+          - gettext
+          - git
+          - glib2-devel
+          - glusterfs-api-devel
+          - gnutls-devel
+          - gtk3-devel
+          - hostname
+          - libaio-devel
+          - libasan
+          - libattr-devel
+          - libblockdev-mpath-devel
+          - libcap-ng-devel
+          - libcurl-devel
+          - libfdt-devel
+          - libiscsi-devel
+          - libjpeg-devel
+          - libpmem-devel
+          - libpng-devel
+          - librbd-devel
+          - libseccomp-devel
+          - libssh-devel
+          - libubsan
+          - libusbx-devel
+          - libxml2-devel
+          - llvm
+          - lzo-devel
+          - make
+          - mingw32-bzip2
+          - mingw32-curl
+          - mingw32-glib2
+          - mingw32-gmp
+          - mingw32-gnutls
+          - mingw32-gtk3
+          - mingw32-libjpeg-turbo
+          - mingw32-libpng
+          - mingw32-libtasn1
+          - mingw32-nettle
+          - mingw32-nsis
+          - mingw32-pixman
+          - mingw32-pkg-config
+          - mingw32-SDL2
+          - mingw64-bzip2
+          - mingw64-curl
+          - mingw64-glib2
+          - mingw64-gmp
+          - mingw64-gnutls
+          - mingw64-gtk3
+          - mingw64-libjpeg-turbo
+          - mingw64-libpng
+          - mingw64-libtasn1
+          - mingw64-nettle
+          - mingw64-pixman
+          - mingw64-pkg-config
+          - mingw64-SDL2
+          - ncurses-devel
+          - nettle-devel
+          - nss-devel
+          - numactl-devel
+          - perl
+          - perl-Test-Harness
+          - pixman-devel
+          - python3
+          - python3-sphinx
+          - PyYAML
+          - rdma-core-devel
+          - SDL2-devel
+          - snappy-devel
+          - sparse
+          - spice-server-devel
+          - systemd-devel
+          - systemtap-sdt-devel
+          - tar
+          - texinfo
+          - usbredir-devel
+          - virglrenderer-devel
+          - vte291-devel
+          - which
+          - xen-devel
+          - zlib-devel
+          - libzstd-devel
+        state: present
+      when: "ansible_facts['distribution'] == 'Fedora'"
+
+    - name: Install basic packages to build QEMU on CentOS 8
+      dnf:
+        # This matches the packages on tests/docker/Dockerfiles/centos8.docker
+        name:
+          - SDL-devel
+          - bison
+          - bzip2
+          - bzip2-devel
+          - dbus-daemon
+          - flex
+          - gcc
+          - gcc-c++
+          - gettext
+          - git
+          - glib2-devel
+          - libaio-devel
+          - libepoxy-devel
+          - lzo-devel
+          - make
+          - mesa-libEGL-devel
+          - nettle-devel
+          - perl-Test-Harness
+          - pixman-devel
+          - python36
+          - rdma-core-devel
+          - spice-glib-devel
+          - spice-server
+          - tar
+          - zlib-devel
+        state: present
+      when:
+        - "ansible_facts['distribution'] == 'CentOS'"
+        - "ansible_facts['distribution_major_version'] == '8'"
diff --git a/scripts/ci/setup/gitlab-runner.yml b/scripts/ci/setup/gitlab-runner.yml
new file mode 100644
index 0000000000..c2f52dad10
--- /dev/null
+++ b/scripts/ci/setup/gitlab-runner.yml
@@ -0,0 +1,72 @@
+---
+- name: Installation of gitlab-runner
+  hosts: all
+  vars_files:
+    - vars.yml
+  tasks:
+    - debug:
+        msg: 'Checking for a valid GitLab registration token'
+      failed_when: "gitlab_runner_registration_token == 'PLEASE_PROVIDE_A_VALID_TOKEN'"
+
+    - name: Checks the availability of official gitlab-runner builds in the archive
+      uri:
+        url: https://s3.amazonaws.com/gitlab-runner-downloads/v{{ gitlab_runner_version  }}/binaries/gitlab-runner-linux-386
+        method: HEAD
+        status_code:
+          - 200
+          - 403
+      register: gitlab_runner_available_archive
+
+    - name: Update base url
+      set_fact:
+        gitlab_runner_base_url: https://s3.amazonaws.com/gitlab-runner-downloads/v{{ gitlab_runner_version  }}/binaries/gitlab-runner-
+      when: gitlab_runner_available_archive.status == 200
+    - debug:
+        msg: Base gitlab-runner url is {{ gitlab_runner_base_url  }}
+
+    - name: Set OS name (FreeBSD)
+      set_fact:
+        gitlab_runner_os: freebsd
+      when: "ansible_facts['system'] == 'FreeBSD'"
+
+    - name: Create a group for the gitlab-runner service
+      group:
+        name: gitlab-runner
+
+    - name: Create a user for the gitlab-runner service
+      user:
+        user: gitlab-runner
+        group: gitlab-runner
+        comment: GitLab Runner
+        home: /home/gitlab-runner
+        shell: /bin/bash
+
+    - name: Remove the .bash_logout file when on Ubuntu systems
+      file:
+        path: /home/gitlab-runner/.bash_logout
+        state: absent
+      when: "ansible_facts['distribution'] == 'Ubuntu'"
+
+    - name: Downloads the matching gitlab-runner
+      get_url:
+        dest: /usr/local/bin/gitlab-runner
+        url: "{{ gitlab_runner_base_url }}{{ gitlab_runner_os }}-{{ gitlab_runner_arch }}"
+        owner: gitlab-runner
+        group: gitlab-runner
+        mode: u=rwx,g=rwx,o=rx
+
+    - name: Register the gitlab-runner
+      command: "/usr/local/bin/gitlab-runner register --non-interactive --url {{ gitlab_runner_server_url }} --registration-token {{ gitlab_runner_registration_token }} --executor shell  --description '{{ ansible_facts[\"distribution\"] }} {{ ansible_facts[\"distribution_version\"] }} {{ ansible_facts[\"architecture\"] }} ({{ ansible_facts[\"os_family\"] }})'"
+
+    - name: Install the gitlab-runner service using its own functionality
+      command: /usr/local/bin/gitlab-runner install --user gitlab-runner --working-directory /home/gitlab-runner
+      register: gitlab_runner_install_service_result
+      failed_when: "gitlab_runner_install_service_result.rc != 0 and \"already exists\" not in gitlab_runner_install_service_result.stderr"
+      when: "ansible_facts['os_family'] != 'FreeBSD'"
+
+    - name: Enable the gitlab-runner service
+      service:
+        name: gitlab-runner
+        state: started
+        enabled: yes
+      when: "ansible_facts['os_family'] != 'FreeBSD'"
diff --git a/scripts/ci/setup/inventory b/scripts/ci/setup/inventory
new file mode 100644
index 0000000000..8bb7ba6b33
--- /dev/null
+++ b/scripts/ci/setup/inventory
@@ -0,0 +1,2 @@
+[local]
+localhost
diff --git a/scripts/ci/setup/vars.yml b/scripts/ci/setup/vars.yml
new file mode 100644
index 0000000000..621435d030
--- /dev/null
+++ b/scripts/ci/setup/vars.yml
@@ -0,0 +1,13 @@
+# The version of the gitlab-runner to use
+gitlab_runner_version: 13.1.1
+# The base location of gitlab-runner binaries, this will be suffixed by $OS-$ARCH
+gitlab_runner_base_url: https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-
+# The URL of the gitlab server to use, usually https://gitlab.com unless you're
+# using a private GitLab instance
+gitlab_runner_server_url: https://gitlab.com
+# Defaults to linux, checks can be used to change this
+gitlab_runner_os: linux
+# Defaults to amd64 (x86_64), checks can be used to change this
+gitlab_runner_arch: amd64
+# A unique token made available by GitLab to your project for registering runners
+gitlab_runner_registration_token: PLEASE_PROVIDE_A_VALID_TOKEN
-- 
2.25.4


