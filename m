Received: from eggs.gnu.org ([2001:4830:134:3::10]:44334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d8mkb-0007Oi-SB
	for qemu-devel@nongnu.org; Thu, 11 May 2017 07:59:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d8mkS-0007cj-QM
	for qemu-devel@nongnu.org; Thu, 11 May 2017 07:59:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:14023)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d8mkS-0007c1-HR
	for qemu-devel@nongnu.org; Thu, 11 May 2017 07:59:12 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 52567C04B311
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 11:59:10 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
	<20170509173559.31598-2-marcandre.lureau@redhat.com>
	<53e35958-82ee-5d90-6c55-7a126dc9108f@redhat.com>
Date: Thu, 11 May 2017 13:59:06 +0200
In-Reply-To: <53e35958-82ee-5d90-6c55-7a126dc9108f@redhat.com> (Eric Blake's
	message of "Tue, 9 May 2017 13:40:49 -0500")
Message-ID: <87tw4rwqnp.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/17] qdev: remove PropertyInfo.qtype field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

Cc Paolo, because I have a question for him at the end.

Eric Blake <eblake@redhat.com> writes:

> On 05/09/2017 12:35 PM, Marc-Andr=C3=A9 Lureau wrote:
>> Remove dependency on qapi qtype, replace a field by a few helper
>> functions to determine the default value type (introduced in commit
>> 4f2d3d7).
>>=20
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  include/hw/qdev-core.h       |  1 -
>>  include/hw/qdev-properties.h |  5 -----
>>  hw/core/qdev.c               | 32 ++++++++++++++++++++++++++------
>>  3 files changed, 26 insertions(+), 12 deletions(-)
>>=20
>> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
>> index 4bf86b0ad8..0f21a500cd 100644
>> --- a/include/hw/qdev-core.h
>> +++ b/include/hw/qdev-core.h
>> @@ -225,7 +225,6 @@ struct Property {
>>      PropertyInfo *info;
>>      ptrdiff_t    offset;
>>      uint8_t      bitnr;
>> -    QType        qtype;
>>      int64_t      defval;
>>      int          arrayoffset;
>>      PropertyInfo *arrayinfo;

As we'll see in the rest of the patch, member qtype is only used by
qdev_property_add_static().  It has nothing to do with QObject there, it
merely helps sorting properties into buckets "uninteresting", "boolean",
"enumeration", "integer".

>> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
>> index 1d69fa7a8f..16d5d0629b 100644
>> --- a/include/hw/qdev-properties.h
>> +++ b/include/hw/qdev-properties.h
>> @@ -42,7 +42,6 @@ extern PropertyInfo qdev_prop_arraylen;
    #define DEFINE_PROP_DEFAULT(_name, _state, _field, _defval, _prop, _typ=
e) { \
            .name      =3D (_name),                                        =
   \
>>          .info      =3D &(_prop),                                       =
   \
>>          .offset    =3D offsetof(_state, _field)                        =
   \
>>              + type_check(_type,typeof_field(_state, _field)),          =
 \
>> -        .qtype     =3D QTYPE_QINT,                                     =
   \
>>          .defval    =3D (_type)_defval,                                 =
   \
>>          }
>>  #define DEFINE_PROP_BIT(_name, _state, _field, _bit, _defval) {  \
>> @@ -51,7 +50,6 @@ extern PropertyInfo qdev_prop_arraylen;
    #define DEFINE_PROP_BIT(_name, _state, _field, _bit, _defval) {  \
            .name      =3D (_name),                                    \
            .info      =3D &(qdev_prop_bit),                           \
>>          .bitnr    =3D (_bit),                                      \
>>          .offset    =3D offsetof(_state, _field)                    \
>>              + type_check(uint32_t,typeof_field(_state, _field)), \
>> -        .qtype     =3D QTYPE_QBOOL,                                \
>>          .defval    =3D (bool)_defval,                              \
>>          }
>>  #define DEFINE_PROP_BIT64(_name, _state, _field, _bit, _defval) {      =
 \
>> @@ -60,7 +58,6 @@ extern PropertyInfo qdev_prop_arraylen;
    #define DEFINE_PROP_BIT64(_name, _state, _field, _bit, _defval) {      =
 \
            .name      =3D (_name),                                        =
   \
            .info      =3D &(qdev_prop_bit64),                             =
   \
>>          .bitnr    =3D (_bit),                                          =
   \
>>          .offset    =3D offsetof(_state, _field)                        =
   \
>>              + type_check(uint64_t, typeof_field(_state, _field)),      =
 \
>> -        .qtype     =3D QTYPE_QBOOL,                                    =
   \
>>          .defval    =3D (bool)_defval,                                  =
   \
>>          }
>>=20=20
>> @@ -69,7 +66,6 @@ extern PropertyInfo qdev_prop_arraylen;
    #define DEFINE_PROP_BOOL(_name, _state, _field, _defval) {       \
            .name      =3D (_name),                                    \
>>          .info      =3D &(qdev_prop_bool),                          \
>>          .offset    =3D offsetof(_state, _field)                    \
>>              + type_check(bool, typeof_field(_state, _field)),    \
>> -        .qtype     =3D QTYPE_QBOOL,                                \
>>          .defval    =3D (bool)_defval,                              \
>>          }
>>=20=20
>> @@ -105,7 +101,6 @@ extern PropertyInfo qdev_prop_arraylen;>
    #define DEFINE_PROP_ARRAY(_name, _state, _field,                       =
 \
                              _arrayfield, _arrayprop, _arraytype) {       =
 \
            .name =3D (PROP_ARRAY_LEN_PREFIX _name),                       =
   \
            .info =3D &(qdev_prop_arraylen),                               =
   \
>>          .offset =3D offsetof(_state, _field)                           =
   \
>>              + type_check(uint32_t, typeof_field(_state, _field)),      =
 \
>> -        .qtype =3D QTYPE_QINT,                                         =
   \
>>          .arrayinfo =3D &(_arrayprop),                                  =
   \
>>          .arrayfieldsize =3D sizeof(_arraytype),                        =
   \
>>          .arrayoffset =3D offsetof(_state, _arrayfield),                =
   \

Note for later:

* Member qtype can be QTYPE_QINT, QTYPE_QBOOL or zero (no initializer),
  i.e. QTYPE_NONE.

* Properties defined with DEFINE_PROP_BIT(), DEFINE_PROP_BIT64() and
  DEFINE_PROP_BOOL() are QTYPE_QBOOL.  These are all boolean properties.
  I didn't check whether the converse is also true, i.e. all boolean
  properties are defined that way.

* Properties defined with DEFINE_PROP_DEFAULT() and DEFINE_PROP_ARRAY()
  are QTYPE_QINT.  On closer examination, the former are all integer and
  enumeration properties, and the latter are all arrays of integer.  I
  didn't check whether the converse is also true.

>> +++ b/hw/core/qdev.c
>> @@ -755,6 +755,30 @@ static void qdev_property_add_legacy(DeviceState *d=
ev, Property *prop,
>>      g_free(name);
>>  }
>>=20=20
>> +static bool prop_info_is_bool(const PropertyInfo *info)
>> +{
>> +    return info =3D=3D &qdev_prop_bit
>> +        || info =3D=3D &qdev_prop_bit64
>> +        || info =3D=3D &qdev_prop_bool;
>> +}
>
> I guess we can expand these helpers if we add more property types later.
>
>> +
>> +static bool prop_info_is_int(const PropertyInfo *info)
>> +{
>> +    return info =3D=3D &qdev_prop_uint8
>> +        || info =3D=3D &qdev_prop_uint16
>> +        || info =3D=3D &qdev_prop_uint32
>> +        || info =3D=3D &qdev_prop_int32
>> +        || info =3D=3D &qdev_prop_uint64
>
> Interesting dissimilarity between existing types, but not the fault of
> your patch.
>
>> +        || info =3D=3D &qdev_prop_size
>> +        || info =3D=3D &qdev_prop_pci_devfn
>
> Okay so far.
>
>> +        || info =3D=3D &qdev_prop_on_off_auto
>> +        || info =3D=3D &qdev_prop_losttickpolicy
>> +        || info =3D=3D &qdev_prop_blockdev_on_error
>> +        || info =3D=3D &qdev_prop_bios_chs_trans
>
> Aren't these four enums rather than ints?
>
>> +        || info =3D=3D &qdev_prop_blocksize
>> +        || info =3D=3D &qdev_prop_arraylen;
>> +}
>> +
>
>> @@ -794,16 +818,12 @@ void qdev_property_add_static(DeviceState *dev, Pr=
operty *prop,
>>                                      prop->info->description,
>>                                      &error_abort);
>>=20=20
>> -    if (prop->qtype =3D=3D QTYPE_NONE) {
>> -        return;
>> -    }
>> -
>> -    if (prop->qtype =3D=3D QTYPE_QBOOL) {
>> +    if (prop_info_is_bool(prop->info)) {
>>          object_property_set_bool(obj, prop->defval, prop->name, &error_=
abort);
>>      } else if (prop->info->enum_table) {
>>          object_property_set_str(obj, prop->info->enum_table[prop->defva=
l],
>>                                  prop->name, &error_abort);
>> -    } else if (prop->qtype =3D=3D QTYPE_QINT) {
>> +    } else if (prop_info_is_int(prop->info)) {
>>          object_property_set_int(obj, prop->defval, prop->name, &error_a=
bort);

Old code:

* Property is either uninteresting (QTYPE_NONE), boolean (QTYPE_QBOOL),
  integer, enumeration or array of integer (QTYPE_QINT)

* If uninteresting (QTYPE_NONE), do nothing.

* If boolean (QTYPE_QBOOL), object_property_set_bool()

* If enumeration (QTYPE_QINT and info->enum_table),
  object_property_set_str()

* If integer or array of integer (QTYPE_QINT and not info->enum_table),
  object_property_set_int()

The patch drops the check of QTYPE_NONE.  No change as long as
info->enum_table implies QTYPE_QINT.  Plausible, but we need to
double-check.

> So enum_table has priority over prop_info_is_int(), in which case, the
> four types I pointed out as being enums will still use set_str() rather
> than set_int().

Yes.

I'm not sure I fully understand this code's logic.  It's from Paolo's
commit 4f2d3d7, moved here in commit fdae245.

> I'm not necessarily sold on this patch - previously, the type was local
> to the declaration of the struct (you could tell by reading
> qdev_prop_bit that it was a boolean type); now the type is remote (you
> have to hunt elsewhere to see how the property is categorized).  I'm not
> rejecting it (I see how getting rid of a dependency on QType makes it
> easier for the rest of the series to change QType underpinnings), but
> wonder if that is a strong enough justification.
>
> But if we DO keep it, you'll want a v2 that cleans up the
> prop_info_is_int() impedance mismatch.

The patch cleans up a mild abuse of QType for another purpose.  I like
that.

What I don't like is enumerating PropertyInfo in helpers.  A relatively
straightforward way to avoid this would be moving the part of
qdev_property_add_static() that varies between properties into a new
PropertyInfo method.  Assumes that *all* instances of the same
PropertyInfo should behave the same.  Paolo, is that the case?
