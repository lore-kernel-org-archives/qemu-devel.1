Received: from eggs.gnu.org ([2001:4830:134:3::10]:42571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBu-00033G-PJ
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBr-0001JU-NR
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:34 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55881
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKBr-0001J2-Gi
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:31 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0hb9w007112
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:30 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27bdm3h0y9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:30 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 19:46:30 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:25 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-32-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 31/67] char: fix missing return in error path
 for chardev TLS init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>

From: "Daniel P. Berrange" <berrange@redhat.com>

If the qio_channel_tls_new_(server|client) methods fail,
we disconnect the client. Unfortunately a missing return
means we then go on to try and run the TLS handshake on
a NULL I/O channel. This gives predictably segfaulty
results.

The main way to trigger this is to request a bogus TLS
priority string for the TLS credentials. e.g.

  -object tls-creds-x509,id=tls0,priority=wibble,...

Most other ways appear impossible to trigger except
perhaps if OOM conditions cause gnutls initialization
to fail.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(cherry picked from commit 660a2d83e026496db6b3eaec2256a2cdd6c74de8)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qemu-char.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/qemu-char.c b/qemu-char.c
index fdb23f5..90e9627 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -3096,6 +3096,7 @@ static void tcp_chr_tls_init(CharDriverState *chr)
     if (tioc == NULL) {
         error_free(err);
         tcp_chr_disconnect(chr);
+        return;
     }
     object_unref(OBJECT(s->ioc));
     s->ioc = QIO_CHANNEL(tioc);
-- 
1.9.1
