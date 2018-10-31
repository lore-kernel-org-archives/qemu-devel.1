Received: from eggs.gnu.org ([2001:4830:134:3::10]:60180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHfUc-0000JF-4G
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 21:40:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHfUY-00023y-2W
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 21:40:22 -0400
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e]:43413)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1gHfUX-0001tz-PK
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 21:40:17 -0400
Received: by mail-qt1-x82e.google.com with SMTP id q41-v6so15953707qtq.10
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 18:40:06 -0700 (PDT)
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 30 Oct 2018 20:37:57 -0500
Message-Id: <20181031013821.24023-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 00/24] qemu-ga patch queue for soft-freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

The following changes since commit a2e002ff7913ce93aa0f7dbedd2123dce5f1a9cd:

  Merge remote-tracking branch 'remotes/vivier2/tags/qemu-trivial-for-3.1-pull-request' into staging (2018-10-30 15:49:55 +0000)

are available in the Git repository at:

  git://github.com/mdroth/qemu.git tags/qga-pull-2018-10-30-v2-tag

for you to fetch changes up to 9634c55fad4681e6000dd3da602081cbc3ade868:

  qga-win: changing --retry-path option behavior (2018-10-30 16:48:49 -0500)

----------------------------------------------------------------
qemu-ga patch queue for soft-freeze

* support for --retry-path option for recovering from communication
  path failures
* support for serial/device name in guest-get-fsinfo for linux/w32
* support for freezing individual mount points in guest-fsfreeze-*
* fixes for unicode paths on w32, not-present vcpus in guest-get-vcpus,
  buffer overflow in guest-get-fsinfo for w32, and other minor fixes

v2:
* set libudev=off in configure for static builds

----------------------------------------------------------------
Bishara AbuHattoum (1):
      qga-win: changing --retry-path option behavior

Chen Hanxiao (1):
      qga-win: add support for qmp_guest_fsfreeze_freeze_list

Igor Mammedov (1):
      qga: ignore non present cpus when handling qmp_guest_get_vcpus()

Jonathon Reinhart (1):
      qga: Support Unicode paths in guest-file-open on win32

Li Qiang (1):
      qga: fix an off-by-one issue

Michael Roth (7):
      qga-win: add debugging information
      qga: group agent init/cleanup init separate routines
      qga: hang GAConfig/socket_activation off of GAState global
      qga: move w32 service handling out of run_agent()
      qga: add --retry-path option for re-initializing channel on failure
      qga-win: install service with --retry-path set by default
      qga-win: report specific error when failing to open channel

Sameeh Jubran (2):
      qga-win: prevent crash when executing fsinfo command
      qga-win: fsinfo: pci-info: allow partial info

Tomáš Golembiovský (10):
      configure: add test for libudev
      qga: linux: report disk serial number
      qga: linux: return disk device in guest-get-fsinfo
      build: rename CONFIG_QGA_NTDDDISK to CONFIG_QGA_NTDDSCSI
      qga-win: refactor disk properties (bus)
      qga-win: report disk serial number
      qga-win: refactor disk info
      qga-win: handle multi-disk volumes
      qga-win: return disk device in guest-get-fsinfo
      qga-win: demystify namespace stripping

 configure                   |  23 ++-
 qga/Makefile.objs           |   1 +
 qga/channel-win32.c         |   3 +-
 qga/commands-posix.c        | 152 ++++++++++++--------
 qga/commands-win32.c        | 337 +++++++++++++++++++++++++++++++++++---------
 qga/installer/qemu-ga.wxs   |   2 +-
 qga/main.c                  | 258 ++++++++++++++++++++++++++-------
 qga/qapi-schema.json        |   5 +-
 qga/service-win32.h         |   4 +
 qga/vss-win32.c             |   5 +-
 qga/vss-win32.h             |   3 +-
 qga/vss-win32/requester.cpp |  92 ++++++++----
 qga/vss-win32/requester.h   |  13 +-
 13 files changed, 688 insertions(+), 210 deletions(-)
