Received: from eggs.gnu.org ([2001:4830:134:3::10]:57290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eduardo.otubo@profitbricks.com>) id 1cdwbm-0007Dy-Of
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 05:14:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eduardo.otubo@profitbricks.com>) id 1cdwbj-0004wL-3y
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 05:14:46 -0500
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:34082)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eduardo.otubo@profitbricks.com>)
	id 1cdwbi-0004vm-UJ
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 05:14:43 -0500
Received: by mail-wr0-x22c.google.com with SMTP id o16so187753675wra.1
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 02:14:42 -0800 (PST)
From: Eduardo Otubo <eduardo.otubo@profitbricks.com>
Date: Wed, 15 Feb 2017 11:14:27 +0100
Message-Id: <20170215101427.23736-3-eduardo.otubo@profitbricks.com>
In-Reply-To: <20170215101427.23736-1-eduardo.otubo@profitbricks.com>
References: <20170215101427.23736-1-eduardo.otubo@profitbricks.com>
Subject: [Qemu-devel] [PATCH 2/2] object_add not registering option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, armbru@redhat.com, Eduardo Otubo <eduardo.otubo@profitbricks.com>

object_add (hmp command) wasn't registering its object in the internal
list of options, hence, not showing when using `writeconfig' command.
Steps to reproduce:

  (qemu) object_add memory-backend-ram,id=mem1,size=1G
  (qemu) device_add pc-dimm,id=dimm1,memdev=mem1
  (qemu) writeconfig qemu.conf

When done before this patch, `writeconfig' would not output the mem1
object to the config file. After this patch the output is as follows:

  [object "mem1"]
    qom-type = "memory-backend-ram"
    size = "1G"

Signed-off-by: Eduardo Otubo <eduardo.otubo@profitbricks.com>
---
 hmp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hmp.c b/hmp.c
index 4f2b8a10d2..36ae478482 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1818,7 +1818,6 @@ void hmp_object_add(Monitor *mon, const QDict *qdict)
     }
 
     obj = user_creatable_add_opts(opts, &err);
-    qemu_opts_del(opts);
 
     if (err) {
         hmp_handle_error(mon, &err);
-- 
2.11.0
