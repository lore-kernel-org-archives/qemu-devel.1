Received: from eggs.gnu.org ([2001:4830:134:3::10]:40400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1erMgD-0005vv-NH
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:47:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1erMgA-0005RO-IH
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:47:21 -0500
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:37122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1erMgA-0005RA-78
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:47:18 -0500
Received: by mail-io0-x242.google.com with SMTP id d71so6811117iog.4
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 03:47:17 -0800 (PST)
References: <20180226082259.40293-1-aik@ozlabs.ru>
	<20180301035910.GC2264@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <ae263ebe-d0d2-3b1d-b2ac-200772eb9154@ozlabs.ru>
Date: Thu, 1 Mar 2018 22:47:10 +1100
MIME-Version: 1.0
In-Reply-To: <20180301035910.GC2264@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="X5cfR2jBuUK3IS7hsl4bnTjsViH9LFp3A"
Subject: Re: [Qemu-devel] [PATCH qemu v2] qmp: Add qom-list-properties to
 list QOM object properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Andrea Bolognani <abologna@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--X5cfR2jBuUK3IS7hsl4bnTjsViH9LFp3A
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>
Message-ID: <ae263ebe-d0d2-3b1d-b2ac-200772eb9154@ozlabs.ru>
Subject: Re: [PATCH qemu v2] qmp: Add qom-list-properties to list QOM object
 properties
References: <20180226082259.40293-1-aik@ozlabs.ru>
 <20180301035910.GC2264@umbus.fritz.box>
In-Reply-To: <20180301035910.GC2264@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/03/18 14:59, David Gibson wrote:
> On Mon, Feb 26, 2018 at 07:22:59PM +1100, Alexey Kardashevskiy wrote:
>> There is already 'device-list-properties' which does most of the job,
>> however it does not handle everything returned by qom-list-types such
>> as machines as they inherit directly from TYPE_OBJECT and not TYPE_DEV=
ICE.
>> It does not handle abstract classes either.
>>
>> This adds a new qom-list-properties command which prints properties
>> of a specific class and its instance. It is pretty much a simplified c=
opy
>> of the device-list-properties handler.
>>
>> Since it creates an object instance, device properties should appear
>> in the output as they are copied to QOM properties at the instance_ini=
t
>> hook.
>>
>> This adds a object_class_property_iter_init() helper to allow class
>> properties enumeration uses it in the new QMP command to allow propert=
ies
>> listing for abstract classes.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>> Changes:
>> v2:
>> * added abstract classes support, now things like "pci-device" or
>> "spapr-machine" show properties, previously these would produce
>> an "abstract class" error
>> ---
>>  qapi-schema.json     | 29 +++++++++++++++++++++++++++++
>>  include/qom/object.h | 16 ++++++++++++++++
>>  qmp.c                | 49 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>>  qom/object.c         |  7 +++++++
>>  4 files changed, 101 insertions(+)
>>
>> diff --git a/qapi-schema.json b/qapi-schema.json
>> index 0262b9f..fa5f189 100644
>> --- a/qapi-schema.json
>> +++ b/qapi-schema.json
>> @@ -1455,6 +1455,35 @@
>>    'returns': [ 'DevicePropertyInfo' ] }
>> =20
>>  ##
>> +# @QOMPropertyInfo:
>> +#
>> +# Information about object properties.
>> +#
>> +# @name: the name of the property
>> +# @type: the typename of the property
>> +# @description: if specified, the description of the property.
>> +#
>> +# Since: 2.12
>> +##
>> +{ 'struct': 'QOMPropertyInfo',
>> +  'data': { 'name': 'str', 'type': 'str', '*description': 'str' } }
>=20
> So, this has identical contents to DevicePropertyInfo, and is very
> similar to ObjectPropertyInfo.  Is there any way we could consolidate
> those types?

Sure, I can get rid of DevicePropertyInfo in favour of QOMPropertyInfo, I=

am just not sure if this typename is visible anywhere in the QMP protocol=
=2E
I'll post v3 in minutes.


>=20
>> +##
>> +# @qom-list-properties:
>> +#
>> +# List properties associated with a QOM object.
>> +#
>> +# @typename: the type name of an object
>> +#
>> +# Returns: a list of QOMPropertyInfo describing object properties
>> +#
>> +# Since: 2.12
>> +##
>> +{ 'command': 'qom-list-properties',
>> +  'data': { 'typename': 'str'},
>> +  'returns': [ 'QOMPropertyInfo' ] }
>> +
>> +##
>>  # @xen-set-global-dirty-log:
>>  #
>>  # Enable or disable the global dirty log mode.
>> diff --git a/include/qom/object.h b/include/qom/object.h
>> index dc73d59..ef07d78 100644
>> --- a/include/qom/object.h
>> +++ b/include/qom/object.h
>> @@ -1017,6 +1017,22 @@ void object_property_iter_init(ObjectPropertyIt=
erator *iter,
>>                                 Object *obj);
>> =20
>>  /**
>> + * object_class_property_iter_init:
>> + * @klass: the class
>> + *
>> + * Initializes an iterator for traversing all properties
>> + * registered against an object class and all parent classes.
>> + *
>> + * It is forbidden to modify the property list while iterating,
>> + * whether removing or adding properties.
>> + *
>> + * This can be used on abstract classes as it does not create a tempo=
rary
>> + * instance.
>> + */
>> +void object_class_property_iter_init(ObjectPropertyIterator *iter,
>> +                                     ObjectClass *klass);
>> +
>> +/**
>>   * object_property_iter_next:
>>   * @iter: the iterator instance
>>   *
>> diff --git a/qmp.c b/qmp.c
>> index 793f6f3..151d3d7 100644
>> --- a/qmp.c
>> +++ b/qmp.c
>> @@ -576,6 +576,55 @@ DevicePropertyInfoList *qmp_device_list_propertie=
s(const char *typename,
>>      return prop_list;
>>  }
>> =20
>> +QOMPropertyInfoList *qmp_qom_list_properties(const char *typename,
>> +                                             Error **errp)
>> +{
>> +    ObjectClass *klass;
>> +    Object *obj =3D NULL;
>> +    ObjectProperty *prop;
>> +    ObjectPropertyIterator iter;
>> +    QOMPropertyInfoList *prop_list =3D NULL;
>> +
>> +    klass =3D object_class_by_name(typename);
>> +    if (klass =3D=3D NULL) {
>> +        error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
>> +                  "Class '%s' not found", typename);
>> +        return NULL;
>> +    }
>> +
>> +    klass =3D object_class_dynamic_cast(klass, TYPE_OBJECT);
>> +    if (klass =3D=3D NULL) {
>> +        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "typename", TY=
PE_OBJECT);
>> +        return NULL;
>> +    }
>> +
>> +    if (object_class_is_abstract(klass)) {
>> +        object_class_property_iter_init(&iter, klass);
>=20
> I like the idea of adding abstract classes in principle, but I'm a
> little concerned about the effect of this in practice, because it only
> lists class properties.
>> Although nearly all properties in qemu *should* be class properties,
> they're nearly all defined as instance properties in practice.  AFAICT
> this is just because most people didn't get the memo on class
> properties and how to use them.
>=20
> Just listing class properties in general might be ok - it would
> encourage people to move things to class properties if they should
> be.  However listing class properties in some cases and all properties
> in other sounds like a recipe for confusion.

This lists all properties one can get for a specific type. For an abstrac=
t
class, an instance cannot be created, hence only class properties are
listed. Quite straight forward imho.




>> +    } else {
>> +        obj =3D object_new(typename);
>> +        object_property_iter_init(&iter, obj);
>> +    }
>> +    while ((prop =3D object_property_iter_next(&iter))) {
>> +        QOMPropertyInfo *info;
>> +        QOMPropertyInfoList *entry;
>> +
>> +        info =3D g_malloc0(sizeof(*info));
>> +        info->name =3D g_strdup(prop->name);
>> +        info->type =3D g_strdup(prop->type);
>> +        info->has_description =3D !!prop->description;
>> +        info->description =3D g_strdup(prop->description);
>> +
>> +        entry =3D g_malloc0(sizeof(*entry));
>> +        entry->value =3D info;
>> +        entry->next =3D prop_list;
>> +        prop_list =3D entry;
>> +    }
>> +
>> +    object_unref(obj);
>> +
>> +    return prop_list;
>> +}
>> +
>>  CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
>>  {
>>      return arch_query_cpu_definitions(errp);
>> diff --git a/qom/object.c b/qom/object.c
>> index 5dcee46..e7978bd 100644
>> --- a/qom/object.c
>> +++ b/qom/object.c
>> @@ -1037,6 +1037,13 @@ ObjectProperty *object_property_iter_next(Objec=
tPropertyIterator *iter)
>>      return val;
>>  }
>> =20
>> +void object_class_property_iter_init(ObjectPropertyIterator *iter,
>> +                                     ObjectClass *klass)
>> +{
>> +    g_hash_table_iter_init(&iter->iter, klass->properties);
>> +    iter->nextclass =3D klass;
>> +}
>> +
>>  ObjectProperty *object_class_property_find(ObjectClass *klass, const =
char *name,
>>                                             Error **errp)
>>  {
>=20


--=20
Alexey


--X5cfR2jBuUK3IS7hsl4bnTjsViH9LFp3A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEZSrPibrORRTHQ99dhhM92CvBILkFAlqX6D4OHGFpa0Bvemxh
YnMucnUACgkQhhM92CvBILk5hg/8DZdpUlENMOXq4EWJP86wlPW0DC6FMrjIq1fm
gX1u1LuzUerd/3W2c764Oi/uWAC64x9M0XJhKAyZ4HungV96JQ+5vy5GOOf0BJU+
o0zwATJNKiUQcO+NgX0Ohi/oc3MWDNRGiwnCZAc1lmyxh2WWwflltIMAZPV/3lIh
3aTgMmq1AoKXIf6PNPOC4WBq2eH36h1AbVYMIEqupSfFpb3htoM5559Onq61/A1D
16lrvDg+bc5sXgqBhyTTwfEb2uSlJIS2otetRPoCbciLZodGL+LhvwhLBkX43qJ+
+ixVRwgiWhoXUiU+PkLxHhPMFi0ADI4I4eYrcEMN149Kqkflve/Ah4KptuE+YA3w
B/Baz3w/GJbiLfD21jRqgYuD7b8RdzGd8xFqebjcMHakaUyP3RnnzYi7Fzin1erj
07pLDfAVJfdtVyH+jG0UiWJe7aDy08H680mgHC4GEFB2/5FQLe2zNddsCM8hPJuO
F/3r5iVvMhrSOdlMaNFqP2HS05+gurYSownv/1EIQjxuNRXG2GGFmcqwlKA+73Ib
5zad8AfWag8EZNXZYfwlFIrnVVvWOrggeNLDOG5zuCEKHguxyTQlx9/HDbzILHs1
WszwP7FSCfxNWQcmjhh4W42JEyC01Z+tGE2uKVxRQqpfWqP4ttq2kQJ1dzm4+JwL
kWOYq5I=
=v60/
-----END PGP SIGNATURE-----

--X5cfR2jBuUK3IS7hsl4bnTjsViH9LFp3A--
