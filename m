Received: from eggs.gnu.org ([2001:4830:134:3::10]:47039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1eF4rx-00010v-EO
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 16:05:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1eF4rw-0002Gh-6w
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 16:05:13 -0500
Date: Wed, 15 Nov 2017 21:05:00 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20171115210500.GB2450@redhat.com>
References: <CAJH6TXiMxUoU2sFEHAoZ8jhDMtg_saEnTHM9f0vJ6Nhqj7099w@mail.gmail.com>
	<c2ecae32-f999-9f1e-46a6-37cdab2a62e3@redhat.com>
	<CAJH6TXhBAaBE9gBSxksWZqNywWmencRaGyeY-oN3jbKdgUettQ@mail.gmail.com>
	<0e6cc220-814a-17fd-4fd7-7b0665d34e81@redhat.com>
	<CAJH6TXh2v-F=yqxQbUUawk_Ctq-sgFefGp1XvMsC=syX_5jEqA@mail.gmail.com>
	<30b54865-2255-d13d-a054-afcf5bbd06b2@redhat.com>
	<20171115202440.GJ19514@redhat.com>
	<7b11bb2b-b93d-e8ff-f396-703c93549d0d@redhat.com>
	<20171115202938.GN2787@redhat.com>
	<CAJH6TXiPuLu62-+o2+PrUGpstrks_5pLotFEe1bAOmsbn20otw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJH6TXiPuLu62-+o2+PrUGpstrks_5pLotFEe1bAOmsbn20otw@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Libguestfs]  [qemu-img] support for XVA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: libguestfs <libguestfs@redhat.com>, qemu-devel@nongnu.org, Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

On Wed, Nov 15, 2017 at 09:41:20PM +0100, Gandalf Corvotempesta wrote:
> 2017-11-15 21:29 GMT+01:00 Richard W.M. Jones <rjones@redhat.com>:
> > Gandalf, is there an XVA file publically available (pref. not
> > too big) that we can look at?
>=20
> I can try to provide one, but it's simple:
>=20
> # tar tvf 20160630_124823_aa72_.xva.gz | head -n 50
> ---------- 0/0           42353 1970-01-01 01:00 ova.xml
> ---------- 0/0         1048576 1970-01-01 01:00 Ref:175/00000000
> ---------- 0/0              40 1970-01-01 01:00 Ref:175/00000000.checks=
um
> ---------- 0/0         1048576 1970-01-01 01:00 Ref:175/00000001
> ---------- 0/0              40 1970-01-01 01:00 Ref:175/00000001.checks=
um
> ---------- 0/0         1048576 1970-01-01 01:00 Ref:175/00000003
> ---------- 0/0              40 1970-01-01 01:00 Ref:175/00000003.checks=
um
> ---------- 0/0         1048576 1970-01-01 01:00 Ref:175/00000004
> ---------- 0/0              40 1970-01-01 01:00 Ref:175/00000004.checks=
um
> ---------- 0/0         1048576 1970-01-01 01:00 Ref:175/00000005
> ---------- 0/0              40 1970-01-01 01:00 Ref:175/00000005.checks=
um
> ---------- 0/0         1048576 1970-01-01 01:00 Ref:175/00000006
> ---------- 0/0              40 1970-01-01 01:00 Ref:175/00000006.checks=
um
> ---------- 0/0         1048576 1970-01-01 01:00 Ref:175/00000007
> ---------- 0/0              40 1970-01-01 01:00 Ref:175/00000007.checks=
um
> ---------- 0/0         1048576 1970-01-01 01:00 Ref:175/00000009
> ---------- 0/0              40 1970-01-01 01:00 Ref:175/00000009.checks=
um
> ---------- 0/0         1048576 1970-01-01 01:00 Ref:175/00000010
> ---------- 0/0              40 1970-01-01 01:00 Ref:175/00000010.checks=
um
>=20
>=20
> You can ignore the ova.xml and just use the "Ref:175" directory.
> Inside the XVA you'll fine one "Ref" directory for each virtual disk
> (ref number is different for each disk)
> Inside each Ref directory, you'll get tons of 1MB file, corrisponding
> to the RAW image.
> You have to merge these files in a single raw file with just an
> exception: numbers are not sequential.
> as you can see above, we have: 00000000, 00000001, 00000003
>=20
> The 00000002 is missing, because it's totally blank. XenServer doesn't
> export any empty block, thus it will skip the corrisponding 1MB file.
> When building the raw image, you have to replace empty blocks with 1MB
> full of zeros.
>=20
> This is (in addition to the tar extract) the most time-consuming part.
> Currently I'm rebuilding a 250GB image, with tons of files to be
> merge.
> If qemu-img can be patched to automatically convert this kind of
> format, I can save about 3 hours (30 minutes for extracting the
> tarball, and about 2 hours to merge 250-300GB image)

I guess the nbdkit approach would be better given the multiple and
missing files within the tar file.

You'll have to use =E2=80=98tar tRvf file.xva=E2=80=99 to extract the off=
set and size
of each file.  (See the function =E2=80=98find_file_in_tar=E2=80=99 in vi=
rt-v2v source
for exactly how).

This will give you one offset/size/filename tuple for each file.  The
plugin will then simply need to calculate which file to access to
resolve each virtual file range (or substitute zeroes for missing
files).

Note that nbdkit lets you write plugins in high-level languages like
Perl or Python which would be ideally suited to this kind of task.

You can then use "captive nbdkit" (see the manual) like this:

  nbdkit -U - \
      perl script=3D/path/to/xva-parser.pl file=3D/path/to/file.xva \
      --run 'qemu-img convert $nbd -O qcow2 output.qcow2'

At no point does the tar file need to be fully unpacked and it should
all be reasonably efficient.

Rich.

--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rj=
ones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html
