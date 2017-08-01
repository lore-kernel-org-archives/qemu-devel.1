Received: from eggs.gnu.org ([2001:4830:134:3::10]:47601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dcX2T-0001f9-Mm
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 09:16:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dcX2S-0005V9-L1
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 09:16:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:62432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dcX2S-0005Us-Eu
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 09:16:44 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue,  1 Aug 2017 14:16:14 +0100
Message-Id: <20170801131618.27332-6-stefanha@redhat.com>
In-Reply-To: <20170801131618.27332-1-stefanha@redhat.com>
References: <20170801131618.27332-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 5/9] coding_style: add point about 0x in
 trace-events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20170731160135.12101-2-vsementsov@virtuozzo.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 CODING_STYLE | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/CODING_STYLE b/CODING_STYLE
index 2fa0c0b65b..12ba58ee29 100644
--- a/CODING_STYLE
+++ b/CODING_STYLE
@@ -123,3 +123,38 @@ We use traditional C-style /* */ comments and avoid // comments.
 
 Rationale: The // form is valid in C99, so this is purely a matter of
 consistency of style. The checkpatch script will warn you about this.
+
+8. trace-events style
+
+8.1 0x prefix
+
+In trace-events files, use a '0x' prefix to specify hex numbers, as in:
+
+some_trace(unsigned x, uint64_t y) "x 0x%x y 0x" PRIx64
+
+An exception is made for groups of numbers that are hexadecimal by
+convention and separated by the symbols '.', '/', ':', or ' ' (such as
+PCI bus id):
+
+another_trace(int cssid, int ssid, int dev_num) "bus id: %x.%x.%04x"
+
+However, you can use '0x' for such groups if you want. Anyway, be sure that
+it is obvious that numbers are in hex, ex.:
+
+data_dump(uint8_t c1, uint8_t c2, uint8_t c3) "bytes (in hex): %02x %02x %02x"
+
+Rationale: hex numbers are hard to read in logs when there is no 0x prefix,
+especially when (occasionally) the representation doesn't contain any letters
+and especially in one line with other decimal numbers. Number groups are allowed
+to not use '0x' because for some things notations like %x.%x.%x are used not
+only in Qemu. Also dumping raw data bytes with '0x' is less readable.
+
+8.2 '#' printf flag
+
+Do not use printf flag '#', like '%#x'.
+
+Rationale: there are two ways to add a '0x' prefix to printed number: '0x%...'
+and '%#...'. For consistency the only one way should be used. Arguments for
+'0x%' are:
+ - it is more popular
+ - '%#' omits the 0x for the value 0 which makes output inconsistent
-- 
2.13.3
