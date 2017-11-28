Received: from eggs.gnu.org ([2001:4830:134:3::10]:49531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eJfXt-00015O-SF
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 08:03:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eJfXr-0003ez-SC
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 08:03:29 -0500
From: Eric Blake <eblake@redhat.com>
Date: Tue, 28 Nov 2017 07:02:47 -0600
Message-Id: <20171128130248.901-2-eblake@redhat.com>
In-Reply-To: <20171128130248.901-1-eblake@redhat.com>
References: <20171128130248.901-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 1/2] nbd/server: CVE-2017-15119 Reject options
 larger than 32M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, secalert@redhat.com, ppandit@redhat.com, qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

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
---
 nbd/server.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/nbd/server.c b/nbd/server.c
index 7d6801b427..a81801e3bc 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -673,6 +673,12 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
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
2.14.3
