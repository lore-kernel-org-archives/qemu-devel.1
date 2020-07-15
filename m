Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88ECC433E4
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 13:57:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8FA820657
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 13:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h3brp/m+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8FA820657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvhuU-0001H5-01
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 09:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jvhrD-0003Vk-6l
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 09:53:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46790
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jvhrB-0005Mr-9b
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 09:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594821236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=Ppe8HFaAkuBHGro/MdNGmoORxrsqNsi5jhVHWKTZR5Y=;
 b=h3brp/m+biMWvAxw7In6tCiYmy5K6mDUQ3yaO9XZDrEkCesOFAFnfiZrtMvM9NYJN3xhZo
 P760apgnWaYrLb0smFFlDVqqZugDaC+BPn7tga+OIJUKUurX+NAogLbFvvPuXyhWhSqhqF
 3KpuR3zw+zDRtUU9XmK+1/+t94TMC/0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-07HNpE0yOmGUqk0zfLcGZg-1; Wed, 15 Jul 2020 09:53:54 -0400
X-MC-Unique: 07HNpE0yOmGUqk0zfLcGZg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83E76E91C;
 Wed, 15 Jul 2020 13:53:53 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-28.pek2.redhat.com
 [10.72.12.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C2DC861477;
 Wed, 15 Jul 2020 13:53:43 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org
Subject: [PULL 6/7] net: detect errors from probing vnet hdr flag for TAP
 devices
Date: Wed, 15 Jul 2020 21:53:20 +0800
Message-Id: <1594821201-3708-7-git-send-email-jasowang@redhat.com>
In-Reply-To: <1594821201-3708-1-git-send-email-jasowang@redhat.com>
References: <1594821201-3708-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 05:07:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Daniel P. Berrange" <berrange@redhat.com>

When QEMU sets up a tap based network device backend, it mostly ignores errors
reported from various ioctl() calls it makes, assuming the TAP file descriptor
is valid. This assumption can easily be violated when the user is passing in a
pre-opened file descriptor. At best, the ioctls may fail with a -EBADF, but if
the user passes in a bogus FD number that happens to clash with a FD number that
QEMU has opened internally for another reason, a wide variety of errnos may
result, as the TUNGETIFF ioctl number may map to a completely different command
on a different type of file.

By ignoring all these errors, QEMU sets up a zombie network backend that will
never pass any data. Even worse, when QEMU shuts down, or that network backend
is hot-removed, it will close this bogus file descriptor, which could belong to
another QEMU device backend.

There's no obvious guaranteed reliable way to detect that a FD genuinely is a
TAP device, as opposed to a UNIX socket, or pipe, or something else. Checking
the errno from probing vnet hdr flag though, does catch the big common cases.
ie calling TUNGETIFF will return EBADF for an invalid FD, and ENOTTY when FD is
a UNIX socket, or pipe which catches accidental collisions with FDs used for
stdio, or monitor socket.

Previously the example below where bogus fd 9 collides with the FD used for the
chardev saw:

$ ./x86_64-softmmu/qemu-system-x86_64 -netdev tap,id=hostnet0,fd=9 \
  -chardev socket,id=charchannel0,path=/tmp/qga,server,nowait \
  -monitor stdio -vnc :0
qemu-system-x86_64: -netdev tap,id=hostnet0,fd=9: TUNGETIFF ioctl() failed: Inappropriate ioctl for device
TUNSETOFFLOAD ioctl() failed: Bad address
QEMU 2.9.1 monitor - type 'help' for more information
(qemu) Warning: netdev hostnet0 has no peer

which gives a running QEMU with a zombie network backend.

With this change applied we get an error message and QEMU immediately exits
before carrying on and making a bigger disaster:

$ ./x86_64-softmmu/qemu-system-x86_64 -netdev tap,id=hostnet0,fd=9 \
  -chardev socket,id=charchannel0,path=/tmp/qga,server,nowait \
  -monitor stdio -vnc :0
qemu-system-x86_64: -netdev tap,id=hostnet0,vhost=on,fd=9: Unable to query TUNGETIFF on FD 9: Inappropriate ioctl for device

Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Tested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-id: 20171027085548.3472-1-berrange@redhat.com
[lv: to simplify, don't check on EINVAL with TUNGETIFF as it exists since v2.6.27]
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/tap-bsd.c     |  2 +-
 net/tap-linux.c   |  8 +++++---
 net/tap-solaris.c |  2 +-
 net/tap-stub.c    |  2 +-
 net/tap.c         | 25 ++++++++++++++++++++-----
 net/tap_int.h     |  2 +-
 6 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/net/tap-bsd.c b/net/tap-bsd.c
index a5c3707..77aaf67 100644
--- a/net/tap-bsd.c
+++ b/net/tap-bsd.c
@@ -211,7 +211,7 @@ void tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp)
 {
 }
 
-int tap_probe_vnet_hdr(int fd)
+int tap_probe_vnet_hdr(int fd, Error **errp)
 {
     return 0;
 }
diff --git a/net/tap-linux.c b/net/tap-linux.c
index e0dd442..b0635e9 100644
--- a/net/tap-linux.c
+++ b/net/tap-linux.c
@@ -147,13 +147,15 @@ void tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp)
     }
 }
 
-int tap_probe_vnet_hdr(int fd)
+int tap_probe_vnet_hdr(int fd, Error **errp)
 {
     struct ifreq ifr;
 
     if (ioctl(fd, TUNGETIFF, &ifr) != 0) {
-        error_report("TUNGETIFF ioctl() failed: %s", strerror(errno));
-        return 0;
+        /* TUNGETIFF is available since kernel v2.6.27 */
+        error_setg_errno(errp, errno,
+                         "Unable to query TUNGETIFF on FD %d", fd);
+        return -1;
     }
 
     return ifr.ifr_flags & IFF_VNET_HDR;
diff --git a/net/tap-solaris.c b/net/tap-solaris.c
index d03165c..0475a58 100644
--- a/net/tap-solaris.c
+++ b/net/tap-solaris.c
@@ -207,7 +207,7 @@ void tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp)
 {
 }
 
-int tap_probe_vnet_hdr(int fd)
+int tap_probe_vnet_hdr(int fd, Error **errp)
 {
     return 0;
 }
diff --git a/net/tap-stub.c b/net/tap-stub.c
index a9ab8f8..de525a2 100644
--- a/net/tap-stub.c
+++ b/net/tap-stub.c
@@ -37,7 +37,7 @@ void tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp)
 {
 }
 
-int tap_probe_vnet_hdr(int fd)
+int tap_probe_vnet_hdr(int fd, Error **errp)
 {
     return 0;
 }
diff --git a/net/tap.c b/net/tap.c
index 32e4813..14dc904 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -598,7 +598,11 @@ int net_init_bridge(const Netdev *netdev, const char *name,
     }
 
     qemu_set_nonblock(fd);
-    vnet_hdr = tap_probe_vnet_hdr(fd);
+    vnet_hdr = tap_probe_vnet_hdr(fd, errp);
+    if (vnet_hdr < 0) {
+        close(fd);
+        return -1;
+    }
     s = net_tap_fd_init(peer, "bridge", name, fd, vnet_hdr);
 
     snprintf(s->nc.info_str, sizeof(s->nc.info_str), "helper=%s,br=%s", helper,
@@ -810,7 +814,11 @@ int net_init_tap(const Netdev *netdev, const char *name,
             return -1;
         }
 
-        vnet_hdr = tap_probe_vnet_hdr(fd);
+        vnet_hdr = tap_probe_vnet_hdr(fd, errp);
+        if (vnet_hdr < 0) {
+            close(fd);
+            return -1;
+        }
 
         net_init_tap_one(tap, peer, "tap", name, NULL,
                          script, downscript,
@@ -862,8 +870,11 @@ int net_init_tap(const Netdev *netdev, const char *name,
             }
 
             if (i == 0) {
-                vnet_hdr = tap_probe_vnet_hdr(fd);
-            } else if (vnet_hdr != tap_probe_vnet_hdr(fd)) {
+                vnet_hdr = tap_probe_vnet_hdr(fd, errp);
+                if (vnet_hdr < 0) {
+                    goto free_fail;
+                }
+            } else if (vnet_hdr != tap_probe_vnet_hdr(fd, NULL)) {
                 error_setg(errp,
                            "vnet_hdr not consistent across given tap fds");
                 ret = -1;
@@ -908,7 +919,11 @@ free_fail:
         }
 
         qemu_set_nonblock(fd);
-        vnet_hdr = tap_probe_vnet_hdr(fd);
+        vnet_hdr = tap_probe_vnet_hdr(fd, errp);
+        if (vnet_hdr < 0) {
+            close(fd);
+            return -1;
+        }
 
         net_init_tap_one(tap, peer, "bridge", name, ifname,
                          script, downscript, vhostfdname,
diff --git a/net/tap_int.h b/net/tap_int.h
index e3194b2..225a49e 100644
--- a/net/tap_int.h
+++ b/net/tap_int.h
@@ -34,7 +34,7 @@ int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
 ssize_t tap_read_packet(int tapfd, uint8_t *buf, int maxlen);
 
 void tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp);
-int tap_probe_vnet_hdr(int fd);
+int tap_probe_vnet_hdr(int fd, Error **errp);
 int tap_probe_vnet_hdr_len(int fd, int len);
 int tap_probe_has_ufo(int fd);
 void tap_fd_set_offload(int fd, int csum, int tso4, int tso6, int ecn, int ufo);
-- 
2.5.0


