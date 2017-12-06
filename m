Received: from eggs.gnu.org ([2001:4830:134:3::10]:49903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCh-0000x5-20
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:18:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCd-0000zA-Oj
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49996
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eMfCd-0000yN-J9
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:55 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6JErtU037169
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 14:17:55 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2eppat0mm3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 14:17:54 -0500
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 14:17:54 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 13:16:38 -0600
In-Reply-To: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
References: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171206191648.18208-46-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 45/55] scripts/make-release: ship u-boot source
 as a tarball
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alexander Graf <agraf@suse.de>, Richard Henderson <richard.henderson@linaro.org>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

The u-boot sources we ship currently cause problems with unpacking on
a case-insensitive filesystem due to path conflicts. This has been
fixed in upstream u-boot via commit 610eec7f, but since it is not
yet included in an official release we implement this approach as a
temporary workaround.

Once we move to a u-boot containing commit 610eec7f we should revert
this patch.

Cc: qemu-stable@nongnu.org
Cc: Alexander Graf <agraf@suse.de>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20171107205201.10207-1-mdroth@linux.vnet.ibm.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit d0dead3b6df7f6cd970ed02e8369ab8730aac9d3)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 scripts/make-release | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/make-release b/scripts/make-release
index fa6323fda8..3917df7142 100755
--- a/scripts/make-release
+++ b/scripts/make-release
@@ -20,6 +20,10 @@ git checkout "v${version}"
 git submodule update --init
 (cd roms/seabios && git describe --tags --long --dirty > .version)
 rm -rf .git roms/*/.git dtc/.git pixman/.git
+# FIXME: The following line is a workaround for avoiding filename collisions
+# when unpacking u-boot sources on case-insensitive filesystems. Once we
+# update to something with u-boot commit 610eec7f0 we can drop this line.
+tar cfj roms/u-boot.tar.bz2 -C roms u-boot && rm -rf roms/u-boot
 popd
 tar cfj ${destination}.tar.bz2 ${destination}
 rm -rf ${destination}
-- 
2.11.0
