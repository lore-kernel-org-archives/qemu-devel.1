Received: from eggs.gnu.org ([2001:4830:134:3::10]:36634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gandalf.corvotempesta@gmail.com>) id 1eF4Uw-0004td-Q5
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 15:41:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gandalf.corvotempesta@gmail.com>) id 1eF4Uv-0001t7-NF
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 15:41:26 -0500
MIME-Version: 1.0
In-Reply-To: <20171115202938.GN2787@redhat.com>
References: <CAJH6TXiMxUoU2sFEHAoZ8jhDMtg_saEnTHM9f0vJ6Nhqj7099w@mail.gmail.com>
	<c2ecae32-f999-9f1e-46a6-37cdab2a62e3@redhat.com>
	<CAJH6TXhBAaBE9gBSxksWZqNywWmencRaGyeY-oN3jbKdgUettQ@mail.gmail.com>
	<0e6cc220-814a-17fd-4fd7-7b0665d34e81@redhat.com>
	<CAJH6TXh2v-F=yqxQbUUawk_Ctq-sgFefGp1XvMsC=syX_5jEqA@mail.gmail.com>
	<30b54865-2255-d13d-a054-afcf5bbd06b2@redhat.com>
	<20171115202440.GJ19514@redhat.com>
	<7b11bb2b-b93d-e8ff-f396-703c93549d0d@redhat.com>
	<20171115202938.GN2787@redhat.com>
From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Date: Wed, 15 Nov 2017 21:41:20 +0100
Message-ID: <CAJH6TXiPuLu62-+o2+PrUGpstrks_5pLotFEe1bAOmsbn20otw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Libguestfs]  [qemu-img] support for XVA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, Qemu-block <qemu-block@nongnu.org>, qemu-devel@nongnu.org, libguestfs <libguestfs@redhat.com>

2017-11-15 21:29 GMT+01:00 Richard W.M. Jones <rjones@redhat.com>:
> Gandalf, is there an XVA file publically available (pref. not
> too big) that we can look at?

I can try to provide one, but it's simple:

# tar tvf 20160630_124823_aa72_.xva.gz | head -n 50
---------- 0/0           42353 1970-01-01 01:00 ova.xml
---------- 0/0         1048576 1970-01-01 01:00 Ref:175/00000000
---------- 0/0              40 1970-01-01 01:00 Ref:175/00000000.checksum
---------- 0/0         1048576 1970-01-01 01:00 Ref:175/00000001
---------- 0/0              40 1970-01-01 01:00 Ref:175/00000001.checksum
---------- 0/0         1048576 1970-01-01 01:00 Ref:175/00000003
---------- 0/0              40 1970-01-01 01:00 Ref:175/00000003.checksum
---------- 0/0         1048576 1970-01-01 01:00 Ref:175/00000004
---------- 0/0              40 1970-01-01 01:00 Ref:175/00000004.checksum
---------- 0/0         1048576 1970-01-01 01:00 Ref:175/00000005
---------- 0/0              40 1970-01-01 01:00 Ref:175/00000005.checksum
---------- 0/0         1048576 1970-01-01 01:00 Ref:175/00000006
---------- 0/0              40 1970-01-01 01:00 Ref:175/00000006.checksum
---------- 0/0         1048576 1970-01-01 01:00 Ref:175/00000007
---------- 0/0              40 1970-01-01 01:00 Ref:175/00000007.checksum
---------- 0/0         1048576 1970-01-01 01:00 Ref:175/00000009
---------- 0/0              40 1970-01-01 01:00 Ref:175/00000009.checksum
---------- 0/0         1048576 1970-01-01 01:00 Ref:175/00000010
---------- 0/0              40 1970-01-01 01:00 Ref:175/00000010.checksum


You can ignore the ova.xml and just use the "Ref:175" directory.
Inside the XVA you'll fine one "Ref" directory for each virtual disk
(ref number is different for each disk)
Inside each Ref directory, you'll get tons of 1MB file, corrisponding
to the RAW image.
You have to merge these files in a single raw file with just an
exception: numbers are not sequential.
as you can see above, we have: 00000000, 00000001, 00000003

The 00000002 is missing, because it's totally blank. XenServer doesn't
export any empty block, thus it will skip the corrisponding 1MB file.
When building the raw image, you have to replace empty blocks with 1MB
full of zeros.

This is (in addition to the tar extract) the most time-consuming part.
Currently I'm rebuilding a 250GB image, with tons of files to be
merge.
If qemu-img can be patched to automatically convert this kind of
format, I can save about 3 hours (30 minutes for extracting the
tarball, and about 2 hours to merge 250-300GB image)
