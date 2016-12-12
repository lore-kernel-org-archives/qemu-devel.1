Received: from eggs.gnu.org ([2001:4830:134:3::10]:40272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edward.shishkin@gmail.com>) id 1cGVCI-0002Aj-Nz
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 13:19:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edward.shishkin@gmail.com>) id 1cGVCF-0003BT-Pd
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 13:19:34 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36861)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edward.shishkin@gmail.com>)
	id 1cGVCF-0003As-Ja
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 13:19:31 -0500
Received: by mail-wm0-f65.google.com with SMTP id m203so12906469wma.3
	for <qemu-devel@nongnu.org>; Mon, 12 Dec 2016 10:19:31 -0800 (PST)
From: edward.shishkin@gmail.com
Date: Mon, 12 Dec 2016 19:15:42 +0100
Message-Id: <1481566542-25894-7-git-send-email-edward.shishkin@gmail.com>
In-Reply-To: <1481566542-25894-1-git-send-email-edward.shishkin@gmail.com>
References: <db578624-4bdd-8d2d-3e18-02f518a6c212@gmail.com>
	<1481566542-25894-1-git-send-email-edward.shishkin@gmail.com>
Subject: [Qemu-devel] [PATCH 7/7] 9p: v9fs fix calculation of max number of
 merged pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Van Hensbergen <ericvh@gmail.com>, V9FS Developers Mailing List <v9fs-developer@lists.sourceforge.net>, Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>
Cc: QEMU Developers Mailing List <qemu-devel@nongnu.org>, ZhangWei <zhangwei555@huawei.com>, Claudio Fontana <Claudio.Fontana@huawei.com>, Greg Kurz <groug@kaod.org>, Alexander Graf <agraf@suse.de>, Eduard Shishkin <eduard.shishkin@huawei.com>

From: Eduard Shishkin <eduard.shishkin@huawei.com>

Don't merge too many pages when composing a 9p message because:
. it doesn't lead to essential performance improvement;
. to not allow user space to allocate big amount of kernel memory.

We use a limit of 256K (for total size of all pages merged per message),
as larger values don't provide any visible speedup.

Signed-off-by: Eduard Shishkin <eduard.shishkin@huawei.com>
---
 fs/9p/v9fs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 58bff9e..50a4034 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -319,6 +319,8 @@ void put_flush_set(struct v9fs_flush_set *fset)
 	kfree(fset);
 }
 
+#define MAX_FLUSH_DATA_SIZE (262144)
+
 /**
  * Allocate and initalize flush set
  * Pre-conditions: valid msize is set
@@ -333,6 +335,11 @@ int alloc_init_flush_set(struct v9fs_session_info *v9ses)
 	if (num_pages < 2)
 		/* speedup impossible */
 		return 0;
+	if (num_pages > (MAX_FLUSH_DATA_SIZE >> PAGE_SHIFT))
+		/*
+		 * no performance gain with larger values
+		 */
+		num_pages = MAX_FLUSH_DATA_SIZE >> PAGE_SHIFT;
 	fset = kzalloc(sizeof(*fset), GFP_KERNEL);
 	if (!fset)
 		goto error;
-- 
2.7.4
