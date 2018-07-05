Received: from eggs.gnu.org ([2001:4830:134:3::10]:57935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1fb8rc-0004Jw-Sp
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 14:20:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1fb8rX-00068A-UN
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 14:20:20 -0400
Received: from mail-pl0-x233.google.com ([2607:f8b0:400e:c01::233]:44687)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mdavidsaver@gmail.com>)
	id 1fb8rX-00067u-Nv
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 14:20:15 -0400
Received: by mail-pl0-x233.google.com with SMTP id m16-v6so1627220pls.11
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 11:20:15 -0700 (PDT)
From: Michael Davidsaver <mdavidsaver@gmail.com>
Date: Thu,  5 Jul 2018 11:19:47 -0700
Message-Id: <20180705182001.16537-1-mdavidsaver@gmail.com>
Subject: [Qemu-devel] [PATCH 00/14] Generalize Dallas/Maxim I2C RTC devices
 v3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Antoine Mathys <barsamin@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, Michael Davidsaver <mdavidsaver@gmail.com>

This series generalizes the ds1338 model to also support the ds1375.
As previously, only the time of day registers are modeled.  This
series (v3) is a minor iteration on the previous v2.

No changes were made to the unittests.

Summary of changes by patch name in response to comments by Peter Maydell.

= timer: ds1338 use registerfields.h

Changed as requested to be more direct translation.

= timer: ds1338 persist 12-hour mode selection

On 04/12/2018 11:03 AM, Peter Maydell wrote:
> The code change here looks like a reasonable no-behaviour-change
> simplification of the code, but it doesn't match up with
> the description in the commit message ?

While it isn't clear from the diff, the condtional
involved has 3 arms, only two of these were updating
's->nvram[]'.  The arm handling control register
writes is the one which didn't.  So attempts to set
the 12 hour mode bit were ignored, and subsequent
reads always returned 24 hour time.

So this is a behaviour change, and a minor bug fix.

= timer: ds1338 clarify HOUR handling
= timer: ds1338 fix wday_offset handling

These two are combined as requested.

= timer: generalize ds1338

The change to CTRL register handling is split out
as a seperate patch "timer: ds1338 remove vestige of un-modeled OSF"

= timer: ds-rtc handle CENTURY bit

Changed as suggested.



Michael Davidsaver (14):
  tests: more thorough tests of ds1338
  timer: ds1338 use registerfields.h
  timer: ds1338 persist 12-hour mode selection
  timer: ds1338 clarify HOUR handling
  timer: ds1338 change write handling and fix wday_offset handling
  tests: ds-rtc test 12 hour mode
  tests: ds-rtc test wday offset
  timer: rename ds1338 -> dsrtc
  timer: rename file ds1338.c -> ds-rtc.c
  timer: ds1338 remove vestige of un-modeled OSF
  timer: generalize ds1338
  timer: ds-rtc handle CENTURY bit
  timer: ds-rtc model ds1375
  tests: drop ds1338-test

 default-configs/arm-softmmu.mak |   2 +-
 hw/timer/Makefile.objs          |   2 +-
 hw/timer/ds-rtc.c               | 335 ++++++++++++++++++++++++++++++++++++++++
 hw/timer/ds1338.c               | 239 ----------------------------
 tests/Makefile.include          |   6 +-
 tests/ds-rtc-common.h           |  71 +++++++++
 tests/ds-rtc-current-test.c     |  66 ++++++++
 tests/ds-rtc-set-test.c         | 171 ++++++++++++++++++++
 tests/ds1338-test.c             |  75 ---------
 9 files changed, 649 insertions(+), 318 deletions(-)
 create mode 100644 hw/timer/ds-rtc.c
 delete mode 100644 hw/timer/ds1338.c
 create mode 100644 tests/ds-rtc-common.h
 create mode 100644 tests/ds-rtc-current-test.c
 create mode 100644 tests/ds-rtc-set-test.c
 delete mode 100644 tests/ds1338-test.c

-- 
2.11.0
