Received: from eggs.gnu.org ([2001:4830:134:3::10]:58703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dJFtb-0006sX-DI
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 05:07:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dJFtX-0007df-7a
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 05:07:55 -0400
Received: from 7.mo178.mail-out.ovh.net ([46.105.58.91]:38089)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dJFtX-0007dO-14
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 05:07:51 -0400
Received: from player728.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id AE38A3EC62
	for <qemu-devel@nongnu.org>; Fri,  9 Jun 2017 11:07:48 +0200 (CEST)
Date: Fri, 9 Jun 2017 11:07:41 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170609110741.5ef3e49d@bahia.ttt.fr.ibm.com>
In-Reply-To: <d08e5a11-0b75-a111-40c4-2f09f37404b1@huawei.com>
References: <1494405683-20877-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1494405683-20877-5-git-send-email-pradeep.jagadeesh@huawei.com>
	<6a035cd9-34f9-c1f5-e986-404daf941641@redhat.com>
	<57a24e21-0864-16d3-1bce-ad801875ea9f@huawei.com>
	<2c0e99ce-f3cb-90e8-baed-8fad9d39455b@redhat.com>
	<20170517182938.0c7f366e@bahia.lan>
	<6df407d5-4145-2e90-a7eb-b047819ceb75@redhat.com>
	<e1d5b2d3-bfe7-4fac-03f7-bbfbd5de10fe@huawei.com>
	<20170608184915.20056e6c@bahia.ttt.fr.ibm.com>
	<d08e5a11-0b75-a111-40c4-2f09f37404b1@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/cfY4/pG=2WbAyo3FfzqXZj0";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v4 4/4] fsdev: QMP interface for throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Cc: Eric Blake <eblake@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>, alberto garcia <berto@igalia.com>, qemu-devel@nongnu.org, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>

--Sig_/cfY4/pG=2WbAyo3FfzqXZj0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 9 Jun 2017 10:31:58 +0200
Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com> wrote:

> On 6/8/2017 6:49 PM, Greg Kurz wrote:
> > On Thu, 18 May 2017 15:30:06 +0200
> > Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com> wrote:
> > =20
> >> On 5/17/2017 7:09 PM, Eric Blake wrote: =20
> >>> On 05/17/2017 11:29 AM, Greg Kurz wrote:
> >>> =20
> >>>>>
> >>>>> First point: is fsdev a Linux-only feature, or can it be compiled on
> >>>>> BSD?  If it is Linux-only, then compiling a stub for Windows will s=
till
> >>>>> leave BSD broken, and your #ifdef is wrong.  Fixing compilation on =
mingw
> >>>>> is nice, but not the only platform to worry about.
> >>>>> =20
> >>>>
> >>>> fsdev compilation currently depends on CONFIG_VIRTFS which is a Linu=
x-only
> >>>> feature for the moment. There was a tentative to support it on Windo=
ws hosts
> >>>> two years ago but it stayed at the RFC stage.
> >>>>
> >>>> But even on Linux hosts, the current fsdev implementation also depen=
ds on
> >>>> the target supporting PCI and VIRTIO. We have a fsdev/qemu-fsdev-dum=
my.c
> >>>> file to put stubs so that we don't pull all the code for such target=
s.
> >>>>
> >>>> Maybe this could be reused for the above stubs as well ? =20
> >>>
> >>> That helps.  The stub should live in qemu-fsdev-dummy.c (where it
> >>> shouldn't need any #ifdef, because that file is only compiled when the
> >>> condition is false), and...
> >>> =20
> >>>> =20
> >>>>> Second point: if fsdev is indeed a platform-specific feature, then =
we
> >>>>> don't want to advertise the QMP commands that are useless when runn=
ing
> >>>>> on a platform that doesn't support it. Anywhere you have to add a s=
tub
> >>>>> for compilation means you ALSO need to patch monitor.c to unregiste=
r the
> >>>>> command from being advertised as a valid QMP command.  (If you used
> >>>>> #ifdef __LINUX__ to guard the working version, and #ifndef __LINUX_=
_ to
> >>>>> declare the stub, then the monitor.c needs an #ifndef section within
> >>>>> qmp_unregister_commands_hack() to tell QMP to not advertise the stu=
bs.) =20
> >>>
> >>> monitor.c should wrap the unregister under #ifndef CONFIG_VIRTFS (rat=
her
> >>> than a particular platform name). =20
> >> I did unregister the functions as mentioned above in monitor.c. But it
> >> does not address the issue when I run "make docker-test-mingw@fedora".=
 =20
> >
> > What issue is this ?
> >
> > I cannot even run this with your unmodified series (please note that I
> > always build out-of-tree). =20
> The issue is when I cross build the qemu, I was facing the compilation=20
> issue. Even it failed in patchew. So, I had to add the dummy functions=20
> in monitor.c and qmp.c.
>=20

I see no dummy functions in monitor.c ...

As said above, I cannot even reach that point with my out-of-tree build
setup:

  GEN     qmp-commands.h
/tmp/qemu-test/src/qapi-schema.json:85: No such file or directory: qapi/fsd=
ev.json
Makefile:438: recipe for target 'qmp-commands.h' failed

Please fix that.

> -Pradeep
> >> I think the VIRTFS is still enabled.
> >> Only having dummy functions even in qmp.c addresses the issue.
> >>
> >> Regards,
> >> Pradeep =20
> >>> =20
> >>
> >> =20
> > =20
>=20


--Sig_/cfY4/pG=2WbAyo3FfzqXZj0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlk6ZV0ACgkQAvw66wEB28KprQCdFyeWfHYuShv0s86Erhq00utv
VhIAn0IBHi6ohxq+zL6D6PM3Qq9lGPf4
=TmJe
-----END PGP SIGNATURE-----

--Sig_/cfY4/pG=2WbAyo3FfzqXZj0--
