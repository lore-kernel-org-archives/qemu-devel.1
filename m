Received: from eggs.gnu.org ([2001:4830:134:3::10]:39187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fGWCR-0008Pz-CZ
	for qemu-devel@nongnu.org; Wed, 09 May 2018 17:00:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fGWCQ-00027r-Ec
	for qemu-devel@nongnu.org; Wed, 09 May 2018 17:00:35 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  9 May 2018 23:00:16 +0200
Message-Id: <20180509210023.20283-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/7] qemu-img: Improve option help for amend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>

[Unchanged text from v1 ahead]

Currently, "qemu-img amend -f $format -o help" prints many things which
it claims to be supported, but most of the time it's wrong.  Usually
that starts with the format already: No format but qcow2 supports option
amendment, so we should never claim that a format supports any options
when it actually does not support amendment in the first place.

It goes on with the options themselves.  The qcow2 driver does not
support amendment of all creation options, so we should not claim it
does.  Actually knowing which formats are supported exactly would be a
bit difficult (this would probably involve adding a field to
QemuOptDesc, and I don't really want to do that), but what we can do
instead is to at least advise the user that the options we print are all
of the creation options and that we might not support amending all of
them.

There is a Bugzilla for this here:
https://bugzilla.redhat.com/show_bug.cgi?id=1537956

On the way to address these issues, there is more to be done, though.
bdrv_amend_options() does not have an Error parameter yet, and there is
no real excuse for that.

Also, "qemu-img create -o help" has its own little issue with formats
that do not support creation:

    $ qemu-img create -f bochs -o help
    Supported options:
    qemu-img: util/qemu-option.c:219:
    qemu_opts_print_help: Assertion `list' failed.
    [1]    24831 abort (core dumped)  qemu-img create -f bochs -o help

Let's fix that, too.


v2:
- Patch 2: [Eric]
  - Use error_setg_errno() where possible
  - Use assertions instead of error messages where that makes sense
  - Rephrase an error message since we're already touching it


git-backport-diff against v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/7:[----] [--] 'qemu-img: Amendment support implies create_opts'
002/7:[0042] [FC] 'block: Add Error parameter to bdrv_amend_options'
003/7:[----] [--] 'qemu-option: Pull out "Supported options" print'
004/7:[----] [--] 'qemu-img: Add print_amend_option_help()'
005/7:[----] [--] 'qemu-img: Recognize no creation support in -o help'
006/7:[----] [--] 'iotests: Test help option for unsupporting formats'
007/7:[----] [--] 'iotests: Rework 113'


Max Reitz (7):
  qemu-img: Amendment support implies create_opts
  block: Add Error parameter to bdrv_amend_options
  qemu-option: Pull out "Supported options" print
  qemu-img: Add print_amend_option_help()
  qemu-img: Recognize no creation support in -o help
  iotests: Test help option for unsupporting formats
  iotests: Rework 113

 include/block/block.h      |  3 +-
 include/block/block_int.h  |  3 +-
 block.c                    |  8 ++++--
 block/qcow2.c              | 72 ++++++++++++++++++++++++++--------------------
 qemu-img.c                 | 52 +++++++++++++++++++++++++++++----
 util/qemu-option.c         |  1 -
 tests/qemu-iotests/060.out |  4 +--
 tests/qemu-iotests/061.out |  7 -----
 tests/qemu-iotests/080.out |  4 +--
 tests/qemu-iotests/082     |  9 ++++++
 tests/qemu-iotests/082.out | 53 +++++++++++++++++++++++-----------
 tests/qemu-iotests/112.out |  3 --
 tests/qemu-iotests/113     | 19 ++++++------
 tests/qemu-iotests/113.out |  7 +++--
 14 files changed, 159 insertions(+), 86 deletions(-)

-- 
2.14.3
