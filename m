Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAF0C4742C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 22:21:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DE8B20FC3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 22:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IXXiR5KX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DE8B20FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYGIH-0002Y8-3z
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 18:21:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kYG1e-0003ug-Ev
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 18:04:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42009)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kYG1Q-0006eK-Pf
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 18:04:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604009031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ghGtQGb+4l5vTeOq5EcJj/Yo0EHPLxl5VGbxEaF22Yo=;
 b=IXXiR5KXr56MuwZJW/5bMPZNiUiwXIhgMQStpzWI6eRVjvfAbA11pIjAfAuK73pWuZMvpS
 6DM+RfrN2veLeLwdfyZdtf43ulMZPnFCeZJpXsCy3QiU6hVaU9TgpnTJuaBojy0SK3yS1V
 hTrw+beUuHW+5kdHAndkCB+t5kgh57Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-V-z-WGJaOwy6R88EMbiifg-1; Thu, 29 Oct 2020 18:03:50 -0400
X-MC-Unique: V-z-WGJaOwy6R88EMbiifg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4722C1018F7A;
 Thu, 29 Oct 2020 22:03:48 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8958D5B4A4;
 Thu, 29 Oct 2020 22:03:41 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 25/36] qdev: Rename qdev_get_prop_ptr() to
 object_static_prop_ptr()
Date: Thu, 29 Oct 2020 18:02:35 -0400
Message-Id: <20201029220246.472693-26-ehabkost@redhat.com>
In-Reply-To: <20201029220246.472693-1-ehabkost@redhat.com>
References: <20201029220246.472693-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Paul Durrant <paul@xen.org>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-block@nongnu.org,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 David Hildenbrand <david@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-s390x@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The function will be moved to common QOM code, as it is not
specific to TYPE_DEVICE anymore.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Paul Durrant <paul@xen.org>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: David Hildenbrand <david@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Cc: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org
Cc: qemu-block@nongnu.org
Cc: qemu-s390x@nongnu.org
---
 include/hw/qdev-properties.h     |  2 +-
 backends/tpm/tpm_util.c          |  6 +--
 hw/block/xen-block.c             |  4 +-
 hw/core/qdev-properties-system.c | 46 +++++++++++------------
 hw/core/qdev-properties.c        | 64 ++++++++++++++++----------------
 hw/s390x/css.c                   |  4 +-
 hw/s390x/s390-pci-bus.c          |  4 +-
 hw/vfio/pci-quirks.c             |  4 +-
 8 files changed, 67 insertions(+), 67 deletions(-)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 0acc92ae2b..4146dac281 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -332,7 +332,7 @@ void qdev_prop_set_macaddr(DeviceState *dev, const char *name,
                            const uint8_t *value);
 void qdev_prop_set_enum(DeviceState *dev, const char *name, int value);
 
-void *qdev_get_prop_ptr(Object *obj, Property *prop);
+void *object_static_prop_ptr(Object *obj, Property *prop);
 
 void qdev_prop_register_global(GlobalProperty *prop);
 const GlobalProperty *qdev_find_global_prop(Object *obj,
diff --git a/backends/tpm/tpm_util.c b/backends/tpm/tpm_util.c
index 042cacfcca..2b5f788861 100644
--- a/backends/tpm/tpm_util.c
+++ b/backends/tpm/tpm_util.c
@@ -35,7 +35,7 @@
 static void get_tpm(Object *obj, Visitor *v, const char *name, void *opaque,
                     Error **errp)
 {
-    TPMBackend **be = qdev_get_prop_ptr(obj, opaque);
+    TPMBackend **be = object_static_prop_ptr(obj, opaque);
     char *p;
 
     p = g_strdup(*be ? (*be)->id : "");
@@ -47,7 +47,7 @@ static void set_tpm(Object *obj, Visitor *v, const char *name, void *opaque,
                     Error **errp)
 {
     Property *prop = opaque;
-    TPMBackend *s, **be = qdev_get_prop_ptr(obj, prop);
+    TPMBackend *s, **be = object_static_prop_ptr(obj, prop);
     char *str;
 
     if (!visit_type_str(v, name, &str, errp)) {
@@ -67,7 +67,7 @@ static void set_tpm(Object *obj, Visitor *v, const char *name, void *opaque,
 static void release_tpm(Object *obj, const char *name, void *opaque)
 {
     Property *prop = opaque;
-    TPMBackend **be = qdev_get_prop_ptr(obj, prop);
+    TPMBackend **be = object_static_prop_ptr(obj, prop);
 
     if (*be) {
         tpm_backend_reset(*be);
diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index bd1aef63a7..20985c465a 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -336,7 +336,7 @@ static void xen_block_get_vdev(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
     Property *prop = opaque;
-    XenBlockVdev *vdev = qdev_get_prop_ptr(obj, prop);
+    XenBlockVdev *vdev = object_static_prop_ptr(obj, prop);
     char *str;
 
     switch (vdev->type) {
@@ -396,7 +396,7 @@ static void xen_block_set_vdev(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
     Property *prop = opaque;
-    XenBlockVdev *vdev = qdev_get_prop_ptr(obj, prop);
+    XenBlockVdev *vdev = object_static_prop_ptr(obj, prop);
     char *str, *p;
     const char *end;
 
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index d9355053d2..448d77ecab 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -60,7 +60,7 @@ static void get_drive(Object *obj, Visitor *v, const char *name, void *opaque,
                       Error **errp)
 {
     Property *prop = opaque;
-    void **ptr = qdev_get_prop_ptr(obj, prop);
+    void **ptr = object_static_prop_ptr(obj, prop);
     const char *value;
     char *p;
 
@@ -86,7 +86,7 @@ static void set_drive_helper(Object *obj, Visitor *v, const char *name,
 {
     DeviceState *dev = DEVICE(obj);
     Property *prop = opaque;
-    void **ptr = qdev_get_prop_ptr(obj, prop);
+    void **ptr = object_static_prop_ptr(obj, prop);
     char *str;
     BlockBackend *blk;
     bool blk_created = false;
@@ -179,7 +179,7 @@ static void release_drive(Object *obj, const char *name, void *opaque)
 {
     DeviceState *dev = DEVICE(obj);
     Property *prop = opaque;
-    BlockBackend **ptr = qdev_get_prop_ptr(obj, prop);
+    BlockBackend **ptr = object_static_prop_ptr(obj, prop);
 
     if (*ptr) {
         AioContext *ctx = blk_get_aio_context(*ptr);
@@ -212,7 +212,7 @@ const PropertyInfo qdev_prop_drive_iothread = {
 static void get_chr(Object *obj, Visitor *v, const char *name, void *opaque,
                     Error **errp)
 {
-    CharBackend *be = qdev_get_prop_ptr(obj, opaque);
+    CharBackend *be = object_static_prop_ptr(obj, opaque);
     char *p;
 
     p = g_strdup(be->chr && be->chr->label ? be->chr->label : "");
@@ -224,7 +224,7 @@ static void set_chr(Object *obj, Visitor *v, const char *name, void *opaque,
                     Error **errp)
 {
     Property *prop = opaque;
-    CharBackend *be = qdev_get_prop_ptr(obj, prop);
+    CharBackend *be = object_static_prop_ptr(obj, prop);
     Chardev *s;
     char *str;
 
@@ -260,7 +260,7 @@ static void set_chr(Object *obj, Visitor *v, const char *name, void *opaque,
 static void release_chr(Object *obj, const char *name, void *opaque)
 {
     Property *prop = opaque;
-    CharBackend *be = qdev_get_prop_ptr(obj, prop);
+    CharBackend *be = object_static_prop_ptr(obj, prop);
 
     qemu_chr_fe_deinit(be, false);
 }
@@ -284,7 +284,7 @@ static void get_mac(Object *obj, Visitor *v, const char *name, void *opaque,
                     Error **errp)
 {
     Property *prop = opaque;
-    MACAddr *mac = qdev_get_prop_ptr(obj, prop);
+    MACAddr *mac = object_static_prop_ptr(obj, prop);
     char buffer[2 * 6 + 5 + 1];
     char *p = buffer;
 
@@ -299,7 +299,7 @@ static void set_mac(Object *obj, Visitor *v, const char *name, void *opaque,
                     Error **errp)
 {
     Property *prop = opaque;
-    MACAddr *mac = qdev_get_prop_ptr(obj, prop);
+    MACAddr *mac = object_static_prop_ptr(obj, prop);
     int i, pos;
     char *str;
     const char *p;
@@ -361,7 +361,7 @@ static void get_netdev(Object *obj, Visitor *v, const char *name,
                        void *opaque, Error **errp)
 {
     Property *prop = opaque;
-    NICPeers *peers_ptr = qdev_get_prop_ptr(obj, prop);
+    NICPeers *peers_ptr = object_static_prop_ptr(obj, prop);
     char *p = g_strdup(peers_ptr->ncs[0] ? peers_ptr->ncs[0]->name : "");
 
     visit_type_str(v, name, &p, errp);
@@ -372,7 +372,7 @@ static void set_netdev(Object *obj, Visitor *v, const char *name,
                        void *opaque, Error **errp)
 {
     Property *prop = opaque;
-    NICPeers *peers_ptr = qdev_get_prop_ptr(obj, prop);
+    NICPeers *peers_ptr = object_static_prop_ptr(obj, prop);
     NetClientState **ncs = peers_ptr->ncs;
     NetClientState *peers[MAX_QUEUE_NUM];
     int queues, err = 0, i = 0;
@@ -434,7 +434,7 @@ static void get_audiodev(Object *obj, Visitor *v, const char* name,
                          void *opaque, Error **errp)
 {
     Property *prop = opaque;
-    QEMUSoundCard *card = qdev_get_prop_ptr(obj, prop);
+    QEMUSoundCard *card = object_static_prop_ptr(obj, prop);
     char *p = g_strdup(audio_get_id(card));
 
     visit_type_str(v, name, &p, errp);
@@ -445,7 +445,7 @@ static void set_audiodev(Object *obj, Visitor *v, const char* name,
                          void *opaque, Error **errp)
 {
     Property *prop = opaque;
-    QEMUSoundCard *card = qdev_get_prop_ptr(obj, prop);
+    QEMUSoundCard *card = object_static_prop_ptr(obj, prop);
     AudioState *state;
     int err = 0;
     char *str;
@@ -547,7 +547,7 @@ static void set_blocksize(Object *obj, Visitor *v, const char *name,
 {
     DeviceState *dev = DEVICE(obj);
     Property *prop = opaque;
-    uint32_t *ptr = qdev_get_prop_ptr(obj, prop);
+    uint32_t *ptr = object_static_prop_ptr(obj, prop);
     uint64_t value;
     Error *local_err = NULL;
 
@@ -635,7 +635,7 @@ static void get_reserved_region(Object *obj, Visitor *v, const char *name,
                                 void *opaque, Error **errp)
 {
     Property *prop = opaque;
-    ReservedRegion *rr = qdev_get_prop_ptr(obj, prop);
+    ReservedRegion *rr = object_static_prop_ptr(obj, prop);
     char buffer[64];
     char *p = buffer;
     int rc;
@@ -651,7 +651,7 @@ static void set_reserved_region(Object *obj, Visitor *v, const char *name,
                                 void *opaque, Error **errp)
 {
     Property *prop = opaque;
-    ReservedRegion *rr = qdev_get_prop_ptr(obj, prop);
+    ReservedRegion *rr = object_static_prop_ptr(obj, prop);
     Error *local_err = NULL;
     const char *endptr;
     char *str;
@@ -713,7 +713,7 @@ static void set_pci_devfn(Object *obj, Visitor *v, const char *name,
                           void *opaque, Error **errp)
 {
     Property *prop = opaque;
-    int32_t value, *ptr = qdev_get_prop_ptr(obj, prop);
+    int32_t value, *ptr = object_static_prop_ptr(obj, prop);
     unsigned int slot, fn, n;
     char *str;
 
@@ -751,7 +751,7 @@ invalid:
 static int print_pci_devfn(Object *obj, Property *prop, char *dest,
                            size_t len)
 {
-    int32_t *ptr = qdev_get_prop_ptr(obj, prop);
+    int32_t *ptr = object_static_prop_ptr(obj, prop);
 
     if (*ptr == -1) {
         return snprintf(dest, len, "<unset>");
@@ -775,7 +775,7 @@ static void get_pci_host_devaddr(Object *obj, Visitor *v, const char *name,
                                  void *opaque, Error **errp)
 {
     Property *prop = opaque;
-    PCIHostDeviceAddress *addr = qdev_get_prop_ptr(obj, prop);
+    PCIHostDeviceAddress *addr = object_static_prop_ptr(obj, prop);
     char buffer[] = "ffff:ff:ff.f";
     char *p = buffer;
     int rc = 0;
@@ -801,7 +801,7 @@ static void set_pci_host_devaddr(Object *obj, Visitor *v, const char *name,
                                  void *opaque, Error **errp)
 {
     Property *prop = opaque;
-    PCIHostDeviceAddress *addr = qdev_get_prop_ptr(obj, prop);
+    PCIHostDeviceAddress *addr = object_static_prop_ptr(obj, prop);
     char *str, *p;
     const char *e;
     unsigned long val;
@@ -890,7 +890,7 @@ static void get_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
 {
     Property *prop = opaque;
-    PCIExpLinkSpeed *p = qdev_get_prop_ptr(obj, prop);
+    PCIExpLinkSpeed *p = object_static_prop_ptr(obj, prop);
     int speed;
 
     switch (*p) {
@@ -918,7 +918,7 @@ static void set_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
 {
     Property *prop = opaque;
-    PCIExpLinkSpeed *p = qdev_get_prop_ptr(obj, prop);
+    PCIExpLinkSpeed *p = object_static_prop_ptr(obj, prop);
     int speed;
 
     if (!visit_type_enum(v, prop->name, &speed, prop->info->enum_table,
@@ -960,7 +960,7 @@ static void get_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
 {
     Property *prop = opaque;
-    PCIExpLinkWidth *p = qdev_get_prop_ptr(obj, prop);
+    PCIExpLinkWidth *p = object_static_prop_ptr(obj, prop);
     int width;
 
     switch (*p) {
@@ -997,7 +997,7 @@ static void set_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
 {
     Property *prop = opaque;
-    PCIExpLinkWidth *p = qdev_get_prop_ptr(obj, prop);
+    PCIExpLinkWidth *p = object_static_prop_ptr(obj, prop);
     int width;
 
     if (!visit_type_enum(v, prop->name, &width, prop->info->enum_table,
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index e4aba2b237..0b53e5ba63 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -51,7 +51,7 @@ void qdev_prop_allow_set_link_before_realize(const Object *obj,
     }
 }
 
-void *qdev_get_prop_ptr(Object *obj, Property *prop)
+void *object_static_prop_ptr(Object *obj, Property *prop)
 {
     void *ptr = obj;
     ptr += prop->offset;
@@ -97,7 +97,7 @@ void object_propinfo_get_enum(Object *obj, Visitor *v, const char *name,
                             void *opaque, Error **errp)
 {
     Property *prop = opaque;
-    int *ptr = qdev_get_prop_ptr(obj, prop);
+    int *ptr = object_static_prop_ptr(obj, prop);
 
     visit_type_enum(v, prop->name, ptr, prop->info->enum_table, errp);
 }
@@ -106,7 +106,7 @@ void object_propinfo_set_enum(Object *obj, Visitor *v, const char *name,
                             void *opaque, Error **errp)
 {
     Property *prop = opaque;
-    int *ptr = qdev_get_prop_ptr(obj, prop);
+    int *ptr = object_static_prop_ptr(obj, prop);
 
     visit_type_enum(v, prop->name, ptr, prop->info->enum_table, errp);
 }
@@ -135,7 +135,7 @@ static uint32_t qdev_get_prop_mask(Property *prop)
 
 static void bit_prop_set(Object *obj, Property *props, bool val)
 {
-    uint32_t *p = qdev_get_prop_ptr(obj, props);
+    uint32_t *p = object_static_prop_ptr(obj, props);
     uint32_t mask = qdev_get_prop_mask(props);
     if (val) {
         *p |= mask;
@@ -148,7 +148,7 @@ static void prop_get_bit(Object *obj, Visitor *v, const char *name,
                          void *opaque, Error **errp)
 {
     Property *prop = opaque;
-    uint32_t *p = qdev_get_prop_ptr(obj, prop);
+    uint32_t *p = object_static_prop_ptr(obj, prop);
     bool value = (*p & qdev_get_prop_mask(prop)) != 0;
 
     visit_type_bool(v, name, &value, errp);
@@ -189,7 +189,7 @@ static uint64_t qdev_get_prop_mask64(Property *prop)
 
 static void bit64_prop_set(Object *obj, Property *props, bool val)
 {
-    uint64_t *p = qdev_get_prop_ptr(obj, props);
+    uint64_t *p = object_static_prop_ptr(obj, props);
     uint64_t mask = qdev_get_prop_mask64(props);
     if (val) {
         *p |= mask;
@@ -202,7 +202,7 @@ static void prop_get_bit64(Object *obj, Visitor *v, const char *name,
                            void *opaque, Error **errp)
 {
     Property *prop = opaque;
-    uint64_t *p = qdev_get_prop_ptr(obj, prop);
+    uint64_t *p = object_static_prop_ptr(obj, prop);
     bool value = (*p & qdev_get_prop_mask64(prop)) != 0;
 
     visit_type_bool(v, name, &value, errp);
@@ -234,7 +234,7 @@ static void get_bool(Object *obj, Visitor *v, const char *name, void *opaque,
                      Error **errp)
 {
     Property *prop = opaque;
-    bool *ptr = qdev_get_prop_ptr(obj, prop);
+    bool *ptr = object_static_prop_ptr(obj, prop);
 
     visit_type_bool(v, name, ptr, errp);
 }
@@ -243,7 +243,7 @@ static void set_bool(Object *obj, Visitor *v, const char *name, void *opaque,
                      Error **errp)
 {
     Property *prop = opaque;
-    bool *ptr = qdev_get_prop_ptr(obj, prop);
+    bool *ptr = object_static_prop_ptr(obj, prop);
 
     visit_type_bool(v, name, ptr, errp);
 }
@@ -261,7 +261,7 @@ static void get_uint8(Object *obj, Visitor *v, const char *name, void *opaque,
                       Error **errp)
 {
     Property *prop = opaque;
-    uint8_t *ptr = qdev_get_prop_ptr(obj, prop);
+    uint8_t *ptr = object_static_prop_ptr(obj, prop);
 
     visit_type_uint8(v, name, ptr, errp);
 }
@@ -270,7 +270,7 @@ static void set_uint8(Object *obj, Visitor *v, const char *name, void *opaque,
                       Error **errp)
 {
     Property *prop = opaque;
-    uint8_t *ptr = qdev_get_prop_ptr(obj, prop);
+    uint8_t *ptr = object_static_prop_ptr(obj, prop);
 
     visit_type_uint8(v, name, ptr, errp);
 }
@@ -300,7 +300,7 @@ static void get_uint16(Object *obj, Visitor *v, const char *name,
                        void *opaque, Error **errp)
 {
     Property *prop = opaque;
-    uint16_t *ptr = qdev_get_prop_ptr(obj, prop);
+    uint16_t *ptr = object_static_prop_ptr(obj, prop);
 
     visit_type_uint16(v, name, ptr, errp);
 }
@@ -309,7 +309,7 @@ static void set_uint16(Object *obj, Visitor *v, const char *name,
                        void *opaque, Error **errp)
 {
     Property *prop = opaque;
-    uint16_t *ptr = qdev_get_prop_ptr(obj, prop);
+    uint16_t *ptr = object_static_prop_ptr(obj, prop);
 
     visit_type_uint16(v, name, ptr, errp);
 }
@@ -327,7 +327,7 @@ static void get_uint32(Object *obj, Visitor *v, const char *name,
                        void *opaque, Error **errp)
 {
     Property *prop = opaque;
-    uint32_t *ptr = qdev_get_prop_ptr(obj, prop);
+    uint32_t *ptr = object_static_prop_ptr(obj, prop);
 
     visit_type_uint32(v, name, ptr, errp);
 }
@@ -336,7 +336,7 @@ static void set_uint32(Object *obj, Visitor *v, const char *name,
                        void *opaque, Error **errp)
 {
     Property *prop = opaque;
-    uint32_t *ptr = qdev_get_prop_ptr(obj, prop);
+    uint32_t *ptr = object_static_prop_ptr(obj, prop);
 
     visit_type_uint32(v, name, ptr, errp);
 }
@@ -345,7 +345,7 @@ void object_propinfo_get_int32(Object *obj, Visitor *v, const char *name,
                              void *opaque, Error **errp)
 {
     Property *prop = opaque;
-    int32_t *ptr = qdev_get_prop_ptr(obj, prop);
+    int32_t *ptr = object_static_prop_ptr(obj, prop);
 
     visit_type_int32(v, name, ptr, errp);
 }
@@ -354,7 +354,7 @@ static void set_int32(Object *obj, Visitor *v, const char *name, void *opaque,
                       Error **errp)
 {
     Property *prop = opaque;
-    int32_t *ptr = qdev_get_prop_ptr(obj, prop);
+    int32_t *ptr = object_static_prop_ptr(obj, prop);
 
     visit_type_int32(v, name, ptr, errp);
 }
@@ -379,7 +379,7 @@ static void get_uint64(Object *obj, Visitor *v, const char *name,
                        void *opaque, Error **errp)
 {
     Property *prop = opaque;
-    uint64_t *ptr = qdev_get_prop_ptr(obj, prop);
+    uint64_t *ptr = object_static_prop_ptr(obj, prop);
 
     visit_type_uint64(v, name, ptr, errp);
 }
@@ -388,7 +388,7 @@ static void set_uint64(Object *obj, Visitor *v, const char *name,
                        void *opaque, Error **errp)
 {
     Property *prop = opaque;
-    uint64_t *ptr = qdev_get_prop_ptr(obj, prop);
+    uint64_t *ptr = object_static_prop_ptr(obj, prop);
 
     visit_type_uint64(v, name, ptr, errp);
 }
@@ -397,7 +397,7 @@ static void get_int64(Object *obj, Visitor *v, const char *name,
                       void *opaque, Error **errp)
 {
     Property *prop = opaque;
-    int64_t *ptr = qdev_get_prop_ptr(obj, prop);
+    int64_t *ptr = object_static_prop_ptr(obj, prop);
 
     visit_type_int64(v, name, ptr, errp);
 }
@@ -406,7 +406,7 @@ static void set_int64(Object *obj, Visitor *v, const char *name,
                       void *opaque, Error **errp)
 {
     Property *prop = opaque;
-    int64_t *ptr = qdev_get_prop_ptr(obj, prop);
+    int64_t *ptr = object_static_prop_ptr(obj, prop);
 
     visit_type_int64(v, name, ptr, errp);
 }
@@ -430,14 +430,14 @@ const PropertyInfo qdev_prop_int64 = {
 static void release_string(Object *obj, const char *name, void *opaque)
 {
     Property *prop = opaque;
-    g_free(*(char **)qdev_get_prop_ptr(obj, prop));
+    g_free(*(char **)object_static_prop_ptr(obj, prop));
 }
 
 static void get_string(Object *obj, Visitor *v, const char *name,
                        void *opaque, Error **errp)
 {
     Property *prop = opaque;
-    char **ptr = qdev_get_prop_ptr(obj, prop);
+    char **ptr = object_static_prop_ptr(obj, prop);
 
     if (!*ptr) {
         char *str = (char *)"";
@@ -451,7 +451,7 @@ static void set_string(Object *obj, Visitor *v, const char *name,
                        void *opaque, Error **errp)
 {
     Property *prop = opaque;
-    char **ptr = qdev_get_prop_ptr(obj, prop);
+    char **ptr = object_static_prop_ptr(obj, prop);
     char *str;
 
     if (!visit_type_str(v, name, &str, errp)) {
@@ -485,7 +485,7 @@ void object_propinfo_get_size32(Object *obj, Visitor *v, const char *name,
                               void *opaque, Error **errp)
 {
     Property *prop = opaque;
-    uint32_t *ptr = qdev_get_prop_ptr(obj, prop);
+    uint32_t *ptr = object_static_prop_ptr(obj, prop);
     uint64_t value = *ptr;
 
     visit_type_size(v, name, &value, errp);
@@ -495,7 +495,7 @@ static void set_size32(Object *obj, Visitor *v, const char *name, void *opaque,
                        Error **errp)
 {
     Property *prop = opaque;
-    uint32_t *ptr = qdev_get_prop_ptr(obj, prop);
+    uint32_t *ptr = object_static_prop_ptr(obj, prop);
     uint64_t value;
 
     if (!visit_type_size(v, name, &value, errp)) {
@@ -526,7 +526,7 @@ static void get_uuid(Object *obj, Visitor *v, const char *name, void *opaque,
                      Error **errp)
 {
     Property *prop = opaque;
-    QemuUUID *uuid = qdev_get_prop_ptr(obj, prop);
+    QemuUUID *uuid = object_static_prop_ptr(obj, prop);
     char buffer[UUID_FMT_LEN + 1];
     char *p = buffer;
 
@@ -541,7 +541,7 @@ static void set_uuid(Object *obj, Visitor *v, const char *name, void *opaque,
                     Error **errp)
 {
     Property *prop = opaque;
-    QemuUUID *uuid = qdev_get_prop_ptr(obj, prop);
+    QemuUUID *uuid = object_static_prop_ptr(obj, prop);
     char *str;
 
     if (!visit_type_str(v, name, &str, errp)) {
@@ -605,7 +605,7 @@ static ArrayElementProperty *array_element_new(Object *obj,
      * being inside the device struct.
      */
     arrayprop->prop.offset = eltptr - (void *)obj;
-    assert(qdev_get_prop_ptr(obj, &arrayprop->prop) == eltptr);
+    assert(object_static_prop_ptr(obj, &arrayprop->prop) == eltptr);
     return arrayprop;
 }
 
@@ -646,7 +646,7 @@ static void set_prop_arraylen(Object *obj, Visitor *v, const char *name,
      * array itself and dynamically add the corresponding properties.
      */
     Property *prop = opaque;
-    uint32_t *alenptr = qdev_get_prop_ptr(obj, prop);
+    uint32_t *alenptr = object_static_prop_ptr(obj, prop);
     void **arrayptr = (void *)obj + prop->arrayoffset;
     void *eltptr;
     const char *arrayname;
@@ -867,7 +867,7 @@ static void get_size(Object *obj, Visitor *v, const char *name, void *opaque,
                      Error **errp)
 {
     Property *prop = opaque;
-    uint64_t *ptr = qdev_get_prop_ptr(obj, prop);
+    uint64_t *ptr = object_static_prop_ptr(obj, prop);
 
     visit_type_size(v, name, ptr, errp);
 }
@@ -876,7 +876,7 @@ static void set_size(Object *obj, Visitor *v, const char *name, void *opaque,
                      Error **errp)
 {
     Property *prop = opaque;
-    uint64_t *ptr = qdev_get_prop_ptr(obj, prop);
+    uint64_t *ptr = object_static_prop_ptr(obj, prop);
 
     visit_type_size(v, name, ptr, errp);
 }
diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 46cab94e2b..c8e7ce232a 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -2344,7 +2344,7 @@ static void get_css_devid(Object *obj, Visitor *v, const char *name,
                           void *opaque, Error **errp)
 {
     Property *prop = opaque;
-    CssDevId *dev_id = qdev_get_prop_ptr(obj, prop);
+    CssDevId *dev_id = object_static_prop_ptr(obj, prop);
     char buffer[] = "xx.x.xxxx";
     char *p = buffer;
     int r;
@@ -2373,7 +2373,7 @@ static void set_css_devid(Object *obj, Visitor *v, const char *name,
                           void *opaque, Error **errp)
 {
     Property *prop = opaque;
-    CssDevId *dev_id = qdev_get_prop_ptr(obj, prop);
+    CssDevId *dev_id = object_static_prop_ptr(obj, prop);
     char *str;
     int num, n1, n2;
     unsigned int cssid, ssid, devid;
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index d02e93a192..74a469e91d 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1248,7 +1248,7 @@ static void s390_pci_get_fid(Object *obj, Visitor *v, const char *name,
                          void *opaque, Error **errp)
 {
     Property *prop = opaque;
-    uint32_t *ptr = qdev_get_prop_ptr(obj, prop);
+    uint32_t *ptr = object_static_prop_ptr(obj, prop);
 
     visit_type_uint32(v, name, ptr, errp);
 }
@@ -1258,7 +1258,7 @@ static void s390_pci_set_fid(Object *obj, Visitor *v, const char *name,
 {
     S390PCIBusDevice *zpci = S390_PCI_DEVICE(obj);
     Property *prop = opaque;
-    uint32_t *ptr = qdev_get_prop_ptr(obj, prop);
+    uint32_t *ptr = object_static_prop_ptr(obj, prop);
 
     if (!visit_type_uint32(v, name, ptr, errp)) {
         return;
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 802979635c..37cb9ab1fa 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1489,7 +1489,7 @@ static void get_nv_gpudirect_clique_id(Object *obj, Visitor *v,
                                        Error **errp)
 {
     Property *prop = opaque;
-    uint8_t *ptr = qdev_get_prop_ptr(obj, prop);
+    uint8_t *ptr = object_static_prop_ptr(obj, prop);
 
     visit_type_uint8(v, name, ptr, errp);
 }
@@ -1499,7 +1499,7 @@ static void set_nv_gpudirect_clique_id(Object *obj, Visitor *v,
                                        Error **errp)
 {
     Property *prop = opaque;
-    uint8_t value, *ptr = qdev_get_prop_ptr(obj, prop);
+    uint8_t value, *ptr = object_static_prop_ptr(obj, prop);
 
     if (!visit_type_uint8(v, name, &value, errp)) {
         return;
-- 
2.28.0


