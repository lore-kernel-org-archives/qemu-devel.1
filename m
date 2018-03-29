Received: from eggs.gnu.org ([2001:4830:134:3::10]:33589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f1TZs-0002Bo-Hw
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 05:10:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f1TZo-0006HA-H7
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 05:10:36 -0400
Received: from 6.mo5.mail-out.ovh.net ([178.32.119.138]:49961)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1f1TZo-0006Gr-BS
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 05:10:32 -0400
Received: from player728.ha.ovh.net (unknown [10.109.120.119])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id AFBB119A308
	for <qemu-devel@nongnu.org>; Thu, 29 Mar 2018 11:10:30 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 29 Mar 2018 11:10:21 +0200
Message-ID: <152231462116.69730.14119625999092384450.stgit@bahia.lan>
In-Reply-To: <152231456507.69730.15601462044394150786.stgit@bahia.lan>
References: <152231456507.69730.15601462044394150786.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 3/3] sev/i386: fix memory leak in
 sev_guest_init()
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

Fixes: d8575c6c0242b
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 target/i386/sev.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 019d84cef2c7..c01167143f1c 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -748,9 +748,11 @@ sev_guest_init(const char *id)
     if (s->sev_fd < 0) {
         error_report("%s: Failed to open %s '%s'", __func__,
                      devname, strerror(errno));
-        goto err;
     }
     g_free(devname);
+    if (s->sev_fd < 0) {
+        goto err;
+    }
 
     ret = sev_platform_ioctl(s->sev_fd, SEV_PLATFORM_STATUS, &status,
                              &fw_error);
