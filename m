Received: from eggs.gnu.org ([2001:4830:134:3::10]:51909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dAIP0-0005G6-8L
	for qemu-devel@nongnu.org; Mon, 15 May 2017 11:59:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dAIOx-0006WW-7V
	for qemu-devel@nongnu.org; Mon, 15 May 2017 11:59:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dAIOw-0006Vj-UQ
	for qemu-devel@nongnu.org; Mon, 15 May 2017 11:59:15 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A9A9E48DEC
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 15:59:13 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <22efcebe-e6fb-d053-7216-10ccd63f7287@redhat.com> (Eric Blake's
	message of "Mon, 15 May 2017 09:28:40 -0500")
References: <20170511163228.6666-1-quintela@redhat.com>
	<20170511163228.6666-3-quintela@redhat.com>
	<20170512034033.GN28293@pxdev.xzpeter.org>
	<877f1mgx9h.fsf@secure.mitica>
	<5bab598f-30eb-fcf6-9d06-8f683b466414@redhat.com>
	<87lgpyfo28.fsf@secure.mitica>
	<22efcebe-e6fb-d053-7216-10ccd63f7287@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 15 May 2017 17:59:02 +0200
Message-ID: <87mvaedsc9.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/3] migration: Remove use of old
 MigrationParams
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, lvivier@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, Markus Armbruster <armbru@redhat.com>

Eric Blake <eblake@redhat.com> wrote:
> [adding Markus]
>
> On 05/15/2017 04:48 AM, Juan Quintela wrote:
>> Eric Blake <eblake@redhat.com> wrote:
>>> On 05/12/2017 05:55 AM, Juan Quintela wrote:
>>>>>> @@ -1239,6 +1240,7 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
>>>>>>      }
>>>>>>  
>>>>>>      if (has_inc && inc) {
>>>>>> +        migrate_set_block_enabled(s, true);
>>>>>>          migrate_set_block_shared(s, true);
>>>>>
>>>>> [2]
>>>>>
>>>>> IIUC for [1] & [2] we are solving the same problem that "shared"
>>>>> depends on "enabled" bit. Would it be good to unitfy this dependency
>>>>> somewhere? E.g., by changing migrate_set_block_shared() into:
>>>>>
>>>>> void migrate_set_block_shared(MigrationState *s, bool value)
>>>>> {
>>>>>     s->enabled_capabilities[MIGRATION_CAPABILITY_BLOCK_SHARED] = value;
>>>>>     if (value) {
>>>>>         migrate_set_block_enabled(s, true);
>>>>>     }
>>>>> }
>>>>
>>>> ok with this.
>>>
>>> Or, as I commented on 1/3, maybe having a single property that is a
>>> tri-state enum value, instead of 2 separate boolean properties, might be
>>> nicer (but certainly a bit more complex to code up).
>> 
>> If you teach me how to do the qapi/qmp part, I will do the other bits.
>> I don't really care if we do it one way or the other.
>
> Adding Markus in, as I value his opinion on matters of UI design.


This is my "working" version of Dave patch on top of my block layer
changes.  Still using the two capabilities.

I am open to suggestions


commit 242852b71ec2b8f08754afa6eafce6fa3fe69139
Author: Dr. David Alan Gilbert <dgilbert@redhat.com>
Date:   Mon May 15 15:05:29 2017 +0100

    block migration: Allow compile time disable
    
    Many users now prefer to use drive_mirror over NBD as an
    alternative to the older migrate -b option; drive_mirror is
    more complex to setup but gives you more options (e.g. only
    migrating some of the disks if some of them are shared).
    
    Allow the large chunk of block migration code to be compiled
    out for those who don't use it.
    
    Based on a downstream-patch we've had for a while by Jeff Cody.
    
    Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

diff --git a/configure b/configure
index 7c020c0..7aba6c5 100755
--- a/configure
+++ b/configure
@@ -316,6 +316,7 @@ vte=""
 virglrenderer=""
 tpm="yes"
 libssh2=""
+live_block_migration="yes"
 numa=""
 tcmalloc="no"
 jemalloc="no"
@@ -1168,6 +1169,10 @@ for opt do
   ;;
   --enable-libssh2) libssh2="yes"
   ;;
+  --disable-live-block-migration) live_block_migration="no"
+  ;;
+  --enable-live-block-migration) live_block_migration="yes"
+  ;;
   --disable-numa) numa="no"
   ;;
   --enable-numa) numa="yes"
@@ -1400,6 +1405,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   libnfs          nfs support
   smartcard       smartcard support (libcacard)
   libusb          libusb (for usb passthrough)
+  live-block-migration   Block migration in the main migration stream
   usb-redir       usb network redirection support
   lzo             support of lzo compression library
   snappy          support of snappy compression library
@@ -5224,6 +5230,7 @@ echo "TPM support       $tpm"
 echo "libssh2 support   $libssh2"
 echo "TPM passthrough   $tpm_passthrough"
 echo "QOM debugging     $qom_cast_debug"
+echo "Live block migration $live_block_migration"
 echo "lzo support       $lzo"
 echo "snappy support    $snappy"
 echo "bzip2 support     $bzip2"
@@ -5790,6 +5797,10 @@ if test "$libssh2" = "yes" ; then
   echo "LIBSSH2_LIBS=$libssh2_libs" >> $config_host_mak
 fi
 
+if test "$live_block_migration" = "yes" ; then
+  echo "CONFIG_LIVE_BLOCK_MIGRATION=y" >> $config_host_mak
+fi
+
 # USB host support
 if test "$libusb" = "yes"; then
   echo "HOST_USB=libusb legacy" >> $config_host_mak
diff --git a/include/migration/misc.h b/include/migration/misc.h
index 5c62e92..99b5795 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -22,7 +22,12 @@ void ram_mig_init(void);
 
 /* migration/block.c */
 
+#ifdef CONFIG_LIVE_BLOCK_MIGRATION
 void blk_mig_init(void);
+#else
+static inline void blk_mig_init(void) { };
+#endif
+
 
 #define SELF_ANNOUNCE_ROUNDS 5
 
diff --git a/migration/Makefile.objs b/migration/Makefile.objs
index 4277c88..1c7770d 100644
--- a/migration/Makefile.objs
+++ b/migration/Makefile.objs
@@ -9,5 +9,5 @@ common-obj-y += qjson.o
 
 common-obj-$(CONFIG_RDMA) += rdma.o
 
-common-obj-y += block.o
+common-obj-$(CONFIG_LIVE_BLOCK_MIGRATION) += block.o
 
diff --git a/migration/block.h b/migration/block.h
index a4d4974..1884fd0 100644
--- a/migration/block.h
+++ b/migration/block.h
@@ -14,12 +14,33 @@
 #ifndef MIGRATION_BLOCK_H
 #define MIGRATION_BLOCK_H
 
+#ifdef CONFIG_LIVE_BLOCK_MIGRATION
 int blk_mig_active(void);
 uint64_t blk_mig_bytes_transferred(void);
 uint64_t blk_mig_bytes_remaining(void);
 uint64_t blk_mig_bytes_total(void);
 
-void migrate_set_block_shared(MigrationState *s, bool value);
-void migrate_set_block_enabled(MigrationState *s, bool value);
+#else
+static inline int blk_mig_active(void)
+{
+    return false;
+}
+static inline uint64_t blk_mig_bytes_transferred(void)
+{
+    return 0;
+}
 
+static inline uint64_t blk_mig_bytes_remaining(void)
+{
+    return 0;
+}
+
+static inline uint64_t blk_mig_bytes_total(void)
+{
+    return 0;
+}
+#endif /* CONFIG_LIVE_BLOCK_MIGRATION */
+
+bool migrate_set_block_shared(MigrationState *s, bool value, Error **errp);
+bool migrate_set_block_enabled(MigrationState *s, bool value, Error **errp);
 #endif /* MIGRATION_BLOCK_H */
diff --git a/migration/colo.c b/migration/colo.c
index 10ee97c..4c652ba 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -348,8 +348,8 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
     }
 
     /* Disable block migration */
-    migrate_set_block_enabled(s, false);
-    migrate_set_block_shared(s, false);
+    migrate_set_block_enabled(s, false, NULL);
+    migrate_set_block_shared(s, false, NULL);
     qemu_savevm_state_header(fb);
     qemu_savevm_state_begin(fb);
     qemu_mutex_lock_iothread();
diff --git a/migration/migration.c b/migration/migration.c
index fd0b11f..a525de5 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -595,11 +595,20 @@ void qmp_migrate_set_capabilities(MigrationCapabilityStatusList *params,
         }
         s->enabled_capabilities[cap->value->capability] = cap->value->state;
     }
-
+#ifdef CONFIG_LIVE_BLOCK_MIGRATION
     if (s->enabled_capabilities[MIGRATION_CAPABILITY_BLOCK_SHARED]) {
         s->enabled_capabilities[MIGRATION_CAPABILITY_BLOCK_ENABLED] = true;
     }
-
+#else
+    if ((s->enabled_capabilities[MIGRATION_CAPABILITY_BLOCK_SHARED])
+        ||(s->enabled_capabilities[MIGRATION_CAPABILITY_BLOCK_SHARED])) {
+        error_setg(errp, "QEMU compiled without old-style (blk/-b, inc/-i) "
+                         "block migration");
+        error_append_hint(errp, "Use drive_mirror+NBD instead.\n");
+        s->enabled_capabilities[MIGRATION_CAPABILITY_BLOCK_ENABLED] = false;
+        s->enabled_capabilities[MIGRATION_CAPABILITY_BLOCK_SHARED] = false;
+    }
+#endif
     if (migrate_postcopy_ram()) {
         if (migrate_use_compression()) {
             /* The decompression threads asynchronously write into RAM
@@ -1004,20 +1013,38 @@ bool migration_is_blocked(Error **errp)
     return false;
 }
 
-void migrate_set_block_shared(MigrationState *s, bool value)
+bool migrate_set_block_shared(MigrationState *s, bool value, Error **errp)
 {
+#ifndef CONFIG_LIVE_BLOCK_MIGRATION
+    if (value) {
+        error_setg(errp, "QEMU compiled without old-style (blk/-b, inc/-i) "
+                         "block migration");
+        error_append_hint(errp, "Use drive_mirror+NBD instead.\n");
+        return false;
+    }
+#endif
     s->enabled_capabilities[MIGRATION_CAPABILITY_BLOCK_SHARED] = value;
     if (value) {
         s->enabled_capabilities[MIGRATION_CAPABILITY_BLOCK_ENABLED] = true;
     }
+    return true;
 }
 
-void migrate_set_block_enabled(MigrationState *s, bool value)
+bool migrate_set_block_enabled(MigrationState *s, bool value, Error **errp)
 {
+#ifndef CONFIG_LIVE_BLOCK_MIGRATION
+    if (value) {
+        error_setg(errp, "QEMU compiled without old-style (blk/-b, inc/-i) "
+                         "block migration");
+        error_append_hint(errp, "Use drive_mirror+NBD instead.\n");
+        return false;
+    }
+#endif
     s->enabled_capabilities[MIGRATION_CAPABILITY_BLOCK_ENABLED] = value;
     if (!value) {
         s->enabled_capabilities[MIGRATION_CAPABILITY_BLOCK_SHARED] = false;
     }
+    return true;
 }
 
 void qmp_migrate(const char *uri, bool has_blk, bool blk,
@@ -1046,11 +1073,17 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
     s = migrate_init();
 
     if (has_blk && blk) {
-        migrate_set_block_enabled(s, true);
+        if(!migrate_set_block_enabled(s, true, &local_err)) {
+            error_propagate(errp, local_err);
+            return;
+        }
     }
 
     if (has_inc && inc) {
-        migrate_set_block_shared(s, true);
+        if(!migrate_set_block_shared(s, true, &local_err)) {
+            error_propagate(errp, local_err);
+            return;
+        }
     }
 
     if (strstart(uri, "tcp:", &p)) {
