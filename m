Received: from eggs.gnu.org ([2001:4830:134:3::10]:49790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gWdig-0008P3-DF
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 03:48:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gWdid-00083E-4C
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 03:48:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44860)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gWdic-00081W-SM
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 03:48:43 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <154419994154.27028.14774494243513273923.stgit@gimli.home>
	<154420088248.27028.3919592169648338038.stgit@gimli.home>
	<16f2e753-4e80-0acc-d35a-75c6eb5a8f54@redhat.com>
Date: Tue, 11 Dec 2018 09:48:37 +0100
In-Reply-To: <16f2e753-4e80-0acc-d35a-75c6eb5a8f54@redhat.com> (Eric Blake's
	message of "Mon, 10 Dec 2018 16:00:57 -0600")
Message-ID: <878t0wbg9m.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Eric Blake <eblake@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, Geoffrey McRae <geoff@hostfission.com>, Markus Armbruster <armbru@redhat.com>

Eric Blake <eblake@redhat.com> writes:

> On 12/7/18 10:41 AM, Alex Williamson wrote:
>> Create properties to be able to define speeds and widths for PCIe
>> links.  The only tricky bit here is that our get and set callbacks
>> translate from the fixed QAPI automagic enums to those we define
>> in PCI code to represent the actual register segment value.
>>
>> Cc: Eric Blake <eblake@redhat.com>
>> Tested-by: Geoffrey McRae <geoff@hostfission.com>
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
>> ---
>>   hw/core/qdev-properties.c    |  178 ++++++++++++++++++++++++++++++++++++++++++
>>   include/hw/qdev-properties.h |    8 ++
>>   qapi/common.json             |   42 ++++++++++
>>   3 files changed, 228 insertions(+)
>>
>> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
>> index 35072dec1ecf..f5ca5b821a79 100644
>> --- a/hw/core/qdev-properties.c
>> +++ b/hw/core/qdev-properties.c
>> @@ -1327,3 +1327,181 @@ const PropertyInfo qdev_prop_off_auto_pcibar = {
>>       .set = set_enum,
>>       .set_default_value = set_default_value_enum,
>>   };
>> +
>> +/* --- PCIELinkSpeed 2_5/5/8/16 -- */
>> +
>> +static void get_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
>> +                                   void *opaque, Error **errp)
>> +{
>> +    DeviceState *dev = DEVICE(obj);
>> +    Property *prop = opaque;
>> +    PCIExpLinkSpeed *p = qdev_get_prop_ptr(dev, prop);
>> +    PCIELinkSpeed speed;
>
> C does not guarantee what width 'speed' has,...

Correct.  The enumeration constants have type int, but the enumeration
type's compatible integer type is implementation-defined, see C99
6.7.2.2.

>> +
>> +    switch (*p) {
>> +    case QEMU_PCI_EXP_LNK_2_5GT:
>> +        speed = PCIE_LINK_SPEED_2_5;
>> +        break;
>> +    case QEMU_PCI_EXP_LNK_5GT:
>> +        speed = PCIE_LINK_SPEED_5;
>> +        break;
>> +    case QEMU_PCI_EXP_LNK_8GT:
>> +        speed = PCIE_LINK_SPEED_8;
>> +        break;
>> +    case QEMU_PCI_EXP_LNK_16GT:
>> +        speed = PCIE_LINK_SPEED_16;
>> +        break;
>> +    default:
>> +        /* Unreachable */
>> +        abort();
>> +    }
>> +
>> +    visit_type_enum(v, prop->name, (int *)&speed, prop->info->enum_table, errp);
>
> ...making this cast to (int*) not be very kosher. I _think_ we're okay
> here, but I'd be a LOT happier if you just used 'int speed' to avoid
> the cast.

Good catch!

"The GNU Compiler Collection" section C Implementation-Defined Behavior
/ Structures, Unions, Enumerations, and Bit-Fields documents:

   * 'The integer type compatible with each enumerated type (C90
     6.5.2.2, C99 and C11 6.7.2.2).'

     Normally, the type is 'unsigned int' if there are no negative
     values in the enumeration, otherwise 'int'.  If '-fshort-enums' is
     specified, then if there are negative values it is the first of
     'signed char', 'short' and 'int' that can represent all the values,
     otherwise it is the first of 'unsigned char', 'unsigned short' and
     'unsigned int' that can represent all the values.

     On some targets, '-fshort-enums' is the default; this is determined
     by the ABI.

We don't pass -fshort-enums, because we can well do without opening that
can of worms.

That leaves the dependence on the ABI.  As far as I know, the ABIs we
care about don't have short enums.

Still, it's unclean without a real need.

>
>> +}
>> +
>> +static void set_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
>> +                                   void *opaque, Error **errp)
>> +{
>> +    DeviceState *dev = DEVICE(obj);
>> +    Property *prop = opaque;
>> +    PCIExpLinkSpeed *p = qdev_get_prop_ptr(dev, prop);
>> +    PCIELinkSpeed speed;
>> +    Error *local_err = NULL;
>> +
>> +    if (dev->realized) {
>> +        qdev_prop_set_after_realize(dev, name, errp);
>> +        return;
>> +    }
>> +
>> +    visit_type_enum(v, prop->name, (int *)&speed,
>
> And again.
>
>> +                    prop->info->enum_table, &local_err);
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +        return;
>> +    }
>> +
>> +    switch (speed) {
>> +    case PCIE_LINK_SPEED_2_5:
>> +        *p = QEMU_PCI_EXP_LNK_2_5GT;
>> +        break;
>> +    case PCIE_LINK_SPEED_5:
>> +        *p = QEMU_PCI_EXP_LNK_5GT;
>> +        break;
>> +    case PCIE_LINK_SPEED_8:
>> +        *p = QEMU_PCI_EXP_LNK_8GT;
>> +        break;
>> +    case PCIE_LINK_SPEED_16:
>> +        *p = QEMU_PCI_EXP_LNK_16GT;
>> +        break;
>> +    default:
>> +        /* Unreachable */
>> +        abort();
>> +    }
>> +}
>> +
>
>> +static void get_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
>> +                                   void *opaque, Error **errp)
>> +{
>> +    DeviceState *dev = DEVICE(obj);
>> +    Property *prop = opaque;
>> +    PCIExpLinkWidth *p = qdev_get_prop_ptr(dev, prop);
>> +    PCIELinkWidth width;
>> +
>> +    switch (*p) {
>
>> +    visit_type_enum(v, prop->name, (int *)&width, prop->info->enum_table, errp);
>> +}
>> +
>> +static void set_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
>> +                                   void *opaque, Error **errp)
>> +{
>> +    DeviceState *dev = DEVICE(obj);
>> +    Property *prop = opaque;
>> +    PCIExpLinkWidth *p = qdev_get_prop_ptr(dev, prop);
>> +    PCIELinkWidth width;
>> +    Error *local_err = NULL;
>> +
>> +    if (dev->realized) {
>> +        qdev_prop_set_after_realize(dev, name, errp);
>> +        return;
>> +    }
>> +
>> +    visit_type_enum(v, prop->name, (int *)&width,
>
> And two more spots.

[...]
