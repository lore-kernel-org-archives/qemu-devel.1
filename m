Received: from eggs.gnu.org ([2001:4830:134:3::10]:43147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gAGT6-0007hq-QP
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 11:32:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gAGT2-0002WH-JL
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 11:32:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gAGT2-0002V8-4V
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 11:32:08 -0400
Date: Wed, 10 Oct 2018 16:31:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181010153141.GL10973@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181009232607.15521-1-crosa@redhat.com>
	<20181009232607.15521-5-crosa@redhat.com>
	<835fcb24-5832-9e6c-9f57-0364f0bf849a@redhat.com>
	<95a8561c-0511-6a8a-a3eb-25d556029e7a@redhat.com>
	<20181010134656.GE5738@habkost.net>
	<47f72e98-335f-b3c9-54c7-4c8a468d85d6@redhat.com>
	<26fe2055-77c2-45fa-4e88-62101d70b88b@redhat.com>
	<20181010142840.GH5738@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181010142840.GH5738@habkost.net>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Cleber Rosa <crosa@redhat.com>, Fam Zheng <famz@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <pmathieu@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>

On Wed, Oct 10, 2018 at 11:28:40AM -0300, Eduardo Habkost wrote:
> On Wed, Oct 10, 2018 at 10:15:15AM -0400, Cleber Rosa wrote:
> >=20
> >=20
> > On 10/10/18 9:59 AM, Cleber Rosa wrote:
> > >=20
> > >=20
> > > On 10/10/18 9:46 AM, Eduardo Habkost wrote:
> > >> On Wed, Oct 10, 2018 at 08:35:38AM -0400, Cleber Rosa wrote:
> > >>>
> > >>>
> > >>> On 10/10/18 7:00 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> > >>>> On 10/10/2018 01:26, Cleber Rosa wrote:
> > >>>>> Some targets require a machine type to be set, as there's no de=
fault
> > >>>>> (aarch64 is one example).  To give a consistent interface to us=
ers of
> > >>>>> this API, this changes set_machine() so that a predefined defau=
lt can
> > >>>>> be used, if one is not given.  The approach used is exactly the=
 same
> > >>>>> with the console device type.
> > >>>>>
> > >>>>> Also, even when there's a default machine type, for some purpos=
es,
> > >>>>> testing included, it's better if outside code is explicit about=
 the
> > >>>>> machine type, instead of relying on whatever is set internally.
> > >>>>>
> > >>>>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > >>>>> ---
> > >>>>>  scripts/qemu.py | 22 +++++++++++++++++++++-
> > >>>>>  1 file changed, 21 insertions(+), 1 deletion(-)
> > >>>>>
> > >>>>> diff --git a/scripts/qemu.py b/scripts/qemu.py
> > >>>>> index d9e24a0c1a..fca9b76990 100644
> > >>>>> --- a/scripts/qemu.py
> > >>>>> +++ b/scripts/qemu.py
> > >>>>> @@ -36,6 +36,15 @@ CONSOLE_DEV_TYPES =3D {
> > >>>>>      r'^s390-ccw-virtio.*': 'sclpconsole',
> > >>>>>      }
> > >>>>> =20
> > >>>>> +#: Maps archictures to the preferred machine type
> > >>>>> +MACHINE_TYPES =3D {
> > >>>>> +    r'^aarch64$': 'virt',
> > >>>>> +    r'^ppc$': 'g3beige',
> > >>>>> +    r'^ppc64$': 'pseries',
> > >>>>> +    r'^s390x$': 's390-ccw-virtio',
> > >>>>> +    r'^x86_64$': 'q35',
> > >>>>
> > >>>> Why choose Q35 rather than PC (the default)?
> > >>>>
> > >>>> I was wondering about how to generate variants/machines.json but=
 this is
> > >>>> definitively something we want to do via a QMP query.
> > >>>>
> > >>>> Eduardo what do you think?
> > >>>>
> > >>>
> > >>> It was motivated by Eduardo's initiative to make q35 the default =
"across
> > >>> the board".  He can confirm and give more details.
> > >>
> > >> Making Q35 the default on applications using QEMU and libvirt is
> > >> something I'd like to happen.  But I think the simplest way to do
> > >> that is to change the QEMU default.  This way you won't need this
> > >> table on qemu.py: you can just use the default provided by QEMU.
> > >>
> > >=20
> > > The idea is to bring consistency on how we're calling
> > > "qemu-system-$(ARCH)", and at the same time apply the "explicit is
> > > better than implicit" rule.
> > >=20
> > > The most important fact is that some targets do not (currently) hav=
e
> > > "the default provided by QEMU", aarch64 is one of them.
> > >=20
> > > - Cleber.
> > >=20
> >=20
> > So I ended up not relaying the question properly: should we default
> > (even if explicitly adding "-machine") to "pc"?
>=20
> I think using the default machine-type (when QEMU has a default)
> would be less surprising for users of the qemu.py API.
>=20
> Implicitly adding -machine when there's no default is also
> surprising, but then it's a nice surprise: instead of crashing
> you get a running VM.
>=20
> Now, there are two other questions related to this:
>=20
> If using 'pc' as default, should we always add -machine, or just
> omit the machine-type name?  I think we should omit it unless the
> caller asked for a specific machine-type name (because it would
> be less surprising for users of the API).
>=20
> About our default testing configuration for acceptance tests:
> should acceptance tests run against PC by default?  Should it
> test Q35?  Should we test both PC and Q35?  I'm not sure what's
> the answer, but I think these decisions shouldn't affect the
> qemu.py API at all.

As a general goal we should be aiming to test everything we provide
to users if, we expect them to actually use it and not have it
break later :-)

Given that 'pc' has been the default for entire existance of QEMU,
99% of guests are using 'pc' and thus we definitely want to be
testing it.

Equally we'd like to encourage use of 'q35' so we should also be
testing that, even though it has very little usage right now.

Thus, we really need to be running any tests against both machine
types.  If we do that, then the question of default doesn't really
matter as one of them is always not the default and needs testing
regardless.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
