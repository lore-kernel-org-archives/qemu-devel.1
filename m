Received: from eggs.gnu.org ([2001:4830:134:3::10]:57962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqgXR-000317-Up
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:47:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqgXQ-0006zn-PQ
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:47:29 -0500
References: <20180224154033.29559-1-mreitz@redhat.com>
	<20180224154033.29559-4-mreitz@redhat.com>
	<abd5ed7a-d5ee-028c-1cd5-208161f88beb@redhat.com>
	<fb3756be-e002-8b47-921f-80a5ce332721@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <01bf42f6-971d-1a28-eeb4-61063ae62bd7@redhat.com>
Date: Tue, 27 Feb 2018 08:47:20 -0600
MIME-Version: 1.0
In-Reply-To: <fb3756be-e002-8b47-921f-80a5ce332721@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/7] qapi: Replace qobject_to_X(o) by
 qobject_to(o, X)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Alberto Garcia <berto@igalia.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 02/26/2018 06:01 AM, Max Reitz wrote:

>>> +++ b/block.c
>>> @@ -1457,7 +1457,7 @@ static QDict *parse_json_filename(const char
>>> *filename, Error **errp)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>  =C2=A0 -=C2=A0=C2=A0=C2=A0 options =3D qobject_to_qdict(options_obj)=
;
>>> +=C2=A0=C2=A0=C2=A0 options =3D qobject_to(options_obj, QDict);
>>
>> Bikeshedding - would it read any easier as:
>>
>> options =3D qobject_to(QDict, options_obj);
>>
>> ?=C2=A0 If so, your Coccinelle script can be touched up, and patch 2/7=
 swaps
>> argument order around, so it would be tolerable but still slightly
>> busywork to regenerate the series.=C2=A0 But I'm not strongly attached=
 to
>> either order, and so I'm also willing to take this as-is (especially
>> since that's less work), if no one else has a strong opinion that
>> swapping order would aid legibility.
>=20
> Well, same for me. :-)
>=20
> In a template/generic language, we'd write the type first (e.g.
> qobject_cast<QDict>(options_obj)).  But maybe we'd write the object
> first, too (e.g. options_obj.cast<QDict>()).  And the current order of
> the arguments follows the order in the name ("qobject" options_obj "to"
> QDict).  But maybe it's more natural to read it as "qobject to" QDict
> "applied to" options_obj.
>=20
> I don't know either.

Okay, after looking for existing uses of type names in macro calls, I see=
:

qemu/compiler.h:

#ifndef container_of
#define container_of(ptr, type, member) ({                      \
         const typeof(((type *) 0)->member) *__mptr =3D (ptr);     \
         (type *) ((char *) __mptr - offsetof(type, member));})
#endif

/* Convert from a base type to a parent type, with compile time=20
checking.  */
#ifdef __GNUC__
#define DO_UPCAST(type, field, dev) ( __extension__ ( { \
     char __attribute__((unused)) offset_must_be_zero[ \
         -offsetof(type, field)]; \
     container_of(dev, type, field);}))
#else
#define DO_UPCAST(type, field, dev) container_of(dev, type, field)
#endif

#define typeof_field(type, field) typeof(((type *)0)->field)


qapi/clone-visitor.h:

/*
  * Deep-clone QAPI object @src of the given @type, and return the result=
.
  *
  * Not usable on QAPI scalars (integers, strings, enums), nor on a
  * QAPI object that references the 'any' type.  Safe when @src is NULL.
  */
#define QAPI_CLONE(type, src)                                           \

/*
  * Copy deep clones of @type members from @src to @dst.
  *
  * Not usable on QAPI scalars (integers, strings, enums), nor on a
  * QAPI object that references the 'any' type.
  */
#define QAPI_CLONE_MEMBERS(type, dst, src)                              \


2 out of 3 macros in compiler.h put the type name first, and=20
container_of() puts it in the middle of 3.  It's even weirder because=20
DO_UPCAST(t, f, d) calls container_of(d, t, f), where the inconsistency=20
makes it a mental struggle to figure out how to read the two macros side=20
by side, compared to if we had just been consistent.  Meanwhile, all of=20
the macros in qapi put the type name first.

So at this point, I'm 70:30 in favor of doing the rename to have=20
qobject_to(type, obj) for consistency with majority of other macros that=20
take a type name (type names are already unusual as arguments to macros,=20
whether or not the macro is named with ALL_CAPS).  (Sorry, I know that=20
means more busy work for you, if you agree with my reasoning)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
