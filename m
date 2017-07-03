Received: from eggs.gnu.org ([2001:4830:134:3::10]:50161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1dRzfn-0001ZO-Sb
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 07:37:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1dRzfi-0002wK-V4
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 07:37:47 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1dRzfi-0002vN-Ly
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 07:37:42 -0400
Received: by mail-wm0-f53.google.com with SMTP id w126so165560670wme.0
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 04:37:42 -0700 (PDT)
Date: Mon, 3 Jul 2017 13:37:38 +0200
From: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Message-ID: <20170703133738.6e6bd346@fiorina>
In-Reply-To: <CAJ+F1CJdDYtPNZXNjs6cesKg1iL7mCEPgx01WSc3RPwL5CcZ6A@mail.gmail.com>
References: <cover.1498771584.git.tgolembi@redhat.com>
	<a01ca468294eba398bbaa1dfdec7fb07903df586.1498771584.git.tgolembi@redhat.com>
	<CAJ+F1CJdDYtPNZXNjs6cesKg1iL7mCEPgx01WSc3RPwL5CcZ6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 3/3] test-qga: add test for
 guest-get-osinfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@gmail.com>
Cc: Eric Blake <eblake@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>, qemu-devel@nongnu.org

Uh, sorry. I will resend in a minute.

    Tomas

On Fri, 30 Jun 2017 13:48:41 +0000
Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:

> Hi,
>=20
> It's missing test-qga-os-release :)
>=20
> On Thu, Jun 29, 2017 at 11:27 PM Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgole=
mbi@redhat.com>
> wrote:
>=20
> > Add test for guest-get-osinfo command.
> >
> > Qemu-ga was modified to accept QGA_OS_RELEASE environment variable. If
> > the variable is defined it is interpreted as path to the os-release file
> > and it is parsed instead of the default paths.
> >
> > Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
> > ---
> >  qga/commands-posix.c | 13 ++++++++++---
> >  tests/test-qga.c     | 53
> > ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 63 insertions(+), 3 deletions(-)
> >
> > diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> > index 2406518d47..f6ce8dd583 100644
> > --- a/qga/commands-posix.c
> > +++ b/qga/commands-posix.c
> > @@ -2683,9 +2683,16 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
> >      info->kernel_release =3D g_strdup(kinfo.release);
> >      info->machine_hardware =3D g_strdup(kinfo.machine);
> >
> > -    GKeyFile *osrelease =3D ga_parse_osrelease("/etc/os-release");
> > -    if (osrelease =3D=3D NULL) {
> > -        osrelease =3D ga_parse_osrelease("/usr/lib/os-release");
> > +    GKeyFile *osrelease =3D NULL;
> > +
> > +    const char *qga_os_release =3D g_getenv("QGA_OS_RELEASE");
> > +    if (qga_os_release !=3D NULL) {
> > +        osrelease =3D ga_parse_osrelease(qga_os_release);
> > +    } else {
> > +        osrelease =3D ga_parse_osrelease("/etc/os-release");
> > +        if (osrelease =3D=3D NULL) {
> > +            osrelease =3D ga_parse_osrelease("/usr/lib/os-release");
> > +        }
> >      }
> >
> >      if (osrelease !=3D NULL) {
> > diff --git a/tests/test-qga.c b/tests/test-qga.c
> > index 631b98639a..b9160708a0 100644
> > --- a/tests/test-qga.c
> > +++ b/tests/test-qga.c
> > @@ -936,6 +936,58 @@ static void test_qga_guest_exec_invalid(gconstpoin=
ter
> > fix)
> >      QDECREF(ret);
> >  }
> >
> > +static void test_qga_guest_get_osinfo(gconstpointer data)
> > +{
> > +    TestFixture fixture;
> > +    const gchar *str;
> > +    gchar *cwd, *env[2];
> > +    QDict *ret, *val;
> > +
> > +    cwd =3D g_get_current_dir();
> > +    env[0] =3D
> > g_strdup_printf("QGA_OS_RELEASE=3D%s%ctests%cdata%ctest-qga-os-release",
> > +                             cwd, G_DIR_SEPARATOR, G_DIR_SEPARATOR,
> > G_DIR_SEPARATOR);
> > +    env[1] =3D NULL;
> > +    g_free(cwd);
> > +    fixture_setup(&fixture, NULL, env);
> > +
> > +    ret =3D qmp_fd(fixture.fd, "{'execute': 'guest-get-osinfo'}");
> > +    g_assert_nonnull(ret);
> > +    qmp_assert_no_error(ret);
> > +
> > +    val =3D qdict_get_qdict(ret, "return");
> > +
> > +    str =3D qdict_get_try_str(val, "id");
> > +    g_assert_nonnull(str);
> > +    g_assert_cmpstr(str, =3D=3D, "qemu-ga-test");
> > +
> > +    str =3D qdict_get_try_str(val, "name");
> > +    g_assert_nonnull(str);
> > +    g_assert_cmpstr(str, =3D=3D, "QEMU-GA");
> > +
> > +    str =3D qdict_get_try_str(val, "pretty-name");
> > +    g_assert_nonnull(str);
> > +    g_assert_cmpstr(str, =3D=3D, "QEMU Guest Agent test");
> > +
> > +    str =3D qdict_get_try_str(val, "version");
> > +    g_assert_nonnull(str);
> > +    g_assert_cmpstr(str, =3D=3D, "Test 1");
> > +
> > +    str =3D qdict_get_try_str(val, "version-id");
> > +    g_assert_nonnull(str);
> > +    g_assert_cmpstr(str, =3D=3D, "1");
> > +
> > +    str =3D qdict_get_try_str(val, "variant");
> > +    g_assert_nonnull(str);
> > +    g_assert_cmpstr(str, =3D=3D, "Unit test \"'$`\\ and \\\\ etc.");
> > +
> > +    str =3D qdict_get_try_str(val, "variant-id");
> > +    g_assert_nonnull(str);
> > +    g_assert_cmpstr(str, =3D=3D, "unit-test");
> > +
> > +    QDECREF(ret);
> > +    g_free(env[0]);
> > +}
> > +
> >  int main(int argc, char **argv)
> >  {
> >      TestFixture fix;
> > @@ -972,6 +1024,7 @@ int main(int argc, char **argv)
> >      g_test_add_data_func("/qga/guest-exec", &fix, test_qga_guest_exec);
> >      g_test_add_data_func("/qga/guest-exec-invalid", &fix,
> >                           test_qga_guest_exec_invalid);
> > +    g_test_add_data_func("/qga/guest-get-osinfo", &fix,
> > test_qga_guest_get_osinfo);
> >
> >      if (g_getenv("QGA_TEST_SIDE_EFFECTING")) {
> >          g_test_add_data_func("/qga/fsfreeze-and-thaw", &fix,
> > --
> > 2.13.1
> >
> > -- =20
> Marc-Andr=C3=A9 Lureau


--=20
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
