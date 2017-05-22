Received: from eggs.gnu.org ([2001:4830:134:3::10]:37326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dCucp-0007do-8X
	for qemu-devel@nongnu.org; Mon, 22 May 2017 17:12:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dCuco-000089-3J
	for qemu-devel@nongnu.org; Mon, 22 May 2017 17:12:23 -0400
From: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Date: Mon, 22 May 2017 23:11:52 +0200
Message-Id: <20170522211205.14265-1-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 00/13] vvfat: misc fixes for read-only mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>

Hi,

This patchset fixes some of issues I encountered when trying to use vvfat=
, and fixes
bug #1599539: https://bugs.launchpad.net/qemu/+bug/1599539

Patch 1 fixes a crash when using 'qemu-img convert'.
Patches 2 to 6 are code cleanup. No functionnal changes.
Patches 7 to 13 fix problems detected by disk checking utilities in read-=
only mode.

With these patches, vvfat creates valid FAT volumes and can be used with =
QEMU disk utilities.

Read-write mode is still buggy after this patchset, but at least, I was n=
ot
able to crash QEMU anymore.

Note that patch 2 doesn't pass checkpatch.pl, as it changes indentation o=
nly.

Herv=C3=A9

Changes v1->v2:
- small changes following Kevin remarks (patches 3, 5, 6)
- use g_utf8_* functions instead of ad-hock code (patches 8 and 9)
- fix a bug with filenames starting with a dot (patch 9)

Herv=C3=A9 Poussineau (13):
  vvfat: fix qemu-img map and qemu-img convert
  vvfat: replace tabs by 8 spaces
  vvfat: fix typos
  vvfat: rename useless enumeration values
  vvfat: introduce offset_to_bootsector, offset_to_fat and
    offset_to_root_dir
  vvfat: fix field names in FAT12/FAT16 and FAT32 boot sectors
  vvfat: always create . and .. entries at first and in that order
  vvfat: correctly create long names for non-ASCII filenames
  vvfat: correctly create base short names for non-ASCII filenames
  vvfat: correctly generate numeric-tail of short file names
  vvfat: limit number of entries in root directory in FAT12/FAT16
  vvfat: handle KANJI lead byte 0xe5
  vvfat: change OEM name to 'MSWIN4.1'

 block/vvfat.c | 2306 ++++++++++++++++++++++++++++++---------------------=
------
 1 file changed, 1198 insertions(+), 1108 deletions(-)

--=20
2.11.0
