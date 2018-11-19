Received: from eggs.gnu.org ([2001:4830:134:3::10]:51202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gOnkr-0008SK-EJ
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 12:54:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gOnko-0002L8-Mb
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 12:54:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33234)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gOnko-0002KH-FA
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 12:54:34 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AA58558E31
	for <qemu-devel@nongnu.org>; Mon, 19 Nov 2018 17:54:33 +0000 (UTC)
Received: from red.redhat.com (ovpn-121-142.rdu2.redhat.com [10.10.121.142])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 25A5F5C231
	for <qemu-devel@nongnu.org>; Mon, 19 Nov 2018 17:54:32 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 19 Nov 2018 11:54:15 -0600
Message-Id: <20181119175427.2298497-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/12] NBD patches for 3.1-rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit e6ebbd46b6e539f3613136111977721d212c28=
12:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into sta=
ging (2018-11-19 14:31:48 +0000)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2018-11-19

for you to fetch changes up to 8cedcffdc195bc39aeb1373826ba0a45629741e0:

  iotests: Drop use of bash keyword 'function' (2018-11-19 11:16:46 -0600=
)

There are still a couple of things I'm working on that might still
qualify for 3.1, but given the timing of -rc2, it's getting more
likely that they will shift into 4.0 instead:
- handling of unaligned images (also broken in 3.0, so not necessarily
a regression - but does fix assertion failures)
- qemu-nbd command line option to query server's exports and info (would
be new feature, but would make it a lot easier to test if existing
x-dirty-block feature is working)

Also, I did not spend enough time on this release reviewing Vladimir's
additions for NBD reconnect, so that has now (sadly) slipped into 4.0.

The diffstat touches a large number of files, which is rather awkward
for an -rc2 pull request - but those changes are mostly mechanical
and mostly in the iotests subdirectory. The changes to the code base
proper are quite small.

----------------------------------------------------------------
nbd patches for 2018-11-19

Add iotest coverage for NBD connections using TLS, including
a couple of code fixes that it pointed out

- Mao Zhongyi: 0/3 Do some cleaning work in qemu-iotests
- Daniel P. Berrang=C3=A9: io: return 0 for EOF in TLS session read after=
 shutdown
- Daniel P. Berrang=C3=A9: 0/6 Misc fixes to NBD
- Eric Blake: iotests: Drop use of bash keyword 'function'

----------------------------------------------------------------
Daniel P. Berrang=C3=A9 (6):
      nbd: fix whitespace in server error message
      io: return 0 for EOF in TLS session read after shutdown
      tests: pull qemu-nbd iotest helpers into common.nbd file
      tests: check if qemu-nbd is still alive before waiting
      tests: add iotests helpers for dealing with TLS certificates
      tests: exercise NBD server in TLS mode

Eric Blake (3):
      nbd/server: Ignore write errors when replying to NBD_OPT_ABORT
      iotests: Also test I/O over NBD TLS
      iotests: Drop use of bash keyword 'function'

Mao Zhongyi (3):
      qemu-iotests: remove unused variable 'here'
      qemu-iotests: convert `pwd` and $(pwd) to $PWD
      qemu-iotests: Modern shell scripting (use $() instead of ``)

 configure                                |   2 +-
 include/io/channel-tls.h                 |   1 +
 include/io/channel.h                     |   6 +-
 crypto/tlssession.c                      |   3 +
 io/channel-tls.c                         |   5 ++
 nbd/server.c                             |  14 ++--
 tests/qemu-iotests/common.config         |   6 +-
 tests/qemu-iotests/common.nbd            | 109 ++++++++++++++++++++++++
 tests/qemu-iotests/common.pattern        |  16 ++--
 tests/qemu-iotests/common.qemu           |   8 +-
 tests/qemu-iotests/common.rc             |   2 +-
 tests/qemu-iotests/common.tls            | 137 +++++++++++++++++++++++++=
++++++
 scripts/coccinelle/tcg_gen_extract.cocci |   2 +-
 tests/check-block.sh                     |   6 +-
 tests/qemu-iotests/001                   |   1 -
 tests/qemu-iotests/002                   |   1 -
 tests/qemu-iotests/003                   |   1 -
 tests/qemu-iotests/004                   |   1 -
 tests/qemu-iotests/005                   |   1 -
 tests/qemu-iotests/007                   |   1 -
 tests/qemu-iotests/008                   |   1 -
 tests/qemu-iotests/009                   |   1 -
 tests/qemu-iotests/010                   |   1 -
 tests/qemu-iotests/011                   |   1 -
 tests/qemu-iotests/012                   |   1 -
 tests/qemu-iotests/013                   |   1 -
 tests/qemu-iotests/014                   |   1 -
 tests/qemu-iotests/015                   |   1 -
 tests/qemu-iotests/017                   |   1 -
 tests/qemu-iotests/018                   |   1 -
 tests/qemu-iotests/019                   |   1 -
 tests/qemu-iotests/020                   |   1 -
 tests/qemu-iotests/021                   |   1 -
 tests/qemu-iotests/022                   |   1 -
 tests/qemu-iotests/023                   |   1 -
 tests/qemu-iotests/024                   |   1 -
 tests/qemu-iotests/025                   |   1 -
 tests/qemu-iotests/026                   |   1 -
 tests/qemu-iotests/027                   |   1 -
 tests/qemu-iotests/028                   |   1 -
 tests/qemu-iotests/029                   |   1 -
 tests/qemu-iotests/031                   |   1 -
 tests/qemu-iotests/032                   |   1 -
 tests/qemu-iotests/033                   |   1 -
 tests/qemu-iotests/034                   |   1 -
 tests/qemu-iotests/035                   |   3 +-
 tests/qemu-iotests/036                   |   1 -
 tests/qemu-iotests/037                   |   3 +-
 tests/qemu-iotests/038                   |   7 +-
 tests/qemu-iotests/039                   |   1 -
 tests/qemu-iotests/042                   |   1 -
 tests/qemu-iotests/043                   |   1 -
 tests/qemu-iotests/046                   |   7 +-
 tests/qemu-iotests/047                   |   3 +-
 tests/qemu-iotests/049                   |   5 +-
 tests/qemu-iotests/050                   |   1 -
 tests/qemu-iotests/051                   |   5 +-
 tests/qemu-iotests/052                   |   1 -
 tests/qemu-iotests/053                   |   1 -
 tests/qemu-iotests/054                   |   1 -
 tests/qemu-iotests/058                   |  48 ++---------
 tests/qemu-iotests/059                   |   1 -
 tests/qemu-iotests/060                   |   1 -
 tests/qemu-iotests/061                   |   1 -
 tests/qemu-iotests/062                   |   1 -
 tests/qemu-iotests/063                   |   1 -
 tests/qemu-iotests/064                   |   1 -
 tests/qemu-iotests/066                   |   1 -
 tests/qemu-iotests/067                   |   5 +-
 tests/qemu-iotests/068                   |   1 -
 tests/qemu-iotests/069                   |   1 -
 tests/qemu-iotests/070                   |   1 -
 tests/qemu-iotests/071                   |   5 +-
 tests/qemu-iotests/072                   |   1 -
 tests/qemu-iotests/073                   |   1 -
 tests/qemu-iotests/075                   |   1 -
 tests/qemu-iotests/076                   |   1 -
 tests/qemu-iotests/077                   |   5 +-
 tests/qemu-iotests/078                   |   1 -
 tests/qemu-iotests/079                   |   1 -
 tests/qemu-iotests/080                   |   1 -
 tests/qemu-iotests/081                   |   5 +-
 tests/qemu-iotests/082                   |   3 +-
 tests/qemu-iotests/083                   |   1 -
 tests/qemu-iotests/084                   |   1 -
 tests/qemu-iotests/085                   |  11 ++-
 tests/qemu-iotests/086                   |   3 +-
 tests/qemu-iotests/087                   |   7 +-
 tests/qemu-iotests/088                   |   1 -
 tests/qemu-iotests/089                   |   1 -
 tests/qemu-iotests/090                   |   1 -
 tests/qemu-iotests/091                   |   1 -
 tests/qemu-iotests/092                   |   1 -
 tests/qemu-iotests/094                   |   1 -
 tests/qemu-iotests/095                   |   1 -
 tests/qemu-iotests/097                   |   1 -
 tests/qemu-iotests/098                   |   1 -
 tests/qemu-iotests/099                   |   7 +-
 tests/qemu-iotests/101                   |   1 -
 tests/qemu-iotests/102                   |   1 -
 tests/qemu-iotests/103                   |   1 -
 tests/qemu-iotests/104                   |   1 -
 tests/qemu-iotests/105                   |   1 -
 tests/qemu-iotests/106                   |   1 -
 tests/qemu-iotests/107                   |   1 -
 tests/qemu-iotests/108                   |   1 -
 tests/qemu-iotests/109                   |   3 +-
 tests/qemu-iotests/110                   |   1 -
 tests/qemu-iotests/111                   |   1 -
 tests/qemu-iotests/112                   |   3 +-
 tests/qemu-iotests/113                   |   1 -
 tests/qemu-iotests/114                   |   1 -
 tests/qemu-iotests/115                   |   1 -
 tests/qemu-iotests/116                   |   1 -
 tests/qemu-iotests/117                   |   1 -
 tests/qemu-iotests/119                   |   1 -
 tests/qemu-iotests/120                   |   1 -
 tests/qemu-iotests/121                   |   1 -
 tests/qemu-iotests/122                   |   1 -
 tests/qemu-iotests/123                   |   1 -
 tests/qemu-iotests/125                   |   1 -
 tests/qemu-iotests/126                   |   1 -
 tests/qemu-iotests/127                   |   1 -
 tests/qemu-iotests/128                   |   1 -
 tests/qemu-iotests/130                   |   1 -
 tests/qemu-iotests/131                   |   1 -
 tests/qemu-iotests/133                   |   1 -
 tests/qemu-iotests/134                   |   1 -
 tests/qemu-iotests/135                   |   1 -
 tests/qemu-iotests/137                   |   1 -
 tests/qemu-iotests/138                   |   1 -
 tests/qemu-iotests/140                   |   1 -
 tests/qemu-iotests/141                   |   1 -
 tests/qemu-iotests/142                   |   9 +-
 tests/qemu-iotests/143                   |   1 -
 tests/qemu-iotests/144                   |   1 -
 tests/qemu-iotests/145                   |   1 -
 tests/qemu-iotests/146                   |   1 -
 tests/qemu-iotests/150                   |   1 -
 tests/qemu-iotests/153                   |   5 +-
 tests/qemu-iotests/154                   |   1 -
 tests/qemu-iotests/156                   |   1 -
 tests/qemu-iotests/157                   |   5 +-
 tests/qemu-iotests/158                   |   1 -
 tests/qemu-iotests/159                   |   1 -
 tests/qemu-iotests/160                   |   1 -
 tests/qemu-iotests/162                   |   1 -
 tests/qemu-iotests/170                   |   1 -
 tests/qemu-iotests/171                   |   1 -
 tests/qemu-iotests/172                   |   7 +-
 tests/qemu-iotests/173                   |   1 -
 tests/qemu-iotests/174                   |   1 -
 tests/qemu-iotests/175                   |   1 -
 tests/qemu-iotests/176                   |   3 +-
 tests/qemu-iotests/177                   |   3 +-
 tests/qemu-iotests/178                   |   1 -
 tests/qemu-iotests/179                   |   1 -
 tests/qemu-iotests/181                   |   1 -
 tests/qemu-iotests/182                   |   1 -
 tests/qemu-iotests/183                   |   1 -
 tests/qemu-iotests/184                   |   5 +-
 tests/qemu-iotests/185                   |   1 -
 tests/qemu-iotests/186                   |   5 +-
 tests/qemu-iotests/187                   |   1 -
 tests/qemu-iotests/188                   |   1 -
 tests/qemu-iotests/189                   |   1 -
 tests/qemu-iotests/190                   |   1 -
 tests/qemu-iotests/191                   |   1 -
 tests/qemu-iotests/192                   |   1 -
 tests/qemu-iotests/195                   |   5 +-
 tests/qemu-iotests/197                   |   1 -
 tests/qemu-iotests/198                   |   1 -
 tests/qemu-iotests/200                   |   1 -
 tests/qemu-iotests/204                   |   3 +-
 tests/qemu-iotests/214                   |   1 -
 tests/qemu-iotests/215                   |   1 -
 tests/qemu-iotests/221                   |   1 -
 tests/qemu-iotests/223                   |   5 +-
 tests/qemu-iotests/225                   |   1 -
 tests/qemu-iotests/226                   |   1 -
 tests/qemu-iotests/227                   |   5 +-
 tests/qemu-iotests/229                   |   1 -
 tests/qemu-iotests/231                   |   1 -
 tests/qemu-iotests/232                   |   7 +-
 tests/qemu-iotests/233                   | 112 +++++++++++++++++++++++++
 tests/qemu-iotests/233.out               |  40 +++++++++
 tests/qemu-iotests/check                 |  62 +++++++-------
 tests/qemu-iotests/group                 |   1 +
 188 files changed, 542 insertions(+), 333 deletions(-)
 create mode 100644 tests/qemu-iotests/common.nbd
 create mode 100644 tests/qemu-iotests/common.tls
 create mode 100755 tests/qemu-iotests/233
 create mode 100644 tests/qemu-iotests/233.out

--=20
2.17.2
