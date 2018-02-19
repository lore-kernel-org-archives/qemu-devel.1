Received: from eggs.gnu.org ([2001:4830:134:3::10]:49331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eng3F-0004i4-6S
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 02:39:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eng3C-0002l2-0P
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 02:39:53 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41478 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eng3B-0002jK-R5
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 02:39:49 -0500
References: <20180219040342.12686-1-mdavidsaver@gmail.com>
	<20180219040342.12686-3-mdavidsaver@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <bd080194-a170-52a0-59fd-31678e838d34@redhat.com>
Date: Mon, 19 Feb 2018 08:39:33 +0100
MIME-Version: 1.0
In-Reply-To: <20180219040342.12686-3-mdavidsaver@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/5] tests: more thorough test of ds1338
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Davidsaver <mdavidsaver@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Antoine Mathys <barsamin@gmail.com>
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 19.02.2018 05:03, Michael Davidsaver wrote:
> Test current time and set+get round trip.
>=20
> The set+get test is repeated 4 times.  These cases are
> spread across a single day in an attempt to trigger some potential
> issues regardless of the timezone of the machine running the tests.
>=20
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
> ---
>  tests/Makefile.include  |   2 +
>  tests/ds-rtc-i2c-test.c | 193 ++++++++++++++++++++++++++++++++++++++++=
++++++++
>  2 files changed, 195 insertions(+)
>  create mode 100644 tests/ds-rtc-i2c-test.c
[...]
>  tests/q35-test$(EXESUF): tests/q35-test.o $(libqos-pc-obj-y)
> diff --git a/tests/ds-rtc-i2c-test.c b/tests/ds-rtc-i2c-test.c
> new file mode 100644
> index 0000000000..464eb08558
> --- /dev/null
> +++ b/tests/ds-rtc-i2c-test.c
> @@ -0,0 +1,193 @@
> +/* Testing of Dallas/Maxim I2C bus RTC devices
> + *
> + * Copyright (c) 2017 Michael Davidsaver
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  S=
ee
> + * the LICENSE file in the top-level directory.
> + */
> +#include <stdio.h>
> +
> +#include "qemu/osdep.h"
> +#include "qemu/bcd.h"
> +#include "qemu/cutils.h"
> +#include "qemu/timer.h"
> +#include "libqtest.h"
> +#include "libqos/libqos.h"
> +#include "libqos/i2c.h"
> +
> +#define IMX25_I2C_0_BASE 0x43F80000
> +#define DS1338_ADDR 0x68
> +
> +static I2CAdapter *i2c;
> +static uint8_t addr;
> +static bool use_century;
> +
> +static
> +time_t rtc_gettime(void)
> +{
> +    struct tm parts;
> +    uint8_t buf[7];
> +
> +    buf[0] =3D 0;
> +    i2c_send(i2c, addr, buf, 1);
> +    i2c_recv(i2c, addr, buf, 7);
> +
> +    parts.tm_sec =3D from_bcd(buf[0]);
> +    parts.tm_min =3D from_bcd(buf[1]);
> +    if (buf[2] & 0x40) {
> +        /* 12 hour */
> +        /* HOUR register is 1-12. */
> +        parts.tm_hour =3D from_bcd(buf[2] & 0x1f);
> +        g_assert_cmpuint(parts.tm_hour, >=3D, 1);
> +        g_assert_cmpuint(parts.tm_hour, <=3D, 12);
> +        parts.tm_hour %=3D 12u; /* wrap 12 -> 0 */
> +        if (buf[2] & 0x20) {
> +            parts.tm_hour +=3D 12u;
> +        }
> +    } else {
> +        /* 24 hour */
> +        parts.tm_hour =3D from_bcd(buf[2] & 0x3f);
> +    }
> +    parts.tm_wday =3D from_bcd(buf[3]);
> +    parts.tm_mday =3D from_bcd(buf[4]);
> +    parts.tm_mon =3D  from_bcd((buf[5] & 0x1f) - 1u);
> +    parts.tm_year =3D from_bcd(buf[6]);
> +    if (!use_century || (buf[5] & 0x80)) {
> +        parts.tm_year +=3D 100u;
> +    }
> +
> +    return mktimegm(&parts);
> +}
> +
> +/* read back and compare with current system time */
> +static
> +void test_rtc_current(void)
> +{
> +    uint8_t buf;
> +    time_t expected, actual;
> +
> +    /* magic address to zero RTC time offset
> +     * as tests may be run in any order
> +     */
> +    buf =3D 0xff;
> +    i2c_send(i2c, addr, &buf, 1);

That magic (together with patch 1/5) is IMHO a little bit ugly. I've hit
the same problem with the m48t59 test recently, and I solved it by
moving the qtest_start() and qtest_end() calls from the main() function
into the single tests instead, so that each test starts with a clean stat=
e:

https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D9c29830c90d82f27f

Could you maybe try whether that approach works for your test cases
here, too? Then you could do this without the "0xff" hack here...

> +
> +    actual =3D time(NULL);
> +    /* new second may start here */
> +    expected =3D rtc_gettime();
> +    g_assert_cmpuint(expected, <=3D, actual + 1);
> +    g_assert_cmpuint(expected, >=3D, actual);
> +}
> +
> +
> +static uint8_t test_time_24_12am[8] =3D {
> +    0, /* address */
> +    /* Wed, 22 Nov 2017 00:30:53 +0000 */
> +    0x53,
> +    0x30,
> +    0x00, /* 12 AM in 24 hour mode */
> +    0x03, /* monday is our day 1 */
> +    0x22,
> +    0x11 | 0x80,
> +    0x17,
> +};
> +
> +static uint8_t test_time_24_6am[8] =3D {
> +    0, /* address */
> +    /* Wed, 22 Nov 2017 06:30:53 +0000 */
> +    0x53,
> +    0x30,
> +    0x06, /* 6 AM in 24 hour mode */
> +    0x03, /* monday is our day 1 */
> +    0x22,
> +    0x11 | 0x80,
> +    0x17,
> +};
> +
> +static uint8_t test_time_24_12pm[8] =3D {
> +    0, /* address */
> +    /* Wed, 22 Nov 2017 12:30:53 +0000 */
> +    0x53,
> +    0x30,
> +    0x12, /* 12 PM in 24 hour mode */
> +    0x03, /* monday is our day 1 */
> +    0x22,
> +    0x11 | 0x80,
> +    0x17,
> +};
> +
> +static uint8_t test_time_24_6pm[8] =3D {
> +    0, /* address */
> +    /* Wed, 22 Nov 2017 18:30:53 +0000 */
> +    0x53,
> +    0x30,
> +    0x18, /* 6 PM in 24 hour mode */
> +    0x03, /* monday is our day 1 */
> +    0x22,
> +    0x11 | 0x80,
> +    0x17,
> +};
> +
> +/* write in and read back known time */
> +static
> +void test_rtc_set(const void *raw)
> +{
> +    const uint8_t *testtime =3D raw;
> +    uint8_t buf[7];
> +    unsigned retry =3D 2;
> +
> +    for (; retry; retry--) {
> +        i2c_send(i2c, addr, testtime, 8);
> +        /* new second may start here */
> +        i2c_send(i2c, addr, testtime, 1);
> +        i2c_recv(i2c, addr, buf, 7);
> +
> +        if (testtime[1] =3D=3D buf[0]) {

Please also check the minutes here (reason: see below).

> +            break;
> +        }
> +        /* we raced start of second, retry */
> +    };
> +
> +    g_assert_cmpuint(testtime[1], =3D=3D, buf[0]); /* SEC */
> +    g_assert_cmpuint(testtime[2], =3D=3D, buf[1]); /* MIN */

Could you please wrap the SEC and MIN lines in a "if (!g_test_slow()) {
... }" statement? The problem is: The "make check" tests are run as CI
on a system that is sometimes *very* overloaded. It might happen that
the test is sometimes interrupted for dozens of seconds, so it might
fail to properly read the time on a granularity of seconds. With
!g_test_slow() you can make sure that the check is not done on such
overloaded CI systems.

> +    g_assert_cmpuint(testtime[3], =3D=3D, buf[2]); /* HOUR */
> +    /* skip comparing Day of Week.  Not handled correctly */
> +    g_assert_cmpuint(testtime[5], =3D=3D, buf[4]); /* DoM */
> +    if (use_century) {
> +        g_assert_cmpuint(testtime[6], =3D=3D, buf[5]); /* MON+century =
*/
> +    } else {
> +        g_assert_cmpuint(testtime[6] & 0x7f, =3D=3D, buf[5]); /* MON *=
/
> +    }
> +    g_assert_cmpuint(testtime[7], =3D=3D, buf[6]); /* YEAR */
> +
> +    g_assert_cmpuint(retry, >, 0);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +    int ret;
> +    const char *arch =3D qtest_get_arch();
> +    QTestState *s =3D NULL;
> +
> +    g_test_init(&argc, &argv, NULL);
> +
> +    if (strcmp(arch, "arm") =3D=3D 0) {
> +        s =3D qtest_start("-display none -machine imx25-pdk");

Do you really need the "-display none" parameter here? ... I thought
that was the default for qtests anyway?

> +        i2c =3D imx_i2c_create(s, IMX25_I2C_0_BASE);
> +        addr =3D DS1338_ADDR;
> +        use_century =3D false;
> +
> +    }
> +
> +    qtest_add_data_func("/ds-rtc-i2c/set24_12am", test_time_24_12am, t=
est_rtc_set);
> +    qtest_add_data_func("/ds-rtc-i2c/set24_6am", test_time_24_6am, tes=
t_rtc_set);
> +    qtest_add_data_func("/ds-rtc-i2c/set24_12pm", test_time_24_12pm, t=
est_rtc_set);
> +    qtest_add_data_func("/ds-rtc-i2c/set24_6pm", test_time_24_6pm, tes=
t_rtc_set);
> +    qtest_add_func("/ds-rtc-i2c/current", test_rtc_current);
> +
> +    ret =3D g_test_run();
> +
> +    qtest_end();
> +
> +    return ret;
> +}
>=20

 Thomas
