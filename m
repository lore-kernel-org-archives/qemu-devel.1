Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE48C4CEC6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 14:22:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 256F92081B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 14:22:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 256F92081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Pz4-0008PX-It
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 10:22:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40452)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i8PUZ-0006jV-H6
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:50:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i8PUX-0002uw-O0
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:50:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45048)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i8PUX-0002tg-EN
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:50:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 62C1018C4273;
 Thu, 12 Sep 2019 13:50:32 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EB8415D717;
 Thu, 12 Sep 2019 13:50:27 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, ivanren@tencent.com, peterx@redhat.com,
 richardw.yang@linux.intel.com, yury-kotov@yandex-team.ru,
 quintela@redhat.com
Date: Thu, 12 Sep 2019 14:49:58 +0100
Message-Id: <20190912135006.14820-5-dgilbert@redhat.com>
In-Reply-To: <20190912135006.14820-1-dgilbert@redhat.com>
References: <20190912135006.14820-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Thu, 12 Sep 2019 13:50:32 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 04/12] migration: register_savevm_live doesn't
 need dev
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Commit 78dd48df3 removed the last caller of register_savevm_live for an
instantiable device (rather than a single system wide device);
so trim out the parameter.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20190822115433.12070-1-dgilbert@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 docs/devel/migration.rst       |  3 +--
 hw/ppc/spapr.c                 |  2 +-
 hw/s390x/s390-skeys.c          |  2 +-
 hw/s390x/s390-stattrib.c       |  2 +-
 hw/s390x/tod.c                 |  2 +-
 include/migration/register.h   |  3 +--
 migration/block-dirty-bitmap.c |  2 +-
 migration/block.c              |  2 +-
 migration/ram.c                |  2 +-
 migration/savevm.c             | 23 +----------------------
 net/slirp.c                    |  2 +-
 11 files changed, 11 insertions(+), 34 deletions(-)

diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
index f7668ae389..e88918f763 100644
--- a/docs/devel/migration.rst
+++ b/docs/devel/migration.rst
@@ -183,8 +183,7 @@ another to load the state back.
=20
 .. code:: c
=20
-  int register_savevm_live(DeviceState *dev,
-                           const char *idstr,
+  int register_savevm_live(const char *idstr,
                            int instance_id,
                            int version_id,
                            SaveVMHandlers *ops,
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 222a325056..08a2a5a770 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3078,7 +3078,7 @@ static void spapr_machine_init(MachineState *machin=
e)
      * interface, this is a legacy from the sPAPREnvironment structure
      * which predated MachineState but had a similar function */
     vmstate_register(NULL, 0, &vmstate_spapr, spapr);
-    register_savevm_live(NULL, "spapr/htab", -1, 1,
+    register_savevm_live("spapr/htab", -1, 1,
                          &savevm_htab_handlers, spapr);
=20
     qbus_set_hotplug_handler(sysbus_get_default(), OBJECT(machine),
diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index d4807f7777..bd37f39120 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -389,7 +389,7 @@ static inline void s390_skeys_set_migration_enabled(O=
bject *obj, bool value,
     ss->migration_enabled =3D value;
=20
     if (ss->migration_enabled) {
-        register_savevm_live(NULL, TYPE_S390_SKEYS, 0, 1,
+        register_savevm_live(TYPE_S390_SKEYS, 0, 1,
                              &savevm_s390_storage_keys, ss);
     } else {
         unregister_savevm(DEVICE(ss), TYPE_S390_SKEYS, ss);
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index eda5ca3bb6..bf5ac014c4 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -381,7 +381,7 @@ static void s390_stattrib_instance_init(Object *obj)
 {
     S390StAttribState *sas =3D S390_STATTRIB(obj);
=20
-    register_savevm_live(NULL, TYPE_S390_STATTRIB, 0, 0,
+    register_savevm_live(TYPE_S390_STATTRIB, 0, 0,
                          &savevm_s390_stattrib_handlers, sas);
=20
     object_property_add_bool(obj, "migration-enabled",
diff --git a/hw/s390x/tod.c b/hw/s390x/tod.c
index 1bf0875afa..2499d6f656 100644
--- a/hw/s390x/tod.c
+++ b/hw/s390x/tod.c
@@ -101,7 +101,7 @@ static void s390_tod_realize(DeviceState *dev, Error =
**errp)
     S390TODState *td =3D S390_TOD(dev);
=20
     /* Legacy migration interface */
-    register_savevm_live(NULL, "todclock", 0, 1, &savevm_tod, td);
+    register_savevm_live("todclock", 0, 1, &savevm_tod, td);
 }
=20
 static void s390_tod_class_init(ObjectClass *oc, void *data)
diff --git a/include/migration/register.h b/include/migration/register.h
index 3d0b9833c6..a13359a08d 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -68,8 +68,7 @@ typedef struct SaveVMHandlers {
     int (*resume_prepare)(MigrationState *s, void *opaque);
 } SaveVMHandlers;
=20
-int register_savevm_live(DeviceState *dev,
-                         const char *idstr,
+int register_savevm_live(const char *idstr,
                          int instance_id,
                          int version_id,
                          const SaveVMHandlers *ops,
diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitma=
p.c
index dd40724b9e..5121f86d73 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -733,7 +733,7 @@ void dirty_bitmap_mig_init(void)
 {
     QSIMPLEQ_INIT(&dirty_bitmap_mig_state.dbms_list);
=20
-    register_savevm_live(NULL, "dirty-bitmap", 0, 1,
+    register_savevm_live("dirty-bitmap", 0, 1,
                          &savevm_dirty_bitmap_handlers,
                          &dirty_bitmap_mig_state);
 }
diff --git a/migration/block.c b/migration/block.c
index aa747b55fa..0de9d84198 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -1030,6 +1030,6 @@ void blk_mig_init(void)
     QSIMPLEQ_INIT(&block_mig_state.blk_list);
     qemu_mutex_init(&block_mig_state.lock);
=20
-    register_savevm_live(NULL, "block", 0, 1, &savevm_block_handlers,
+    register_savevm_live("block", 0, 1, &savevm_block_handlers,
                          &block_mig_state);
 }
diff --git a/migration/ram.c b/migration/ram.c
index 0047286b7e..01df326767 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4675,5 +4675,5 @@ static SaveVMHandlers savevm_ram_handlers =3D {
 void ram_mig_init(void)
 {
     qemu_mutex_init(&XBZRLE.lock);
-    register_savevm_live(NULL, "ram", 0, 4, &savevm_ram_handlers, &ram_s=
tate);
+    register_savevm_live("ram", 0, 4, &savevm_ram_handlers, &ram_state);
 }
diff --git a/migration/savevm.c b/migration/savevm.c
index 35426d1db8..3454bc937e 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -684,8 +684,7 @@ static void savevm_state_handler_insert(SaveStateEntr=
y *nse)
    of the system, so instance_id should be removed/replaced.
    Meanwhile pass -1 as instance_id if you do not already have a clearly
    distinguishing id for all instances of your device class. */
-int register_savevm_live(DeviceState *dev,
-                         const char *idstr,
+int register_savevm_live(const char *idstr,
                          int instance_id,
                          int version_id,
                          const SaveVMHandlers *ops,
@@ -704,26 +703,6 @@ int register_savevm_live(DeviceState *dev,
         se->is_ram =3D 1;
     }
=20
-    if (dev) {
-        char *id =3D qdev_get_dev_path(dev);
-        if (id) {
-            if (snprintf(se->idstr, sizeof(se->idstr), "%s/", id) >=3D
-                sizeof(se->idstr)) {
-                error_report("Path too long for VMState (%s)", id);
-                g_free(id);
-                g_free(se);
-
-                return -1;
-            }
-            g_free(id);
-
-            se->compat =3D g_new0(CompatEntry, 1);
-            pstrcpy(se->compat->idstr, sizeof(se->compat->idstr), idstr)=
;
-            se->compat->instance_id =3D instance_id =3D=3D -1 ?
-                         calculate_compat_instance_id(idstr) : instance_=
id;
-            instance_id =3D -1;
-        }
-    }
     pstrcat(se->idstr, sizeof(se->idstr), idstr);
=20
     if (instance_id =3D=3D -1) {
diff --git a/net/slirp.c b/net/slirp.c
index b34cb29276..f42f496641 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -576,7 +576,7 @@ static int net_slirp_init(NetClientState *peer, const=
 char *model,
      * specific version?
      */
     g_assert(slirp_state_version() =3D=3D 4);
-    register_savevm_live(NULL, "slirp", 0, slirp_state_version(),
+    register_savevm_live("slirp", 0, slirp_state_version(),
                          &savevm_slirp_state, s->slirp);
=20
     s->poll_notifier.notify =3D net_slirp_poll_notify;
--=20
2.21.0


