Received: from eggs.gnu.org ([2001:4830:134:3::10]:40139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fNvHH-0004fU-I8
	for qemu-devel@nongnu.org; Wed, 30 May 2018 03:12:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fNvHB-0002Ib-6G
	for qemu-devel@nongnu.org; Wed, 30 May 2018 03:12:11 -0400
Received: from [107.173.13.209] (port=48339 helo=ozlabs.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fNvHA-0002IL-UM
	for qemu-devel@nongnu.org; Wed, 30 May 2018 03:12:05 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Wed, 30 May 2018 17:11:29 +1000
Message-Id: <20180530071129.9013-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v3] qom: Document
 qom/device-list-properties implementation specific
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

The recently introduced qom-list-properties QMP command raised
a question what properties it (and its cousin - device-list-properties)
can possibly print - only those defined by DeviceClass::props
or dynamically created in TypeInfo::instance_init() so properties created
elsewhere won't show up and this behaviour might confuse the user.

For example, PIIX4 does that from piix4_pm_realize() via
  piix4_pm_add_propeties():

object_property_add_uint8_ptr(OBJECT(s), ACPI_PM_PROP_ACPI_ENABLE_CMD,
                              &acpi_enable_cmd, NULL);

This adds a note to the command descriptions about the limitation.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v3:
* adjusted commit log with Markus suggestion
* added a-by/r-by
---
 qapi/misc.json | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/qapi/misc.json b/qapi/misc.json
index 99bcaac..bbf9ef8 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1529,6 +1529,10 @@
 #
 # Returns: a list of ObjectPropertyInfo describing a devices properties
 #
+# Note: objects can create properties at runtime, for example to describe
+# links between different devices and/or objects. These properties
+# are not included in the output of this command.
+#
 # Since: 1.2
 ##
 { 'command': 'device-list-properties',
@@ -1542,6 +1546,10 @@
 #
 # @typename: the type name of an object
 #
+# Note: objects can create properties at runtime, for example to describe
+# links between different devices and/or objects. These properties
+# are not included in the output of this command.
+#
 # Returns: a list of ObjectPropertyInfo describing object properties
 #
 # Since: 2.12
-- 
2.11.0
