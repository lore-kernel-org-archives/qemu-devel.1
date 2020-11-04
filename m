Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545C4C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 17:31:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7730820759
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 17:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WhaUsOVn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7730820759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaMcm-0000mL-9D
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 12:31:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kaMXb-0001Ro-3O
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 12:25:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57012)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kaMXX-0008KK-Ds
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 12:25:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604510742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q5BeNYOZ4RDTFOfuNV6EvBOecZflftp3s5pV01xgFqI=;
 b=WhaUsOVnDkpsIxNfLQzar1rNZwy/plNMQavYBea5cAJG2vlTjKx1pG37JZzMkM93EenxBM
 29d+9a5MsGnorTl3PpoiMluMO0oqIcs+c5YSDv1OV84qKxcdNBhoDObBAZHpNtEFrj5TAc
 WDzVjOVtrHBpb3J1PtJHYydVdXNNubs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-Ue3Ir6wOOOWpdg8TaOCtAA-1; Wed, 04 Nov 2020 12:25:41 -0500
X-MC-Unique: Ue3Ir6wOOOWpdg8TaOCtAA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D20F411BD342;
 Wed,  4 Nov 2020 17:25:38 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E97BE65F5E;
 Wed,  4 Nov 2020 17:25:31 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/7] qom: Add FIELD_PTR,
 a type-safe wrapper for object_field_prop_ptr()
Date: Wed,  4 Nov 2020 12:25:11 -0500
Message-Id: <20201104172512.2381656-7-ehabkost@redhat.com>
In-Reply-To: <20201104172512.2381656-1-ehabkost@redhat.com>
References: <20201104172512.2381656-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "Daniel P. Berrange" <berrange@redhat.com>, xen-devel@lists.xenproject.org,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Paul Durrant <paul@xen.org>, David Hildenbrand <david@redhat.com>,
 qemu-s390x@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-block@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce a FIELD_PTR macro that will ensure the size of the area
we are accessing has the correct size, and will return a pointer
of the correct type.

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
Cc: Thomas Huth <thuth@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: David Hildenbrand <david@redhat.com>
Cc: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org
Cc: qemu-block@nongnu.org
Cc: qemu-s390x@nongnu.org
---
 include/qom/field-property.h     | 21 ++++++++++-
 backends/tpm/tpm_util.c          |  6 ++--
 hw/block/xen-block.c             |  4 +--
 hw/core/qdev-properties-system.c | 50 +++++++++++++-------------
 hw/s390x/css.c                   |  4 +--
 hw/s390x/s390-pci-bus.c          |  4 +--
 hw/vfio/pci-quirks.c             |  4 +--
 qom/field-property.c             |  3 +-
 qom/property-types.c             | 60 +++++++++++++++++---------------
 9 files changed, 89 insertions(+), 67 deletions(-)

diff --git a/include/qom/field-property.h b/include/qom/field-property.h
index 1d3bf9699b..58baaca160 100644
--- a/include/qom/field-property.h
+++ b/include/qom/field-property.h
@@ -125,6 +125,25 @@ object_class_property_add_field(ObjectClass *oc, const char *name,
                                 Property *prop,
                                 ObjectPropertyAllowSet allow_set);
 
-void *object_field_prop_ptr(Object *obj, Property *prop);
+/**
+ * object_field_prop_ptr: Get pointer to property field
+ * @obj: the object instance
+ * @prop: field property definition
+ * @expected_size: expected size of struct field
+ *
+ * Don't use this function directly, use the FIELD_PTR() macro instead.
+ */
+void *object_field_prop_ptr(Object *obj, Property *prop, size_t expected_size);
+
+/**
+ * FIELD_PTR: Get pointer to struct field for property
+ *
+ * This returns a pointer to type @type, pointing to the struct
+ * field containing the property value.
+ *
+ * @type must match the expected type for the property.
+ */
+#define FIELD_PTR(obj, prop, type) \
+    ((type *)object_field_prop_ptr((obj), (prop), sizeof(type)))
 
 #endif
diff --git a/backends/tpm/tpm_util.c b/backends/tpm/tpm_util.c
index 556e21388c..da80379404 100644
--- a/backends/tpm/tpm_util.c
+++ b/backends/tpm/tpm_util.c
@@ -35,7 +35,7 @@
 static void get_tpm(Object *obj, Visitor *v, const char *name,
                     Property *prop, Error **errp)
 {
-    TPMBackend **be = object_field_prop_ptr(obj, prop);
+    TPMBackend **be = FIELD_PTR(obj, prop, TPMBackend *);
     char *p;
 
     p = g_strdup(*be ? (*be)->id : "");
@@ -46,7 +46,7 @@ static void get_tpm(Object *obj, Visitor *v, const char *name,
 static void set_tpm(Object *obj, Visitor *v, const char *name,
                     Property *prop, Error **errp)
 {
-    TPMBackend *s, **be = object_field_prop_ptr(obj, prop);
+    TPMBackend *s, **be = FIELD_PTR(obj, prop, TPMBackend *);
     char *str;
 
     if (!visit_type_str(v, name, &str, errp)) {
@@ -65,7 +65,7 @@ static void set_tpm(Object *obj, Visitor *v, const char *name,
 
 static void release_tpm(Object *obj, const char *name, Property *prop)
 {
-    TPMBackend **be = object_field_prop_ptr(obj, prop);
+    TPMBackend **be = FIELD_PTR(obj, prop, TPMBackend *);
 
     if (*be) {
         tpm_backend_reset(*be);
diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index c1ee634639..390bf417ab 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -335,7 +335,7 @@ static char *disk_to_vbd_name(unsigned int disk)
 static void xen_block_get_vdev(Object *obj, Visitor *v, const char *name,
                                 Property *prop, Error **errp)
 {
-    XenBlockVdev *vdev = object_field_prop_ptr(obj, prop);
+    XenBlockVdev *vdev = FIELD_PTR(obj, prop, XenBlockVdev);
     char *str;
 
     switch (vdev->type) {
@@ -394,7 +394,7 @@ static int vbd_name_to_disk(const char *name, const char **endp,
 static void xen_block_set_vdev(Object *obj, Visitor *v, const char *name,
                                 Property *prop, Error **errp)
 {
-    XenBlockVdev *vdev = object_field_prop_ptr(obj, prop);
+    XenBlockVdev *vdev = FIELD_PTR(obj, prop, XenBlockVdev);
     char *str, *p;
     const char *end;
 
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 2fdd5863bb..1ec64514b9 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -61,7 +61,7 @@ static bool check_prop_still_unset(Object *obj, const char *name,
 static void get_drive(Object *obj, Visitor *v, const char *name,
                       Property *prop, Error **errp)
 {
-    void **ptr = object_field_prop_ptr(obj, prop);
+    void **ptr = FIELD_PTR(obj, prop, void *);
     const char *value;
     char *p;
 
@@ -87,7 +87,7 @@ static void set_drive_helper(Object *obj, Visitor *v, const char *name,
 {
     DeviceState *dev = DEVICE(obj);
     Property *prop = opaque;
-    void **ptr = object_field_prop_ptr(obj, prop);
+    void **ptr = FIELD_PTR(obj, prop, void *);
     char *str;
     BlockBackend *blk;
     bool blk_created = false;
@@ -179,7 +179,7 @@ static void set_drive_iothread(Object *obj, Visitor *v, const char *name,
 static void release_drive(Object *obj, const char *name, Property *prop)
 {
     DeviceState *dev = DEVICE(obj);
-    BlockBackend **ptr = object_field_prop_ptr(obj, prop);
+    BlockBackend **ptr = FIELD_PTR(obj, prop, BlockBackend *);
 
     if (*ptr) {
         AioContext *ctx = blk_get_aio_context(*ptr);
@@ -212,7 +212,7 @@ const PropertyInfo qdev_prop_drive_iothread = {
 static void get_chr(Object *obj, Visitor *v, const char *name,
                     Property *prop, Error **errp)
 {
-    CharBackend *be = object_field_prop_ptr(obj, prop);
+    CharBackend *be = FIELD_PTR(obj, prop, CharBackend);
     char *p;
 
     p = g_strdup(be->chr && be->chr->label ? be->chr->label : "");
@@ -223,7 +223,7 @@ static void get_chr(Object *obj, Visitor *v, const char *name,
 static void set_chr(Object *obj, Visitor *v, const char *name,
                     Property *prop, Error **errp)
 {
-    CharBackend *be = object_field_prop_ptr(obj, prop);
+    CharBackend *be = FIELD_PTR(obj, prop, CharBackend);
     Chardev *s;
     char *str;
 
@@ -258,7 +258,7 @@ static void set_chr(Object *obj, Visitor *v, const char *name,
 
 static void release_chr(Object *obj, const char *name, Property *prop)
 {
-    CharBackend *be = object_field_prop_ptr(obj, prop);
+    CharBackend *be = FIELD_PTR(obj, prop, CharBackend);
 
     qemu_chr_fe_deinit(be, false);
 }
@@ -281,7 +281,7 @@ const PropertyInfo qdev_prop_chr = {
 static void get_mac(Object *obj, Visitor *v, const char *name,
                     Property *prop, Error **errp)
 {
-    MACAddr *mac = object_field_prop_ptr(obj, prop);
+    MACAddr *mac = FIELD_PTR(obj, prop, MACAddr);
     char buffer[2 * 6 + 5 + 1];
     char *p = buffer;
 
@@ -295,7 +295,7 @@ static void get_mac(Object *obj, Visitor *v, const char *name,
 static void set_mac(Object *obj, Visitor *v, const char *name,
                     Property *prop, Error **errp)
 {
-    MACAddr *mac = object_field_prop_ptr(obj, prop);
+    MACAddr *mac = FIELD_PTR(obj, prop, MACAddr);
     int i, pos;
     char *str;
     const char *p;
@@ -356,7 +356,7 @@ void qdev_prop_set_macaddr(DeviceState *dev, const char *name,
 static void get_netdev(Object *obj, Visitor *v, const char *name,
                         Property *prop, Error **errp)
 {
-    NICPeers *peers_ptr = object_field_prop_ptr(obj, prop);
+    NICPeers *peers_ptr = FIELD_PTR(obj, prop, NICPeers);
     char *p = g_strdup(peers_ptr->ncs[0] ? peers_ptr->ncs[0]->name : "");
 
     visit_type_str(v, name, &p, errp);
@@ -366,7 +366,7 @@ static void get_netdev(Object *obj, Visitor *v, const char *name,
 static void set_netdev(Object *obj, Visitor *v, const char *name,
                         Property *prop, Error **errp)
 {
-    NICPeers *peers_ptr = object_field_prop_ptr(obj, prop);
+    NICPeers *peers_ptr = FIELD_PTR(obj, prop, NICPeers);
     NetClientState **ncs = peers_ptr->ncs;
     NetClientState *peers[MAX_QUEUE_NUM];
     int queues, err = 0, i = 0;
@@ -427,7 +427,7 @@ const PropertyInfo qdev_prop_netdev = {
 static void get_audiodev(Object *obj, Visitor *v, const char* name,
                           Property *prop, Error **errp)
 {
-    QEMUSoundCard *card = object_field_prop_ptr(obj, prop);
+    QEMUSoundCard *card = FIELD_PTR(obj, prop, QEMUSoundCard);
     char *p = g_strdup(audio_get_id(card));
 
     visit_type_str(v, name, &p, errp);
@@ -437,7 +437,7 @@ static void get_audiodev(Object *obj, Visitor *v, const char* name,
 static void set_audiodev(Object *obj, Visitor *v, const char* name,
                           Property *prop, Error **errp)
 {
-    QEMUSoundCard *card = object_field_prop_ptr(obj, prop);
+    QEMUSoundCard *card = FIELD_PTR(obj, prop, QEMUSoundCard);
     AudioState *state;
     int err = 0;
     char *str;
@@ -538,7 +538,7 @@ static void set_blocksize(Object *obj, Visitor *v, const char *name,
                            Property *prop, Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
-    uint32_t *ptr = object_field_prop_ptr(obj, prop);
+    uint32_t *ptr = FIELD_PTR(obj, prop, uint32_t);
     uint64_t value;
     Error *local_err = NULL;
 
@@ -625,7 +625,7 @@ const PropertyInfo qdev_prop_multifd_compression = {
 static void get_reserved_region(Object *obj, Visitor *v, const char *name,
                                  Property *prop, Error **errp)
 {
-    ReservedRegion *rr = object_field_prop_ptr(obj, prop);
+    ReservedRegion *rr = FIELD_PTR(obj, prop, ReservedRegion);
     char buffer[64];
     char *p = buffer;
     int rc;
@@ -640,7 +640,7 @@ static void get_reserved_region(Object *obj, Visitor *v, const char *name,
 static void set_reserved_region(Object *obj, Visitor *v, const char *name,
                                  Property *prop, Error **errp)
 {
-    ReservedRegion *rr = object_field_prop_ptr(obj, prop);
+    ReservedRegion *rr = FIELD_PTR(obj, prop, ReservedRegion);
     Error *local_err = NULL;
     const char *endptr;
     char *str;
@@ -701,7 +701,7 @@ const PropertyInfo qdev_prop_reserved_region = {
 static void set_pci_devfn(Object *obj, Visitor *v, const char *name,
                            Property *prop, Error **errp)
 {
-    int32_t value, *ptr = object_field_prop_ptr(obj, prop);
+    int32_t value, *ptr = FIELD_PTR(obj, prop, int32_t);
     unsigned int slot, fn, n;
     char *str;
 
@@ -739,7 +739,7 @@ invalid:
 static int print_pci_devfn(Object *obj, Property *prop, char *dest,
                            size_t len)
 {
-    int32_t *ptr = object_field_prop_ptr(obj, prop);
+    int32_t *ptr = FIELD_PTR(obj, prop, int32_t);
 
     if (*ptr == -1) {
         return snprintf(dest, len, "<unset>");
@@ -762,7 +762,7 @@ const PropertyInfo qdev_prop_pci_devfn = {
 static void get_pci_host_devaddr(Object *obj, Visitor *v, const char *name,
                                   Property *prop, Error **errp)
 {
-    PCIHostDeviceAddress *addr = object_field_prop_ptr(obj, prop);
+    PCIHostDeviceAddress *addr = FIELD_PTR(obj, prop, PCIHostDeviceAddress);
     char buffer[] = "ffff:ff:ff.f";
     char *p = buffer;
     int rc = 0;
@@ -787,7 +787,7 @@ static void get_pci_host_devaddr(Object *obj, Visitor *v, const char *name,
 static void set_pci_host_devaddr(Object *obj, Visitor *v, const char *name,
                                   Property *prop, Error **errp)
 {
-    PCIHostDeviceAddress *addr = object_field_prop_ptr(obj, prop);
+    PCIHostDeviceAddress *addr = FIELD_PTR(obj, prop, PCIHostDeviceAddress);
     char *str, *p;
     const char *e;
     unsigned long val;
@@ -875,7 +875,7 @@ const PropertyInfo qdev_prop_off_auto_pcibar = {
 static void get_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
                                     Property *prop, Error **errp)
 {
-    PCIExpLinkSpeed *p = object_field_prop_ptr(obj, prop);
+    PCIExpLinkSpeed *p = FIELD_PTR(obj, prop, PCIExpLinkSpeed);
     int speed;
 
     switch (*p) {
@@ -902,7 +902,7 @@ static void get_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
 static void set_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
                                     Property *prop, Error **errp)
 {
-    PCIExpLinkSpeed *p = object_field_prop_ptr(obj, prop);
+    PCIExpLinkSpeed *p = FIELD_PTR(obj, prop, PCIExpLinkSpeed);
     int speed;
 
     if (!visit_type_enum(v, name, &speed, prop->info->enum_table,
@@ -943,7 +943,7 @@ const PropertyInfo qdev_prop_pcie_link_speed = {
 static void get_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
                                     Property *prop, Error **errp)
 {
-    PCIExpLinkWidth *p = object_field_prop_ptr(obj, prop);
+    PCIExpLinkWidth *p = FIELD_PTR(obj, prop, PCIExpLinkWidth);
     int width;
 
     switch (*p) {
@@ -979,7 +979,7 @@ static void get_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
 static void set_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
                                     Property *prop, Error **errp)
 {
-    PCIExpLinkWidth *p = object_field_prop_ptr(obj, prop);
+    PCIExpLinkWidth *p = FIELD_PTR(obj, prop, PCIExpLinkWidth);
     int width;
 
     if (!visit_type_enum(v, name, &width, prop->info->enum_table,
@@ -1029,7 +1029,7 @@ const PropertyInfo qdev_prop_pcie_link_width = {
 static void get_uuid(Object *obj, Visitor *v, const char *name,
                      Property *prop, Error **errp)
 {
-    QemuUUID *uuid = object_field_prop_ptr(obj, prop);
+    QemuUUID *uuid = FIELD_PTR(obj, prop, QemuUUID);
     char buffer[UUID_FMT_LEN + 1];
     char *p = buffer;
 
@@ -1043,7 +1043,7 @@ static void get_uuid(Object *obj, Visitor *v, const char *name,
 static void set_uuid(Object *obj, Visitor *v, const char *name,
                     Property *prop, Error **errp)
 {
-    QemuUUID *uuid = object_field_prop_ptr(obj, prop);
+    QemuUUID *uuid = FIELD_PTR(obj, prop, QemuUUID);
     char *str;
 
     if (!visit_type_str(v, name, &str, errp)) {
diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 1400d80689..5a38919a05 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -2343,7 +2343,7 @@ void css_reset(void)
 static void get_css_devid(Object *obj, Visitor *v, const char *name,
                            Property *prop, Error **errp)
 {
-    CssDevId *dev_id = object_field_prop_ptr(obj, prop);
+    CssDevId *dev_id = FIELD_PTR(obj, prop, CssDevId);
     char buffer[] = "xx.x.xxxx";
     char *p = buffer;
     int r;
@@ -2371,7 +2371,7 @@ static void get_css_devid(Object *obj, Visitor *v, const char *name,
 static void set_css_devid(Object *obj, Visitor *v, const char *name,
                            Property *prop, Error **errp)
 {
-    CssDevId *dev_id = object_field_prop_ptr(obj, prop);
+    CssDevId *dev_id = FIELD_PTR(obj, prop, CssDevId);
     char *str;
     int num, n1, n2;
     unsigned int cssid, ssid, devid;
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index a29bba17b4..8e38787c99 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1322,7 +1322,7 @@ static void s390_pci_device_reset(DeviceState *dev)
 static void s390_pci_get_fid(Object *obj, Visitor *v, const char *name,
                           Property *prop, Error **errp)
 {
-    uint32_t *ptr = object_field_prop_ptr(obj, prop);
+    uint32_t *ptr = FIELD_PTR(obj, prop, uint32_t);
 
     visit_type_uint32(v, name, ptr, errp);
 }
@@ -1331,7 +1331,7 @@ static void s390_pci_set_fid(Object *obj, Visitor *v, const char *name,
                           Property *prop, Error **errp)
 {
     S390PCIBusDevice *zpci = S390_PCI_DEVICE(obj);
-    uint32_t *ptr = object_field_prop_ptr(obj, prop);
+    uint32_t *ptr = FIELD_PTR(obj, prop, uint32_t);
 
     if (!visit_type_uint32(v, name, ptr, errp)) {
         return;
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 34f5f5dce2..93fb507ec4 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1488,7 +1488,7 @@ static void get_nv_gpudirect_clique_id(Object *obj, Visitor *v,
                                        const char *name,
                                        Property *prop, Error **errp)
 {
-    uint8_t *ptr = object_field_prop_ptr(obj, prop);
+    uint8_t *ptr = FIELD_PTR(obj, prop, uint8_t);
 
     visit_type_uint8(v, name, ptr, errp);
 }
@@ -1497,7 +1497,7 @@ static void set_nv_gpudirect_clique_id(Object *obj, Visitor *v,
                                        const char *name,
                                        Property *prop, Error **errp)
 {
-    uint8_t value, *ptr = object_field_prop_ptr(obj, prop);
+    uint8_t value, *ptr = FIELD_PTR(obj, prop, uint8_t);
 
     if (!visit_type_uint8(v, name, &value, errp)) {
         return;
diff --git a/qom/field-property.c b/qom/field-property.c
index 865d4929a3..0932a799de 100644
--- a/qom/field-property.c
+++ b/qom/field-property.c
@@ -5,10 +5,11 @@
 #include "qom/field-property.h"
 #include "qom/field-property-internal.h"
 
-void *object_field_prop_ptr(Object *obj, Property *prop)
+void *object_field_prop_ptr(Object *obj, Property *prop, size_t expected_size)
 {
     void *ptr = obj;
     ptr += prop->offset;
+    assert(prop->size == expected_size);
     return ptr;
 }
 
diff --git a/qom/property-types.c b/qom/property-types.c
index 0182a73e38..e01f5a9fef 100644
--- a/qom/property-types.c
+++ b/qom/property-types.c
@@ -10,7 +10,7 @@
 void field_prop_get_enum(Object *obj, Visitor *v, const char *name,
                           Property *prop, Error **errp)
 {
-    int *ptr = object_field_prop_ptr(obj, prop);
+    int *ptr = FIELD_PTR(obj, prop, int);
 
     visit_type_enum(v, name, ptr, prop->info->enum_table, errp);
 }
@@ -18,7 +18,7 @@ void field_prop_get_enum(Object *obj, Visitor *v, const char *name,
 void field_prop_set_enum(Object *obj, Visitor *v, const char *name,
                           Property *prop, Error **errp)
 {
-    int *ptr = object_field_prop_ptr(obj, prop);
+    int *ptr = FIELD_PTR(obj, prop, int);
 
     visit_type_enum(v, name, ptr, prop->info->enum_table, errp);
 }
@@ -47,7 +47,7 @@ static uint32_t qdev_get_prop_mask(Property *prop)
 
 static void bit_prop_set(Object *obj, Property *props, bool val)
 {
-    uint32_t *p = object_field_prop_ptr(obj, props);
+    uint32_t *p = FIELD_PTR(obj, props, uint32_t);
     uint32_t mask = qdev_get_prop_mask(props);
     if (val) {
         *p |= mask;
@@ -59,7 +59,7 @@ static void bit_prop_set(Object *obj, Property *props, bool val)
 static void prop_get_bit(Object *obj, Visitor *v, const char *name,
                           Property *prop, Error **errp)
 {
-    uint32_t *p = object_field_prop_ptr(obj, prop);
+    uint32_t *p = FIELD_PTR(obj, prop, uint32_t);
     bool value = (*p & qdev_get_prop_mask(prop)) != 0;
 
     visit_type_bool(v, name, &value, errp);
@@ -99,7 +99,7 @@ static uint64_t qdev_get_prop_mask64(Property *prop)
 
 static void bit64_prop_set(Object *obj, Property *props, bool val)
 {
-    uint64_t *p = object_field_prop_ptr(obj, props);
+    uint64_t *p = FIELD_PTR(obj, props, uint64_t);
     uint64_t mask = qdev_get_prop_mask64(props);
     if (val) {
         *p |= mask;
@@ -111,7 +111,7 @@ static void bit64_prop_set(Object *obj, Property *props, bool val)
 static void prop_get_bit64(Object *obj, Visitor *v, const char *name,
                             Property *prop, Error **errp)
 {
-    uint64_t *p = object_field_prop_ptr(obj, prop);
+    uint64_t *p = FIELD_PTR(obj, prop, uint64_t);
     bool value = (*p & qdev_get_prop_mask64(prop)) != 0;
 
     visit_type_bool(v, name, &value, errp);
@@ -141,7 +141,7 @@ const PropertyInfo prop_info_bit64 = {
 static void get_bool(Object *obj, Visitor *v, const char *name,
                      Property *prop, Error **errp)
 {
-    bool *ptr = object_field_prop_ptr(obj, prop);
+    bool *ptr = FIELD_PTR(obj, prop, bool);
 
     visit_type_bool(v, name, ptr, errp);
 }
@@ -149,7 +149,7 @@ static void get_bool(Object *obj, Visitor *v, const char *name,
 static void set_bool(Object *obj, Visitor *v, const char *name,
                      Property *prop, Error **errp)
 {
-    bool *ptr = object_field_prop_ptr(obj, prop);
+    bool *ptr = FIELD_PTR(obj, prop, bool);
 
     visit_type_bool(v, name, ptr, errp);
 }
@@ -166,7 +166,7 @@ const PropertyInfo prop_info_bool = {
 static void get_uint8(Object *obj, Visitor *v, const char *name,
                       Property *prop, Error **errp)
 {
-    uint8_t *ptr = object_field_prop_ptr(obj, prop);
+    uint8_t *ptr = FIELD_PTR(obj, prop, uint8_t);
 
     visit_type_uint8(v, name, ptr, errp);
 }
@@ -174,7 +174,7 @@ static void get_uint8(Object *obj, Visitor *v, const char *name,
 static void set_uint8(Object *obj, Visitor *v, const char *name,
                       Property *prop, Error **errp)
 {
-    uint8_t *ptr = object_field_prop_ptr(obj, prop);
+    uint8_t *ptr = FIELD_PTR(obj, prop, uint8_t);
 
     visit_type_uint8(v, name, ptr, errp);
 }
@@ -203,7 +203,7 @@ const PropertyInfo prop_info_uint8 = {
 static void get_uint16(Object *obj, Visitor *v, const char *name,
                         Property *prop, Error **errp)
 {
-    uint16_t *ptr = object_field_prop_ptr(obj, prop);
+    uint16_t *ptr = FIELD_PTR(obj, prop, uint16_t);
 
     visit_type_uint16(v, name, ptr, errp);
 }
@@ -211,7 +211,7 @@ static void get_uint16(Object *obj, Visitor *v, const char *name,
 static void set_uint16(Object *obj, Visitor *v, const char *name,
                         Property *prop, Error **errp)
 {
-    uint16_t *ptr = object_field_prop_ptr(obj, prop);
+    uint16_t *ptr = FIELD_PTR(obj, prop, uint16_t);
 
     visit_type_uint16(v, name, ptr, errp);
 }
@@ -228,7 +228,7 @@ const PropertyInfo prop_info_uint16 = {
 static void get_uint32(Object *obj, Visitor *v, const char *name,
                         Property *prop, Error **errp)
 {
-    uint32_t *ptr = object_field_prop_ptr(obj, prop);
+    uint32_t *ptr = FIELD_PTR(obj, prop, uint32_t);
 
     visit_type_uint32(v, name, ptr, errp);
 }
@@ -236,7 +236,7 @@ static void get_uint32(Object *obj, Visitor *v, const char *name,
 static void set_uint32(Object *obj, Visitor *v, const char *name,
                         Property *prop, Error **errp)
 {
-    uint32_t *ptr = object_field_prop_ptr(obj, prop);
+    uint32_t *ptr = FIELD_PTR(obj, prop, uint32_t);
 
     visit_type_uint32(v, name, ptr, errp);
 }
@@ -244,7 +244,7 @@ static void set_uint32(Object *obj, Visitor *v, const char *name,
 void field_prop_get_int32(Object *obj, Visitor *v, const char *name,
                            Property *prop, Error **errp)
 {
-    int32_t *ptr = object_field_prop_ptr(obj, prop);
+    int32_t *ptr = FIELD_PTR(obj, prop, int32_t);
 
     visit_type_int32(v, name, ptr, errp);
 }
@@ -252,7 +252,7 @@ void field_prop_get_int32(Object *obj, Visitor *v, const char *name,
 static void set_int32(Object *obj, Visitor *v, const char *name,
                       Property *prop, Error **errp)
 {
-    int32_t *ptr = object_field_prop_ptr(obj, prop);
+    int32_t *ptr = FIELD_PTR(obj, prop, int32_t);
 
     visit_type_int32(v, name, ptr, errp);
 }
@@ -276,7 +276,7 @@ const PropertyInfo prop_info_int32 = {
 static void get_uint64(Object *obj, Visitor *v, const char *name,
                         Property *prop, Error **errp)
 {
-    uint64_t *ptr = object_field_prop_ptr(obj, prop);
+    uint64_t *ptr = FIELD_PTR(obj, prop, uint64_t);
 
     visit_type_uint64(v, name, ptr, errp);
 }
@@ -284,7 +284,7 @@ static void get_uint64(Object *obj, Visitor *v, const char *name,
 static void set_uint64(Object *obj, Visitor *v, const char *name,
                         Property *prop, Error **errp)
 {
-    uint64_t *ptr = object_field_prop_ptr(obj, prop);
+    uint64_t *ptr = FIELD_PTR(obj, prop, uint64_t);
 
     visit_type_uint64(v, name, ptr, errp);
 }
@@ -292,7 +292,7 @@ static void set_uint64(Object *obj, Visitor *v, const char *name,
 static void get_int64(Object *obj, Visitor *v, const char *name,
                        Property *prop, Error **errp)
 {
-    int64_t *ptr = object_field_prop_ptr(obj, prop);
+    int64_t *ptr = FIELD_PTR(obj, prop, int64_t);
 
     visit_type_int64(v, name, ptr, errp);
 }
@@ -300,7 +300,7 @@ static void get_int64(Object *obj, Visitor *v, const char *name,
 static void set_int64(Object *obj, Visitor *v, const char *name,
                        Property *prop, Error **errp)
 {
-    int64_t *ptr = object_field_prop_ptr(obj, prop);
+    int64_t *ptr = FIELD_PTR(obj, prop, int64_t);
 
     visit_type_int64(v, name, ptr, errp);
 }
@@ -323,13 +323,14 @@ const PropertyInfo prop_info_int64 = {
 
 static void release_string(Object *obj, const char *name, Property *prop)
 {
-    g_free(*(char **)object_field_prop_ptr(obj, prop));
+    char **ptr = FIELD_PTR(obj, prop, char *);
+    g_free(*ptr);
 }
 
 static void get_string(Object *obj, Visitor *v, const char *name,
                         Property *prop, Error **errp)
 {
-    char **ptr = object_field_prop_ptr(obj, prop);
+    char **ptr = FIELD_PTR(obj, prop, char *);
 
     if (!*ptr) {
         char *str = (char *)"";
@@ -342,7 +343,7 @@ static void get_string(Object *obj, Visitor *v, const char *name,
 static void set_string(Object *obj, Visitor *v, const char *name,
                         Property *prop, Error **errp)
 {
-    char **ptr = object_field_prop_ptr(obj, prop);
+    char **ptr = FIELD_PTR(obj, prop, char *);
     char *str;
 
     if (!visit_type_str(v, name, &str, errp)) {
@@ -375,7 +376,7 @@ const PropertyInfo prop_info_on_off_auto = {
 void field_prop_get_size32(Object *obj, Visitor *v, const char *name,
                             Property *prop, Error **errp)
 {
-    uint32_t *ptr = object_field_prop_ptr(obj, prop);
+    uint32_t *ptr = FIELD_PTR(obj, prop, uint32_t);
     uint64_t value = *ptr;
 
     visit_type_size(v, name, &value, errp);
@@ -384,7 +385,7 @@ void field_prop_get_size32(Object *obj, Visitor *v, const char *name,
 static void set_size32(Object *obj, Visitor *v, const char *name,
                        Property *prop, Error **errp)
 {
-    uint32_t *ptr = object_field_prop_ptr(obj, prop);
+    uint32_t *ptr = FIELD_PTR(obj, prop, uint32_t);
     uint64_t value;
 
     if (!visit_type_size(v, name, &value, errp)) {
@@ -415,7 +416,7 @@ static void set_prop_arraylen(Object *obj, Visitor *v, const char *name,
                                Property *prop, Error **errp)
 {
     ObjectProperty *op = object_property_find_err(obj, name, &error_abort);
-    uint32_t *alenptr = object_field_prop_ptr(obj, prop);
+    uint32_t *alenptr = FIELD_PTR(obj, prop, uint32_t);
     void **arrayptr = (void *)obj + prop->arrayoffset;
     void *eltptr;
     const char *arrayname;
@@ -455,7 +456,8 @@ static void set_prop_arraylen(Object *obj, Visitor *v, const char *name,
          */
         arrayprop->offset = eltptr - (void *)obj;
         arrayprop->size = prop->arrayfieldsize;
-        assert(object_field_prop_ptr(obj, arrayprop) == eltptr);
+        assert(object_field_prop_ptr(obj, arrayprop,
+                                     prop->arrayfieldsize) == eltptr);
         object_property_add_field(obj, propname, arrayprop, op->allow_set);
     }
 }
@@ -472,7 +474,7 @@ const PropertyInfo prop_info_arraylen = {
 static void get_size(Object *obj, Visitor *v, const char *name,
                      Property *prop, Error **errp)
 {
-    uint64_t *ptr = object_field_prop_ptr(obj, prop);
+    uint64_t *ptr = FIELD_PTR(obj, prop, uint64_t);
 
     visit_type_size(v, name, ptr, errp);
 }
@@ -480,7 +482,7 @@ static void get_size(Object *obj, Visitor *v, const char *name,
 static void set_size(Object *obj, Visitor *v, const char *name,
                      Property *prop, Error **errp)
 {
-    uint64_t *ptr = object_field_prop_ptr(obj, prop);
+    uint64_t *ptr = FIELD_PTR(obj, prop, uint64_t);
 
     visit_type_size(v, name, ptr, errp);
 }
-- 
2.28.0


