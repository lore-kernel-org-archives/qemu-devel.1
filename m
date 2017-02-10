Received: from eggs.gnu.org ([2001:4830:134:3::10]:48998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cc8zm-0003oO-J5
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 06:04:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cc8zj-0002MK-EG
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 06:04:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56682)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cc8zj-0002MD-6J
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 06:04:03 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 10 Feb 2017 11:03:59 +0000
Message-Id: <20170210110359.8210-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v2] migration: Update docs to discourage
 version bumps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, armbru@redhat.com
Cc: peter.maydell@linaro.org

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Version bumps break backwards migration; update the docs
to explain to people that's bad and how to avoid it.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 docs/migration.txt | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/docs/migration.txt b/docs/migration.txt
index b462ead..1b940a8 100644
--- a/docs/migration.txt
+++ b/docs/migration.txt
@@ -161,6 +161,11 @@ include/hw/hw.h.
 
 === More about versions ===
 
+Version numbers are intended for major incompatible changes to the
+migration of a device, and using them breaks backwards-migration
+compatibility; in general most changes can be made by adding Subsections
+(see below) or _TEST macros (see below) which won't break compatibility.
+
 You can see that there are several version fields:
 
 - version_id: the maximum version_id supported by VMState for that device.
@@ -175,6 +180,9 @@ version_id.  And the function load_state_old() (if present) is able to
 load state from minimum_version_id_old to minimum_version_id.  This
 function is deprecated and will be removed when no more users are left.
 
+Saving state will always create a section with the 'version_id' value
+and thus can't be loaded by any older QEMU.
+
 ===  Massaging functions ===
 
 Sometimes, it is not enough to be able to save the state directly
@@ -292,6 +300,56 @@ save/send this state when we are in the middle of a pio operation
 not enabled, the values on that fields are garbage and don't need to
 be sent.
 
+Using a condition function that checks a 'property' to determine whether
+to send a subsection allows backwards migration compatibility when
+new subsections are added.
+
+For example;
+   a) Add a new property using DEFINE_PROP_BOOL - e.g. support-foo and
+      default it to true.
+   b) Add an entry to the HW_COMPAT_ for the previous version
+      that sets the property to false.
+   c) Add a static bool  support_foo function that tests the property.
+   d) Add a subsection with a .needed set to the support_foo function
+   e) (potentially) Add a pre_load that sets up a default value for 'foo'
+      to be used if the subsection isn't loaded.
+
+Now that subsection will not be generated when using an older
+machine type and the migration stream will be accepted by older
+QEMU versions. pre-load functions can be used to initialise state
+on the newer version so that they default to suitable values
+when loading streams created by older QEMU versions that do not
+generate the subsection.
+
+In some cases subsections are added for data that had been accidentally
+omitted by earlier versions; if the missing data causes the migration
+process to succeed but the guest to behave badly then it may be better
+to send the subsection and cause the migration to explicitly fail
+with the unknown subsection error.   If the bad behaviour only happens
+with certain data values, making the subsection conditional on
+the data value (rather than the machine type) allows migrations to succeed
+in most cases.  In general the preference is to tie the subsection to
+the machine type, and allow reliable migrations, unless the behaviour
+from omission of the subsection is really bad.
+
+= Not sending existing elements =
+
+Sometimes members of the VMState are no longer needed;
+  removing them will break migration compatibility
+  making them version dependent and bumping the version will break backwards
+   migration compatibility.
+
+The best way is to:
+  a) Add a new property/compatibility/function in the same way for subsections
+    above.
+  b) replace the VMSTATE macro with the _TEST version of the macro, e.g.:
+     VMSTATE_UINT32(foo, barstruct)
+   becomes
+     VMSTATE_UINT32_TEST(foo, barstruct, pre_version_baz)
+
+  Sometime in the future when we no longer care about the ancient
+versions these can be killed off.
+
 = Return path =
 
 In most migration scenarios there is only a single data path that runs
-- 
2.9.3
