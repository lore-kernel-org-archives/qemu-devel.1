Received: from eggs.gnu.org ([2001:4830:134:3::10]:38659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1faihL-0002Bk-CM
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 10:24:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1faihK-0003kt-3L
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 10:23:59 -0400
Date: Wed, 4 Jul 2018 16:23:49 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180704142349.GF4334@localhost.localdomain>
References: <20180625095322.GC18580@redhat.com>
	<20180625114106.GJ5024@localhost.localdomain>
	<20180625114528.GL16514@angien.pipo.sk>
	<20180702080411.GA4299@localhost.localdomain>
	<60f6bf3c-6cad-c86f-01d7-8c376a6ccfe0@de.ibm.com>
	<20180703111949.GB24516@redhat.com>
	<20180703113229.GD3812@localhost.localdomain>
	<20180704150256.408d4a07.cohuck@redhat.com>
	<20180704133440.GE4334@localhost.localdomain>
	<20180704134320.GI32267@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180704134320.GI32267@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [libvirt] [PULL 25/26] block: Remove deprecated
 -drive option serial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Boris Fiuczynski <fiuczy@linux.ibm.com>, qemu-block@nongnu.org, libvir-list@redhat.com, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Peter Krempa <pkrempa@redhat.com>

Am 04.07.2018 um 15:43 hat Daniel P. Berrang=E9 geschrieben:
> On Wed, Jul 04, 2018 at 03:34:40PM +0200, Kevin Wolf wrote:
> > I understand where you're coming from, but let's be honest: It's not =
as
> > if disk geometry or serial numbers were features that absolutely need
> > to be there to give QEMU any testing.
>=20
> I'd venture to suggest disk geometry is almost never used in practice.
>=20
> serial strings, however, are pretty common, used by default in fact
> by openstack.

Interesting, good to know.

> > Also, my understanding has always been that we expect users to have a
> > libvirt version that isn't older than QEMU. It would be useful to set=
 a
> > clear policy for this and document it.
>=20
> My understanding was actually mostly the opposite. We'll try not to
> /knowingly/ break existing libvirt version if reasonable. We've not
> always followed that, either by accident, or even intentionally in
> some cases. What's never defined is just how old libvirt we care about
> not breaking.

Hm, that used to be true, yes. I still seem to remember that we've
always expected a new libvirt version. Was that only about new features
then?

However, the deprecation policy essentially says that we will now
knowingly break existing libvirt versions. With it, we also defined that
we definitely don't care about libvirt versions older than QEMU n-2.
You're right that we're not really making a statement for libvirt
versions newer than that.

> In the case of QEMU libvirt will in fact be fixed before QEMU 3.0 is
> released, but only by a week or so.

Probably two weeks because QEMU never does without the extra RC, but
that doesn't make a big difference.

> I think its mostly a case of being pragmatic about what we do in this
> respect, rather than defining a hard rule.
>=20
> In this case I'd personally lean towards reverting this patch, since
> merging it was not a critical blocker to other work that went into
> 3.0 IIUC. So block maintaniers burden shouldn't be impacted by a
> temporary revert and then re-merge when 3.1 opens.

Having to remember to really bring it back to life after the release is
a maintainer burden, which is one of the reasons why I don't want this
"extended" deprecation process to become the norm.

If it stays a one-time thing, and given that we're now in the freeze
and a block-next branch will be active anyway, I'm okay with a temporary
revert.

> > > I think it would be really beneficial to general QEMU test coverage=
 to
> > > push deleting this option back a release or two. We should make tes=
ting
> > > QEMU in conjunction with libvirt as uncomplicated as possible.
> >=20
> > Essentially, what is important to me isn't getting these options drop=
ped
> > exactly in 3.0, but not setting a bad precedence that deprecation isn=
't
> > actually worth anything. We may easily end up with this deprecation
> > process:
> >=20
> > depreate a feature
> > release QEMU version n + 1
> > release QEMU version n + 2
> > remove the feature
> > while libvirt hasn't removed use of the feature:
> >     # ...and why should it when everything is still working?
> >     reinstate the feature
> >     release QEMU version n + x
> >     remove the feature
>=20
> Yeah, we definitely don't want to get into that kind of mess
> in general.
>=20
> > When management tools know that this is the process, the motivation t=
o
> > remove the use of the feature gets even lower (not out of malice, but
> > because there will be always more important things), so this will
> > "optimise" itself into an endless loop and we're back to never actual=
ly
> > removing old cruft that impedes development.
> >=20
> > The libvirt patch has just been merged (and I'm almost sure that this
> > wouldn't have happened so quickly if I had just reverted the patch ri=
ght
> > away), so at least we know now that this specific instance of the loo=
p
> > is going to terminate.
> >=20
> > What's left is first and foremost that we need to sort out our broken
> > deprecation mechanism, and if that gets done, I don't mind if someone
> > wants to revert the patch for 3.0 as long as they also take care that=
 it
> > gets back into 3.1.
>=20
> What I think this really highlights is
>=20
>  - Lack of libvirt paying attention to deprecations
>  - Lack of a way to get good diagnostic of violations when testing
>=20
> The first thing is just a human problem on libvirt side.
>=20
> The second thing could be addressed in code if there was an env variabl=
e
> or cli option to turn all use of deprecated features into abort()s in
> QEMU. That way libvirt automated testing against git master would have
> a way to identify places where we use deprecated feature.

The first one is basically just a result of the second. I think the most
important improvement will be finding a way how to break things early
for libvirt developers, but keep them working with a warning for
everyone else.

As a more short-term thing, is someone from libvirt looking at other
present deprecations in QEMU and what needs to be done for them?

Kevin
