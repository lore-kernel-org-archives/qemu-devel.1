Received: from eggs.gnu.org ([2001:4830:134:3::10]:44540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gDXyC-00034F-1p
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:49:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gDXyB-0004l1-0U
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:49:51 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 19 Oct 2018 18:49:24 +0200
Message-Id: <20181019164929.18404-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/5] Various option help readability
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>

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

Furthermore, types are now enclosed by angle brackets, and the alignment
we originally had for descriptions is restored (although now after 24
instead of 16 characters, because every option name is now accompanied
by indentation and a type).


Thus, after this series, the amend output looks like this:

$ ./qemu-img amend -f qcow2 -o help
Creation options for 'qcow2':
  backing_file=3D<str>     - File name of a base image
  backing_fmt=3D<str>      - Image format of the base image
  cluster_size=3D<size>    - qcow2 cluster size
  compat=3D<str>           - Compatibility level (0.10 or 1.1)
[...]


virtio-blk's list presents itself like so:

$ x86_64-softmmu/qemu-system-x86_64 -device virtio-blk,help
virtio-blk-pci options:
  iothread=3D<link<iothread>>
  request-merging=3D<bool> - on/off
  secs=3D<uint32>
[...]


And now we even print something when there are no options:

$ x86_64-softmmu/qemu-system-x86_64 -object can-bus,help
There are no options for can-bus.

(Before this series, there just is no output.)


As a side effect, patch 1 fixes iotest 082.


v2:
- Patch 1:
  - Abandon the "$name: $type" formatting in favor of "$name=3D<$type>"
    [Marc-Andr=C3=A9, at least the "abandon" part]
  - Restore description alignment [Kevin]
  - Do the alignment when generating each line's GString instead of when
    printing them.  This results in less lines modified and allows the
    compiler to optimize the printf("%s\n", x) to puts(x).
- Patch 3:
  - Same changes as above, with the addition of also separating the
    description with " - " instead of enclosing it in parentheses (to
    match the other places)
  - Also, we never did align the descriptions here, so this is not
    "restore" but "introduce description alignment".
- Patch 4:
  - Same as patch 1, but again with the catch of s/restore/introduce/.


git-backport-diff against v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/5:[0963] [FC] 'option: Make option help nicer to read'
002/5:[----] [--] 'chardev: Indent list of chardevs'
003/5:[0008] [FC] 'qdev-monitor: Make device options help nicer'
004/5:[0007] [FC] 'object: Make option help nicer to read'
005/5:[----] [--] 'fw_cfg: Drop newline in @file description'


Max Reitz (5):
  option: Make option help nicer to read
  chardev: Indent list of chardevs
  qdev-monitor: Make device options help nicer
  object: Make option help nicer to read
  fw_cfg: Drop newline in @file description

 include/qemu/option.h      |   2 +-
 chardev/char.c             |   2 +-
 qdev-monitor.c             |  13 +-
 qemu-img.c                 |   4 +-
 util/qemu-option.c         |  32 +-
 vl.c                       |  15 +-
 tests/qemu-iotests/082.out | 956 ++++++++++++++++++-------------------
 7 files changed, 530 insertions(+), 494 deletions(-)

--=20
2.17.1
