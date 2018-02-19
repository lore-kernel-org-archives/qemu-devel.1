Received: from eggs.gnu.org ([2001:4830:134:3::10]:49468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1encgQ-0007Wj-7H
	for qemu-devel@nongnu.org; Sun, 18 Feb 2018 23:04:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1encgN-0000Qi-58
	for qemu-devel@nongnu.org; Sun, 18 Feb 2018 23:04:06 -0500
Received: from mail-io0-x236.google.com ([2607:f8b0:4001:c06::236]:35064)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mdavidsaver@gmail.com>)
	id 1encgM-0000QJ-Uj
	for qemu-devel@nongnu.org; Sun, 18 Feb 2018 23:04:03 -0500
Received: by mail-io0-x236.google.com with SMTP id 30so4703629iog.2
	for <qemu-devel@nongnu.org>; Sun, 18 Feb 2018 20:04:02 -0800 (PST)
From: Michael Davidsaver <mdavidsaver@gmail.com>
Date: Sun, 18 Feb 2018 20:03:37 -0800
Message-Id: <20180219040342.12686-1-mdavidsaver@gmail.com>
Subject: [Qemu-devel] [PATCH 0/5] Generalize Dallas/Maxim I2C RTC devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Brook <paul@codesourcery.com>, Peter Maydell <peter.maydell@linaro.org>, Antoine Mathys <barsamin@gmail.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, Michael Davidsaver <mdavidsaver@gmail.com>

These changes previously appeared as part of a series "Add MVME3100 PPC SBC v2"
back in November.  David Gibson, who looked that that series, suggested getting
this reviewed separately.  There doesn't appear to be a listed maintainer
for this code, so I'm addressing this to the 3 people who have made more than
cosmetic changes to it.  The most recent of these was in 2012.

This series replaces the ds1338 RTC with a model covering a number of these
similar chips: ds1307, ds1337, ds1338, ds1339, ds1340, ds1375, ds1388,
and ds3231.

The limits of the new model are the same as the old.  Only the time of day
registers, and NVRAM are modeled.  The alarm and control registers are not.

I've added a more thorough test of the time of day function, covering
reading and setting in both 12 and 24 hour mode.  In the process
I found two minor issues with the ds1338 model.  These are described in the
commit message for #3.  So this series first adds those tests which pass with
both old and new model.  Then later adds some additional tests which only
pass with the new model.


Michael Davidsaver (5):
  timer: ds1338 add magic reset for test code
  tests: more thorough test of ds1338
  timer: generalize Dallas/Maxim RTC i2c devices
  tests: ds-rtc-i2c-test test 12 hour mode and DoW
  tests: drop ds1338-test

 default-configs/arm-softmmu.mak |   2 +-
 hw/timer/Makefile.objs          |   2 +-
 hw/timer/ds-rtc-i2c.c           | 466 ++++++++++++++++++++++++++++++++++++++++
 hw/timer/ds1338.c               | 239 ---------------------
 tests/Makefile.include          |   4 +-
 tests/ds-rtc-i2c-test.c         | 245 +++++++++++++++++++++
 tests/ds1338-test.c             |  75 -------
 7 files changed, 715 insertions(+), 318 deletions(-)
 create mode 100644 hw/timer/ds-rtc-i2c.c
 delete mode 100644 hw/timer/ds1338.c
 create mode 100644 tests/ds-rtc-i2c-test.c
 delete mode 100644 tests/ds1338-test.c

-- 
2.11.0
