Received: from eggs.gnu.org ([2001:4830:134:3::10]:47923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gC6fW-0005Pd-In
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:28:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gC6fT-00054o-Ti
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:28:37 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 15 Oct 2018 19:28:12 +0200
Message-Id: <20181015172817.19796-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/5] Various option help readability
 improvement suggestions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

I noticed that with the (more or less) recent series from Marc-Andr=C3=A9=
 the
output of qemu-img amend -f qcow2 -o help changed to this:

$ ./qemu-img amend -f qcow2 -o help
Creation options for 'qcow2':
qcow2-create-opts.backing_file=3Dstr - File name of a base image
qcow2-create-opts.backing_fmt=3Dstr - Image format of the base image
qcow2-create-opts.cluster_size=3Dsize - qcow2 cluster size
qcow2-create-opts.compat=3Dstr - Compatibility level (0.10 or 1.1)
[...]

The types are a nice addition, but I didn't like having the list name
printed in every single line (in fact, the list name does not make any
sense here at all, because there already is a caption which reads
"Creation options for 'qcow2'"), and I did not like the use of '=3D' for
types.

In general, I don't like the robot-y appearance, which is even worse in
things like -device virtio-blk,help, which gives you this (among
other lines):

> virtio-blk-pci.iothread=3Dlink<iothread>

Sadly, there isn't much we can do about the "link<iothread>", so this
series doesn't improve on that point.

What this series does do, however, is it changes these lists not to
print the list name on every single line, but only as a caption (and for
option lists, this caption is option, because the caller may want to
print a custom caption that is more expressive -- as is the case for
qemu-img amend -o help).

Consequentially, all list items are indented by two spaces to make clear
they belong to the caption.  I can already see that some people might
disagree on having this indentation, but I like it, so I have it in this
series.

Furthermore, '=3D' for types is changed to ': '.


Thus, after this series, the amend output looks like this:

$ ./qemu-img amend -f qcow2 -o help
Creation options for 'qcow2':
  backing_file: str - File name of a base image
  backing_fmt: str - Image format of the base image
  cluster_size: size - qcow2 cluster size
  compat: str - Compatibility level (0.10 or 1.1)
[...]


virtio-blk's list presents itself like so:

$ x86_64-softmmu/qemu-system-x86_64 -device virtio-blk,help
virtio-blk-pci options:
  iothread: link<iothread>
  request-merging: bool (on/off)
  secs: uint32
[...]

(which is still not perfect, but at least it no longer looks like it's
been generated for consumption by libvirt)


And now we even print something when there are no options:

$ x86_64-softmmu/qemu-system-x86_64 -object can-bus,help
There are no options for can-bus.

(Before this series, there just is no output.)


As a side effect, patch 1 fixes iotest 082.


Max Reitz (5):
  option: Make option help nicer to read
  chardev: Indent list of chardevs
  qdev-monitor: Make device options help nicer
  object: Make option help nicer to read
  fw_cfg: Drop newline in @file description

 include/qemu/option.h      |   2 +-
 chardev/char.c             |   2 +-
 qdev-monitor.c             |   7 +-
 qemu-img.c                 |   4 +-
 util/qemu-option.c         |  31 +-
 vl.c                       |  14 +-
 tests/qemu-iotests/082.out | 956 ++++++++++++++++++-------------------
 7 files changed, 521 insertions(+), 495 deletions(-)

--=20
2.17.1
