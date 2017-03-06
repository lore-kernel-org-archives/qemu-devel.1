Received: from eggs.gnu.org ([2001:4830:134:3::10]:46068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ckxsV-0004Bl-VA
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 14:01:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ckxsS-0004mz-TP
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 14:01:04 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  6 Mar 2017 20:00:34 +0100
Message-Id: <1488826849-32384-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 00/15] block: A bunch of fixes for Sheepdog
 and Gluster
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com, ndevos@redhat.com, eblake@redhat.com, f4bug@amsat.org

Bad error handling, memory leaks, and lack of blockdev-add support.

v2:
* Straightforward rebase
* PATCH 01: Superfluous conditional dropped, labels renamed, commit
  message updated accordingly [Eric]
* PATCH 02: More pleasant use of @ret, error message capitalized,
  line break tidied up [Kevin, Eric]
* PATCH 05: Whitespace tidied up [Kevin]
* PATCH 06: Missing assignment to ret fixed up [Eric]
* PATCH 07: Missing assignment to ret fixed up [Kevin]
* PATCH 12: Use -1 instead of 0 for unused argument [Niels]
* PATCH 14: Better explain compatibility impact in commit message,
  whitespace tidied up [Eric]


Markus Armbruster (15):
  sheepdog: Defuse time bomb in sd_open() error handling
  sheepdog: Fix error handling in sd_snapshot_delete()
  sheepdog: Fix error handling sd_create()
  sheepdog: Mark sd_snapshot_delete() lossage FIXME
  sheepdog: Fix snapshot ID parsing in _open(), _create, _goto()
  sheepdog: Don't truncate long VDI name in _open(), _create()
  sheepdog: Report errors in pseudo-filename more usefully
  sheepdog: Use SocketAddress and socket_connect()
  sheepdog: Implement bdrv_parse_filename()
  gluster: Drop assumptions on SocketTransport names
  gluster: Don't duplicate qapi-util.c's qapi_enum_parse()
  gluster: Plug memory leaks in qemu_gluster_parse_json()
  qapi-schema: Rename GlusterServer to SocketAddressFlat
  qapi-schema: Rename SocketAddressFlat's variant tcp to inet
  sheepdog: Support blockdev-add

 block/gluster.c      | 127 +++++++--------
 block/sheepdog.c     | 453 +++++++++++++++++++++++++++++++++++++--------=
------
 qapi-schema.json     |  38 +++++
 qapi/block-core.json |  73 +++------
 4 files changed, 451 insertions(+), 240 deletions(-)

--=20
2.7.4
