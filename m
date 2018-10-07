Received: from eggs.gnu.org ([2001:4830:134:3::10]:47043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bishara@daynix.com>) id 1g96pW-00052w-1u
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 07:02:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bishara@daynix.com>) id 1g96pS-0007Ns-Og
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 07:02:33 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41208)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bishara@daynix.com>) id 1g96pR-0007MA-Uc
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 07:02:30 -0400
Received: by mail-wr1-x443.google.com with SMTP id x12-v6so17722101wru.8
	for <qemu-devel@nongnu.org>; Sun, 07 Oct 2018 04:02:29 -0700 (PDT)
From: Bishara AbuHattoum <bishara@daynix.com>
Date: Sun,  7 Oct 2018 14:02:16 +0300
Message-Id: <20181007110223.129692-1-bishara@daynix.com>
Subject: [Qemu-devel] [PATCH v2 0/7] qga: add support for re-opening channel
 on error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Yan Vugenfirer <yan@daynix.com>, Sameeh Jubran <sameeh@daynix.com>

Changes from v1:
 [1/7] qga: group agent init/cleanup init separate routines
         Fixed typo in the commit message and dropped the unnecessary message ID
 [2/7] qga: hang GAConfig/socket_activation off of GAState global
         Dropped the unnecessary message ID
 [3/7] qga: move w32 service handling out of run_agent()
         Fixed run_agent() extra call and dropped the unnecessary message ID 
 [4/7] qga: add --retry-path option for re-initializing channel on failure
         Dropped the unnecessary message ID
 [5/7] qga-win: install service with --retry-path set by default
         Dropped the unnecessary message ID
 [6/7] qga-win: report specific error when failing to open channel
         Dropped the unnecessary message ID
 [7/7] qga-win: changing --retry-path option behavior
         Dropped the use of two events and WaitForMultipleObjects, and used
         one 'wakeup_event'.

A patch series was firstly introduced about a year ago which resolves an issue
with qemu-ga and virtio-serial functionality. The issue was discussed in the
following thread:
  https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg06256.html

In short, Sameeh sent an implementation which uses udev on Linux and device
events API on Windows. Since udev API is only supported for kernels 2.6+ it is
not a good approach and Michael suggested his alternative series which uses a
loop and checks if the serial is present or not. Since the Windows API is
supported and has backward compatibility up until Windows xp, there is no reason
for not using the Windows API. It was finally agreed by Michael and Sameeh that
a combination of both approaches should be used.

This series does just that, it rebases Michael's patches on top of upstream and
merges Sameeh's patches for Windows API into Michael's implementation.

Michael's series:
  https://github.com/mdroth/qemu/commits/qga-retry-path
Sameeh's series:
  https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02400.html
  https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02399.html
  https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02401.html

Bishara AbuHattoum (1):
  qga-win: changing --retry-path option behavior

Michael Roth (6):
  qga: group agent init/cleanup init separate routines
  qga: hang GAConfig/socket_activation off of GAState global
  qga: move w32 service handling out of run_agent()
  qga: add --retry-path option for re-initializing channel on failure
  qga-win: install service with --retry-path set by default
  qga-win: report specific error when failing to open channel

 qga/channel-win32.c       |   3 +-
 qga/installer/qemu-ga.wxs |   2 +-
 qga/main.c                | 288 +++++++++++++++++++++++++++++---------
 qga/service-win32.h       |   4 +
 4 files changed, 229 insertions(+), 68 deletions(-)

-- 
2.17.0
