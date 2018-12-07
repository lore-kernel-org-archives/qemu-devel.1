Received: from eggs.gnu.org ([2001:4830:134:3::10]:45168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gVEH8-0001Zd-1R
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 06:26:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gVEH4-0001C1-2D
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 06:26:30 -0500
Received: from mail-qt1-f180.google.com ([209.85.160.180]:37844)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gVEH3-0001BR-TZ
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 06:26:25 -0500
Received: by mail-qt1-f180.google.com with SMTP id z16so4043521qtq.4
	for <qemu-devel@nongnu.org>; Fri, 07 Dec 2018 03:26:25 -0800 (PST)
MIME-Version: 1.0
References: <20180706105753.26700-1-marcandre.lureau@redhat.com>
	<20180706105753.26700-11-marcandre.lureau@redhat.com>
	<87k1koq6s6.fsf@dusky.pond.sub.org>
In-Reply-To: <87k1koq6s6.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 7 Dec 2018 15:26:13 +0400
Message-ID: <CAMxuvaw_3gHsgDZ9tN7r+uzV3BPr8TAoBoYBVUnPMv6ODyYfYA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 10/27] qapi: factor out checking for keys
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

On Wed, Dec 5, 2018 at 8:26 PM Markus Armbruster <armbru@redhat.com> wrote:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Introduce a new helper function to check if the given keys are known,
> > and if mandatory keys are present. The function will be reused in
> > other places in the following code changes.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  scripts/qapi/common.py | 20 +++++++++++++-------
> >  1 file changed, 13 insertions(+), 7 deletions(-)
> >
> > diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> > index a353670079..8313c478c4 100644
> > --- a/scripts/qapi/common.py
> > +++ b/scripts/qapi/common.py
> > @@ -873,6 +873,17 @@ def check_struct(expr, info):
> >                 allow_metas=3D['struct'])
> >
> >
> > +def check_known_keys(info, source, keys, required, optional):
> > +    for key in keys:
> > +        if key not in required and key not in optional:
> > +            raise QAPISemError(info, "Unknown key '%s' in %s" % (key, =
source))
> > +
> > +    for key in required:
> > +        if key not in keys:
> > +            raise QAPISemError(info, "Key '%s' is missing from %s"
> > +                               % (key, source))
> > +
> > +
> >  def check_keys(expr_elem, meta, required, optional=3D[]):
> >      expr =3D expr_elem['expr']
> >      info =3D expr_elem['info']
> > @@ -880,10 +891,9 @@ def check_keys(expr_elem, meta, required, optional=
=3D[]):
> >      if not isinstance(name, str):
> >          raise QAPISemError(info, "'%s' key must have a string value" %=
 meta)
> >      required =3D required + [meta]
> > +    source =3D "%s '%s'" % (meta, name)
> > +    check_known_keys(info, source, list(expr.keys()), required, option=
al)
>
> Sure you need list() here?

I don't know, that's what python-modernize suggests.

Also the top answer from:
https://stackoverflow.com/questions/16819222/how-to-return-dictionary-keys-=
as-a-list-in-python#16819250

Do you mind if I leave the list() ? (mostly for python-modernize to be happ=
y)


>
> >      for (key, value) in expr.items():
> > -        if key not in required and key not in optional:
> > -            raise QAPISemError(info, "Unknown key '%s' in %s '%s'"
> > -                               % (key, meta, name))
> >          if key in ['gen', 'success-response'] and value is not False:
> >              raise QAPISemError(info,
> >                                 "'%s' of %s '%s' should only use false =
value"
> > @@ -895,10 +905,6 @@ def check_keys(expr_elem, meta, required, optional=
=3D[]):
> >                                 % (key, meta, name))
> >          if key =3D=3D 'if':
> >              check_if(expr, info)
> > -    for key in required:
> > -        if key not in expr:
> > -            raise QAPISemError(info, "Key '%s' is missing from %s '%s'=
"
> > -                               % (key, meta, name))
> >
> >
> >  def check_exprs(exprs):
