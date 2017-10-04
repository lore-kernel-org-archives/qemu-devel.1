Received: from eggs.gnu.org ([2001:4830:134:3::10]:57641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzhKI-0003AZ-RS
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:54:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzhKH-0001nv-P2
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:54:54 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:50500)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dzhKH-0001nS-Ib
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:54:53 -0400
Received: by mail-oi0-x243.google.com with SMTP id q4so1312565oic.7
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 03:54:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171002152552.27999-9-armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
	<20171002152552.27999-9-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 4 Oct 2017 12:54:50 +0200
Message-ID: <CAJ+F1CKsYfk=SEj_VP-SPuLCu8R9gba-WD7xDbmp+68+VWUYVA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 08/32] qapi: Simplify check_name()
 parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Mon, Oct 2, 2017 at 5:25 PM, Markus Armbruster <armbru@redhat.com> wrote=
:
> Replace flags @enum_member, @allow_optional by string @meta:
> 'member-enum' implies @enum_member, 'member-struct' implies
> @allow_optional.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  scripts/qapi.py | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
>
> diff --git a/scripts/qapi.py b/scripts/qapi.py
> index 248af89b0b..208010c241 100644
> --- a/scripts/qapi.py
> +++ b/scripts/qapi.py
> @@ -593,8 +593,7 @@ valid_name =3D re.compile(r'^(__[a-zA-Z0-9.-]+_)?'
>                          '[a-zA-Z][a-zA-Z0-9_-]*$')
>
>
> -def check_name(info, source, name, allow_optional=3DFalse,
> -               enum_member=3DFalse):
> +def check_name(info, source, name, meta):
>      global valid_name
>      membername =3D name
>
> @@ -602,12 +601,12 @@ def check_name(info, source, name, allow_optional=
=3DFalse,
>          raise QAPISemError(info, "%s requires a string name" % source)
>      if name.startswith('*'):
>          membername =3D name[1:]
> -        if not allow_optional:
> +        if meta !=3D 'member-struct':
>              raise QAPISemError(info, "%s does not allow optional name '%=
s'"
>                                 % (source, name))
>      # Enum members can start with a digit, because the generated C
>      # code always prefixes it with the enum name
> -    if enum_member and membername[0].isdigit():
> +    if meta =3D=3D 'member-enum' and membername[0].isdigit():
>          membername =3D 'D' + membername
>      # Reserve the entire 'q_' namespace for c_name(), and for 'q_empty'
>      # and 'q_obj_*' implicit type names.
> @@ -618,7 +617,7 @@ def check_name(info, source, name, allow_optional=3DF=
alse,
>
>  def add_name(name, info, meta, implicit=3DFalse):
>      global all_names
> -    check_name(info, "'%s'" % meta, name)
> +    check_name(info, "'%s'" % meta, name, meta)
>      # FIXME should reject names that differ only in '_' vs. '.'
>      # vs. '-', because they're liable to clash in generated C.
>      if name in all_names:
> @@ -667,8 +666,7 @@ def check_type(info, source, value, allow_array=3DFal=
se,
>
>      # value is a dictionary, check that each member is okay
>      for (key, arg) in value.items():
> -        check_name(info, "Member of %s" % source, key,
> -                   allow_optional=3Dallow_optional)
> +        check_name(info, "Member of %s" % source, key, 'member-struct')
>          if c_name(key, False) =3D=3D 'u' or c_name(key, False).startswit=
h('has_'):
>              raise QAPISemError(info, "Member of %s uses reserved name '%=
s'"
>                                 % (source, key))
> @@ -741,7 +739,7 @@ def check_union(expr, info):
>          # The value of member 'discriminator' must name a non-optional
>          # member of the base struct.
>          check_name(info, "Discriminator of flat union '%s'" % name,
> -                   discriminator)
> +                   discriminator, 'member-union')
>          discriminator_type =3D base_members.get(discriminator)
>          if not discriminator_type:
>              raise QAPISemError(info,
> @@ -760,7 +758,7 @@ def check_union(expr, info):
>      if len(members) =3D=3D 0:
>          raise QAPISemError(info, "Union '%s' cannot have empty 'data'" %=
 name)
>      for (key, value) in members.items():
> -        check_name(info, "Member of union '%s'" % name, key)
> +        check_name(info, "Member of union '%s'" % name, key, 'member-uni=
on')
>
>          # Each value must name a known type
>          check_type(info, "Member '%s' of union '%s'" % (key, name),
> @@ -794,7 +792,8 @@ def check_alternate(expr, info):
>                             "Alternate '%s' should have at least two bran=
ches "
>                             "in 'data'" % name)
>      for (key, value) in members.items():
> -        check_name(info, "Member of alternate '%s'" % name, key)
> +        check_name(info, "Member of alternate '%s'" % name, key,
> +                   'member-alternate')
>
>          # Ensure alternates have no type conflicts.
>          check_type(info, "Member '%s' of alternate '%s'" % (key, name),
> @@ -836,8 +835,7 @@ def check_enum(expr, info):
>          raise QAPISemError(info,
>                             "Enum '%s' requires a string for 'prefix'" % =
name)
>      for member in members:
> -        check_name(info, "Member of enum '%s'" % name, member,
> -                   enum_member=3DTrue)
> +        check_name(info, "Member of enum '%s'" % name, member, 'member-e=
num')
>
>
>  def check_struct(expr, info):
> --
> 2.13.6
>
>



--=20
Marc-Andr=C3=A9 Lureau
