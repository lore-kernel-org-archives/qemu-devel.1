Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6D6C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 15:53:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87CD4206F5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 15:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BVT1abTq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87CD4206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1AsM-0003dC-RT
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 11:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1AdS-0007bR-5f
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:38:25 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37176)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1AdN-0002C2-CJ
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:38:20 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UFXXd3155787;
 Thu, 30 Jul 2020 15:38:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=gA4smmTDr4yV2TFqL9n5pgGRpocaWBZlXIn3Szu+0+M=;
 b=BVT1abTqjT8zlDGDu6rO+Dg2O4Nk18XH/O7Q2rr5r0KGQg849IeHfSQZ/DeAApQNwV+1
 E/Q1bdCmAYFM2dgXFl+xJAF+eOlwk9rdA0+kQV1DYpzPvgQLvS8Lnmdlk5Ul4Yth6XpT
 MV370a/eE65P5ggWX/kavm9os1e2JXSSxaPnOvxWcUIHD9/Ns1KjmO0niJzVYIt3+P/H
 8Nr6fThMIRzJ+VIkn3MTlupW9Bc8JeMlk9f7fQ06o+v14lHBtPFQhq0uw87GxbJZvY8g
 dDTAJaO+lFDZv+piwlaOpKQ8HHXZHsrtLXCsd0/XexF8jt+6D6mgfnlfkFy6P4BgiWXA 7g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 32hu1jmee8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 30 Jul 2020 15:38:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UFXShC130702;
 Thu, 30 Jul 2020 15:38:14 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 32hu5wwh23-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2020 15:38:14 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06UFcDJV001920;
 Thu, 30 Jul 2020 15:38:13 GMT
Received: from ca-dev63.us.oracle.com (/10.211.8.221)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 30 Jul 2020 08:38:12 -0700
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH V1 24/32] ui: save/restore vnc socket fds
Date: Thu, 30 Jul 2020 08:14:28 -0700
Message-Id: <1596122076-341293-25-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 mlxscore=0
 suspectscore=1 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 clxscore=1015 mlxscore=0 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=1 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300111
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=steven.sistare@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 11:37:57
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Mark Kanda <mark.kanda@oracle.com>

Iterate through the VNC displays and save/restore the socket fds.

Signed-off-by: Mark Kanda <mark.kanda@oracle.com>
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/sysemu/sysemu.h |   2 +
 migration/savevm.c      |   3 +
 ui/vnc.c                | 153 +++++++++++++++++++++++++++++++++++++++---------
 3 files changed, 130 insertions(+), 28 deletions(-)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index fa1a5c3..3e7bfee 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -28,6 +28,8 @@ void qemu_remove_machine_init_done_notifier(Notifier *notify);
 void save_cpr_snapshot(const char *file, const char *mode, Error **errp);
 void load_cpr_snapshot(const char *file, Error **errp);
 void save_chardev_fds(void);
+void save_vnc_fds(void);
+void load_vnc_fds(void);
 
 extern int autostart;
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 81f38c4..35fafb7 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2768,6 +2768,7 @@ void save_cpr_snapshot(const char *file, const char *mode, Error **errp)
             return;
         }
         save_chardev_fds();
+        save_vnc_fds();
         walkenv(FD_PREFIX, preserve_fd, 0);
         qemu_system_exec_request();
         putenv((char *)"QEMU_START_FREEZE=");
@@ -3015,6 +3016,8 @@ void load_cpr_snapshot(const char *file, Error **errp)
             start_on_wake = 1;
         }
     }
+
+    load_vnc_fds();
 }
 
 int load_snapshot(const char *name, Error **errp)
diff --git a/ui/vnc.c b/ui/vnc.c
index f006aa1..947ddf5 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -50,6 +50,7 @@
 #include "qom/object_interfaces.h"
 #include "qemu/cutils.h"
 #include "io/dns-resolver.h"
+#include "sysemu/sysemu.h"
 
 #define VNC_REFRESH_INTERVAL_BASE GUI_REFRESH_INTERVAL_DEFAULT
 #define VNC_REFRESH_INTERVAL_INC  50
@@ -2214,28 +2215,34 @@ static void set_pixel_format(VncState *vs, int bits_per_pixel,
     graphic_hw_update(vs->vd->dcl.con);
 }
 
-static void pixel_format_message (VncState *vs) {
+/*
+ * reuse - true if we are using an existing (already initialized)
+ * connection to a vnc client
+ */
+static void pixel_format_message(VncState *vs, bool reuse)
+{
     char pad[3] = { 0, 0, 0 };
 
     vs->client_pf = qemu_default_pixelformat(32);
 
-    vnc_write_u8(vs, vs->client_pf.bits_per_pixel); /* bits-per-pixel */
-    vnc_write_u8(vs, vs->client_pf.depth); /* depth */
+    if (!reuse) {
+        vnc_write_u8(vs, vs->client_pf.bits_per_pixel); /* bits-per-pixel */
+        vnc_write_u8(vs, vs->client_pf.depth); /* depth */
 
 #ifdef HOST_WORDS_BIGENDIAN
-    vnc_write_u8(vs, 1);             /* big-endian-flag */
+        vnc_write_u8(vs, 1);             /* big-endian-flag */
 #else
-    vnc_write_u8(vs, 0);             /* big-endian-flag */
+        vnc_write_u8(vs, 0);             /* big-endian-flag */
 #endif
-    vnc_write_u8(vs, 1);             /* true-color-flag */
-    vnc_write_u16(vs, vs->client_pf.rmax);     /* red-max */
-    vnc_write_u16(vs, vs->client_pf.gmax);     /* green-max */
-    vnc_write_u16(vs, vs->client_pf.bmax);     /* blue-max */
-    vnc_write_u8(vs, vs->client_pf.rshift);    /* red-shift */
-    vnc_write_u8(vs, vs->client_pf.gshift);    /* green-shift */
-    vnc_write_u8(vs, vs->client_pf.bshift);    /* blue-shift */
-    vnc_write(vs, pad, 3);           /* padding */
-
+        vnc_write_u8(vs, 1);             /* true-color-flag */
+        vnc_write_u16(vs, vs->client_pf.rmax);     /* red-max */
+        vnc_write_u16(vs, vs->client_pf.gmax);     /* green-max */
+        vnc_write_u16(vs, vs->client_pf.bmax);     /* blue-max */
+        vnc_write_u8(vs, vs->client_pf.rshift);    /* red-shift */
+        vnc_write_u8(vs, vs->client_pf.gshift);    /* green-shift */
+        vnc_write_u8(vs, vs->client_pf.bshift);    /* blue-shift */
+        vnc_write(vs, pad, 3);           /* padding */
+    }
     vnc_hextile_set_pixel_conversion(vs, 0);
     vs->write_pixels = vnc_write_pixels_copy;
 }
@@ -2252,7 +2259,7 @@ static void vnc_colordepth(VncState *vs)
                                pixman_image_get_width(vs->vd->server),
                                pixman_image_get_height(vs->vd->server),
                                VNC_ENCODING_WMVi);
-        pixel_format_message(vs);
+        pixel_format_message(vs, false);
         vnc_unlock_output(vs);
         vnc_flush(vs);
     } else {
@@ -2420,7 +2427,8 @@ static int protocol_client_msg(VncState *vs, uint8_t *data, size_t len)
     return 0;
 }
 
-static int protocol_client_init(VncState *vs, uint8_t *data, size_t len)
+static int protocol_client_init_base(VncState *vs, uint8_t *data, size_t len,
+                                     bool reuse)
 {
     char buf[1024];
     VncShareMode mode;
@@ -2495,10 +2503,11 @@ static int protocol_client_init(VncState *vs, uint8_t *data, size_t len)
            pixman_image_get_height(vs->vd->server) >= 0);
     vs->client_width = pixman_image_get_width(vs->vd->server);
     vs->client_height = pixman_image_get_height(vs->vd->server);
-    vnc_write_u16(vs, vs->client_width);
-    vnc_write_u16(vs, vs->client_height);
-
-    pixel_format_message(vs);
+    if (!reuse) {
+        vnc_write_u16(vs, vs->client_width);
+        vnc_write_u16(vs, vs->client_height);
+    }
+    pixel_format_message(vs, reuse);
 
     if (qemu_name) {
         size = snprintf(buf, sizeof(buf), "QEMU (%s)", qemu_name);
@@ -2509,9 +2518,11 @@ static int protocol_client_init(VncState *vs, uint8_t *data, size_t len)
         size = snprintf(buf, sizeof(buf), "QEMU");
     }
 
-    vnc_write_u32(vs, size);
-    vnc_write(vs, buf, size);
-    vnc_flush(vs);
+    if (!reuse) {
+        vnc_write_u32(vs, size);
+        vnc_write(vs, buf, size);
+        vnc_flush(vs);
+    }
 
     vnc_client_cache_auth(vs);
     vnc_qmp_event(vs, QAPI_EVENT_VNC_INITIALIZED);
@@ -2521,6 +2532,11 @@ static int protocol_client_init(VncState *vs, uint8_t *data, size_t len)
     return 0;
 }
 
+static int protocol_client_init(VncState *vs, uint8_t *data, size_t len)
+{
+    return protocol_client_init_base(vs, data, len, false);
+}
+
 void start_client_init(VncState *vs)
 {
     vnc_read_when(vs, protocol_client_init, 1);
@@ -3012,8 +3028,12 @@ static void vnc_refresh(DisplayChangeListener *dcl)
     }
 }
 
+/*
+ * reuse - true if we are using an existing (already initialized)
+ * connection to a vnc client
+ */
 static void vnc_connect(VncDisplay *vd, QIOChannelSocket *sioc,
-                        bool skipauth, bool websocket)
+                        bool skipauth, bool websocket, bool reuse)
 {
     VncState *vs = g_new0(VncState, 1);
     bool first_client = QTAILQ_EMPTY(&vd->clients);
@@ -3109,10 +3129,15 @@ static void vnc_connect(VncDisplay *vd, QIOChannelSocket *sioc,
 
     graphic_hw_update(vd->dcl.con);
 
-    if (!vs->websocket) {
+    if ((!vs->websocket) && !reuse) {
         vnc_start_protocol(vs);
     }
 
+    if (reuse) {
+        uint8_t data[1] = {0};
+        (void) protocol_client_init_base(vs, data, sizeof(data), true);
+    }
+
     if (vd->num_connecting > vd->connections_limit) {
         QTAILQ_FOREACH(vs, &vd->clients, next) {
             if (vs->share_mode == VNC_SHARE_MODE_CONNECTING) {
@@ -3143,7 +3168,7 @@ static void vnc_listen_io(QIONetListener *listener,
     qio_channel_set_name(QIO_CHANNEL(cioc),
                          isWebsock ? "vnc-ws-server" : "vnc-server");
     qio_channel_set_delay(QIO_CHANNEL(cioc), false);
-    vnc_connect(vd, cioc, false, isWebsock);
+    vnc_connect(vd, cioc, false, isWebsock, false);
 }
 
 static const DisplayChangeListenerOps dcl_ops = {
@@ -3733,7 +3758,7 @@ static int vnc_display_connect(VncDisplay *vd,
     if (qio_channel_socket_connect_sync(sioc, saddr[0], errp) < 0) {
         return -1;
     }
-    vnc_connect(vd, sioc, false, false);
+    vnc_connect(vd, sioc, false, false, false);
     object_unref(OBJECT(sioc));
     return 0;
 }
@@ -4057,7 +4082,7 @@ void vnc_display_add_client(const char *id, int csock, bool skipauth)
     sioc = qio_channel_socket_new_fd(csock, NULL);
     if (sioc) {
         qio_channel_set_name(QIO_CHANNEL(sioc), "vnc-server");
-        vnc_connect(vd, sioc, skipauth, false);
+        vnc_connect(vd, sioc, skipauth, false, false);
         object_unref(OBJECT(sioc));
     }
 }
@@ -4117,3 +4142,75 @@ static void vnc_register_config(void)
     qemu_add_opts(&qemu_vnc_opts);
 }
 opts_init(vnc_register_config);
+
+void save_vnc_fds(void)
+{
+    VncDisplay *vd;
+    VncState *vs;
+    int disp_num = 0;
+    char name[40];
+
+    QTAILQ_FOREACH(vd, &vnc_displays, next) {
+        QTAILQ_FOREACH(vs, &vd->clients, next) {
+            if (vs->sioc) {
+                snprintf(name, sizeof(name), "%s_%d", vs->sioc->parent.name,
+                         disp_num);
+                setenv_fd(name, vs->sioc->fd);
+                break;
+            }
+        }
+        disp_num++;
+    }
+}
+
+static void set_vnc_fd(char *name, QIOChannelSocket *cioc, VncDisplay *vd,
+                       bool isWebsock)
+{
+    VncState *vs;
+    QIOChannelSocket *sioc;
+
+    int fd = getenv_fd(name);
+    if (fd != -1) {
+        sioc = qio_channel_socket_accept(cioc, fd, NULL);
+        if (sioc) {
+            unsetenv_fd(name);
+            qio_channel_set_name(QIO_CHANNEL(sioc),
+                                 isWebsock ? "vnc-ws-server" : "vnc-server");
+
+            qio_channel_set_delay(QIO_CHANNEL(sioc), false);
+            vnc_connect(vd, sioc, false, isWebsock, true);
+            object_unref(OBJECT(sioc));
+
+            /* force update on all clients */
+            QTAILQ_FOREACH(vs, &vd->clients, next) {
+                vs->update = VNC_STATE_UPDATE_FORCE;
+            }
+        } else {
+            error_printf("Could not restore vnc channel %s; "
+                     "client must reconnect.\n", name);
+        }
+    }
+}
+
+void load_vnc_fds(void)
+{
+    VncDisplay *vd;
+    QIOChannelSocket *cioc = NULL;
+    int disp_num = 0;
+    char name[40];
+
+    QTAILQ_FOREACH(vd, &vnc_displays, next) {
+        if (vd->listener) {
+            cioc = *vd->listener->sioc;
+            snprintf(name, sizeof(name), "vnc-server_%d", disp_num);
+            set_vnc_fd(name, cioc, vd, false);
+        }
+
+        if (vd->wslistener) {
+            cioc = *vd->wslistener->sioc;
+            snprintf(name, sizeof(name), "vnc-ws-server_%d", disp_num);
+            set_vnc_fd(name, cioc, vd, true);
+        }
+        disp_num++;
+    }
+}
-- 
1.8.3.1


