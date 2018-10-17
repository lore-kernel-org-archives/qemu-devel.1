Received: from eggs.gnu.org ([2001:4830:134:3::10]:41164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gCkrx-0002Dy-Hh
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:24:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gCkrt-0006Jh-9X
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:24:09 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:44172)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <artem.k.pisarenko@gmail.com>)
	id 1gCkrt-0006If-0h
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:24:05 -0400
Received: by mail-lf1-x143.google.com with SMTP id m18-v6so19631357lfl.11
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 05:24:04 -0700 (PDT)
From: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Date: Wed, 17 Oct 2018 18:22:59 +0600
Message-Id: <cover.1539778764.git.artem.k.pisarenko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/4] Fix and improve core RTC function and
 documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Artem Pisarenko <artem.k.pisarenko@gmail.com>

Modifications are motivated by bug https://bugs.launchpad.net/qemu/+bug/1797033 I've encountered recently.

Trying to fix it and analyzing its effect on all use cases (not covered in bug report) revealed much deeper problems.
This is my first patch to QEMU and I'm not sure whether the way I addressed them is proper.
They definitely require either modifications to current implementation (breaking compability), or adding clarifications to user documentation. I've tried to find compromise.
Changes I propose are driven mostly by my interpretation of user documentation and comments in code, rather than by existing implementation.

I've splitted patches in a way that at least some of them may be accepted. Following subsets are make sense on their own:
- 1
- 1,2,3

I limited refactoring only to vl.c, although it leads to reworking of all hw/* rtc models which have unreasonable duplications of actions performed by vl.c.
I'm sure such kind of rework will reveal more hidden bugs/features, but so far I've had enough (it's a long story how muсh effort and pain cost me to find that tricky bug above).
I suppose just to draw attention of relevant hw/* maintainers.


v2 changes:
 - fixed compiler warning caused non-debug build fail


Artem Pisarenko (4):
  vl: improve/fix documentation related to RTC function
  vl: refactor -rtc option references
  Fixes RTC bug with base datetime shifts in clock=vm
  vl,qapi: offset value calculation in RTC_CHANGE event reverted to
    match behavior before #1797033 bugfix and documented

 qapi/misc.json  |   3 +-
 qemu-options.hx |  14 +++++---
 vl.c            | 105 +++++++++++++++++++++++++++++++++++++-------------------
 3 files changed, 80 insertions(+), 42 deletions(-)

-- 
2.7.4
