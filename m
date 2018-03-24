Received: from eggs.gnu.org ([208.118.235.92]:42488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1ezont-0007hz-3W
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 15:27:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1ezomp-0005im-3W
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 15:26:13 -0400
Received: from mail-pg0-x229.google.com ([2607:f8b0:400e:c05::229]:47006)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mdavidsaver@gmail.com>)
	id 1ezomo-0005iU-Tg
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 15:25:07 -0400
Received: by mail-pg0-x229.google.com with SMTP id t12so4022640pgp.13
	for <qemu-devel@nongnu.org>; Sat, 24 Mar 2018 12:25:06 -0700 (PDT)
From: Michael Davidsaver <mdavidsaver@gmail.com>
Date: Sat, 24 Mar 2018 12:24:41 -0700
Message-Id: <20180324192455.12254-1-mdavidsaver@gmail.com>
Subject: [Qemu-devel] [PATCH 00/14] Generalize Dallas/Maxim I2C RTC devices
 v2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: Antoine Mathys <barsamin@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, Michael Davidsaver <mdavidsaver@gmail.com>

This series generalizes the ds1338 model to also support the ds1375.
As previously, only the time of day registers are modeled.  This
series is largely a do-over wrt. my previous series.  This time I
started with incremental changes from the existing ds1338 model, and only
add support for the ds1375 (which I care about).

I've added a more thorough test of the time of day function, covering
reading and setting in both 12 and 24 hour mode.  This corrects two
(practically inconsequential) bugs with the handling of 12 hour mode,
and day of the week.

In an attempt to address concerns about false positive test failures
in CI builds, instead of comparing the parts of 'struct tm' seperately
I've changed the logic of the tests to compare the difference between
the expected and actual time in seconds.  The threshold is 30 seconds
when run with 'gtester -m quick', and 1 second otherwise.

Comparision of day of the week is still exact, so there is a chance of
a false positive if the test is running across midnight UTC.

Michael Davidsaver (14):
  tests: more thorough tests of ds1338
  timer: ds1338 use registerfields.h
  timer: ds1338 persist 12-hour mode selection
  timer: ds1338 clarify HOUR handling
  timer: ds1338 change write handling
  tests: ds-rtc test 12 hour mode
  timer: ds1338 fix wday_offset handling
  tests: ds-rtc test wday offset
  timer: rename ds1338 -> dsrtc
  timer: rename file ds1338.c -> ds-rtc.c
  timer: generalize ds1338
  timer: ds-rtc handle CENTURY bit
  timer: ds-rtc model ds1375
  tests: drop ds1338-test

 default-configs/arm-softmmu.mak |   2 +-
 hw/timer/Makefile.objs          |   2 +-
 hw/timer/ds-rtc.c               | 331 ++++++++++++++++++++++++++++++++++++++++
 hw/timer/ds1338.c               | 239 -----------------------------
 tests/Makefile.include          |   6 +-
 tests/ds-rtc-common.h           |  71 +++++++++
 tests/ds-rtc-current-test.c     |  66 ++++++++
 tests/ds-rtc-set-test.c         | 171 +++++++++++++++++++++
 tests/ds1338-test.c             |  75 ---------
 9 files changed, 645 insertions(+), 318 deletions(-)
 create mode 100644 hw/timer/ds-rtc.c
 delete mode 100644 hw/timer/ds1338.c
 create mode 100644 tests/ds-rtc-common.h
 create mode 100644 tests/ds-rtc-current-test.c
 create mode 100644 tests/ds-rtc-set-test.c
 delete mode 100644 tests/ds1338-test.c

-- 
2.11.0
