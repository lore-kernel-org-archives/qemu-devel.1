Received: from eggs.gnu.org ([2001:4830:134:3::10]:60391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e2Dxu-0004om-LX
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 06:10:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e2Dxt-00022i-7l
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 06:10:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e2Dxs-00020c-OJ
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 06:10:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DC1FF3DBD1
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 10:10:11 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Wed, 11 Oct 2017 11:09:59 +0100
Message-Id: <20171011100959.29326-8-berrange@redhat.com>
In-Reply-To: <20171011100959.29326-1-berrange@redhat.com>
References: <20171011100959.29326-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 7/7] io: add trace points for websocket HTTP
 protocol headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 io/channel-websock.c | 4 ++++
 io/trace-events      | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/io/channel-websock.c b/io/channel-websock.c
index 3e3d0953c4..afe9db4c28 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -224,6 +224,7 @@ qio_channel_websock_extract_headers(QIOChannelWebsock *ioc,
         goto bad_request;
     }
     *nl = '\0';
+    trace_qio_channel_websock_http_greeting(ioc, buffer);
 
     tmp = strchr(buffer, ' ');
     if (!tmp) {
@@ -425,6 +426,9 @@ static void qio_channel_websock_handshake_process(QIOChannelWebsock *ioc,
         goto bad_request;
     }
 
+    trace_qio_channel_websock_http_request(ioc, protocols, version,
+                                           host, connection, upgrade, key);
+
     if (!g_strrstr(protocols, QIO_CHANNEL_WEBSOCK_PROTOCOL_BINARY)) {
         error_setg(errp, "No '%s' protocol is supported by client '%s'",
                    QIO_CHANNEL_WEBSOCK_PROTOCOL_BINARY, protocols);
diff --git a/io/trace-events b/io/trace-events
index 801b5dcb61..f70bad7cbe 100644
--- a/io/trace-events
+++ b/io/trace-events
@@ -48,6 +48,8 @@ qio_channel_websock_handshake_pending(void *ioc, int status) "Websock handshake
 qio_channel_websock_handshake_reply(void *ioc) "Websock handshake reply ioc=%p"
 qio_channel_websock_handshake_fail(void *ioc, const char *msg) "Websock handshake fail ioc=%p err=%s"
 qio_channel_websock_handshake_complete(void *ioc) "Websock handshake complete ioc=%p"
+qio_channel_websock_http_greeting(void *ioc, const char *greeting) "Websocket HTTP request ioc=%p greeting='%s'"
+qio_channel_websock_http_request(void *ioc, const char *protocols, const char *version, const char *host, const char *connection, const char *upgrade, const char *key) "Websocket HTTP request ioc=%p protocols='%s' version='%s' host='%s' connection='%s' upgrade='%s' key='%s'"
 qio_channel_websock_header_partial_decode(void *ioc, size_t payloadlen, unsigned char fin, unsigned char opcode, unsigned char has_mask) "Websocket header decoded ioc=%p payload-len=%zu fin=0x%x opcode=0x%x has_mask=0x%x"
 qio_channel_websock_header_full_decode(void *ioc, size_t headerlen, size_t payloadlen, uint32_t mask) "Websocket header decoded ioc=%p header-len=%zu payload-len=%zu mask=0x%x"
 qio_channel_websock_payload_decode(void *ioc, uint8_t opcode, size_t payload_remain) "Websocket header decoded ioc=%p opcode=0x%x payload-remain=%zu"
-- 
2.13.5
