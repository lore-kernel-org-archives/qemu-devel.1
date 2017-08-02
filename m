Received: from eggs.gnu.org ([2001:4830:134:3::10]:43582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dcxXP-0000MH-5q
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 13:34:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dcxXL-0005Xl-8P
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 13:34:27 -0400
Received: from 4.mo178.mail-out.ovh.net ([46.105.49.171]:37627)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dcxXL-0005X1-2m
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 13:34:23 -0400
Received: from player728.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 509A54B13B
	for <qemu-devel@nongnu.org>; Wed,  2 Aug 2017 19:34:21 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Wed, 02 Aug 2017 19:34:16 +0200
Message-ID: <150169525609.4634.10414517308328488237.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] ppc: fix double-free in cpu_post_load()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

When running nested with KVM PR, ppc_set_compat() fails and QEMU crashes
because of "double free or corruption (!prev)". The crash happens because
error_report_err() has already called error_free().

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/machine.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index f578156dd411..abe0a1cdf021 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -239,7 +239,6 @@ static int cpu_post_load(void *opaque, int version_id)
         ppc_set_compat(cpu, cpu->compat_pvr, &local_err);
         if (local_err) {
             error_report_err(local_err);
-            error_free(local_err);
             return -1;
         }
     } else
