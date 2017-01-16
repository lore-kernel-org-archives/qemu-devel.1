Received: from eggs.gnu.org ([2001:4830:134:3::10]:52343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cTGkd-0000IJ-2z
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 18:31:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cTGkZ-0000zP-Vy
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 18:31:47 -0500
Date: Tue, 17 Jan 2017 08:33:22 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170116213322.GE15853@umbus>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
	<CAFEAcA9fENz1=__4-upW=HLZJ50pAYkA4H2T13wDs62PNDXK3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GxcwvYAGnODwn7V8"
Content-Disposition: inline
In-Reply-To: <CAFEAcA9fENz1=__4-upW=HLZJ50pAYkA4H2T13wDs62PNDXK3A@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/67] ppc-for-2.9 queue 20170112
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alexander Graf <agraf@suse.de>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Roth <mdroth@linux.vnet.ibm.com>


--GxcwvYAGnODwn7V8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 13, 2017 at 10:54:33AM +0000, Peter Maydell wrote:
> On 12 January 2017 at 02:02, David Gibson <david@gibson.dropbear.id.au> w=
rote:
> > The following changes since commit b44486dfb9447c88e4b216e730adcc780190=
852c:
> >
> >   Merge remote-tracking branch 'remotes/kraxel/tags/pull-ui-20170110-1'=
 into staging (2017-01-10 14:52:34 +0000)
> >
> > are available in the git repository at:
> >
> >   git://github.com/dgibson/qemu.git tags/ppc-for-2.9-20170112
> >
> > for you to fetch changes up to 229b5b6b56db9c3e6b8f44b4b55a62fa32979f47:
> >
> >   ppc: Fix a warning in bcdcfz code and improve BCD_DIG_BYTE macro (201=
7-01-12 10:21:49 +1100)
> >
> > ----------------------------------------------------------------
> > ppc patch queue 2017-01-12
> >
> > This is the first ppc pull request for qemu-2.9.  It's been a while
> > coming, partly due to dealing with some problems running my usual set
> > of tests.  So, there's quite a lot in here.
> >
> >     * More POWER9 instruction implementations for TCG
> >     * The simpler parts of my CPU compatibility mode cleanup
> >         * This changes behaviour to prefer compatibility modes over
> >           "raW" mode for new machine type versions
> >     * New "40p" machine type which is essentially a modernized and
> >       cleaned up "prep".  The intention is that it will replace "prep"
> >       once it has some more testing and polish.
> >     * Add pseries-2.9 machine type
> >     * Implement H_SIGNAL_SYS_RESET hypercall
> >     * Consolidate the two alternate CPU init paths in pseries by
> >       making it always go through CPU core objects to initialize CPU
> >     * A handful of bugfixes and cleanups
> >
> > There are also some changes not strictly related to ppc code, but for
> > its benefit:
> >
> >     * Limit the pxi-expander-bridge (PXB) device to x86 guests only
> >       (it's essentially a hack to work around historical x86
> >       limitations)
> >     * Revise a number of qtests and enable them for ppc
>=20
> Hi -- this fails "make check" on OSX host:

Bother.  I saw the failure on Travis, but I was misled by all the SASL
warnings, and assumed it was an upstream / library problem, not
something with my patches.

>   GTESTER check-qtest-ppc64
> qemu-system-ppc64: -object
> memory-backend-file,id=3Dmb1,size=3D1M,share,mem-path=3D/dev/shm/qtest-68=
237-4247260626:
> invalid object type: memory-backend-file
> Broken pipe
> GTester: last random seed: R02Sc13bf53b8b3055a3c30552f67d7c263b
> **
> ERROR:/Users/pm215/src/qemu-for-merges/tests/libqos/pci.c:412:void
> qpci_plug_device_test(const char *, const char *, uint8_t, const char
> *): assertion failed: (!qdict_haskey(response, "error"))
> GTester: last random seed: R02Sf3594a21c711ec941d5f4c89724ce12d
> qemu-system-ppc64: -device ivshmem-plain,memdev=3Dmb1: 'ivshmem-plain'
> is not a valid device model name
> Broken pipe
>=20
> It looks like you've enabled the ivshmem test unconditionally,
> but it should only be turned on if CONFIG_EVENTFD is true, see
> how we do this for x86:
>=20
> check-qtest-pci-$(CONFIG_EVENTFD) +=3D tests/ivshmem-test$(EXESUF)
> gcov-files-pci-y +=3D hw/misc/ivshmem.c

Ah, right, thanks.

> Q: can we just enable these tests for PCI with
> check-qtest-ppc64-y +=3D $(check-qtest-pci-y)
> gcov-files-ppc64-y +=3D $(gcov-files-pci-y)
>=20
> the way we do for i386/x86_64 ? Or is that doing too much
> unwanted extra testing?

As Laurent says, that doesn't quite work, but we can still put the
test on CONFIG_EVENTFD in.  I've put a draft fix into my tree, but I
probably won't get a chance to properly test and resend until after
I'm back from LCA and holidays, around the end of Jan.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GxcwvYAGnODwn7V8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYfTwcAAoJEGw4ysog2bOShMwP/3XWqK/G7+jYjjC0TZb65b0t
yQSFMXDzuqF/UbZlm+SRJaZyQTGe+4QtotUWKNB7cUKEMHfe+YuWP1Ch3dqQRkZ0
RWks4bNb2iE85CwlLbCKduWuBTrb+QqVd060f9RX9p3Yk8cLwNH/WM9gWr8orPmr
sIRrtjS/8ZMwwi/MzKTs8y7GNBb4OP9CZIkI0cn31aeLQGpn13ij4nbEEnW1b0nU
SLLouIjC0IMlu6D6NDXeaBNyayRORvGmNm+q5frQOanJmjCUmKnSvaT2BYIblKQJ
n9mjHnBH94AH03jhBGVgHoAtmX8J6FFid4sE1TgQhdbb642plRrIGvqWodEwCWVU
cQgp7GAFcvT/UAofifFGCiyW1N99cKhKsGpgbJU5vzRS+DGkWLLGUuwprPaGnbn6
hjZd1CsQIqtAO5r9piT9YhE8LKSqlrbtX4F67GWhrVnyd3+QtTRgG0dDXhX1/1ow
gpSX3W5dgomKNS07fI/Jaw0n3inLih2rU4Pwvv1YOSs/PrVSWms8B6mSrpwye6eX
3zPi58he/uwnJqBFH6HHOoYhKgunEEjRD7zRRcwG5boNNq0+2fm/pFtbuc7NJYF/
2tCn9U+I2LG8OoYnNwXtsasEwyXwLItGi1ES7YwUOrXUSBe52DnR88O7GGaOnY9P
aDIjgGQkkILIk5AVNN1N
=yr/S
-----END PGP SIGNATURE-----

--GxcwvYAGnODwn7V8--
