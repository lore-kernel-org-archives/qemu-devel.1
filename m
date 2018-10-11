Received: from eggs.gnu.org ([2001:4830:134:3::10]:38825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gAeeq-000627-2p
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:21:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gAeek-0003Fr-Ve
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:21:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55736)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gAeek-0003FW-Mb
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:21:50 -0400
Date: Thu, 11 Oct 2018 14:21:37 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181011172137.GU5738@habkost.net>
References: <835fcb24-5832-9e6c-9f57-0364f0bf849a@redhat.com>
	<95a8561c-0511-6a8a-a3eb-25d556029e7a@redhat.com>
	<20181010134656.GE5738@habkost.net>
	<47f72e98-335f-b3c9-54c7-4c8a468d85d6@redhat.com>
	<26fe2055-77c2-45fa-4e88-62101d70b88b@redhat.com>
	<20181010142840.GH5738@habkost.net>
	<118ed8f7-5947-12c6-f3f6-b10597f37aac@redhat.com>
	<963e4f75-76a1-d3f3-3a03-b8de13429175@redhat.com>
	<20181011034246.GP5738@habkost.net>
	<564cbc9a-304a-4713-5311-b23ebeb10be1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <564cbc9a-304a-4713-5311-b23ebeb10be1@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/7] scripts/qemu.py: set predefined
 machine type based on arch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <pmathieu@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Laszlo Ersek <lersek@redhat.com>

On Thu, Oct 11, 2018 at 12:43:06AM -0400, Cleber Rosa wrote:
>=20
>=20
> On 10/10/18 11:42 PM, Eduardo Habkost wrote:
> > On Wed, Oct 10, 2018 at 08:17:26PM -0400, Cleber Rosa wrote:
> >>
> >>
> >> On 10/10/18 11:47 AM, Cleber Rosa wrote:
> >>>
> >>>
> >>> On 10/10/18 10:28 AM, Eduardo Habkost wrote:
> >>>> On Wed, Oct 10, 2018 at 10:15:15AM -0400, Cleber Rosa wrote:
> >>>>>
> >>>>>
> >>>>> On 10/10/18 9:59 AM, Cleber Rosa wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 10/10/18 9:46 AM, Eduardo Habkost wrote:
> >>>>>>> On Wed, Oct 10, 2018 at 08:35:38AM -0400, Cleber Rosa wrote:
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> On 10/10/18 7:00 AM, Philippe Mathieu-Daud=E9 wrote:
> >>>>>>>>> On 10/10/2018 01:26, Cleber Rosa wrote:
> >>>>>>>>>> Some targets require a machine type to be set, as there's no=
 default
> >>>>>>>>>> (aarch64 is one example).  To give a consistent interface to=
 users of
> >>>>>>>>>> this API, this changes set_machine() so that a predefined de=
fault can
> >>>>>>>>>> be used, if one is not given.  The approach used is exactly =
the same
> >>>>>>>>>> with the console device type.
> >>>>>>>>>>
> >>>>>>>>>> Also, even when there's a default machine type, for some pur=
poses,
> >>>>>>>>>> testing included, it's better if outside code is explicit ab=
out the
> >>>>>>>>>> machine type, instead of relying on whatever is set internal=
ly.
> >>>>>>>>>>
> >>>>>>>>>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> >>>>>>>>>> ---
> >>>>>>>>>>  scripts/qemu.py | 22 +++++++++++++++++++++-
> >>>>>>>>>>  1 file changed, 21 insertions(+), 1 deletion(-)
> >>>>>>>>>>
> >>>>>>>>>> diff --git a/scripts/qemu.py b/scripts/qemu.py
> >>>>>>>>>> index d9e24a0c1a..fca9b76990 100644
> >>>>>>>>>> --- a/scripts/qemu.py
> >>>>>>>>>> +++ b/scripts/qemu.py
> >>>>>>>>>> @@ -36,6 +36,15 @@ CONSOLE_DEV_TYPES =3D {
> >>>>>>>>>>      r'^s390-ccw-virtio.*': 'sclpconsole',
> >>>>>>>>>>      }
> >>>>>>>>>> =20
> >>>>>>>>>> +#: Maps archictures to the preferred machine type
> >>>>>>>>>> +MACHINE_TYPES =3D {
> >>>>>>>>>> +    r'^aarch64$': 'virt',
> >>>>>>>>>> +    r'^ppc$': 'g3beige',
> >>>>>>>>>> +    r'^ppc64$': 'pseries',
> >>>>>>>>>> +    r'^s390x$': 's390-ccw-virtio',
> >>>>>>>>>> +    r'^x86_64$': 'q35',
> >>>>>>>>>
> >>>>>>>>> Why choose Q35 rather than PC (the default)?
> >>>>>>>>>
> >>>>>>>>> I was wondering about how to generate variants/machines.json =
but this is
> >>>>>>>>> definitively something we want to do via a QMP query.
> >>>>>>>>>
> >>>>>>>>> Eduardo what do you think?
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> It was motivated by Eduardo's initiative to make q35 the defau=
lt "across
> >>>>>>>> the board".  He can confirm and give more details.
> >>>>>>>
> >>>>>>> Making Q35 the default on applications using QEMU and libvirt i=
s
> >>>>>>> something I'd like to happen.  But I think the simplest way to =
do
> >>>>>>> that is to change the QEMU default.  This way you won't need th=
is
> >>>>>>> table on qemu.py: you can just use the default provided by QEMU=
.
> >>>>>>>
> >>>>>>
> >>>>>> The idea is to bring consistency on how we're calling
> >>>>>> "qemu-system-$(ARCH)", and at the same time apply the "explicit =
is
> >>>>>> better than implicit" rule.
> >>>>>>
> >>>>>> The most important fact is that some targets do not (currently) =
have
> >>>>>> "the default provided by QEMU", aarch64 is one of them.
> >>>>>>
> >>>>>> - Cleber.
> >>>>>>
> >>>>>
> >>>>> So I ended up not relaying the question properly: should we defau=
lt
> >>>>> (even if explicitly adding "-machine") to "pc"?
> >>>>
> >>>> I think using the default machine-type (when QEMU has a default)
> >>>> would be less surprising for users of the qemu.py API.
> >>>>
> >>>
> >>> OK, agreed.
> >>>
> >>>> Implicitly adding -machine when there's no default is also
> >>>> surprising, but then it's a nice surprise: instead of crashing
> >>>> you get a running VM.
> >>>>
> >>>> Now, there are two other questions related to this:
> >>>>
> >>>> If using 'pc' as default, should we always add -machine, or just
> >>>> omit the machine-type name?  I think we should omit it unless the
> >>>> caller asked for a specific machine-type name (because it would
> >>>> be less surprising for users of the API).
> >>>>
> >>>
> >>
> >> Getting down to business, trying to apply those changes, I was faced
> >> with a situation.  Actually, the same situation I faced a few months
> >> ago.  Handling it was defered until it was *really* a blocker.
> >> Basically the issue is: the set_console() method, which gives tests =
a
> >> ready to use console, depends on knowing the machine type (see
> >> CONSOLE_DEV_TYPES).
> >>
> >> As a case study, let's look at "boot_console_linux.py":
> >>  1) it sets the machine type explicitly
> >>  2) it has nothing to do with the specific machine type
> >>  3) the setting of a machine type is boiler plate code to set a cons=
ole
> >>  4) the console is used on the test's real purpose: verifying the Li=
nux
> >> kernel booted
> >>
> >> Now, to be able to run the same test -- booting a Linux kernel -- on
> >> *other target archs*, we need the same machinery.  Even more importa=
nt:
> >> to have similar tests we'll need to either abstract those features o=
r
> >> duplicate them.  This can be seen, at least in part, on the firmware
> >> tests that Philippe sent to the list: they would also benefit from
> >> having a console device ready to be used on the configured machine t=
ype[1]:
> >>
> >> Assuming that we want to provide this type of machinery for free (or=
 as
> >> close as that) to the acceptance/functional tests, we need some sour=
ce
> >> of "known good" configuration for the targets we aim to support.
> >>
> >> Let's restrict the discussion to the issue at hand, machine types, w=
hile
> >> keeping in mind that the same pattern happened with devices types to=
 use
> >> as console before, and my experience running into default network de=
vice
> >> types in further work (tests that interact with the guest by ssh'ing
> >> into it).
> >>
> >> The solutions I can think of are:
> >>
> >>  1) run the target binary previous to the "real" run, and query
> >> information -- this is what Avocado-VT does[2], and something I trie=
d on
> >> earlier versions of the acceptance tests infrastructure code
> >>
> >>  2) attempt to get this information from the build system[3]
> >>
> >>  3) hard code the "known" good configuration
> >>
> >> I've previously worked on solutions along the lines of #1 and #2, bu=
t
> >> the general feedback wasn't that positive, for valid reasons.  Eduar=
do
> >> probably remembers this.
> >=20
> > I don't remember seeing negative feedback for #1.  It sounds like
> > the best solution.
> >=20
>=20
> IIRC, it was mostly related to the fact that the reliable way to query =
a
> target information (instead of parsing a human oriented output) would b=
e
> to use QMP.
>=20
> Then, the question of using QEMUMachine for that (and the possible
> chicken-and-egg situations, having a different set of base args, etc)
> led me into prototyping a simplified version:
>=20
> https://github.com/clebergnu/qemu/commit/b769b3d969b9e29c644d12c30cd0bb=
7f312e4fbc#diff-07b9b989eb85128c2c8d2a8f17685698R46
>=20
> Which would still be duplicating some code.  I'm not particularly happy
> about either approaches TBH.
>=20
> >>
> >> So, I'm tempted to try solution #3.  As much as duplicating target
> >> defaults in qemu.py doesn't sound perfect, it seems to be the more
> >> predictable and attainable solution at this point.
> >=20
> > I consider #3 to be acceptable just as a temporary solution until
> > we implement #1.
> >=20
> >=20
>=20
> So, with the extra information given here, would you recommend doing #3=
?
> Or pause this, and work on a #1 of sorts?

Getting more working tests is more important to me.  I won't mind
implementing #3 on the avocado_qemu module if implementing #1
first would delay the inclusion of tests on QEMU 3.1.

--=20
Eduardo
