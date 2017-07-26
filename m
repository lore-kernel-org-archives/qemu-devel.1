Received: from eggs.gnu.org ([2001:4830:134:3::10]:53661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daB88-0000Ic-Pv
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 21:28:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daB85-0001ix-Ls
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 21:28:52 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34960)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daB85-0001iR-Fa
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 21:28:49 -0400
Received: by mail-qk0-x243.google.com with SMTP id k2so6794711qkf.2
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 18:28:49 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1500990514-30326-1-git-send-email-pbonzini@redhat.com>
	<1500990514-30326-3-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d82f2f89-2d40-9bf3-9b89-50ed734fb5e6@amsat.org>
Date: Tue, 25 Jul 2017 22:28:28 -0300
MIME-Version: 1.0
In-Reply-To: <1500990514-30326-3-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/4] rtc-test: introduce more update tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peng.hao2@zte.com.cn, liu.yi24@zte.com.cn

On 07/25/2017 10:48 AM, Paolo Bonzini wrote:
> Test divider reset and UIP behavior.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   tests/rtc-test.c | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 81 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/rtc-test.c b/tests/rtc-test.c
> index 798cf5e..d7a96cb 100644
> --- a/tests/rtc-test.c
> +++ b/tests/rtc-test.c
> @@ -325,6 +325,30 @@ static void set_datetime_bcd(int h, int min, int s, int d, int m, int y)
>       cmos_write(RTC_DAY_OF_MONTH, d);
>   }
>   

I'm not sure why this function is in tests/ ...

> +static void set_datetime_dec(int h, int min, int s, int d, int m, int y)
> +{

Following is set_time_regs()

> +    cmos_write(RTC_HOURS, h);
> +    cmos_write(RTC_MINUTES, min);
> +    cmos_write(RTC_SECONDS, s);

Maybe we can use here:

if (mode & REG_B_DM /* dec */) {

> +    cmos_write(RTC_YEAR, y % 100);
> +    cmos_write(RTC_CENTURY, y / 100);

} else /* bcd */ {
...
}

instead of having 2 set_datetime()

> +    cmos_write(RTC_MONTH, m);
> +    cmos_write(RTC_DAY_OF_MONTH, d);
> +}
> +
> +static void set_datetime(int mode, int h, int min, int s, int d, int m, int y)
> +{
> +    cmos_write(RTC_REG_B, mode);
> +
> +    cmos_write(RTC_REG_A, 0x76);
> +    if (mode & REG_B_DM) {
> +        set_datetime_dec(h, min, s, d, m, y);
> +    } else {
> +        set_datetime_bcd(h, min, s, d, m, y);
> +    }
> +    cmos_write(RTC_REG_A, 0x26);
> +}
> +
>   #define assert_time(h, m, s) \
>       do { \
>           g_assert_cmpint(cmos_read(RTC_HOURS), ==, h); \
> @@ -559,6 +583,60 @@ static void register_b_set_flag(void)
>       assert_datetime_bcd(0x02, 0x04, 0x59, 0x02, 0x02, 0x2011);
>   }
>   
> +static void divider_reset(void)
> +{
> +    /* Enable binary-coded decimal (BCD) mode in Register B*/
> +    cmos_write(RTC_REG_B, REG_B_24H);
> +
> +    /* Enter divider reset */
> +    cmos_write(RTC_REG_A, 0x76);
> +    set_datetime_bcd(0x02, 0x04, 0x58, 0x02, 0x02, 0x2011);
> +
> +    assert_datetime_bcd(0x02, 0x04, 0x58, 0x02, 0x02, 0x2011);
> +
> +    /* Since divider reset flag is still enabled, these are equality checks. */
> +    clock_step(1000000000LL);
> +    assert_datetime_bcd(0x02, 0x04, 0x58, 0x02, 0x02, 0x2011);
> +
> +    /* The first update ends 500 ms after divider reset */
> +    cmos_write(RTC_REG_A, 0x26);
> +    clock_step(500000000LL - UIP_HOLD_LENGTH - 1);
> +    g_assert_cmpint(cmos_read(RTC_REG_A) & REG_A_UIP, ==, 0);
> +    assert_datetime_bcd(0x02, 0x04, 0x58, 0x02, 0x02, 0x2011);
> +
> +    clock_step(1);
> +    g_assert_cmpint(cmos_read(RTC_REG_A) & REG_A_UIP, !=, 0);
> +    clock_step(UIP_HOLD_LENGTH);
> +    g_assert_cmpint(cmos_read(RTC_REG_A) & REG_A_UIP, ==, 0);
> +
> +    assert_datetime_bcd(0x02, 0x04, 0x59, 0x02, 0x02, 0x2011);
> +}
> +
> +static void uip_stuck(void)
> +{
> +    set_datetime(REG_B_24H, 0x02, 0x04, 0x58, 0x02, 0x02, 0x2011);
> +
> +    /* The first update ends 500 ms after divider reset */
> +    (void)cmos_read(RTC_REG_C);
> +    clock_step(500000000LL);
> +    g_assert_cmpint(cmos_read(RTC_REG_A) & REG_A_UIP, ==, 0);
> +    assert_datetime_bcd(0x02, 0x04, 0x59, 0x02, 0x02, 0x2011);
> +
> +    /* UF is now set.  */
> +    cmos_write(RTC_HOURS_ALARM, 0x02);
> +    cmos_write(RTC_MINUTES_ALARM, 0xC0);
> +    cmos_write(RTC_SECONDS_ALARM, 0xC0);
> +
> +    /* Because the alarm will fire soon, reading register A will latch UIP.  */
> +    clock_step(1000000000LL - UIP_HOLD_LENGTH / 2);
> +    g_assert_cmpint(cmos_read(RTC_REG_A) & REG_A_UIP, !=, 0);
> +
> +    /* Move the alarm far away.  This must not cause UIP to remain stuck!  */
> +    cmos_write(RTC_HOURS_ALARM, 0x03);
> +    clock_step(UIP_HOLD_LENGTH);
> +    g_assert_cmpint(cmos_read(RTC_REG_A) & REG_A_UIP, ==, 0);
> +}
> +
>   #define RTC_PERIOD_CODE1    13   /* 8 Hz */
>   #define RTC_PERIOD_CODE2    15   /* 2 Hz */
>   
> @@ -625,7 +703,9 @@ int main(int argc, char **argv)
>       qtest_add_func("/rtc/basic/bcd-12h", basic_12h_bcd);
>       qtest_add_func("/rtc/set-year/20xx", set_year_20xx);
>       qtest_add_func("/rtc/set-year/1980", set_year_1980);
> -    qtest_add_func("/rtc/misc/register_b_set_flag", register_b_set_flag);
> +    qtest_add_func("/rtc/update/register_b_set_flag", register_b_set_flag);
> +    qtest_add_func("/rtc/update/divider-reset", divider_reset);
> +    qtest_add_func("/rtc/update/uip-stuck", uip_stuck);
>       qtest_add_func("/rtc/misc/fuzz-registers", fuzz_registers);
>       qtest_add_func("/rtc/periodic/interrupt", periodic_timer);
>   
> 
