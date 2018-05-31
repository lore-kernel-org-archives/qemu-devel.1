Received: from eggs.gnu.org ([2001:4830:134:3::10]:58605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8Z-0003eD-6W
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8Y-0000DE-1j
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33534 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fOR8X-0000Cy-TL
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:17 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 31 May 2018 19:12:24 +0200
Message-Id: <20180531171253.21012-25-pbonzini@redhat.com>
In-Reply-To: <20180531171253.21012-1-pbonzini@redhat.com>
References: <20180531171253.21012-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 24/53] qom: Document qom/device-list-properties
 implementation specific
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

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
Message-Id: <20180530071129.9013-1-aik@ozlabs.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qapi/misc.json | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/qapi/misc.json b/qapi/misc.json
index f5988cc0b5..efc3d23057 100644
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
2.17.0
