Received: from eggs.gnu.org ([2001:4830:134:3::10]:60237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eotdG-00040X-1b
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 11:22:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eotdE-0003Ol-LX
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 11:22:06 -0500
Date: Thu, 22 Feb 2018 17:21:47 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180222162147.GL4147@localhost.localdomain>
References: <20180205151835.20812-1-mreitz@redhat.com>
	<20180205151835.20812-4-mreitz@redhat.com>
	<20180222133956.GG4147@localhost.localdomain>
	<a28d1832-cdf2-3413-a0f3-a885dfaa2375@redhat.com>
	<20180222151210.GK4147@localhost.localdomain>
	<c5a34045-7c8f-f37b-8fc6-a5338cedc2bf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uZ3hkaAS1mZxFaxD"
Content-Disposition: inline
In-Reply-To: <c5a34045-7c8f-f37b-8fc6-a5338cedc2bf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 03/26] block: Add BDS.backing_overridden
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>


--uZ3hkaAS1mZxFaxD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 22.02.2018 um 16:17 hat Max Reitz geschrieben:
> On 2018-02-22 16:12, Kevin Wolf wrote:
> > Am 22.02.2018 um 15:55 hat Max Reitz geschrieben:
> >> On 2018-02-22 14:39, Kevin Wolf wrote:
> >>> Am 05.02.2018 um 16:18 hat Max Reitz geschrieben:
> >>>> If the backing file is overridden, this most probably does change the
> >>>> guest-visible data of a BDS. Therefore, we will need to consider thi=
s in
> >>>> bdrv_refresh_filename().
> >>>>
> >>>> Adding a new field to the BDS is not nice, but it is very simple and
> >>>> exactly keeps track of whether the backing file has been overridden.
> >>>
> >>> ...as long as we manage to actually keep it up to date all the time.
> >>>
> >>> First of all, what I'm missing here (or in fact in the comment in the
> >>> code) is a definition what "overridden" really means. "specified by t=
he
> >>> user" is kind of vague: You consider the backing file relationship for
> >>> snapshot=3Don as user specified, even though the user wasn't explicit
> >>> about this. On the other hand, creating a live snapshot results in a
> >>> node that isn't user specified.
> >>>
> >>> Isn't the real question to ask whether the default backing file (taken
> >>> from the image header) would result in the same tree? The answer to t=
his
> >>> changes after more operations, like qmp_change_backing_file().
> >>
> >> With you so far.
> >>
> >>> Considering that there are so many ways to change the answer, I think
> >>> the simplest reliable option isn't a new BDS field that needs to upda=
ted
> >>> everywhere, but looking at the current value of bs->options and
> >>> bs->backing_file and see if they match.
> >>
> >> I don't see how that is simple.  First, bs->options does not necessari=
ly
> >> reflect the "current options", those would be bs->full_open_options.
> >> And for generating that, we need a way to determine whether the backing
> >> file has been overridden or not, so whether we need to put the backing
> >> options into it or whether we do not.
> >=20
> > For the purpose of this comparison, we need a set of options that
> > contains the backing file options unconditionally.
> >=20
> >> (I am right that bs->backing_file is what the image header says, right?
> >> So we need to compare it against something that reflects the runtime s=
tate.)
> >=20
> > I think so, yes.
> >=20
> >> What I could see would be comparing bs->backing_file to
> >> bs->backing->bs->filename.  But this sounds very hacky to me.
> >>
> >> One thing the comes to mind is that it can break whenever
> >> bdrv_refresh_filename() is clever.  So you specify
> >> 'json:{"driver":"null-co"}' in the image header, and
> >> bdrv_refresh_filename() optimizes that to "null-co://".  Now the
> >> filenames differ even though it's still the original filename.  So this
> >> wouldn't work very well either.

So what's the full effect here?

You example says that if you use an overcomplicated way to specify an
image (by using json: instead of an URL), you get back an
overcomplicated filename for the parent image (which includes the
backing file even though it's not really necessary). Sounds fair enough
to me.

Can bad things happen with absolute vs. relative paths?

> > On the other hand, the problem with your current approach is that it
> > results in a JSON filename even if you override the backing file and
> > specify the same file name as we already have in the image header.
>=20
> Yes.
>=20
> > In the future, libvirt is going to manually build the graph, so we will
> > always have the backing file overridden according to the logic in this
> > patch. I don't think we want to get JSON filenames for all libvirt
> > managed VMs, so can we realistically do without any kind of comparison?
>=20
> libvirt doesn't need to query the filename, though, does it?

I know that libvirt uses the output in qemu-img info. And I learnt about
that because they were surprised that json: filenames you get there
can't necessarily be fed to QMP (because they contain only strings).

Other than that, I hope they don't. I suppose the filename can end up in
error messages in logfiles, though.

> In my mind, we wanted to phase out filenames and basically only present
> them as convenience/legacy information to users who use qemu directly.
>=20
> I really don't see the point of burdening qemu with simplifying and
> niceifying filenames when you want to use node names for everything
> anyway.

But if you essentially say "filenames are only for those who don't use
advanced features", then why bother with overridden backing files?

There are two problems I have with this patch: The first is that it
introduces additional state that needs to be managed correctly in all
future patches that modify the graph, and the second (and worse one) is
that it fails to manage this state correctly even now.

I mentioned snapshots and change-backing-file that can result in a wrong
bs->backing_overridden, and those were only the obvious first places I
had a look at. Even if you fix them, I wouldn't trust my own review to
find all relevant places. And that's a really bad sign for a design.

This is the most important reason why I'm looking for some method to
derive the flag from already existing state.

Kevin

--uZ3hkaAS1mZxFaxD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJaju4bAAoJEH8JsnLIjy/WPl0QAJJhVtQYZS/eFM35zt39z4ut
Lg4znNc8HVYlopihxj7arzMuAfN5Wl8ys789y/ikGSR/wSTS5tVW5rK0k3Ej9Ejr
/9rj9XBu9SgXS1t3+PHT99GAMV9/LmtLOIpKWbx7cuABu/QZmRvO3vKZtpJwMei+
pA7N/eIsvLsqvA9673YguNouXKJVfbWjznXslPKLhR+wcS8IbOlEI96cmDNA51S3
No1FQCincxFWgRRx3J8jwSTlg5jf9XjYm2xIiS3izqBEaaPIQ1fw1Sl+NJ1VVKvu
iQ3KVDGSlCekv+owpLSg7Y8sqrXVLvvFntquuM4c12d292A+aKxCV08U4lHOd0NB
ogOSvl0g9TumRpWgluHXOI2YU/XpD5lwUBcBPqXtkicPVDHw6nEYD42/1FL0IXIf
TIV/rYO4/g/5SYNb1MFThQ5CMPG4siHsuvmqQLFXgMpwZvmPqSvU7rTuFJLGLiKw
nRBPERxPv+AZAJkvUFw2H4TZIjbHGqs2fy8lu8ZRhrNRDJIdfcpz6LdsWNSDOSz5
UppP5HbTXskMIysjdRN1slMponitGkA2UapatLfKa1H/CEwRiB4I6q2d7OgAZa1X
urmpqyWXQCS5AiAB5rcoyhzsgNrzYYgyt8WPGS8/Rw/MTWlPheh0FBn/WOug+qmu
KyVw1CwHFByprgZUZSD6
=lxCg
-----END PGP SIGNATURE-----

--uZ3hkaAS1mZxFaxD--
