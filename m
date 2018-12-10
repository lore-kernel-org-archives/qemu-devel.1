Received: from eggs.gnu.org ([2001:4830:134:3::10]:54727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gWJiQ-0007Om-TU
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 06:27:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gWJiM-00066w-6g
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 06:27:10 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Dec 2018 11:26:47 +0000
Message-Id: <20181210112649.11581-2-peter.maydell@linaro.org>
In-Reply-To: <20181210112649.11581-1-peter.maydell@linaro.org>
References: <20181210112649.11581-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/3] block/vpc: Don't take address of fields in
 packed structs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ben Warren <ben@skyportsystems.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Weil <sw@weilnetz.de>

Taking the address of a field in a packed struct is a bad idea, because
it might not be actually aligned enough for that pointer type (and
thus cause a crash on dereference on some host architectures). Newer
versions of clang warn about this. Avoid the bug by generating the
UUID into a local variable which is definitely safely aligned and
then copying it into place.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 block/vpc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/vpc.c b/block/vpc.c
index 80c5b2b197e..968d80ae461 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -979,6 +979,7 @@ static int coroutine_fn vpc_co_create(BlockdevCreateOptions *opts,
     int64_t total_size;
     int disk_type;
     int ret = -EIO;
+    QemuUUID uuid;
 
     assert(opts->driver == BLOCKDEV_DRIVER_VPC);
     vpc_opts = &opts->u.vpc;
@@ -1062,7 +1063,8 @@ static int coroutine_fn vpc_co_create(BlockdevCreateOptions *opts,
 
     footer->type = cpu_to_be32(disk_type);
 
-    qemu_uuid_generate(&footer->uuid);
+    qemu_uuid_generate(&uuid);
+    footer->uuid = uuid;
 
     footer->checksum = cpu_to_be32(vpc_checksum(buf, HEADER_SIZE));
 
-- 
2.19.2
