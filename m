Received: from eggs.gnu.org ([209.51.188.92]:44794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1gm1nf-0007Uh-QN
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:33:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1gm1gq-0005ex-2q
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:26:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1gm1gp-0005W7-TN
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:26:28 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 42EC258E3E
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 14:41:07 +0000 (UTC)
From: Pankaj Gupta <pagupta@redhat.com>
Date: Tue, 22 Jan 2019 20:11:03 +0530
Message-Id: <20190122144103.18310-1-pagupta@redhat.com>
Subject: [Qemu-devel] [PATCH] chardev: Avoid adding duplicate chardev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, xiaohli@redhat.com, pagupta@redhat.com

Hotplugging existing char chardev with qmp, dereferences(removes) 
existing chardev. This patch avoids adding a chardev if a chardev 
with same id exists.

RH BZ 1660831: 

# (host) ls -lt /tmp/helloworld*
srwxr-xr-x.  /tmp/helloworld1
srwxr-xr-x.  /tmp/helloworld2

Before this patch:

hotplug existed chardev(channel1) in qmp:
{"execute":"chardev-add","arguments":{"id":"charchannel1","backend":{"type":"socket",
"data":{"addr":{"type":"unix", "data": {"path": "/tmp/helloworld1"}}}}}}

{"error": {"class": "GenericError", "desc": "attempt to add duplicate 
property 'charchannel1' to object (type 'container')"}}

# ls -lt /tmp/helloworld*
srwxr-xr-x. 1 root root 0 Dec 19 16:39 /tmp/helloworld2

After this patch:

{"execute":"chardev-add","arguments":{"id":"charchannel1","backend":{"type":"socket",
"data":{"addr":{"type":"unix", "data": {"path": "/tmp/helloworld1"}}}}}}
{"error": {"class": "GenericError", "desc": "Chardev 'charchannel1' already exist"}}

# ls -lt /tmp/helloworld*
srwxr-xr-x. 1 /tmp/helloworld1
srwxr-xr-x. 1 /tmp/helloworld2
 
Reported-by: Xiaohui Li <xiaohli@redhat.com>
Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
---
 chardev/char.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/chardev/char.c b/chardev/char.c
index ccba36bafb..cab0d3df16 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -985,6 +985,12 @@ ChardevReturn *qmp_chardev_add(const char *id, ChardevBackend *backend,
     ChardevReturn *ret;
     Chardev *chr;
 
+    chr = qemu_chr_find(id);
+    if (chr) {
+        error_setg(errp, "Chardev '%s' already exist", id);
+        return NULL;
+    }
+
     cc = char_get_class(ChardevBackendKind_str(backend->type), errp);
     if (!cc) {
         return NULL;
-- 
2.14.3
