Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991DAC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 06:05:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E39B207D3
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 06:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VdZSCaY8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E39B207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdpBy-0002AX-JM
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 02:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jdp6b-0002ac-85
 for qemu-devel@nongnu.org; Wed, 27 May 2020 01:59:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52918
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jdp6X-0004Ef-TC
 for qemu-devel@nongnu.org; Wed, 27 May 2020 01:59:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590559192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bpvpcuEGOqp5VHCVEPcPDdZOHjY9q7vpnxF50Uyhw6Q=;
 b=VdZSCaY8oktsEgnF5Df/rAP34QjPXIM68yD/B+/YZB+2g+MEpix2eUGr2a1R5hEP/dqNLh
 1YbkLa8Gc/VdYZGQygvNSyRkAJjgJpUBhsp2Qz3RxG3YRPMfUFRo4FqZpQ2YtVtwAWI1nQ
 ydnXwJR8swIKejcjb0i/pn/J05Hnono=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-sqApCiexPgWQXDyTbFNUtw-1; Wed, 27 May 2020 01:59:50 -0400
X-MC-Unique: sqApCiexPgWQXDyTbFNUtw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58A2C1855A0C
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 05:59:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 046C07A1E1;
 Wed, 27 May 2020 05:59:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EF62E113639D; Wed, 27 May 2020 07:59:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/10] error: Use error_reportf_err() where appropriate
Date: Wed, 27 May 2020 07:59:40 +0200
Message-Id: <20200527055945.6774-6-armbru@redhat.com>
In-Reply-To: <20200527055945.6774-1-armbru@redhat.com>
References: <20200527055945.6774-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 01:25:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace

    error_report("...: %s", ..., error_get_pretty(err));

by

    error_reportf_err(err, "...: ", ...);

One of the replaced messages lacked a colon.  Add it.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200505101908.6207-6-armbru@redhat.com>
---
 chardev/char-socket.c | 5 +++--
 hw/sd/pxa2xx_mmci.c   | 4 ++--
 hw/sd/sd.c            | 4 ++--
 hw/usb/dev-mtp.c      | 9 +++++----
 qemu-nbd.c            | 7 +++----
 scsi/qemu-pr-helper.c | 4 ++--
 6 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index e77699db48..db253d4024 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -138,8 +138,9 @@ static void check_report_connect_error(Chardev *chr,
     SocketChardev *s = SOCKET_CHARDEV(chr);
 
     if (!s->connect_err_reported) {
-        error_report("Unable to connect character device %s: %s",
-                     chr->label, error_get_pretty(err));
+        error_reportf_err(err,
+                          "Unable to connect character device %s: ",
+                          chr->label);
         s->connect_err_reported = true;
     }
     qemu_chr_socket_restart_timer(chr);
diff --git a/hw/sd/pxa2xx_mmci.c b/hw/sd/pxa2xx_mmci.c
index 8f9ab0ec16..f9c50ddda5 100644
--- a/hw/sd/pxa2xx_mmci.c
+++ b/hw/sd/pxa2xx_mmci.c
@@ -497,12 +497,12 @@ PXA2xxMMCIState *pxa2xx_mmci_init(MemoryRegion *sysmem,
     carddev = qdev_create(qdev_get_child_bus(dev, "sd-bus"), TYPE_SD_CARD);
     qdev_prop_set_drive(carddev, "drive", blk, &err);
     if (err) {
-        error_report("failed to init SD card: %s", error_get_pretty(err));
+        error_reportf_err(err, "failed to init SD card: ");
         return NULL;
     }
     object_property_set_bool(OBJECT(carddev), true, "realized", &err);
     if (err) {
-        error_report("failed to init SD card: %s", error_get_pretty(err));
+        error_reportf_err(err, "failed to init SD card: ");
         return NULL;
     }
 
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 71a9af09ab..3c06a0ac6d 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -703,13 +703,13 @@ SDState *sd_init(BlockBackend *blk, bool is_spi)
     dev = DEVICE(obj);
     qdev_prop_set_drive(dev, "drive", blk, &err);
     if (err) {
-        error_report("sd_init failed: %s", error_get_pretty(err));
+        error_reportf_err(err, "sd_init failed: ");
         return NULL;
     }
     qdev_prop_set_bit(dev, "spi", is_spi);
     object_property_set_bool(obj, true, "realized", &err);
     if (err) {
-        error_report("sd_init failed: %s", error_get_pretty(err));
+        error_reportf_err(err, "sd_init failed: ");
         return NULL;
     }
 
diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 20717f026b..168428156b 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -631,8 +631,9 @@ static void usb_mtp_object_readdir(MTPState *s, MTPObject *o)
         int64_t id = qemu_file_monitor_add_watch(s->file_monitor, o->path, NULL,
                                                  file_monitor_event, s, &err);
         if (id == -1) {
-            error_report("usb-mtp: failed to add watch for %s: %s", o->path,
-                         error_get_pretty(err));
+            error_reportf_err(err,
+                              "usb-mtp: failed to add watch for %s: ",
+                              o->path);
             error_free(err);
         } else {
             trace_usb_mtp_file_monitor_event(s->dev.addr, o->path,
@@ -1276,8 +1277,8 @@ static void usb_mtp_command(MTPState *s, MTPControl *c)
 
         s->file_monitor = qemu_file_monitor_new(&err);
         if (err) {
-            error_report("usb-mtp: file monitoring init failed: %s",
-                         error_get_pretty(err));
+            error_reportf_err(err,
+                              "usb-mtp: file monitoring init failed: ");
             error_free(err);
         } else {
             QTAILQ_INIT(&s->events);
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 306e44fb0a..d2657b8db5 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -856,8 +856,7 @@ int main(int argc, char **argv)
         }
         tlscreds = nbd_get_tls_creds(tlscredsid, list, &local_err);
         if (local_err) {
-            error_report("Failed to get TLS creds %s",
-                         error_get_pretty(local_err));
+            error_reportf_err(local_err, "Failed to get TLS creds: ");
             exit(EXIT_FAILURE);
         }
     } else {
@@ -983,8 +982,8 @@ int main(int argc, char **argv)
                                              &local_err);
             if (sioc == NULL) {
                 object_unref(OBJECT(server));
-                error_report("Failed to use socket activation: %s",
-                             error_get_pretty(local_err));
+                error_reportf_err(local_err,
+                                  "Failed to use socket activation: ");
                 exit(EXIT_FAILURE);
             }
             qio_net_listener_add(server, sioc);
diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index 181ed4a186..57ad830d54 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -1030,8 +1030,8 @@ int main(int argc, char **argv)
         server_ioc = qio_channel_socket_new_fd(FIRST_SOCKET_ACTIVATION_FD,
                                                &local_err);
         if (server_ioc == NULL) {
-            error_report("Failed to use socket activation: %s",
-                         error_get_pretty(local_err));
+            error_reportf_err(local_err,
+                              "Failed to use socket activation: ");
             exit(EXIT_FAILURE);
         }
     }
-- 
2.21.3


