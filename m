Received: from eggs.gnu.org ([2001:4830:134:3::10]:45045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eCPLm-0007Fx-NT
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 07:20:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eCPLl-0002jp-N9
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 07:20:58 -0500
Date: Wed, 8 Nov 2017 13:20:49 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171108122049.GE30890@localhost.localdomain>
References: <20171107172638.29942-1-kwolf@redhat.com>
	<9306085c-07c4-b6f7-5222-2b73ee706dac@redhat.com>
	<20171108100417.GA30890@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Content-Disposition: inline
In-Reply-To: <20171108100417.GA30890@localhost.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: Deprecate
 bdrv_set_read_only() and users
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com


--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 08.11.2017 um 11:04 hat Kevin Wolf geschrieben:
> Am 07.11.2017 um 21:29 hat Eric Blake geschrieben:
> > On 11/07/2017 11:26 AM, Kevin Wolf wrote:
> > > bdrv_set_read_only() is used by some block drivers to override the
> > > read-only option given by the user. This is not how read-only images
> > > generally work in QEMU: Instead of second guessing what the user real=
ly
> > > meant (which currently includes making an image read-only even if the
> > > user didn't only use the default, but explicitly said read-only=3Doff=
), we
> > > should error out if we can't provide what the user requested.
> > >=20
> > > This adds deprecation warnings to all callers of bdrv_set_read_only()=
 so
> > > that the behaviour can be corrected after the usual deprecation perio=
d.
> > >=20
> > > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > > ---
> > >  block.c       |  5 +++++
> > >  block/bochs.c | 13 ++++++++++---
> > >  block/cloop.c | 13 ++++++++++---
> > >  block/dmg.c   | 12 +++++++++---
> > >  block/rbd.c   | 14 ++++++++++----
> > >  block/vvfat.c |  6 +++++-
> > >  6 files changed, 49 insertions(+), 14 deletions(-)
> >=20
> > Dan pointed out the missing documentation, but for the code itself, the
> > approach looks sane (especially since it was my attempt to make it worse
> > by extending the idiom to NBD that triggered you to write this patch).
> >=20
> > Other documentation: In qapi/block-core.json, @BlockdevOptions, we
> > probably ought to mention under @read-only that some block drivers
> > require the use of an explicit read-only.
>=20
> Well, they don't only need an explicitly set option, but the important
> point is that they don't work with the default value. But I can add
> something to this effect.

I'll squash this in if it looks good to you:

diff --git a/qapi/block-core.json b/qapi/block-core.json
index ab96e348e6..76bf50f813 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3134,8 +3134,11 @@
 #                 This option is required on the top level of blockdev-add.
 # @discard:       discard-related options (default: ignore)
 # @cache:         cache-related options
-# @read-only:     whether the block device should be read-only
-#                 (default: false)
+# @read-only:     whether the block device should be read-only (default: f=
alse).
+#                 Note that some block drivers support only read-only acce=
ss,
+#                 either generally or in certain configurations. In this c=
ase,
+#                 the default value does not work and the option must be
+#                 specified explicitly.
 # @detect-zeroes: detect and optimize zero writes (Since 2.1)
 #                 (default: off)
 # @force-share:   force share all permission on added nodes.

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJaAvahAAoJEH8JsnLIjy/Wbk8QAIS7sL4LG0Whw7LVCcb2vrzk
1aLT3THVB8D2No6y0lzAtmEaf2RJ88Z/Vhd1qqoDwBJeGO6g1bALXAtj3nJ9+JIN
LV3ifS16gHyci6CSEHfXjcMcSeCb42mt94zwTaCy6Z0XdwJAg+53px2mxZ92P1Bg
L83VlHDV9l4+ddXDJNxky2Snz7m9IP4pGCEX3MW318y9r+saA46HThdAvVRXPw98
uWmTi4gS7LKRrof9aLLEYibc2q7a5Gf9B39awanRm1ulLp7nTaM0ovTWzsOihV6t
AvmTdR3TZ1Swcsgn3D9AvWRQO/DwxutDSsZOmIJtJ/X0AZVGUf9nLi80axKGscGA
S+8999hrP4XsEXvwvxyzfBI/pq5GzLckTSPtTN3jJUxvCjiIO7xDwvnHejGg1cf4
Z0++Jy9ltbVYKhlq30tseELIkoBW0+Of5Zb1tPtXI5mTvCmbBX9DGxztrikGXi6x
4AehPowMZbbAz4ZAJ/hYJUzcjflraOtcd/wbgb1MYJyw9f/iqPkdXXEqjhJkivne
oX8/E7OKVW9VJU8VWgX35zucAUCK3ibAK8g8UvLaUQfJpsrJwXHzz1xnaDGw4IeR
nqJCXSimmTiaqidRqsFZHzT30mslJ8QETHnAIuCxtxpx2a9mrcEUlUSdTLzOtCG/
fU3mSeLtnSKFS4qbWhim
=IsV3
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--
