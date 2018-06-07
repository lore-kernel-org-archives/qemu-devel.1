Received: from eggs.gnu.org ([2001:4830:134:3::10]:47805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fQqVy-0003sp-A5
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 04:43:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fQqVv-0006lF-5e
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 04:43:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32904 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fQqVu-0006l9-Vy
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 04:43:23 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180605091508.14129-1-aik@ozlabs.ru>
	<20180605092937.GK32286@redhat.com>
Date: Thu, 07 Jun 2018 10:43:20 +0200
In-Reply-To: <20180605092937.GK32286@redhat.com> ("Daniel P. =?utf-8?Q?Ber?=
	=?utf-8?Q?rang=C3=A9=22's?=
	message of "Tue, 5 Jun 2018 10:29:37 +0100")
Message-ID: <87d0x32dhz.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH qemu] qdev: Use "string" for QOM string
 properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Jun 05, 2018 at 07:15:08PM +1000, Alexey Kardashevskiy wrote:
>> For QOM properties QEMU uses "string", for example:
>>=20
>> {"execute": "qom-list", "arguments": {"path": "/machine"}}
>> [{'return': [{'type': 'string', 'name': 'append'},  {'type': 'string', '=
name': 'kernel'}]
>>=20
>> However for the device properties copied from DEVICE_CLASS(class)->props,
>> "str" is used for a type (vnet0 is "-device virtio-net-pci,id=3Dvnet0"):
>>=20
>> {"execute": "qom-list", "arguments": {"path": "/machine/peripheral/vnet0=
"}}
>> ret=3D[{'return': [{'name': 'tx', 'type': 'str'}]

Sad.

>> This changes string type when adding them to QOM property list so
>> we get one string type in QMP.
>>=20
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>=20
>> Not a huge improvement and might actually break something but since
>> I got that far I decided to post this anyway :)
>>=20
>> The alternatives are: 1) do nothing 2) do this:
>>=20
>>  const PropertyInfo qdev_prop_string =3D {
>> -    .name  =3D "str",
>> +    .name  =3D "string",
>>      .release =3D release_string,
>>      .get   =3D get_string,
>>      .set   =3D set_string,
>>  };

To gauge the effect of this change, we need to track down uses of
.name.  See below.

>
> As further points of reference:
>
>  - object_property_add_str & object_class_property_add_str
>    both use "string".
>=20=20=20=20
>  - QAPI schema uses "str"
>
> So the inconsistency is even bigger than just qdev. I'm inclined
> to say "QAPI schema" is the canonical source of truth, and so
> every use of "string" should change to "str".
>
> CC'd Markus for 2nd opinion.

I agree with the notion to give QAPI precedence on interface
introspection questions, simply because its become our base for
introspectable interfaces.

However, this case isn't as simple as "QAPI uses 'str', and that's
that.'

QAPI's 'str' started out as name of a built-in type, not exposed at any
external interface.

With QMP schema introspection, the names of built-in types got exposed,
but only as a reading aid, with an explicit admonition not to rely on
them (docs/devel/qapi-code-gen.txt section Client JSON Protocol
introspection):

    Command and event names are part of the wire ABI, but type names are
    not.  Therefore, the SchemaInfo for types have auto-generated
    meaningless names.
    [...]
    The SchemaInfo for a built-in type has the same name as the type in
    the QAPI schema (see section Built-in Types) [...].  It has variant
    member "json-type" that shows how values of this type are encoded on
    the wire.
    [...]
    As explained above, type names are not part of the wire ABI.  Not even
    the names of built-in types.  Clients should examine member
    "json-type" instead of hard-coding names of built-in types.

This gives us license to change the type name 'str' in QMP schema
introspection.  Clients that rely on 'str' are simply broken.

Doesn't mean we *want* to change it.  We might not want to turn latent
client bugs into actively biting ones.  Or we might like 'str' better.

>> ---
>>  hw/core/qdev.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
>> index f6f9247..2895693 100644
>> --- a/hw/core/qdev.c
>> +++ b/hw/core/qdev.c
>> @@ -687,7 +687,7 @@ static void qdev_property_add_legacy(DeviceState *de=
v, Property *prop,
>>      }
>>=20=20
>>      name =3D g_strdup_printf("legacy-%s", prop->name);
>> -    object_property_add(OBJECT(dev), name, "str",
>> +    object_property_add(OBJECT(dev), name, "string",
>>                          prop->info->print ? qdev_get_legacy_property : =
prop->info->get,
>>                          NULL,
>>                          NULL,
>> @@ -711,6 +711,7 @@ void qdev_property_add_static(DeviceState *dev, Prop=
erty *prop,
>>  {
>>      Error *local_err =3D NULL;
>>      Object *obj =3D OBJECT(dev);
>> +    const char *proptype;
>>=20=20
>>      if (prop->info->create) {
>>          prop->info->create(obj, prop, &local_err);
>> @@ -723,7 +724,11 @@ void qdev_property_add_static(DeviceState *dev, Pro=
perty *prop,
>>          if (!prop->info->get && !prop->info->set) {
>>              return;
>>          }
>> -        object_property_add(obj, prop->name, prop->info->name,
>> +        proptype =3D prop->info->name;
>> +        if (0 =3D=3D strncmp(proptype, "str", 3)) {
>> +            proptype =3D "string";
>> +        }
>> +        object_property_add(obj, prop->name, proptype,
>>                              prop->info->get, prop->info->set,
>>                              prop->info->release,
>>                              prop, &local_err);
>> --=20
>> 2.11.0

Can you convince us that you got all the sources of "str" in qom-list?

Taking a step back: the type names are a merry "pass the first string
that crosses your mind" game for developers to play.  Are there more
inconsistencies?  How can we fix them?  How can we avoid having them
creep back?

I promised to track down uses of PropertyInfo member @name for you:

(1) make_device_property_info() uses it to initialize an
    ObjectPropertyInfo's type name.  Visible as result of qom-list,
    device-list-properties, qom-list-properties.  Its specification in
    misc.json reads:

# @type: the type of the property.  This will typically come in one of four
#        forms:
#
#        1) A primitive type such as 'u8', 'u16', 'bool', 'str', or 'double=
'.
#           These types are mapped to the appropriate JSON type.
#
#        2) A child type in the form 'child<subtype>' where subtype is a qd=
ev
#           device type name.  Child properties create the composition tree.
#
#        3) A link type in the form 'link<subtype>' where subtype is a qdev
#           device type name.  Link properties form the device model graph.

  This makes (ill-specified!) primitive type names ABI, unlike QMP
  schema introspection.

  Note the documentation mentions 'str', but not 'string'.

(2) set_prop_arraylen(), qdev_property_add_static() pass it to
    object_property_add() as type name, which puts it into
    ObjectProperty member @type.  I lack the time to figure out how
    that's used right now.

Due to (1), changing qdev_prop_string.name would be an ABI break.  It's
a problematic corner of the ABI (to put it politely), but it's what we
have.  Before we discuss whether we can break it anyway, we'd have to
figure out whether and how (2) impacts ABI.

Actually, any fix making qom-list use either 'str' or 'string'
consistently is an ABI break of sorts.  We could declare it a bug fix,
though.

What a steaming pile of ...
