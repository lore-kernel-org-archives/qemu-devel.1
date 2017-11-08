Received: from eggs.gnu.org ([2001:4830:134:3::10]:55921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eCTeQ-0004m9-F6
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:56:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eCTeL-0001Fo-Iy
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:56:30 -0500
Date: Wed, 8 Nov 2017 14:56:19 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171108165619.GM3111@localhost.localdomain>
References: <20171030181459.1951-1-f4bug@amsat.org>
	<20171103003520.GF3111@localhost.localdomain>
	<9adefce7-1c65-9539-1961-fa981f0ecccc@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <9adefce7-1c65-9539-1961-fa981f0ecccc@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] vl: only display available accelerators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, "Emilio G . Cota" <cota@braap.org>, Eric Blake <eblake@redhat.com>, Richard Henderson <rth@twiddle.net>

On Wed, Nov 08, 2017 at 01:20:49PM -0300, Philippe Mathieu-Daud=E9 wrote:
> On 11/02/2017 09:35 PM, Eduardo Habkost wrote:
> > On Mon, Oct 30, 2017 at 03:14:59PM -0300, Philippe Mathieu-Daud=E9 wr=
ote:
> >> examples configuring with '--enable-kvm --disable-tcg'
> >>
> >> - before
> >>
> >>   $ qemu-system-x86_64 -accel help
> >>   Possible accelerators: kvm, xen, hax, tcg
> >>
> >>   $ qemu-system-x86_64 -accel tcg
> >>   qemu-system-x86_64: -machine accel=3Dtcg: No accelerator found
> >>
> >>   # qemu-system-x86_64 -accel hax
> >>   qemu-system-x86_64: -machine accel=3Dhax: No accelerator found
> >>
> >> - after
> >>
> >>   $ qemu-system-x86_64 -accel help
> >>   Possible accelerators:
> >>     xen
> >>     kvm
> >>
> >> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> >> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> >> ---
> >> since RFC:
> >>   - use much cleaner object_class_get_list(TYPE_ACCEL, false)
> >>
> >>  vl.c | 39 ++++++++++++++++++++++++++++++++++-----
> >>  1 file changed, 34 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/vl.c b/vl.c
> >> index ec299099ff..0f13641715 100644
> >> --- a/vl.c
> >> +++ b/vl.c
> >> @@ -2764,6 +2764,39 @@ static gint machine_class_cmp(gconstpointer a=
, gconstpointer b)
> >>      exit(!name || !is_help_option(name));
> >>  }
> >> =20
> >> +static void accel_list_entry(gpointer data, gpointer user_data)
> >> +{
> >> +    ObjectClass *oc =3D data;
> >> +    const char *typename =3D object_class_get_name(oc);
> >> +    int len;
> >> +
> >> +    if (!qtest_driver() && !g_strcmp0(typename, ACCEL_CLASS_NAME("q=
test"))) {
> >> +        return; /* used by test cases */
> >> +    }
> >=20
> > I would prefer to not hardcode the accel name here.  If you want
> > qtest to have special behavior, you can add a new field to
> > AccelClass to implement that.
> >=20
> > However, I don't think I agree we should hide qtest from the
> > user: it is accepted on the command-line, so why should we lie?
>=20
> Ok.
>=20
> > Why not add a description field and indicate that qtest is useful
> > only for testing?
>=20
> This is cleaner indeed.
>=20
> >> +
> >> +    len =3D strlen(typename) - strlen("-" TYPE_ACCEL);
> >=20
> > You can use AccelClass::name here.
>=20
> Hmm yes but currently this is not what the user should use, since the
> accel_find() matches the ACCEL_CLASS_NAME:
>=20
> $ ppc64-softmmu/qemu-system-ppc64 -accel QTest
> qemu-system-ppc64: -machine accel=3DQTest: No accelerator found

Oops, you're correct.

In this case, I suggest using ACCEL_CLASS_SUFFIX instead of
hardcoding ("-" TYPE_ACCEL).

Maybe a accel_class_get_accel_name() helper similar to
x86_cpu_class_get_model_name() would be even better.  It would
require an extra memory allocation, but the code would be
cleaner.  We might add a QMP command returning the accel list in
the future, so a common helper would be useful.


>=20
> I'll respin but the change will be bigger so I is probably too late for
> 2.11.
>=20
> >=20
> >> +    if (len > 0) {
> >> +        error_printf("  %.*s\n", len, typename);
> >> +    }
> >> +}
> >> +
> >> +static void accel_parse(const char *name, QemuOpts *accel_opts)
> >> +{
> >> +    const char *optarg =3D qemu_opt_get(accel_opts, "accel");
> >> +    GSList *list;
> >> +
> >> +    if (!is_help_option(optarg)) {
> >> +        return;
> >> +    }
> >> +
> >> +    list =3D object_class_get_list(TYPE_ACCEL, false);
> >> +    error_printf("Possible accelerators:\n");
> >> +    g_slist_foreach(list, accel_list_entry, NULL);
> >> +    g_slist_free(list);
> >> +
> >> +    exit(0);
> >> +}
> >> +
> >>  void qemu_add_exit_notifier(Notifier *notify)
> >>  {
> >>      notifier_list_add(&exit_notifiers, notify);
> >> @@ -3881,11 +3914,7 @@ int main(int argc, char **argv, char **envp)
> >>              case QEMU_OPTION_accel:
> >>                  accel_opts =3D qemu_opts_parse_noisily(qemu_find_op=
ts("accel"),
> >>                                                       optarg, true);
> >> -                optarg =3D qemu_opt_get(accel_opts, "accel");
> >> -                if (!optarg || is_help_option(optarg)) {
> >> -                    error_printf("Possible accelerators: kvm, xen, =
hax, tcg\n");
> >> -                    exit(0);
> >> -                }
> >> +                accel_parse(optarg, accel_opts);
> >>                  opts =3D qemu_opts_create(qemu_find_opts("machine")=
, NULL,
> >>                                          false, &error_abort);
> >>                  qemu_opt_set(opts, "accel", optarg, &error_abort);
> >> --=20
> >> 2.15.0.rc2
> >>
> >=20

--=20
Eduardo
