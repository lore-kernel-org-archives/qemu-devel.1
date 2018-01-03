Received: from eggs.gnu.org ([2001:4830:134:3::10]:34625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eWfVb-00072Q-Jk
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 04:38:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eWfVY-00070L-Fg
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 04:38:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eWfVY-0006zC-36
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 04:38:48 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 31DDA2DD783
	for <qemu-devel@nongnu.org>; Wed,  3 Jan 2018 09:38:47 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  3 Jan 2018 10:38:24 +0100
Message-Id: <20180103093834.20879-5-quintela@redhat.com>
In-Reply-To: <20180103093834.20879-1-quintela@redhat.com>
References: <20180103093834.20879-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 04/14] docs: Convert migration.txt to rst
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Mostly just manual conversion with very minor fixes.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Kashyap Chamarthy <kchamart@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 docs/devel/{migration.txt => migration.rst} | 470 +++++++++++++++-------------
 1 file changed, 247 insertions(+), 223 deletions(-)
 rename docs/devel/{migration.txt => migration.rst} (58%)

diff --git a/docs/devel/migration.txt b/docs/devel/migration.rst
similarity index 58%
rename from docs/devel/migration.txt
rename to docs/devel/migration.rst
index 4030703726..bf97080dac 100644
--- a/docs/devel/migration.txt
+++ b/docs/devel/migration.rst
@@ -1,4 +1,6 @@
-= Migration =
+=========
+Migration
+=========
 
 QEMU has code to load/save the state of the guest that it is running.
 These are two complementary operations.  Saving the state just does
@@ -26,7 +28,8 @@ the guest to be stopped.  Typically the time that the guest is
 unresponsive during live migration is the low hundred of milliseconds
 (notice that this depends on a lot of things).
 
-=== Types of migration ===
+Types of migration
+==================
 
 Now that we have talked about live migration, there are several ways
 to do migration:
@@ -41,49 +44,21 @@ All these four migration protocols use the same infrastructure to
 save/restore state devices.  This infrastructure is shared with the
 savevm/loadvm functionality.
 
-=== State Live Migration ===
+State Live Migration
+====================
 
 This is used for RAM and block devices.  It is not yet ported to vmstate.
 <Fill more information here>
 
-=== What is the common infrastructure ===
+Common infrastructure
+=====================
 
-QEMU uses a QEMUFile abstraction to be able to do migration.  Any type
-of migration that wants to use QEMU infrastructure has to create a
-QEMUFile with:
+The files, sockets or fd's that carry the migration stream are abstracted by
+the  ``QEMUFile`` type (see `migration/qemu-file.h`).  In most cases this
+is connected to a subtype of ``QIOChannel`` (see `io/`).
 
-QEMUFile *qemu_fopen_ops(void *opaque,
-                         QEMUFilePutBufferFunc *put_buffer,
-                         QEMUFileGetBufferFunc *get_buffer,
-                         QEMUFileCloseFunc *close);
-
-The functions have the following functionality:
-
-This function writes a chunk of data to a file at the given position.
-The pos argument can be ignored if the file is only used for
-streaming.  The handler should try to write all of the data it can.
-
-typedef int (QEMUFilePutBufferFunc)(void *opaque, const uint8_t *buf,
-                                    int64_t pos, int size);
-
-Read a chunk of data from a file at the given position.  The pos argument
-can be ignored if the file is only be used for streaming.  The number of
-bytes actually read should be returned.
-
-typedef int (QEMUFileGetBufferFunc)(void *opaque, uint8_t *buf,
-                                    int64_t pos, int size);
-
-Close a file and return an error code.
-
-typedef int (QEMUFileCloseFunc)(void *opaque);
-
-You can use any internal state that you need using the opaque void *
-pointer that is passed to all functions.
-
-The important functions for us are put_buffer()/get_buffer() that
-allow to write/read a buffer into the QEMUFile.
-
-=== How to save the state of one device ===
+Saving the state of one device
+==============================
 
 The state of a device is saved using intermediate buffers.  There are
 some helper functions to assist this saving.
@@ -93,34 +68,38 @@ version.  When we migrate a device, we save/load the state as a series
 of fields.  Some times, due to bugs or new functionality, we need to
 change the state to store more/different information.  We use the
 version to identify each time that we do a change.  Each version is
-associated with a series of fields saved.  The save_state always saves
-the state as the newer version.  But load_state sometimes is able to
+associated with a series of fields saved.  The `save_state` always saves
+the state as the newer version.  But `load_state` sometimes is able to
 load state from an older version.
 
-=== Legacy way ===
+Legacy way
+----------
 
 This way is going to disappear as soon as all current users are ported to VMSTATE.
 
 Each device has to register two functions, one to save the state and
 another to load the state back.
 
-int register_savevm(DeviceState *dev,
-                    const char *idstr,
-                    int instance_id,
-                    int version_id,
-                    SaveStateHandler *save_state,
-                    LoadStateHandler *load_state,
-                    void *opaque);
+.. code:: c
 
-typedef void SaveStateHandler(QEMUFile *f, void *opaque);
-typedef int LoadStateHandler(QEMUFile *f, void *opaque, int version_id);
+  int register_savevm(DeviceState *dev,
+                      const char *idstr,
+                      int instance_id,
+                      int version_id,
+                      SaveStateHandler *save_state,
+                      LoadStateHandler *load_state,
+                      void *opaque);
 
-The important functions for the device state format are the save_state
-and load_state.  Notice that load_state receives a version_id
-parameter to know what state format is receiving.  save_state doesn't
+  typedef void SaveStateHandler(QEMUFile *f, void *opaque);
+  typedef int LoadStateHandler(QEMUFile *f, void *opaque, int version_id);
+
+The important functions for the device state format are the `save_state`
+and `load_state`.  Notice that `load_state` receives a version_id
+parameter to know what state format is receiving.  `save_state` doesn't
 have a version_id parameter because it always uses the latest version.
 
-=== VMState ===
+VMState
+-------
 
 The legacy way of saving/loading state of the device had the problem
 that we have to maintain two functions in sync.  If we did one change
@@ -135,31 +114,36 @@ save/load functions.
 
 An example (from hw/input/pckbd.c)
 
-static const VMStateDescription vmstate_kbd = {
-    .name = "pckbd",
-    .version_id = 3,
-    .minimum_version_id = 3,
-    .fields = (VMStateField[]) {
-        VMSTATE_UINT8(write_cmd, KBDState),
-        VMSTATE_UINT8(status, KBDState),
-        VMSTATE_UINT8(mode, KBDState),
-        VMSTATE_UINT8(pending, KBDState),
-        VMSTATE_END_OF_LIST()
-    }
-};
+.. code:: c
+
+  static const VMStateDescription vmstate_kbd = {
+      .name = "pckbd",
+      .version_id = 3,
+      .minimum_version_id = 3,
+      .fields = (VMStateField[]) {
+          VMSTATE_UINT8(write_cmd, KBDState),
+          VMSTATE_UINT8(status, KBDState),
+          VMSTATE_UINT8(mode, KBDState),
+          VMSTATE_UINT8(pending, KBDState),
+          VMSTATE_END_OF_LIST()
+      }
+  };
 
 We are declaring the state with name "pckbd".
-The version_id is 3, and the fields are 4 uint8_t in a KBDState structure.
+The `version_id` is 3, and the fields are 4 uint8_t in a KBDState structure.
 We registered this with:
 
+.. code:: c
+
     vmstate_register(NULL, 0, &vmstate_kbd, s);
 
 Note: talk about how vmstate <-> qdev interact, and what the instance ids mean.
 
-You can search for VMSTATE_* macros for lots of types used in QEMU in
+You can search for ``VMSTATE_*`` macros for lots of types used in QEMU in
 include/hw/hw.h.
 
-=== More about versions ===
+More about versions
+-------------------
 
 Version numbers are intended for major incompatible changes to the
 migration of a device, and using them breaks backwards-migration
@@ -168,22 +152,23 @@ compatibility; in general most changes can be made by adding Subsections
 
 You can see that there are several version fields:
 
-- version_id: the maximum version_id supported by VMState for that device.
-- minimum_version_id: the minimum version_id that VMState is able to understand
+- `version_id`: the maximum version_id supported by VMState for that device.
+- `minimum_version_id`: the minimum version_id that VMState is able to understand
   for that device.
-- minimum_version_id_old: For devices that were not able to port to vmstate, we can
+- `minimum_version_id_old`: For devices that were not able to port to vmstate, we can
   assign a function that knows how to read this old state. This field is
-  ignored if there is no load_state_old handler.
+  ignored if there is no `load_state_old` handler.
 
 So, VMState is able to read versions from minimum_version_id to
-version_id.  And the function load_state_old() (if present) is able to
+version_id.  And the function ``load_state_old()`` (if present) is able to
 load state from minimum_version_id_old to minimum_version_id.  This
 function is deprecated and will be removed when no more users are left.
 
 Saving state will always create a section with the 'version_id' value
 and thus can't be loaded by any older QEMU.
 
-===  Massaging functions ===
+Massaging functions
+-------------------
 
 Sometimes, it is not enough to be able to save the state directly
 from one structure, we need to fill the correct values there.  One
@@ -194,24 +179,24 @@ load the state for the cpu that we have just loaded from the QEMUFile.
 
 The functions to do that are inside a vmstate definition, and are called:
 
-- int (*pre_load)(void *opaque);
+- ``int (*pre_load)(void *opaque);``
 
   This function is called before we load the state of one device.
 
-- int (*post_load)(void *opaque, int version_id);
+- ``int (*post_load)(void *opaque, int version_id);``
 
   This function is called after we load the state of one device.
 
-- int (*pre_save)(void *opaque);
+- ``int (*pre_save)(void *opaque);``
 
   This function is called before we save the state of one device.
 
 Example: You can look at hpet.c, that uses the three function to
-         massage the state that is transferred.
+massage the state that is transferred.
 
 If you use memory API functions that update memory layout outside
 initialization (i.e., in response to a guest action), this is a strong
-indication that you need to call these functions in a post_load callback.
+indication that you need to call these functions in a `post_load` callback.
 Examples of such memory API functions are:
 
   - memory_region_add_subregion()
@@ -221,7 +206,8 @@ Examples of such memory API functions are:
   - memory_region_set_address()
   - memory_region_set_alias_offset()
 
-=== Subsections ===
+Subsections
+-----------
 
 The use of version_id allows to be able to migrate from older versions
 to newer versions of a device.  But not the other way around.  This
@@ -251,52 +237,54 @@ value that it uses.
 
 Example:
 
-static bool ide_drive_pio_state_needed(void *opaque)
-{
-    IDEState *s = opaque;
+.. code:: c
 
-    return ((s->status & DRQ_STAT) != 0)
-        || (s->bus->error_status & BM_STATUS_PIO_RETRY);
-}
+  static bool ide_drive_pio_state_needed(void *opaque)
+  {
+      IDEState *s = opaque;
 
-const VMStateDescription vmstate_ide_drive_pio_state = {
-    .name = "ide_drive/pio_state",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .pre_save = ide_drive_pio_pre_save,
-    .post_load = ide_drive_pio_post_load,
-    .needed = ide_drive_pio_state_needed,
-    .fields = (VMStateField[]) {
-        VMSTATE_INT32(req_nb_sectors, IDEState),
-        VMSTATE_VARRAY_INT32(io_buffer, IDEState, io_buffer_total_len, 1,
-                             vmstate_info_uint8, uint8_t),
-        VMSTATE_INT32(cur_io_buffer_offset, IDEState),
-        VMSTATE_INT32(cur_io_buffer_len, IDEState),
-        VMSTATE_UINT8(end_transfer_fn_idx, IDEState),
-        VMSTATE_INT32(elementary_transfer_size, IDEState),
-        VMSTATE_INT32(packet_transfer_size, IDEState),
-        VMSTATE_END_OF_LIST()
-    }
-};
+      return ((s->status & DRQ_STAT) != 0)
+          || (s->bus->error_status & BM_STATUS_PIO_RETRY);
+  }
 
-const VMStateDescription vmstate_ide_drive = {
-    .name = "ide_drive",
-    .version_id = 3,
-    .minimum_version_id = 0,
-    .post_load = ide_drive_post_load,
-    .fields = (VMStateField[]) {
-        .... several fields ....
-        VMSTATE_END_OF_LIST()
-    },
-    .subsections = (const VMStateDescription*[]) {
-        &vmstate_ide_drive_pio_state,
-        NULL
-    }
-};
+  const VMStateDescription vmstate_ide_drive_pio_state = {
+      .name = "ide_drive/pio_state",
+      .version_id = 1,
+      .minimum_version_id = 1,
+      .pre_save = ide_drive_pio_pre_save,
+      .post_load = ide_drive_pio_post_load,
+      .needed = ide_drive_pio_state_needed,
+      .fields = (VMStateField[]) {
+          VMSTATE_INT32(req_nb_sectors, IDEState),
+          VMSTATE_VARRAY_INT32(io_buffer, IDEState, io_buffer_total_len, 1,
+                               vmstate_info_uint8, uint8_t),
+          VMSTATE_INT32(cur_io_buffer_offset, IDEState),
+          VMSTATE_INT32(cur_io_buffer_len, IDEState),
+          VMSTATE_UINT8(end_transfer_fn_idx, IDEState),
+          VMSTATE_INT32(elementary_transfer_size, IDEState),
+          VMSTATE_INT32(packet_transfer_size, IDEState),
+          VMSTATE_END_OF_LIST()
+      }
+  };
+
+  const VMStateDescription vmstate_ide_drive = {
+      .name = "ide_drive",
+      .version_id = 3,
+      .minimum_version_id = 0,
+      .post_load = ide_drive_post_load,
+      .fields = (VMStateField[]) {
+          .... several fields ....
+          VMSTATE_END_OF_LIST()
+      },
+      .subsections = (const VMStateDescription*[]) {
+          &vmstate_ide_drive_pio_state,
+          NULL
+      }
+  };
 
 Here we have a subsection for the pio state.  We only need to
 save/send this state when we are in the middle of a pio operation
-(that is what ide_drive_pio_state_needed() checks).  If DRQ_STAT is
+(that is what ``ide_drive_pio_state_needed()`` checks).  If DRQ_STAT is
 not enabled, the values on that fields are garbage and don't need to
 be sent.
 
@@ -304,11 +292,12 @@ Using a condition function that checks a 'property' to determine whether
 to send a subsection allows backwards migration compatibility when
 new subsections are added.
 
-For example;
-   a) Add a new property using DEFINE_PROP_BOOL - e.g. support-foo and
+For example:
+
+   a) Add a new property using ``DEFINE_PROP_BOOL`` - e.g. support-foo and
       default it to true.
-   b) Add an entry to the HW_COMPAT_ for the previous version
-      that sets the property to false.
+   b) Add an entry to the ``HW_COMPAT_`` for the previous version that sets
+      the property to false.
    c) Add a static bool  support_foo function that tests the property.
    d) Add a subsection with a .needed set to the support_foo function
    e) (potentially) Add a pre_load that sets up a default value for 'foo'
@@ -332,25 +321,30 @@ in most cases.  In general the preference is to tie the subsection to
 the machine type, and allow reliable migrations, unless the behaviour
 from omission of the subsection is really bad.
 
-= Not sending existing elements =
+Not sending existing elements
+-----------------------------
 
-Sometimes members of the VMState are no longer needed;
-  removing them will break migration compatibility
-  making them version dependent and bumping the version will break backwards
-   migration compatibility.
+Sometimes members of the VMState are no longer needed:
+
+  - removing them will break migration compatibility
+
+  - making them version dependent and bumping the version will break backwards migration compatibility.
 
 The best way is to:
-  a) Add a new property/compatibility/function in the same way for subsections
-    above.
+
+  a) Add a new property/compatibility/function in the same way for subsections above.
   b) replace the VMSTATE macro with the _TEST version of the macro, e.g.:
-     VMSTATE_UINT32(foo, barstruct)
+
+   ``VMSTATE_UINT32(foo, barstruct)``
+
    becomes
-     VMSTATE_UINT32_TEST(foo, barstruct, pre_version_baz)
 
-  Sometime in the future when we no longer care about the ancient
-versions these can be killed off.
+   ``VMSTATE_UINT32_TEST(foo, barstruct, pre_version_baz)``
 
-= Return path =
+   Sometime in the future when we no longer care about the ancient versions these can be killed off.
+
+Return path
+-----------
 
 In most migration scenarios there is only a single data path that runs
 from the source VM to the destination, typically along a single fd (although
@@ -360,19 +354,23 @@ However, some uses need two way communication; in particular the Postcopy
 destination needs to be able to request pages on demand from the source.
 
 For these scenarios there is a 'return path' from the destination to the source;
-qemu_file_get_return_path(QEMUFile* fwdpath) gives the QEMUFile* for the return
+``qemu_file_get_return_path(QEMUFile* fwdpath)`` gives the QEMUFile* for the return
 path.
 
   Source side
+
      Forward path - written by migration thread
      Return path  - opened by main thread, read by return-path thread
 
   Destination side
+
      Forward path - read by main thread
      Return path  - opened by main thread, written by main thread AND postcopy
-                    thread (protected by rp_mutex)
+     thread (protected by rp_mutex)
+
+Postcopy
+========
 
-= Postcopy =
 'Postcopy' migration is a way to deal with migrations that refuse to converge
 (or take too long to converge) its plus side is that there is an upper bound on
 the amount of migration traffic and time it takes, the down side is that during
@@ -386,27 +384,30 @@ a fault that's translated by QEMU into a request to the source QEMU.
 Postcopy can be combined with precopy (i.e. normal migration) so that if precopy
 doesn't finish in a given time the switch is made to postcopy.
 
-=== Enabling postcopy ===
+Enabling postcopy
+-----------------
 
 To enable postcopy, issue this command on the monitor prior to the
 start of migration:
 
-migrate_set_capability postcopy-ram on
+``migrate_set_capability postcopy-ram on``
 
 The normal commands are then used to start a migration, which is still
 started in precopy mode.  Issuing:
 
-migrate_start_postcopy
+``migrate_start_postcopy``
 
 will now cause the transition from precopy to postcopy.
 It can be issued immediately after migration is started or any
 time later on.  Issuing it after the end of a migration is harmless.
 
-Note: During the postcopy phase, the bandwidth limits set using
-migrate_set_speed is ignored (to avoid delaying requested pages that
-the destination is waiting for).
+.. note::
+  During the postcopy phase, the bandwidth limits set using
+  ``migrate_set_speed`` is ignored (to avoid delaying requested pages that
+  the destination is waiting for).
 
-=== Postcopy device transfer ===
+Postcopy device transfer
+------------------------
 
 Loading of device data may cause the device emulation to access guest RAM
 that may trigger faults that have to be resolved by the source, as such
@@ -416,6 +417,7 @@ before the device load begins to free the stream up.  This is achieved by
 'packaging' the device data into a blob that's read in one go.
 
 Source behaviour
+----------------
 
 Until postcopy is entered the migration stream is identical to normal
 precopy, except for the addition of a 'postcopy advise' command at
@@ -423,13 +425,14 @@ the beginning, to tell the destination that postcopy might happen.
 When postcopy starts the source sends the page discard data and then
 forms the 'package' containing:
 
-   Command: 'postcopy listen'
-   The device state
-      A series of sections, identical to the precopy streams device state stream
-      containing everything except postcopiable devices (i.e. RAM)
-   Command: 'postcopy run'
+   - Command: 'postcopy listen'
+   - The device state
 
-The 'package' is sent as the data part of a Command: 'CMD_PACKAGED', and the
+     A series of sections, identical to the precopy streams device state stream
+     containing everything except postcopiable devices (i.e. RAM)
+   - Command: 'postcopy run'
+
+The 'package' is sent as the data part of a Command: ``CMD_PACKAGED``, and the
 contents are formatted in the same way as the main migration stream.
 
 During postcopy the source scans the list of dirty pages and sends them
@@ -441,82 +444,100 @@ to be sent quickly in the hope that those pages are likely to be used
 by the destination soon.
 
 Destination behaviour
+---------------------
 
 Initially the destination looks the same as precopy, with a single thread
 reading the migration stream; the 'postcopy advise' and 'discard' commands
 are processed to change the way RAM is managed, but don't affect the stream
 processing.
 
-------------------------------------------------------------------------------
-                        1      2   3     4 5                      6   7
-main -----DISCARD-CMD_PACKAGED ( LISTEN  DEVICE     DEVICE DEVICE RUN )
-thread                             |       |
-                                   |     (page request)
-                                   |        \___
-                                   v            \
-listen thread:                     --- page -- page -- page -- page -- page --
-
-                                   a   b        c
-------------------------------------------------------------------------------
-
-On receipt of CMD_PACKAGED (1)
-   All the data associated with the package - the ( ... ) section in the
-diagram - is read into memory, and the main thread recurses into
-qemu_loadvm_state_main to process the contents of the package (2)
-which contains commands (3,6) and devices (4...)
-
-On receipt of 'postcopy listen' - 3 -(i.e. the 1st command in the package)
-a new thread (a) is started that takes over servicing the migration stream,
-while the main thread carries on loading the package.   It loads normal
-background page data (b) but if during a device load a fault happens (5) the
-returned page (c) is loaded by the listen thread allowing the main threads
-device load to carry on.
-
-The last thing in the CMD_PACKAGED is a 'RUN' command (6) letting the destination
-CPUs start running.
-At the end of the CMD_PACKAGED (7) the main thread returns to normal running behaviour
-and is no longer used by migration, while the listen thread carries
-on servicing page data until the end of migration.
-
-=== Postcopy states ===
+::
+
+  ------------------------------------------------------------------------------
+                          1      2   3     4 5                      6   7
+  main -----DISCARD-CMD_PACKAGED ( LISTEN  DEVICE     DEVICE DEVICE RUN )
+  thread                             |       |
+                                     |     (page request)
+                                     |        \___
+                                     v            \
+  listen thread:                     --- page -- page -- page -- page -- page --
+
+                                     a   b        c
+  ------------------------------------------------------------------------------
+
+- On receipt of ``CMD_PACKAGED`` (1)
+
+   All the data associated with the package - the ( ... ) section in the diagram -
+   is read into memory, and the main thread recurses into qemu_loadvm_state_main
+   to process the contents of the package (2) which contains commands (3,6) and
+   devices (4...)
+
+- On receipt of 'postcopy listen' - 3 -(i.e. the 1st command in the package)
+
+   a new thread (a) is started that takes over servicing the migration stream,
+   while the main thread carries on loading the package.   It loads normal
+   background page data (b) but if during a device load a fault happens (5)
+   the returned page (c) is loaded by the listen thread allowing the main
+   threads device load to carry on.
+
+- The last thing in the ``CMD_PACKAGED`` is a 'RUN' command (6)
+
+   letting the destination CPUs start running.  At the end of the
+   ``CMD_PACKAGED`` (7) the main thread returns to normal running behaviour and
+   is no longer used by migration, while the listen thread carries on servicing
+   page data until the end of migration.
+
+Postcopy states
+---------------
 
 Postcopy moves through a series of states (see postcopy_state) from
 ADVISE->DISCARD->LISTEN->RUNNING->END
 
-  Advise:  Set at the start of migration if postcopy is enabled, even
-           if it hasn't had the start command; here the destination
-           checks that its OS has the support needed for postcopy, and performs
-           setup to ensure the RAM mappings are suitable for later postcopy.
-           The destination will fail early in migration at this point if the
-           required OS support is not present.
-           (Triggered by reception of POSTCOPY_ADVISE command)
-
-  Discard: Entered on receipt of the first 'discard' command; prior to
-           the first Discard being performed, hugepages are switched off
-           (using madvise) to ensure that no new huge pages are created
-           during the postcopy phase, and to cause any huge pages that
-           have discards on them to be broken.
-
-  Listen:  The first command in the package, POSTCOPY_LISTEN, switches
-           the destination state to Listen, and starts a new thread
-           (the 'listen thread') which takes over the job of receiving
-           pages off the migration stream, while the main thread carries
-           on processing the blob.  With this thread able to process page
-           reception, the destination now 'sensitises' the RAM to detect
-           any access to missing pages (on Linux using the 'userfault'
-           system).
-
-  Running: POSTCOPY_RUN causes the destination to synchronise all
-           state and start the CPUs and IO devices running.  The main
-           thread now finishes processing the migration package and
-           now carries on as it would for normal precopy migration
-           (although it can't do the cleanup it would do as it
-           finishes a normal migration).
-
-  End:     The listen thread can now quit, and perform the cleanup of migration
-           state, the migration is now complete.
-
-=== Source side page maps ===
+ - Advise
+
+    Set at the start of migration if postcopy is enabled, even
+    if it hasn't had the start command; here the destination
+    checks that its OS has the support needed for postcopy, and performs
+    setup to ensure the RAM mappings are suitable for later postcopy.
+    The destination will fail early in migration at this point if the
+    required OS support is not present.
+    (Triggered by reception of POSTCOPY_ADVISE command)
+
+ - Discard
+
+    Entered on receipt of the first 'discard' command; prior to
+    the first Discard being performed, hugepages are switched off
+    (using madvise) to ensure that no new huge pages are created
+    during the postcopy phase, and to cause any huge pages that
+    have discards on them to be broken.
+
+ - Listen
+
+    The first command in the package, POSTCOPY_LISTEN, switches
+    the destination state to Listen, and starts a new thread
+    (the 'listen thread') which takes over the job of receiving
+    pages off the migration stream, while the main thread carries
+    on processing the blob.  With this thread able to process page
+    reception, the destination now 'sensitises' the RAM to detect
+    any access to missing pages (on Linux using the 'userfault'
+    system).
+
+ - Running
+
+    POSTCOPY_RUN causes the destination to synchronise all
+    state and start the CPUs and IO devices running.  The main
+    thread now finishes processing the migration package and
+    now carries on as it would for normal precopy migration
+    (although it can't do the cleanup it would do as it
+    finishes a normal migration).
+
+ - End
+
+    The listen thread can now quit, and perform the cleanup of migration
+    state, the migration is now complete.
+
+Source side page maps
+---------------------
 
 The source side keeps two bitmaps during postcopy; 'the migration bitmap'
 and 'unsent map'.  The 'migration bitmap' is basically the same as in
@@ -529,6 +550,7 @@ The 'unsent map' is used for the transition to postcopy. It is a bitmap that
 has a bit cleared whenever a page is sent to the destination, however during
 the transition to postcopy mode it is combined with the migration bitmap
 to form a set of pages that:
+
    a) Have been sent but then redirtied (which must be discarded)
    b) Have not yet been sent - which also must be discarded to cause any
       transparent huge pages built during precopy to be broken.
@@ -540,15 +562,17 @@ request for a page that has already been sent is ignored.  Duplicate requests
 such as this can happen as a page is sent at about the same time the
 destination accesses it.
 
-=== Postcopy with hugepages ===
+Postcopy with hugepages
+-----------------------
 
 Postcopy now works with hugetlbfs backed memory:
+
   a) The linux kernel on the destination must support userfault on hugepages.
   b) The huge-page configuration on the source and destination VMs must be
      identical; i.e. RAMBlocks on both sides must use the same page size.
-  c) Note that -mem-path /dev/hugepages  will fall back to allocating normal
+  c) Note that ``-mem-path /dev/hugepages``  will fall back to allocating normal
      RAM if it doesn't have enough hugepages, triggering (b) to fail.
-     Using -mem-prealloc enforces the allocation using hugepages.
+     Using ``-mem-prealloc`` enforces the allocation using hugepages.
   d) Care should be taken with the size of hugepage used; postcopy with 2MB
      hugepages works well, however 1GB hugepages are likely to be problematic
      since it takes ~1 second to transfer a 1GB hugepage across a 10Gbps link,
-- 
2.14.3
