Received: from eggs.gnu.org ([2001:4830:134:3::10]:57069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gXS5R-0000nC-Oe
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:35:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gXS5N-0006AM-Gr
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:35:37 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34313)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gXS5N-0006AA-Bu
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:35:33 -0500
Received: by mail-qk1-f195.google.com with SMTP id a132so1236508qkg.1
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 06:35:33 -0800 (PST)
MIME-Version: 1.0
References: <20181213123724.4866-1-marcandre.lureau@redhat.com>
	<20181213123724.4866-7-marcandre.lureau@redhat.com>
	<87r2elpkei.fsf@dusky.pond.sub.org>
In-Reply-To: <87r2elpkei.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 13 Dec 2018 18:35:20 +0400
Message-ID: <CAMxuvawGAg5LwsUyWLYE_Hv+gsCbjKuLFN=4MzNVNGSAgtFFZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 06/22] qapi: add a dictionary form with
 'name' key for enum members
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

On Thu, Dec 13, 2018 at 6:32 PM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> One little thing...
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Desugar the enum NAME form to { 'name': NAME }. This will allow to add
> > new enum members, such as 'if' in the following patch.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> [...]
> > diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> > index f205805751..bb928d2f7d 100644
> > --- a/scripts/qapi/common.py
> > +++ b/scripts/qapi/common.py
> [...]
> > @@ -847,19 +851,29 @@ def check_alternate(expr, info):
> >              types_seen[qt] =3D key
> >
> >
> > +def normalize_enum(expr):
> > +    if isinstance(expr['data'], list):
> > +        expr['data'] =3D [m if isinstance(m, dict) else {'name': m}
> > +                        for m in expr['data']]
> > +
> > +
> >  def check_enum(expr, info):
> >      name =3D expr['enum']
> > -    members =3D expr.get('data')
> > +    members =3D expr['data']
> >      prefix =3D expr.get('prefix')
> >
> > -    if not isinstance(members, list):
> > -        raise QAPISemError(info,
> > -                           "Enum '%s' requires an array for 'data'" % =
name)
> >      if prefix is not None and not isinstance(prefix, str):
> >          raise QAPISemError(info,
> >                             "Enum '%s' requires a string for 'prefix'" =
% name)
> > +
> > +    if not isinstance(members, list):
> > +        raise QAPISemError(info,
> > +                           "Enum '%s' requires an array for 'data'" % =
name)
> > +
>
> The move of the "requires an array" check looks accidental.  I'll back
> it out unless you tell me it's needed.

ack

>
> >      for member in members:
> > -        check_name(info, "Member of enum '%s'" % name, member,
> > +        source =3D "dictionary member of enum '%s'" % name
> > +        check_known_keys(info, source, member, ['name'], [])
> > +        check_name(info, "Member of enum '%s'" % name, member['name'],
> >                     enum_member=3DTrue)
> >
> >
> [...]
