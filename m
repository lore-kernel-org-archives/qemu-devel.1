Received: from eggs.gnu.org ([2001:4830:134:3::10]:49935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCh-0000xh-Oy
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:18:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCe-00010a-KK
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50712
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eMfCe-0000zj-CM
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:56 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6JE252015486
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 14:17:55 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2epn0ac1st-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 14:17:55 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 14:17:55 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 13:16:41 -0600
In-Reply-To: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
References: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171206191648.18208-49-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 48/55] nbd/server: CVE-2017-15119 Reject
 options larger than 32M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Blake <eblake@redhat.com>

From: Eric Blake <eblake@redhat.com>

The NBD spec gives us permission to abruptly disconnect on clients
that send outrageously large option requests, rather than having
to spend the time reading to the end of the option.  No real
option request requires that much data anyways; and meanwhile, we
already have the practice of abruptly dropping the connection on
any client that sends NBD_CMD_WRITE with a payload larger than 32M.

For comparison, nbdkit drops the connection on any request with
more than 4096 bytes; however, that limit is probably too low
(as the NBD spec states an export name can theoretically be up
to 4096 bytes, which means a valid NBD_OPT_INFO could be even
longer) - even if qemu doesn't permit exports longer than 256
bytes.

It could be argued that a malicious client trying to get us to
read nearly 4G of data on a bad request is a form of denial of
service.  In particular, if the server requires TLS, but a client
that does not know the TLS credentials sends any option (other
than NBD_OPT_STARTTLS or NBD_OPT_EXPORT_NAME) with a stated
payload of nearly 4G, then the server was keeping the connection
alive trying to read all the payload, tying up resources that it
would rather be spending on a client that can get past the TLS
handshake.  Hence, this warranted a CVE.

Present since at least 2.5 when handling known options, and made
worse in 2.6 when fixing support for NBD_FLAG_C_FIXED_NEWSTYLE
to handle unknown options.

CC: qemu-stable@nongnu.org
Signed-off-by: Eric Blake <eblake@redhat.com>
(cherry picked from commit fdad35ef6c5839d50dfc14073364ac893afebc30)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 nbd/server.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/nbd/server.c b/nbd/server.c
index 993ade30bb..b93cb88911 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -661,6 +661,12 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
         }
         length = be32_to_cpu(length);
 
+        if (length > NBD_MAX_BUFFER_SIZE) {
+            error_setg(errp, "len (%" PRIu32" ) is larger than max len (%u)",
+                       length, NBD_MAX_BUFFER_SIZE);
+            return -EINVAL;
+        }
+
         trace_nbd_negotiate_options_check_option(option,
                                                  nbd_opt_lookup(option));
         if (client->tlscreds &&
-- 
2.11.0
