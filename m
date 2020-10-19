Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D7CC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 01:51:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6764F222C3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 01:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E+xqxobl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6764F222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUKL2-00037h-AI
	for qemu-devel@archiver.kernel.org; Sun, 18 Oct 2020 21:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kUKJg-0001ir-Hq
 for qemu-devel@nongnu.org; Sun, 18 Oct 2020 21:50:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28215)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kUKJa-0001Gv-6c
 for qemu-devel@nongnu.org; Sun, 18 Oct 2020 21:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603072220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vQUWv6g5MWCDHehGrOsttrmyoSLaHsUoEVyKO5KtHAI=;
 b=E+xqxobl0pT4NWX7p4LRnQWAQY9xNqvNg4jb77DMA2sBxQpoftvnSOg+j0WVI8KZB4TCPM
 BZD2W8doKQV0nNQjwXgsg8mAyP40XAu27sLlJ+KgVu1Wzsr9FrJ37ji76COgmeefEYxeTt
 mMcysiK8GXaDa4FM/iJz8tScVkTXyIo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-icD7BgBTNLGspYgYr_qrog-1; Sun, 18 Oct 2020 21:50:16 -0400
X-MC-Unique: icD7BgBTNLGspYgYr_qrog-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A36A3879511;
 Mon, 19 Oct 2020 01:50:15 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 448F46EF50;
 Mon, 19 Oct 2020 01:50:14 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v4 2/4] Jobs based on custom runners: build environment docs
 and playbook
Date: Sun, 18 Oct 2020 21:50:01 -0400
Message-Id: <20201019015003.1527746-3-crosa@redhat.com>
In-Reply-To: <20201019015003.1527746-1-crosa@redhat.com>
References: <20201019015003.1527746-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/18 21:50:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Andrea Bolognani <abologna@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To run basic jobs on custom runners, the environment needs to be
properly set up.  The most common requirement is having the right
packages installed.

The playbook introduced here covers a number of different Linux
distributions and FreeBSD, and are intended to provide a reproducible
environment.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 docs/devel/ci.rst                      |  32 ++++
 scripts/ci/setup/build-environment.yml | 233 +++++++++++++++++++++++++
 scripts/ci/setup/inventory             |   2 +
 3 files changed, 267 insertions(+)
 create mode 100644 scripts/ci/setup/build-environment.yml
 create mode 100644 scripts/ci/setup/inventory

diff --git a/docs/devel/ci.rst b/docs/devel/ci.rst
index 41a4bbddad..208b5e399b 100644
--- a/docs/devel/ci.rst
+++ b/docs/devel/ci.rst
@@ -52,3 +52,35 @@ As a general rule, those newly added contributed jobs should run as
 The precise minimum requirements and exact rules for machine
 configuration documentation/scripts, and the success rate of jobs are
 still to be defined.
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
+The ``scripts/ci/setup/build-environment.yml`` Ansible playbook will
+set up machines with the environment needed to perform builds and run
+QEMU tests.  It covers a number of different Linux distributions and
+FreeBSD.
+
+To run the playbook, execute::
+
+  cd scripts/ci/setup
+  ansible-playbook -i inventory build-environment.yml
diff --git a/scripts/ci/setup/build-environment.yml b/scripts/ci/setup/build-environment.yml
new file mode 100644
index 0000000000..074aaca927
--- /dev/null
+++ b/scripts/ci/setup/build-environment.yml
@@ -0,0 +1,233 @@
+---
+- name: Installation of basic packages to build QEMU
+  hosts: all
+  tasks:
+    - name: Install basic packages to build QEMU on Ubuntu 18.04/20.04
+      apt:
+        update_cache: yes
+        # Originally from tests/docker/dockerfiles/ubuntu1804.docker
+        pkg:
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
+          - ninja-build
+          - python3-yaml
+          - python3-sphinx
+          - sparse
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
+        # Originally from packages on .cirrus.yml under the freebsd_12_task
+        name: bash,curl,cyrus-sasl,git,glib,gmake,gnutls,gsed,nettle,ninja,perl5,pixman,pkgconf,png,usbredir
+        state: present
+      when: "ansible_facts['os_family'] == 'FreeBSD'"
+
+    - name: Install basic packages to build QEMU on Fedora 30, 31 and 32
+      dnf:
+        # Originally from tests/docker/dockerfiles/fedora.docker
+        name:
+          - SDL2-devel
+          - bc
+          - brlapi-devel
+          - bzip2
+          - bzip2-devel
+          - ccache
+          - clang
+          - cyrus-sasl-devel
+          - dbus-daemon
+          - device-mapper-multipath-devel
+          - diffutils
+          - findutils
+          - gcc
+          - gcc-c++
+          - genisoimage
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
+          - libepoxy-devel
+          - libfdt-devel
+          - libiscsi-devel
+          - libjpeg-devel
+          - libpmem-devel
+          - libpng-devel
+          - librbd-devel
+          - libseccomp-devel
+          - libssh-devel
+          - libubsan
+          - libudev-devel
+          - libusbx-devel
+          - libxml2-devel
+          - libzstd-devel
+          - llvm
+          - lzo-devel
+          - make
+          - mingw32-SDL2
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
+          - mingw64-SDL2
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
+          - ncurses-devel
+          - nettle-devel
+          - ninja-build
+          - nss-devel
+          - numactl-devel
+          - perl
+          - perl-Test-Harness
+          - pixman-devel
+          - python3
+          - python3-PyYAML
+          - python3-numpy
+          - python3-opencv
+          - python3-pillow
+          - python3-pip
+          - python3-sphinx
+          - python3-virtualenv
+          - rdma-core-devel
+          - snappy-devel
+          - sparse
+          - spice-server-devel
+          - systemd-devel
+          - systemtap-sdt-devel
+          - tar
+          - tesseract
+          - tesseract-langpack-eng
+          - usbredir-devel
+          - virglrenderer-devel
+          - vte291-devel
+          - which
+          - xen-devel
+          - zlib-devel
+        state: present
+      when: "ansible_facts['distribution'] == 'Fedora'"
+
+    - name: Enable PowerTools repo on CentOS 8
+      ini_file:
+        path: /etc/yum.repos.d/CentOS-PowerTools.repo
+        section: PowerTools
+        option: enabled
+        value: "1"
+      when:
+        - "ansible_facts['distribution'] == 'CentOS'"
+        - "ansible_facts['distribution_major_version'] == '8'"
+
+    - name: Install basic packages to build QEMU on CentOS 8
+      dnf:
+        # Originally from tests/docker/dockerfiles/centos8.docker
+        name:
+          - SDL-devel
+          - bzip2
+          - bzip2-devel
+          - dbus-daemon
+          - gcc
+          - gcc-c++
+          - genisoimage
+          - gettext
+          - git
+          - glib2-devel
+          - libaio-devel
+          - libepoxy-devel
+          - libgcrypt-devel
+          - lzo-devel
+          - make
+          - mesa-libEGL-devel
+          - nettle-devel
+          - ninja-build
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
diff --git a/scripts/ci/setup/inventory b/scripts/ci/setup/inventory
new file mode 100644
index 0000000000..8bb7ba6b33
--- /dev/null
+++ b/scripts/ci/setup/inventory
@@ -0,0 +1,2 @@
+[local]
+localhost
-- 
2.25.4


