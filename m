Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547DEC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:10:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB4872075B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eHMvDv75"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB4872075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsqAR-0000Q3-LV
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 12:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsq7D-000253-3c
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:06:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43119
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsq73-0006oG-EJ
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:06:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594137988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=paHJiRzpnWawijzH4n3EJjyPBZDmw5pmcVKN0qjiWe8=;
 b=eHMvDv751y1YXWzh2Y/TST0vlSIp9/jZTrGLMqYWy486qiKwapObw+0kppaqKvRMixcF9U
 S6SSWJyvNXdJkPBmmCFUJeYQlqNnC0Dj+EeUn+hyMUEryPgdh6ILdqcshG31QKjPw1aa+h
 JryxY/dmmwCciC4eWlRG5Rh0878mcx4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-3-kqky9KNLW0MDONDu6ZEw-1; Tue, 07 Jul 2020 12:06:26 -0400
X-MC-Unique: 3-kqky9KNLW0MDONDu6ZEw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88D0E10059AB;
 Tue,  7 Jul 2020 16:06:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6026578460;
 Tue,  7 Jul 2020 16:06:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B4A001144254; Tue,  7 Jul 2020 18:06:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 18/45] qapi: Use returned bool to check for failure,
 Coccinelle part
Date: Tue,  7 Jul 2020 18:05:46 +0200
Message-Id: <20200707160613.848843-19-armbru@redhat.com>
In-Reply-To: <20200707160613.848843-1-armbru@redhat.com>
References: <20200707160613.848843-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, berrange@redhat.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, groug@kaod.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The previous commit enables conversion of

    visit_foo(..., &err);
    if (err) {
        ...
    }

to

    if (!visit_foo(..., errp)) {
        ...
    }

for visitor functions that now return true / false on success / error.
Coccinelle script:

    @@
    identifier fun =3D~ "check_list|input_type_enum|lv_start_struct|lv_type=
_bool|lv_type_int64|lv_type_str|lv_type_uint64|output_type_enum|parse_type_=
bool|parse_type_int64|parse_type_null|parse_type_number|parse_type_size|par=
se_type_str|parse_type_uint64|print_type_bool|print_type_int64|print_type_n=
ull|print_type_number|print_type_size|print_type_str|print_type_uint64|qapi=
_clone_start_alternate|qapi_clone_start_list|qapi_clone_start_struct|qapi_c=
lone_type_bool|qapi_clone_type_int64|qapi_clone_type_null|qapi_clone_type_n=
umber|qapi_clone_type_str|qapi_clone_type_uint64|qapi_dealloc_start_list|qa=
pi_dealloc_start_struct|qapi_dealloc_type_anything|qapi_dealloc_type_bool|q=
api_dealloc_type_int64|qapi_dealloc_type_null|qapi_dealloc_type_number|qapi=
_dealloc_type_str|qapi_dealloc_type_uint64|qobject_input_check_list|qobject=
_input_check_struct|qobject_input_start_alternate|qobject_input_start_list|=
qobject_input_start_struct|qobject_input_type_any|qobject_input_type_bool|q=
object_input_type_bool_keyval|qobject_input_type_int64|qobject_input_type_i=
nt64_keyval|qobject_input_type_null|qobject_input_type_number|qobject_input=
_type_number_keyval|qobject_input_type_size_keyval|qobject_input_type_str|q=
object_input_type_str_keyval|qobject_input_type_uint64|qobject_input_type_u=
int64_keyval|qobject_output_start_list|qobject_output_start_struct|qobject_=
output_type_any|qobject_output_type_bool|qobject_output_type_int64|qobject_=
output_type_null|qobject_output_type_number|qobject_output_type_str|qobject=
_output_type_uint64|start_list|visit_check_list|visit_check_struct|visit_st=
art_alternate|visit_start_list|visit_start_struct|visit_type_.*";
    expression list args;
    typedef Error;
    Error *err;
    @@
    -    fun(args, &err);
    -    if (err)
    +    if (!fun(args, &err))
         {
             ...
         }

A few line breaks tidied up manually.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 accel/kvm/kvm-all.c              |  3 +--
 accel/tcg/tcg-all.c              |  3 +--
 backends/cryptodev.c             |  3 +--
 backends/hostmem-file.c          |  3 +--
 backends/hostmem-memfd.c         |  3 +--
 backends/hostmem.c               |  6 ++---
 backends/tpm/tpm_util.c          |  3 +--
 block/blkdebug.c                 |  3 +--
 block/nbd.c                      |  3 +--
 block/sheepdog.c                 |  3 +--
 block/throttle-groups.c          |  6 ++---
 bootdevice.c                     |  3 +--
 hw/block/xen-block.c             |  3 +--
 hw/core/machine.c                |  3 +--
 hw/core/qdev-properties-system.c | 12 +++------
 hw/core/qdev-properties.c        | 38 +++++++++++------------------
 hw/cpu/core.c                    |  6 ++---
 hw/gpio/aspeed_gpio.c            |  3 +--
 hw/i386/pc.c                     |  3 +--
 hw/ide/qdev.c                    |  3 +--
 hw/intc/apic_common.c            |  3 +--
 hw/mem/nvdimm.c                  |  6 ++---
 hw/misc/aspeed_sdmc.c            |  3 +--
 hw/misc/pca9552.c                |  3 +--
 hw/misc/tmp105.c                 |  3 +--
 hw/misc/tmp421.c                 |  3 +--
 hw/net/ne2000-isa.c              |  3 +--
 hw/ppc/spapr_caps.c              |  9 +++----
 hw/ppc/spapr_drc.c               | 10 +++-----
 hw/s390x/css.c                   |  3 +--
 hw/usb/dev-storage.c             |  3 +--
 hw/vfio/pci-quirks.c             |  3 +--
 hw/virtio/virtio-balloon.c       | 15 ++++--------
 iothread.c                       |  3 +--
 monitor/hmp-cmds.c               |  3 +--
 net/colo-compare.c               |  6 ++---
 net/dump.c                       |  3 +--
 net/filter-buffer.c              |  3 +--
 qom/object.c                     | 42 +++++++++++---------------------
 qom/object_interfaces.c          |  3 +--
 target/arm/cpu64.c               |  9 +++----
 target/arm/monitor.c             |  3 +--
 target/i386/cpu.c                | 15 ++++--------
 target/ppc/compat.c              |  3 +--
 target/s390x/cpu_models.c        |  9 +++----
 target/sparc/cpu.c               |  3 +--
 46 files changed, 97 insertions(+), 188 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index d54a8701d8..397669231d 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3116,8 +3116,7 @@ static void kvm_set_kvm_shadow_mem(Object *obj, Visit=
or *v,
     Error *error =3D NULL;
     int64_t value;
=20
-    visit_type_int(v, name, &value, &error);
-    if (error) {
+    if (!visit_type_int(v, name, &value, &error)) {
         error_propagate(errp, error);
         return;
     }
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 3b4fda5640..d6b3d7fc07 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -185,8 +185,7 @@ static void tcg_set_tb_size(Object *obj, Visitor *v,
     Error *error =3D NULL;
     uint32_t value;
=20
-    visit_type_uint32(v, name, &value, &error);
-    if (error) {
+    if (!visit_type_uint32(v, name, &value, &error)) {
         error_propagate(errp, error);
         return;
     }
diff --git a/backends/cryptodev.c b/backends/cryptodev.c
index a3841c4e41..7e7265102e 100644
--- a/backends/cryptodev.c
+++ b/backends/cryptodev.c
@@ -157,8 +157,7 @@ cryptodev_backend_set_queues(Object *obj, Visitor *v, c=
onst char *name,
     Error *local_err =3D NULL;
     uint32_t value;
=20
-    visit_type_uint32(v, name, &value, &local_err);
-    if (local_err) {
+    if (!visit_type_uint32(v, name, &value, &local_err)) {
         goto out;
     }
     if (!value) {
diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index cdabb412e6..320dffbaa9 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -119,8 +119,7 @@ static void file_memory_backend_set_align(Object *o, Vi=
sitor *v,
         goto out;
     }
=20
-    visit_type_size(v, name, &val, &local_err);
-    if (local_err) {
+    if (!visit_type_size(v, name, &val, &local_err)) {
         goto out;
     }
     fb->align =3D val;
diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index 1b5e4bfe0d..d4281c0032 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -85,8 +85,7 @@ memfd_backend_set_hugetlbsize(Object *obj, Visitor *v, co=
nst char *name,
         goto out;
     }
=20
-    visit_type_size(v, name, &value, &local_err);
-    if (local_err) {
+    if (!visit_type_size(v, name, &value, &local_err)) {
         goto out;
     }
     if (!value) {
diff --git a/backends/hostmem.c b/backends/hostmem.c
index 61e3255f5c..4e4103ac09 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -63,8 +63,7 @@ host_memory_backend_set_size(Object *obj, Visitor *v, con=
st char *name,
         goto out;
     }
=20
-    visit_type_size(v, name, &value, &local_err);
-    if (local_err) {
+    if (!visit_type_size(v, name, &value, &local_err)) {
         goto out;
     }
     if (!value) {
@@ -257,8 +256,7 @@ static void host_memory_backend_set_prealloc_threads(Ob=
ject *obj, Visitor *v,
     Error *local_err =3D NULL;
     uint32_t value;
=20
-    visit_type_uint32(v, name, &value, &local_err);
-    if (local_err) {
+    if (!visit_type_uint32(v, name, &value, &local_err)) {
         goto out;
     }
     if (value <=3D 0) {
diff --git a/backends/tpm/tpm_util.c b/backends/tpm/tpm_util.c
index cfc7572a61..971f3af047 100644
--- a/backends/tpm/tpm_util.c
+++ b/backends/tpm/tpm_util.c
@@ -58,8 +58,7 @@ static void set_tpm(Object *obj, Visitor *v, const char *=
name, void *opaque,
         return;
     }
=20
-    visit_type_str(v, name, &str, &local_err);
-    if (local_err) {
+    if (!visit_type_str(v, name, &str, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
diff --git a/block/blkdebug.c b/block/blkdebug.c
index d473dcf8c7..3c0a9d45cc 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -375,8 +375,7 @@ static int blkdebug_parse_perm_list(uint64_t *dest, QDi=
ct *options,
     }
=20
     v =3D qobject_input_visitor_new(crumpled_subqdict);
-    visit_type_BlockPermissionList(v, NULL, &perm_list, &local_err);
-    if (local_err) {
+    if (!visit_type_BlockPermissionList(v, NULL, &perm_list, &local_err)) =
{
         error_propagate(errp, local_err);
         ret =3D -EINVAL;
         goto out;
diff --git a/block/nbd.c b/block/nbd.c
index 1b30d96a4f..1331307ffb 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1739,8 +1739,7 @@ static SocketAddress *nbd_config(BDRVNBDState *s, QDi=
ct *options,
         goto done;
     }
=20
-    visit_type_SocketAddress(iv, NULL, &saddr, &local_err);
-    if (local_err) {
+    if (!visit_type_SocketAddress(iv, NULL, &saddr, &local_err)) {
         error_propagate(errp, local_err);
         goto done;
     }
diff --git a/block/sheepdog.c b/block/sheepdog.c
index a8d396dcdf..e3bcb05f60 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -541,8 +541,7 @@ static SocketAddress *sd_server_config(QDict *options, =
Error **errp)
         goto done;
     }
=20
-    visit_type_SocketAddress(iv, NULL, &saddr, &local_err);
-    if (local_err) {
+    if (!visit_type_SocketAddress(iv, NULL, &saddr, &local_err)) {
         error_propagate(errp, local_err);
         goto done;
     }
diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 784fa4a16c..bb242fde1a 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -823,8 +823,7 @@ static void throttle_group_set(Object *obj, Visitor *v,=
 const char * name,
         goto ret;
     }
=20
-    visit_type_int64(v, name, &value, &local_err);
-    if (local_err) {
+    if (!visit_type_int64(v, name, &value, &local_err)) {
         goto ret;
     }
     if (value < 0) {
@@ -896,8 +895,7 @@ static void throttle_group_set_limits(Object *obj, Visi=
tor *v,
     ThrottleLimits *argp;
     Error *local_err =3D NULL;
=20
-    visit_type_ThrottleLimits(v, name, &argp, &local_err);
-    if (local_err) {
+    if (!visit_type_ThrottleLimits(v, name, &argp, &local_err)) {
         goto ret;
     }
     qemu_mutex_lock(&tg->lock);
diff --git a/bootdevice.c b/bootdevice.c
index 0ff55e2b79..fb09d3c668 100644
--- a/bootdevice.c
+++ b/bootdevice.c
@@ -297,8 +297,7 @@ static void device_set_bootindex(Object *obj, Visitor *=
v, const char *name,
     int32_t boot_index;
     Error *local_err =3D NULL;
=20
-    visit_type_int32(v, name, &boot_index, &local_err);
-    if (local_err) {
+    if (!visit_type_int32(v, name, &boot_index, &local_err)) {
         goto out;
     }
     /* check whether bootindex is present in fw_boot_order list  */
diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 10c44dfda2..48890536a4 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -412,8 +412,7 @@ static void xen_block_set_vdev(Object *obj, Visitor *v,=
 const char *name,
         return;
     }
=20
-    visit_type_str(v, name, &str, &local_err);
-    if (local_err) {
+    if (!visit_type_str(v, name, &str, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 211b4e077a..7ff0af93ef 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -293,8 +293,7 @@ static void machine_set_phandle_start(Object *obj, Visi=
tor *v,
     Error *error =3D NULL;
     int64_t value;
=20
-    visit_type_int(v, name, &value, &error);
-    if (error) {
+    if (!visit_type_int(v, name, &value, &error)) {
         error_propagate(errp, error);
         return;
     }
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-sys=
tem.c
index 38b0c9f09b..383a54578f 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -92,8 +92,7 @@ static void set_drive_helper(Object *obj, Visitor *v, con=
st char *name,
         return;
     }
=20
-    visit_type_str(v, name, &str, &local_err);
-    if (local_err) {
+    if (!visit_type_str(v, name, &str, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
@@ -238,8 +237,7 @@ static void set_chr(Object *obj, Visitor *v, const char=
 *name, void *opaque,
         return;
     }
=20
-    visit_type_str(v, name, &str, &local_err);
-    if (local_err) {
+    if (!visit_type_str(v, name, &str, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
@@ -316,8 +314,7 @@ static void set_netdev(Object *obj, Visitor *v, const c=
har *name,
         return;
     }
=20
-    visit_type_str(v, name, &str, &local_err);
-    if (local_err) {
+    if (!visit_type_str(v, name, &str, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
@@ -398,8 +395,7 @@ static void set_audiodev(Object *obj, Visitor *v, const=
 char* name,
         return;
     }
=20
-    visit_type_str(v, name, &str, &local_err);
-    if (local_err) {
+    if (!visit_type_str(v, name, &str, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index ca7771f307..3cb6faa12b 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -125,8 +125,7 @@ static void prop_set_bit(Object *obj, Visitor *v, const=
 char *name,
         return;
     }
=20
-    visit_type_bool(v, name, &value, &local_err);
-    if (local_err) {
+    if (!visit_type_bool(v, name, &value, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
@@ -189,8 +188,7 @@ static void prop_set_bit64(Object *obj, Visitor *v, con=
st char *name,
         return;
     }
=20
-    visit_type_bool(v, name, &value, &local_err);
-    if (local_err) {
+    if (!visit_type_bool(v, name, &value, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
@@ -486,8 +484,7 @@ static void set_string(Object *obj, Visitor *v, const c=
har *name,
         return;
     }
=20
-    visit_type_str(v, name, &str, &local_err);
-    if (local_err) {
+    if (!visit_type_str(v, name, &str, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
@@ -540,8 +537,7 @@ static void set_mac(Object *obj, Visitor *v, const char=
 *name, void *opaque,
         return;
     }
=20
-    visit_type_str(v, name, &str, &local_err);
-    if (local_err) {
+    if (!visit_type_str(v, name, &str, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
@@ -762,8 +758,7 @@ static void set_pci_devfn(Object *obj, Visitor *v, cons=
t char *name,
         return;
     }
=20
-    visit_type_str(v, name, &str, &local_err);
-    if (local_err) {
+    if (!visit_type_str(v, name, &str, &local_err)) {
         error_free(local_err);
         local_err =3D NULL;
         visit_type_int32(v, name, &value, &local_err);
@@ -844,8 +839,7 @@ static void set_size32(Object *obj, Visitor *v, const c=
har *name, void *opaque,
         return;
     }
=20
-    visit_type_size(v, name, &value, &local_err);
-    if (local_err) {
+    if (!visit_type_size(v, name, &value, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
@@ -894,8 +888,7 @@ static void set_blocksize(Object *obj, Visitor *v, cons=
t char *name,
         return;
     }
=20
-    visit_type_size(v, name, &value, &local_err);
-    if (local_err) {
+    if (!visit_type_size(v, name, &value, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
@@ -976,8 +969,7 @@ static void set_pci_host_devaddr(Object *obj, Visitor *=
v, const char *name,
         return;
     }
=20
-    visit_type_str(v, name, &str, &local_err);
-    if (local_err) {
+    if (!visit_type_str(v, name, &str, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
@@ -1076,8 +1068,7 @@ static void set_uuid(Object *obj, Visitor *v, const c=
har *name, void *opaque,
         return;
     }
=20
-    visit_type_str(v, name, &str, &local_err);
-    if (local_err) {
+    if (!visit_type_str(v, name, &str, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
@@ -1158,8 +1149,7 @@ static void set_prop_arraylen(Object *obj, Visitor *v=
, const char *name,
                    name);
         return;
     }
-    visit_type_uint32(v, name, alenptr, &local_err);
-    if (local_err) {
+    if (!visit_type_uint32(v, name, alenptr, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
@@ -1490,8 +1480,8 @@ static void set_prop_pcielinkspeed(Object *obj, Visit=
or *v, const char *name,
         return;
     }
=20
-    visit_type_enum(v, prop->name, &speed, prop->info->enum_table, &local_=
err);
-    if (local_err) {
+    if (!visit_type_enum(v, prop->name, &speed, prop->info->enum_table,
+                         &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
@@ -1578,8 +1568,8 @@ static void set_prop_pcielinkwidth(Object *obj, Visit=
or *v, const char *name,
         return;
     }
=20
-    visit_type_enum(v, prop->name, &width, prop->info->enum_table, &local_=
err);
-    if (local_err) {
+    if (!visit_type_enum(v, prop->name, &width, prop->info->enum_table,
+                         &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
diff --git a/hw/cpu/core.c b/hw/cpu/core.c
index a92ac597ca..d9857031ca 100644
--- a/hw/cpu/core.c
+++ b/hw/cpu/core.c
@@ -31,8 +31,7 @@ static void core_prop_set_core_id(Object *obj, Visitor *v=
, const char *name,
     Error *local_err =3D NULL;
     int64_t value;
=20
-    visit_type_int(v, name, &value, &local_err);
-    if (local_err) {
+    if (!visit_type_int(v, name, &value, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
@@ -61,8 +60,7 @@ static void core_prop_set_nr_threads(Object *obj, Visitor=
 *v, const char *name,
     Error *local_err =3D NULL;
     int64_t value;
=20
-    visit_type_int(v, name, &value, &local_err);
-    if (local_err) {
+    if (!visit_type_int(v, name, &value, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
index dfa9db3d33..3310fe62fe 100644
--- a/hw/gpio/aspeed_gpio.c
+++ b/hw/gpio/aspeed_gpio.c
@@ -762,8 +762,7 @@ static void aspeed_gpio_set_pin(Object *obj, Visitor *v=
, const char *name,
     AspeedGPIOState *s =3D ASPEED_GPIO(obj);
     int set_idx, group_idx =3D 0;
=20
-    visit_type_bool(v, name, &level, &local_err);
-    if (local_err) {
+    if (!visit_type_bool(v, name, &level, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 4af9679d03..0f49afc261 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1854,8 +1854,7 @@ static void pc_machine_set_max_ram_below_4g(Object *o=
bj, Visitor *v,
     Error *error =3D NULL;
     uint64_t value;
=20
-    visit_type_size(v, name, &value, &error);
-    if (error) {
+    if (!visit_type_size(v, name, &value, &error)) {
         error_propagate(errp, error);
         return;
     }
diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index f68fbee93d..358f10a92e 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -245,8 +245,7 @@ static void ide_dev_set_bootindex(Object *obj, Visitor =
*v, const char *name,
     int32_t boot_index;
     Error *local_err =3D NULL;
=20
-    visit_type_int32(v, name, &boot_index, &local_err);
-    if (local_err) {
+    if (!visit_type_int32(v, name, &boot_index, &local_err)) {
         goto out;
     }
     /* check whether bootindex is present in fw_boot_order list  */
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index 7da2862b3d..76c3f78e11 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -428,8 +428,7 @@ static void apic_common_set_id(Object *obj, Visitor *v,=
 const char *name,
         return;
     }
=20
-    visit_type_uint32(v, name, &value, &local_err);
-    if (local_err) {
+    if (!visit_type_uint32(v, name, &value, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index 76f66e0b19..ec92ffd415 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -53,8 +53,7 @@ static void nvdimm_set_label_size(Object *obj, Visitor *v=
, const char *name,
         goto out;
     }
=20
-    visit_type_size(v, name, &value, &local_err);
-    if (local_err) {
+    if (!visit_type_size(v, name, &value, &local_err)) {
         goto out;
     }
     if (value < MIN_NAMESPACE_LABEL_SIZE) {
@@ -89,8 +88,7 @@ static void nvdimm_set_uuid(Object *obj, Visitor *v, cons=
t char *name,
     Error *local_err =3D NULL;
     char *value;
=20
-    visit_type_str(v, name, &value, &local_err);
-    if (local_err) {
+    if (!visit_type_str(v, name, &value, &local_err)) {
         goto out;
     }
=20
diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index 25e1e58356..28874445c3 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -227,8 +227,7 @@ static void aspeed_sdmc_set_ram_size(Object *obj, Visit=
or *v, const char *name,
     AspeedSDMCState *s =3D ASPEED_SDMC(obj);
     AspeedSDMCClass *asc =3D ASPEED_SDMC_GET_CLASS(s);
=20
-    visit_type_int(v, name, &value, &local_err);
-    if (local_err) {
+    if (!visit_type_int(v, name, &value, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
index 68b574d084..d2b99fc706 100644
--- a/hw/misc/pca9552.c
+++ b/hw/misc/pca9552.c
@@ -296,8 +296,7 @@ static void pca955x_set_led(Object *obj, Visitor *v, co=
nst char *name,
     uint8_t state;
     char *state_str;
=20
-    visit_type_str(v, name, &state_str, &local_err);
-    if (local_err) {
+    if (!visit_type_str(v, name, &state_str, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
diff --git a/hw/misc/tmp105.c b/hw/misc/tmp105.c
index 58dbebca90..2ae0b899be 100644
--- a/hw/misc/tmp105.c
+++ b/hw/misc/tmp105.c
@@ -75,8 +75,7 @@ static void tmp105_set_temperature(Object *obj, Visitor *=
v, const char *name,
     Error *local_err =3D NULL;
     int64_t temp;
=20
-    visit_type_int(v, name, &temp, &local_err);
-    if (local_err) {
+    if (!visit_type_int(v, name, &temp, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
diff --git a/hw/misc/tmp421.c b/hw/misc/tmp421.c
index 74864cd93d..9473382bd5 100644
--- a/hw/misc/tmp421.c
+++ b/hw/misc/tmp421.c
@@ -147,8 +147,7 @@ static void tmp421_set_temperature(Object *obj, Visitor=
 *v, const char *name,
     int offset =3D ext_range * 64 * 256;
     int tempid;
=20
-    visit_type_int(v, name, &temp, &local_err);
-    if (local_err) {
+    if (!visit_type_int(v, name, &temp, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
diff --git a/hw/net/ne2000-isa.c b/hw/net/ne2000-isa.c
index fdf8faa0d9..765bcd1f0b 100644
--- a/hw/net/ne2000-isa.c
+++ b/hw/net/ne2000-isa.c
@@ -113,8 +113,7 @@ static void isa_ne2000_set_bootindex(Object *obj, Visit=
or *v,
     int32_t boot_index;
     Error *local_err =3D NULL;
=20
-    visit_type_int32(v, name, &boot_index, &local_err);
-    if (local_err) {
+    if (!visit_type_int32(v, name, &boot_index, &local_err)) {
         goto out;
     }
     /* check whether bootindex is present in fw_boot_order list  */
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 0c2bc8e06e..52be86e49c 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -88,8 +88,7 @@ static void spapr_cap_set_bool(Object *obj, Visitor *v, c=
onst char *name,
     bool value;
     Error *local_err =3D NULL;
=20
-    visit_type_bool(v, name, &value, &local_err);
-    if (local_err) {
+    if (!visit_type_bool(v, name, &value, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
@@ -127,8 +126,7 @@ static void spapr_cap_set_string(Object *obj, Visitor *=
v, const char *name,
     uint8_t i;
     char *val;
=20
-    visit_type_str(v, name, &val, &local_err);
-    if (local_err) {
+    if (!visit_type_str(v, name, &val, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
@@ -171,8 +169,7 @@ static void spapr_cap_set_pagesize(Object *obj, Visitor=
 *v, const char *name,
     uint8_t val;
     Error *local_err =3D NULL;
=20
-    visit_type_size(v, name, &pagesize, &local_err);
-    if (local_err) {
+    if (!visit_type_size(v, name, &pagesize, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 951bcdf2c0..d10193f39e 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -327,8 +327,7 @@ static void prop_get_fdt(Object *obj, Visitor *v, const=
 char *name,
         case FDT_BEGIN_NODE:
             fdt_depth++;
             name =3D fdt_get_name(fdt, fdt_offset, &name_len);
-            visit_start_struct(v, name, NULL, 0, &err);
-            if (err) {
+            if (!visit_start_struct(v, name, NULL, 0, &err)) {
                 error_propagate(errp, err);
                 return;
             }
@@ -348,14 +347,13 @@ static void prop_get_fdt(Object *obj, Visitor *v, con=
st char *name,
             int i;
             prop =3D fdt_get_property_by_offset(fdt, fdt_offset, &prop_len=
);
             name =3D fdt_string(fdt, fdt32_to_cpu(prop->nameoff));
-            visit_start_list(v, name, NULL, 0, &err);
-            if (err) {
+            if (!visit_start_list(v, name, NULL, 0, &err)) {
                 error_propagate(errp, err);
                 return;
             }
             for (i =3D 0; i < prop_len; i++) {
-                visit_type_uint8(v, NULL, (uint8_t *)&prop->data[i], &err)=
;
-                if (err) {
+                if (!visit_type_uint8(v, NULL, (uint8_t *)&prop->data[i],
+                                      &err)) {
                     error_propagate(errp, err);
                     return;
                 }
diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index d1e365e3e6..ab28b2fb30 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -2387,8 +2387,7 @@ static void set_css_devid(Object *obj, Visitor *v, co=
nst char *name,
         return;
     }
=20
-    visit_type_str(v, name, &str, &local_err);
-    if (local_err) {
+    if (!visit_type_str(v, name, &str, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index f5977eb72e..1c3bd2578c 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -736,8 +736,7 @@ static void usb_msd_set_bootindex(Object *obj, Visitor =
*v, const char *name,
     int32_t boot_index;
     Error *local_err =3D NULL;
=20
-    visit_type_int32(v, name, &boot_index, &local_err);
-    if (local_err) {
+    if (!visit_type_int32(v, name, &boot_index, &local_err)) {
         goto out;
     }
     /* check whether bootindex is present in fw_boot_order list  */
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index d304c81148..1467b8034e 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1509,8 +1509,7 @@ static void set_nv_gpudirect_clique_id(Object *obj, V=
isitor *v,
         return;
     }
=20
-    visit_type_uint8(v, name, &value, &local_err);
-    if (local_err) {
+    if (!visit_type_uint8(v, name, &value, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 10507b2a43..62676412f9 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -233,22 +233,18 @@ static void balloon_stats_get_all(Object *obj, Visito=
r *v, const char *name,
     VirtIOBalloon *s =3D opaque;
     int i;
=20
-    visit_start_struct(v, name, NULL, 0, &err);
-    if (err) {
+    if (!visit_start_struct(v, name, NULL, 0, &err)) {
         goto out;
     }
-    visit_type_int(v, "last-update", &s->stats_last_update, &err);
-    if (err) {
+    if (!visit_type_int(v, "last-update", &s->stats_last_update, &err)) {
         goto out_end;
     }
=20
-    visit_start_struct(v, "stats", NULL, 0, &err);
-    if (err) {
+    if (!visit_start_struct(v, "stats", NULL, 0, &err)) {
         goto out_end;
     }
     for (i =3D 0; i < VIRTIO_BALLOON_S_NR; i++) {
-        visit_type_uint64(v, balloon_stat_names[i], &s->stats[i], &err);
-        if (err) {
+        if (!visit_type_uint64(v, balloon_stat_names[i], &s->stats[i], &er=
r)) {
             goto out_nested;
         }
     }
@@ -281,8 +277,7 @@ static void balloon_stats_set_poll_interval(Object *obj=
, Visitor *v,
     Error *local_err =3D NULL;
     int64_t value;
=20
-    visit_type_int(v, name, &value, &local_err);
-    if (local_err) {
+    if (!visit_type_int(v, name, &value, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
diff --git a/iothread.c b/iothread.c
index cb082b9b26..cb65ef0e56 100644
--- a/iothread.c
+++ b/iothread.c
@@ -243,8 +243,7 @@ static void iothread_set_poll_param(Object *obj, Visito=
r *v,
     Error *local_err =3D NULL;
     int64_t value;
=20
-    visit_type_int64(v, name, &value, &local_err);
-    if (local_err) {
+    if (!visit_type_int64(v, name, &value, &local_err)) {
         goto out;
     }
=20
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index d7810cb564..9588c2d81f 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -1355,8 +1355,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const QD=
ict *qdict)
         break;
     case MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE:
         p->has_xbzrle_cache_size =3D true;
-        visit_type_size(v, param, &cache_size, &err);
-        if (err) {
+        if (!visit_type_size(v, param, &cache_size, &err)) {
             break;
         }
         if (cache_size > INT64_MAX || (size_t)cache_size !=3D cache_size) =
{
diff --git a/net/colo-compare.c b/net/colo-compare.c
index f15779dedc..6835d42363 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -1096,8 +1096,7 @@ static void compare_set_timeout(Object *obj, Visitor =
*v,
     Error *local_err =3D NULL;
     uint32_t value;
=20
-    visit_type_uint32(v, name, &value, &local_err);
-    if (local_err) {
+    if (!visit_type_uint32(v, name, &value, &local_err)) {
         goto out;
     }
     if (!value) {
@@ -1129,8 +1128,7 @@ static void compare_set_expired_scan_cycle(Object *ob=
j, Visitor *v,
     Error *local_err =3D NULL;
     uint32_t value;
=20
-    visit_type_uint32(v, name, &value, &local_err);
-    if (local_err) {
+    if (!visit_type_uint32(v, name, &value, &local_err)) {
         goto out;
     }
     if (!value) {
diff --git a/net/dump.c b/net/dump.c
index 61389e7dad..8c487a5590 100644
--- a/net/dump.c
+++ b/net/dump.c
@@ -195,8 +195,7 @@ static void filter_dump_set_maxlen(Object *obj, Visitor=
 *v, const char *name,
     Error *local_err =3D NULL;
     uint32_t value;
=20
-    visit_type_uint32(v, name, &value, &local_err);
-    if (local_err) {
+    if (!visit_type_uint32(v, name, &value, &local_err)) {
         goto out;
     }
     if (value =3D=3D 0) {
diff --git a/net/filter-buffer.c b/net/filter-buffer.c
index 93050f86cf..8e42934b37 100644
--- a/net/filter-buffer.c
+++ b/net/filter-buffer.c
@@ -173,8 +173,7 @@ static void filter_buffer_set_interval(Object *obj, Vis=
itor *v,
     Error *local_err =3D NULL;
     uint32_t value;
=20
-    visit_type_uint32(v, name, &value, &local_err);
-    if (local_err) {
+    if (!visit_type_uint32(v, name, &value, &local_err)) {
         goto out;
     }
     if (!value) {
diff --git a/qom/object.c b/qom/object.c
index 6ece96bc2b..87ee0b5a81 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2080,8 +2080,7 @@ static void property_set_str(Object *obj, Visitor *v,=
 const char *name,
     char *value;
     Error *local_err =3D NULL;
=20
-    visit_type_str(v, name, &value, &local_err);
-    if (local_err) {
+    if (!visit_type_str(v, name, &value, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
@@ -2161,8 +2160,7 @@ static void property_set_bool(Object *obj, Visitor *v=
, const char *name,
     bool value;
     Error *local_err =3D NULL;
=20
-    visit_type_bool(v, name, &value, &local_err);
-    if (local_err) {
+    if (!visit_type_bool(v, name, &value, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
@@ -2234,8 +2232,7 @@ static void property_set_enum(Object *obj, Visitor *v=
, const char *name,
     int value;
     Error *err =3D NULL;
=20
-    visit_type_enum(v, name, &value, prop->lookup, &err);
-    if (err) {
+    if (!visit_type_enum(v, name, &value, prop->lookup, &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -2305,32 +2302,25 @@ static void property_get_tm(Object *obj, Visitor *v=
, const char *name,
         goto out;
     }
=20
-    visit_start_struct(v, name, NULL, 0, &err);
-    if (err) {
+    if (!visit_start_struct(v, name, NULL, 0, &err)) {
         goto out;
     }
-    visit_type_int32(v, "tm_year", &value.tm_year, &err);
-    if (err) {
+    if (!visit_type_int32(v, "tm_year", &value.tm_year, &err)) {
         goto out_end;
     }
-    visit_type_int32(v, "tm_mon", &value.tm_mon, &err);
-    if (err) {
+    if (!visit_type_int32(v, "tm_mon", &value.tm_mon, &err)) {
         goto out_end;
     }
-    visit_type_int32(v, "tm_mday", &value.tm_mday, &err);
-    if (err) {
+    if (!visit_type_int32(v, "tm_mday", &value.tm_mday, &err)) {
         goto out_end;
     }
-    visit_type_int32(v, "tm_hour", &value.tm_hour, &err);
-    if (err) {
+    if (!visit_type_int32(v, "tm_hour", &value.tm_hour, &err)) {
         goto out_end;
     }
-    visit_type_int32(v, "tm_min", &value.tm_min, &err);
-    if (err) {
+    if (!visit_type_int32(v, "tm_min", &value.tm_min, &err)) {
         goto out_end;
     }
-    visit_type_int32(v, "tm_sec", &value.tm_sec, &err);
-    if (err) {
+    if (!visit_type_int32(v, "tm_sec", &value.tm_sec, &err)) {
         goto out_end;
     }
     visit_check_struct(v, &err);
@@ -2394,8 +2384,7 @@ static void property_set_uint8_ptr(Object *obj, Visit=
or *v, const char *name,
     uint8_t value;
     Error *local_err =3D NULL;
=20
-    visit_type_uint8(v, name, &value, &local_err);
-    if (local_err) {
+    if (!visit_type_uint8(v, name, &value, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
@@ -2417,8 +2406,7 @@ static void property_set_uint16_ptr(Object *obj, Visi=
tor *v, const char *name,
     uint16_t value;
     Error *local_err =3D NULL;
=20
-    visit_type_uint16(v, name, &value, &local_err);
-    if (local_err) {
+    if (!visit_type_uint16(v, name, &value, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
@@ -2440,8 +2428,7 @@ static void property_set_uint32_ptr(Object *obj, Visi=
tor *v, const char *name,
     uint32_t value;
     Error *local_err =3D NULL;
=20
-    visit_type_uint32(v, name, &value, &local_err);
-    if (local_err) {
+    if (!visit_type_uint32(v, name, &value, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
@@ -2463,8 +2450,7 @@ static void property_set_uint64_ptr(Object *obj, Visi=
tor *v, const char *name,
     uint64_t value;
     Error *local_err =3D NULL;
=20
-    visit_type_uint64(v, name, &value, &local_err);
-    if (local_err) {
+    if (!visit_type_uint64(v, name, &value, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index 7e26f86fa6..3085ae0b31 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -63,8 +63,7 @@ Object *user_creatable_add_type(const char *type, const c=
har *id,
=20
     assert(qdict);
     obj =3D object_new(type);
-    visit_start_struct(v, NULL, NULL, 0, &local_err);
-    if (local_err) {
+    if (!visit_start_struct(v, NULL, NULL, 0, &local_err)) {
         goto out;
     }
     for (e =3D qdict_first(qdict); e; e =3D qdict_next(qdict, e)) {
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index a2f4733eed..343c227c09 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -467,8 +467,7 @@ static void cpu_max_set_sve_max_vq(Object *obj, Visitor=
 *v, const char *name,
     Error *err =3D NULL;
     uint32_t max_vq;
=20
-    visit_type_uint32(v, name, &max_vq, &err);
-    if (err) {
+    if (!visit_type_uint32(v, name, &max_vq, &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -513,8 +512,7 @@ static void cpu_arm_set_sve_vq(Object *obj, Visitor *v,=
 const char *name,
     Error *err =3D NULL;
     bool value;
=20
-    visit_type_bool(v, name, &value, &err);
-    if (err) {
+    if (!visit_type_bool(v, name, &value, &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -550,8 +548,7 @@ static void cpu_arm_set_sve(Object *obj, Visitor *v, co=
nst char *name,
     bool value;
     uint64_t t;
=20
-    visit_type_bool(v, name, &value, &err);
-    if (err) {
+    if (!visit_type_bool(v, name, &value, &err)) {
         error_propagate(errp, err);
         return;
     }
diff --git a/target/arm/monitor.c b/target/arm/monitor.c
index ea6598c412..98fe11ae69 100644
--- a/target/arm/monitor.c
+++ b/target/arm/monitor.c
@@ -174,8 +174,7 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(Cp=
uModelExpansionType type,
         Error *err =3D NULL;
=20
         visitor =3D qobject_input_visitor_new(model->props);
-        visit_start_struct(visitor, NULL, NULL, 0, &err);
-        if (err) {
+        if (!visit_start_struct(visitor, NULL, NULL, 0, &err)) {
             visit_free(visitor);
             object_unref(obj);
             error_propagate(errp, err);
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 36cbd3d027..c69d057df3 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4420,8 +4420,7 @@ static void x86_cpuid_version_set_family(Object *obj,=
 Visitor *v,
     Error *local_err =3D NULL;
     int64_t value;
=20
-    visit_type_int(v, name, &value, &local_err);
-    if (local_err) {
+    if (!visit_type_int(v, name, &value, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
@@ -4463,8 +4462,7 @@ static void x86_cpuid_version_set_model(Object *obj, =
Visitor *v,
     Error *local_err =3D NULL;
     int64_t value;
=20
-    visit_type_int(v, name, &value, &local_err);
-    if (local_err) {
+    if (!visit_type_int(v, name, &value, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
@@ -4501,8 +4499,7 @@ static void x86_cpuid_version_set_stepping(Object *ob=
j, Visitor *v,
     Error *local_err =3D NULL;
     int64_t value;
=20
-    visit_type_int(v, name, &value, &local_err);
-    if (local_err) {
+    if (!visit_type_int(v, name, &value, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
@@ -4606,8 +4603,7 @@ static void x86_cpuid_set_tsc_freq(Object *obj, Visit=
or *v, const char *name,
     Error *local_err =3D NULL;
     int64_t value;
=20
-    visit_type_int(v, name, &value, &local_err);
-    if (local_err) {
+    if (!visit_type_int(v, name, &value, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
@@ -6816,8 +6812,7 @@ static void x86_cpu_set_bit_prop(Object *obj, Visitor=
 *v, const char *name,
         return;
     }
=20
-    visit_type_bool(v, name, &value, &local_err);
-    if (local_err) {
+    if (!visit_type_bool(v, name, &value, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
diff --git a/target/ppc/compat.c b/target/ppc/compat.c
index fda0dfe8f8..42f87a4bfe 100644
--- a/target/ppc/compat.c
+++ b/target/ppc/compat.c
@@ -264,8 +264,7 @@ static void ppc_compat_prop_set(Object *obj, Visitor *v=
, const char *name,
     char *value;
     uint32_t compat_pvr;
=20
-    visit_type_str(v, name, &value, &local_err);
-    if (local_err) {
+    if (!visit_type_str(v, name, &value, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 2fa609bffe..65c26c4c86 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -510,8 +510,7 @@ static void cpu_model_from_info(S390CPUModel *model, co=
nst CpuModelInfo *info,
=20
     if (qdict) {
         visitor =3D qobject_input_visitor_new(info->props);
-        visit_start_struct(visitor, NULL, NULL, 0, &err);
-        if (err) {
+        if (!visit_start_struct(visitor, NULL, NULL, 0, &err)) {
             error_propagate(errp, err);
             visit_free(visitor);
             object_unref(obj);
@@ -1017,8 +1016,7 @@ static void set_feature(Object *obj, Visitor *v, cons=
t char *name,
         return;
     }
=20
-    visit_type_bool(v, name, &value, &err);
-    if (err) {
+    if (!visit_type_bool(v, name, &value, &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -1076,8 +1074,7 @@ static void set_feature_group(Object *obj, Visitor *v=
, const char *name,
         return;
     }
=20
-    visit_type_bool(v, name, &value, &err);
-    if (err) {
+    if (!visit_type_bool(v, name, &value, &err)) {
         error_propagate(errp, err);
         return;
     }
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 3f05aba9d6..4a9257005d 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -804,8 +804,7 @@ static void sparc_set_nwindows(Object *obj, Visitor *v,=
 const char *name,
     Error *err =3D NULL;
     int64_t value;
=20
-    visit_type_int(v, name, &value, &err);
-    if (err) {
+    if (!visit_type_int(v, name, &value, &err)) {
         error_propagate(errp, err);
         return;
     }
--=20
2.26.2


