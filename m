Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1582CC43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 09:35:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 801612078B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 09:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OBGUS080"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 801612078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJCnm-00019h-DS
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 05:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kJCn1-0000ej-Om
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 05:34:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31670)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kJCmz-0005i1-Uh
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 05:34:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600421684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bhCgdRonuqJbY5hDJn2SqfLHKZfK3o5DLvfcBi77GYU=;
 b=OBGUS0805Fl0ywK+OGq1LXj3UT+DkxapDTbumEVKFwh81NNZaJyixv8Ch9tiTgRHX4bUSj
 vwO09vcycwoT3e5vL7+xLxF3r80vD5vbAouUnKEjkRO2LptQmu8SVGVDvkc4o/RUe6WPWQ
 hIEZ9JVMDUwaZxJ+9jPYCrqf0Uy9qOE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-IRtOO_4iNgKECGMrEX0XNQ-1; Fri, 18 Sep 2020 05:34:42 -0400
X-MC-Unique: IRtOO_4iNgKECGMrEX0XNQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E84C188C12D;
 Fri, 18 Sep 2020 09:34:41 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-113-161.ams2.redhat.com
 [10.36.113.161])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 296091002D46;
 Fri, 18 Sep 2020 09:34:37 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] util: include the target address in socket connect failures
Date: Fri, 18 Sep 2020 10:34:36 +0100
Message-Id: <20200918093436.1775120-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 00:20:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reporting "Failed to connect socket" is essentially useless for a user
attempting to diagnose failure. It needs to include the target addres
details. Simiarly when failing to create a socket we should include the
socket family info, so the user understands what particular feature was
missing in their kernel build (IPv6, VSock in particular).

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qemu-iotests/162.out |  4 ++--
 util/qemu-sockets.c        | 32 +++++++++++++++++++-------------
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/tests/qemu-iotests/162.out b/tests/qemu-iotests/162.out
index 5a00d36d17..f8714cb0d2 100644
--- a/tests/qemu-iotests/162.out
+++ b/tests/qemu-iotests/162.out
@@ -6,8 +6,8 @@ image: nbd://localhost:PORT
 image: nbd+unix://?socket=42
 
 === SSH ===
-qemu-img: Could not open 'json:{"driver": "ssh", "host": "localhost", "port": "0", "path": "/foo"}': Failed to connect socket: Connection refused
-qemu-img: Could not open 'driver=ssh,host=localhost,port=0,path=/foo': Failed to connect socket: Connection refused
+qemu-img: Could not open 'json:{"driver": "ssh", "host": "localhost", "port": "0", "path": "/foo"}': Failed to connect to 'localhost:0': Connection refused
+qemu-img: Could not open 'driver=ssh,host=localhost,port=0,path=/foo': Failed to connect to 'localhost:0': Connection refused
 qemu-img: Could not open 'json:{"driver": "ssh", "host": "localhost", "port": 0.42, "path": "/foo"}': Parameter 'port' expects a number
 qemu-img: Could not open 'driver=ssh,host=localhost,port=0.42,path=/foo': Parameter 'port' expects a number
 
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index b37d288866..dbf8e4dd0c 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -354,15 +354,15 @@ listen_ok:
     ((rc) == -EINPROGRESS)
 #endif
 
-static int inet_connect_addr(struct addrinfo *addr, Error **errp);
-
-static int inet_connect_addr(struct addrinfo *addr, Error **errp)
+static int inet_connect_addr(const InetSocketAddress *saddr,
+                             struct addrinfo *addr, Error **errp)
 {
     int sock, rc;
 
     sock = qemu_socket(addr->ai_family, addr->ai_socktype, addr->ai_protocol);
     if (sock < 0) {
-        error_setg_errno(errp, errno, "Failed to create socket");
+        error_setg_errno(errp, errno, "Failed to create socket family %d",
+                         addr->ai_family);
         return -1;
     }
     socket_set_fast_reuse(sock);
@@ -376,7 +376,8 @@ static int inet_connect_addr(struct addrinfo *addr, Error **errp)
     } while (rc == -EINTR);
 
     if (rc < 0) {
-        error_setg_errno(errp, errno, "Failed to connect socket");
+        error_setg_errno(errp, errno, "Failed to connect to '%s:%s'",
+                         saddr->host, saddr->port);
         closesocket(sock);
         return -1;
     }
@@ -455,7 +456,7 @@ int inet_connect_saddr(InetSocketAddress *saddr, Error **errp)
     for (e = res; e != NULL; e = e->ai_next) {
         error_free(local_err);
         local_err = NULL;
-        sock = inet_connect_addr(e, &local_err);
+        sock = inet_connect_addr(saddr, e, &local_err);
         if (sock >= 0) {
             break;
         }
@@ -549,7 +550,8 @@ static int inet_dgram_saddr(InetSocketAddress *sraddr,
     /* create socket */
     sock = qemu_socket(peer->ai_family, peer->ai_socktype, peer->ai_protocol);
     if (sock < 0) {
-        error_setg_errno(errp, errno, "Failed to create socket");
+        error_setg_errno(errp, errno, "Failed to create socket family %d",
+                         peer->ai_family);
         goto err;
     }
     socket_set_fast_reuse(sock);
@@ -562,7 +564,8 @@ static int inet_dgram_saddr(InetSocketAddress *sraddr,
 
     /* connect to peer */
     if (connect(sock,peer->ai_addr,peer->ai_addrlen) < 0) {
-        error_setg_errno(errp, errno, "Failed to connect socket");
+        error_setg_errno(errp, errno, "Failed to connect to '%s:%s'",
+                         addr, port);
         goto err;
     }
 
@@ -735,13 +738,15 @@ static bool vsock_parse_vaddr_to_sockaddr(const VsockSocketAddress *vaddr,
     return true;
 }
 
-static int vsock_connect_addr(const struct sockaddr_vm *svm, Error **errp)
+static int vsock_connect_addr(const VsockSocketAddress *vaddr,
+                              const struct sockaddr_vm *svm, Error **errp)
 {
     int sock, rc;
 
     sock = qemu_socket(AF_VSOCK, SOCK_STREAM, 0);
     if (sock < 0) {
-        error_setg_errno(errp, errno, "Failed to create socket");
+        error_setg_errno(errp, errno, "Failed to create socket family %d",
+                         AF_VSOCK);
         return -1;
     }
 
@@ -754,7 +759,8 @@ static int vsock_connect_addr(const struct sockaddr_vm *svm, Error **errp)
     } while (rc == -EINTR);
 
     if (rc < 0) {
-        error_setg_errno(errp, errno, "Failed to connect socket");
+        error_setg_errno(errp, errno, "Failed to connect to '%s:%s'",
+                         vaddr->cid, vaddr->port);
         closesocket(sock);
         return -1;
     }
@@ -770,7 +776,7 @@ static int vsock_connect_saddr(VsockSocketAddress *vaddr, Error **errp)
         return -1;
     }
 
-    return vsock_connect_addr(&svm, errp);
+    return vsock_connect_addr(vaddr, &svm, errp);
 }
 
 static int vsock_listen_saddr(VsockSocketAddress *vaddr,
@@ -994,7 +1000,7 @@ static int unix_connect_saddr(UnixSocketAddress *saddr, Error **errp)
     } while (rc == -EINTR);
 
     if (rc < 0) {
-        error_setg_errno(errp, -rc, "Failed to connect socket %s",
+        error_setg_errno(errp, -rc, "Failed to connect to '%s'",
                          saddr->path);
         goto err;
     }
-- 
2.26.2


