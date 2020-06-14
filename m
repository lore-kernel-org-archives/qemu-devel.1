Return-Path: <SRS0=clLO=73=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95FFC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 14:29:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 865072071A
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 14:29:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 865072071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkTdu-0006Mi-Lt
	for qemu-devel@archiver.kernel.org; Sun, 14 Jun 2020 10:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jkTd3-0005Hd-EY; Sun, 14 Jun 2020 10:28:57 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:38320
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jkTd1-00058R-2c; Sun, 14 Jun 2020 10:28:57 -0400
Received: from host217-39-64-113.range217-39.btcentralplus.com
 ([217.39.64.113] helo=kentang.home)
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jkTcq-0006Hv-U6; Sun, 14 Jun 2020 15:28:51 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, laurent@vivier.eu,
 fthain@telegraphics.com.au
Date: Sun, 14 Jun 2020 15:28:18 +0100
Message-Id: <20200614142840.10245-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 217.39.64.113
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 00/22] ADB: fix autopoll issues and rework mac_via state
 machine
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patchset is something I have been chipping away at for a while since
spending some time over the Christmas holidays trying to boot the MacOS
toolbox ROM on the new q800 machine.

Initially I discovered that there were some problems when the MacOS ROM was
enumerating ADB devices due to multiple meanings of the vADBInt bit. After
fixing this there were still issues with keys being dropped during autopoll
which were eventually traced back to the autopoll timer re-firing before
the host had managed to read back the previous response.

At this point I noticed that CUDA/PMU/mac_via all had their own implementations
of ADB autopoll, and that it would make sense to consolidate the autopoll timer,
mask, interval and locking into the ADB bus. This would allow the logic to be
removed from each separate device and managed in just one place.

Finally I updated the trace-events to allow separate tracing of bus requests
and device responses which makes it easier to follow the ADB enumeration process.

The breakdown of the patchset is as follows:

- Patch 1 keeps checkpatch happy for the remainder of the patchset whilst patch
  2 is the proper fix for a spurious ADB register 3 write during enumeration
  caused by ignoring the request length which I had tried to work around earlier.

- Patches 3 to 10 are part of the autopoll consolidation process which moves the
  separate autopoll implementations into a single implementation within
  ADBBusState.

- Patches 11 to 13 update the ADB implementation to hold a status variable
  indicating the result of the last request and allow devices to indicate
  whether they have data to send. This extra information is required by the
  upcoming mac_via state machine changes.

- Patches 14 to 17 add a variable and functions to block and unblock ADB
  autopoll at bus level, adding the functions at the correct places within
  CUDA and PMU.

- Patches 18 and 19 rework the mac_via ADB state machine so that the bus
  can be enumerated correctly, and both explicit and autopoll requests work
  under both MacOS and Linux.

- Patch 20 enforces the blocking and unblocking of autopoll at the ADB
  level, including adding an assert() to prevent developers from trying to
  make an ADB request whilst autopoll is in progress.
  
- Patches 21 and 22 update the trace-events to separate out ADB device and
  ADB bus events.

The patch has been tested by myself and a couple of others during the development
process across the PPC g3beige/mac99 and 68K q800 machine so it should be quite
solid.

One thing to indicate is that the patchset bumps the VMState versions for the
affected devices but does not allow older versions to load. This is a conscious
decision given that for the mac_via device used in the q800 machine it would be
just about impossible to map this in a way that would work for all cases. Similarly
for the Mac PPC machines migration is already hit/miss due to timebase issues so
I don't see this as being a big loss.

To finish off I'd also like to say a big thank-you to both Laurent Vivier and
Finn Thain who both took time to answer my questions, dump information from a
real q800, and analyse it in very fine detail. Without them this patchset would
still be several months away.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


Mark Cave-Ayland (22):
  adb: coding style update to fix checkpatch errors
  adb: fix adb-mouse read length and revert disable-reg3-direct-writes
    workaround
  cuda: convert ADB autopoll timer from ns to ms
  pmu: fix duplicate autopoll mask variable
  pmu: honour autopoll_rate_ms when rearming the ADB autopoll timer
  adb: introduce realize/unrealize and VMStateDescription for ADB bus
  adb: create autopoll variables directly within ADBBusState
  cuda: convert to use ADBBusState internal autopoll variables
  pmu: convert to use ADBBusState internal autopoll variables
  mac_via: convert to use ADBBusState internal autopoll variables
  adb: introduce new ADBDeviceHasData method to ADBDeviceClass
  adb: keep track of devices with pending data
  adb: add status field for holding information about the last ADB
    request
  adb: use adb_request() only for explicit requests
  adb: add autopoll_blocked variable to block autopoll
  cuda: add adb_autopoll_block() and adb_autopoll_unblock() functions
  pmu: add adb_autopoll_block() and adb_autopoll_unblock() functions
  mac_via: move VIA1 portB write logic into mos6522_q800_via1_write()
  mac_via: rework ADB state machine to be compatible with both MacOS and
    Linux
  adb: only call autopoll callbacks when autopoll is not blocked
  adb: use adb_device prefix for ADB device trace events
  adb: add ADB bus trace events

 hw/input/adb-kbd.c           |  42 ++--
 hw/input/adb-mouse.c         |  65 +++---
 hw/input/adb.c               | 212 +++++++++++++++++--
 hw/input/trace-events        |  27 ++-
 hw/misc/mac_via.c            | 399 ++++++++++++++++++++++-------------
 hw/misc/macio/cuda.c         |  60 +++---
 hw/misc/macio/pmu.c          |  47 ++---
 hw/misc/trace-events         |   3 +
 hw/ppc/mac_newworld.c        |   2 -
 include/hw/input/adb.h       |  26 ++-
 include/hw/misc/mac_via.h    |   2 +-
 include/hw/misc/macio/cuda.h |   4 -
 include/hw/misc/macio/pmu.h  |   4 -
 13 files changed, 608 insertions(+), 285 deletions(-)

-- 
2.20.1


