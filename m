Received: from eggs.gnu.org ([2001:4830:134:3::10]:60935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gVafE-0000j6-U4
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:20:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gVaf3-0005fZ-RV
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:20:48 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37274)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gVaf3-0005ex-BA
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:20:41 -0500
Received: by mail-qk1-f194.google.com with SMTP id 131so3985072qkd.4
	for <qemu-devel@nongnu.org>; Sat, 08 Dec 2018 03:20:41 -0800 (PST)
MIME-Version: 1.0
References: <20180706105753.26700-1-marcandre.lureau@redhat.com>
	<20180706105753.26700-7-marcandre.lureau@redhat.com>
	<875zw8t8k8.fsf@dusky.pond.sub.org>
In-Reply-To: <875zw8t8k8.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sat, 8 Dec 2018 15:20:28 +0400
Message-ID: <CAMxuvaw20Mw4_BAShbHvVT+JwdGj5MZN0jBRcE=m8QqFqU5ddg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 06/27] qapi: do not define enumeration
 value explicitly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Armbruster, Markus" <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

Hi
On Wed, Dec 5, 2018 at 5:19 PM Markus Armbruster <armbru@redhat.com> wrote:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > The C standard has the initial value at 0 and the subsequent values
> > incremented by 1. No need to set this explicitely.
> >
> > This will prevent from artificial "gaps" when compiling out some enum
> > values and having unnecessarily large MAX values & enums arrays, or
> > simplifying iterating over valid enum values.
>
> Yes, gaps can be annoying, e.g. in lookup tables where gaps get confused
> with sentinels.
>
> Avoiding gaps scares me.  You have to religiously compile the enum with
> the exact same configuration everywhere in the program, or else you end
> up with bugs that are hard to spot.  Therefore:
>
> > Whenever config-host.h is changed, all the enum/types are recompiled.
> >
> > (a subsequent patch will split the schema. Target-specific poisoined
> > conditionals will be added. They cannot be mixed with the common
> > schema: it is not possible to end up with enums of different values in
> > common and target builds)
>
> Should we mention config-target.h here?
>

My memory isn't clear. I'll drop that comment from here, we will
discuss the poisoned conditionals again with the patch splitting the
schema.

> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  scripts/qapi/common.py | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> >
> > diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> > index 02c5c6767a..6f9498566e 100644
> > --- a/scripts/qapi/common.py
> > +++ b/scripts/qapi/common.py
> > @@ -2045,14 +2045,11 @@ typedef enum %(c_name)s {
> >  ''',
> >                  c_name=3Dc_name(name))
> >
> > -    i =3D 0
> >      for value in enum_values:
> >          ret +=3D mcgen('''
> > -    %(c_enum)s =3D %(i)d,
> > +    %(c_enum)s,
> >  ''',
> > -                     c_enum=3Dc_enum_const(name, value, prefix),
> > -                     i=3Di)
> > -        i +=3D 1
> > +                     c_enum=3Dc_enum_const(name, value, prefix))
> >
> >      ret +=3D mcgen('''
> >  } %(c_name)s;
>
> I need to consider the whole series to decide whether avoiding gaps is a
> good idea.  If it is, then this patch is fine.
