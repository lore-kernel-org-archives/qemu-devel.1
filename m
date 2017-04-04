Received: from eggs.gnu.org ([2001:4830:134:3::10]:58426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cvSms-0005Tj-5u
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 14:02:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cvSmn-0000dz-7U
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 14:02:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcody@redhat.com>) id 1cvSmm-0000cI-VO
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 14:02:33 -0400
Date: Tue, 4 Apr 2017 14:02:28 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170404180228.GR15423@localhost.localdomain>
References: <1491277689-24949-1-git-send-email-Ashish.Mittal@veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1491277689-24949-1-git-send-email-Ashish.Mittal@veritas.com>
Subject: Re: [Qemu-devel] [PATCH v11 0/2] block/vxhs.c: Add support for a
 new block device type called "vxhs"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashish Mittal <ashmit602@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, kwolf@redhat.com, armbru@redhat.com, berrange@redhat.com, famz@redhat.com, ashish.mittal@veritas.com, stefanha@gmail.com, Ketan.Nilangekar@veritas.com, jferlan@redhat.com, Buddhi.Madhav@veritas.com, Suraj.Singh@veritas.com, Nitin.Jerath@veritas.com, peter.maydell@linaro.org, venkatesha.mg@veritas.com, Rakesh.Ranjan@veritas.com, eblake@redhat.com, Abhijit.Dey@veritas.com

On Mon, Apr 03, 2017 at 08:48:07PM -0700, Ashish Mittal wrote:
> - Veritas HyperScale block driver in QEMU is designed to provide an accelerated
>   IO path from KVM virtual machines to Veritas HyperScale storage service.
> 
> - A network IO transfer library that translates block IO from HyperScale block
>   driver to a network IO format to send it to Veritas HyperScale storage
>   service. This library (libvxhs) has been open sourced and is available on
>   github here:  https://github.com/VeritasHyperScale/libqnio.git
> 
> Ashish Mittal (2):
>   block/vxhs.c: Add support for a new block device type called "vxhs"
>   block/vxhs.c: Add qemu-iotests for new block device type "vxhs"
> 
>  block/Makefile.objs              |   2 +
>  block/trace-events               |  17 ++
>  block/vxhs.c                     | 575 +++++++++++++++++++++++++++++++++++++++
>  configure                        |  39 +++
>  qapi/block-core.json             |  23 +-
>  tests/qemu-iotests/common        |   6 +
>  tests/qemu-iotests/common.config |  13 +
>  tests/qemu-iotests/common.filter |   1 +
>  tests/qemu-iotests/common.rc     |  19 ++
>  9 files changed, 693 insertions(+), 2 deletions(-)
>  create mode 100644 block/vxhs.c
> 
> -- 
> 2.5.5
>

With this additional patch (below), this passes all qemu-iotests for qcow2.


>From aeea8e23e28de325c572f8f3f67a1651b62887bd Mon Sep 17 00:00:00 2001
Message-Id: <aeea8e23e28de325c572f8f3f67a1651b62887bd.1491328865.git.jcody@redhat.com>
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 14 Feb 2017 09:51:42 -0500
Subject: [PATCH v10 3/2 1/1] qemu-iotests: exclude vxhs from image creation
 via protocol

The protocol VXHS does not support image creation.  Some tests expect
to be able to create images through the protocol.  Exclude VXHS from
these tests.

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 tests/qemu-iotests/017 | 1 +
 tests/qemu-iotests/020 | 1 +
 tests/qemu-iotests/029 | 1 +
 tests/qemu-iotests/073 | 1 +
 tests/qemu-iotests/114 | 1 +
 tests/qemu-iotests/130 | 1 +
 tests/qemu-iotests/134 | 1 +
 tests/qemu-iotests/156 | 1 +
 tests/qemu-iotests/158 | 1 +
 9 files changed, 9 insertions(+)

diff --git a/tests/qemu-iotests/017 b/tests/qemu-iotests/017
index e3f9e75..4f9302d 100755
--- a/tests/qemu-iotests/017
+++ b/tests/qemu-iotests/017
@@ -41,6 +41,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # Any format supporting backing files
 _supported_fmt qcow qcow2 vmdk qed
 _supported_proto generic
+_unsupported_proto vxhs
 _supported_os Linux
 _unsupported_imgopts "subformat=monolithicFlat" "subformat=twoGbMaxExtentFlat"
 
diff --git a/tests/qemu-iotests/020 b/tests/qemu-iotests/020
index 9c4a68c..7a11110 100755
--- a/tests/qemu-iotests/020
+++ b/tests/qemu-iotests/020
@@ -43,6 +43,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # Any format supporting backing files
 _supported_fmt qcow qcow2 vmdk qed
 _supported_proto generic
+_unsupported_proto vxhs
 _supported_os Linux
 _unsupported_imgopts "subformat=monolithicFlat" \
                      "subformat=twoGbMaxExtentFlat" \
diff --git a/tests/qemu-iotests/029 b/tests/qemu-iotests/029
index e639ac0..30bab24 100755
--- a/tests/qemu-iotests/029
+++ b/tests/qemu-iotests/029
@@ -42,6 +42,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # Any format supporting intenal snapshots
 _supported_fmt qcow2
 _supported_proto generic
+_unsupported_proto vxhs
 _supported_os Linux
 # Internal snapshots are (currently) impossible with refcount_bits=1
 _unsupported_imgopts 'refcount_bits=1[^0-9]'
diff --git a/tests/qemu-iotests/073 b/tests/qemu-iotests/073
index ad37a61..40f85b1 100755
--- a/tests/qemu-iotests/073
+++ b/tests/qemu-iotests/073
@@ -39,6 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto generic
+_unsupported_proto vxhs
 _supported_os Linux
 
 CLUSTER_SIZE=64k
diff --git a/tests/qemu-iotests/114 b/tests/qemu-iotests/114
index f110d4f..5b7dc54 100755
--- a/tests/qemu-iotests/114
+++ b/tests/qemu-iotests/114
@@ -39,6 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto generic
+_unsupported_proto vxhs
 _supported_os Linux
 
 
diff --git a/tests/qemu-iotests/130 b/tests/qemu-iotests/130
index ecc8a5b..f941fc9 100755
--- a/tests/qemu-iotests/130
+++ b/tests/qemu-iotests/130
@@ -42,6 +42,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto generic
+_unsupported_proto vxhs
 _supported_os Linux
 
 qemu_comm_method="monitor"
diff --git a/tests/qemu-iotests/134 b/tests/qemu-iotests/134
index af618b8..acce946 100755
--- a/tests/qemu-iotests/134
+++ b/tests/qemu-iotests/134
@@ -39,6 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto generic
+_unsupported_proto vxhs
 _supported_os Linux
 
 
diff --git a/tests/qemu-iotests/156 b/tests/qemu-iotests/156
index cc95ff1..78deaff 100755
--- a/tests/qemu-iotests/156
+++ b/tests/qemu-iotests/156
@@ -48,6 +48,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2 qed
 _supported_proto generic
+_unsupported_proto vxhs
 _supported_os Linux
 
 # Create source disk
diff --git a/tests/qemu-iotests/158 b/tests/qemu-iotests/158
index a6cdd6d..ef8d70f 100755
--- a/tests/qemu-iotests/158
+++ b/tests/qemu-iotests/158
@@ -39,6 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto generic
+_unsupported_proto vxhs
 _supported_os Linux
 
 
-- 
2.9.3
