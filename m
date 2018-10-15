Received: from eggs.gnu.org ([2001:4830:134:3::10]:41172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gC7hB-0004iz-2j
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 14:34:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gC7h0-0001Xh-9W
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 14:34:19 -0400
Date: Mon, 15 Oct 2018 15:33:48 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181015183348.GS31060@habkost.net>
References: <20181013050227.17022-1-ehabkost@redhat.com>
	<20181015093243.GE6785@redhat.com>
	<CAFEAcA8MQ37JVCCPGyQa20n6AuU8Sv_pC9DoDoCKdQhqekpGnQ@mail.gmail.com>
	<20181015101309.GD10459@localhost.localdomain>
	<87woqjw4o3.fsf@dusky.pond.sub.org>
	<d1335244-1aaa-a6e6-e27f-a4de6a38a785@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <d1335244-1aaa-a6e6-e27f-a4de6a38a785@de.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC] Require Python 3 for building QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Mon, Oct 15, 2018 at 08:19:18PM +0200, Christian Borntraeger wrote:
>=20
>=20
> On 10/15/2018 06:33 PM, Markus Armbruster wrote:
> > Kevin Wolf <kwolf@redhat.com> writes:
> >=20
> >> Am 15.10.2018 um 12:02 hat Peter Maydell geschrieben:
> >>> On 15 October 2018 at 10:32, Daniel P. Berrang=E9 <berrange@redhat.=
com> wrote:
> >>>> On Sat, Oct 13, 2018 at 02:02:27AM -0300, Eduardo Habkost wrote:
> >>>>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> >>>>> ---
> >>>>> I'd like to do this in QEMU 3.1.  I think it's time to drop
> >>>>> support for old systems that have only Python 2.
> >>>>>
> >>>>> We still have a few scripts that are not required for building
> >>>>> QEMU that still work only with Python 2 (iotests being the most
> >>>>> relevant set).  Requiring Python 3 for building QEMU won't
> >>>>> prevent people from using those scripts with Python 2 until they
> >>>>> are finally ported.
> >>>>
> >>>> I think it is premature & unecessary to do this. We just got QEMU =
building
> >>>> with dual Python2/3 in 3.0 to give people leeway in the migration =
path to
> >>>> a fully v3 future. The code to support building 2/3 in parallel is=
 not
> >>>> imposing a unreasonable maint burden. Dropping py2 suport would ha=
ve
> >>>> negligible impact on the code, as there's no v3-only features we h=
ave
> >>>> used. IOW, I don't think there's a compelling reason to rush into =
forcing
> >>>> users onto v3.
> >>>>
> >>>> If we want to drop py2, we should give people a warning of such a =
planned
> >>>> change, especially since some of our targetted host OS[1] don't ev=
en
> >>>> include a py3 as standard without acquiring extra add-on repos. De=
vs in
> >>>> a typical corporate env will not have the freedom to install such =
extra
> >>>> repos on their machines.
> >>>
> >>> I agree. I also think that dropping python 2 support before we've
> >>> even converted all our python scripts to handle python 3 is the
> >>> wrong order to do things. People interested in moving forward with
> >>> the transition to python-3-only should start by making sure everyth=
ing
> >>> we have works with python 3...
> >>
> >> It's easier to port stuff to Python 3 though than making them work w=
ith
> >> both. I think Eduardo's RFC is in part motivated by a patch from
> >> Philippe that converted something in iotests to work with Python 3,
> >> passed review and then turned out to break Python 2.
> >=20
> > Seconded.  This is not about the cost of maintaining existing
> > compatibility gunk, it's about the extra effort to first get the
> > remainder to work with 2 and 3, only to throw away 2 a few months lat=
er.
> >=20
> > I propose we permit ourselves to port stuff that isn't essential to
> > building QEMU straight to 3 instead.  This includes iotests.
> >=20
> >> Having to test every iotests patch twice with different Python versi=
ons
> >> isn't something I would like to do for extended periods of time.
> >=20
> > It's worth doing only if the benefits of doing it outweigh the costs.=
  I
> > don't think they do.
>=20
> FWIW, I do not care about python 2 vs 3. I just want to emphasize that =
I=20
> consider the qemu iotest a very valuable part of the qemu test suite as=
 it
> has detected a lot of regressions over the past years. So as long as we=
 keep
> that running I am fine.

It depends where exactly one needs to keep them running.  Does
anybody need to run iotests for QEMU 3.0+ builds in systems where
it's impossible to install Python 3?

If somebody really needs that, then I'd kindly ask them to
volunteer to do the extra work to make iotests compatible with
both Python 2 and 3.

--=20
Eduardo
