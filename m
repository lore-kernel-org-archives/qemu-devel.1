Received: from eggs.gnu.org ([2001:4830:134:3::10]:56230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dT8VQ-0001H0-Tk
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 11:15:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dT8VN-0000QL-Ou
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 11:15:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dT8VN-0000Pw-EA
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 11:15:45 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170601124143.10915-1-marcandre.lureau@redhat.com>
	<20170601124143.10915-2-marcandre.lureau@redhat.com>
	<874luq6jmr.fsf@dusky.pond.sub.org>
	<CAJ+F1CJmUCFx+pq1mE8pkehCTM-ko_F-LXfdp0ZnXoRHxJW_YQ@mail.gmail.com>
Date: Thu, 06 Jul 2017 17:15:41 +0200
In-Reply-To: <CAJ+F1CJmUCFx+pq1mE8pkehCTM-ko_F-LXfdp0ZnXoRHxJW_YQ@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Thu, 6 Jul 2017
	05:11:53 -0700")
Message-ID: <87mv8hha02.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/2] qapi: add location comment for
 generated types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Thu, Jul 6, 2017 at 10:43 AM Markus Armbruster <armbru@redhat.com> wro=
te:
>
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>
>> > This may help to find where the origin of the type was declared in the
>> > json (when greping isn't easy enough).
>> >
>> > Generates the following kind of C comment before types:
>> >
>> >   /* /home/elmarco/src/qemu/qapi/introspect.json:94 */
>> >   typedef struct SchemaInfo SchemaInfo;
>>
>> Can we do relative file names?  I.e. just qapi/introspect.json.
>>
>
> We could, but relative to $srcdir or $builddir? I think absolute path
> avoids some potential confusion.

Source files are always relative to $srcdir.

Absolute paths are a total pain when you diff files generated in
separate trees.

>> Would such comments be useful for things other than typedefs?
>>
>
> Certainly it could, however I just needed it for typedef, didn't bother
> adding it for the rest.

Fair enough.

>> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> > ---
>> >  scripts/qapi.py       | 12 +++++++++---
>> >  scripts/qapi-event.py |  2 +-
>> >  scripts/qapi-types.py | 18 +++++++++---------
>> >  3 files changed, 19 insertions(+), 13 deletions(-)
>> >
>> > diff --git a/scripts/qapi.py b/scripts/qapi.py
>> > index d37a6157e0..7f9935eec0 100644
>> > --- a/scripts/qapi.py
>> > +++ b/scripts/qapi.py
>> > @@ -1852,15 +1852,21 @@ const char *const %(c_name)s_lookup[] =3D {
>> >      return ret
>> >
>> >
>> > -def gen_enum(name, values, prefix=3DNone):
>> > +def build_src_loc_comment(info):
>> > +    if info:
>> > +        return '\n/* %s:%d */' % (info['file'], info['line'])
>>
>> Leading instead of trailing newline, hmm.  Let's see how it works out.
>>
>> > +    else:
>> > +        return ''
>>
>> Let's drop the else: line.
>>
>
> ok
>
>
>>
>> > +
>> > +def gen_enum(info, name, values, prefix=3DNone):
>>
>> Make that name, info, values, ... for consistency with other functions
>> taking both name and info.  More of the same below.
>>
>>
> ok
>
>
>> >      # append automatically generated _MAX value
>> >      enum_values =3D values + ['_MAX']
>> >
>> >      ret =3D mcgen('''
>> > -
>> > +%(comment)s
>>
>> Loses the blank line when not info.
>>
>> >  typedef enum %(c_name)s {
>> >  ''',
>> > -                c_name=3Dc_name(name))
>> > +                c_name=3Dc_name(name), comment=3Dbuild_src_loc_commen=
t(info))
>> >
>> >      i =3D 0
>> >      for value in enum_values:
>> > diff --git a/scripts/qapi-event.py b/scripts/qapi-event.py
>> > index bcbef1035f..cf5e282011 100644
>> > --- a/scripts/qapi-event.py
>> > +++ b/scripts/qapi-event.py
>> > @@ -159,7 +159,7 @@ class QAPISchemaGenEventVisitor(QAPISchemaVisitor):
>> >          self._event_names =3D []
>> >
>> >      def visit_end(self):
>> > -        self.decl +=3D gen_enum(event_enum_name, self._event_names)
>> > +        self.decl +=3D gen_enum(None, event_enum_name, self._event_na=
mes)
>> >          self.defn +=3D gen_enum_lookup(event_enum_name, self._event_n=
ames)
>> >          self._event_names =3D None
>> >
>> > diff --git a/scripts/qapi-types.py b/scripts/qapi-types.py
>> > index b45e7b5634..9c8a3e277b 100644
>> > --- a/scripts/qapi-types.py
>> > +++ b/scripts/qapi-types.py
>> > @@ -19,12 +19,12 @@ from qapi import *
>> >  objects_seen =3D set()
>> >
>> >
>> > -def gen_fwd_object_or_array(name):
>> > +def gen_fwd_object_or_array(info, name):
>> >      return mcgen('''
>> > -
>> > +%(comment)s
>>
>> Likewise.
>>
>> I think we should drop the newline from build_src_loc_comment()'s value,
>> and keep the blank line before its two uses.
>>
>>
> And you get an extra empty line if info is None. I don't mind.

I misread your code.  The leading '\n' is kind of weird, but it works.

>                                                                Other opti=
on
> is to just add \n in the else case in build_src_loc_comment()

Could work, too.  Perhaps even something like '/* built-in */\n'.

[...]
