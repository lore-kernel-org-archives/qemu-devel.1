Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC56C2BB1D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:40:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D03C206E9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JH1rP0O7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D03C206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCTgp-0007Xx-7Q
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 15:40:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1jCTdj-0007Vl-8j
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:37:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1jCTdf-0007tO-8K
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:37:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59095
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1jCTdf-0007tE-2c
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:37:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584041822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q6A6a2hxXlqqiYzbdM/gqVm92XQIxhN3NPrL/ps8Ryk=;
 b=JH1rP0O7qhC+hEZZU/kMBShw82ScZHm4bIElqdqIRZ1Nj1GI399kd92WuKVA5/wMHq1k0v
 qWEtXEs7W30S9VdiMnrmoYgorgqL89UNsYqH+S4T37s65xEetcVemnacJtg9E6daY9Zvly
 zwk4KxwjQcicdrrqiFEuo6in08O5rUU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-DhRmXr5oPpm3AkOyk-losw-1; Thu, 12 Mar 2020 15:36:57 -0400
X-MC-Unique: DhRmXr5oPpm3AkOyk-losw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D1C81013CF8;
 Thu, 12 Mar 2020 19:36:56 +0000 (UTC)
Received: from dhcp-17-173.bos.redhat.com (dhcp-17-173.bos.redhat.com
 [10.18.17.173])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 558D65C1B5;
 Thu, 12 Mar 2020 19:36:55 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Subject: [PATCH 5/5] GitLab Gating CI: initial set of jobs,
 documentation and scripts
Date: Thu, 12 Mar 2020 15:36:16 -0400
Message-Id: <20200312193616.438922-6-crosa@redhat.com>
In-Reply-To: <20200312193616.438922-1-crosa@redhat.com>
References: <20200312193616.438922-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 Wainer Moschetta <wmoschet@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a mapping of Peter's "remake-merge-builds" and
"pull-buildtest" scripts, gone through some updates, adding some build
option and removing others.

To add to some of the diversity of platforms that QEMU covers, this
initial set of jobs require three machines:

 - Ubuntu 18.04
 - Fedora 30
 - FreeBSD 12.1

All jobs have been marked as x86_64, but others can be introduced with
different architectures.  During the development of this set of jobs,
the GitLab CI was tested with many other architectures, including
ppc64, s390x and aarch64.

More information can be found in the documentation itself.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 .gitlab-ci-gating.yml                      | 111 +++++++++++
 .gitlab-ci.yml                             |  15 ++
 contrib/ci/orgs/qemu/build-environment.yml | 208 +++++++++++++++++++++
 contrib/ci/orgs/qemu/gitlab-runner.yml     |  65 +++++++
 contrib/ci/orgs/qemu/inventory             |   2 +
 contrib/ci/orgs/qemu/vars.yml              |  13 ++
 docs/devel/testing.rst                     | 142 ++++++++++++++
 7 files changed, 556 insertions(+)
 create mode 100644 .gitlab-ci-gating.yml
 create mode 100644 contrib/ci/orgs/qemu/build-environment.yml
 create mode 100644 contrib/ci/orgs/qemu/gitlab-runner.yml
 create mode 100644 contrib/ci/orgs/qemu/inventory
 create mode 100644 contrib/ci/orgs/qemu/vars.yml

diff --git a/.gitlab-ci-gating.yml b/.gitlab-ci-gating.yml
new file mode 100644
index 0000000000..4c6010bcc4
--- /dev/null
+++ b/.gitlab-ci-gating.yml
@@ -0,0 +1,111 @@
+variables:
+  GIT_SUBMODULE_STRATEGY: recursive
+
+# All ubuntu-18.04.3 jobs should run successfully in an environment
+# setup by the contrib/ci/orgs/qemu/build-environment.yml task
+# "Install basic packages to build QEMU on Ubuntu 18.04"
+ubuntu-18.04.3-x86_64-all-linux-static:
+ tags:
+ - ubuntu_18.04.3
+ - x86_64
+ rules:
+ - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
+ script:
+ # --disable-libssh is needed because of https://bugs.launchpad.net/qemu/+=
bug/1838763
+ # --disable-glusterfs is needed because there's no static version of thos=
e libs in distro supplied packages
+ - ./configure --enable-debug --static --disable-system --disable-glusterf=
s --disable-libssh
+ - make --output-sync -j`nproc`
+ - make --output-sync -j`nproc` check V=3D1
+ - make --output-sync -j`nproc` check-tcg V=3D1
+
+ubuntu-18.04.3-x86_64-all:
+ tags:
+ - ubuntu_18.04.3
+ - x86_64
+ rules:
+ - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
+ script:
+ - ./configure --disable-libssh
+ - make --output-sync -j`nproc`
+ - make --output-sync -j`nproc` check V=3D1
+
+ubuntu-18.04.3-x86_64-alldbg:
+ tags:
+ - ubuntu_18.04.3
+ - x86_64
+ rules:
+ - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
+ script:
+ - ./configure --enable-debug --disable-libssh
+ - make clean
+ - make --output-sync -j`nproc`
+ - make --output-sync -j`nproc` check V=3D1
+
+ubuntu-18.04.3-x86_64-clang:
+ tags:
+ - ubuntu_18.04.3
+ - x86_64
+ rules:
+ - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
+ script:
+ - ./configure --disable-libssh --cc=3Dclang --cxx=3Dclang++ --enable-sani=
tizers
+ - make --output-sync -j`nproc`
+ - make --output-sync -j`nproc` check V=3D1
+
+ubuntu-18.04.3-x86_64-tci:
+ tags:
+ - ubuntu_18.04.3
+ - x86_64
+ rules:
+ - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
+ script:
+ - ./configure --disable-libssh --enable-tcg-interpreter
+ - make --output-sync -j`nproc`
+
+ubuntu-18.04.3-x86_64-notcg:
+ tags:
+ - ubuntu_18.04.3
+ - x86_64
+ rules:
+ - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
+ script:
+ - ./configure --disable-libssh --disable-tcg
+ - make --output-sync -j`nproc`
+ - make --output-sync -j`nproc` check V=3D1
+
+# All fedora-30 jobs should run successfully in an environment
+# setup by the contrib/ci/orgs/qemu/build-environment.yml task
+# "Install basic packages to build QEMU on Fedora 30"
+fedora-30-x86_64-cross-w32:
+ tags:
+ - fedora_30
+ - x86_64
+ rules:
+ - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
+ script:
+ - ./configure --cross-prefix=3Di686-w64-mingw32-
+ - make --output-sync -j`nproc`
+
+fedora-30-x86_64-cross-w64:
+ tags:
+ - fedora_30
+ - x86_64
+ rules:
+ - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
+ script:
+ - ./configure --cross-prefix=3Dx86_64-w64-mingw32-
+ - make --output-sync -j`nproc`
+
+# All freebsd_12.1 jobs should run successfully in an environment
+# setup by the contrib/ci/orgs/qemu/build-environment.yml task
+# "Install basic packages to build QEMU on FreeBSD 12.x"
+freebsd-12.1-x86_64-all:
+ tags:
+ - freebsd_12.1
+ - x86_64
+ rules:
+ - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
+ script:
+ - ./configure
+ - gmake --output-sync -j`sysctl -n hw.ncpu`
+ - gmake --output-sync -j`sysctl -n hw.ncpu` check V=3D1
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 3ef1551273..8c51672dc1 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -1,7 +1,10 @@
 include:
   - local: '/.gitlab-ci-edk2.yml'
+  - local: '/.gitlab-ci-gating.yml'
=20
 build-system1:
+ rules:
+ - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
  before_script: &before_scr_apt
  - apt-get update -qq
  - apt-get install -y -qq flex bison libglib2.0-dev libpixman-1-dev geniso=
image
@@ -17,6 +20,8 @@ build-system1:
  - make -j2 check
=20
 build-system2:
+ rules:
+ - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
  before_script:
   *before_scr_apt
  script:
@@ -32,6 +37,8 @@ build-system2:
  - make -j2 check
=20
 build-disabled:
+ rules:
+ - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
  before_script:
   *before_scr_apt
  script:
@@ -48,6 +55,8 @@ build-disabled:
  - make -j2 check-qtest SPEED=3Dslow
=20
 build-tcg-disabled:
+ rules:
+ - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
  before_script:
   *before_scr_apt
  script:
@@ -68,6 +77,8 @@ build-tcg-disabled:
             260 261 262 263 264 270 272 273 277 279
=20
 build-user:
+ rules:
+ - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
  before_script:
   *before_scr_apt
  script:
@@ -79,6 +90,8 @@ build-user:
  - make run-tcg-tests-i386-linux-user run-tcg-tests-x86_64-linux-user
=20
 build-clang:
+ rules:
+ - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
  before_script:
   *before_scr_apt
  script:
@@ -93,6 +106,8 @@ build-clang:
  - make -j2 check
=20
 build-tci:
+ rules:
+ - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
  before_script:
   *before_scr_apt
  script:
diff --git a/contrib/ci/orgs/qemu/build-environment.yml b/contrib/ci/orgs/q=
emu/build-environment.yml
new file mode 100644
index 0000000000..ea839ded4c
--- /dev/null
+++ b/contrib/ci/orgs/qemu/build-environment.yml
@@ -0,0 +1,208 @@
+---
+- name: Installation of basic packages to build QEMU
+  hosts: all
+  vars_files:
+    - vars.yml
+  tasks:
+    - name: Install basic packages to build QEMU on Ubuntu 18.04
+      apt:
+        update_cache: yes
+        # This matches the packages on tests/docker/Dockerfiles/ubuntu1804=
.docker
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
+          - libspice-server-dev
+          - libssh-dev
+          - libusb-1.0-0-dev
+          - libusbredirhost-dev
+          - libvdeplug-dev
+          - libvte-2.91-dev
+          - libxen-dev
+          - libzstd-dev
+          - make
+          - python3-yaml
+          - python3-sphinx
+          - sparse
+          - texinfo
+          - xfslibs-dev
+        state: present
+      when: "ansible_facts['distribution'] =3D=3D 'Ubuntu'"
+
+    - name: Install basic packages to build QEMU on FreeBSD 12.x
+      pkgng:
+        # This matches the packages on .cirrus.yml under the freebsd_12_ta=
sk
+        name: bash,bison,curl,cyrus-sasl,git,glib,gmake,gnutls,gsed,nettle=
,perl5,pixman,pkgconf,png,usbredir
+        state: present
+      when: "ansible_facts['os_family'] =3D=3D 'FreeBSD'"
+
+    - name: Install basic packages to build QEMU on Fedora 30
+      dnf:
+        # This matches the packages on tests/docker/Dockerfiles/fedora.doc=
ker
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
+      when: "ansible_facts['distribution'] =3D=3D 'Fedora'"
+
+    - name: Install basic packages to build QEMU on CentOS 8
+      dnf:
+        # This matches the packages on tests/docker/Dockerfiles/centos8.do=
cker
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
+        - "ansible_facts['distribution'] =3D=3D 'CentOS'"
+        - "ansible_facts['distribution_major_version'] =3D=3D '8'"
diff --git a/contrib/ci/orgs/qemu/gitlab-runner.yml b/contrib/ci/orgs/qemu/=
gitlab-runner.yml
new file mode 100644
index 0000000000..19dc31a299
--- /dev/null
+++ b/contrib/ci/orgs/qemu/gitlab-runner.yml
@@ -0,0 +1,65 @@
+---
+- name: Installation of gitlab-runner
+  hosts: all
+  vars_files:
+    - vars.yml
+  tasks:
+    - debug:
+        msg: 'Checking for a valid GitLab registration token'
+      failed_when: "gitlab_runner_registration_token =3D=3D 'PLEASE_PROVID=
E_A_VALID_TOKEN'"
+
+    - name: Checks the availability of official gitlab-runner builds in th=
e archive
+      uri:
+        url: https://s3.amazonaws.com/gitlab-runner-downloads/v{{ gitlab_r=
unner_version  }}/binaries/gitlab-runner-linux-386
+        method: HEAD
+        status_code:
+          - 200
+          - 403
+      register: gitlab_runner_available_archive
+
+    - name: Update base url
+      set_fact:
+        gitlab_runner_base_url: https://s3.amazonaws.com/gitlab-runner-dow=
nloads/v{{ gitlab_runner_version  }}/binaries/gitlab-runner-
+      when: gitlab_runner_available_archive.status =3D=3D 200
+    - debug:
+        msg: Base gitlab-runner url is {{ gitlab_runner_base_url  }}
+
+    - name: Set OS name (FreeBSD)
+      set_fact:
+        gitlab_runner_os: freebsd
+      when: "ansible_facts['system'] =3D=3D 'FreeBSD'"
+
+    - name: Create a group for the gitlab-runner service
+      group:
+        name: gitlab-runner
+    - name: Create a user for the gitlab-runner service
+      user:
+        user: gitlab-runner
+        group: gitlab-runner
+        comment: GitLab Runner
+        home: /home/gitlab-runner
+        shell: /bin/bash
+
+    - name: Downloads the matching gitlab-runner
+      get_url:
+        dest: /usr/local/bin/gitlab-runner
+        url: "{{ gitlab_runner_base_url }}{{ gitlab_runner_os }}-{{ gitlab=
_runner_arch }}"
+        owner: gitlab-runner
+        group: gitlab-runner
+        mode: u=3Drwx,g=3Drwx,o=3Drx
+
+    - name: Register the gitlab-runner
+      command: "/usr/local/bin/gitlab-runner register --non-interactive --=
url {{ gitlab_runner_server_url }} --registration-token {{ gitlab_runner_re=
gistration_token }} --executor shell  --description '{{ ansible_facts[\"dis=
tribution\"] }} {{ ansible_facts[\"distribution_version\"] }} {{ ansible_fa=
cts[\"architecture\"] }} ({{ ansible_facts[\"os_family\"] }})'"
+
+    - name: Install the gitlab-runner service using its own functionality
+      command: /usr/local/bin/gitlab-runner install --user gitlab-runner -=
-working-directory /home/gitlab-runner
+      register: gitlab_runner_install_service_result
+      failed_when: "gitlab_runner_install_service_result.rc !=3D 0 and \"a=
lready exists\" not in gitlab_runner_install_service_result.stderr"
+      when: "ansible_facts['os_family'] !=3D 'FreeBSD'"
+
+    - name: Enable the gitlab-runner service
+      service:
+        name: gitlab-runner
+        state: started
+        enabled: yes
+      when: "ansible_facts['os_family'] !=3D 'FreeBSD'"
diff --git a/contrib/ci/orgs/qemu/inventory b/contrib/ci/orgs/qemu/inventor=
y
new file mode 100644
index 0000000000..8bb7ba6b33
--- /dev/null
+++ b/contrib/ci/orgs/qemu/inventory
@@ -0,0 +1,2 @@
+[local]
+localhost
diff --git a/contrib/ci/orgs/qemu/vars.yml b/contrib/ci/orgs/qemu/vars.yml
new file mode 100644
index 0000000000..0095851172
--- /dev/null
+++ b/contrib/ci/orgs/qemu/vars.yml
@@ -0,0 +1,13 @@
+# The version of the gitlab-runner to use
+gitlab_runner_version: 12.8.0
+# The base location of gitlab-runner binaries, this will be suffixed by $O=
S-$ARCH
+gitlab_runner_base_url: https://gitlab-runner-downloads.s3.amazonaws.com/l=
atest/binaries/gitlab-runner-
+# The URL of the gitlab server to use, usually https://gitlab.com unless y=
ou're
+# using a private GitLab instance
+gitlab_runner_server_url: https://gitlab.com
+# Defaults to linux, checks can be used to change this
+gitlab_runner_os: linux
+# Defaults to amd64 (x86_64), checks can be used to change this
+gitlab_runner_arch: amd64
+# A unique token made available by GitLab to your project for registering =
runners
+gitlab_runner_registration_token: PLEASE_PROVIDE_A_VALID_TOKEN
diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index 770a987ea4..6f8e04e079 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -896,3 +896,145 @@ exercise as many corner cases as possible. It is a us=
eful test suite
 to run to exercise QEMU's linux-user code::
=20
   https://linux-test-project.github.io/
+
+CI
+=3D=3D
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
+  contrib/ci/orgs/qemu
+
+Ansible playbooks have been provided to perform two different tasks
+related to setting gitlab-runner and the build environment.
+
+Other organizations involved in QEMU development may, in the near
+future, contribute their own setup documentation/scripts under
+``contrib/ci/orgs/$ORG_NAME`` directory.
+
+The GitLab CI jobs definition for the gating jobs are located under::
+
+  .gitlab-ci-gating.yml
+
+It's expected that these will be moved to a ``.gitlab-ci.d/``
+directory shortly.  Once the gating CI has proved mature with this set
+of initial jobs, other members in the community may provide their own
+machine configuration documentation/scripts, and accompanying job
+definitions.  Those contributed jobs should run as non-gating, until
+their reliability is verified.
+
+Machine Setup Howto
+-------------------
+
+For all Linux based systems, the setup can be mostly automated by the
+execution of two Ansible playbooks.  Start by adding your machines to
+the ``inventory`` file under ``contrib/ci/orgs/qemu``, such as this::
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
+  fully.qualified.domain ansible_python_interpreter=3D/usr/bin/python3
+  other.machine.hostname ansible_python_interpreter=3D/usr/bin/python3
+
+Build environment
+~~~~~~~~~~~~~~~~~
+
+The ``contrib/ci/orgs/qemu/build-environment.yml`` Ansible playbook
+will setup machines with the environment needed to perform builds of
+QEMU and runs of the tests defined in the current gating jobs.  It
+covers a number of different Linux distributions and FreeBSD.
+
+To run the playbook, execute::
+
+  cd contrib/ci/orgs/qemu
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
+Edit the ``contrib/ci/orgs/qemu/vars.yml`` file, setting the
+``gitlab_runner_registration_token`` variable to the value obtained
+earlier.
+
+To run the playbook, execute::
+
+  cd contrib/ci/orgs/qemu
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
+Because the job definition at ``.gitlab-ci-gating.yml`` contains::
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
--=20
2.24.1


