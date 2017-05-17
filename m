Received: from eggs.gnu.org ([2001:4830:134:3::10]:55864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dB1pl-0008Lh-KW
	for qemu-devel@nongnu.org; Wed, 17 May 2017 12:29:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dB1ph-0000EC-NN
	for qemu-devel@nongnu.org; Wed, 17 May 2017 12:29:57 -0400
Received: from 5.mo3.mail-out.ovh.net ([87.98.178.36]:46421)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dB1ph-0000Cf-GL
	for qemu-devel@nongnu.org; Wed, 17 May 2017 12:29:53 -0400
Received: from player797.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id A214ACF501
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 18:29:45 +0200 (CEST)
Date: Wed, 17 May 2017 18:29:38 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170517182938.0c7f366e@bahia.lan>
In-Reply-To: <2c0e99ce-f3cb-90e8-baed-8fad9d39455b@redhat.com>
References: <1494405683-20877-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1494405683-20877-5-git-send-email-pradeep.jagadeesh@huawei.com>
	<6a035cd9-34f9-c1f5-e986-404daf941641@redhat.com>
	<57a24e21-0864-16d3-1bce-ad801875ea9f@huawei.com>
	<2c0e99ce-f3cb-90e8-baed-8fad9d39455b@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_//xD.g4qEpZG5ziA.e1Km73t";
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
To: Eric Blake <eblake@redhat.com>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, alberto garcia <berto@igalia.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

--Sig_//xD.g4qEpZG5ziA.e1Km73t
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 17 May 2017 10:28:33 -0500
Eric Blake <eblake@redhat.com> wrote:

> On 05/17/2017 09:53 AM, Pradeep Jagadeesh wrote:
>=20
> >>> +#ifdef _WIN64
> >>> +
> >>> +void qmp_fsdev_set_io_throttle(IOThrottle *arg, Error **errp)
> >>> +{
> >>> +  return;
> >>> +}
> >>> +
> >>> +IOThrottleList *qmp_query_fsdev_io_throttle(Error **errp)
> >>> +{
> >>> +    abort();
> >>> +}
> >>> +
> >>> +#endif =20
> >>
> >> I think you're missing an addition to monitor.c
> >> qmp_unregister_commands_hack() if you intend for this command to be
> >> available only on non-windows platforms (and is your #ifdef the correct
> >> name, or is this a Linux-only feature rather than a non-windows featur=
e). =20
> > I had to add this one here because, I was getting some error when I
> > cross compile for Windows. But I do not have any idea about, do I need
> > to add in monitor.c or not. =20
>=20
> First point: is fsdev a Linux-only feature, or can it be compiled on
> BSD?  If it is Linux-only, then compiling a stub for Windows will still
> leave BSD broken, and your #ifdef is wrong.  Fixing compilation on mingw
> is nice, but not the only platform to worry about.
>=20

fsdev compilation currently depends on CONFIG_VIRTFS which is a Linux-only
feature for the moment. There was a tentative to support it on Windows hosts
two years ago but it stayed at the RFC stage.

But even on Linux hosts, the current fsdev implementation also depends on
the target supporting PCI and VIRTIO. We have a fsdev/qemu-fsdev-dummy.c
file to put stubs so that we don't pull all the code for such targets.

Maybe this could be reused for the above stubs as well ?

> Second point: if fsdev is indeed a platform-specific feature, then we
> don't want to advertise the QMP commands that are useless when running
> on a platform that doesn't support it. Anywhere you have to add a stub
> for compilation means you ALSO need to patch monitor.c to unregister the
> command from being advertised as a valid QMP command.  (If you used
> #ifdef __LINUX__ to guard the working version, and #ifndef __LINUX__ to
> declare the stub, then the monitor.c needs an #ifndef section within
> qmp_unregister_commands_hack() to tell QMP to not advertise the stubs.)
>=20


--Sig_//xD.g4qEpZG5ziA.e1Km73t
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkcenIACgkQAvw66wEB28KsEQCfbue3vYU9ztzvPrc5Sb+DKj0J
IngAn3lyX6EW+RP5EbjGFPiD3LNWv6yy
=f5cI
-----END PGP SIGNATURE-----

--Sig_//xD.g4qEpZG5ziA.e1Km73t--
