Received: from eggs.gnu.org ([2001:4830:134:3::10]:33424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f1TZQ-0001kw-89
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 05:10:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f1TZM-0005x9-0f
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 05:10:07 -0400
Received: from 6.mo6.mail-out.ovh.net ([87.98.177.69]:54255)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1f1TZL-0005vm-Qm
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 05:10:03 -0400
Received: from player728.ha.ovh.net (unknown [10.109.105.27])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 2455014E5CE
	for <qemu-devel@nongnu.org>; Thu, 29 Mar 2018 11:10:01 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 29 Mar 2018 11:09:46 +0200
Message-ID: <152231458624.69730.1752893648612848392.stgit@bahia.lan>
In-Reply-To: <152231456507.69730.15601462044394150786.stgit@bahia.lan>
References: <152231456507.69730.15601462044394150786.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 1/3] exec: fix memory leak in
 find_max_supported_pagesize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org, qemu-stable@nongnu.org

The string returned by object_property_get_str() is dynamically allocated.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 exec.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/exec.c b/exec.c
index c09bd93df31e..02b1efebb7c3 100644
--- a/exec.c
+++ b/exec.c
@@ -1495,6 +1495,7 @@ static int find_max_supported_pagesize(Object *obj, void *opaque)
         mem_path = object_property_get_str(obj, "mem-path", NULL);
         if (mem_path) {
             long hpsize = qemu_mempath_getpagesize(mem_path);
+            g_free(mem_path);
             if (hpsize < *hpsize_min) {
                 *hpsize_min = hpsize;
             }
