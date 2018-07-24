Received: from eggs.gnu.org ([2001:4830:134:3::10]:54807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fi0HH-0007YN-4U
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 12:35:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fi0HD-0004jt-Vj
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 12:35:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33734 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fi0HD-0004jG-PA
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 12:35:07 -0400
Date: Tue, 24 Jul 2018 17:35:00 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180724163500.GN19167@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180718093815.8104-1-berrange@redhat.com>
	<20180718093815.8104-3-berrange@redhat.com>
	<38b24622-d0e5-6ee9-24af-e23e2e5a6656@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <38b24622-d0e5-6ee9-24af-e23e2e5a6656@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 3.0 2/4] tests: don't silence error
 reporting for all tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Wed, Jul 18, 2018 at 10:44:11AM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> Hi Daniel,
>=20
> On 07/18/2018 06:38 AM, Daniel P. Berrang=C3=A9 wrote:
> > The test-vmstate test is a bit chatty because it triggers various
> > expected failure scenarios and the code in question uses error_report
> > instead of accepting 'Error **errp' parameters. To silence this test =
the
> > stubs for error_vprintf() were changed to send errors via
> > g_test_message() instead of stderr:
> >=20
> >   commit 28017e010ddf6849cfa830e898da3e44e6610952
> >   Author: Paolo Bonzini <pbonzini@redhat.com>
> >   Date:   Mon Oct 24 18:31:03 2016 +0200
> >=20
> >     tests: send error_report to test log
> >=20
> >     Implement error_vprintf to send the output of error_report to
> >     the test log.  This silences test-vmstate.
> >=20
> >     Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >     Message-Id: <1477326663-67817-3-git-send-email-pbonzini@redhat.co=
m>
> >=20
> > Unfortunately this change has global impact across the entire test su=
ite
> > and means that when tests fail for unexpected reasons, the message is
> > not displayed on stderr. eg when using &error_abort in a call the tes=
t
> > merely prints
> >=20
> >   Unexpected error in qcrypto_tls_session_check_certificate() at cryp=
to/tlssession.c:280:
> >=20
> > and the actual error message is hidden, making it impossible to diagn=
ose
> > the failure. This is especially problematic in CI or build systems wh=
ere
> > it isn't possible to easily pass the --debug-log flag to tests and
> > re-run with the test log visible.
> >=20
> > This change makes the previous big hammer much more nuanced, providin=
g a
> > flag in the stub error_vprintf() that can used on a per-test basis to
> > silence the errors. Only the test-vmstate silences errors initially.
> >=20
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >  stubs/error-printf.c | 5 ++++-
> >  tests/test-vmstate.c | 3 +++
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/stubs/error-printf.c b/stubs/error-printf.c
> > index ac6b92aa69..2199d79d28 100644
> > --- a/stubs/error-printf.c
> > +++ b/stubs/error-printf.c
> > @@ -2,9 +2,12 @@
> >  #include "qemu-common.h"
> >  #include "qemu/error-report.h"
> > =20
> > +bool silence_test_errors;
>=20
> This is not used.

Yes, accidentally left over from earlier version of patch

>=20
> > +
> >  void error_vprintf(const char *fmt, va_list ap)
> >  {
> > -    if (g_test_initialized() && !g_test_subprocess()) {
> > +    if (g_test_initialized() && !g_test_subprocess() &&
> > +        getenv("QTEST_SILENT_ERRORS")) {
> >          char *msg =3D g_strdup_vprintf(fmt, ap);
> >          g_test_message("%s", msg);
> >          g_free(msg);
> > diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
> > index 087844b6c8..42923bb1df 100644
> > --- a/tests/test-vmstate.c
> > +++ b/tests/test-vmstate.c
> > @@ -32,6 +32,7 @@
> >  #include "../migration/qemu-file-channel.h"
> >  #include "../migration/savevm.h"
> >  #include "qemu/coroutine.h"
> > +#include "qemu/error-report.h"
>=20
> Why? This doesn't seem necessary, neither related to this patch.

Left over from an earlier version of the patch, I'll cull it.

>=20
> >  #include "io/channel-file.h"
> > =20
> >  static char temp_file[] =3D "/tmp/vmst.test.XXXXXX";
> > @@ -859,6 +860,8 @@ int main(int argc, char **argv)
> > =20
> >      module_call_init(MODULE_INIT_QOM);
> > =20
> > +    setenv("QTEST_SILENT_ERRORS", "1", 1);
> > +
> >      g_test_init(&argc, &argv, NULL);
> >      g_test_add_func("/vmstate/simple/primitive", test_simple_primiti=
ve);
> >      g_test_add_func("/vmstate/versioned/load/v1", test_load_v1);
> >=20
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
