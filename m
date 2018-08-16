Received: from eggs.gnu.org ([2001:4830:134:3::10]:48540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fqFl9-0001xp-Hj
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 06:44:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fqFl6-0000vL-H7
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 06:44:06 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39542)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fqFl4-0000uS-CJ
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 06:44:02 -0400
Received: by mail-wr1-x441.google.com with SMTP id h10-v6so3710356wre.6
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 03:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180815195051.24586-1-marcandre.lureau@redhat.com>
	<87pnyieq43.fsf@dusky.pond.sub.org>
	<CAJ+F1C+GEerjpUED38b5caVO-ZUsp4anS-gcTR8_7KZuM5uTVg@mail.gmail.com>
In-Reply-To: <CAJ+F1C+GEerjpUED38b5caVO-ZUsp4anS-gcTR8_7KZuM5uTVg@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 16 Aug 2018 12:43:49 +0200
Message-ID: <CAJ+F1CJ_snhfjNVv2RGju5vz449NPDZPVKqeV4kVAnnmhZWVww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] qemu-option: add help fallback to
 print the list of options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

On Thu, Aug 16, 2018 at 12:01 PM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> On Thu, Aug 16, 2018 at 9:19 AM Markus Armbruster <armbru@redhat.com> wro=
te:
> >
> > Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
> >
> > > QDev options accept '?' or 'help' in the list of parameters, which is
> > > really handy to list the available options.
> > >
> > > Unfortunately, this isn't built in QemuOpts. qemu_opts_parse_noisily(=
)
> > > seems to be the common path for command line options, so place a
> > > fallback to check for '?' and print help listing available options.
> >
> > My immediate reaction was "how come this doesn't break -device help"?
> > It doesn't, because...
> >
> > > This is very handy, for example with qemu "-spice ?".
> > >
> > > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > ---
> > >  util/qemu-option.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/util/qemu-option.c b/util/qemu-option.c
> > > index 01886efe90..8839ee6523 100644
> > > --- a/util/qemu-option.c
> > > +++ b/util/qemu-option.c
> > > @@ -889,7 +889,12 @@ QemuOpts *qemu_opts_parse_noisily(QemuOptsList *=
list, const char *params,
> > >
> > >      opts =3D opts_parse(list, params, permit_abbrev, false, &err);
> > >      if (err) {
> > > -        error_report_err(err);
> > > +        if (has_help_option(params)) {
> > > +            qemu_opts_print_help(list);
> > > +            error_free(err);
> > > +        } else {
> > > +            error_report_err(err);
> > > +        }
> > >      }
> > >      return opts;
> > >  }
> >
> > ... it only kicks in when parsing failed, and it doesn't for option
> > argument "help".
> >
> > However, it *can* break for some option arguments:
> >
> >     $ upstream-qemu -device e1000,id=3D@
> >     upstream-qemu: -device e1000,id=3D@: Parameter 'id' expects an iden=
tifier
> >     Identifiers consist of letters, digits, '-', '.', '_', starting wit=
h a letter.
> >     [Exit 1 ]
> >     $ upstream-qemu -device e1000,id=3D@,help
> >     [Exit 1 ]
> >
> > In the second test case, the error message gets replaced by (empty)
> > help.
>
> Good catch
>
> >
> > I love patches improving help, but I can't immediately see how to
> > salvage this one.
> >
>
> We can pass a with_help option down to opt_set(), and print help
> there? Alternatively, pass a bool *invalid_parameter, to be set in
> this case, so qemu_opts_parse_noisly() would only print help when it
> is set.
>
> Do you see a problem with any of those 2 options?

This is the second option, that I can amend and send v2 if you are ok with =
it:

diff --git a/util/qemu-option.c b/util/qemu-option.c
index 9b99f0d0be..a54cf74b49 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -526,7 +526,7 @@ int qemu_opt_unset(QemuOpts *opts, const char *name)
 }

 static void opt_set(QemuOpts *opts, const char *name, char *value,
-                    bool prepend, Error **errp)
+                    bool prepend, bool *invalidp, Error **errp)
 {
     QemuOpt *opt;
     const QemuOptDesc *desc;
@@ -536,6 +536,9 @@ static void opt_set(QemuOpts *opts, const char
*name, char *value,
     if (!desc && !opts_accepts_any(opts)) {
         g_free(value);
         error_setg(errp, QERR_INVALID_PARAMETER, name);
+        if (invalidp) {
+            *invalidp =3D true;
+        }
         return;
     }

@@ -559,7 +562,7 @@ static void opt_set(QemuOpts *opts, const char
*name, char *value,
 void qemu_opt_set(QemuOpts *opts, const char *name, const char *value,
                   Error **errp)
 {
-    opt_set(opts, name, g_strdup(value), false, errp);
+    opt_set(opts, name, g_strdup(value), false, NULL, errp);
 }

 void qemu_opt_set_bool(QemuOpts *opts, const char *name, bool val,
@@ -790,7 +793,8 @@ void qemu_opts_print(QemuOpts *opts, const char *separa=
tor)
 }

 static void opts_do_parse(QemuOpts *opts, const char *params,
-                          const char *firstname, bool prepend, Error **err=
p)
+                          const char *firstname, bool prepend,
+                          bool *invalidp, Error **errp)
 {
     char *option =3D NULL;
     char *value =3D NULL;
@@ -825,7 +829,7 @@ static void opts_do_parse(QemuOpts *opts, const
char *params,
         }
         if (strcmp(option, "id") !=3D 0) {
             /* store and parse */
-            opt_set(opts, option, value, prepend, &local_err);
+            opt_set(opts, option, value, prepend, invalidp, &local_err);
             value =3D NULL;
             if (local_err) {
                 error_propagate(errp, local_err);
@@ -854,11 +858,12 @@ static void opts_do_parse(QemuOpts *opts, const
char *params,
 void qemu_opts_do_parse(QemuOpts *opts, const char *params,
                        const char *firstname, Error **errp)
 {
-    opts_do_parse(opts, params, firstname, false, errp);
+    opts_do_parse(opts, params, firstname, false, NULL, errp);
 }

 static QemuOpts *opts_parse(QemuOptsList *list, const char *params,
-                            bool permit_abbrev, bool defaults, Error **err=
p)
+                            bool permit_abbrev, bool defaults,
+                            bool *invalidp, Error **errp)
 {
     const char *firstname;
     char *id =3D NULL;
@@ -890,7 +895,7 @@ static QemuOpts *opts_parse(QemuOptsList *list,
const char *params,
         return NULL;
     }

-    opts_do_parse(opts, params, firstname, defaults, &local_err);
+    opts_do_parse(opts, params, firstname, defaults, invalidp, &local_err)=
;
     if (local_err) {
         error_propagate(errp, local_err);
         qemu_opts_del(opts);
@@ -910,7 +915,7 @@ static QemuOpts *opts_parse(QemuOptsList *list,
const char *params,
 QemuOpts *qemu_opts_parse(QemuOptsList *list, const char *params,
                           bool permit_abbrev, Error **errp)
 {
-    return opts_parse(list, params, permit_abbrev, false, errp);
+    return opts_parse(list, params, permit_abbrev, false, NULL, errp);
 }

 /**
@@ -926,10 +931,11 @@ QemuOpts *qemu_opts_parse_noisily(QemuOptsList
*list, const char *params,
 {
     Error *err =3D NULL;
     QemuOpts *opts;
+    bool invalidp =3D false;

-    opts =3D opts_parse(list, params, permit_abbrev, false, &err);
+    opts =3D opts_parse(list, params, permit_abbrev, false, &invalidp, &er=
r);
     if (err) {
-        if (has_help_option(params)) {
+        if (invalidp && has_help_option(params)) {
             qemu_opts_print_help(list);
             error_free(err);
         } else {
@@ -944,7 +950,7 @@ void qemu_opts_set_defaults(QemuOptsList *list,
const char *params,
 {
     QemuOpts *opts;

-    opts =3D opts_parse(list, params, permit_abbrev, true, NULL);
+    opts =3D opts_parse(list, params, permit_abbrev, true, NULL, NULL);
     assert(opts);
 }





--=20
Marc-Andr=C3=A9 Lureau
