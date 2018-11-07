Received: from eggs.gnu.org ([2001:4830:134:3::10]:58358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gKMjF-0006fR-Gk
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 07:14:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gKMiz-0004ig-7j
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 07:14:30 -0500
Date: Wed, 7 Nov 2018 12:13:19 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20181107121319.GC14842@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Change in qemu 2.12 causes qemu-img convert to NBD to
 write more data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, eblake@redhat.com, qemu-block@nongnu.org, Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>
Cc: nsoffer@redhat.com

(I'm not going to claim this is a bug, but it causes a large, easily
measurable performance regression in virt-v2v).

In qemu 2.10, when you do =E2=80=98qemu-img convert=E2=80=99 to an NBD ta=
rget, qemu
interleaves write and zero requests.  We can observe this as follows:

  $ virt-builder fedora-28
  $ nbdkit --filter=3Dlog memory size=3D6G logfile=3D/tmp/log \
      --run './qemu-img convert ./fedora-28.img -n $nbd'
  $ grep '\.\.\.$' /tmp/log | sed 's/.*\([A-Z][a-z]*\).*/\1/' | uniq -c
      1 Write
      2 Zero
      1 Write
      3 Zero
      1 Write
      1 Zero
      1 Write
    [etc for over 1000 lines]

Looking at the log file in detail we can see it is writing serially
from the beginning to the end of the disk.

In qemu 2.12 this behaviour changed:

  $ nbdkit --filter=3Dlog memory size=3D6G logfile=3D/tmp/log \
      --run './qemu-img convert ./fedora-28.img -n $nbd'
  $ grep '\.\.\.$' /tmp/log | sed 's/.*\([A-Z][a-z]*\).*/\1/' | uniq -c
      193 Zero
     1246 Write

It now zeroes the whole disk up front and then writes data over the
top of the zeroed blocks.

The reason for the performance regression is that in the first case we
write 6G in total.  In the second case we write 6G of zeroes up front,
followed by the amount of data in the disk image (in this case the
test disk image contains 1G of non-sparse data, so we write about 7G
in total).

In real world cases this makes a great difference: we might have 100s
of G of data in the disk.  The ultimate backend storage (a Linux block
device) doesn't support efficient BLKZEROOUT so zeroing is pretty slow
too.

I bisected the change to the commit shown at the end of this email.

Any suggestions how to fix or work around this problem welcome.

Rich.


commit 9776f0db6a19a0510e89b7aae38190b4811c95ba
Author: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>
Date:   Thu Jan 18 14:51:58 2018 +0300

    nbd: implement bdrv_get_info callback
   =20
    Since mirror job supports efficient zero out target mechanism (see
    in mirror_dirty_init()), implement bdrv_get_info to make it work
    over NBD. Such improvement will allow using the largest chunk possibl=
e
    and will decrease the number of NBD_CMD_WRITE_ZEROES requests on the =
wire.
   =20
    Signed-off-by: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>
    Message-Id: <20180118115158.17219-1-edgar.kaziakhmedov@virtuozzo.com>
    Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
    Signed-off-by: Eric Blake <eblake@redhat.com>


--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rj=
ones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-df lists disk usage of guests without needing to install any
software inside the virtual machine.  Supports Linux and Windows.
http://people.redhat.com/~rjones/virt-df/
