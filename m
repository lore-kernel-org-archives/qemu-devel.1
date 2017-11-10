Received: from eggs.gnu.org ([2001:4830:134:3::10]:34278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eDCAY-0007so-B6
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 11:28:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eDCAV-0003Kx-8B
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 11:28:38 -0500
Date: Fri, 10 Nov 2017 17:28:21 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171110162821.GH5466@localhost.localdomain>
References: <20171103144113.7188-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171103144113.7188-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qcow2: fix image corruption after
 committing qcow2 image into base
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 03.11.2017 um 15:41 hat Daniel P. Berrange geschrieben:
> After committing the qcow2 image contents into the base image, qemu-img
> will call bdrv_make_empty to drop the payload in the layered image.
> 
> When this is done for qcow2 images, it blows away the LUKS encryption
> header, making the resulting image unusable. There are two codepaths
> for emptying a qcow2 image, and the second (slower) codepaths leaves
> the LUKS header intact, so force use of that codepath.
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
> 
> NB, ideally we would fix the faster codepath in make_completely_empty, but
> having looked at the code, I've really no idea how to even start on fixing that
> to not kill the LUKS header clusters.
> 
>  block/qcow2.c                    |   3 +-
>  tests/qemu-iotests/198           | 104 +++++++++++++++++++++++++++++++
>  tests/qemu-iotests/198.out       | 128 +++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/common.filter |   4 +-
>  tests/qemu-iotests/group         |   1 +
>  5 files changed, 238 insertions(+), 2 deletions(-)
>  create mode 100755 tests/qemu-iotests/198
>  create mode 100644 tests/qemu-iotests/198.out

The test fails for me. Looks like we need some filtering.

Kevin


--- /home/kwolf/source/qemu/tests/qemu-iotests/198.out  2017-11-10 17:23:54.484003430 +0100
+++ /home/kwolf/source/qemu/tests/qemu-iotests/198.out.bad      2017-11-10 17:26:54.914932949 +0100
@@ -35,7 +35,7 @@
 image: json:{"encrypt.key-secret": "sec0", "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT.base"}}
 file format: IMGFMT
 virtual size: 16M (16777216 bytes)
-disk size: 17M
+disk size: 33M
 Format specific information:
     compat: 1.1
     lazy refcounts: false
@@ -82,7 +82,7 @@
 image: json:{"encrypt.key-secret": "sec1", "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}}
 file format: IMGFMT
 virtual size: 16M (16777216 bytes)
-disk size: 548K
+disk size: 17M
 backing file: TEST_DIR/t.IMGFMT.base
 Format specific information:
     compat: 1.1
Failures: 198
Failed 1 of 1 tests
