Received: from eggs.gnu.org ([2001:4830:134:3::10]:50418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gCtSd-0004o2-6o
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 17:34:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gCtSO-0001GH-EM
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 17:34:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gCtSO-0001D2-12
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 17:34:20 -0400
Date: Wed, 17 Oct 2018 18:34:09 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181017213409.GP31060@habkost.net>
References: <20181016232201.16829-1-crosa@redhat.com>
	<CAFEAcA_KFOay7zBoYMSqqEYd0ZhTcW5wp3bs28cr=oK4W4FL3A@mail.gmail.com>
	<20181017162944.GF31060@habkost.net>
	<d5f32475-df5b-0c5c-591f-5fae8e641c11@redhat.com>
	<CAFEAcA_gyQvmq48QquNiFhGef-FWPeDKRUSk3wf7hS=_=xm_XQ@mail.gmail.com>
	<20181017194315.GA18379@kermit-br-ibm-com>
	<20181017200558.GJ31060@habkost.net>
	<cc4cd4bb-e7b2-a7e3-eab0-210ece6b1bd4@redhat.com>
	<524e469f-1c1e-f71a-fb4b-2384c6a13872@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <524e469f-1c1e-f71a-fb4b-2384c6a13872@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Acceptance tests: host arch to target arch
 name mapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Caio Carrara <ccarrara@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>

On Wed, Oct 17, 2018 at 05:10:18PM -0400, Cleber Rosa wrote:
>=20
>=20
> On 10/17/18 4:33 PM, Wainer dos Santos Moschetta wrote:
> >=20
> > On 10/17/2018 05:05 PM, Eduardo Habkost wrote:
> >> On Wed, Oct 17, 2018 at 04:43:15PM -0300, Murilo Opsfelder Araujo wr=
ote:
> >>> On Wed, Oct 17, 2018 at 07:40:51PM +0100, Peter Maydell wrote:
> >>>> On 17 October 2018 at 18:38, Cleber Rosa <crosa@redhat.com> wrote:
> >>>>>
> >>>>> On 10/17/18 12:29 PM, Eduardo Habkost wrote:
> >>>>>> On Wed, Oct 17, 2018 at 01:34:41PM +0100, Peter Maydell wrote:
> >>>>>>> So, why does the test code need to care? It's not clear
> >>>>>>> from the patch... My expectation would be that you'd
> >>>>>>> just test all the testable target architectures,
> >>>>>>> regardless of what the host architecture is.
> >>>>>> I tend to agree.=A0 Maybe the right solution is to get rid of th=
e
> >>>>>> os.uname().=A0 I think the default should be testing all QEMU
> >>>>>> binaries that were built, and the host architecture shouldn't
> >>>>>> matter.
> >>>> Yes, looking at os.uname() also seems like an odd thing
> >>>> for the tests to be doing here. The test framework
> >>>> should be as far as possible host-architecture agnostic.
> >>>> (For some of the KVM cases there probably is a need to
> >>>> care, but those are exceptions, not the rule.)
> >>>>
> >>>>> I'm in favor of exercising all built targets, but that seems to m=
e
> >>>>> to be
> >>>>> on another layer, above the test themselves. This change is about=
 the
> >>>>> behavior of a test when not told about the target arch (and thus
> >>>>> binary)
> >>>>> it should use.
> >>>> At that level, I think the right answer is "tell the user
> >>>> they need to specify the qemu executable they are trying to test".
> >>>> In particular, there is no guarantee that the user has actually
> >>>> built the executable for the target that corresponds to the
> >>>> host, so it doesn't work to try to default to that anyway.
> >>>>
> >>>> thanks
> >>>> -- PMM
> >>>>
> >>> I agree with Peter.=A0 We can make qemu_bin parameter mandatory.=A0=
 If it
> >>> is not
> >>> given, error out.=A0 Trying to guess it based on host architecture
> >>> turns out to be
> >>> troublesome.
> >>>
> >>> If we decide to follow this approach of not guessing QEMU binary, w=
e
> >>> should
> >>> update docs/devel/testing.rst to make it crystal clear qemu_bin
> >>> parameter is
> >>> mandatory.
> >> That's not a perfect solution to me, but it sounds better than
> >> using uname() and silently making a decision for the user.
> >>
> >=20
> > As someone that have been writing acceptance tests recently, I find v=
ery
> > convenient it picking the qemu binary from current build automaticall=
y.
> >=20
>=20
> I can relate to that.  It may not sound like much, but every single
> barrier or extra requirement we put on the initial test writing, is
> another possible lost test case written.

Agreed.


>=20
> > On the other hand, as an CI system or tester (I presume), I would wan=
t
> > to run tests on all target built. Or at least have control over it.
> >=20
>=20
> Absolutely.  The control already exists though.  I think the key
> decision we need now is:
>=20
>  * Should an individual test refuse to run and error out unless an
> explicit QEMU binary parameter is given? OR
>=20
>  * Should an individual test default to a host/target binary is one
> exists in the system?

We have a third option: an individual test[1] not erroring out
and testing all QEMU binaries in the current build.  What are the
obstacles for doing that?

[1] By "an individual test" I understand "a command where the
    user indicates that they want to run a single test".

>=20
> > I don't know if the architectures in question are so broadly used on
> > workstations that would justify this patch. Maybe we can stick with
> > current uname() approach (and if not able to find the binary, well, y=
ou
> > should point do it), and rather introduce a mechanism for running tes=
ts
> > against several targets (satisfying CI needs)?
> >=20
>=20
> Well, I added all for the sake of comprehensiveness (well, actually got
> two wrong as you noticed :).  The tooling to exercise many targets,
> machine types, devices, is certainly something we need, but, it's
> another layer altogether.

Maybe the key difference here is that people probably don't
expect every machine type and device to be always tested, but
they are likely to expect test commands to test all QEMU binaries
in the current build dir.  That's the behavior of all
"make check-*" rules currently.

If this should be considered another layer in the system, that's
fine.  But then we should ensure the UIs/instructions we provide
for running tests talk to that layer.

--=20
Eduardo
