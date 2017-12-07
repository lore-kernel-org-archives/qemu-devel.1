Received: from eggs.gnu.org ([2001:4830:134:3::10]:46761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eN3ot-0001w1-H5
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:35:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eN3oq-00053n-CG
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:35:03 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:45766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1eN3oq-00053I-5W
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:35:00 -0500
Received: by mail-pf0-x242.google.com with SMTP id u19so5641408pfa.12
	for <qemu-devel@nongnu.org>; Thu, 07 Dec 2017 13:35:00 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Thu,  7 Dec 2017 15:34:48 -0600
Message-Id: <1512682489-4474-7-git-send-email-minyard@acm.org>
In-Reply-To: <1512682489-4474-1-git-send-email-minyard@acm.org>
References: <1512682489-4474-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH 6/7] smbios:ipmi: Ignore IPMI devices with no
 fwinfo function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

Not all devices have fwinfo (like the coming PCI one), so ignore
them if the their fwinfo function is NULL.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/smbios/smbios_type_38.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/smbios/smbios_type_38.c b/hw/smbios/smbios_type_38.c
index 56e8609..5475323 100644
--- a/hw/smbios/smbios_type_38.c
+++ b/hw/smbios/smbios_type_38.c
@@ -95,6 +95,9 @@ static void smbios_add_ipmi_devices(BusState *bus)
             ii = IPMI_INTERFACE(obj);
             iic = IPMI_INTERFACE_GET_CLASS(obj);
             memset(&info, 0, sizeof(info));
+            if (!iic->get_fwinfo) {
+                continue;
+            }
             iic->get_fwinfo(ii, &info);
             smbios_build_one_type_38(&info);
             continue;
-- 
2.7.4
