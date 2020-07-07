Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08047C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:47:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE392206E2
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AtudMlL2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE392206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsscw-0007rI-42
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 14:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1jssb8-00058x-EU
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:45:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29680
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1jssb6-0007F7-5q
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594147539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gR59wA1IW8js6Hw+yLL7CoKyJyCyFu9O9hAYxwg3x/g=;
 b=AtudMlL2idEYCZyB0XmO9431jxX06UeYQhYDnq/aOPXEPc/tLO1AxPj0xpPWlIdfJ1JRfh
 0C/L+3DWZULPEsSxI6KnUw/s3h3IVaPTw+WaIkPHRyJqPA+t8CE6M30wHxRTwWX9AvwKp1
 DsmN0CSw05Z0fKjwsQrdEEDP1rLU+PQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-PmzJJ0vkMFCZwxRWW8bRDg-1; Tue, 07 Jul 2020 14:45:36 -0400
X-MC-Unique: PmzJJ0vkMFCZwxRWW8bRDg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E73A68015CE;
 Tue,  7 Jul 2020 18:45:35 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-112-252.ams2.redhat.com
 [10.36.112.252])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 121DB61981;
 Tue,  7 Jul 2020 18:45:23 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 1/2] net: check if the file descriptor is valid before
 using it
Date: Tue,  7 Jul 2020 20:45:14 +0200
Message-Id: <20200707184515.371476-2-lvivier@redhat.com>
In-Reply-To: <20200707184515.371476-1-lvivier@redhat.com>
References: <20200707184515.371476-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lvivier@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=lvivier@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 06:04:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qemu_set_nonblock() checks that the file descriptor can be used and, if
not, crashes QEMU. An assert() is used for that. The use of assert() is
used to detect programming error and the coredump will allow to debug
the problem.

But in the case of the tap device, this assert() can be triggered by
a misconfiguration by the user. At startup, it's not a real problem, but it
can also happen during the hot-plug of a new device, and here it's a
problem because we can crash a perfectly healthy system.

For instance:
 # ip link add link virbr0 name macvtap0 type macvtap mode bridge
 # ip link set macvtap0 up
 # TAP=/dev/tap$(ip -o link show macvtap0 | cut -d: -f1)
 # qemu-system-x86_64 -machine q35 -device pcie-root-port,id=pcie-root-port-0 -monitor stdio 9<> $TAP
 (qemu) netdev_add type=tap,id=hostnet0,vhost=on,fd=9
 (qemu) device_add driver=virtio-net-pci,netdev=hostnet0,id=net0,bus=pcie-root-port-0
 (qemu) device_del net0
 (qemu) netdev_del hostnet0
 (qemu) netdev_add type=tap,id=hostnet1,vhost=on,fd=9
 qemu-system-x86_64: .../util/oslib-posix.c:247: qemu_set_nonblock: Assertion `f != -1' failed.
 Aborted (core dumped)

To avoid that, add a function, qemu_try_set_nonblock(), that allows to report the
problem without crashing.

In the same way, we also update the function for vhostfd in net_init_tap_one() and
for fd in net_init_socket() (both descriptors are provided by the user and can
be wrong).

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/qemu/sockets.h |  1 +
 net/socket.c           |  9 +++++--
 net/tap.c              | 25 +++++++++++++++---
 util/oslib-posix.c     | 26 +++++++++++++------
 util/oslib-win32.c     | 57 ++++++++++++++++++++++++------------------
 5 files changed, 79 insertions(+), 39 deletions(-)

diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
index 57cd049d6edd..7d1f8135767d 100644
--- a/include/qemu/sockets.h
+++ b/include/qemu/sockets.h
@@ -18,6 +18,7 @@ int qemu_accept(int s, struct sockaddr *addr, socklen_t *addrlen);
 int socket_set_cork(int fd, int v);
 int socket_set_nodelay(int fd);
 void qemu_set_block(int fd);
+int qemu_try_set_nonblock(int fd);
 void qemu_set_nonblock(int fd);
 int socket_set_fast_reuse(int fd);
 
diff --git a/net/socket.c b/net/socket.c
index c92354049bca..2d21fddd9cd6 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -725,13 +725,18 @@ int net_init_socket(const Netdev *netdev, const char *name,
     }
 
     if (sock->has_fd) {
-        int fd;
+        int fd, ret;
 
         fd = monitor_fd_param(cur_mon, sock->fd, errp);
         if (fd == -1) {
             return -1;
         }
-        qemu_set_nonblock(fd);
+        ret = qemu_try_set_nonblock(fd);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "%s: Can't use file descriptor %d",
+                             name, fd);
+            return -1;
+        }
         if (!net_socket_fd_init(peer, "socket", name, fd, 1, sock->mcast,
                                 errp)) {
             return -1;
diff --git a/net/tap.c b/net/tap.c
index 6207f61f84ab..41a20102fd0b 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -689,6 +689,8 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
         }
 
         if (vhostfdname) {
+            int ret;
+
             vhostfd = monitor_fd_param(cur_mon, vhostfdname, &err);
             if (vhostfd == -1) {
                 if (tap->has_vhostforce && tap->vhostforce) {
@@ -698,7 +700,12 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
                 }
                 return;
             }
-            qemu_set_nonblock(vhostfd);
+            ret = qemu_try_set_nonblock(vhostfd);
+            if (ret < 0) {
+                error_setg_errno(errp, -ret, "%s: Can't use file descriptor %d",
+                                 name, fd);
+                return;
+            }
         } else {
             vhostfd = open("/dev/vhost-net", O_RDWR);
             if (vhostfd < 0) {
@@ -766,6 +773,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
     Error *err = NULL;
     const char *vhostfdname;
     char ifname[128];
+    int ret = 0;
 
     assert(netdev->type == NET_CLIENT_DRIVER_TAP);
     tap = &netdev->u.tap;
@@ -795,7 +803,12 @@ int net_init_tap(const Netdev *netdev, const char *name,
             return -1;
         }
 
-        qemu_set_nonblock(fd);
+        ret = qemu_try_set_nonblock(fd);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "%s: Can't use file descriptor %d",
+                             name, fd);
+            return -1;
+        }
 
         vnet_hdr = tap_probe_vnet_hdr(fd);
 
@@ -810,7 +823,6 @@ int net_init_tap(const Netdev *netdev, const char *name,
         char **fds;
         char **vhost_fds;
         int nfds = 0, nvhosts = 0;
-        int ret = 0;
 
         if (tap->has_ifname || tap->has_script || tap->has_downscript ||
             tap->has_vnet_hdr || tap->has_helper || tap->has_queues ||
@@ -843,7 +855,12 @@ int net_init_tap(const Netdev *netdev, const char *name,
                 goto free_fail;
             }
 
-            qemu_set_nonblock(fd);
+            ret = qemu_try_set_nonblock(fd);
+            if (ret < 0) {
+                error_setg_errno(errp, -ret, "%s: Can't use file descriptor %d",
+                                 name, fd);
+                goto free_fail;
+            }
 
             if (i == 0) {
                 vnet_hdr = tap_probe_vnet_hdr(fd);
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 916f1be2243a..149254cd691f 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -253,25 +253,35 @@ void qemu_set_block(int fd)
     assert(f != -1);
 }
 
-void qemu_set_nonblock(int fd)
+int qemu_try_set_nonblock(int fd)
 {
     int f;
     f = fcntl(fd, F_GETFL);
-    assert(f != -1);
-    f = fcntl(fd, F_SETFL, f | O_NONBLOCK);
-#ifdef __OpenBSD__
     if (f == -1) {
+        return -errno;
+    }
+    if (fcntl(fd, F_SETFL, f | O_NONBLOCK) == -1) {
+#ifdef __OpenBSD__
         /*
          * Previous to OpenBSD 6.3, fcntl(F_SETFL) is not permitted on
          * memory devices and sets errno to ENODEV.
          * It's OK if we fail to set O_NONBLOCK on devices like /dev/null,
          * because they will never block anyway.
          */
-        assert(errno == ENODEV);
-    }
-#else
-    assert(f != -1);
+        if (errno == ENODEV) {
+            return 0;
+        }
 #endif
+        return -errno;
+    }
+    return 0;
+}
+
+void qemu_set_nonblock(int fd)
+{
+    int f;
+    f = qemu_try_set_nonblock(fd);
+    assert(f == 0);
 }
 
 int socket_set_fast_reuse(int fd)
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index e9b14ab17847..5548ce6038f3 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -132,31 +132,6 @@ struct tm *localtime_r(const time_t *timep, struct tm *result)
 }
 #endif /* CONFIG_LOCALTIME_R */
 
-void qemu_set_block(int fd)
-{
-    unsigned long opt = 0;
-    WSAEventSelect(fd, NULL, 0);
-    ioctlsocket(fd, FIONBIO, &opt);
-}
-
-void qemu_set_nonblock(int fd)
-{
-    unsigned long opt = 1;
-    ioctlsocket(fd, FIONBIO, &opt);
-    qemu_fd_register(fd);
-}
-
-int socket_set_fast_reuse(int fd)
-{
-    /* Enabling the reuse of an endpoint that was used by a socket still in
-     * TIME_WAIT state is usually performed by setting SO_REUSEADDR. On Windows
-     * fast reuse is the default and SO_REUSEADDR does strange things. So we
-     * don't have to do anything here. More info can be found at:
-     * http://msdn.microsoft.com/en-us/library/windows/desktop/ms740621.aspx */
-    return 0;
-}
-
-
 static int socket_error(void)
 {
     switch (WSAGetLastError()) {
@@ -233,6 +208,38 @@ static int socket_error(void)
     }
 }
 
+void qemu_set_block(int fd)
+{
+    unsigned long opt = 0;
+    WSAEventSelect(fd, NULL, 0);
+    ioctlsocket(fd, FIONBIO, &opt);
+}
+
+int qemu_try_set_nonblock(int fd)
+{
+    unsigned long opt = 1;
+    if (ioctlsocket(fd, FIONBIO, &opt) != NO_ERROR) {
+        return -socket_error();
+    }
+    qemu_fd_register(fd);
+    return 0;
+}
+
+void qemu_set_nonblock(int fd)
+{
+    (void)qemu_try_set_nonblock(fd);
+}
+
+int socket_set_fast_reuse(int fd)
+{
+    /* Enabling the reuse of an endpoint that was used by a socket still in
+     * TIME_WAIT state is usually performed by setting SO_REUSEADDR. On Windows
+     * fast reuse is the default and SO_REUSEADDR does strange things. So we
+     * don't have to do anything here. More info can be found at:
+     * http://msdn.microsoft.com/en-us/library/windows/desktop/ms740621.aspx */
+    return 0;
+}
+
 int inet_aton(const char *cp, struct in_addr *ia)
 {
     uint32_t addr = inet_addr(cp);
-- 
2.26.2


