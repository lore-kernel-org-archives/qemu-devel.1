Received: from eggs.gnu.org ([209.51.188.92]:55086)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <ao2@ao2.it>)
	id 1hMTXu-0000yg-SN
	for qemu-devel@nongnu.org; Fri, 03 May 2019 04:27:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ao2@ao2.it>) id 1hMTXt-0006vt-Pz
	for qemu-devel@nongnu.org; Fri, 03 May 2019 04:27:54 -0400
Received: from mail.ao2.it ([2001:4b98:dc0:41:216:3eff:fe7c:639b]:39650
	helo=ao2.it)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ao2@ao2.it>) id 1hMTXt-0006uv-EB
	for qemu-devel@nongnu.org; Fri, 03 May 2019 04:27:53 -0400
From: Antonio Ospite <ao2@ao2.it>
Date: Fri,  3 May 2019 10:27:27 +0200
Message-Id: <20190503082728.16485-2-ao2@ao2.it>
In-Reply-To: <20190503082728.16485-1-ao2@ao2.it>
References: <20190503082728.16485-1-ao2@ao2.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 1/2] configure: set source_path only once
 and make its definition more robust
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Antonio Ospite <antonio.ospite@collabora.com>, Antonio Ospite <ao2@ao2.it>, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>

From: Antonio Ospite <antonio.ospite@collabora.com>

Since commit 79d77bcd36 (configure: Remove --source-path option,
2019-04-29) source_path cannot be overridden anymore, move it out of the
"default parameters" block since the word "default" may suggest that the
value can change, while in fact it does not.

While at it, only set source_path once and separate the positional
argument of basename with "--" to more robustly cover the case of path
names starting with a dash.

Signed-off-by: Antonio Ospite <antonio.ospite@collabora.com>
---
 configure | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index 60719ddcc5..9832cbca5c 100755
--- a/configure
+++ b/configure
@@ -276,10 +276,10 @@ ld_has() {
     $ld --help 2>/dev/null | grep ".$1" >/dev/null 2>&1
 }
 
-# default parameters
-source_path=$(dirname "$0")
 # make source path absolute
-source_path=$(cd "$source_path"; pwd)
+source_path=$(cd "$(dirname -- "$0")"; pwd)
+
+# default parameters
 cpu=""
 iasl="iasl"
 interp_prefix="/usr/gnemul/qemu-%M"
-- 
2.20.1
