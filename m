Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DF3C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 16:57:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9050A20738
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 16:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D4TWyciM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9050A20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo8ho-0000pt-QG
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 12:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jo8VP-0003aQ-0B
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 12:44:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60033
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jo8VA-00055m-Ny
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 12:44:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593017034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6oPxQQbv129eV7W9Fe7d53n7RI1HTEwndPoWMltfdFY=;
 b=D4TWyciMnSKw+2PGWnEGIKoQU7vFr4UJrzZgaryKSO15frTV2xj5AL+pyDpWckEED22b2R
 ChvzOHW0L4urOvgVP6c1oPpuBkjxfwygR77uppNCuRv+6DaZPNdt1WUgkFiX9AGQuiwcAS
 ZTuCmxdDzz9mLllW2mb242rOro6rY5E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-3bGc0FVgOGW36K_5nnXXfQ-1; Wed, 24 Jun 2020 12:43:52 -0400
X-MC-Unique: 3bGc0FVgOGW36K_5nnXXfQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1BA0B107ACF4;
 Wed, 24 Jun 2020 16:43:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 625F62B473;
 Wed, 24 Jun 2020 16:43:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 383951138484; Wed, 24 Jun 2020 18:43:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 23/46] qapi: Smooth error checking with Coccinelle
Date: Wed, 24 Jun 2020 18:43:21 +0200
Message-Id: <20200624164344.3778251-24-armbru@redhat.com>
In-Reply-To: <20200624164344.3778251-1-armbru@redhat.com>
References: <20200624164344.3778251-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 02:33:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 ehabkost@redhat.com, qemu-block@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The previous commit enables conversion of

    visit_foo(..., &err);
    if (err) {
=09...
    }

to

    if (!visit_foo(..., errp)) {
=09...
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
    expression list args, args2;
    typedef Error;
    Error *err;
    identifier errp;
    @@
    -      fun(args, &err, args2);
    -      if (err) {
    +      if (!fun(args, errp, args2)) {
=09       ... when !=3D err
    -=09   error_propagate(errp, err);
=09       ...
=09   }

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
    expression list args, args2;
    typedef Error;
    Error *err;
    @@
    -      fun(args, &err, args2);
    -      if (err) {
    +      if (!fun(args, &err, args2)) {
=09       ...
=09   }

Eliminate error_propagate() that are now unnecessary.  Delete @err
that are now unused.  Tidy up line breaks and whitespace.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 accel/kvm/kvm-all.c              |  5 +--
 accel/tcg/tcg-all.c              |  5 +--
 backends/cryptodev.c             |  5 +--
 backends/hostmem-file.c          |  5 +--
 backends/hostmem-memfd.c         |  5 +--
 backends/hostmem.c               | 10 ++----
 block/blkdebug.c                 |  5 +--
 block/nbd.c                      |  5 +--
 block/sheepdog.c                 |  5 +--
 block/throttle-groups.c          |  8 ++---
 bootdevice.c                     |  3 +-
 hw/block/xen-block.c             |  5 +--
 hw/core/machine.c                |  5 +--
 hw/core/qdev-properties-system.c | 20 +++--------
 hw/core/qdev-properties.c        | 58 +++++++-------------------------
 hw/cpu/core.c                    | 10 ++----
 hw/gpio/aspeed_gpio.c            |  5 +--
 hw/i386/pc.c                     |  5 +--
 hw/ide/qdev.c                    |  3 +-
 hw/intc/apic_common.c            |  5 +--
 hw/mem/nvdimm.c                  |  8 ++---
 hw/misc/aspeed_sdmc.c            |  5 +--
 hw/misc/pca9552.c                |  5 +--
 hw/misc/tmp105.c                 |  5 +--
 hw/misc/tmp421.c                 |  5 +--
 hw/net/ne2000-isa.c              |  3 +-
 hw/ppc/spapr_caps.c              | 15 ++-------
 hw/ppc/spapr_drc.c               | 13 +++----
 hw/s390x/css.c                   |  5 +--
 hw/tpm/tpm_util.c                |  5 +--
 hw/usb/dev-storage.c             |  3 +-
 hw/vfio/pci-quirks.c             |  5 +--
 hw/virtio/virtio-balloon.c       | 17 +++-------
 iothread.c                       |  5 +--
 monitor/hmp-cmds.c               |  3 +-
 net/colo-compare.c               | 10 ++----
 net/dump.c                       |  5 +--
 net/filter-buffer.c              |  5 +--
 qom/object.c                     | 56 ++++++++----------------------
 qom/object_interfaces.c          |  3 +-
 target/arm/cpu64.c               | 15 ++-------
 target/arm/monitor.c             |  4 +--
 target/i386/cpu.c                | 25 +++-----------
 target/ppc/compat.c              |  5 +--
 target/s390x/cpu_models.c        | 14 ++------
 target/sparc/cpu.c               |  5 +--
 46 files changed, 95 insertions(+), 331 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f24d7da783..be02b8e07a 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3106,12 +3106,9 @@ static void kvm_set_kvm_shadow_mem(Object *obj, Visi=
tor *v,
                                    Error **errp)
 {
     KVMState *s =3D KVM_STATE(obj);
-    Error *error =3D NULL;
     int64_t value;
=20
-    visit_type_int(v, name, &value, &error);
-    if (error) {
-        error_propagate(errp, error);
+    if (!visit_type_int(v, name, &value, errp)) {
         return;
     }
=20
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 3b4fda5640..eace2c113b 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -182,12 +182,9 @@ static void tcg_set_tb_size(Object *obj, Visitor *v,
                             Error **errp)
 {
     TCGState *s =3D TCG_STATE(obj);
-    Error *error =3D NULL;
     uint32_t value;
=20
-    visit_type_uint32(v, name, &value, &error);
-    if (error) {
-        error_propagate(errp, error);
+    if (!visit_type_uint32(v, name, &value, errp)) {
         return;
     }
=20
diff --git a/backends/cryptodev.c b/backends/cryptodev.c
index 8645f297e3..17ee76a61e 100644
--- a/backends/cryptodev.c
+++ b/backends/cryptodev.c
@@ -154,12 +154,9 @@ cryptodev_backend_set_queues(Object *obj, Visitor *v, =
const char *name,
                              void *opaque, Error **errp)
 {
     CryptoDevBackend *backend =3D CRYPTODEV_BACKEND(obj);
-    Error *local_err =3D NULL;
     uint32_t value;
=20
-    visit_type_uint32(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_uint32(v, name, &value, errp)) {
         return;
     }
     if (!value) {
diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 098c8e6e64..5b819020b4 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -110,7 +110,6 @@ static void file_memory_backend_set_align(Object *o, Vi=
sitor *v,
 {
     HostMemoryBackend *backend =3D MEMORY_BACKEND(o);
     HostMemoryBackendFile *fb =3D MEMORY_BACKEND_FILE(o);
-    Error *local_err =3D NULL;
     uint64_t val;
=20
     if (host_memory_backend_mr_inited(backend)) {
@@ -119,9 +118,7 @@ static void file_memory_backend_set_align(Object *o, Vi=
sitor *v,
         return;
     }
=20
-    visit_type_size(v, name, &val, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_size(v, name, &val, errp)) {
         return;
     }
     fb->align =3D val;
diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index 9582c7f8fc..4c040a7541 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -77,7 +77,6 @@ memfd_backend_set_hugetlbsize(Object *obj, Visitor *v, co=
nst char *name,
                               void *opaque, Error **errp)
 {
     HostMemoryBackendMemfd *m =3D MEMORY_BACKEND_MEMFD(obj);
-    Error *local_err =3D NULL;
     uint64_t value;
=20
     if (host_memory_backend_mr_inited(MEMORY_BACKEND(obj))) {
@@ -85,9 +84,7 @@ memfd_backend_set_hugetlbsize(Object *obj, Visitor *v, co=
nst char *name,
         return;
     }
=20
-    visit_type_size(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_size(v, name, &value, errp)) {
         return;
     }
     if (!value) {
diff --git a/backends/hostmem.c b/backends/hostmem.c
index 2a0c92d458..c614f1bdc1 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -54,7 +54,6 @@ host_memory_backend_set_size(Object *obj, Visitor *v, con=
st char *name,
                              void *opaque, Error **errp)
 {
     HostMemoryBackend *backend =3D MEMORY_BACKEND(obj);
-    Error *local_err =3D NULL;
     uint64_t value;
=20
     if (host_memory_backend_mr_inited(backend)) {
@@ -63,9 +62,7 @@ host_memory_backend_set_size(Object *obj, Visitor *v, con=
st char *name,
         return;
     }
=20
-    visit_type_size(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_size(v, name, &value, errp)) {
         return;
     }
     if (!value) {
@@ -253,12 +250,9 @@ static void host_memory_backend_set_prealloc_threads(O=
bject *obj, Visitor *v,
     const char *name, void *opaque, Error **errp)
 {
     HostMemoryBackend *backend =3D MEMORY_BACKEND(obj);
-    Error *local_err =3D NULL;
     uint32_t value;
=20
-    visit_type_uint32(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_uint32(v, name, &value, errp)) {
         return;
     }
     if (value <=3D 0) {
diff --git a/block/blkdebug.c b/block/blkdebug.c
index fa4b4fefdc..9c08d8a005 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -359,7 +359,6 @@ static int blkdebug_parse_perm_list(uint64_t *dest, QDi=
ct *options,
     QObject *crumpled_subqdict =3D NULL;
     Visitor *v =3D NULL;
     BlockPermissionList *perm_list =3D NULL, *element;
-    Error *local_err =3D NULL;
=20
     *dest =3D 0;
=20
@@ -375,9 +374,7 @@ static int blkdebug_parse_perm_list(uint64_t *dest, QDi=
ct *options,
     }
=20
     v =3D qobject_input_visitor_new(crumpled_subqdict);
-    visit_type_BlockPermissionList(v, NULL, &perm_list, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_BlockPermissionList(v, NULL, &perm_list, errp)) {
         ret =3D -EINVAL;
         goto out;
     }
diff --git a/block/nbd.c b/block/nbd.c
index 9789c56476..6876da04a7 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1726,7 +1726,6 @@ static SocketAddress *nbd_config(BDRVNBDState *s, QDi=
ct *options,
     SocketAddress *saddr =3D NULL;
     QDict *addr =3D NULL;
     Visitor *iv =3D NULL;
-    Error *local_err =3D NULL;
=20
     qdict_extract_subqdict(options, &addr, "server.");
     if (!qdict_size(addr)) {
@@ -1739,9 +1738,7 @@ static SocketAddress *nbd_config(BDRVNBDState *s, QDi=
ct *options,
         goto done;
     }
=20
-    visit_type_SocketAddress(iv, NULL, &saddr, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_SocketAddress(iv, NULL, &saddr, errp)) {
         goto done;
     }
=20
diff --git a/block/sheepdog.c b/block/sheepdog.c
index 9cb5ae5fc6..a6a91442c9 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -532,7 +532,6 @@ static SocketAddress *sd_server_config(QDict *options, =
Error **errp)
     QDict *server =3D NULL;
     Visitor *iv =3D NULL;
     SocketAddress *saddr =3D NULL;
-    Error *local_err =3D NULL;
=20
     qdict_extract_subqdict(options, &server, "server.");
=20
@@ -541,9 +540,7 @@ static SocketAddress *sd_server_config(QDict *options, =
Error **errp)
         goto done;
     }
=20
-    visit_type_SocketAddress(iv, NULL, &saddr, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_SocketAddress(iv, NULL, &saddr, errp)) {
         goto done;
     }
=20
diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 60a2aad75a..dba2bb6451 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -811,7 +811,6 @@ static void throttle_group_set(Object *obj, Visitor *v,=
 const char * name,
     ThrottleGroup *tg =3D THROTTLE_GROUP(obj);
     ThrottleConfig *cfg;
     ThrottleParamInfo *info =3D opaque;
-    Error *local_err =3D NULL;
     int64_t value;
=20
     /* If we have finished initialization, don't accept individual propert=
y
@@ -823,9 +822,7 @@ static void throttle_group_set(Object *obj, Visitor *v,=
 const char * name,
         return;
     }
=20
-    visit_type_int64(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_int64(v, name, &value, errp)) {
         return;
     }
     if (value < 0) {
@@ -892,8 +889,7 @@ static void throttle_group_set_limits(Object *obj, Visi=
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
index 10c44dfda2..6ca6f18c7b 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -403,7 +403,6 @@ static void xen_block_set_vdev(Object *obj, Visitor *v,=
 const char *name,
     DeviceState *dev =3D DEVICE(obj);
     Property *prop =3D opaque;
     XenBlockVdev *vdev =3D qdev_get_prop_ptr(dev, prop);
-    Error *local_err =3D NULL;
     char *str, *p;
     const char *end;
=20
@@ -412,9 +411,7 @@ static void xen_block_set_vdev(Object *obj, Visitor *v,=
 const char *name,
         return;
     }
=20
-    visit_type_str(v, name, &str, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_str(v, name, &str, errp)) {
         return;
     }
=20
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 1d80ab0e1d..109eb3bb24 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -290,12 +290,9 @@ static void machine_set_phandle_start(Object *obj, Vis=
itor *v,
                                       Error **errp)
 {
     MachineState *ms =3D MACHINE(obj);
-    Error *error =3D NULL;
     int64_t value;
=20
-    visit_type_int(v, name, &value, &error);
-    if (error) {
-        error_propagate(errp, error);
+    if (!visit_type_int(v, name, &value, errp)) {
         return;
     }
=20
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-sys=
tem.c
index 38b0c9f09b..f69e2858d1 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -80,7 +80,6 @@ static void set_drive_helper(Object *obj, Visitor *v, con=
st char *name,
 {
     DeviceState *dev =3D DEVICE(obj);
     Property *prop =3D opaque;
-    Error *local_err =3D NULL;
     void **ptr =3D qdev_get_prop_ptr(dev, prop);
     char *str;
     BlockBackend *blk;
@@ -92,9 +91,7 @@ static void set_drive_helper(Object *obj, Visitor *v, con=
st char *name,
         return;
     }
=20
-    visit_type_str(v, name, &str, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_str(v, name, &str, errp)) {
         return;
     }
=20
@@ -227,7 +224,6 @@ static void set_chr(Object *obj, Visitor *v, const char=
 *name, void *opaque,
                     Error **errp)
 {
     DeviceState *dev =3D DEVICE(obj);
-    Error *local_err =3D NULL;
     Property *prop =3D opaque;
     CharBackend *be =3D qdev_get_prop_ptr(dev, prop);
     Chardev *s;
@@ -238,9 +234,7 @@ static void set_chr(Object *obj, Visitor *v, const char=
 *name, void *opaque,
         return;
     }
=20
-    visit_type_str(v, name, &str, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_str(v, name, &str, errp)) {
         return;
     }
=20
@@ -307,7 +301,6 @@ static void set_netdev(Object *obj, Visitor *v, const c=
har *name,
     NICPeers *peers_ptr =3D qdev_get_prop_ptr(dev, prop);
     NetClientState **ncs =3D peers_ptr->ncs;
     NetClientState *peers[MAX_QUEUE_NUM];
-    Error *local_err =3D NULL;
     int queues, err =3D 0, i =3D 0;
     char *str;
=20
@@ -316,9 +309,7 @@ static void set_netdev(Object *obj, Visitor *v, const c=
har *name,
         return;
     }
=20
-    visit_type_str(v, name, &str, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_str(v, name, &str, errp)) {
         return;
     }
=20
@@ -389,7 +380,6 @@ static void set_audiodev(Object *obj, Visitor *v, const=
 char* name,
     Property *prop =3D opaque;
     QEMUSoundCard *card =3D qdev_get_prop_ptr(dev, prop);
     AudioState *state;
-    Error *local_err =3D NULL;
     int err =3D 0;
     char *str;
=20
@@ -398,9 +388,7 @@ static void set_audiodev(Object *obj, Visitor *v, const=
 char* name,
         return;
     }
=20
-    visit_type_str(v, name, &str, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_str(v, name, &str, errp)) {
         return;
     }
=20
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 71f8aca7c6..fa88a8885c 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -116,7 +116,6 @@ static void prop_set_bit(Object *obj, Visitor *v, const=
 char *name,
 {
     DeviceState *dev =3D DEVICE(obj);
     Property *prop =3D opaque;
-    Error *local_err =3D NULL;
     bool value;
=20
     if (dev->realized) {
@@ -124,9 +123,7 @@ static void prop_set_bit(Object *obj, Visitor *v, const=
 char *name,
         return;
     }
=20
-    visit_type_bool(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_bool(v, name, &value, errp)) {
         return;
     }
     bit_prop_set(dev, prop, value);
@@ -180,7 +177,6 @@ static void prop_set_bit64(Object *obj, Visitor *v, con=
st char *name,
 {
     DeviceState *dev =3D DEVICE(obj);
     Property *prop =3D opaque;
-    Error *local_err =3D NULL;
     bool value;
=20
     if (dev->realized) {
@@ -188,9 +184,7 @@ static void prop_set_bit64(Object *obj, Visitor *v, con=
st char *name,
         return;
     }
=20
-    visit_type_bool(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_bool(v, name, &value, errp)) {
         return;
     }
     bit64_prop_set(dev, prop, value);
@@ -477,7 +471,6 @@ static void set_string(Object *obj, Visitor *v, const c=
har *name,
     DeviceState *dev =3D DEVICE(obj);
     Property *prop =3D opaque;
     char **ptr =3D qdev_get_prop_ptr(dev, prop);
-    Error *local_err =3D NULL;
     char *str;
=20
     if (dev->realized) {
@@ -485,9 +478,7 @@ static void set_string(Object *obj, Visitor *v, const c=
har *name,
         return;
     }
=20
-    visit_type_str(v, name, &str, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_str(v, name, &str, errp)) {
         return;
     }
     g_free(*ptr);
@@ -530,7 +521,6 @@ static void set_mac(Object *obj, Visitor *v, const char=
 *name, void *opaque,
     DeviceState *dev =3D DEVICE(obj);
     Property *prop =3D opaque;
     MACAddr *mac =3D qdev_get_prop_ptr(dev, prop);
-    Error *local_err =3D NULL;
     int i, pos;
     char *str, *p;
=20
@@ -539,9 +529,7 @@ static void set_mac(Object *obj, Visitor *v, const char=
 *name, void *opaque,
         return;
     }
=20
-    visit_type_str(v, name, &str, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_str(v, name, &str, errp)) {
         return;
     }
=20
@@ -673,8 +661,7 @@ static void set_pci_devfn(Object *obj, Visitor *v, cons=
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
@@ -748,16 +735,13 @@ static void set_size32(Object *obj, Visitor *v, const=
 char *name, void *opaque,
     Property *prop =3D opaque;
     uint32_t *ptr =3D qdev_get_prop_ptr(dev, prop);
     uint64_t value;
-    Error *local_err =3D NULL;
=20
     if (dev->realized) {
         qdev_prop_set_after_realize(dev, name, errp);
         return;
     }
=20
-    visit_type_size(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_size(v, name, &value, errp)) {
         return;
     }
=20
@@ -798,16 +782,13 @@ static void set_blocksize(Object *obj, Visitor *v, co=
nst char *name,
     Property *prop =3D opaque;
     uint32_t *ptr =3D qdev_get_prop_ptr(dev, prop);
     uint64_t value;
-    Error *local_err =3D NULL;
=20
     if (dev->realized) {
         qdev_prop_set_after_realize(dev, name, errp);
         return;
     }
=20
-    visit_type_size(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_size(v, name, &value, errp)) {
         return;
     }
     /* value of 0 means "unset" */
@@ -875,7 +856,6 @@ static void set_pci_host_devaddr(Object *obj, Visitor *=
v, const char *name,
     DeviceState *dev =3D DEVICE(obj);
     Property *prop =3D opaque;
     PCIHostDeviceAddress *addr =3D qdev_get_prop_ptr(dev, prop);
-    Error *local_err =3D NULL;
     char *str, *p;
     char *e;
     unsigned long val;
@@ -887,9 +867,7 @@ static void set_pci_host_devaddr(Object *obj, Visitor *=
v, const char *name,
         return;
     }
=20
-    visit_type_str(v, name, &str, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_str(v, name, &str, errp)) {
         return;
     }
=20
@@ -979,7 +957,6 @@ static void set_uuid(Object *obj, Visitor *v, const cha=
r *name, void *opaque,
     DeviceState *dev =3D DEVICE(obj);
     Property *prop =3D opaque;
     QemuUUID *uuid =3D qdev_get_prop_ptr(dev, prop);
-    Error *local_err =3D NULL;
     char *str;
=20
     if (dev->realized) {
@@ -987,9 +964,7 @@ static void set_uuid(Object *obj, Visitor *v, const cha=
r *name, void *opaque,
         return;
     }
=20
-    visit_type_str(v, name, &str, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_str(v, name, &str, errp)) {
         return;
     }
=20
@@ -1055,7 +1030,6 @@ static void set_prop_arraylen(Object *obj, Visitor *v=
, const char *name,
     Property *prop =3D opaque;
     uint32_t *alenptr =3D qdev_get_prop_ptr(dev, prop);
     void **arrayptr =3D (void *)dev + prop->arrayoffset;
-    Error *local_err =3D NULL;
     void *eltptr;
     const char *arrayname;
     int i;
@@ -1069,9 +1043,7 @@ static void set_prop_arraylen(Object *obj, Visitor *v=
, const char *name,
                    name);
         return;
     }
-    visit_type_uint32(v, name, alenptr, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_uint32(v, name, alenptr, errp)) {
         return;
     }
     if (!*alenptr) {
@@ -1394,16 +1366,13 @@ static void set_prop_pcielinkspeed(Object *obj, Vis=
itor *v, const char *name,
     Property *prop =3D opaque;
     PCIExpLinkSpeed *p =3D qdev_get_prop_ptr(dev, prop);
     int speed;
-    Error *local_err =3D NULL;
=20
     if (dev->realized) {
         qdev_prop_set_after_realize(dev, name, errp);
         return;
     }
=20
-    visit_type_enum(v, prop->name, &speed, prop->info->enum_table, &local_=
err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_enum(v, prop->name, &speed, prop->info->enum_table, er=
rp)) {
         return;
     }
=20
@@ -1482,16 +1451,13 @@ static void set_prop_pcielinkwidth(Object *obj, Vis=
itor *v, const char *name,
     Property *prop =3D opaque;
     PCIExpLinkWidth *p =3D qdev_get_prop_ptr(dev, prop);
     int width;
-    Error *local_err =3D NULL;
=20
     if (dev->realized) {
         qdev_prop_set_after_realize(dev, name, errp);
         return;
     }
=20
-    visit_type_enum(v, prop->name, &width, prop->info->enum_table, &local_=
err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_enum(v, prop->name, &width, prop->info->enum_table, er=
rp)) {
         return;
     }
=20
diff --git a/hw/cpu/core.c b/hw/cpu/core.c
index a92ac597ca..3a659291ea 100644
--- a/hw/cpu/core.c
+++ b/hw/cpu/core.c
@@ -28,12 +28,9 @@ static void core_prop_set_core_id(Object *obj, Visitor *=
v, const char *name,
                                   void *opaque, Error **errp)
 {
     CPUCore *core =3D CPU_CORE(obj);
-    Error *local_err =3D NULL;
     int64_t value;
=20
-    visit_type_int(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_int(v, name, &value, errp)) {
         return;
     }
=20
@@ -58,12 +55,9 @@ static void core_prop_set_nr_threads(Object *obj, Visito=
r *v, const char *name,
                                      void *opaque, Error **errp)
 {
     CPUCore *core =3D CPU_CORE(obj);
-    Error *local_err =3D NULL;
     int64_t value;
=20
-    visit_type_int(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_int(v, name, &value, errp)) {
         return;
     }
=20
diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
index dfa9db3d33..985a259e05 100644
--- a/hw/gpio/aspeed_gpio.c
+++ b/hw/gpio/aspeed_gpio.c
@@ -755,16 +755,13 @@ static void aspeed_gpio_get_pin(Object *obj, Visitor =
*v, const char *name,
 static void aspeed_gpio_set_pin(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
-    Error *local_err =3D NULL;
     bool level;
     int pin =3D 0xfff;
     char group[4];
     AspeedGPIOState *s =3D ASPEED_GPIO(obj);
     int set_idx, group_idx =3D 0;
=20
-    visit_type_bool(v, name, &level, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_bool(v, name, &level, errp)) {
         return;
     }
     if (sscanf(name, "gpio%2[A-Z]%1d", group, &pin) !=3D 2) {
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 70d832536b..50e431346e 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1864,12 +1864,9 @@ static void pc_machine_set_max_ram_below_4g(Object *=
obj, Visitor *v,
                                             Error **errp)
 {
     PCMachineState *pcms =3D PC_MACHINE(obj);
-    Error *error =3D NULL;
     uint64_t value;
=20
-    visit_type_size(v, name, &value, &error);
-    if (error) {
-        error_propagate(errp, error);
+    if (!visit_type_size(v, name, &value, errp)) {
         return;
     }
     if (value > 4 * GiB) {
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
index 7da2862b3d..dc070343c0 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -420,7 +420,6 @@ static void apic_common_set_id(Object *obj, Visitor *v,=
 const char *name,
 {
     APICCommonState *s =3D APIC_COMMON(obj);
     DeviceState *dev =3D DEVICE(obj);
-    Error *local_err =3D NULL;
     uint32_t value;
=20
     if (dev->realized) {
@@ -428,9 +427,7 @@ static void apic_common_set_id(Object *obj, Visitor *v,=
 const char *name,
         return;
     }
=20
-    visit_type_uint32(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_uint32(v, name, &value, errp)) {
         return;
     }
=20
diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index 93f7af1c58..e6fdf6ccc3 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -45,7 +45,6 @@ static void nvdimm_set_label_size(Object *obj, Visitor *v=
, const char *name,
                                   void *opaque, Error **errp)
 {
     NVDIMMDevice *nvdimm =3D NVDIMM(obj);
-    Error *local_err =3D NULL;
     uint64_t value;
=20
     if (nvdimm->nvdimm_mr) {
@@ -53,9 +52,7 @@ static void nvdimm_set_label_size(Object *obj, Visitor *v=
, const char *name,
         return;
     }
=20
-    visit_type_size(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_size(v, name, &value, errp)) {
         return;
     }
     if (value < MIN_NAMESPACE_LABEL_SIZE) {
@@ -88,8 +85,7 @@ static void nvdimm_set_uuid(Object *obj, Visitor *v, cons=
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
index 6fefb05695..0737d8de81 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -223,13 +223,10 @@ static void aspeed_sdmc_set_ram_size(Object *obj, Vis=
itor *v, const char *name,
     int i;
     char *sz;
     int64_t value;
-    Error *local_err =3D NULL;
     AspeedSDMCState *s =3D ASPEED_SDMC(obj);
     AspeedSDMCClass *asc =3D ASPEED_SDMC_GET_CLASS(s);
=20
-    visit_type_int(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_int(v, name, &value, errp)) {
         return;
     }
=20
diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
index cac729e35a..3e82c2838f 100644
--- a/hw/misc/pca9552.c
+++ b/hw/misc/pca9552.c
@@ -213,14 +213,11 @@ static void pca9552_set_led(Object *obj, Visitor *v, =
const char *name,
                             void *opaque, Error **errp)
 {
     PCA9552State *s =3D PCA9552(obj);
-    Error *local_err =3D NULL;
     int led, rc, reg, val;
     uint8_t state;
     char *state_str;
=20
-    visit_type_str(v, name, &state_str, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_str(v, name, &state_str, errp)) {
         return;
     }
     rc =3D sscanf(name, "led%2d", &led);
diff --git a/hw/misc/tmp105.c b/hw/misc/tmp105.c
index 58dbebca90..b47120492a 100644
--- a/hw/misc/tmp105.c
+++ b/hw/misc/tmp105.c
@@ -72,12 +72,9 @@ static void tmp105_set_temperature(Object *obj, Visitor =
*v, const char *name,
                                    void *opaque, Error **errp)
 {
     TMP105State *s =3D TMP105(obj);
-    Error *local_err =3D NULL;
     int64_t temp;
=20
-    visit_type_int(v, name, &temp, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_int(v, name, &temp, errp)) {
         return;
     }
     if (temp >=3D 128000 || temp < -128000) {
diff --git a/hw/misc/tmp421.c b/hw/misc/tmp421.c
index 74864cd93d..49abe2d246 100644
--- a/hw/misc/tmp421.c
+++ b/hw/misc/tmp421.c
@@ -141,15 +141,12 @@ static void tmp421_set_temperature(Object *obj, Visit=
or *v, const char *name,
                                    void *opaque, Error **errp)
 {
     TMP421State *s =3D TMP421(obj);
-    Error *local_err =3D NULL;
     int64_t temp;
     bool ext_range =3D (s->config[0] & TMP421_CONFIG_RANGE);
     int offset =3D ext_range * 64 * 256;
     int tempid;
=20
-    visit_type_int(v, name, &temp, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_int(v, name, &temp, errp)) {
         return;
     }
=20
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
index efdc0dbbcf..416c85bfb1 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -86,11 +86,8 @@ static void spapr_cap_set_bool(Object *obj, Visitor *v, =
const char *name,
     SpaprCapabilityInfo *cap =3D opaque;
     SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
     bool value;
-    Error *local_err =3D NULL;
=20
-    visit_type_bool(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_bool(v, name, &value, errp)) {
         return;
     }
=20
@@ -123,13 +120,10 @@ static void spapr_cap_set_string(Object *obj, Visitor=
 *v, const char *name,
 {
     SpaprCapabilityInfo *cap =3D opaque;
     SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
-    Error *local_err =3D NULL;
     uint8_t i;
     char *val;
=20
-    visit_type_str(v, name, &val, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_str(v, name, &val, errp)) {
         return;
     }
=20
@@ -169,11 +163,8 @@ static void spapr_cap_set_pagesize(Object *obj, Visito=
r *v, const char *name,
     SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
     uint64_t pagesize;
     uint8_t val;
-    Error *local_err =3D NULL;
=20
-    visit_type_size(v, name, &pagesize, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_size(v, name, &pagesize, errp)) {
         return;
     }
=20
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 951bcdf2c0..c8e8ba2ee8 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -327,9 +327,7 @@ static void prop_get_fdt(Object *obj, Visitor *v, const=
 char *name,
         case FDT_BEGIN_NODE:
             fdt_depth++;
             name =3D fdt_get_name(fdt, fdt_offset, &name_len);
-            visit_start_struct(v, name, NULL, 0, &err);
-            if (err) {
-                error_propagate(errp, err);
+            if (!visit_start_struct(v, name, NULL, 0, errp)) {
                 return;
             }
             break;
@@ -348,15 +346,12 @@ static void prop_get_fdt(Object *obj, Visitor *v, con=
st char *name,
             int i;
             prop =3D fdt_get_property_by_offset(fdt, fdt_offset, &prop_len=
);
             name =3D fdt_string(fdt, fdt32_to_cpu(prop->nameoff));
-            visit_start_list(v, name, NULL, 0, &err);
-            if (err) {
-                error_propagate(errp, err);
+            if (!visit_start_list(v, name, NULL, 0, errp)) {
                 return;
             }
             for (i =3D 0; i < prop_len; i++) {
-                visit_type_uint8(v, NULL, (uint8_t *)&prop->data[i], &err)=
;
-                if (err) {
-                    error_propagate(errp, err);
+                if (!visit_type_uint8(v, NULL, (uint8_t *)&prop->data[i],
+                                      errp)) {
                     return;
                 }
             }
diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index d1e365e3e6..519dc91316 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -2377,7 +2377,6 @@ static void set_css_devid(Object *obj, Visitor *v, co=
nst char *name,
     DeviceState *dev =3D DEVICE(obj);
     Property *prop =3D opaque;
     CssDevId *dev_id =3D qdev_get_prop_ptr(dev, prop);
-    Error *local_err =3D NULL;
     char *str;
     int num, n1, n2;
     unsigned int cssid, ssid, devid;
@@ -2387,9 +2386,7 @@ static void set_css_devid(Object *obj, Visitor *v, co=
nst char *name,
         return;
     }
=20
-    visit_type_str(v, name, &str, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_str(v, name, &str, errp)) {
         return;
     }
=20
diff --git a/hw/tpm/tpm_util.c b/hw/tpm/tpm_util.c
index c0a0f3d71f..ca3ea20bdb 100644
--- a/hw/tpm/tpm_util.c
+++ b/hw/tpm/tpm_util.c
@@ -48,7 +48,6 @@ static void set_tpm(Object *obj, Visitor *v, const char *=
name, void *opaque,
                     Error **errp)
 {
     DeviceState *dev =3D DEVICE(obj);
-    Error *local_err =3D NULL;
     Property *prop =3D opaque;
     TPMBackend *s, **be =3D qdev_get_prop_ptr(dev, prop);
     char *str;
@@ -58,9 +57,7 @@ static void set_tpm(Object *obj, Visitor *v, const char *=
name, void *opaque,
         return;
     }
=20
-    visit_type_str(v, name, &str, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_str(v, name, &str, errp)) {
         return;
     }
=20
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
index d304c81148..3a14b7c303 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1502,16 +1502,13 @@ static void set_nv_gpudirect_clique_id(Object *obj,=
 Visitor *v,
     DeviceState *dev =3D DEVICE(obj);
     Property *prop =3D opaque;
     uint8_t value, *ptr =3D qdev_get_prop_ptr(dev, prop);
-    Error *local_err =3D NULL;
=20
     if (dev->realized) {
         qdev_prop_set_after_realize(dev, name, errp);
         return;
     }
=20
-    visit_type_uint8(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_uint8(v, name, &value, errp)) {
         return;
     }
=20
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 10507b2a43..8eb652a348 100644
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
@@ -278,12 +274,9 @@ static void balloon_stats_set_poll_interval(Object *ob=
j, Visitor *v,
                                             Error **errp)
 {
     VirtIOBalloon *s =3D opaque;
-    Error *local_err =3D NULL;
     int64_t value;
=20
-    visit_type_int(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_int(v, name, &value, errp)) {
         return;
     }
=20
diff --git a/iothread.c b/iothread.c
index b465e5c25b..0598a6d20d 100644
--- a/iothread.c
+++ b/iothread.c
@@ -239,12 +239,9 @@ static void iothread_set_poll_param(Object *obj, Visit=
or *v,
     IOThread *iothread =3D IOTHREAD(obj);
     PollParamInfo *info =3D opaque;
     int64_t *field =3D (void *)iothread + info->offset;
-    Error *local_err =3D NULL;
     int64_t value;
=20
-    visit_type_int64(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_int64(v, name, &value, errp)) {
         return;
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
index b18b096a6e..398b7546ff 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -1093,12 +1093,9 @@ static void compare_set_timeout(Object *obj, Visitor=
 *v,
                                 Error **errp)
 {
     CompareState *s =3D COLO_COMPARE(obj);
-    Error *local_err =3D NULL;
     uint32_t value;
=20
-    visit_type_uint32(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_uint32(v, name, &value, errp)) {
         return;
     }
     if (!value) {
@@ -1124,12 +1121,9 @@ static void compare_set_expired_scan_cycle(Object *o=
bj, Visitor *v,
                                            Error **errp)
 {
     CompareState *s =3D COLO_COMPARE(obj);
-    Error *local_err =3D NULL;
     uint32_t value;
=20
-    visit_type_uint32(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_uint32(v, name, &value, errp)) {
         return;
     }
     if (!value) {
diff --git a/net/dump.c b/net/dump.c
index e8c4071d59..11a737a4bc 100644
--- a/net/dump.c
+++ b/net/dump.c
@@ -192,12 +192,9 @@ static void filter_dump_set_maxlen(Object *obj, Visito=
r *v, const char *name,
                                    void *opaque, Error **errp)
 {
     NetFilterDumpState *nfds =3D FILTER_DUMP(obj);
-    Error *local_err =3D NULL;
     uint32_t value;
=20
-    visit_type_uint32(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_uint32(v, name, &value, errp)) {
         return;
     }
     if (value =3D=3D 0) {
diff --git a/net/filter-buffer.c b/net/filter-buffer.c
index c3892911b8..dfa211794b 100644
--- a/net/filter-buffer.c
+++ b/net/filter-buffer.c
@@ -170,12 +170,9 @@ static void filter_buffer_set_interval(Object *obj, Vi=
sitor *v,
                                        Error **errp)
 {
     FilterBufferState *s =3D FILTER_BUFFER(obj);
-    Error *local_err =3D NULL;
     uint32_t value;
=20
-    visit_type_uint32(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_uint32(v, name, &value, errp)) {
         return;
     }
     if (!value) {
diff --git a/qom/object.c b/qom/object.c
index 6ece96bc2b..780a700542 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2078,11 +2078,8 @@ static void property_set_str(Object *obj, Visitor *v=
, const char *name,
 {
     StringProperty *prop =3D opaque;
     char *value;
-    Error *local_err =3D NULL;
=20
-    visit_type_str(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_str(v, name, &value, errp)) {
         return;
     }
=20
@@ -2159,11 +2156,8 @@ static void property_set_bool(Object *obj, Visitor *=
v, const char *name,
 {
     BoolProperty *prop =3D opaque;
     bool value;
-    Error *local_err =3D NULL;
=20
-    visit_type_bool(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_bool(v, name, &value, errp)) {
         return;
     }
=20
@@ -2232,11 +2226,8 @@ static void property_set_enum(Object *obj, Visitor *=
v, const char *name,
 {
     EnumProperty *prop =3D opaque;
     int value;
-    Error *err =3D NULL;
=20
-    visit_type_enum(v, name, &value, prop->lookup, &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!visit_type_enum(v, name, &value, prop->lookup, errp)) {
         return;
     }
     prop->set(obj, value, errp);
@@ -2305,32 +2296,25 @@ static void property_get_tm(Object *obj, Visitor *v=
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
@@ -2392,11 +2376,8 @@ static void property_set_uint8_ptr(Object *obj, Visi=
tor *v, const char *name,
 {
     uint8_t *field =3D opaque;
     uint8_t value;
-    Error *local_err =3D NULL;
=20
-    visit_type_uint8(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_uint8(v, name, &value, errp)) {
         return;
     }
=20
@@ -2415,11 +2396,8 @@ static void property_set_uint16_ptr(Object *obj, Vis=
itor *v, const char *name,
 {
     uint16_t *field =3D opaque;
     uint16_t value;
-    Error *local_err =3D NULL;
=20
-    visit_type_uint16(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_uint16(v, name, &value, errp)) {
         return;
     }
=20
@@ -2438,11 +2416,8 @@ static void property_set_uint32_ptr(Object *obj, Vis=
itor *v, const char *name,
 {
     uint32_t *field =3D opaque;
     uint32_t value;
-    Error *local_err =3D NULL;
=20
-    visit_type_uint32(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_uint32(v, name, &value, errp)) {
         return;
     }
=20
@@ -2461,11 +2436,8 @@ static void property_set_uint64_ptr(Object *obj, Vis=
itor *v, const char *name,
 {
     uint64_t *field =3D opaque;
     uint64_t value;
-    Error *local_err =3D NULL;
=20
-    visit_type_uint64(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_uint64(v, name, &value, errp)) {
         return;
     }
=20
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
index 778cecc2e6..fcb3eedabb 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -464,12 +464,9 @@ static void cpu_max_set_sve_max_vq(Object *obj, Visito=
r *v, const char *name,
                                    void *opaque, Error **errp)
 {
     ARMCPU *cpu =3D ARM_CPU(obj);
-    Error *err =3D NULL;
     uint32_t max_vq;
=20
-    visit_type_uint32(v, name, &max_vq, &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!visit_type_uint32(v, name, &max_vq, errp)) {
         return;
     }
=20
@@ -510,12 +507,9 @@ static void cpu_arm_set_sve_vq(Object *obj, Visitor *v=
, const char *name,
 {
     ARMCPU *cpu =3D ARM_CPU(obj);
     uint32_t vq =3D atoi(&name[3]) / 128;
-    Error *err =3D NULL;
     bool value;
=20
-    visit_type_bool(v, name, &value, &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!visit_type_bool(v, name, &value, errp)) {
         return;
     }
=20
@@ -546,13 +540,10 @@ static void cpu_arm_set_sve(Object *obj, Visitor *v, =
const char *name,
                             void *opaque, Error **errp)
 {
     ARMCPU *cpu =3D ARM_CPU(obj);
-    Error *err =3D NULL;
     bool value;
     uint64_t t;
=20
-    visit_type_bool(v, name, &value, &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!visit_type_bool(v, name, &value, errp)) {
         return;
     }
=20
diff --git a/target/arm/monitor.c b/target/arm/monitor.c
index ea6598c412..fdab052acd 100644
--- a/target/arm/monitor.c
+++ b/target/arm/monitor.c
@@ -174,11 +174,9 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(C=
puModelExpansionType type,
         Error *err =3D NULL;
=20
         visitor =3D qobject_input_visitor_new(model->props);
-        visit_start_struct(visitor, NULL, NULL, 0, &err);
-        if (err) {
+        if (!visit_start_struct(visitor, NULL, NULL, 0, errp)) {
             visit_free(visitor);
             object_unref(obj);
-            error_propagate(errp, err);
             return NULL;
         }
=20
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b1b311baa2..ef5cf587b6 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4408,12 +4408,9 @@ static void x86_cpuid_version_set_family(Object *obj=
, Visitor *v,
     CPUX86State *env =3D &cpu->env;
     const int64_t min =3D 0;
     const int64_t max =3D 0xff + 0xf;
-    Error *local_err =3D NULL;
     int64_t value;
=20
-    visit_type_int(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_int(v, name, &value, errp)) {
         return;
     }
     if (value < min || value > max) {
@@ -4451,12 +4448,9 @@ static void x86_cpuid_version_set_model(Object *obj,=
 Visitor *v,
     CPUX86State *env =3D &cpu->env;
     const int64_t min =3D 0;
     const int64_t max =3D 0xff;
-    Error *local_err =3D NULL;
     int64_t value;
=20
-    visit_type_int(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_int(v, name, &value, errp)) {
         return;
     }
     if (value < min || value > max) {
@@ -4489,12 +4483,9 @@ static void x86_cpuid_version_set_stepping(Object *o=
bj, Visitor *v,
     CPUX86State *env =3D &cpu->env;
     const int64_t min =3D 0;
     const int64_t max =3D 0xf;
-    Error *local_err =3D NULL;
     int64_t value;
=20
-    visit_type_int(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_int(v, name, &value, errp)) {
         return;
     }
     if (value < min || value > max) {
@@ -4594,12 +4585,9 @@ static void x86_cpuid_set_tsc_freq(Object *obj, Visi=
tor *v, const char *name,
     X86CPU *cpu =3D X86_CPU(obj);
     const int64_t min =3D 0;
     const int64_t max =3D INT64_MAX;
-    Error *local_err =3D NULL;
     int64_t value;
=20
-    visit_type_int(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_int(v, name, &value, errp)) {
         return;
     }
     if (value < min || value > max) {
@@ -6799,7 +6787,6 @@ static void x86_cpu_set_bit_prop(Object *obj, Visitor=
 *v, const char *name,
     DeviceState *dev =3D DEVICE(obj);
     X86CPU *cpu =3D X86_CPU(obj);
     BitProperty *fp =3D opaque;
-    Error *local_err =3D NULL;
     bool value;
=20
     if (dev->realized) {
@@ -6807,9 +6794,7 @@ static void x86_cpu_set_bit_prop(Object *obj, Visitor=
 *v, const char *name,
         return;
     }
=20
-    visit_type_bool(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_bool(v, name, &value, errp)) {
         return;
     }
=20
diff --git a/target/ppc/compat.c b/target/ppc/compat.c
index fda0dfe8f8..08aede88dc 100644
--- a/target/ppc/compat.c
+++ b/target/ppc/compat.c
@@ -260,13 +260,10 @@ static void ppc_compat_prop_get(Object *obj, Visitor =
*v, const char *name,
 static void ppc_compat_prop_set(Object *obj, Visitor *v, const char *name,
                                 void *opaque, Error **errp)
 {
-    Error *local_err =3D NULL;
     char *value;
     uint32_t compat_pvr;
=20
-    visit_type_str(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!visit_type_str(v, name, &value, errp)) {
         return;
     }
=20
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 2fa609bffe..aadd92247f 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -510,9 +510,7 @@ static void cpu_model_from_info(S390CPUModel *model, co=
nst CpuModelInfo *info,
=20
     if (qdict) {
         visitor =3D qobject_input_visitor_new(info->props);
-        visit_start_struct(visitor, NULL, NULL, 0, &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!visit_start_struct(visitor, NULL, NULL, 0, errp)) {
             visit_free(visitor);
             object_unref(obj);
             return;
@@ -1001,7 +999,6 @@ static void get_feature(Object *obj, Visitor *v, const=
 char *name,
 static void set_feature(Object *obj, Visitor *v, const char *name,
                         void *opaque, Error **errp)
 {
-    Error *err =3D NULL;
     S390Feat feat =3D (S390Feat) opaque;
     DeviceState *dev =3D DEVICE(obj);
     S390CPU *cpu =3D S390_CPU(obj);
@@ -1017,9 +1014,7 @@ static void set_feature(Object *obj, Visitor *v, cons=
t char *name,
         return;
     }
=20
-    visit_type_bool(v, name, &value, &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!visit_type_bool(v, name, &value, errp)) {
         return;
     }
     if (value) {
@@ -1059,7 +1054,6 @@ static void get_feature_group(Object *obj, Visitor *v=
, const char *name,
 static void set_feature_group(Object *obj, Visitor *v, const char *name,
                               void *opaque, Error **errp)
 {
-    Error *err =3D NULL;
     S390FeatGroup group =3D (S390FeatGroup) opaque;
     const S390FeatGroupDef *def =3D s390_feat_group_def(group);
     DeviceState *dev =3D DEVICE(obj);
@@ -1076,9 +1070,7 @@ static void set_feature_group(Object *obj, Visitor *v=
, const char *name,
         return;
     }
=20
-    visit_type_bool(v, name, &value, &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!visit_type_bool(v, name, &value, errp)) {
         return;
     }
     if (value) {
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 3f05aba9d6..cf21efd85f 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -801,12 +801,9 @@ static void sparc_set_nwindows(Object *obj, Visitor *v=
, const char *name,
     const int64_t min =3D MIN_NWINDOWS;
     const int64_t max =3D MAX_NWINDOWS;
     SPARCCPU *cpu =3D SPARC_CPU(obj);
-    Error *err =3D NULL;
     int64_t value;
=20
-    visit_type_int(v, name, &value, &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!visit_type_int(v, name, &value, errp)) {
         return;
     }
=20
--=20
2.26.2


