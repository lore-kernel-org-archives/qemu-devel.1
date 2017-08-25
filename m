Received: from eggs.gnu.org ([2001:4830:134:3::10]:46721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dl9ic-0006pW-Ux
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 04:11:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dl9iW-0003OQ-P0
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 04:11:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dl9iW-0003Nl-Fs
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 04:11:48 -0400
Date: Fri, 25 Aug 2017 10:11:44 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170825101144.5caf3e8c@nial.brq.redhat.com>
In-Reply-To: <fed7c9be-6609-75bc-61ca-b6acc67bb092@amsat.org>
References: <1503592308-93913-1-git-send-email-imammedo@redhat.com>
	<1503592308-93913-2-git-send-email-imammedo@redhat.com>
	<fed7c9be-6609-75bc-61ca-b6acc67bb092@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.11 v3 01/25] qom: cpu: fix parsed
 feature string length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>

On Thu, 24 Aug 2017 14:00:21 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> Hi Igor,
>=20
> On 08/24/2017 01:31 PM, Igor Mammedov wrote:
> > since commit ( 9262685b cpu: Factor out cpu_generic_init() )
> > features parsed by it were truncated only to the 1st feature
> > after CPU name due to fact that
> >=20
> >     featurestr =3D strtok(NULL, ",");
> >     cc->parse_features(cpu, featurestr, &err);
> >=20
> > would extract exactly one feature and parse_features() callback
> > would parse it and only it leaving the rest of features ignored.
> >=20
> > Reuse approach from x86 custom impl. i.e. replace strtok() token
> > parsing with g_strsplit(), which would split feature string in
> > 2 parts name and features list and pass the later to
> > parse_features() callback.
> >=20
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > CC: Eduardo Habkost <ehabkost@redhat.com>
> > CC: Andreas F=C3=A4rber <afaerber@suse.de>
> >=20
> > Probably due to existing users not actualy using/having any
> > features to parse bug were unnoticed for 2 years but switching
> > from custom cpu_foo_init() to cpu_generic_init() triggered it.
> > ---
> >   qom/cpu.c | 14 ++++++--------
> >   1 file changed, 6 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/qom/cpu.c b/qom/cpu.c
> > index 4f38db0..caf5c14 100644
> > --- a/qom/cpu.c
> > +++ b/qom/cpu.c
> > @@ -50,28 +50,26 @@ bool cpu_exists(int64_t id)
> >  =20
> >   CPUState *cpu_generic_init(const char *typename, const char *cpu_mode=
l)
> >   {
> > -    char *str, *name, *featurestr;
> >       CPUState *cpu =3D NULL;
> >       ObjectClass *oc;
> >       CPUClass *cc;
> >       Error *err =3D NULL;
> > +    gchar **model_pieces;
> >  =20
> > -    str =3D g_strdup(cpu_model);
> > -    name =3D strtok(str, ",");
> > +    model_pieces =3D g_strsplit(cpu_model, ",", 2);
> >  =20
> > -    oc =3D cpu_class_by_name(typename, name);
> > +    oc =3D cpu_class_by_name(typename, model_pieces[0]);
> >       if (oc =3D=3D NULL) {
> > -        g_free(str);
> > +        g_strfreev(model_pieces);
> >           return NULL;
> >       }
> >  =20
> >       cc =3D CPU_CLASS(oc);
> > -    featurestr =3D strtok(NULL, ",");
> >       /* TODO: all callers of cpu_generic_init() need to be converted to
> >        * call parse_features() only once, before calling cpu_generic_in=
it().
> >        */
> > -    cc->parse_features(object_class_get_name(oc), featurestr, &err);
> > -    g_free(str); =20
>=20
> I feel safer adding:
>=20
>         if (g_strv_length(model_pieces) > 1) {
all current callbacks (i386/sparc/cpu_common_parse_features) deal with

  cc->parse_features(,NULL,)

by explicitly checking for NULL, so there is no need for check here.

Though, it's possible to avoid calling callback at all
if model_pieces[1] =3D=3D NULL

Would you like to post a patch on top?

>=20
> > +    cc->parse_features(object_class_get_name(oc), model_pieces[1], &er=
r); =20
>=20
>         }
>=20
> > +    g_strfreev(model_pieces);
> >       if (err !=3D NULL) {
> >           goto out;
> >       }
> >  =20
>=20
