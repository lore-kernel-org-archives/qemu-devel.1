Received: from eggs.gnu.org ([2001:4830:134:3::10]:46940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXRWK-00060n-KG
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 08:59:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXRWD-0001M3-SE
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 08:59:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43518)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gXRWD-0001Jz-BM
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 08:59:13 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181208111606.8505-1-marcandre.lureau@redhat.com>
	<20181208111606.8505-23-marcandre.lureau@redhat.com>
	<874lbkoxy8.fsf@dusky.pond.sub.org>
	<CAMxuvaxu_G62E0Gg677FvCapiswJ+6i3wqzrg78qOVtsizHuVg@mail.gmail.com>
Date: Thu, 13 Dec 2018 14:59:07 +0100
In-Reply-To: <CAMxuvaxu_G62E0Gg677FvCapiswJ+6i3wqzrg78qOVtsizHuVg@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 11 Dec 2018
	20:07:49 +0400")
Message-ID: <87ftv1r0ic.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v7 22/27] qapi: add 'If:' condition
 to enum values documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: "Armbruster, Markus" <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Hi
>
> On Tue, Dec 11, 2018 at 8:00 PM Markus Armbruster <armbru@redhat.com> wro=
te:
>>
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>
>> > Use a common function to generate the "If:..." line.
>> >
>> > While at it, get rid of the existing \n\n (no idea why it was
>> > there). Use a line-break in member description, this seems to look
>> > slightly better in the plaintext version.
>>
>> Where exactly in the patch is this done?
>
> -    if ifcond:
> -        body +=3D '\n\n@b{If:} @code{%s}' % ", ".join(ifcond)
> +    body +=3D texi_if(ifcond, suffix=3D'')

Thanks.  I suspected that much, but wasn't sure.

> See also doc-good.texi output
>
>>
>> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> > ---
>> >  scripts/qapi/doc.py             | 24 +++++++++++++++---------
>> >  tests/qapi-schema/doc-good.json |  4 +++-
>> >  tests/qapi-schema/doc-good.out  |  1 +
>> >  tests/qapi-schema/doc-good.texi |  2 +-
>> >  4 files changed, 20 insertions(+), 11 deletions(-)
>> >
>> > diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
>> > index 76cb186ff9..2133ded47e 100755
>> > --- a/scripts/qapi/doc.py
>> > +++ b/scripts/qapi/doc.py
>> > @@ -126,19 +126,26 @@ def texi_body(doc):
>> >      return texi_format(doc.body.text)
>> >
>> >
>> > -def texi_enum_value(value):
>> > +def texi_if(ifcond, prefix=3D'\n', suffix=3D'\n'):
>> > +    """Format the #if condition"""
>> > +    return '%s@b{If:} @code{%s}%s' % (
>> > +        prefix, ', '.join(ifcond), suffix) if ifcond else ''
>>
>> I like the ternary operator, but I nevertheless think this function is
>> easier to read as
>>
>>        if not ifcond:
>>            return ''
>>        return '%s@b{If:} @code{%s}%s' % (prefix, ', '.join(ifcond), suff=
ix)
>>
>
> No difference to me, sure
>
>> > +
>> > +
>> > +def texi_enum_value(value, desc, suffix=3D''):
>> >      """Format a table of members item for an enumeration value"""
>> > -    return '@item @code{%s}\n' % value.name
>> > +    return '@item @code{%s}\n%s%s' % (
>> > +        value.name, desc, texi_if(value.ifcond, prefix=3D'@*'))
>>
>> Do you ignore suffix intentionally?
>
> yes

That's kind of surprising, until you pry open the abstraction and
realize that we reach this one only from the first call of member_func()
below, which ...

>>
>> >
>> >
>> > -def texi_member(member, suffix=3D''):
>> > +def texi_member(member, desc=3D'', suffix=3D''):
>> >      """Format a table of members item for an object type member"""
>> >      typ =3D member.type.doc_type()
>> >      membertype =3D ': ' + typ if typ else ''
>> > -    return '@item @code{%s%s}%s%s\n' % (
>> > +    return '@item @code{%s%s}%s%s\n%s' % (
>> >          member.name, membertype,
>> >          ' (optional)' if member.optional else '',
>> > -        suffix)
>> > +        suffix, desc)
>> >
>> >
>> >  def texi_members(doc, what, base, variants, member_func):
>> > @@ -155,7 +162,7 @@ def texi_members(doc, what, base, variants, member=
_func):
>> >              desc =3D 'One of ' + members_text + '\n'
>> >          else:
>> >              desc =3D 'Not documented\n'
>> > -        items +=3D member_func(section.member) + desc
>> > +        items +=3D member_func(section.member, desc)
>>
>> Here, you pass a @desc argument, but no @suffix.
>>
>> @member_func is either texi_enum_value() or texi_member().  Works.

... doesn't pass @suffix.  So @suffix is empty when we ignore it.

>> >      if base:
>> >          items +=3D '@item The members of @code{%s}\n' % base.doc_type=
()
>> >      if variants:
>> > @@ -165,7 +172,7 @@ def texi_members(doc, what, base, variants, member=
_func):
>> >              if v.type.is_implicit():
>> >                  assert not v.type.base and not v.type.variants
>> >                  for m in v.type.local_members:
>> > -                    items +=3D member_func(m, when)
>> > +                    items +=3D member_func(m, suffix=3Dwhen)
>>
>> Here, you pass a @suffix argument, but no @desc.
>>
>> texi_enum_value() would choke on that, but it can't occur here, because
>> enums have no variants.
>>
>> Still, I'd prefer texi_enum_value() and texi_member() to have the exact
>> same signature.
>
> OK (not sure what is the more pythonic way)

I suspect there's a clean solution struggling to get out.  But I can't
grasp it yet.

>>
>> >              else:
>> >                  items +=3D '@item The members of @code{%s}%s\n' % (
>> >                      v.type.doc_type(), when)
>> > @@ -185,8 +192,7 @@ def texi_sections(doc, ifcond):
>> >              body +=3D texi_example(section.text)
>> >          else:
>> >              body +=3D texi_format(section.text)
>> > -    if ifcond:
>> > -        body +=3D '\n\n@b{If:} @code{%s}' % ", ".join(ifcond)
>> > +    body +=3D texi_if(ifcond, suffix=3D'')
>> >      return body
>> >
>> >
[...]
