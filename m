Received: from eggs.gnu.org ([2001:4830:134:3::10]:59757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fUpiA-0005ZV-PZ
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 04:40:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fUpi8-0000K5-QI
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 04:40:30 -0400
Received: from mail-db5eur01on0097.outbound.protection.outlook.com
	([104.47.2.97]:43712
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1fUpi8-0000FC-Eg
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 04:40:28 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Mon, 18 Jun 2018 11:40:06 +0300
Message-Id: <1529311206-76847-3-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1529311206-76847-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1529311206-76847-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 2/2] qapi: remove empty flat union branches
 and types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, mdroth@linux.vnet.ibm.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

Flat unions may now have uncovered branches, so it is possible to get rid
of empty types defined for that purpose only.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/block-core.json | 52 +++-------------------------------------------------
 qapi/crypto.json     | 13 +------------
 qapi/misc.json       | 46 ++--------------------------------------------
 qapi/net.json        | 12 ------------
 qapi/ui.json         | 19 +------------------
 block/qcow2.c        |  1 -
 cpus.c               |  2 --
 7 files changed, 7 insertions(+), 138 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index ab629d1..23c88f5 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -52,8 +52,7 @@
 { 'union': 'ImageInfoSpecificQCow2Encryption',
   'base': 'ImageInfoSpecificQCow2EncryptionBase',
   'discriminator': 'format',
-  'data': { 'aes': 'QCryptoBlockInfoQCow',
-            'luks': 'QCryptoBlockInfoLUKS' } }
+  'data': { 'luks': 'QCryptoBlockInfoLUKS' } }
 
 ##
 # @ImageInfoSpecificQCow2:
@@ -2853,16 +2852,6 @@
             'hash': 'str' }}
 
 ##
-# @SshHostKeyDummy:
-#
-# For those union branches that don't need additional fields.
-#
-# Since: 2.12
-##
-{ 'struct': 'SshHostKeyDummy',
-  'data': {} }
-
-##
 # @SshHostKeyCheck:
 #
 # Since: 2.12
@@ -2870,9 +2859,7 @@
 { 'union': 'SshHostKeyCheck',
   'base': { 'mode': 'SshHostKeyCheckMode' },
   'discriminator': 'mode',
-  'data': { 'none': 'SshHostKeyDummy',
-            'hash': 'SshHostKeyHash',
-            'known_hosts': 'SshHostKeyDummy' } }
+  'data': { 'hash': 'SshHostKeyHash' } }
 
 ##
 # @BlockdevOptionsSsh:
@@ -4051,15 +4038,6 @@
             '*force-size':          'bool' } }
 
 ##
-# @BlockdevCreateNotSupported:
-#
-# This is used for all drivers that don't support creating images.
-#
-# Since: 2.12
-##
-{ 'struct': 'BlockdevCreateNotSupported', 'data': {}}
-
-##
 # @BlockdevCreateOptions:
 #
 # Options for creating an image format on a given node.
@@ -4073,44 +4051,20 @@
       'driver':         'BlockdevDriver' },
   'discriminator': 'driver',
   'data': {
-      'blkdebug':       'BlockdevCreateNotSupported',
-      'blkverify':      'BlockdevCreateNotSupported',
-      'bochs':          'BlockdevCreateNotSupported',
-      'cloop':          'BlockdevCreateNotSupported',
-      'copy-on-read':   'BlockdevCreateNotSupported',
-      'dmg':            'BlockdevCreateNotSupported',
       'file':           'BlockdevCreateOptionsFile',
-      'ftp':            'BlockdevCreateNotSupported',
-      'ftps':           'BlockdevCreateNotSupported',
       'gluster':        'BlockdevCreateOptionsGluster',
-      'host_cdrom':     'BlockdevCreateNotSupported',
-      'host_device':    'BlockdevCreateNotSupported',
-      'http':           'BlockdevCreateNotSupported',
-      'https':          'BlockdevCreateNotSupported',
-      'iscsi':          'BlockdevCreateNotSupported',
       'luks':           'BlockdevCreateOptionsLUKS',
-      'nbd':            'BlockdevCreateNotSupported',
       'nfs':            'BlockdevCreateOptionsNfs',
-      'null-aio':       'BlockdevCreateNotSupported',
-      'null-co':        'BlockdevCreateNotSupported',
-      'nvme':           'BlockdevCreateNotSupported',
       'parallels':      'BlockdevCreateOptionsParallels',
       'qcow':           'BlockdevCreateOptionsQcow',
       'qcow2':          'BlockdevCreateOptionsQcow2',
       'qed':            'BlockdevCreateOptionsQed',
-      'quorum':         'BlockdevCreateNotSupported',
-      'raw':            'BlockdevCreateNotSupported',
       'rbd':            'BlockdevCreateOptionsRbd',
-      'replication':    'BlockdevCreateNotSupported',
       'sheepdog':       'BlockdevCreateOptionsSheepdog',
       'ssh':            'BlockdevCreateOptionsSsh',
-      'throttle':       'BlockdevCreateNotSupported',
       'vdi':            'BlockdevCreateOptionsVdi',
       'vhdx':           'BlockdevCreateOptionsVhdx',
-      'vmdk':           'BlockdevCreateNotSupported',
-      'vpc':            'BlockdevCreateOptionsVpc',
-      'vvfat':          'BlockdevCreateNotSupported',
-      'vxhs':           'BlockdevCreateNotSupported'
+      'vpc':            'BlockdevCreateOptionsVpc'
   } }
 
 ##
diff --git a/qapi/crypto.json b/qapi/crypto.json
index 288bc05..a51b434 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -297,16 +297,6 @@
            'uuid': 'str',
            'slots': [ 'QCryptoBlockInfoLUKSSlot' ] }}
 
-##
-# @QCryptoBlockInfoQCow:
-#
-# Information about the QCow block encryption options
-#
-# Since: 2.7
-##
-{ 'struct': 'QCryptoBlockInfoQCow',
-  'data': { }}
-
 
 ##
 # @QCryptoBlockInfo:
@@ -318,5 +308,4 @@
 { 'union': 'QCryptoBlockInfo',
   'base': 'QCryptoBlockInfoBase',
   'discriminator': 'format',
-  'data': { 'qcow': 'QCryptoBlockInfoQCow',
-            'luks': 'QCryptoBlockInfoLUKS' } }
+  'data': { 'luks': 'QCryptoBlockInfoLUKS' } }
diff --git a/qapi/misc.json b/qapi/misc.json
index f83a63a..39f4dc1 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -395,8 +395,7 @@
             'mips': 'CpuInfoMIPS',
             'tricore': 'CpuInfoTricore',
             's390': 'CpuInfoS390',
-            'riscv': 'CpuInfoRISCV',
-            'other': 'CpuInfoOther' } }
+            'riscv': 'CpuInfoRISCV' } }
 
 ##
 # @CpuInfoX86:
@@ -467,16 +466,6 @@
 { 'struct': 'CpuInfoRISCV', 'data': { 'pc': 'int' } }
 
 ##
-# @CpuInfoOther:
-#
-# No additional information is available about the virtual CPU
-#
-# Since: 2.6
-#
-##
-{ 'struct': 'CpuInfoOther', 'data': { } }
-
-##
 # @CpuS390State:
 #
 # An enumeration of cpu states that can be assumed by a virtual
@@ -577,38 +566,7 @@
                       'arch'         : 'CpuInfoArch',
                       'target'       : 'SysEmuTarget' },
   'discriminator' : 'target',
-  'data'          : { 'aarch64'      : 'CpuInfoOther',
-                      'alpha'        : 'CpuInfoOther',
-                      'arm'          : 'CpuInfoOther',
-                      'cris'         : 'CpuInfoOther',
-                      'hppa'         : 'CpuInfoOther',
-                      'i386'         : 'CpuInfoOther',
-                      'lm32'         : 'CpuInfoOther',
-                      'm68k'         : 'CpuInfoOther',
-                      'microblaze'   : 'CpuInfoOther',
-                      'microblazeel' : 'CpuInfoOther',
-                      'mips'         : 'CpuInfoOther',
-                      'mips64'       : 'CpuInfoOther',
-                      'mips64el'     : 'CpuInfoOther',
-                      'mipsel'       : 'CpuInfoOther',
-                      'moxie'        : 'CpuInfoOther',
-                      'nios2'        : 'CpuInfoOther',
-                      'or1k'         : 'CpuInfoOther',
-                      'ppc'          : 'CpuInfoOther',
-                      'ppc64'        : 'CpuInfoOther',
-                      'ppcemb'       : 'CpuInfoOther',
-                      'riscv32'      : 'CpuInfoOther',
-                      'riscv64'      : 'CpuInfoOther',
-                      's390x'        : 'CpuInfoS390',
-                      'sh4'          : 'CpuInfoOther',
-                      'sh4eb'        : 'CpuInfoOther',
-                      'sparc'        : 'CpuInfoOther',
-                      'sparc64'      : 'CpuInfoOther',
-                      'tricore'      : 'CpuInfoOther',
-                      'unicore32'    : 'CpuInfoOther',
-                      'x86_64'       : 'CpuInfoOther',
-                      'xtensa'       : 'CpuInfoOther',
-                      'xtensaeb'     : 'CpuInfoOther' } }
+  'data'          : { 's390x'        : 'CpuInfoS390' } }
 
 ##
 # @query-cpus-fast:
diff --git a/qapi/net.json b/qapi/net.json
index 6b7d93c..c86f351 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -89,16 +89,6 @@
 { 'command': 'netdev_del', 'data': {'id': 'str'} }
 
 ##
-# @NetdevNoneOptions:
-#
-# Use it alone to have zero network devices.
-#
-# Since: 1.2
-##
-{ 'struct': 'NetdevNoneOptions',
-  'data': { } }
-
-##
 # @NetLegacyNicOptions:
 #
 # Create a new Network Interface Card.
@@ -477,7 +467,6 @@
   'base': { 'id': 'str', 'type': 'NetClientDriver' },
   'discriminator': 'type',
   'data': {
-    'none':     'NetdevNoneOptions',
     'nic':      'NetLegacyNicOptions',
     'user':     'NetdevUserOptions',
     'tap':      'NetdevTapOptions',
@@ -530,7 +519,6 @@
   'base': { 'type': 'NetLegacyOptionsType' },
   'discriminator': 'type',
   'data': {
-    'none':     'NetdevNoneOptions',
     'nic':      'NetLegacyNicOptions',
     'user':     'NetdevUserOptions',
     'tap':      'NetdevTapOptions',
diff --git a/qapi/ui.json b/qapi/ui.json
index fc18a05..f48d2a0 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -996,17 +996,6 @@
 
 
 ##
-# @DisplayNoOpts:
-#
-# Empty struct for displays without config options.
-#
-# Since: 2.12
-#
-##
-{ 'struct'  : 'DisplayNoOpts',
-  'data'    : { } }
-
-##
 # @DisplayGTK:
 #
 # GTK display options.
@@ -1068,10 +1057,4 @@
                 '*window-close'  : 'bool',
                 '*gl'            : 'DisplayGLMode' },
   'discriminator' : 'type',
-  'data'    : { 'default'        : 'DisplayNoOpts',
-                'none'           : 'DisplayNoOpts',
-                'gtk'            : 'DisplayGTK',
-                'sdl'            : 'DisplayNoOpts',
-                'egl-headless'   : 'DisplayNoOpts',
-                'curses'         : 'DisplayNoOpts',
-                'cocoa'          : 'DisplayNoOpts' } }
+  'data'    : { 'gtk'            : 'DisplayGTK' } }
diff --git a/block/qcow2.c b/block/qcow2.c
index 945132f..a3a3aa2 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4166,7 +4166,6 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs)
         switch (encrypt_info->format) {
         case Q_CRYPTO_BLOCK_FORMAT_QCOW:
             qencrypt->format = BLOCKDEV_QCOW2_ENCRYPTION_FORMAT_AES;
-            qencrypt->u.aes = encrypt_info->u.qcow;
             break;
         case Q_CRYPTO_BLOCK_FORMAT_LUKS:
             qencrypt->format = BLOCKDEV_QCOW2_ENCRYPTION_FORMAT_LUKS;
diff --git a/cpus.c b/cpus.c
index d1f1629..19c5d37 100644
--- a/cpus.c
+++ b/cpus.c
@@ -2273,8 +2273,6 @@ CpuInfoFastList *qmp_query_cpus_fast(Error **errp)
         info->value->target = target;
         if (target == SYS_EMU_TARGET_S390X) {
             cpustate_to_cpuinfo_s390(&info->value->u.s390x, cpu);
-        } else {
-            /* do nothing for @CpuInfoOther */
         }
 
         if (!cur_item) {
-- 
2.7.4
