Received: from eggs.gnu.org ([2001:4830:134:3::10]:49109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gWlM0-00078v-BC
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:57:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gWlLw-0002ga-2t
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:57:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51110)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gWlLt-00029t-Tu
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:57:46 -0500
Date: Tue, 11 Dec 2018 09:57:02 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20181211095702.75f375d0@x1.home>
In-Reply-To: <878t0wbg9m.fsf@dusky.pond.sub.org>
References: <154419994154.27028.14774494243513273923.stgit@gimli.home>
	<154420088248.27028.3919592169648338038.stgit@gimli.home>
	<16f2e753-4e80-0acc-d35a-75c6eb5a8f54@redhat.com>
	<878t0wbg9m.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [for-4.0 PATCH v4 4/9] qapi: Define PCIe link
 speed and width properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Geoffrey McRae <geoff@hostfission.com>

On Tue, 11 Dec 2018 09:48:37 +0100
Markus Armbruster <armbru@redhat.com> wrote:

> Eric Blake <eblake@redhat.com> writes:
> 
> > On 12/7/18 10:41 AM, Alex Williamson wrote:  
> >> Create properties to be able to define speeds and widths for PCIe
> >> links.  The only tricky bit here is that our get and set callbacks
> >> translate from the fixed QAPI automagic enums to those we define
> >> in PCI code to represent the actual register segment value.
> >>
> >> Cc: Eric Blake <eblake@redhat.com>
> >> Tested-by: Geoffrey McRae <geoff@hostfission.com>
> >> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> >> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> >> ---
> >>   hw/core/qdev-properties.c    |  178 ++++++++++++++++++++++++++++++++++++++++++
> >>   include/hw/qdev-properties.h |    8 ++
> >>   qapi/common.json             |   42 ++++++++++
> >>   3 files changed, 228 insertions(+)
> >>
> >> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> >> index 35072dec1ecf..f5ca5b821a79 100644
> >> --- a/hw/core/qdev-properties.c
> >> +++ b/hw/core/qdev-properties.c
> >> @@ -1327,3 +1327,181 @@ const PropertyInfo qdev_prop_off_auto_pcibar = {
> >>       .set = set_enum,
> >>       .set_default_value = set_default_value_enum,
> >>   };
> >> +
> >> +/* --- PCIELinkSpeed 2_5/5/8/16 -- */
> >> +
> >> +static void get_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
> >> +                                   void *opaque, Error **errp)
> >> +{
> >> +    DeviceState *dev = DEVICE(obj);
> >> +    Property *prop = opaque;
> >> +    PCIExpLinkSpeed *p = qdev_get_prop_ptr(dev, prop);
> >> +    PCIELinkSpeed speed;  
> >
> > C does not guarantee what width 'speed' has,...  
> 
> Correct.  The enumeration constants have type int, but the enumeration
> type's compatible integer type is implementation-defined, see C99
> 6.7.2.2.
> 
> >> +
> >> +    switch (*p) {
> >> +    case QEMU_PCI_EXP_LNK_2_5GT:
> >> +        speed = PCIE_LINK_SPEED_2_5;
> >> +        break;
> >> +    case QEMU_PCI_EXP_LNK_5GT:
> >> +        speed = PCIE_LINK_SPEED_5;
> >> +        break;
> >> +    case QEMU_PCI_EXP_LNK_8GT:
> >> +        speed = PCIE_LINK_SPEED_8;
> >> +        break;
> >> +    case QEMU_PCI_EXP_LNK_16GT:
> >> +        speed = PCIE_LINK_SPEED_16;
> >> +        break;
> >> +    default:
> >> +        /* Unreachable */
> >> +        abort();
> >> +    }
> >> +
> >> +    visit_type_enum(v, prop->name, (int *)&speed, prop->info->enum_table, errp);  
> >
> > ...making this cast to (int*) not be very kosher. I _think_ we're okay
> > here, but I'd be a LOT happier if you just used 'int speed' to avoid
> > the cast.  
> 
> Good catch!
> 
> "The GNU Compiler Collection" section C Implementation-Defined Behavior
> / Structures, Unions, Enumerations, and Bit-Fields documents:
> 
>    * 'The integer type compatible with each enumerated type (C90
>      6.5.2.2, C99 and C11 6.7.2.2).'
> 
>      Normally, the type is 'unsigned int' if there are no negative
>      values in the enumeration, otherwise 'int'.  If '-fshort-enums' is
>      specified, then if there are negative values it is the first of
>      'signed char', 'short' and 'int' that can represent all the values,
>      otherwise it is the first of 'unsigned char', 'unsigned short' and
>      'unsigned int' that can represent all the values.
> 
>      On some targets, '-fshort-enums' is the default; this is determined
>      by the ABI.
> 
> We don't pass -fshort-enums, because we can well do without opening that
> can of worms.
> 
> That leaves the dependence on the ABI.  As far as I know, the ABIs we
> care about don't have short enums.
> 
> Still, it's unclean without a real need.

Ok, I'll respin this patch to the following, the rest of the series is
unaffected.  Since Markus has commented in agreement, I'll leave his
review.  I'll give it a bit more time before I repost the whole series
again. Thanks,

Alex

commit f72d8fbfa3d081a9d0e83a9549f5bd4b0165cc92
Author: Alex Williamson <alex.williamson@redhat.com>
Date:   Tue Dec 4 08:44:20 2018 -0700

    qapi: Define PCIe link speed and width properties
    
    Create properties to be able to define speeds and widths for PCIe
    links.  The only tricky bit here is that our get and set callbacks
    translate from the fixed QAPI automagic enums to those we define
    in PCI code to represent the actual register segment value.
    
    Cc: Eric Blake <eblake@redhat.com>
    Tested-by: Geoffrey McRae <geoff@hostfission.com>
    Reviewed-by: Markus Armbruster <armbru@redhat.com>
    Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 35072dec1ecf..1dee38000111 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1327,3 +1327,179 @@ const PropertyInfo qdev_prop_off_auto_pcibar = {
     .set = set_enum,
     .set_default_value = set_default_value_enum,
 };
+
+/* --- PCIELinkSpeed 2_5/5/8/16 -- */
+
+static void get_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
+                                   void *opaque, Error **errp)
+{
+    DeviceState *dev = DEVICE(obj);
+    Property *prop = opaque;
+    PCIExpLinkSpeed *p = qdev_get_prop_ptr(dev, prop);
+    int speed;
+
+    switch (*p) {
+    case QEMU_PCI_EXP_LNK_2_5GT:
+        speed = PCIE_LINK_SPEED_2_5;
+        break;
+    case QEMU_PCI_EXP_LNK_5GT:
+        speed = PCIE_LINK_SPEED_5;
+        break;
+    case QEMU_PCI_EXP_LNK_8GT:
+        speed = PCIE_LINK_SPEED_8;
+        break;
+    case QEMU_PCI_EXP_LNK_16GT:
+        speed = PCIE_LINK_SPEED_16;
+        break;
+    default:
+        /* Unreachable */
+        abort();
+    }
+
+    visit_type_enum(v, prop->name, &speed, prop->info->enum_table, errp);
+}
+
+static void set_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
+                                   void *opaque, Error **errp)
+{
+    DeviceState *dev = DEVICE(obj);
+    Property *prop = opaque;
+    PCIExpLinkSpeed *p = qdev_get_prop_ptr(dev, prop);
+    int speed;
+    Error *local_err = NULL;
+
+    if (dev->realized) {
+        qdev_prop_set_after_realize(dev, name, errp);
+        return;
+    }
+
+    visit_type_enum(v, prop->name, &speed, prop->info->enum_table, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    switch (speed) {
+    case PCIE_LINK_SPEED_2_5:
+        *p = QEMU_PCI_EXP_LNK_2_5GT;
+        break;
+    case PCIE_LINK_SPEED_5:
+        *p = QEMU_PCI_EXP_LNK_5GT;
+        break;
+    case PCIE_LINK_SPEED_8:
+        *p = QEMU_PCI_EXP_LNK_8GT;
+        break;
+    case PCIE_LINK_SPEED_16:
+        *p = QEMU_PCI_EXP_LNK_16GT;
+        break;
+    default:
+        /* Unreachable */
+        abort();
+    }
+}
+
+const PropertyInfo qdev_prop_pcie_link_speed = {
+    .name = "PCIELinkSpeed",
+    .description = "2_5/5/8/16",
+    .enum_table = &PCIELinkSpeed_lookup,
+    .get = get_prop_pcielinkspeed,
+    .set = set_prop_pcielinkspeed,
+    .set_default_value = set_default_value_enum,
+};
+
+/* --- PCIELinkWidth 1/2/4/8/12/16/32 -- */
+
+static void get_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
+                                   void *opaque, Error **errp)
+{
+    DeviceState *dev = DEVICE(obj);
+    Property *prop = opaque;
+    PCIExpLinkWidth *p = qdev_get_prop_ptr(dev, prop);
+    int width;
+
+    switch (*p) {
+    case QEMU_PCI_EXP_LNK_X1:
+        width = PCIE_LINK_WIDTH_1;
+        break;
+    case QEMU_PCI_EXP_LNK_X2:
+        width = PCIE_LINK_WIDTH_2;
+        break;
+    case QEMU_PCI_EXP_LNK_X4:
+        width = PCIE_LINK_WIDTH_4;
+        break;
+    case QEMU_PCI_EXP_LNK_X8:
+        width = PCIE_LINK_WIDTH_8;
+        break;
+    case QEMU_PCI_EXP_LNK_X12:
+        width = PCIE_LINK_WIDTH_12;
+        break;
+    case QEMU_PCI_EXP_LNK_X16:
+        width = PCIE_LINK_WIDTH_16;
+        break;
+    case QEMU_PCI_EXP_LNK_X32:
+        width = PCIE_LINK_WIDTH_32;
+        break;
+    default:
+        /* Unreachable */
+        abort();
+    }
+
+    visit_type_enum(v, prop->name, &width, prop->info->enum_table, errp);
+}
+
+static void set_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
+                                   void *opaque, Error **errp)
+{
+    DeviceState *dev = DEVICE(obj);
+    Property *prop = opaque;
+    PCIExpLinkWidth *p = qdev_get_prop_ptr(dev, prop);
+    int width;
+    Error *local_err = NULL;
+
+    if (dev->realized) {
+        qdev_prop_set_after_realize(dev, name, errp);
+        return;
+    }
+
+    visit_type_enum(v, prop->name, &width, prop->info->enum_table, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    switch (width) {
+    case PCIE_LINK_WIDTH_1:
+        *p = QEMU_PCI_EXP_LNK_X1;
+        break;
+    case PCIE_LINK_WIDTH_2:
+        *p = QEMU_PCI_EXP_LNK_X2;
+        break;
+    case PCIE_LINK_WIDTH_4:
+        *p = QEMU_PCI_EXP_LNK_X4;
+        break;
+    case PCIE_LINK_WIDTH_8:
+        *p = QEMU_PCI_EXP_LNK_X8;
+        break;
+    case PCIE_LINK_WIDTH_12:
+        *p = QEMU_PCI_EXP_LNK_X12;
+        break;
+    case PCIE_LINK_WIDTH_16:
+        *p = QEMU_PCI_EXP_LNK_X16;
+        break;
+    case PCIE_LINK_WIDTH_32:
+        *p = QEMU_PCI_EXP_LNK_X32;
+        break;
+    default:
+        /* Unreachable */
+        abort();
+    }
+}
+
+const PropertyInfo qdev_prop_pcie_link_width = {
+    .name = "PCIELinkWidth",
+    .description = "1/2/4/8/12/16/32",
+    .enum_table = &PCIELinkWidth_lookup,
+    .get = get_prop_pcielinkwidth,
+    .set = set_prop_pcielinkwidth,
+    .set_default_value = set_default_value_enum,
+};
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 4f60cc88f325..6a13a284c48c 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -36,6 +36,8 @@ extern const PropertyInfo qdev_prop_uuid;
 extern const PropertyInfo qdev_prop_arraylen;
 extern const PropertyInfo qdev_prop_link;
 extern const PropertyInfo qdev_prop_off_auto_pcibar;
+extern const PropertyInfo qdev_prop_pcie_link_speed;
+extern const PropertyInfo qdev_prop_pcie_link_width;
 
 #define DEFINE_PROP(_name, _state, _field, _prop, _type) { \
         .name      = (_name),                                    \
@@ -217,6 +219,12 @@ extern const PropertyInfo qdev_prop_off_auto_pcibar;
 #define DEFINE_PROP_OFF_AUTO_PCIBAR(_n, _s, _f, _d) \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_off_auto_pcibar, \
                         OffAutoPCIBAR)
+#define DEFINE_PROP_PCIE_LINK_SPEED(_n, _s, _f, _d) \
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_pcie_link_speed, \
+                        PCIExpLinkSpeed)
+#define DEFINE_PROP_PCIE_LINK_WIDTH(_n, _s, _f, _d) \
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_pcie_link_width, \
+                        PCIExpLinkWidth)
 
 #define DEFINE_PROP_UUID(_name, _state, _field) {                  \
         .name      = (_name),                                      \
diff --git a/qapi/common.json b/qapi/common.json
index 021174f04ea4..99d313ef3b59 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -127,6 +127,48 @@
 { 'enum': 'OffAutoPCIBAR',
   'data': [ 'off', 'auto', 'bar0', 'bar1', 'bar2', 'bar3', 'bar4', 'bar5' ] }
 
+##
+# @PCIELinkSpeed:
+#
+# An enumeration of PCIe link speeds in units of GT/s
+#
+# @2_5: 2.5GT/s
+#
+# @5: 5.0GT/s
+#
+# @8: 8.0GT/s
+#
+# @16: 16.0GT/s
+#
+# Since: 4.0
+##
+{ 'enum': 'PCIELinkSpeed',
+  'data': [ '2_5', '5', '8', '16' ] }
+
+##
+# @PCIELinkWidth:
+#
+# An enumeration of PCIe link width
+#
+# @1: x1
+#
+# @2: x2
+#
+# @4: x4
+#
+# @8: x8
+#
+# @12: x12
+#
+# @16: x16
+#
+# @32: x32
+#
+# Since: 4.0
+##
+{ 'enum': 'PCIELinkWidth',
+  'data': [ '1', '2', '4', '8', '12', '16', '32' ] }
+
 ##
 # @SysEmuTarget:
 #
