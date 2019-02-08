Received: from eggs.gnu.org ([209.51.188.92]:51005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gs37c-00088H-9Q
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 05:11:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gs37b-0002rw-B9
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 05:11:00 -0500
Date: Fri, 8 Feb 2019 11:10:48 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190208111048.749914f2.cohuck@redhat.com>
In-Reply-To: <99b31455-41be-af68-ad03-1119340905c3@redhat.com>
References: <20190202005610.24048-1-crosa@redhat.com>
	<20190202005610.24048-6-crosa@redhat.com>
	<20190206164004.79be247a.cohuck@redhat.com>
	<fa162265-629f-73e1-c483-3cad10f1b101@redhat.com>
	<99b31455-41be-af68-ad03-1119340905c3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 05/20] Acceptance tests: introduce arch
 parameter and attribute
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>, Caio Carrara <ccarrara@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <fam@euphon.net>, qemu-s390x@nongnu.org, Stefan Markovic <smarkovic@wavecomp.com>

On Thu, 7 Feb 2019 13:22:10 -0500
Cleber Rosa <crosa@redhat.com> wrote:

> On 2/7/19 1:02 PM, Cleber Rosa wrote:
> >=20
> >=20
> > On 2/6/19 10:40 AM, Cornelia Huck wrote: =20
> >> On Fri,  1 Feb 2019 19:55:55 -0500
> >> Cleber Rosa <crosa@redhat.com> wrote:
> >> =20
> >>> It's useful to define the architecture that should be used in
> >>> situations such as:
> >>>  * the intended target of the QEMU binary to be used on tests
> >>>  * the architecture of code to be run within the QEMU binary, such
> >>>    as a kernel image or a full blown guest OS image =20
> >>
> >> Thinking a bit more about this: These two are often, but not
> >> necessarily, the same. For example, starting a machine with the 64 bit
> >> variant of an architecture to run a guest with the 32 bit variant of
> >> that architecture might be a valid case.
> >> =20
> >=20
> > I agree with everything you said, and that's why I imagine "arch" being
> > used as a safe default type of parameter.
> >=20
> > See, the QEMU binary can be influenced by the "arch" parameter, but can
> > still be *defined* by the "qemu_bin" parameter.  That's the same
> > approach I believe can be applied to the architecture of the guest code.
> >  When time comes, we may add a "guest_arch" parameter of sorts.  We
> > don't have that use case now, but I believe we'll be covered when it co=
mes.

Ok, makes sense.

> >  =20
> >>>
> >>> This commit introduces both a test parameter and a test instance
> >>> attribute, that will contain such a value.
> >>>
> >>> Now, when the "arch" test parameter is given, it will influence the
> >>> selection of the default QEMU binary, if one is not given explicitly
> >>> by means of the "qemu_img" parameter.
> >>>
> >>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> >>> ---
> >>>  docs/devel/testing.rst                    | 17 +++++++++++++++++
> >>>  tests/acceptance/avocado_qemu/__init__.py | 14 +++++++++++---
> >>>  2 files changed, 28 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> >>> index 44c9b3ae74..d37c4b0e77 100644
> >>> --- a/docs/devel/testing.rst
> >>> +++ b/docs/devel/testing.rst
> >>> @@ -689,6 +689,16 @@ vm
> >>>  A QEMUMachine instance, initially configured according to the given
> >>>  ``qemu_bin`` parameter.
> >>> =20
> >>> +arch
> >>> +~~~~
> >>> +
> >>> +The architecture that will be used on a number of different
> >>> +scenarios.  For instance, when a QEMU binary is not explicitly given,
> >>> +the one selected will depend on this attribute. =20
> >>
> >> This is probably a bit too vague. (What are "different scenarios"?)
> >> =20
> >=20
> > I believe it's kind of vague because I was thinking of both the
> > "framework level" code, and the possible uses in the tests.
> >=20
> > At the "framework" level, it's only used for the case listed there
> > ("when a QEMU binary is not explicitly given...").
> >  =20
> >> Does it select anything else than the architecture of the vm that will
> >> be started?
> >> =20
> >=20
> > No, it doesn't.  The idea here was that tests may choose to use the same
> > attribute value in their own specific ("different") scenarios.
> >=20
> > I can certainly make this clearer.
> >  =20
>=20
> Hi Cornelia,
>=20
> How does this sound?
>=20
> ---

What about adding the following as a lead-in:

"The architecture can be used on different levels of the stack, e.g. by
the framework or by the test itself."

That would probably explain what you wanted to express with "different
scenarios".

>=20
> The architecture that will influence the selection of a QEMU binary
> (when one is not explicitly given).

s/that will/will/ ?

>=20
> Tests are also free to use this attribute value, for their own needs.
> A test may, for instance, use the same value when selecting the
> architecture of a kernel or disk image to boot a VM with.
>=20
> The ``arch`` attribute will be set to the test parameter of the same
> name, and if one is not given explicitly, it will be set to ``None``.
>=20
> ---
>=20
> It uses your previous point about the 64/32 bit host/guest as an
> example.  Again, a test could use another parameter (not a Test class
> attribute) if it wants to use code for a different arch than the host.

Sounds good!
