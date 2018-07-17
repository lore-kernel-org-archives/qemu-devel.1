Received: from eggs.gnu.org ([2001:4830:134:3::10]:55910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffRuZ-0004YU-22
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:29:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffRuX-0005xB-N8
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:29:11 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:41599)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ffRuX-0005wt-FK
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:29:09 -0400
Received: by mail-oi0-x244.google.com with SMTP id k12-v6so2787247oiw.8
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 08:29:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180705182001.16537-2-mdavidsaver@gmail.com>
References: <20180705182001.16537-1-mdavidsaver@gmail.com>
	<20180705182001.16537-2-mdavidsaver@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Jul 2018 16:28:48 +0100
Message-ID: <CAFEAcA_8bKuuriPGy0PazhgAPWFYetexD3G0mDn_koe77OH9wA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 01/14] tests: more thorough tests of ds1338
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Davidsaver <mdavidsaver@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Antoine Mathys <barsamin@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, QEMU Developers <qemu-devel@nongnu.org>

On 5 July 2018 at 19:19, Michael Davidsaver <mdavidsaver@gmail.com> wrote:
> Test current time and set+get round trip.
>
> Separate current time test from set/get tests
> to avoid test needing to impose order, or to
> have a magic handshaketo reset RTC to current time.
>
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
> ---
>  tests/Makefile.include      |   4 ++
>  tests/ds-rtc-common.h       |  67 +++++++++++++++++++++++++
>  tests/ds-rtc-current-test.c |  59 ++++++++++++++++++++++
>  tests/ds-rtc-set-test.c     | 117 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 247 insertions(+)
>  create mode 100644 tests/ds-rtc-common.h
>  create mode 100644 tests/ds-rtc-current-test.c
>  create mode 100644 tests/ds-rtc-set-test.c
>
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 8859e88ffb..6ce5a9ff4d 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -378,6 +378,8 @@ check-qtest-sparc64-y += tests/boot-serial-test$(EXESUF)
>  check-qtest-arm-y = tests/tmp105-test$(EXESUF)
>  check-qtest-arm-y += tests/pca9552-test$(EXESUF)
>  check-qtest-arm-y += tests/ds1338-test$(EXESUF)
> +check-qtest-arm-y += tests/ds-rtc-current-test$(EXESUF)
> +check-qtest-arm-y += tests/ds-rtc-set-test$(EXESUF)
>  check-qtest-arm-y += tests/m25p80-test$(EXESUF)
>  gcov-files-arm-y += hw/misc/tmp105.c
>  check-qtest-arm-y += tests/virtio-blk-test$(EXESUF)
> @@ -787,6 +789,8 @@ tests/pxe-test$(EXESUF): tests/pxe-test.o tests/boot-sector.o $(libqos-obj-y)
>  tests/tmp105-test$(EXESUF): tests/tmp105-test.o $(libqos-omap-obj-y)
>  tests/pca9552-test$(EXESUF): tests/pca9552-test.o $(libqos-omap-obj-y)
>  tests/ds1338-test$(EXESUF): tests/ds1338-test.o $(libqos-imx-obj-y)
> +tests/ds-rtc-current-test$(EXESUF): tests/ds-rtc-current-test.o $(libqos-imx-obj-y)
> +tests/ds-rtc-set-test$(EXESUF): tests/ds-rtc-set-test.o $(libqos-imx-obj-y)
>  tests/m25p80-test$(EXESUF): tests/m25p80-test.o
>  tests/i440fx-test$(EXESUF): tests/i440fx-test.o $(libqos-pc-obj-y)
>  tests/q35-test$(EXESUF): tests/q35-test.o $(libqos-pc-obj-y)
> diff --git a/tests/ds-rtc-common.h b/tests/ds-rtc-common.h
> new file mode 100644
> index 0000000000..c8e6c2bc5b
> --- /dev/null
> +++ b/tests/ds-rtc-common.h
> @@ -0,0 +1,67 @@
> +/* Common code for testing of Dallas/Maxim I2C bus RTC devices
> + *
> + * Copyright (c) 2018 Michael Davidsaver
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  See
> + * the LICENSE file in the top-level directory.
> + */
> +#ifndef DSRTCCOMMON_H
> +#define DSRTCCOMMON_H
> +
> +#include "qemu/osdep.h"

Headers should never include osdep.h.


> +#include "qemu/cutils.h"
> +#include "libqos/i2c.h"
> +
> +#define IMX25_I2C_0_BASE 0x43F80000
> +#define DS1338_ADDR 0x68
> +
> +static I2CAdapter *i2c;
> +static uint8_t addr;
> +static bool use_century;
> +
> +/* input buffer must have at least 7 elements */
> +static inline time_t rtc_parse(const uint8_t *buf)
> +{
> +    struct tm parts;
> +
> +    parts.tm_sec = from_bcd(buf[0]);
> +    parts.tm_min = from_bcd(buf[1]);
> +    if (buf[2] & 0x40) {
> +        /* 12 hour */
> +        /* HOUR register is 1-12. */
> +        parts.tm_hour = from_bcd(buf[2] & 0x1f);
> +        g_assert_cmpuint(parts.tm_hour, >=, 1);
> +        g_assert_cmpuint(parts.tm_hour, <=, 12);
> +        parts.tm_hour %= 12u; /* wrap 12 -> 0 */
> +        if (buf[2] & 0x20) {
> +            parts.tm_hour += 12u;
> +        }
> +    } else {
> +        /* 24 hour */
> +        parts.tm_hour = from_bcd(buf[2] & 0x3f);
> +    }
> +    parts.tm_wday = from_bcd(buf[3]);
> +    parts.tm_mday = from_bcd(buf[4]);
> +    parts.tm_mon =  from_bcd((buf[5] & 0x1f) - 1u);
> +    parts.tm_year = from_bcd(buf[6]);
> +    if (!use_century || (buf[5] & 0x80)) {
> +        parts.tm_year += 100u;
> +    }
> +
> +    return mktimegm(&parts);
> +}
> +
> +static time_t rtc_gettime(void)
> +{
> +    uint8_t buf[7];
> +
> +    /* zero address pointer */
> +    buf[0] = 0;
> +    i2c_send(i2c, addr, buf, 1);
> +    /* read back current time registers */
> +    i2c_recv(i2c, addr, buf, 7);
> +
> +    return rtc_parse(buf);
> +}
> +
> +#endif /* DSRTCCOMMON_H */
> diff --git a/tests/ds-rtc-current-test.c b/tests/ds-rtc-current-test.c
> new file mode 100644
> index 0000000000..6acbbed9a6
> --- /dev/null
> +++ b/tests/ds-rtc-current-test.c
> @@ -0,0 +1,59 @@
> +/* Testing of Dallas/Maxim I2C bus RTC devices
> + *
> + * Copyright (c) 2018 Michael Davidsaver
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  See
> + * the LICENSE file in the top-level directory.
> + */
> +#include <stdio.h>

This is included for you by osdep.h.

> +
> +#include "qemu/osdep.h"
> +#include "qemu/bcd.h"
> +#include "qemu/cutils.h"
> +#include "libqtest.h"
> +#include "libqos/libqos.h"
> +#include "libqos/i2c.h"
> +
> +#include "ds-rtc-common.h"
> +
> +/* read back and compare with current system time */
> +static
> +void test_rtc_current(void)
> +{
> +    time_t expected, actual;
> +    /* relax test to limit false positives when host may be overloaded.
> +     * Allow larger delta when running "-m quick"
> +     */
> +    time_t max_delta = g_test_slow() ? 1 : 30;
> +
> +    actual = time(NULL);
> +    /* new second may start here */
> +    expected = rtc_gettime();
> +    g_assert_cmpuint(expected, <=, actual + max_delta);
> +    g_assert_cmpuint(expected, >=, actual);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +    int ret;
> +    const char *arch = qtest_get_arch();
> +    QTestState *s = NULL;
> +
> +    g_test_init(&argc, &argv, NULL);
> +
> +    if (strcmp(arch, "arm") == 0) {

The makefile changes add this to check-qtest-arm-y,
so why do we need this if() ?

> +        s = qtest_start("-machine imx25-pdk");
> +        i2c = imx_i2c_create(s, IMX25_I2C_0_BASE);
> +        addr = DS1338_ADDR;
> +        use_century = false;
> +
> +    }
> +
> +    qtest_add_func("/ds-rtc-i2c/current", test_rtc_current);
> +
> +    ret = g_test_run();
> +
> +    qtest_end();
> +
> +    return ret;
> +}
> diff --git a/tests/ds-rtc-set-test.c b/tests/ds-rtc-set-test.c
> new file mode 100644
> index 0000000000..35e1a36281

Same comments as above apply to this file too.

thanks
-- PMM
