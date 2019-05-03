Received: from eggs.gnu.org ([209.51.188.92]:37716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMMGu-0003cQ-8m
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:41:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMMGt-0006m8-6Y
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:41:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hMMGs-0006lr-Ux
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:41:51 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu,  2 May 2019 21:41:17 -0300
Message-Id: <20190503004130.8285-7-ehabkost@redhat.com>
In-Reply-To: <20190503004130.8285-1-ehabkost@redhat.com>
References: <20190503004130.8285-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 06/19] tests/acceptance: look for target
 architecture in test tags first
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>

From: Cleber Rosa <crosa@redhat.com>

A test can, optionally, be tagged for one or many architectures.  If a
test has been tagged for a single architecture, there's a high chance
that the test won't run on other architectures.  This changes the
default order of choosing a default target architecture to use based
on the 'arch' tag value first.

The precedence order is for choosing a QEMU binary to use for a test
is now:

 * qemu_bin parameter
 * arch parameter
 * arch tag value (for example, x86_64 if ":avocado: tags=arch:x86_64
   is used)

This means that if one runs:

 $ avocado run -p qemu_bin=/usr/bin/qemu-system-x86_64 test.py

No arch parameter or tag will influence the selection of the QEMU
target binary.  If one runs:

 $ avocado run -p arch=ppc64 test.py

The target binary selection mechanism will attempt to find a binary
such as "ppc64-softmmu/qemu-system-ppc64".  And finally, if one runs
a test that is tagged (in its docstring) with "arch:aarch64":

 $ avocado run aarch64.py

The target binary selection mechanism will attempt to find a binary
such as "aarch64-softmmu/qemu-system-aarch64".

At this time, no provision is made to cancel the execution of tests if
the arch parameter given (manually) does not match the test "arch"
tag, but it may be a useful default behavior to be added in the
future.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20190312171824.5134-7-crosa@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 docs/devel/testing.rst                    | 4 +++-
 tests/acceptance/avocado_qemu/__init__.py | 7 ++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index 83bf9f09ac..da2d0fc964 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -740,7 +740,9 @@ A test may, for instance, use the same value when selecting the
 architecture of a kernel or disk image to boot a VM with.
 
 The ``arch`` attribute will be set to the test parameter of the same
-name, and if one is not given explicitly, it will be set to ``None``.
+name.  If one is not given explicitly, it will either be set to
+``None``, or, if the test is tagged with one (and only one)
+``:avocado: tags=arch:VALUE`` tag, it will be set to ``VALUE``.
 
 qemu_bin
 ~~~~~~~~
diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/avocado_qemu/__init__.py
index 688a0746a2..2b236a1cf0 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -53,7 +53,12 @@ def pick_default_qemu_bin(arch=None):
 class Test(avocado.Test):
     def setUp(self):
         self._vms = {}
-        self.arch = self.params.get('arch')
+        arches = self.tags.get('arch', [])
+        if len(arches) == 1:
+            arch = arches.pop()
+        else:
+            arch = None
+        self.arch = self.params.get('arch', default=arch)
         default_qemu_bin = pick_default_qemu_bin(arch=self.arch)
         self.qemu_bin = self.params.get('qemu_bin',
                                         default=default_qemu_bin)
-- 
2.18.0.rc1.1.g3f1ff2140
